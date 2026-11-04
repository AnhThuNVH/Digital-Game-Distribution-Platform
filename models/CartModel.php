<?php
// =============================================================================
// CART MODEL - Tables: gio_hang, muc_gio_hang, and the whole sandbox checkout
// (don_hang, chi_tiet_don_hang, thanh_toan, quyen_so_huu_tro_choi,
//  so_ke_toan_tac_gia, luot_dung_ma_giam_gia, thong_ke_tro_choi_hang_ngay).
// gio_hang is unique per user: after checkout the row is marked checked_out and
// re-activated on the next add.
// =============================================================================

class CartModel extends Model {
    protected static $table = 'gio_hang';

    public const PROVIDER = 'sandbox';

    /** Cart id for the user; creates or re-activates the row when $create. */
    public static function cartId(int $userId, bool $create = true): int {
        $row = self::one('SELECT ma, trang_thai FROM gio_hang WHERE nguoi_dung_id = :u', [':u' => $userId]);
        if ($row) {
            if ($row['trang_thai'] !== 'active' && $create) {
                self::run("UPDATE gio_hang SET trang_thai = 'active', ma_tien_te = :c WHERE ma = :id", [':c' => APP_CURRENCY, ':id' => (int)$row['ma']]);
            } elseif ($row['trang_thai'] !== 'active') {
                return 0;
            }
            return (int)$row['ma'];
        }
        if (!$create) {
            return 0;
        }
        return self::insert(['nguoi_dung_id' => $userId, 'trang_thai' => 'active', 'ma_tien_te' => APP_CURRENCY]);
    }

    /** Amount the buyer chose for a pay-what-you-want game. */
    public static function pwywAmount(array $game): float {
        $min = (float)$game['gia_toi_thieu'];
        $chosen = $_SESSION['pwyw'][(int)$game['ma']] ?? null;
        if ($chosen === null) {
            $chosen = $game['gia_de_xuat'] !== null ? (float)$game['gia_de_xuat'] : $min;
        }
        return round(max($min, (float)$chosen), 2);
    }

    /** Author shares for a game: [userId => percent]; the creator gets 100% when no authors exist. */
    public static function authorShares(int $gameId, int $creatorId): array {
        $rows = self::query('SELECT nguoi_dung_id, phan_tram_huong_doanh_thu FROM tac_gia_tro_choi WHERE tro_choi_id = :g ORDER BY thu_tu_hien_thi, ngay_them', [':g' => $gameId]);
        $shares = [];
        foreach ($rows as $row) {
            if ((float)$row['phan_tram_huong_doanh_thu'] > 0) {
                $shares[(int)$row['nguoi_dung_id']] = (float)$row['phan_tram_huong_doanh_thu'];
            }
        }
        return $shares ?: [$creatorId => 100.0];
    }

