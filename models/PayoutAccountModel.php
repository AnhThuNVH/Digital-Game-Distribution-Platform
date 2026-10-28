<?php
// =============================================================================
// PAYOUT ACCOUNT MODEL - Table: tai_khoan_nhan_tien_nguoi_dung
// =============================================================================

class PayoutAccountModel extends Model {
    protected static $table = 'tai_khoan_nhan_tien_nguoi_dung';

    public static function create(int $userId, string $provider, string $accountId, string $accountName, string $currency, bool $default = false): int {
        return self::insert([
            'nguoi_dung_id' => $userId,
            'nha_cung_cap' => $provider,
            'ma_tai_khoan_ben_ngoai' => $accountId,
            'ten_tai_khoan' => $accountName,
            'ma_tien_te' => $currency,
            'mac_dinh' => $default,
        ]);
    }
}