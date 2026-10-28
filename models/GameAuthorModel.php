<?php
// =============================================================================
// GAME AUTHOR MODEL - Table: tac_gia_tro_choi
// =============================================================================

class GameAuthorModel extends Model {
    protected static $table = 'tac_gia_tro_choi';

    public static function add(int $gameId, int $userId, float $share, int $order = 0): bool {
        return self::insertRow([
            'tro_choi_id' => $gameId,
            'nguoi_dung_id' => $userId,
            'phan_tram_huong_doanh_thu' => $share,
            'thu_tu_hien_thi' => $order,
        ]);
    }

    public static function listForGame(int $gameId): array {
        $sql = "SELECT t.*, u.ten_hien_thi, u.url_anh_dai_dien
                FROM " . self::$table . " t
                INNER JOIN nguoi_dung u ON u.ma = t.nguoi_dung_id
                WHERE t.tro_choi_id = :gid
                ORDER BY t.thu_tu_hien_thi ASC";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':gid' => $gameId]);
        return $stmt->fetchAll();
    }

    public static function totalShare(int $gameId): float {
        $sql = "SELECT COALESCE(SUM(phan_tram_huong_doanh_thu), 0) AS total FROM " . self::$table . " WHERE tro_choi_id = :gid";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':gid' => $gameId]);
        return (float)$stmt->fetch()['total'];
    }
}