    /**
     * Cart lines with prices. Each line: item_id, type, id, title, url, cover, cover_alt,
     * list (list price), sale (sale discount), price (after sale), authors, games, problem.
     */
    public static function lines(int $userId): array {
        $cartId = self::cartId($userId, false);
        if (!$cartId) {
            return [];
        }
        $owned = OwnershipModel::ownedIds($userId);
        $lines = [];

        $games = self::query('SELECT i.ma AS item_id, ' . GameModel::cardColumns() . '
            FROM muc_gio_hang i JOIN tro_choi g ON g.ma = i.tro_choi_id
            WHERE i.gio_hang_id = :c AND i.loai_muc = \'game\' ORDER BY i.ngay_them', [':c' => $cartId]);
        foreach ($games as $g) {
            $base = GameModel::basePrice($g);
            $price = $g['mo_hinh_gia'] === 'pay_what_you_want' ? self::pwywAmount($g) : GameModel::effectivePrice($g);
            $list = $g['mo_hinh_gia'] === 'pay_what_you_want' ? $price : $base;
            $problem = null;
            if ($g['trang_thai'] !== 'published') {
                $problem = 'Trò chơi này hiện không còn bán.';
            } elseif (in_array((int)$g['ma'], $owned, true)) {
                $problem = 'Bạn đã sở hữu trò chơi này.';
            } elseif ($price <= 0) {
                $problem = 'Trò chơi miễn phí — hãy nhận trực tiếp trên trang trò chơi.';
            }
            $lines['g' . $g['ma']] = [
                'item_id' => (int)$g['item_id'], 'type' => 'game', 'id' => (int)$g['ma'], 'title' => $g['tieu_de'],
                'url' => game_url($g), 'cover' => $g['anh_bia'], 'cover_alt' => $g['anh_bia_alt'], 'pricing' => $g['mo_hinh_gia'],
                'min' => (float)$g['gia_toi_thieu'], 'list' => $list, 'sale' => round($list - $price, 2), 'price' => $price,
                'sale_percent' => (float)$g['giam_gia'], 'authors' => array_keys(self::authorShares((int)$g['ma'], (int)$g['nguoi_tao_id'])),
                'games' => [['id' => (int)$g['ma'], 'creator' => (int)$g['nguoi_tao_id'], 'base' => $price]],
                'problem' => $problem,
            ];
        }

        $bundles = self::query("SELECT i.ma AS item_id, b.* FROM muc_gio_hang i JOIN goi_game b ON b.ma = i.goi_game_id
            WHERE i.gio_hang_id = :c AND i.loai_muc = 'bundle' ORDER BY i.ngay_them", [':c' => $cartId]);
        foreach ($bundles as $b) {
            $contents = BundleModel::games((int)$b['ma']);
            $authors = [];
            $gamesInfo = [];
            $newGames = 0;
            foreach ($contents as $g) {
                $authors = array_merge($authors, array_keys(self::authorShares((int)$g['ma'], (int)$g['nguoi_tao_id'])));
                $gamesInfo[] = ['id' => (int)$g['ma'], 'creator' => (int)$g['nguoi_tao_id'], 'base' => GameModel::basePrice($g)];
                if (!in_array((int)$g['ma'], $owned, true)) {
                    $newGames++;
                }
            }
            $problem = null;
            if (!BundleModel::isOnSale($b)) {
                $problem = 'Gói game này hiện không còn bán.';
            } elseif (!$contents) {
                $problem = 'Gói game chưa có trò chơi nào.';
            } elseif ($newGames === 0) {
                $problem = 'Bạn đã sở hữu mọi trò chơi trong gói này.';
            }
            $price = round((float)$b['gia'], 2);
            $lines['b' . $b['ma']] = [
                'item_id' => (int)$b['item_id'], 'type' => 'bundle', 'id' => (int)$b['ma'], 'title' => $b['tieu_de'],
                'url' => app_url('/bundles/' . rawurlencode($b['duong_dan_rut_gon'])), 'cover' => $contents[0]['anh_bia'] ?? null,
                'cover_alt' => $contents[0]['anh_bia_alt'] ?? null, 'pricing' => 'bundle', 'min' => $price,
                'list' => $price, 'sale' => 0.0, 'price' => $price, 'sale_percent' => 0,
                'authors' => array_values(array_unique($authors)), 'games' => $gamesInfo, 'new_games' => $newGames,
                'game_count' => count($contents), 'problem' => $problem,
            ];
        }
        return $lines;
    }

    /** Coupon currently applied to the cart (from the session), or null. */
    public static function appliedCoupon(): ?array {
        $code = $_SESSION['cart_coupon'] ?? '';
        if ($code === '') {
            return null;
        }
        $coupon = CouponModel::findByCode($code);
        if (!$coupon || CouponModel::problem($coupon)) {
            unset($_SESSION['cart_coupon']);
            return null;
        }
        return $coupon;
    }

    /** Totals for a set of lines; adds 'coupon' and 'net' per line. */
    public static function totals(array &$lines, ?array $coupon): array {
        $alloc = [];
        if ($coupon) {
            $input = [];
            foreach ($lines as $key => $line) {
                if (!$line['problem']) {
                    $input[$key] = ['net' => $line['price'], 'authors' => $line['authors']];
                }
            }
            $alloc = CouponModel::allocate($coupon, $input);
        }
        $t = ['list' => 0.0, 'sale' => 0.0, 'coupon' => 0.0, 'total' => 0.0, 'count' => 0, 'blocked' => 0];
        foreach ($lines as $key => &$line) {
            $line['coupon'] = $alloc[$key] ?? 0.0;
            $line['net'] = round($line['price'] - $line['coupon'], 2);
            if ($line['problem']) {
                $t['blocked']++;
                continue;
            }
            $t['count']++;
            $t['list'] += $line['list'];
            $t['sale'] += $line['sale'];
            $t['coupon'] += $line['coupon'];
            $t['total'] += $line['net'];
        }
        unset($line);
        foreach (['list', 'sale', 'coupon', 'total'] as $k) {
            $t[$k] = round($t[$k], 2);
        }
        $t['coupon_applies'] = $coupon !== null && $t['coupon'] > 0;
        return $t;
    }

    /** Add a game or bundle. Returns null on success or an error message. */
    public const ALREADY = 'Sản phẩm này đã có trong giỏ hàng.';

    public static function add(int $userId, string $type, int $id): ?string {
        if ($type === 'game') {
            $game = GameModel::findWithCard($id);
            if (!$game || $game['trang_thai'] !== 'published') {
                return 'Không tìm thấy trò chơi đang bán.';
            }
            if (game_is_free($game)) {
                return 'Trò chơi này miễn phí — hãy bấm "Nhận miễn phí".';
            }
            if (OwnershipModel::has($userId, $id)) {
                return 'Bạn đã sở hữu trò chơi này.';
            }
        } elseif ($type === 'bundle') {
            $bundle = BundleModel::find($id);
            if (!$bundle || !BundleModel::isOnSale($bundle)) {
                return 'Gói game này hiện không bán.';
            }
        } else {
            return 'Loại sản phẩm không hợp lệ.';
        }
        $cartId = self::cartId($userId);
        $column = $type === 'game' ? 'tro_choi_id' : 'goi_game_id';
        $added = self::run("INSERT IGNORE INTO muc_gio_hang (gio_hang_id, loai_muc, $column) VALUES (:c, :t, :id)", [':c' => $cartId, ':t' => $type, ':id' => $id]);
        self::run('UPDATE gio_hang SET ngay_cap_nhat = NOW() WHERE ma = :c', [':c' => $cartId]);
        return $added ? null : self::ALREADY;
    }

    public static function remove(int $userId, int $itemId): bool {
        $cartId = self::cartId($userId, false);
        if (!$cartId) {
            return false;
        }
        return self::run('DELETE FROM muc_gio_hang WHERE ma = :i AND gio_hang_id = :c', [':i' => $itemId, ':c' => $cartId]) > 0;
    }

    /**
     * Sandbox checkout in one transaction. Returns the order code.
     * Throws RuntimeException with a user-facing message when the cart can't be paid.
     */
    public static function checkout(int $userId): string {
        return self::transaction(function () use ($userId) {
            $cart = self::one("SELECT ma FROM gio_hang WHERE nguoi_dung_id = :u AND trang_thai = 'active' FOR UPDATE", [':u' => $userId]);
            if (!$cart) {
                throw new RuntimeException('Giỏ hàng đang trống.');
            }
            $lines = self::lines($userId);
            if (!$lines) {
                throw new RuntimeException('Giỏ hàng đang trống.');
            }
            foreach ($lines as $line) {
                if ($line['problem']) {
                    throw new RuntimeException('"' . $line['title'] . '": ' . $line['problem'] . ' Hãy xóa mục này khỏi giỏ trước khi thanh toán.');
                }
            }
            $coupon = null;
            if (!empty($_SESSION['cart_coupon'])) {
                $coupon = self::one('SELECT * FROM ma_giam_gia WHERE ma_uu_dai = :c FOR UPDATE', [':c' => $_SESSION['cart_coupon']]);
                if (!$coupon || ($problem = CouponModel::problem($coupon))) {
                    unset($_SESSION['cart_coupon']);
                    throw new RuntimeException(($problem ?? 'Mã giảm giá không còn hợp lệ.') . ' Mã đã được gỡ khỏi giỏ hàng.');
                }
            }
            $totals = self::totals($lines, $coupon);
            if ($coupon && $totals['coupon'] <= 0) {
                $coupon = null;
            }

            $code = 'TEST-' . strtoupper(bin2hex(random_bytes(6)));
            $orderId = self::db()->prepare("INSERT INTO don_hang (ma_don_hang, nguoi_mua_id, trang_thai, ma_tien_te, tong_tien_hang, tong_tien_giam, tong_tien_thue, tong_thanh_toan, ngay_thanh_toan)
                VALUES (:code, :u, 'paid', :cur, :list, :disc, 0, :total, NOW())")->execute([
                ':code' => $code, ':u' => $userId, ':cur' => APP_CURRENCY, ':list' => $totals['list'],
                ':disc' => round($totals['sale'] + $totals['coupon'], 2), ':total' => $totals['total'],
            ]) ? self::lastId() : 0;

            $sellers = [];
            foreach ($lines as $line) {
                $itemId = self::insertOrderItem($orderId, $line);
                if ($line['type'] === 'game') {
                    OwnershipModel::grant($userId, $line['id'], 'purchase', $itemId);
                    $game = $line['games'][0];
                    $perGame = [$game['id'] => ['creator' => $game['creator'], 'amount' => $line['net']]];
                } else {
                    $perGame = self::splitBundle($line);
                    foreach ($line['games'] as $g) {
                        OwnershipModel::grant($userId, $g['id'], 'bundle', $itemId);
                    }
                }
                $authorGross = [];
                foreach ($perGame as $gameId => $part) {
                    DailyStatsModel::bump($gameId, 'so_luot_mua');
                    DailyStatsModel::bump($gameId, 'doanh_thu_gop', $part['amount']);
                    foreach (self::splitAuthors($gameId, $part['creator'], $part['amount']) as $authorId => $amount) {
                        $authorGross[$authorId] = ['amount' => ($authorGross[$authorId]['amount'] ?? 0) + $amount['amount'], 'percent' => $amount['percent']];
                    }
                }
                RevenueLedgerModel::record($itemId, $authorGross);
                foreach (array_keys($authorGross) as $authorId) {
                    $sellers[$authorId][] = $line['title'];
                }
            }

            if ($totals['total'] > 0) {
                self::run("INSERT INTO thanh_toan (don_hang_id, nha_cung_cap, ma_giao_dich_nha_cung_cap, so_tien, ma_tien_te, trang_thai, ma_phan_hoi_nha_cung_cap, ngay_thanh_toan)
                    VALUES (:o, :p, :tx, :amount, :cur, 'succeeded', 'sandbox_approved', NOW())", [
                    ':o' => $orderId, ':p' => self::PROVIDER, ':tx' => 'SANDBOX-' . strtoupper(bin2hex(random_bytes(8))),
                    ':amount' => $totals['total'], ':cur' => APP_CURRENCY,
                ]);
            }

            if ($coupon) {
                $updated = self::run('UPDATE ma_giam_gia SET so_luot_da_dung = so_luot_da_dung + 1
                    WHERE ma = :id AND (so_luot_dung_toi_da IS NULL OR so_luot_da_dung < so_luot_dung_toi_da)', [':id' => (int)$coupon['ma']]);
                if ($updated !== 1) {
                    throw new RuntimeException('Mã giảm giá vừa hết lượt sử dụng.');
                }
                self::run('INSERT INTO luot_dung_ma_giam_gia (ma_giam_gia_id, don_hang_id, nguoi_dung_id, so_tien_giam) VALUES (:c, :o, :u, :a)',
                    [':c' => (int)$coupon['ma'], ':o' => $orderId, ':u' => $userId, ':a' => $totals['coupon']]);
            }

            self::run('DELETE FROM muc_gio_hang WHERE gio_hang_id = :c', [':c' => (int)$cart['ma']]);
            self::run("UPDATE gio_hang SET trang_thai = 'checked_out' WHERE ma = :c", [':c' => (int)$cart['ma']]);

            $orderUrl = '/orders/' . $code;
            NotificationModel::create($userId, 'order_paid', 'Đơn hàng ' . $code . ' đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', $orderUrl);
            foreach ($sellers as $authorId => $titles) {
                if ($authorId !== $userId) {
                    NotificationModel::create((int)$authorId, 'sale', 'Bạn có lượt bán mới', implode(', ', array_unique($titles)), '/dev/sales');
                }
            }
            unset($_SESSION['cart_coupon'], $_SESSION['pwyw']);
            return $code;
        });
    }

