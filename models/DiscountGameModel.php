<?php
// =============================================================================
// DISCOUNT GAME MODEL - Table: tro_choi_giam_gia
// =============================================================================

class DiscountGameModel extends Model {
    protected static $table = 'tro_choi_giam_gia';

    public static function add(int $campaignId, int $gameId): bool {
        return self::insertRow(['chien_dich_id' => $campaignId, 'tro_choi_id' => $gameId]);
    }
}