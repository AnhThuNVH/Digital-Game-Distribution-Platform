<?php
// =============================================================================
// GAME COMMENT MODEL - Table: binh_luan_tro_choi
// =============================================================================

class GameCommentModel extends Model {
    protected static $table = 'binh_luan_tro_choi';

    public static function create(int $gameId, int $userId, string $content, ?int $parentId = null): int {
        return self::insert([
            'tro_choi_id' => $gameId,
            'nguoi_dung_id' => $userId,
            'binh_luan_cha_id' => $parentId,
            'noi_dung' => $content,
        ]);
    }

    public static function listForGame(int $gameId): array {
        $sql = "SELECT c.*, u.ten_hien_thi, u.url_anh_dai_dien
                FROM " . self::$table . " c
                INNER JOIN nguoi_dung u ON u.ma = c.nguoi_dung_id
                WHERE c.tro_choi_id = :gid AND c.trang_thai = 'published'
                ORDER BY c.ngay_tao ASC";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':gid' => $gameId]);
        return $stmt->fetchAll();
    }
}