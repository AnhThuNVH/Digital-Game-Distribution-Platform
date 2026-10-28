<?php
// =============================================================================
// AUDIT LOG MODEL - Table: nhat_ky_he_thong
// =============================================================================

class AuditLogModel extends Model {
    protected static $table = 'nhat_ky_he_thong';

    public static function log(?int $userId, string $action, ?string $entityType, ?int $entityId, ?string $ip, ?string $userAgent, ?string $extra = null): int {
        return self::insert([
            'nguoi_dung_id' => $userId,
            'ma_hanh_dong' => $action,
            'loai_thuc_the' => $entityType,
            'thuc_the_id' => $entityId,
            'dia_chi_ip' => $ip,
            'trinh_duyet_nguoi_dung' => $userAgent,
            'du_lieu_bo_sung' => $extra,
        ]);
    }
}