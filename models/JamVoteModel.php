<?php
// =============================================================================
// JAM VOTE MODEL - Table: binh_chon_bai_du_thi
// =============================================================================

class JamVoteModel extends Model {
    protected static $table = 'binh_chon_bai_du_thi';

    public static function vote(int $entryId, int $userId, string $criteria = 'overall', int $score = 5, string $comment = ''): bool {
        return self::insertRow([
            'bai_du_thi_id' => $entryId,
            'nguoi_binh_chon_id' => $userId,
            'tieu_chi' => $criteria,
            'diem_so' => $score,
            'binh_luan' => $comment,
        ]);
    }
}