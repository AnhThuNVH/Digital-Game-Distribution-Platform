<?php
// =============================================================================
// OWNERSHIP MODEL - Table: quyen_so_huu_tro_choi
// =============================================================================

class OwnershipModel extends Model {
    protected static $table = 'quyen_so_huu_tro_choi';

    /** Grant (or re-activate) ownership. Returns true when the user did not own it before. */
    public static function grant(int $userId, int $gameId, string $type, ?int $orderItemId = null): bool {
        $existing = self::one('SELECT ma, trang_thai FROM quyen_so_huu_tro_choi WHERE nguoi_dung_id = :u AND tro_choi_id = :g FOR UPDATE', [':u' => $userId, ':g' => $gameId]);
        if ($existing && $existing['trang_thai'] === 'active') {
            return false;
        }
        if ($existing) {
            self::run("UPDATE quyen_so_huu_tro_choi SET trang_thai = 'active', ngay_thu_hoi = NULL, loai_nhan_quyen = :t, chi_tiet_don_hang_id = :oi, ngay_nhan_quyen = NOW() WHERE ma = :id",
                [':t' => $type, ':oi' => $orderItemId, ':id' => (int)$existing['ma']]);
            return true;
        }
        self::insert(['nguoi_dung_id' => $userId, 'tro_choi_id' => $gameId, 'loai_nhan_quyen' => $type, 'chi_tiet_don_hang_id' => $orderItemId]);
        return true;
    }

    public static function has(int $userId, int $gameId): bool {
        if ($userId <= 0) return false;
        return (bool)self::scalar("SELECT 1 FROM quyen_so_huu_tro_choi WHERE nguoi_dung_id = :u AND tro_choi_id = :g AND trang_thai = 'active'", [':u' => $userId, ':g' => $gameId]);
    }

    /** Ids of the given games the user owns. */
    public static function ownedIds(int $userId, array $gameIds = []): array {
        if ($userId <= 0) return [];
        $rows = self::column("SELECT tro_choi_id FROM quyen_so_huu_tro_choi WHERE nguoi_dung_id = :u AND trang_thai = 'active'", [':u' => $userId]);
        $rows = array_map('intval', $rows);
        return $gameIds ? array_values(array_intersect($rows, array_map('intval', $gameIds))) : $rows;
    }

    public static function library(int $userId, string $q = '', string $sort = 'recent'): array {
        $params = [':u' => $userId];
        $where = "o.nguoi_dung_id = :u AND o.trang_thai = 'active'";
        if ($q !== '') {
            $where .= ' AND g.tieu_de LIKE :q';
            $params[':q'] = "%$q%";
        }
        $order = $sort === 'title' ? 'g.tieu_de ASC' : 'o.ngay_nhan_quyen DESC';
        return self::query('SELECT ' . GameModel::cardColumns() . ", g.url_choi_ngoai, o.loai_nhan_quyen, o.ngay_nhan_quyen,
                (SELECT r.ten_phien_ban FROM phien_ban_phat_hanh r WHERE r.tro_choi_id = g.ma AND r.cong_khai = 1 AND r.ngay_phat_hanh <= NOW() ORDER BY r.ngay_phat_hanh DESC, r.ma DESC LIMIT 1) AS phien_ban_moi
            FROM quyen_so_huu_tro_choi o JOIN tro_choi g ON g.ma = o.tro_choi_id
            WHERE $where ORDER BY $order", $params);
    }
}
