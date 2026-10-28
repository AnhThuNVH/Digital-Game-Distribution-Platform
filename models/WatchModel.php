<?php
// =============================================================================
// WATCH MODEL - Table: theo_doi_tro_choi
// =============================================================================

class WatchModel extends Model {
    protected static $table = 'theo_doi_tro_choi';

    public static function toggle(int $userId, int $gameId): bool {
        $exists = self::exists($userId, $gameId);
        if ($exists) {
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
}