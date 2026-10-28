<?php
// =============================================================================
// RELEASE MODEL - Table: phien_ban_phat_hanh
// =============================================================================

class ReleaseModel extends Model {
    protected static $table = 'phien_ban_phat_hanh';

    public static function create(int $gameId, string $version, string $channel, string $notes, int $creatorId): int {
        return self::insert([
            'tro_choi_id' => $gameId,
            'ten_phien_ban' => $version,
            'kenh_phat_hanh' => $channel,
            'ghi_chu_phat_hanh' => $notes,
            'nguoi_tao_id' => $creatorId,
            'ngay_phat_hanh' => date('Y-m-d H:i:s'),
        ]);
    }

    public static function listForGame(int $gameId): array {
        $sql = "SELECT * FROM " . self::$table . " WHERE tro_choi_id = :gid ORDER BY ngay_phat_hanh DESC";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':gid' => $gameId]);
        return $stmt->fetchAll();
    }
}