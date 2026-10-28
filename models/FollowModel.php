<?php
// =============================================================================
// FOLLOW MODEL - Table: theo_doi_nguoi_dung
// =============================================================================

class FollowModel extends Model {
    protected static $table = 'theo_doi_nguoi_dung';

    public static function follow(int $followerId, int $targetId): bool {
        if ($followerId === $targetId) return false;
        return self::insertRow([
            'nguoi_theo_doi_id' => $followerId,
            'nguoi_duoc_theo_doi_id' => $targetId,
        ]);
    }

    public static function unfollow(int $followerId, int $targetId): bool {
        $stmt = self::db()->prepare("DELETE FROM " . self::$table . " WHERE nguoi_theo_doi_id = :f AND nguoi_duoc_theo_doi_id = :t");
        return $stmt->execute([':f' => $followerId, ':t' => $targetId]);
    }

    public static function isFollowing(int $followerId, int $targetId): bool {
        $stmt = self::db()->prepare("SELECT 1 FROM " . self::$table . " WHERE nguoi_theo_doi_id = :f AND nguoi_duoc_theo_doi_id = :t LIMIT 1");
        $stmt->execute([':f' => $followerId, ':t' => $targetId]);
        return $stmt->fetch() !== false;
    }
}