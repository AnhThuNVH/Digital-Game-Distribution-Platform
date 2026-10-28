<?php
// =============================================================================
// BUNDLE GAME MODEL - Table: tro_choi_goi_game
// =============================================================================

class BundleGameModel extends Model {
    protected static $table = 'tro_choi_goi_game';

    public static function add(int $bundleId, int $gameId, int $position = 0): bool {
        return self::insertRow([
            'goi_game_id' => $bundleId,
            'tro_choi_id' => $gameId,
            'vi_tri' => $position,
        ]);
    }
}