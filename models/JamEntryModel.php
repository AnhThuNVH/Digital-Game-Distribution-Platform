<?php
// =============================================================================
// JAM ENTRY MODEL - Table: bai_du_thi
// =============================================================================

class JamEntryModel extends Model {
    protected static $table = 'bai_du_thi';

    public static function submit(int $jamId, int $gameId, int $submitterId): int {
        return self::insert([
            'cuoc_thi_id' => $jamId,
            'tro_choi_id' => $gameId,
            'nguoi_nop_id' => $submitterId,
        ]);
    }

    public static function listForJam(int $jamId): array {
        $sql = "SELECT b.*, g.tieu_de, g.duong_dan_rut_gon
                FROM " . self::$table . " b
                INNER JOIN tro_choi g ON g.ma = b.tro_choi_id
                WHERE b.cuoc_thi_id = :jid ORDER BY b.ngay_nop DESC";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':jid' => $jamId]);
        return $stmt->fetchAll();
    }
}