<?php
// =============================================================================
// ORDER MODEL - Tables: don_hang, chi_tiet_don_hang, thanh_toan, luot_dung_ma_giam_gia
// Orders are written by CartModel::checkout; this model only reads them.
// =============================================================================

class OrderModel extends Model {
    protected static $table = 'don_hang';

    public static function listForUser(int $userId, string $status = ''): array {
        $sql = 'SELECT o.*, (SELECT COUNT(*) FROM chi_tiet_don_hang i WHERE i.don_hang_id = o.ma) item_count,
                (SELECT GROUP_CONCAT(i.tieu_de_luc_mua ORDER BY i.ma SEPARATOR \', \') FROM chi_tiet_don_hang i WHERE i.don_hang_id = o.ma) titles
            FROM don_hang o WHERE o.nguoi_mua_id = :uid';
        $params = [':uid' => $userId];
        if ($status !== '') {
            $sql .= ' AND o.trang_thai = :s';
            $params[':s'] = $status;
        }
        return self::query($sql . ' ORDER BY o.ngay_dat_hang DESC, o.ma DESC', $params);
    }

    public static function findByCode(string $code): ?array {
        return self::one('SELECT o.*, u.ten_hien_thi buyer_name, u.ten_dang_nhap buyer_username, u.email buyer_email
            FROM don_hang o JOIN nguoi_dung u ON u.ma = o.nguoi_mua_id WHERE o.ma_don_hang = :c', [':c' => $code]);
    }

    /** Order lines with the game/bundle they point to and the latest refund on each line. */
    public static function items(int $orderId): array {
        return self::query("SELECT i.*, g.duong_dan_rut_gon game_slug, b.duong_dan_rut_gon bundle_slug,
                r.ma refund_id, r.trang_thai refund_status, r.so_tien refund_amount, r.ngay_tao refund_date
            FROM chi_tiet_don_hang i
            LEFT JOIN tro_choi g ON g.ma = i.tro_choi_id
            LEFT JOIN goi_game b ON b.ma = i.goi_game_id
            LEFT JOIN hoan_tien r ON r.ma = (SELECT MAX(r2.ma) FROM hoan_tien r2 WHERE r2.chi_tiet_don_hang_id = i.ma)
            WHERE i.don_hang_id = :o ORDER BY i.ma", [':o' => $orderId]);
    }

    public static function payments(int $orderId): array {
        return self::query('SELECT * FROM thanh_toan WHERE don_hang_id = :o ORDER BY ma', [':o' => $orderId]);
    }

    /** The payment a refund is charged against: the latest succeeded one. */
    public static function paidPayment(int $orderId): ?array {
        return self::one("SELECT * FROM thanh_toan WHERE don_hang_id = :o AND trang_thai = 'succeeded' ORDER BY ma DESC LIMIT 1", [':o' => $orderId]);
    }

    public static function refunds(int $orderId): array {
        return self::query('SELECT r.*, i.tieu_de_luc_mua FROM hoan_tien r JOIN thanh_toan p ON p.ma = r.thanh_toan_id
            LEFT JOIN chi_tiet_don_hang i ON i.ma = r.chi_tiet_don_hang_id WHERE p.don_hang_id = :o ORDER BY r.ma', [':o' => $orderId]);
    }

    public static function couponUse(int $orderId): ?array {
        return self::one('SELECT l.so_tien_giam, c.ma_uu_dai FROM luot_dung_ma_giam_gia l JOIN ma_giam_gia c ON c.ma = l.ma_giam_gia_id WHERE l.don_hang_id = :o LIMIT 1', [':o' => $orderId]);
    }

    /** Admin list with buyer info. */
    public static function search(string $q, string $status, int $limit, int $offset): array {
        [$where, $params] = self::filters($q, $status);
        return self::query("SELECT o.*, u.ten_hien_thi buyer_name, u.ten_dang_nhap buyer_username,
                (SELECT COUNT(*) FROM chi_tiet_don_hang i WHERE i.don_hang_id = o.ma) item_count
            FROM don_hang o JOIN nguoi_dung u ON u.ma = o.nguoi_mua_id $where
            ORDER BY o.ngay_dat_hang DESC, o.ma DESC LIMIT " . (int)$limit . ' OFFSET ' . (int)$offset, $params);
    }

    public static function searchCount(string $q, string $status): int {
        [$where, $params] = self::filters($q, $status);
        return (int)self::scalar("SELECT COUNT(*) FROM don_hang o JOIN nguoi_dung u ON u.ma = o.nguoi_mua_id $where", $params);
    }

    private static function filters(string $q, string $status): array {
        $where = [];
        $params = [];
        if ($q !== '') {
            $where[] = '(o.ma_don_hang LIKE :q1 OR u.ten_dang_nhap LIKE :q2 OR u.email LIKE :q3)';
            $params[':q1'] = $params[':q2'] = $params[':q3'] = '%' . $q . '%';
        }
        if ($status !== '') {
            $where[] = 'o.trang_thai = :s';
            $params[':s'] = $status;
        }
        return [$where ? 'WHERE ' . implode(' AND ', $where) : '', $params];
    }
}
