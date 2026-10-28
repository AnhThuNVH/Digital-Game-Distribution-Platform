<?php
// =============================================================================
// DEVLOG COMMENT MODEL - Table: binh_luan_nhat_ky
// =============================================================================

class DevlogCommentModel extends Model {
    protected static $table = 'binh_luan_nhat_ky';

    public static function create(int $devlogId, int $userId, string $content, ?int $parentId = null): int {
        return self::insert([
            'nhat_ky_phat_trien_id' => $devlogId,
            'nguoi_dung_id' => $userId,
            'binh_luan_cha_id' => $parentId,
            'noi_dung' => $content,
        ]);
    }

    public static function listForDevlog(int $devlogId): array {
        $sql = "SELECT c.*, u.ten_hien_thi, u.url_anh_dai_dien
                FROM " . self::$table . " c
                INNER JOIN nguoi_dung u ON u.ma = c.nguoi_dung_id
                WHERE c.nhat_ky_phat_trien_id = :did AND c.trang_thai = 'published'
                ORDER BY c.ngay_tao ASC";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':did' => $devlogId]);
        return $stmt->fetchAll();
    }
}