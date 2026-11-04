<?php
// =============================================================================
// COUPON MODEL - Tables: ma_giam_gia, luot_dung_ma_giam_gia
// A coupon made by an administrator (or with no creator) applies to the whole
// order; a coupon made by a developer applies only to that developer's games.
// =============================================================================

class CouponModel extends Model {
    protected static $table = 'ma_giam_gia';

    public static function findByCode(string $code): ?array {
        return self::one('SELECT * FROM ma_giam_gia WHERE ma_uu_dai = :c LIMIT 1', [':c' => $code]);
    }

    /** Why a coupon can't be used right now, or null when it can. */
    public static function problem(array $coupon): ?string {
        if (!(int)$coupon['dang_hoat_dong']) {
            return 'Mã giảm giá này đã bị tắt.';
        }
        $now = time();
        if ($coupon['ngay_bat_dau'] && strtotime($coupon['ngay_bat_dau']) > $now) {
            return 'Mã giảm giá chưa đến thời gian sử dụng.';
        }
        if ($coupon['ngay_ket_thuc'] && strtotime($coupon['ngay_ket_thuc']) < $now) {
            return 'Mã giảm giá đã hết hạn.';
        }
        if ($coupon['so_luot_dung_toi_da'] !== null && (int)$coupon['so_luot_da_dung'] >= (int)$coupon['so_luot_dung_toi_da']) {
            return 'Mã giảm giá đã hết lượt sử dụng.';
        }
        if ($coupon['loai_giam_gia'] === 'fixed_amount' && !empty($coupon['ma_tien_te']) && $coupon['ma_tien_te'] !== APP_CURRENCY) {
            return 'Mã giảm giá không áp dụng cho đơn vị tiền tệ này.';
        }
        return null;
    }

    /** coupon_state label key for the list view. */
    public static function state(array $coupon): string {
        $now = time();
        return match (true) {
            !(int)$coupon['dang_hoat_dong'] => 'disabled',
            $coupon['ngay_ket_thuc'] && strtotime($coupon['ngay_ket_thuc']) < $now => 'expired',
            $coupon['so_luot_dung_toi_da'] !== null && (int)$coupon['so_luot_da_dung'] >= (int)$coupon['so_luot_dung_toi_da'] => 'used_up',
            $coupon['ngay_bat_dau'] && strtotime($coupon['ngay_bat_dau']) > $now => 'scheduled',
            default => 'active',
        };
    }

    /** Developer id the coupon is limited to, or 0 for a platform-wide coupon. */
    public static function scopeOwner(array $coupon): int {
        $creator = (int)($coupon['nguoi_tao_id'] ?? 0);
        if ($creator <= 0) {
            return 0;
        }
        $isAdmin = (bool)self::scalar(
            "SELECT 1 FROM nguoi_dung_vai_tro x JOIN vai_tro r ON r.ma = x.vai_tro_id WHERE x.nguoi_dung_id = :u AND r.ma_vai_tro = 'admin'",
            [':u' => $creator]
        );
        return $isAdmin ? 0 : $creator;
    }

    /**
     * Spread the coupon over eligible lines.
     * $lines: [key => ['net' => float, 'authors' => int[]]]. Returns [key => discount].
     */
    public static function allocate(array $coupon, array $lines): array {
        $owner = self::scopeOwner($coupon);
        $eligible = [];
        foreach ($lines as $key => $line) {
            if ($line['net'] <= 0) {
                continue;
            }
            if ($owner && !in_array($owner, $line['authors'], true)) {
                continue;
            }
            $eligible[$key] = $line['net'];
        }
        $subtotal = array_sum($eligible);
        if ($subtotal <= 0) {
            return [];
        }
        $value = (float)$coupon['gia_tri_giam_gia'];
        $total = $coupon['loai_giam_gia'] === 'percent'
            ? round($subtotal * min(100, $value) / 100, 2)
            : min($subtotal, round($value, 2));
        $out = [];
        $left = $total;
        $keys = array_keys($eligible);
        foreach ($keys as $i => $key) {
            $share = $i === count($keys) - 1 ? $left : round($total * $eligible[$key] / $subtotal, 2);
            $share = max(0, min($share, $eligible[$key]));
            $out[$key] = $share;
            $left = round($left - $share, 2);
        }
        return $out;
    }

