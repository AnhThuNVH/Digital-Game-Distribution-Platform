<?php
// =============================================================================
// GAME SETTINGS MODEL - Table: cai_dat_trang_tro_choi
// =============================================================================

class GameSettingsModel extends Model {
    protected static $table = 'cai_dat_trang_tro_choi';
    protected static $pk = 'tro_choi_id';

    public static function createDefault(int $gameId): bool {
        return self::insertRow([
            'tro_choi_id' => $gameId,
            'bo_cuc_trang' => 'default',
            'bat_cong_dong' => true,
            'hien_thi_nha_sang_tao' => true,
        ]);
    }
}