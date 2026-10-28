<?php
// =============================================================================
// GAME TAG MODEL - Table: tro_choi_nhan
// =============================================================================

class GameTagModel extends Model {
    protected static $table = 'tro_choi_nhan';

    public static function add(int $gameId, int $tagId): bool {
        return self::insertRow(['tro_choi_id' => $gameId, 'nhan_id' => $tagId]);
    }

    public static function listForGame(int $gameId): array {
        $sql = "SELECT n.* FROM nhan n
                INNER JOIN tro_choi_nhan tn ON tn.nhan_id = n.ma
                WHERE tn.tro_choi_id = :gid";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':gid' => $gameId]);
        return $stmt->fetchAll();
    }

    public static function setForGame(int $gameId, array $tagIds): void {
        self::db()->prepare("DELETE FROM " . self::$table . " WHERE tro_choi_id = :gid")->execute([':gid' => $gameId]);
        foreach ($tagIds as $tid) {
            self::add($gameId, (int)$tid);
        }
    }
}