<?php
// =============================================================================
// GAME MODEL - Table: tro_choi
// Catalogue queries load cover, sale, rating, categories and platforms in one
// statement (correlated sub-selects) instead of one query per game.
// =============================================================================

class GameModel extends Model {
    protected static $table = 'tro_choi';

    public const STATUSES = ['draft', 'published', 'unlisted', 'hidden', 'under_review', 'suspended'];
    public const RELEASE_STATUSES = ['prototype', 'in_development', 'early_access', 'released', 'cancelled'];
    public const PRICING = ['free', 'paid', 'pay_what_you_want', 'donation'];
    public const PROJECT_TYPES = ['game', 'asset', 'tool', 'soundtrack', 'comic', 'book', 'physical', 'other'];

    /** Shared column list for any game card. */
    public static function cardColumns(string $alias = 'g'): string {
        $g = $alias;
        return "$g.ma, $g.nguoi_tao_id, $g.tieu_de, $g.duong_dan_rut_gon, $g.mo_ta_ngan, $g.loai_du_an, $g.trang_thai,
            $g.trang_thai_phat_hanh, $g.mo_hinh_gia, $g.gia_toi_thieu, $g.gia_de_xuat, $g.ma_tien_te, $g.ngay_cong_bo, $g.ngay_tao,
            (SELECT m.url_media FROM media_tro_choi m
              WHERE m.tro_choi_id = $g.ma AND m.loai_media IN ('cover','thumbnail','screenshot')
              ORDER BY FIELD(m.loai_media,'cover','thumbnail','screenshot'), m.thu_tu_sap_xep, m.ma LIMIT 1) AS anh_bia,
            (SELECT m.van_ban_thay_the FROM media_tro_choi m
              WHERE m.tro_choi_id = $g.ma AND m.loai_media IN ('cover','thumbnail','screenshot')
              ORDER BY FIELD(m.loai_media,'cover','thumbnail','screenshot'), m.thu_tu_sap_xep, m.ma LIMIT 1) AS anh_bia_alt,
            (SELECT MAX(c.phan_tram_giam_gia) FROM tro_choi_giam_gia tg
              JOIN chien_dich_giam_gia c ON c.ma = tg.chien_dich_id
              WHERE tg.tro_choi_id = $g.ma AND c.trang_thai IN ('active','scheduled')
                AND NOW() >= c.ngay_bat_dau AND NOW() < c.ngay_ket_thuc) AS giam_gia,
            (SELECT ROUND(AVG(r.diem_danh_gia), 1) FROM danh_gia r WHERE r.tro_choi_id = $g.ma AND r.trang_thai = 'published') AS diem_tb,
            (SELECT COUNT(*) FROM danh_gia r WHERE r.tro_choi_id = $g.ma AND r.trang_thai = 'published') AS so_danh_gia,
            (SELECT GROUP_CONCAT(t.ten ORDER BY t.ten SEPARATOR ', ') FROM tro_choi_the_loai x
              JOIN the_loai t ON t.ma = x.the_loai_id WHERE x.tro_choi_id = $g.ma) AS the_loai,
            (SELECT GROUP_CONCAT(p.ten_nen_tang ORDER BY p.ma SEPARATOR ', ') FROM tro_choi_nen_tang x
              JOIN nen_tang p ON p.ma = x.nen_tang_id WHERE x.tro_choi_id = $g.ma) AS nen_tang,
            (SELECT GROUP_CONCAT(u.ten_hien_thi ORDER BY a.thu_tu_hien_thi, a.ngay_them SEPARATOR ', ') FROM tac_gia_tro_choi a
              JOIN nguoi_dung u ON u.ma = a.nguoi_dung_id WHERE a.tro_choi_id = $g.ma) AS nha_phat_trien";
    }

    /** Price the buyer pays right now (sale applied to paid games only). */
    public static function effectivePrice(array $game): float {
        $base = self::basePrice($game);
        $discount = (float)($game['giam_gia'] ?? 0);
        if ($game['mo_hinh_gia'] === 'paid' && $discount > 0) {
            return round($base * (1 - $discount / 100), 2);
        }
        return $base;
    }

    public static function basePrice(array $game): float {
        return in_array($game['mo_hinh_gia'], ['paid', 'pay_what_you_want'], true) ? (float)$game['gia_toi_thieu'] : 0.0;
    }

