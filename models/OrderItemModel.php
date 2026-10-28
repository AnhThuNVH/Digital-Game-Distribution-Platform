<?php
// =============================================================================
// ORDER ITEM MODEL - Table: chi_tiet_don_hang
// =============================================================================

class OrderItemModel extends Model {
    protected static $table = 'chi_tiet_don_hang';

    public static function create(int $orderId, string $type, ?int $gameId, ?int $bundleId, ?int $giftTo, string $title, int $qty, float $unitPrice, float $discount, float $tax, float $total, string $currency): int {
        return self::insert([
            'don_hang_id' => $orderId,
            'loai_muc' => $type,
            'tro_choi_id' => $gameId,
            'goi_game_id' => $bundleId,
            'nguoi_nhan_qua_id' => $giftTo,
            'tieu_de_luc_mua' => $title,
            'so_luong' => $qty,
            'don_gia' => $unitPrice,
            'so_tien_giam' => $discount,
            'tien_thue' => $tax,
            'thanh_tien_dong' => $total,
            'ma_tien_te' => $currency,
        ]);
    }
}