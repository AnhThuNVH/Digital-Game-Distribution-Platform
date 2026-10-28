<?php
// =============================================================================
// PAYOUT REQUEST MODEL - Table: dot_chi_tra
// =============================================================================

class PayoutRequestModel extends Model {
    protected static $table = 'dot_chi_tra';

    public static function create(int $userId, int $accountId, float $amount, string $currency): int {
        return self::insert([
            'nguoi_dung_id' => $userId,
            'tai_khoan_nhan_tien_id' => $accountId,
            'so_tien' => $amount,
            'ma_tien_te' => $currency,
        ]);
    }
}