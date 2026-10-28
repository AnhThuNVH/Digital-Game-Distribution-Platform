<?php
// =============================================================================
// REVIEW MODEL - Table: danh_gia
// =============================================================================

class ReviewModel extends Model {
    protected static $table = 'danh_gia';

    public static function create(int $gameId, int $userId, int $rating, string $title = '', string $content = '', bool $verified = false): int {
        return self::insert([
            'tro_choi_id' => $gameId,
            'nguoi_dung_id' => $userId,
            'diem_danh_gia' => $rating,
            'tieu_de' => $title,
            'noi_dung_danh_gia' => $content,
            'da_xac_minh_so_huu' => $verified,
        ]);
    }

    public static function listForGame(int $gameId): array {
        $sql = "SELECT r.*, u.ten_hien_thi, u.url_anh_dai_dien
                FROM " . self::$table . " r
                INNER JOIN nguoi_dung u ON u.ma = r.nguoi_dung_id
                WHERE r.tro_choi_id = :gid AND r.trang_thai = 'published'
                ORDER BY r.ngay_tao DESC";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':gid' => $gameId]);
        return $stmt->fetchAll();
    }

    public static function averageRating(int $gameId): array {
        $sql = "SELECT AVG(diem_danh_gia) AS avg_rating, COUNT(*) AS count
                FROM " . self::$table . " WHERE tro_choi_id = :gid AND trang_thai = 'published'";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':gid' => $gameId]);
        return $stmt->fetch();
    }
}