<?php
// =============================================================================
// GAME MEDIA MODEL - Table: media_tro_choi
// =============================================================================

class GameMediaModel extends Model {
    protected static $table = 'media_tro_choi';

    public static function add(int $gameId, string $type, string $url, string $caption = '', string $altText = '', int $order = 0): int {
        return self::insert([
            'tro_choi_id' => $gameId,
            'loai_media' => $type,
            'url_media' => $url,
            'chu_thich' => $caption,
            'van_ban_thay_the' => $altText,
            'thu_tu_sap_xep' => $order,
        ]);
    }

    public static function listForGame(int $gameId): array {
        $sql = "SELECT * FROM " . self::$table . " WHERE tro_choi_id = :gid ORDER BY thu_tu_sap_xep ASC, ngay_tao ASC";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':gid' => $gameId]);
        return $stmt->fetchAll();
    }
}