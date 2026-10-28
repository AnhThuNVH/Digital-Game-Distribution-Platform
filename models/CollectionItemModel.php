<?php
// =============================================================================
// COLLECTION ITEM MODEL - Table: tro_choi_bo_suu_tap
// =============================================================================

class CollectionItemModel extends Model {
    protected static $table = 'tro_choi_bo_suu_tap';

    public static function add(int $collectionId, int $gameId, int $addedBy, string $note = ''): bool {
        return self::insertRow([
            'bo_suu_tap_id' => $collectionId,
            'tro_choi_id' => $gameId,
            'nguoi_them_id' => $addedBy,
            'ghi_chu' => $note,
        ]);
    }

    public static function listForCollection(int $collectionId): array {
        $sql = "SELECT t.*, g.tieu_de, g.duong_dan_rut_gon
                FROM " . self::$table . " t
                INNER JOIN tro_choi g ON g.ma = t.tro_choi_id
                WHERE t.bo_suu_tap_id = :cid ORDER BY t.vi_tri ASC";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':cid' => $collectionId]);
        return $stmt->fetchAll();
    }
}