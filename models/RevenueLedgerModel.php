<?php
// =============================================================================
// REVENUE LEDGER MODEL - Tables: so_ke_toan_tac_gia, dot_chi_tra, chi_tiet_chi_tra,
// tai_khoan_nhan_tien_nguoi_dung
// pending (refund window) -> available -> held (in a payout) -> paid
//                                       \-> reversed (refund)
// =============================================================================

class RevenueLedgerModel extends Model {
    protected static $table = 'so_ke_toan_tac_gia';

    /** One ledger row per author for an order item. $shares: [authorId => ['amount','percent']]. */
    public static function record(int $orderItemId, array $shares): void {
        foreach ($shares as $authorId => $share) {
            $gross = round((float)$share['amount'], 2);
            $fee = round($gross * PLATFORM_FEE_RATE, 2);
            self::run("INSERT INTO so_ke_toan_tac_gia (chi_tiet_don_hang_id, nguoi_dung_id, phan_tram_huong_doanh_thu, doanh_thu_truoc_phi, phi_nen_tang, thue_da_khau_tru, so_tien_thuc_nhan, ma_tien_te, trang_thai, ngay_co_the_chi_tra)
                VALUES (:oi, :u, :pct, :gross, :fee, 0, :net, :cur, 'pending', NOW() + INTERVAL " . (int)PAYOUT_HOLD_DAYS . " DAY)", [
                ':oi' => $orderItemId, ':u' => (int)$authorId, ':pct' => $share['percent'], ':gross' => $gross,
                ':fee' => $fee, ':net' => round($gross - $fee, 2), ':cur' => APP_CURRENCY,
            ]);
        }
    }

    /** Move rows whose hold period ended to available. */
    public static function releaseDue(?int $userId = null): int {
        $sql = "UPDATE so_ke_toan_tac_gia SET trang_thai = 'available' WHERE trang_thai = 'pending' AND ngay_co_the_chi_tra <= NOW()";
        $params = [];
        if ($userId) {
            $sql .= ' AND nguoi_dung_id = :u';
            $params[':u'] = $userId;
        }
        return self::run($sql, $params);
    }

    /** Reverse the ledger of a refunded order item. Throws when money already left. */
    public static function reverse(int $orderItemId): void {
        $locked = (int)self::scalar("SELECT COUNT(*) FROM so_ke_toan_tac_gia WHERE chi_tiet_don_hang_id = :oi AND trang_thai IN ('held','paid')", [':oi' => $orderItemId]);
        if ($locked > 0) {
            throw new RuntimeException('Doanh thu của mục này đã được đưa vào đợt chi trả cho nhà phát triển, không thể hoàn tự động.');
        }
        self::run("UPDATE so_ke_toan_tac_gia SET trang_thai = 'reversed' WHERE chi_tiet_don_hang_id = :oi AND trang_thai IN ('pending','available')", [':oi' => $orderItemId]);
    }

    /** Balance per status for one developer. */
    public static function balances(int $userId): array {
        self::releaseDue($userId);
        $out = ['pending' => 0.0, 'available' => 0.0, 'held' => 0.0, 'paid' => 0.0, 'reversed' => 0.0, 'gross' => 0.0, 'fee' => 0.0];
        foreach (self::query('SELECT trang_thai, SUM(so_tien_thuc_nhan) net, SUM(doanh_thu_truoc_phi) gross, SUM(phi_nen_tang) fee FROM so_ke_toan_tac_gia WHERE nguoi_dung_id = :u GROUP BY trang_thai', [':u' => $userId]) as $row) {
            $out[$row['trang_thai']] = (float)$row['net'];
            if ($row['trang_thai'] !== 'reversed') {
                $out['gross'] += (float)$row['gross'];
                $out['fee'] += (float)$row['fee'];
            }
        }
        return $out;
    }

    /** Ledger rows for a developer with order and game context. */
    public static function rowsFor(int $userId, string $status = '', int $limit = 50, int $offset = 0): array {
        $where = 'l.nguoi_dung_id = :u';
        $params = [':u' => $userId, ':limit' => $limit, ':offset' => $offset];
        if (in_array($status, ['pending', 'available', 'held', 'paid', 'reversed'], true)) {
            $where .= ' AND l.trang_thai = :s';
            $params[':s'] = $status;
        }
        return self::query("SELECT l.*, i.tieu_de_luc_mua, i.loai_muc, i.tro_choi_id, i.goi_game_id, o.ma_don_hang, o.ngay_dat_hang
            FROM so_ke_toan_tac_gia l JOIN chi_tiet_don_hang i ON i.ma = l.chi_tiet_don_hang_id JOIN don_hang o ON o.ma = i.don_hang_id
            WHERE $where ORDER BY l.ngay_tao DESC, l.ma DESC LIMIT :limit OFFSET :offset", $params);
    }

    public static function countFor(int $userId, string $status = ''): int {
        $where = 'nguoi_dung_id = :u';
        $params = [':u' => $userId];
        if (in_array($status, ['pending', 'available', 'held', 'paid', 'reversed'], true)) {
            $where .= ' AND trang_thai = :s';
            $params[':s'] = $status;
        }
        return (int)self::scalar("SELECT COUNT(*) FROM so_ke_toan_tac_gia WHERE $where", $params);
    }

    /** Sales per game for a developer (gross before fee, excluding reversed rows). */
    public static function salesByGame(int $userId): array {
        return self::query("SELECT COALESCE(i.tro_choi_id, 0) AS tro_choi_id, i.tieu_de_luc_mua, i.loai_muc, COUNT(*) AS so_luot,
                SUM(l.doanh_thu_truoc_phi) AS gop, SUM(l.so_tien_thuc_nhan) AS thuc_nhan
            FROM so_ke_toan_tac_gia l JOIN chi_tiet_don_hang i ON i.ma = l.chi_tiet_don_hang_id
            WHERE l.nguoi_dung_id = :u AND l.trang_thai <> 'reversed'
            GROUP BY COALESCE(i.tro_choi_id, 0), i.tieu_de_luc_mua, i.loai_muc ORDER BY gop DESC", [':u' => $userId]);
    }

    // ------------------------------------------------------------ payouts -----

    public static function accounts(int $userId): array {
        return self::query('SELECT * FROM tai_khoan_nhan_tien_nguoi_dung WHERE nguoi_dung_id = :u ORDER BY mac_dinh DESC, ngay_tao DESC', [':u' => $userId]);
    }

    public static function payouts(int $userId): array {
        return self::query('SELECT p.*, a.nha_cung_cap, a.ten_tai_khoan, (SELECT COUNT(*) FROM chi_tiet_chi_tra c WHERE c.dot_chi_tra_id = p.ma) AS so_dong
            FROM dot_chi_tra p JOIN tai_khoan_nhan_tien_nguoi_dung a ON a.ma = p.tai_khoan_nhan_tien_id
            WHERE p.nguoi_dung_id = :u ORDER BY p.ngay_yeu_cau DESC', [':u' => $userId]);
    }

    /** Gather every available row into a payout request. Returns the payout id. */
    public static function requestPayout(int $userId): int {
        return self::transaction(function () use ($userId) {
            self::releaseDue($userId);
            $account = self::one("SELECT * FROM tai_khoan_nhan_tien_nguoi_dung WHERE nguoi_dung_id = :u AND trang_thai = 'active' ORDER BY mac_dinh DESC, ma LIMIT 1", [':u' => $userId]);
            if (!$account) {
                throw new RuntimeException('Bạn cần một tài khoản nhận tiền đã được xác minh.');
            }
            $open = (int)self::scalar("SELECT COUNT(*) FROM dot_chi_tra WHERE nguoi_dung_id = :u AND trang_thai IN ('requested','processing')", [':u' => $userId]);
            if ($open > 0) {
                throw new RuntimeException('Bạn đang có một yêu cầu chi trả chưa xử lý xong.');
            }
            $rows = self::query("SELECT ma, so_tien_thuc_nhan FROM so_ke_toan_tac_gia WHERE nguoi_dung_id = :u AND trang_thai = 'available' FOR UPDATE", [':u' => $userId]);
            $total = round(array_sum(array_map('floatval', array_column($rows, 'so_tien_thuc_nhan'))), 2);
            if ($total <= 0) {
                throw new RuntimeException('Chưa có khoản nào có thể rút.');
            }
            self::run("INSERT INTO dot_chi_tra (nguoi_dung_id, tai_khoan_nhan_tien_id, so_tien, ma_tien_te, trang_thai) VALUES (:u, :a, :s, :c, 'requested')",
                [':u' => $userId, ':a' => (int)$account['ma'], ':s' => $total, ':c' => APP_CURRENCY]);
            $payoutId = self::lastId();
            foreach ($rows as $row) {
                self::run('INSERT INTO chi_tiet_chi_tra (dot_chi_tra_id, so_ke_toan_id, so_tien) VALUES (:p, :l, :s)', [':p' => $payoutId, ':l' => (int)$row['ma'], ':s' => $row['so_tien_thuc_nhan']]);
                self::run("UPDATE so_ke_toan_tac_gia SET trang_thai = 'held' WHERE ma = :l", [':l' => (int)$row['ma']]);
            }
            return $payoutId;
        });
    }

    /** Admin decision on a payout: processing, paid, failed or cancelled. */
    public static function decidePayout(int $payoutId, string $status, string $reference, string $reason): void {
        self::transaction(function () use ($payoutId, $status, $reference, $reason) {
            $payout = self::one('SELECT * FROM dot_chi_tra WHERE ma = :id FOR UPDATE', [':id' => $payoutId]);
            if (!$payout || !in_array($payout['trang_thai'], ['requested', 'processing'], true)) {
                throw new RuntimeException('Đợt chi trả này đã được xử lý.');
            }
            $ledgerIds = 'SELECT so_ke_toan_id FROM chi_tiet_chi_tra WHERE dot_chi_tra_id = :id';
            if ($status === 'processing') {
                self::run("UPDATE dot_chi_tra SET trang_thai = 'processing' WHERE ma = :id", [':id' => $payoutId]);
                return;
            }
            if ($status === 'paid') {
                self::run("UPDATE dot_chi_tra SET trang_thai = 'paid', ma_chi_tra_nha_cung_cap = :ref, ngay_xu_ly = NOW() WHERE ma = :id", [':ref' => $reference ?: null, ':id' => $payoutId]);
                self::run("UPDATE so_ke_toan_tac_gia SET trang_thai = 'paid' WHERE ma IN ($ledgerIds)", [':id' => $payoutId]);
            } elseif ($status === 'failed' || $status === 'cancelled') {
                self::run('UPDATE dot_chi_tra SET trang_thai = :s, ly_do_that_bai = :r, ngay_xu_ly = NOW() WHERE ma = :id', [':s' => $status, ':r' => $reason ?: null, ':id' => $payoutId]);
                self::run("UPDATE so_ke_toan_tac_gia SET trang_thai = 'available' WHERE ma IN ($ledgerIds) AND trang_thai = 'held'", [':id' => $payoutId]);
            } else {
                throw new RuntimeException('Trạng thái không hợp lệ.');
            }
            NotificationModel::create((int)$payout['nguoi_dung_id'], 'payout', 'Đợt chi trả ' . money($payout['so_tien']) . ': ' . label('payout_status', $status),
                $reason, '/dev/payouts');
        });
    }
}
