<?php
// =============================================================================
// COUPON MODEL - Table: ma_giam_gia
// =============================================================================

class CouponModel extends Model {
    protected static $table = 'ma_giam_gia';

    public static function create(string $code, string $type, float $value, ?int $maxUses, ?string $start, ?string $end): int {
        return self::insert([
            'ma_uu_dai' => $code,
            'loai_giam_gia' => $type,
            'gia_tri_giam_gia' => $value,
            'so_luot_dung_toi_da' => $maxUses,
            'ngay_bat_dau' => $start,
            'ngay_ket_thuc' => $end,
        ]);
    }

    public static function findByCode(string $code): ?array {
        return self::findBy('ma_uu_dai', $code);
    }
}