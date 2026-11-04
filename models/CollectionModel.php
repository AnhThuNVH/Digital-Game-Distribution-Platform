<?php
// =============================================================================
// COLLECTION MODEL - Tables: bo_suu_tap, tro_choi_bo_suu_tap
// =============================================================================

class CollectionModel extends Model {
    protected static $table = 'bo_suu_tap';

    public const VISIBILITY = ['public', 'unlisted', 'private'];
    public const LAYOUTS = ['grid', 'list'];

    /** Shared list columns: visible game count and the first visible game's cover. */
    private static function listColumns(): string {
        return "c.*, u.ten_dang_nhap, u.ten_hien_thi, u.url_anh_dai_dien,
            (SELECT COUNT(*) FROM tro_choi_bo_suu_tap i JOIN tro_choi g ON g.ma = i.tro_choi_id
              WHERE i.bo_suu_tap_id = c.ma AND g.trang_thai IN ('published','unlisted')) AS so_game,
            (SELECT m.url_media FROM tro_choi_bo_suu_tap i JOIN tro_choi g ON g.ma = i.tro_choi_id
              JOIN media_tro_choi m ON m.tro_choi_id = g.ma AND m.loai_media IN ('cover','thumbnail','screenshot')
              WHERE i.bo_suu_tap_id = c.ma AND g.trang_thai IN ('published','unlisted')
              ORDER BY i.vi_tri, i.ngay_tao, FIELD(m.loai_media,'cover','thumbnail','screenshot'), m.thu_tu_sap_xep LIMIT 1) AS anh_bia";
    }

    public static function forOwner(int $ownerId): array {
        return self::query('SELECT ' . self::listColumns() . ' FROM bo_suu_tap c JOIN nguoi_dung u ON u.ma = c.nguoi_dung_so_huu_id
            WHERE c.nguoi_dung_so_huu_id = :o ORDER BY c.ngay_cap_nhat DESC', [':o' => $ownerId]);
    }

    /** Public collections that contain at least one visible game. */
    public static function community(int $limit, int $offset = 0): array {
        return self::query('SELECT * FROM (SELECT ' . self::listColumns() . " FROM bo_suu_tap c JOIN nguoi_dung u ON u.ma = c.nguoi_dung_so_huu_id
            WHERE c.pham_vi_hien_thi = 'public' AND u.trang_thai = 'active') x WHERE x.so_game > 0
            ORDER BY x.ngay_cap_nhat DESC LIMIT " . (int)$limit . ' OFFSET ' . (int)$offset);
    }

    public static function countCommunity(): int {
        return (int)self::scalar("SELECT COUNT(*) FROM bo_suu_tap c JOIN nguoi_dung u ON u.ma = c.nguoi_dung_so_huu_id
            WHERE c.pham_vi_hien_thi = 'public' AND u.trang_thai = 'active'
              AND EXISTS (SELECT 1 FROM tro_choi_bo_suu_tap i JOIN tro_choi g ON g.ma = i.tro_choi_id WHERE i.bo_suu_tap_id = c.ma AND g.trang_thai IN ('published','unlisted'))");
    }

    public static function withOwner(int $id): ?array {
        return self::one('SELECT c.*, u.ten_dang_nhap, u.ten_hien_thi, u.url_anh_dai_dien, u.trang_thai AS owner_status
            FROM bo_suu_tap c JOIN nguoi_dung u ON u.ma = c.nguoi_dung_so_huu_id WHERE c.ma = :id', [':id' => $id]);
    }

    /** Visible games in a collection, in collection order, with the curator note. */
    public static function games(int $collectionId): array {
        return self::query('SELECT ' . GameModel::cardColumns() . ', i.ghi_chu, i.vi_tri, i.ngay_tao AS ngay_them
            FROM tro_choi_bo_suu_tap i JOIN tro_choi g ON g.ma = i.tro_choi_id
            WHERE i.bo_suu_tap_id = :c AND g.trang_thai IN (\'published\',\'unlisted\')
            ORDER BY i.vi_tri, i.ngay_tao', [':c' => $collectionId]);
    }

    /** A slug unique for this owner, derived from the title. */
    public static function uniqueSlug(int $ownerId, string $title, int $exceptId = 0): string {
        $base = mb_substr(slugify($title), 0, 180) ?: 'bo-suu-tap';
        $slug = $base;
        for ($n = 2; self::scalar('SELECT 1 FROM bo_suu_tap WHERE nguoi_dung_so_huu_id = :o AND duong_dan_rut_gon = :s AND ma <> :id',
            [':o' => $ownerId, ':s' => $slug, ':id' => $exceptId]); $n++) {
            $slug = $base . '-' . $n;
        }
        return $slug;
    }

    /** Collections of the user, flagged when they already contain the game. */
    public static function pickerFor(int $ownerId, int $gameId): array {
        return self::query('SELECT c.ma, c.tieu_de, c.pham_vi_hien_thi,
                EXISTS (SELECT 1 FROM tro_choi_bo_suu_tap i WHERE i.bo_suu_tap_id = c.ma AND i.tro_choi_id = :g) AS co_game
            FROM bo_suu_tap c WHERE c.nguoi_dung_so_huu_id = :o ORDER BY c.ngay_cap_nhat DESC', [':g' => $gameId, ':o' => $ownerId]);
    }

    /** Add a game, or update its note when it is already there. Returns true when newly added. */
    public static function addGame(int $collectionId, int $gameId, int $userId, ?string $note): bool {
        return self::transaction(function () use ($collectionId, $gameId, $userId, $note) {
            $exists = self::scalar('SELECT 1 FROM tro_choi_bo_suu_tap WHERE bo_suu_tap_id = :c AND tro_choi_id = :g FOR UPDATE', [':c' => $collectionId, ':g' => $gameId]);
            if ($exists) {
                if ($note !== null) {
                    self::run('UPDATE tro_choi_bo_suu_tap SET ghi_chu = :n WHERE bo_suu_tap_id = :c AND tro_choi_id = :g', [':n' => $note !== '' ? $note : null, ':c' => $collectionId, ':g' => $gameId]);
                }
                self::touch($collectionId);
                return false;
            }
            $next = (int)self::scalar('SELECT COALESCE(MAX(vi_tri), 0) + 1 FROM tro_choi_bo_suu_tap WHERE bo_suu_tap_id = :c', [':c' => $collectionId]);
            self::run('INSERT INTO tro_choi_bo_suu_tap (bo_suu_tap_id, tro_choi_id, nguoi_them_id, vi_tri, ghi_chu) VALUES (:c, :g, :u, :p, :n)', [
                ':c' => $collectionId, ':g' => $gameId, ':u' => $userId, ':p' => $next, ':n' => ($note ?? '') !== '' ? $note : null,
            ]);
            self::touch($collectionId);
            return true;
        });
    }

    public static function removeGame(int $collectionId, int $gameId): int {
        $n = self::run('DELETE FROM tro_choi_bo_suu_tap WHERE bo_suu_tap_id = :c AND tro_choi_id = :g', [':c' => $collectionId, ':g' => $gameId]);
        self::touch($collectionId);
        return $n;
    }

    public static function touch(int $collectionId): void {
        self::run('UPDATE bo_suu_tap SET ngay_cap_nhat = NOW() WHERE ma = :c', [':c' => $collectionId]);
    }
}
