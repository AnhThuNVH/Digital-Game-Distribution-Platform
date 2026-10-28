<?php
// =============================================================================
// TOPIC MODEL - Table: chu_de_thao_luan
// =============================================================================

class TopicModel extends Model {
    protected static $table = 'chu_de_thao_luan';

    public static function create(int $forumId, int $authorId, string $title, string $content): int {
        return self::insert([
            'dien_dan_id' => $forumId,
            'tac_gia_nguoi_dung_id' => $authorId,
            'tieu_de' => $title,
            'noi_dung_mo_dau' => $content,
        ]);
    }

    public static function listForForum(int $forumId): array {
        $sql = "SELECT t.*, u.ten_hien_thi
                FROM " . self::$table . " t
                INNER JOIN nguoi_dung u ON u.ma = t.tac_gia_nguoi_dung_id
                WHERE t.dien_dan_id = :fid AND t.trang_thai = 'published'
                ORDER BY t.da_ghim DESC, t.ngay_cap_nhat DESC";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':fid' => $forumId]);
        return $stmt->fetchAll();
    }
}