    /** A game needs checkout when its minimum price is above zero. */
    public static function requiresPayment(array $game): bool {
        return self::basePrice($game) > 0;
    }

    public static function findBySlug(string $slug): ?array {
        return self::one('SELECT ' . self::cardColumns() . ', g.mo_ta, g.phan_loai_do_tuoi, g.ten_giay_phep, g.url_choi_ngoai,
                g.cho_phep_binh_luan, g.cho_phep_danh_gia, g.ngay_cap_nhat
            FROM tro_choi g WHERE g.duong_dan_rut_gon = :slug LIMIT 1', [':slug' => $slug]);
    }

    public static function findWithCard(int $id): ?array {
        return self::one('SELECT ' . self::cardColumns() . ', g.mo_ta, g.phan_loai_do_tuoi, g.ten_giay_phep, g.url_choi_ngoai,
                g.cho_phep_binh_luan, g.cho_phep_danh_gia, g.ngay_cap_nhat
            FROM tro_choi g WHERE g.ma = :id LIMIT 1', [':id' => $id]);
    }

    /** Build WHERE + params for the public catalogue. */
    private static function catalogueWhere(array $f): array {
        $where = ["g.trang_thai = 'published'"];
        $params = [];
        if (!empty($f['q'])) {
            $where[] = "(g.tieu_de LIKE :q1 OR g.mo_ta_ngan LIKE :q2 OR EXISTS (SELECT 1 FROM tro_choi_nhan x JOIN nhan n ON n.ma = x.nhan_id WHERE x.tro_choi_id = g.ma AND n.ten LIKE :q3))";
            $like = '%' . $f['q'] . '%';
            $params += [':q1' => $like, ':q2' => $like, ':q3' => $like];
        }
        if (!empty($f['category'])) {
            $where[] = 'EXISTS (SELECT 1 FROM tro_choi_the_loai x JOIN the_loai t ON t.ma = x.the_loai_id WHERE x.tro_choi_id = g.ma AND t.duong_dan_rut_gon = :cat)';
            $params[':cat'] = $f['category'];
        }
        if (!empty($f['tag'])) {
            $where[] = 'EXISTS (SELECT 1 FROM tro_choi_nhan x JOIN nhan n ON n.ma = x.nhan_id WHERE x.tro_choi_id = g.ma AND n.duong_dan_rut_gon = :tag)';
            $params[':tag'] = $f['tag'];
        }
        if (!empty($f['platform'])) {
            $where[] = 'EXISTS (SELECT 1 FROM tro_choi_nen_tang x JOIN nen_tang p ON p.ma = x.nen_tang_id WHERE x.tro_choi_id = g.ma AND p.ma_nen_tang = :plat)';
            $params[':plat'] = $f['platform'];
        }
        if (!empty($f['status']) && in_array($f['status'], self::RELEASE_STATUSES, true)) {
            $where[] = 'g.trang_thai_phat_hanh = :rstatus';
            $params[':rstatus'] = $f['status'];
        }
        if (!empty($f['type']) && in_array($f['type'], self::PROJECT_TYPES, true)) {
            $where[] = 'g.loai_du_an = :ptype';
            $params[':ptype'] = $f['type'];
        }
        if (!empty($f['author'])) {
            $where[] = 'EXISTS (SELECT 1 FROM tac_gia_tro_choi a WHERE a.tro_choi_id = g.ma AND a.nguoi_dung_id = :author)';
            $params[':author'] = (int)$f['author'];
        }
        switch ($f['price'] ?? '') {
            case 'free':
                $where[] = "(g.mo_hinh_gia IN ('free','donation') OR (g.mo_hinh_gia = 'pay_what_you_want' AND g.gia_toi_thieu = 0))";
                break;
            case 'paid':
                $where[] = "g.gia_toi_thieu > 0 AND g.mo_hinh_gia IN ('paid','pay_what_you_want')";
                break;
            case 'under5':
                $where[] = "g.mo_hinh_gia IN ('paid','pay_what_you_want') AND g.gia_toi_thieu > 0 AND g.gia_toi_thieu <= 5";
                break;
            case 'under15':
                $where[] = "g.mo_hinh_gia IN ('paid','pay_what_you_want') AND g.gia_toi_thieu > 0 AND g.gia_toi_thieu <= 15";
                break;
        }
        if (!empty($f['sale'])) {
            $where[] = "EXISTS (SELECT 1 FROM tro_choi_giam_gia tg JOIN chien_dich_giam_gia c ON c.ma = tg.chien_dich_id
                WHERE tg.tro_choi_id = g.ma AND c.trang_thai IN ('active','scheduled') AND NOW() >= c.ngay_bat_dau AND NOW() < c.ngay_ket_thuc AND c.phan_tram_giam_gia > 0)";
        }
        return [implode(' AND ', $where), $params];
    }

    public const SORTS = [
        'popular' => 'Phổ biến',
        'new' => 'Mới công bố',
        'rating' => 'Đánh giá cao',
        'price_asc' => 'Giá thấp đến cao',
        'price_desc' => 'Giá cao đến thấp',
        'title' => 'Tên A–Z',
    ];

    private static function sortClause(string $sort): string {
        switch ($sort) {
            case 'new': return 'g.ngay_cong_bo DESC, g.ma DESC';
            case 'rating': return 'diem_tb IS NULL, diem_tb DESC, so_danh_gia DESC, g.ma DESC';
            case 'price_asc': return "(CASE WHEN g.mo_hinh_gia IN ('paid','pay_what_you_want') THEN g.gia_toi_thieu ELSE 0 END) ASC, g.tieu_de ASC";
            case 'price_desc': return "(CASE WHEN g.mo_hinh_gia IN ('paid','pay_what_you_want') THEN g.gia_toi_thieu ELSE 0 END) DESC, g.tieu_de ASC";
            case 'title': return 'g.tieu_de ASC';
            default: return 'so_huu DESC, so_danh_gia DESC, g.ngay_cong_bo DESC';
        }
    }

    public static function catalogue(array $filters, int $limit, int $offset): array {
        [$where, $params] = self::catalogueWhere($filters);
        $sql = 'SELECT ' . self::cardColumns() . ",
                (SELECT COUNT(*) FROM quyen_so_huu_tro_choi o WHERE o.tro_choi_id = g.ma AND o.trang_thai = 'active') AS so_huu
            FROM tro_choi g WHERE $where ORDER BY " . self::sortClause((string)($filters['sort'] ?? 'popular')) . ' LIMIT :limit OFFSET :offset';
        $params[':limit'] = $limit;
        $params[':offset'] = $offset;
        return self::query($sql, $params);
    }

    public static function countCatalogue(array $filters): int {
        [$where, $params] = self::catalogueWhere($filters);
        return (int)self::scalar("SELECT COUNT(*) FROM tro_choi g WHERE $where", $params);
    }

    /** Is the user one of the game's authors (or its creator)? */
    public static function isAuthor(int $gameId, int $userId): bool {
        if ($userId <= 0) return false;
        return (bool)self::scalar(
            'SELECT 1 FROM tro_choi g WHERE g.ma = :gid AND (g.nguoi_tao_id = :uid1 OR EXISTS (SELECT 1 FROM tac_gia_tro_choi a WHERE a.tro_choi_id = g.ma AND a.nguoi_dung_id = :uid2))',
            [':gid' => $gameId, ':uid1' => $userId, ':uid2' => $userId]
        );
    }

    /** Creator plus listed authors of a game. */
    public static function authorIds(int $gameId): array {
        $ids = array_map('intval', self::column('SELECT nguoi_dung_id FROM tac_gia_tro_choi WHERE tro_choi_id = :g', [':g' => $gameId]));
        $creator = (int)self::scalar('SELECT nguoi_tao_id FROM tro_choi WHERE ma = :g', [':g' => $gameId]);
        if ($creator) {
            $ids[] = $creator;
        }
        return array_values(array_unique($ids));
    }

    /** Games the user can manage as a developer. */
    public static function listForAuthor(int $userId): array {
        return self::query('SELECT ' . self::cardColumns() . ",
                (SELECT COUNT(*) FROM quyen_so_huu_tro_choi o WHERE o.tro_choi_id = g.ma AND o.trang_thai = 'active') AS so_huu,
                (SELECT COALESCE(SUM(s.luot_xem_trang),0) FROM thong_ke_tro_choi_hang_ngay s WHERE s.tro_choi_id = g.ma AND s.ngay_thong_ke >= CURDATE() - INTERVAL 29 DAY) AS luot_xem_30
            FROM tro_choi g
            WHERE g.nguoi_tao_id = :uid1 OR EXISTS (SELECT 1 FROM tac_gia_tro_choi a WHERE a.tro_choi_id = g.ma AND a.nguoi_dung_id = :uid2)
            ORDER BY g.ngay_cap_nhat DESC", [':uid1' => $userId, ':uid2' => $userId]);
    }

    public static function create(array $data): int {
        return self::insert($data);
    }

    public static function listForAdmin(string $q, string $status, int $limit, int $offset): array {
        [$where, $params] = self::adminWhere($q, $status);
        $params[':limit'] = $limit;
        $params[':offset'] = $offset;
        return self::query("SELECT g.ma, g.tieu_de, g.duong_dan_rut_gon, g.trang_thai, g.mo_hinh_gia, g.gia_toi_thieu, g.ngay_tao, g.ngay_cap_nhat,
                u.ten_dang_nhap, u.ten_hien_thi,
                (SELECT COUNT(*) FROM bao_cao_noi_dung b WHERE b.loai_doi_tuong = 'game' AND b.doi_tuong_id = g.ma AND b.trang_thai IN ('open','investigating')) AS bao_cao_mo
            FROM tro_choi g JOIN nguoi_dung u ON u.ma = g.nguoi_tao_id
            WHERE $where ORDER BY FIELD(g.trang_thai,'under_review') DESC, g.ngay_cap_nhat DESC LIMIT :limit OFFSET :offset", $params);
    }

    public static function countForAdmin(string $q, string $status): int {
        [$where, $params] = self::adminWhere($q, $status);
        return (int)self::scalar("SELECT COUNT(*) FROM tro_choi g JOIN nguoi_dung u ON u.ma = g.nguoi_tao_id WHERE $where", $params);
    }

    private static function adminWhere(string $q, string $status): array {
        $where = ['1=1'];
        $params = [];
        if (ctype_digit($q)) {
            $where[] = 'g.ma = :qid';
            $params[':qid'] = (int)$q;
        } elseif ($q !== '') {
            $where[] = '(g.tieu_de LIKE :q1 OR g.duong_dan_rut_gon LIKE :q2 OR u.ten_dang_nhap LIKE :q3)';
            $params += [':q1' => "%$q%", ':q2' => "%$q%", ':q3' => "%$q%"];
        }
        if (in_array($status, self::STATUSES, true)) {
            $where[] = 'g.trang_thai = :status';
            $params[':status'] = $status;
        }
        return [implode(' AND ', $where), $params];
    }

    /** Statuses staff may set. Draft stays the developer's own state. */
    public const STAFF_STATUSES = ['published', 'unlisted', 'hidden', 'under_review', 'suspended'];

    /**
     * Staff status change: update, moderation log, system log, and a notice to the authors.
     * Returns an error message, or null on success. $game needs ma, tieu_de, trang_thai.
     */
    public static function staffSetStatus(array $game, string $status, int $moderatorId, string $reason): ?string {
        if (!in_array($status, self::STAFF_STATUSES, true)) {
            return 'Trạng thái không hợp lệ.';
        }
        if ($game['trang_thai'] === 'draft') {
            return 'Bản nháp do nhà phát triển quản lý; chỉ xử lý sau khi được gửi công bố.';
        }
        if ($status === $game['trang_thai']) {
            return 'Trò chơi đã ở trạng thái này.';
        }
        if (in_array($status, ['hidden', 'suspended'], true) && $reason === '') {
            return 'Hãy ghi lý do khi ẩn hoặc đình chỉ trò chơi.';
        }
        $id = (int)$game['ma'];
        $action = ['hidden' => 'hide', 'suspended' => 'suspend', 'under_review' => 'other'][$status] ?? 'restore';
        $change = label('game_status', $game['trang_thai']) . ' → ' . label('game_status', $status);
        self::transaction(function () use ($id, $status, $action, $reason, $moderatorId, $change) {
            self::run('UPDATE tro_choi SET trang_thai = :s WHERE ma = :g', [':s' => $status, ':g' => $id]);
            ModerationActionModel::log($moderatorId, 'game', $id, $action, $change . ($reason !== '' ? '. ' . $reason : ''));
        });
        audit('game_status', 'tro_choi', $id, ['truoc' => $game['trang_thai'], 'sau' => $status]);
        NotificationModel::notifyUsers(self::authorIds($id), $moderatorId, 'game_status', $game['tieu_de'] . ': ' . label('game_status', $status),
            $reason !== '' ? $reason : 'Trạng thái trò chơi đã được điều hành viên cập nhật.', '/dev/games/' . $id);
        return null;
    }
}