    /** Coupons with usage totals; $creatorId null lists every coupon. */
    public static function listFor(?int $creatorId): array {
        $where = $creatorId === null ? '1=1' : 'c.nguoi_tao_id = :u';
        $params = $creatorId === null ? [] : [':u' => $creatorId];
        return self::query("SELECT c.*, u.ten_hien_thi AS nguoi_tao, u.ten_dang_nhap AS nguoi_tao_dn,
                (c.nguoi_tao_id IS NULL OR EXISTS (SELECT 1 FROM nguoi_dung_vai_tro x JOIN vai_tro r ON r.ma = x.vai_tro_id
                    WHERE x.nguoi_dung_id = c.nguoi_tao_id AND r.ma_vai_tro = 'admin')) AS toan_cua_hang,
                (SELECT COALESCE(SUM(l.so_tien_giam), 0) FROM luot_dung_ma_giam_gia l WHERE l.ma_giam_gia_id = c.ma) AS tong_giam
            FROM ma_giam_gia c LEFT JOIN nguoi_dung u ON u.ma = c.nguoi_tao_id
            WHERE $where ORDER BY c.ngay_tao DESC, c.ma DESC", $params);
    }

    /** Validate the coupon form; returns [data, errors]. */
    public static function fromForm(array $post): array {
        $errors = [];
        $code = strtoupper(trim((string)($post['ma_uu_dai'] ?? '')));
        if (!preg_match('/^[A-Z0-9_-]{4,40}$/', $code)) {
            $errors[] = 'Mã gồm 4–40 ký tự: chữ in hoa không dấu, số, gạch ngang hoặc gạch dưới.';
        }
        $type = (string)($post['loai_giam_gia'] ?? '');
        if (!in_array($type, ['percent', 'fixed_amount'], true)) {
            $errors[] = 'Chọn loại giảm giá.';
        }
        $value = parse_money($post['gia_tri_giam_gia'] ?? '');
        if ($value === null || $value <= 0 || ($type === 'percent' && $value > 100)) {
            $errors[] = $type === 'percent' ? 'Phần trăm giảm phải trong khoảng 0–100.' : 'Số tiền giảm phải lớn hơn 0.';
        }
        $max = trim((string)($post['so_luot_dung_toi_da'] ?? ''));
        if ($max !== '' && (!ctype_digit($max) || (int)$max < 1 || (int)$max > 1000000)) {
            $errors[] = 'Số lượt dùng tối đa phải là số nguyên dương.';
        }
        $start = parse_datetime($post['ngay_bat_dau'] ?? '');
        $end = parse_datetime($post['ngay_ket_thuc'] ?? '');
        if (($post['ngay_bat_dau'] ?? '') !== '' && !$start) $errors[] = 'Ngày bắt đầu không hợp lệ.';
        if (($post['ngay_ket_thuc'] ?? '') !== '' && !$end) $errors[] = 'Ngày kết thúc không hợp lệ.';
        if ($start && $end && strtotime($end) <= strtotime($start)) {
            $errors[] = 'Ngày kết thúc phải sau ngày bắt đầu.';
        }
        if (!$errors && self::findByCode($code)) {
            $errors[] = 'Mã này đã tồn tại.';
        }
        return [[
            'ma_uu_dai' => $code,
            'loai_giam_gia' => $type,
            'gia_tri_giam_gia' => $value,
            'ma_tien_te' => $type === 'fixed_amount' ? APP_CURRENCY : null,
            'so_luot_dung_toi_da' => $max === '' ? null : (int)$max,
            'ngay_bat_dau' => $start,
            'ngay_ket_thuc' => $end,
        ], $errors];
    }
}
