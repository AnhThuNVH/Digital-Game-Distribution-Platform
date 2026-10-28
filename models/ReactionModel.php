<?php
// =============================================================================
// REACTION MODEL - Table: tuong_tac_bai_viet
// =============================================================================

class ReactionModel extends Model {
    protected static $table = 'tuong_tac_bai_viet';

    public static function react(int $postId, int $userId, string $reaction = 'like'): bool {
        return self::insertRow([
            'bai_viet_id' => $postId,
            'nguoi_dung_id' => $userId,
            'phan_ung' => $reaction,
        ]);
    }
}