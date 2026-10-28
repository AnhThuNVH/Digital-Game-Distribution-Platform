<?php
// =============================================================================
// FAVORITE MODEL - Table: tro_choi_yeu_thich
// =============================================================================

class FavoriteModel extends Model {
    protected static $table = 'tro_choi_yeu_thich';

    public static function toggle(int $userId, int $gameId): bool {
        if (self::exists($userId, $gameId)) {
            $stmt = self::db()->prepare("DELETE FROM " . self::$table . " WHERE nguoi_dung_id = :uid AND tro_choi_id = :gid");
            return $stmt->execute([':uid' => $userId, ':gid' => $gameId]);
        }
        return self::insertRow(['nguoi_dung_id' => $userId, 'tro_choi_id' => $gameId]);
    }

    public static function exists(int $userId, int $gameId): bool {
        $stmt = self::db()->prepare("SELECT 1 FROM " . self::$table . " WHERE nguoi_dung_id = :uid AND tro_choi_id = :gid LIMIT 1");
        $stmt->execute([':uid' => $userId, ':gid' => $gameId]);
        return $stmt->fetch() !== false;
    }

    public static function listForUser(int $userId): array {
        $sql = "SELECT g.* FROM tro_choi g
                INNER JOIN tro_choi_yeu_thich f ON f.tro_choi_id = g.ma
                WHERE f.nguoi_dung_id = :uid AND g.trang_thai = 'published'
                ORDER BY f.ngay_tao DESC";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':uid' => $userId]);
        return $stmt->fetchAll();
    }
}