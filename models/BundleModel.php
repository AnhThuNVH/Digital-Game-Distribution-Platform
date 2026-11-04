<?php
// =============================================================================
// BUNDLE MODEL - Tables: goi_game, tro_choi_goi_game
// =============================================================================

class BundleModel extends Model {
    protected static $table = 'goi_game';

    public const STATUSES = ['draft', 'published', 'hidden', 'ended'];

    public static function isOnSale(array $bundle): bool {
        if ($bundle['trang_thai'] !== 'published') {
            return false;
        }
        $now = time();
        if ($bundle['ngay_bat_dau'] && strtotime($bundle['ngay_bat_dau']) > $now) {
            return false;
        }
        return !($bundle['ngay_ket_thuc'] && strtotime($bundle['ngay_ket_thuc']) <= $now);
    }

    /** Published games inside a bundle, as game cards. */
    public static function games(int $bundleId, bool $publishedOnly = true): array {
        return self::query('SELECT ' . GameModel::cardColumns() . ', x.vi_tri FROM tro_choi_goi_game x JOIN tro_choi g ON g.ma = x.tro_choi_id
            WHERE x.goi_game_id = :b' . ($publishedOnly ? " AND g.trang_thai = 'published'" : '') . ' ORDER BY x.vi_tri, g.tieu_de', [':b' => $bundleId]);
    }

    /** Bundles on sale now, with the summed list price of their games. */
    public static function onSale(int $limit = 50): array {
        return self::query("SELECT b.*, u.ten_hien_thi AS nguoi_tao,
                (SELECT COUNT(*) FROM tro_choi_goi_game x JOIN tro_choi g ON g.ma = x.tro_choi_id WHERE x.goi_game_id = b.ma AND g.trang_thai = 'published') AS so_game,
                (SELECT COALESCE(SUM(CASE WHEN g.mo_hinh_gia IN ('paid','pay_what_you_want') THEN g.gia_toi_thieu ELSE 0 END), 0)
                   FROM tro_choi_goi_game x JOIN tro_choi g ON g.ma = x.tro_choi_id WHERE x.goi_game_id = b.ma AND g.trang_thai = 'published') AS tong_gia_le,
                (SELECT m.url_media FROM tro_choi_goi_game x JOIN media_tro_choi m ON m.tro_choi_id = x.tro_choi_id
                   WHERE x.goi_game_id = b.ma AND m.loai_media IN ('cover','screenshot') ORDER BY x.vi_tri, FIELD(m.loai_media,'cover','screenshot'), m.thu_tu_sap_xep LIMIT 1) AS anh_bia
            FROM goi_game b JOIN nguoi_dung u ON u.ma = b.nguoi_tao_id
            WHERE b.trang_thai = 'published' AND (b.ngay_bat_dau IS NULL OR b.ngay_bat_dau <= NOW()) AND (b.ngay_ket_thuc IS NULL OR b.ngay_ket_thuc > NOW())
            ORDER BY b.ngay_tao DESC LIMIT :limit", [':limit' => $limit]);
    }

    public static function findBySlug(string $slug): ?array {
        return self::one('SELECT b.*, u.ten_hien_thi AS nguoi_tao, u.ten_dang_nhap FROM goi_game b JOIN nguoi_dung u ON u.ma = b.nguoi_tao_id WHERE b.duong_dan_rut_gon = :s', [':s' => $slug]);
    }

    /** Bundles for the manage screens; $creatorId null lists all. */
    public static function listFor(?int $creatorId): array {
        $where = $creatorId === null ? '1=1' : 'b.nguoi_tao_id = :u';
        $params = $creatorId === null ? [] : [':u' => $creatorId];
        return self::query("SELECT b.*, u.ten_hien_thi AS nguoi_tao,
                (SELECT COUNT(*) FROM tro_choi_goi_game x WHERE x.goi_game_id = b.ma) AS so_game,
                (SELECT COUNT(*) FROM chi_tiet_don_hang i JOIN don_hang o ON o.ma = i.don_hang_id WHERE i.goi_game_id = b.ma AND o.trang_thai IN ('paid','partially_refunded')) AS so_luot_ban
            FROM goi_game b JOIN nguoi_dung u ON u.ma = b.nguoi_tao_id WHERE $where ORDER BY b.ngay_cap_nhat DESC", $params);
    }

    /** Validate the bundle form; returns [data, gameIds, errors]. $allowedGameIds null = any published game. */
    public static function fromForm(array $post, ?array $allowedGameIds, ?int $exceptId = null): array {
        $errors = [];
        $title = trim((string)($post['tieu_de'] ?? ''));
        if ($title === '' || mb_strlen($title) > 200) {
            $errors[] = 'Tên gói từ 1 đến 200 ký tự.';
        }
        $slugIn = trim((string)($post['duong_dan_rut_gon'] ?? ''));
        $slug = slugify($slugIn !== '' ? $slugIn : $title);
        if ($slugIn === '' && $title === '') {
            // The slug comes from the title; the title error already covers it.
        } elseif ($slug === '' || strlen($slug) > 220) {
            $errors[] = 'Đường dẫn không hợp lệ.';
        } elseif (self::scalar('SELECT 1 FROM goi_game WHERE duong_dan_rut_gon = :s AND ma <> :id', [':s' => $slug, ':id' => (int)$exceptId])) {
            $errors[] = 'Đường dẫn này đã được dùng cho gói khác.';
        }
        $price = parse_money($post['gia'] ?? '');
        if ($price === null) {
            $errors[] = 'Giá gói không hợp lệ (ví dụ 9.99).';
        }
        $status = (string)($post['trang_thai'] ?? 'draft');
        if (!in_array($status, self::STATUSES, true)) {
            $errors[] = 'Trạng thái không hợp lệ.';
        }
        $start = parse_datetime($post['ngay_bat_dau'] ?? '');
        $end = parse_datetime($post['ngay_ket_thuc'] ?? '');
        if ($start && $end && strtotime($end) <= strtotime($start)) {
            $errors[] = 'Ngày kết thúc phải sau ngày bắt đầu.';
        }
        $description = trim((string)($post['mo_ta'] ?? ''));
        if (mb_strlen($description) > 20000) {
            $errors[] = 'Mô tả quá dài.';
        }
        $gameIds = array_values(array_unique(array_filter(array_map('intval', (array)($post['games'] ?? [])))));
        if ($allowedGameIds !== null) {
            $gameIds = array_values(array_intersect($gameIds, $allowedGameIds));
        } elseif ($gameIds) {
            $in = implode(',', $gameIds);
            $gameIds = array_map('intval', self::column("SELECT ma FROM tro_choi WHERE ma IN ($in) AND trang_thai = 'published'"));
        }
        if (count($gameIds) < 2) {
            $errors[] = 'Một gói cần ít nhất 2 trò chơi.';
        } elseif ($price !== null && $price <= 0 && self::listTotal($gameIds) > 0) {
            // A free bundle would hand out paid games for nothing (and pay their authors nothing).
            $errors[] = 'Gói có trò chơi trả phí cần giá lớn hơn 0.';
        }
        return [[
            'tieu_de' => $title, 'duong_dan_rut_gon' => $slug, 'mo_ta' => $description !== '' ? $description : null,
            'gia' => $price, 'trang_thai' => $status, 'ngay_bat_dau' => $start, 'ngay_ket_thuc' => $end,
        ], $gameIds, $errors];
    }

    /** Published games that can go into a bundle; $authorId limits to games that user is an author of. */
    public static function eligibleGames(?int $authorId): array {
        $where = $authorId === null ? '' : ' AND EXISTS (SELECT 1 FROM tac_gia_tro_choi a WHERE a.tro_choi_id = g.ma AND a.nguoi_dung_id = :u)';
        return self::query("SELECT g.ma, g.tieu_de, g.mo_hinh_gia, g.gia_toi_thieu, u.ten_hien_thi AS nguoi_tao
            FROM tro_choi g JOIN nguoi_dung u ON u.ma = g.nguoi_tao_id
            WHERE g.trang_thai = 'published'$where ORDER BY g.tieu_de", $authorId === null ? [] : [':u' => $authorId]);
    }

    /** Sum of the base prices of the given games (GameModel::basePrice). */
    public static function listTotal(array $gameIds): float {
        if (!$gameIds) {
            return 0.0;
        }
        $in = implode(',', array_map('intval', $gameIds));
        return (float)self::scalar("SELECT COALESCE(SUM(CASE WHEN mo_hinh_gia IN ('paid','pay_what_you_want') THEN gia_toi_thieu ELSE 0 END), 0) FROM tro_choi WHERE ma IN ($in)");
    }

    public static function gameIds(int $bundleId): array {
        return array_map('intval', self::column('SELECT tro_choi_id FROM tro_choi_goi_game WHERE goi_game_id = :b ORDER BY vi_tri', [':b' => $bundleId]));
    }

    public static function saveGames(int $bundleId, array $gameIds): void {
        self::run('DELETE FROM tro_choi_goi_game WHERE goi_game_id = :b', [':b' => $bundleId]);
        foreach (array_values($gameIds) as $i => $gameId) {
            self::run('INSERT INTO tro_choi_goi_game (goi_game_id, tro_choi_id, vi_tri) VALUES (:b, :g, :p)', [':b' => $bundleId, ':g' => $gameId, ':p' => $i]);
        }
    }
}
