<?php
// =============================================================================
// REVENUE LEDGER MODEL - Table: so_ke_toan_tac_gia
// =============================================================================

class RevenueLedgerModel extends Model {
    protected static $table = 'so_ke_toan_tac_gia';

    public static function create(int $orderItemId, int $userId, float $share, float $revenue, float $fee, float $tax, float $net, string $currency): int {
        return self::insert([
            'chi_tiet_don_hang_id' => $orderItemId,
            'nguoi_dung_id' => $userId,
            'phan_tram_huong_doanh_thu' => $share,
            'doanh_thu_truoc_phi' => $revenue,
            'phi_nen_tang' => $fee,
            'thue_da_khau_tru' => $tax,
            'so_tien_thuc_nhan' => $net,
            'ma_tien_te' => $currency,
        ]);
    }

    public static function listForUser(int $userId): array {
        return self::findAllBy('nguoi_dung_id', $userId);
    }
}