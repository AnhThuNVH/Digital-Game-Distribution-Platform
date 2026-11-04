<?php
// =============================================================================
// RELEASE MODEL - Table: phien_ban_phat_hanh
// Unique key uq_game_release_version (tro_choi_id, ten_phien_ban, kenh_phat_hanh).
// =============================================================================

class ReleaseModel extends Model {
    protected static $table = 'phien_ban_phat_hanh';

    /** Insert a release; followers are notified only when it is public and already out. */
    public static function create(int $gameId, string $version, string $channel, string $notes, int $creatorId, bool $public = true, ?string $releasedAt = null): int {
        $releasedAt = $releasedAt ?? date('Y-m-d H:i:s');
        $releaseId = self::insert([
            'tro_choi_id' => $gameId,
            'ten_phien_ban' => $version,
            'kenh_phat_hanh' => $channel,
            'ghi_chu_phat_hanh' => $notes !== '' ? $notes : null,
            'cong_khai' => $public ? 1 : 0,
            'nguoi_tao_id' => $creatorId,
            'ngay_phat_hanh' => $releasedAt,
        ]);
        $game = GameModel::find($gameId);
        if ($game && $public && strtotime($releasedAt) <= time() && in_array($game['trang_thai'], ['published', 'unlisted'], true)) {
            NotificationModel::notifyGameFollowers(
                $gameId,
                $creatorId,
                'game_release',
                'Có phiên bản game mới',
                $game['tieu_de'] . ' vừa phát hành phiên bản ' . $version . '.',
                '/games/' . rawurlencode($game['duong_dan_rut_gon'])
            );
        }
        return $releaseId;
    }

    /** Every release of a game, public or not, newest first (developer view). */
    public static function listForGame(int $gameId): array {
        return self::query('SELECT r.*, u.ten_hien_thi FROM phien_ban_phat_hanh r JOIN nguoi_dung u ON u.ma = r.nguoi_tao_id
            WHERE r.tro_choi_id = :gid ORDER BY r.ngay_phat_hanh DESC, r.ma DESC', [':gid' => $gameId]);
    }

    /** Is (version, channel) taken by another release of the game? */
    public static function versionTaken(int $gameId, string $version, string $channel, int $exceptId = 0): bool {
        return (bool)self::scalar('SELECT 1 FROM phien_ban_phat_hanh WHERE tro_choi_id = :g AND ten_phien_ban = :v AND kenh_phat_hanh = :c AND ma <> :x LIMIT 1',
            [':g' => $gameId, ':v' => $version, ':c' => $channel, ':x' => $exceptId]);
    }
}
