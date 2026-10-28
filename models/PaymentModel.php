<?php
// =============================================================================
// PAYMENT MODEL - Table: thanh_toan
// =============================================================================

class PaymentModel extends Model {
    protected static $table = 'thanh_toan';

    public static function create(int $orderId, string $provider, string $txId, float $amount, string $currency): int {
        return self::insert([
            'don_hang_id' => $orderId,
            'nha_cung_cap' => $provider,
            'ma_giao_dich_nha_cung_cap' => $txId,
            'so_tien' => $amount,
            'ma_tien_te' => $currency,
        ]);
    }

    public static function updateStatus(int $paymentId, string $status, ?string $response = null): bool {
        $data = ['trang_thai' => $status];
        if ($response) $data['ma_phan_hoi_nha_cung_cap'] = $response;
        if ($status === 'succeeded') $data['ngay_thanh_toan'] = date('Y-m-d H:i:s');
        return self::update($paymentId, $data);
    }
}