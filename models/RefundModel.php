<?php
// =============================================================================
// REFUND MODEL - Table: hoan_tien
// =============================================================================

class RefundModel extends Model {
    protected static $table = 'hoan_tien';

    public static function create(int $paymentId, ?int $orderItemId, ?int $requesterId, float $amount, string $currency, string $reason = ''): int {
        return self::insert([
            'thanh_toan_id' => $paymentId,
            'chi_tiet_don_hang_id' => $orderItemId,
            'nguoi_yeu_cau_id' => $requesterId,
            'so_tien' => $amount,
            'ma_tien_te' => $currency,
            'ly_do' => $reason,
        ]);
    }
}