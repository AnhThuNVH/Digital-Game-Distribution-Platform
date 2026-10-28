<?php
// =============================================================================
// MODERATION ACTION MODEL - Table: hanh_dong_kiem_duyet
// =============================================================================

class ModerationActionModel extends Model {
    protected static $table = 'hanh_dong_kiem_duyet';

    public static function log(int $moderatorId, string $type, int $objectId, string $action, string $reason = ''): int {
        return self::insert([
            'nguoi_kiem_duyet_id' => $moderatorId,
            'loai_doi_tuong' => $type,
            'doi_tuong_id' => $objectId,
            'loai_hanh_dong' => $action,
            'ly_do' => $reason,
        ]);
    }
}