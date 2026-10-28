<?php
// =============================================================================
// POST MODEL - Table: bai_viet_thao_luan
// =============================================================================

class PostModel extends Model {
    protected static $table = 'bai_viet_thao_luan';

    public static function create(int $topicId, int $authorId, string $content, ?int $parentId = null): int {
        return self::insert([
            'chu_de_id' => $topicId,
            'tac_gia_nguoi_dung_id' => $authorId,
            'bai_viet_cha_id' => $parentId,
            'noi_dung' => $content,
        ]);
    }

    public static function listForTopic(int $topicId): array {
        $sql = "SELECT p.*, u.ten_hien_thi, u.url_anh_dai_dien
                FROM " . self::$table . " p
                INNER JOIN nguoi_dung u ON u.ma = p.tac_gia_nguoi_dung_id
                WHERE p.chu_de_id = :tid AND p.trang_thai = 'published'
                ORDER BY p.ngay_tao ASC";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':tid' => $topicId]);
        return $stmt->fetchAll();
    }
}