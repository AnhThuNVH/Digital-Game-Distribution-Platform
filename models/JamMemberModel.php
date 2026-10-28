<?php
// =============================================================================
// JAM MEMBER MODEL - Table: thanh_vien_cuoc_thi
// =============================================================================

class JamMemberModel extends Model {
    protected static $table = 'thanh_vien_cuoc_thi';

    public static function add(int $jamId, int $userId, string $role = 'moderator'): bool {
        return self::insertRow([
            'cuoc_thi_id' => $jamId,
            'nguoi_dung_id' => $userId,
            'vai_tro_thanh_vien' => $role,
        ]);
    }
}