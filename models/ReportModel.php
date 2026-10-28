<?php
// =============================================================================
// REPORT MODEL - Table: bao_cao_noi_dung
// =============================================================================

class ReportModel extends Model {
    protected static $table = 'bao_cao_noi_dung';

    public static function create(?int $reporterId, string $type, int $objectId, string $reason, string $details = ''): int {
        return self::insert([
            'nguoi_bao_cao_id' => $reporterId,
            'loai_doi_tuong' => $type,
            'doi_tuong_id' => $objectId,
            'ma_ly_do' => $reason,
            'chi_tiet' => $details,
        ]);
    }

    public static function listOpen(): array {
        $sql = "SELECT r.*, u.ten_hien_thi AS reporter_name
                FROM " . self::$table . " r
                LEFT JOIN nguoi_dung u ON u.ma = r.nguoi_bao_cao_id
                WHERE r.trang_thai = 'open' ORDER BY r.ngay_tao DESC";
        $stmt = self::db()->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll();
    }
}