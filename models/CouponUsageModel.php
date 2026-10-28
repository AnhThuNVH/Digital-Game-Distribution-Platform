<?php
// =============================================================================
// COUPON USAGE MODEL - Table: luot_dung_ma_giam_gia
// =============================================================================

class CouponUsageModel extends Model {
    protected static $table = 'luot_dung_ma_giam_gia';

    public static function record(int $couponId, int $orderId, int $userId, float $discountAmount): int {
        return self::insert([
            'ma_giam_gia_id' => $couponId,
            'don_hang_id' => $orderId,
            'nguoi_dung_id' => $userId,
            'so_tien_giam' => $discountAmount,
        ]);
    }
}