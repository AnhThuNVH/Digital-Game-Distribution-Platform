<?php
// =============================================================================
// GAME CATEGORY MODEL - Table: tro_choi_the_loai
// =============================================================================

class GameCategoryModel extends Model {
    protected static $table = 'tro_choi_the_loai';

    public static function add(int $gameId, int $categoryId): bool {
        return self::insertRow(['tro_choi_id' => $gameId, 'the_loai_id' => $categoryId]);
    }

    public static function listForGame(int $gameId): array {
        $sql = "SELECT tl.* FROM the_loai tl
                INNER JOIN tro_choi_the_loai ttl ON ttl.the_loai_id = tl.ma
                WHERE ttl.tro_choi_id = :gid";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':gid' => $gameId]);
        return $stmt->fetchAll();
    }

    public static function setForGame(int $gameId, array $categoryIds): void {
        self::db()->prepare("DELETE FROM " . self::$table . " WHERE tro_choi_id = :gid")->execute([':gid' => $gameId]);
        foreach ($categoryIds as $cid) {
            self::add($gameId, (int)$cid);
        }
    }
}