<?php
// =============================================================================
// DAILY STATS MODEL - Table: thong_ke_tro_choi_hang_ngay
// =============================================================================

class DailyStatsModel extends Model {
    protected static $table = 'thong_ke_tro_choi_hang_ngay';
    protected static $pk = 'ngay_thong_ke'; // composite key

    public static function increment(int $gameId, string $date, array $fields): void {
        $sets = [];
        $params = [':gid' => $gameId, ':date' => $date];
        foreach ($fields as $col => $val) {
            $sets[] = "$col = $col + :$col";
            $params[':' . $col] = $val;
        }
        $sql = "INSERT INTO " . self::$table . " (tro_choi_id, ngay_thong_ke) VALUES (:gid, :date)
                ON DUPLICATE KEY UPDATE " . implode(', ', $sets);
        $stmt = self::db()->prepare($sql);
        $stmt->execute($params);
    }
}