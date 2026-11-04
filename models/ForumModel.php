<?php
// =============================================================================
// FORUM MODEL - Tables: dien_dan, chu_de_thao_luan, bai_viet_thao_luan,
// tuong_tac_bai_viet
// =============================================================================

class ForumModel extends Model {
    protected static $table = 'dien_dan';

    public const REACTIONS = ['like', 'helpful', 'love', 'laugh'];

    private static function boardColumns(): string {
        return "d.*, g.tieu_de AS game_title, g.duong_dan_rut_gon AS game_slug, g.trang_thai AS game_status, g.nguoi_tao_id AS game_creator,
            j.tieu_de AS jam_title, j.duong_dan_rut_gon AS jam_slug, j.trang_thai AS jam_status,
            (SELECT COUNT(*) FROM chu_de_thao_luan t WHERE t.dien_dan_id = d.ma AND t.trang_thai = 'published') AS so_chu_de,
            (SELECT COUNT(*) FROM bai_viet_thao_luan p JOIN chu_de_thao_luan t ON t.ma = p.chu_de_id
              WHERE t.dien_dan_id = d.ma AND t.trang_thai = 'published' AND p.trang_thai = 'published') AS so_bai,
            (SELECT MAX(COALESCE((SELECT MAX(p.ngay_tao) FROM bai_viet_thao_luan p WHERE p.chu_de_id = t.ma AND p.trang_thai = 'published'), t.ngay_tao))
              FROM chu_de_thao_luan t WHERE t.dien_dan_id = d.ma AND t.trang_thai = 'published') AS hoat_dong_cuoi";
    }

    /** Boards for the index. Staff also see private boards and boards of unpublished games or draft jams. */
    public static function boards(bool $staff): array {
        $where = $staff ? '1 = 1' : "d.cong_khai = 1 AND (d.loai_dien_dan = 'platform'
            OR (d.loai_dien_dan = 'game' AND g.trang_thai = 'published')
            OR (d.loai_dien_dan = 'jam' AND j.trang_thai NOT IN ('draft','cancelled')))";
        return self::query('SELECT ' . self::boardColumns() . ' FROM dien_dan d
            LEFT JOIN tro_choi g ON g.ma = d.tro_choi_id LEFT JOIN cuoc_thi_lam_game j ON j.ma = d.cuoc_thi_id
            WHERE ' . $where . " ORDER BY FIELD(d.loai_dien_dan,'platform','game','jam'), hoat_dong_cuoi IS NULL, hoat_dong_cuoi DESC, d.ma");
    }

