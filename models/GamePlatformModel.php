<?php
// =============================================================================
// GAME PLATFORM MODEL - Table: tro_choi_nen_tang
// =============================================================================

class GamePlatformModel extends Model {
    protected static $table = 'tro_choi_nen_tang';

    public static function add(int $gameId, int $platformId): bool {
        return self::insertRow(['tro_choi_id' => $gameId, 'nen_tang_id' => $platformId]);
    }

    public static function listForGame(int $gameId): array {
        $sql = "SELECT nt.* FROM nen_tang nt
                INNER JOIN tro_choi_nen_tang tnt ON tnt.nen_tang_id = nt.ma
                WHERE tnt.tro_choi_id = :gid";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':gid' => $gameId]);
        return $stmt->fetchAll();
    }

    public static function setForGame(int $gameId, array $platformIds): void {
        self::db()->prepare("DELETE FROM " . self::$table . " WHERE tro_choi_id = :gid")->execute([':gid' => $gameId]);
        foreach ($platformIds as $pid) {
            self::add($gameId, (int)$pid);
        }
    }
}