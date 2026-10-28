<?php
// =============================================================================
// VOTE MODEL - Table: binh_chon_danh_gia
// =============================================================================

class VoteModel extends Model {
    protected static $table = 'binh_chon_danh_gia';

    public static function vote(int $reviewId, int $userId, bool $helpful): bool {
        return self::insertRow([
            'danh_gia_id' => $reviewId,
            'nguoi_dung_id' => $userId,
            'co_ich' => $helpful,
        ]);
    }
}