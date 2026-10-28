<?php
// =============================================================================
// DISCOUNT CAMPAIGN MODEL - Table: chien_dich_giam_gia
// =============================================================================

class DiscountCampaignModel extends Model {
    protected static $table = 'chien_dich_giam_gia';

    public static function create(int $creatorId, string $title, string $description = '', float $percent, string $start, string $end): int {
        return self::insert([
            'nguoi_tao_id' => $creatorId,
            'tieu_de' => $title,
            'mo_ta' => $description,
            'phan_tram_giam_gia' => $percent,
            'trang_thai' => 'active',
            'ngay_bat_dau' => $start,
            'ngay_ket_thuc' => $end,
        ]);
    }

    public static function getActive(): array {
        $now = date('Y-m-d H:i:s');
        $sql = "SELECT * FROM " . self::$table . " WHERE trang_thai = 'active' AND ngay_bat_dau <= :now AND ngay_ket_thuc >= :now";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':now' => $now]);
        return $stmt->fetchAll();
    }
}