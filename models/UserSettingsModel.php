<?php
// =============================================================================
// USER SETTINGS MODEL - Table: cai_dat_nguoi_dung
// =============================================================================

class UserSettingsModel extends Model {
    protected static $table = 'cai_dat_nguoi_dung';
    protected static $pk = 'nguoi_dung_id';

    public static function createDefault(int $userId): bool {
        return self::insertRow([
            'nguoi_dung_id' => $userId,
            'pham_vi_hien_thi_ho_so' => 'public',
            'hien_thi_game_so_huu' => true,
            'cho_phep_nhan_tin' => true,
            'email_cap_nhat_san_pham' => true,
            'email_cap_nhat_cong_dong' => true,
            'ngon_ngu_uu_tien' => 'vi',
            'tien_te_uu_tien' => 'VND',
        ]);
    }
}