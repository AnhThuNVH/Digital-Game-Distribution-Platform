<?php
// =============================================================================
// REFUND MODEL - Table: hoan_tien (+ so_ke_toan_tac_gia, quyen_so_huu_tro_choi, don_hang)
// A buyer asks for a refund of one order line inside REFUND_WINDOW_DAYS.
// An admin approves (sandbox: completes at once, reverses the developer ledger
// and revokes the games) or rejects it.
// =============================================================================

class RefundModel extends Model {
    protected static $table = 'hoan_tien';
    public const OPEN = ['requested', 'approved', 'processing', 'completed'];

    /** Why this line cannot be refunded, or null when it can. */
    public static function problem(array $order, array $item): ?string {
        if (!in_array($order['trang_thai'], ['paid', 'partially_refunded'], true)) {
            return 'Đơn hàng không ở trạng thái có thể hoàn tiền.';
        }
        if ((float)$item['thanh_tien_dong'] <= 0) {
            return 'Mục miễn phí không cần hoàn tiền.';
        }
        if (!empty($item['refund_status']) && in_array($item['refund_status'], self::OPEN, true)) {
            return 'Mục này đã có yêu cầu hoàn tiền.';
        }
        $paidAt = $order['ngay_thanh_toan'] ?: $order['ngay_dat_hang'];
        if (strtotime($paidAt) < time() - REFUND_WINDOW_DAYS * 86400) {
            return 'Đã quá ' . REFUND_WINDOW_DAYS . ' ngày kể từ khi thanh toán.';
        }
        if (!OrderModel::paidPayment((int)$order['ma'])) {
            return 'Đơn hàng không có giao dịch thanh toán thành công.';
        }
        return null;
    }

    public static function request(array $order, array $item, int $userId, string $reason): int {
        return self::transaction(function () use ($order, $item, $userId, $reason) {
            $open = self::scalar("SELECT 1 FROM hoan_tien WHERE chi_tiet_don_hang_id = :i AND trang_thai IN ('requested','approved','processing','completed') FOR UPDATE", [':i' => (int)$item['ma']]);
            if ($open) {
                throw new RuntimeException('Mục này đã có yêu cầu hoàn tiền.');
            }
            $payment = OrderModel::paidPayment((int)$order['ma']);
            self::run('INSERT INTO hoan_tien (thanh_toan_id, chi_tiet_don_hang_id, nguoi_yeu_cau_id, so_tien, ma_tien_te, ly_do) VALUES (:p, :i, :u, :a, :c, :r)', [
                ':p' => (int)$payment['ma'], ':i' => (int)$item['ma'], ':u' => $userId,
                ':a' => (float)$item['thanh_tien_dong'], ':c' => $item['ma_tien_te'], ':r' => $reason,
            ]);
            return self::lastId();
        });
    }

    public static function findFull(int $id): ?array {
        return self::one('SELECT r.*, i.tieu_de_luc_mua, i.thanh_tien_dong, i.loai_muc, o.ma order_id, o.ma_don_hang, o.nguoi_mua_id, o.tong_thanh_toan,
                u.ten_hien_thi buyer_name, u.ten_dang_nhap buyer_username
            FROM hoan_tien r JOIN thanh_toan p ON p.ma = r.thanh_toan_id JOIN don_hang o ON o.ma = p.don_hang_id
            LEFT JOIN chi_tiet_don_hang i ON i.ma = r.chi_tiet_don_hang_id
            LEFT JOIN nguoi_dung u ON u.ma = r.nguoi_yeu_cau_id WHERE r.ma = :id', [':id' => $id]);
    }

    public static function search(string $status, int $limit, int $offset): array {
        $where = $status !== '' ? 'WHERE r.trang_thai = :s' : '';
        return self::query("SELECT r.*, i.tieu_de_luc_mua, o.ma_don_hang, u.ten_hien_thi buyer_name, u.ten_dang_nhap buyer_username
            FROM hoan_tien r JOIN thanh_toan p ON p.ma = r.thanh_toan_id JOIN don_hang o ON o.ma = p.don_hang_id
            LEFT JOIN chi_tiet_don_hang i ON i.ma = r.chi_tiet_don_hang_id LEFT JOIN nguoi_dung u ON u.ma = r.nguoi_yeu_cau_id
            $where ORDER BY FIELD(r.trang_thai,'requested','processing','approved') DESC, r.ngay_tao DESC LIMIT " . (int)$limit . ' OFFSET ' . (int)$offset,
            $status !== '' ? [':s' => $status] : []);
    }

    public static function searchCount(string $status): int {
        return $status !== ''
            ? (int)self::scalar('SELECT COUNT(*) FROM hoan_tien WHERE trang_thai = :s', [':s' => $status])
            : (int)self::scalar('SELECT COUNT(*) FROM hoan_tien');
    }

    /** Approve or reject a requested refund. Approve completes it in the sandbox. */
    public static function decide(int $id, bool $approve, string $note): array {
        return self::transaction(function () use ($id, $approve, $note) {
            $refund = self::one("SELECT * FROM hoan_tien WHERE ma = :id FOR UPDATE", [':id' => $id]);
            if (!$refund || $refund['trang_thai'] !== 'requested') {
                throw new RuntimeException('Yêu cầu này đã được xử lý.');
            }
            $full = self::findFull($id);
            if (!$approve) {
                self::run("UPDATE hoan_tien SET trang_thai = 'rejected', ngay_xu_ly = NOW() WHERE ma = :id", [':id' => $id]);
                return $full + ['decision' => 'rejected'];
            }
            $itemId = (int)$refund['chi_tiet_don_hang_id'];
            if ($itemId) {
                RevenueLedgerModel::reverse($itemId);
                self::run("UPDATE quyen_so_huu_tro_choi SET trang_thai = 'refunded', ngay_thu_hoi = NOW() WHERE chi_tiet_don_hang_id = :i AND trang_thai = 'active'", [':i' => $itemId]);
            }
            self::run("UPDATE hoan_tien SET trang_thai = 'completed', ngay_xu_ly = NOW() WHERE ma = :id", [':id' => $id]);
            $orderId = (int)$full['order_id'];
            $refunded = (float)self::scalar("SELECT COALESCE(SUM(r.so_tien), 0) FROM hoan_tien r JOIN thanh_toan p ON p.ma = r.thanh_toan_id WHERE p.don_hang_id = :o AND r.trang_thai = 'completed'", [':o' => $orderId]);
            $status = $refunded + 0.005 >= (float)$full['tong_thanh_toan'] ? 'refunded' : 'partially_refunded';
            self::run('UPDATE don_hang SET trang_thai = :s WHERE ma = :o', [':s' => $status, ':o' => $orderId]);
            return $full + ['decision' => 'completed', 'order_status' => $status, 'note' => $note];
        });
    }
}
