<?php
// =============================================================================
// DEVLOG MODEL - Table: nhat_ky_phat_trien
// Unique key uq_devlog_game_slug (tro_choi_id, duong_dan_rut_gon).
// =============================================================================

class DevlogModel extends Model {
    protected static $table = 'nhat_ky_phat_trien';

    public static function create(int $gameId, int $authorId, string $title, string $slug, string $content, bool $publish = false): int {
        $devlogId = self::insert([
            'tro_choi_id' => $gameId,
            'tac_gia_nguoi_dung_id' => $authorId,
            'tieu_de' => $title,
            'duong_dan_rut_gon' => $slug,
            'noi_dung' => $content,
            'trang_thai' => $publish ? 'published' : 'draft',
            'ngay_cong_bo' => $publish ? date('Y-m-d H:i:s') : null,
        ]);
        if ($publish) {
            self::notifyPublished($gameId, $authorId, $title, $slug);
        }
        return $devlogId;
    }

    /** Tell the game's followers about a newly published post. */
    public static function notifyPublished(int $gameId, int $authorId, string $title, string $slug): void {
        $game = GameModel::find($gameId);
        if ($game && in_array($game['trang_thai'], ['published', 'unlisted'], true)) {
            NotificationModel::notifyGameFollowers(
                $gameId,
                $authorId,
                'game_devlog',
                'Nhật ký phát triển mới',
                $game['tieu_de'] . ': ' . $title,
                '/games/' . rawurlencode($game['duong_dan_rut_gon']) . '/devlogs/' . rawurlencode($slug)
            );
        }
    }

    /** A slug unique within the game, derived from the title. */
    public static function uniqueSlug(int $gameId, string $title): string {
        $base = mb_substr(slugify($title), 0, 200) ?: 'nhat-ky';
        $slug = $base;
        for ($i = 2; self::scalar('SELECT 1 FROM nhat_ky_phat_trien WHERE tro_choi_id = :g AND duong_dan_rut_gon = :s', [':g' => $gameId, ':s' => $slug]); $i++) {
            $slug = $base . '-' . $i;
        }
        return $slug;
    }

    public static function listForGame(int $gameId): array {
        $sql = "SELECT * FROM " . self::$table . " WHERE tro_choi_id = :gid AND trang_thai = 'published' ORDER BY ngay_cong_bo DESC";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':gid' => $gameId]);
        return $stmt->fetchAll();
    }

    public static function findBySlug(string $slug): ?array {
        return self::findBy('duong_dan_rut_gon', $slug);
    }
}
