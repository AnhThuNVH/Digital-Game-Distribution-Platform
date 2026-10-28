<?php
// =============================================================================
// CART MODEL - Table: gio_hang
// =============================================================================

class CartModel extends Model {
    protected static $table = 'gio_hang';

    public static function getOrCreate(int $userId): array {
        $cart = self::findBy('nguoi_dung_id', $userId);
        if ($cart) return $cart;
        $id = self::insert([
            'nguoi_dung_id' => $userId,
            'ma_tien_te' => 'USD',
        ]);
        return self::find($id);
    }
}