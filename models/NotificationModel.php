<?php
// =============================================================================
// NOTIFICATION MODEL - Table: thong_bao
// =============================================================================

class NotificationModel extends Model {
    protected static $table = 'thong_bao';

    public static function create(int $userId, string $type, string $title, string $content = '', string $url = ''): int {
        return self::insert([
            'nguoi_dung_id' => $userId,
            'loai_thong_bao' => $type,
            'tieu_de' => $title,
            'noi_dung_thong_bao' => $content,
            'url_dich' => $url,
        ]);
    }

    public static function markRead(int $notificationId): bool {
        $stmt = self::db()->prepare("UPDATE " . self::$table . " SET da_doc = TRUE, ngay_doc = NOW() WHERE ma = :id");
        return $stmt->execute([':id' => $notificationId]);
    }

    public static function listForUser(int $userId, int $limit = 20): array {
        $stmt = self::db()->prepare("SELECT * FROM " . self::$table . " WHERE nguoi_dung_id = :uid ORDER BY ngay_tao DESC LIMIT :limit");
        $stmt->bindValue(':uid', $userId, PDO::PARAM_INT);
        $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll();
    }

    public static function unreadCount(int $userId): int {
        return self::count('nguoi_dung_id = :uid AND da_doc = FALSE', [':uid' => $userId]);
    }
}