    private static function insertOrderItem(int $orderId, array $line): int {
        self::run("INSERT INTO chi_tiet_don_hang (don_hang_id, loai_muc, tro_choi_id, goi_game_id, tieu_de_luc_mua, so_luong, don_gia, so_tien_giam, tien_thue, thanh_tien_dong, ma_tien_te)
            VALUES (:o, :t, :g, :b, :title, 1, :unit, :disc, 0, :net, :cur)", [
            ':o' => $orderId, ':t' => $line['type'], ':g' => $line['type'] === 'game' ? $line['id'] : null,
            ':b' => $line['type'] === 'bundle' ? $line['id'] : null, ':title' => mb_substr($line['title'], 0, 220),
            ':unit' => $line['list'], ':disc' => round($line['sale'] + $line['coupon'], 2), ':net' => $line['net'], ':cur' => APP_CURRENCY,
        ]);
        return self::lastId();
    }

    /** Split a bundle's net amount across its games by base price (equally when all are free). */
    private static function splitBundle(array $line): array {
        $games = $line['games'];
        $sum = array_sum(array_column($games, 'base'));
        $out = [];
        $left = $line['net'];
        foreach ($games as $i => $g) {
            $amount = $i === count($games) - 1 ? $left : round($line['net'] * ($sum > 0 ? $g['base'] / $sum : 1 / count($games)), 2);
            $left = round($left - $amount, 2);
            $out[$g['id']] = ['creator' => $g['creator'], 'amount' => $amount];
        }
        return $out;
    }

    /** [authorId => ['amount' => gross, 'percent' => share]] for one game's revenue. */
    private static function splitAuthors(int $gameId, int $creatorId, float $amount): array {
        $shares = self::authorShares($gameId, $creatorId);
        $sum = array_sum($shares);
        $out = [];
        $left = $amount;
        $ids = array_keys($shares);
        foreach ($ids as $i => $authorId) {
            $part = $i === count($ids) - 1 ? $left : round($amount * $shares[$authorId] / $sum, 2);
            $left = round($left - $part, 2);
            $out[$authorId] = ['amount' => $part, 'percent' => round($shares[$authorId] * 100 / $sum, 2)];
        }
        return $out;
    }
}
