<?php
// =============================================================================
// PAYOUT ITEM MODEL - Table: chi_tiet_chi_tra
// =============================================================================

class PayoutItemModel extends Model {
    protected static $table = 'chi_tiet_chi_tra';

    public static function add(int $payoutId, int $ledgerId, float $amount): bool {
        return self::insertRow([
            'dot_chi_tra_id' => $payoutId,
            'so_ke_toan_id' => $ledgerId,
            'so_tien' => $amount,
        ]);
    }
}