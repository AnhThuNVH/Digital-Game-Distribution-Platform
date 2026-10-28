<?php
// =============================================================================
// COLLECTION MODEL - Table: bo_suu_tap
// =============================================================================

class CollectionModel extends Model {
    protected static $table = 'bo_suu_tap';

    public static function create(int $ownerId, string $title, string $slug, string $description = '', string $visibility = 'public', string $layout = 'grid'): int {
        return self::insert([
            'nguoi_dung_so_huu_id' => $ownerId,
            'tieu_de' => $title,
            'duong_dan_rut_gon' => $slug,
            'mo_ta' => $description,
            'pham_vi_hien_thi' => $visibility,
            'bo_cuc' => $layout,
        ]);
    }

    public static function listPublic(int $limit = 20): array {
        $sql = "SELECT * FROM " . self::$table . " WHERE pham_vi_hien_thi = 'public' ORDER BY ngay_tao DESC LIMIT :limit";
        $stmt = self::db()->prepare($sql);
        $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll();
    }

    public static function listForOwner(int $ownerId): array {
        return self::findAllBy('nguoi_dung_so_huu_id', $ownerId);
    }
}