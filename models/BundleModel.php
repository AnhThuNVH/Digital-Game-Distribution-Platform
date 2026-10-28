<?php
// =============================================================================
// BUNDLE MODEL - Table: goi_game
// =============================================================================

class BundleModel extends Model {
    protected static $table = 'goi_game';

    public static function create(int $creatorId, string $title, string $slug, string $description = '', float $price = 0, string $currency = 'USD'): int {
        return self::insert([
            'nguoi_tao_id' => $creatorId,
            'tieu_de' => $title,
            'duong_dan_rut_gon' => $slug,
            'mo_ta' => $description,
            'gia' => $price,
            'ma_tien_te' => $currency,
        ]);
    }

    public static function getAllPublished(): array {
        return self::findAllBy('trang_thai', 'published');
    }
}