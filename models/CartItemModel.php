<?php
// =============================================================================
// CART ITEM MODEL - Table: muc_gio_hang
// =============================================================================

class CartItemModel extends Model {
    protected static $table = 'muc_gio_hang';

    public static function add(int $cartId, string $type, ?int $gameId, ?int $bundleId): int {
        $sql = "INSERT INTO " . self::$table . "
                    (gio_hang_id, loai_muc, tro_choi_id, goi_game_id)
                VALUES (:cart_id, :type, :game_id, :bundle_id)
                ON DUPLICATE KEY UPDATE ma = LAST_INSERT_ID(ma)";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([
            ':cart_id' => $cartId,
            ':type' => $type,
            ':game_id' => $gameId,
            ':bundle_id' => $bundleId,
        ]);
        return (int)self::db()->lastInsertId();
    }

    public static function listForCart(int $cartId): array {
        $sql = "SELECT i.*, COALESCE(g.tieu_de, b.tieu_de) AS tieu_de,
                       COALESCE(g.gia_toi_thieu, b.gia) AS gia,
                       g.mo_hinh_gia,
                       COALESCE(g.ma_tien_te, b.ma_tien_te) AS ma_tien_te
                FROM " . self::$table . " i
                LEFT JOIN tro_choi g ON g.ma = i.tro_choi_id
                LEFT JOIN goi_game b ON b.ma = i.goi_game_id
                WHERE i.gio_hang_id = :cart
                ORDER BY i.ngay_them DESC";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':cart' => $cartId]);
        return $stmt->fetchAll();
    }

    public static function listGamesForCheckout(int $cartId): array {
        $sql = "SELECT i.ma AS cart_item_id, i.loai_muc, g.ma AS game_id, g.tieu_de,
                       g.trang_thai, g.mo_hinh_gia, g.gia_toi_thieu, g.ma_tien_te
                FROM " . self::$table . " i
                INNER JOIN tro_choi g ON g.ma = i.tro_choi_id
                WHERE i.gio_hang_id = :cart AND i.loai_muc = 'game'
                ORDER BY i.ma
                FOR UPDATE";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':cart' => $cartId]);
        return $stmt->fetchAll();
    }

    public static function countForCart(int $cartId): int {
        $stmt = self::db()->prepare('SELECT COUNT(*) FROM ' . self::$table . ' WHERE gio_hang_id = :cart');
        $stmt->execute([':cart' => $cartId]);
        return (int)$stmt->fetchColumn();
    }

    public static function clear(int $cartId): void {
        $stmt = self::db()->prepare('DELETE FROM ' . self::$table . ' WHERE gio_hang_id = :cart');
        $stmt->execute([':cart' => $cartId]);
    }
}