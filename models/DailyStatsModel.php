<?php
// =============================================================================
// DAILY STATS MODEL - Table: thong_ke_tro_choi_hang_ngay (one row per game per day)
// =============================================================================

class DailyStatsModel extends Model {
    protected static $table = 'thong_ke_tro_choi_hang_ngay';
    private const COLUMNS = ['luot_xem_trang', 'luot_nhan_tai_xuong', 'so_luot_mua', 'doanh_thu_gop', 'luot_them_yeu_thich', 'so_luong_binh_luan'];

    public static function bump(int $gameId, string $column, float $amount = 1): void {
        if (!in_array($column, self::COLUMNS, true)) {
            throw new InvalidArgumentException('Unknown stats column.');
        }
        try {
            self::run("INSERT INTO thong_ke_tro_choi_hang_ngay (tro_choi_id, ngay_thong_ke, $column) VALUES (:g, CURDATE(), :a)
                ON DUPLICATE KEY UPDATE $column = $column + VALUES($column)", [':g' => $gameId, ':a' => $column === 'doanh_thu_gop' ? number_format($amount, 2, '.', '') : (int)$amount]);
        } catch (Throwable $error) {
            error_log('stats bump failed: ' . $error->getMessage());
        }
    }

    /** A page view is counted once per session per game per day. */
    public static function countView(int $gameId): void {
        $key = $gameId . ':' . date('Y-m-d');
        if (!empty($_SESSION['viewed'][$key])) {
            return;
        }
        $_SESSION['viewed'][$key] = 1;
        self::bump($gameId, 'luot_xem_trang');
    }

    /** Daily series for one or more games over the last $days days, gaps filled with zeros. */
    public static function series(array $gameIds, int $days = 30): array {
        $out = [];
        for ($i = $days - 1; $i >= 0; $i--) {
            $d = date('Y-m-d', strtotime("-$i day"));
            $out[$d] = array_fill_keys(self::COLUMNS, 0) + ['ngay' => $d];
        }
        if (!$gameIds) {
            return array_values($out);
        }
        $in = implode(',', array_map('intval', $gameIds));
        $rows = self::query("SELECT ngay_thong_ke, SUM(luot_xem_trang) luot_xem_trang, SUM(luot_nhan_tai_xuong) luot_nhan_tai_xuong, SUM(so_luot_mua) so_luot_mua,
                SUM(doanh_thu_gop) doanh_thu_gop, SUM(luot_them_yeu_thich) luot_them_yeu_thich, SUM(so_luong_binh_luan) so_luong_binh_luan
            FROM thong_ke_tro_choi_hang_ngay WHERE tro_choi_id IN ($in) AND ngay_thong_ke >= CURDATE() - INTERVAL :d DAY GROUP BY ngay_thong_ke", [':d' => $days - 1]);
        foreach ($rows as $row) {
            if (isset($out[$row['ngay_thong_ke']])) {
                foreach (self::COLUMNS as $c) {
                    $out[$row['ngay_thong_ke']][$c] = (float)$row[$c];
                }
            }
        }
        return array_values($out);
    }
}
