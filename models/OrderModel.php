<?php
// =============================================================================
// ORDER MODEL - Table: don_hang
// =============================================================================

class OrderModel extends Model {
    protected static $table = 'don_hang';

    public static function create(int $buyerId, string $orderNumber, string $currency, float $subtotal, float $discount, float $tax, float $total, ?string $country = null): int {
        return self::insert([
            'ma_don_hang' => $orderNumber,
            'nguoi_mua_id' => $buyerId,
            'ma_tien_te' => $currency,
            'tong_tien_hang' => $subtotal,
            'tong_tien_giam' => $discount,
            'tong_tien_thue' => $tax,
            'tong_thanh_toan' => $total,
            'quoc_gia_thanh_toan' => $country,
        ]);
    }

    public static function listForUser(int $userId): array {
        $sql = "SELECT * FROM " . self::$table . " WHERE nguoi_mua_id = :uid ORDER BY ngay_dat_hang DESC";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':uid' => $userId]);
        return $stmt->fetchAll();
    }
}