    public static function board(int $id): ?array {
        return self::one('SELECT ' . self::boardColumns() . ' FROM dien_dan d
            LEFT JOIN tro_choi g ON g.ma = d.tro_choi_id LEFT JOIN cuoc_thi_lam_game j ON j.ma = d.cuoc_thi_id
            WHERE d.ma = :id', [':id' => $id]);
    }

    private static function topicWhere(int $boardId, bool $staff, string $q): array {
        $where = 't.dien_dan_id = :b AND t.trang_thai ' . ($staff ? "IN ('published','hidden')" : "= 'published'");
        $params = [':b' => $boardId];
        if ($q !== '') {
            $where .= ' AND t.tieu_de LIKE :q';
            $params[':q'] = '%' . str_replace(['\\', '%', '_'], ['\\\\', '\%', '\_'], $q) . '%';
        }
        return [$where, $params];
    }

    public static function topics(int $boardId, bool $staff, string $q, int $limit, int $offset): array {
        [$where, $params] = self::topicWhere($boardId, $staff, $q);
        return self::query("SELECT t.ma, t.tieu_de, t.trang_thai, t.da_ghim, t.da_khoa, t.ngay_tao, t.tac_gia_nguoi_dung_id,
                u.ten_dang_nhap, u.ten_hien_thi, u.url_anh_dai_dien,
                (SELECT COUNT(*) FROM bai_viet_thao_luan p WHERE p.chu_de_id = t.ma AND p.trang_thai = 'published') AS so_tra_loi,
                (SELECT MAX(p.ngay_tao) FROM bai_viet_thao_luan p WHERE p.chu_de_id = t.ma AND p.trang_thai = 'published') AS tra_loi_cuoi
            FROM chu_de_thao_luan t JOIN nguoi_dung u ON u.ma = t.tac_gia_nguoi_dung_id
            WHERE $where ORDER BY t.da_ghim DESC, COALESCE(tra_loi_cuoi, t.ngay_tao) DESC, t.ma DESC
            LIMIT " . (int)$limit . ' OFFSET ' . (int)$offset, $params);
    }

    public static function countTopics(int $boardId, bool $staff, string $q): int {
        [$where, $params] = self::topicWhere($boardId, $staff, $q);
        return (int)self::scalar("SELECT COUNT(*) FROM chu_de_thao_luan t WHERE $where", $params);
    }

    public static function topic(int $boardId, int $topicId): ?array {
        return self::one('SELECT t.*, u.ten_dang_nhap, u.ten_hien_thi, u.url_anh_dai_dien
            FROM chu_de_thao_luan t JOIN nguoi_dung u ON u.ma = t.tac_gia_nguoi_dung_id
            WHERE t.ma = :t AND t.dien_dan_id = :b', [':t' => $topicId, ':b' => $boardId]);
    }

    private static function postWhere(bool $staff): string {
        return 'p.chu_de_id = :t AND p.trang_thai ' . ($staff ? "IN ('published','hidden')" : "= 'published'");
    }

    public static function posts(int $topicId, bool $staff, int $limit, int $offset): array {
        return self::query('SELECT p.*, u.ten_dang_nhap, u.ten_hien_thi, u.url_anh_dai_dien,
                pp.tac_gia_nguoi_dung_id AS cha_tac_gia_id, pu.ten_hien_thi AS cha_ten, pp.trang_thai AS cha_trang_thai
            FROM bai_viet_thao_luan p JOIN nguoi_dung u ON u.ma = p.tac_gia_nguoi_dung_id
            LEFT JOIN bai_viet_thao_luan pp ON pp.ma = p.bai_viet_cha_id
            LEFT JOIN nguoi_dung pu ON pu.ma = pp.tac_gia_nguoi_dung_id
            WHERE ' . self::postWhere($staff) . ' ORDER BY p.ngay_tao, p.ma LIMIT ' . (int)$limit . ' OFFSET ' . (int)$offset, [':t' => $topicId]);
    }

    public static function countPosts(int $topicId, bool $staff): int {
        return (int)self::scalar('SELECT COUNT(*) FROM bai_viet_thao_luan p WHERE ' . self::postWhere($staff), [':t' => $topicId]);
    }

    /** Post with its topic and board, for edit/delete/react. */
    public static function postWithTopic(int $postId): ?array {
        return self::one('SELECT p.*, t.dien_dan_id, t.tieu_de AS topic_title, t.trang_thai AS topic_status, t.da_khoa
            FROM bai_viet_thao_luan p JOIN chu_de_thao_luan t ON t.ma = p.chu_de_id WHERE p.ma = :p', [':p' => $postId]);
    }

    /** Reaction counts per post and the viewer's own reactions. */
    public static function reactions(array $postIds, int $userId): array {
        $counts = [];
        $mine = [];
        $postIds = array_values(array_unique(array_map('intval', $postIds)));
        if (!$postIds) {
            return [$counts, $mine];
        }
        $ph = [];
        $params = [];
        foreach ($postIds as $i => $id) {
            $ph[] = ':p' . $i;
            $params[':p' . $i] = $id;
        }
        $in = implode(',', $ph);
        foreach (self::query("SELECT bai_viet_id, phan_ung, COUNT(*) n FROM tuong_tac_bai_viet WHERE bai_viet_id IN ($in) GROUP BY bai_viet_id, phan_ung", $params) as $r) {
            $counts[(int)$r['bai_viet_id']][$r['phan_ung']] = (int)$r['n'];
        }
        if ($userId > 0) {
            foreach (self::query("SELECT bai_viet_id, phan_ung FROM tuong_tac_bai_viet WHERE nguoi_dung_id = :u AND bai_viet_id IN ($in)", $params + [':u' => $userId]) as $r) {
                $mine[(int)$r['bai_viet_id']][$r['phan_ung']] = true;
            }
        }
        return [$counts, $mine];
    }

    /** Toggle a reaction; returns true when it is now on. */
    public static function toggleReaction(int $postId, int $userId, string $reaction): bool {
        $removed = self::run('DELETE FROM tuong_tac_bai_viet WHERE bai_viet_id = :p AND nguoi_dung_id = :u AND phan_ung = :r', [':p' => $postId, ':u' => $userId, ':r' => $reaction]);
        if ($removed) {
            return false;
        }
        self::run('INSERT INTO tuong_tac_bai_viet (bai_viet_id, nguoi_dung_id, phan_ung) VALUES (:p, :u, :r)', [':p' => $postId, ':u' => $userId, ':r' => $reaction]);
        return true;
    }
}
