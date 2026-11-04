<?php
// =============================================================================
// DOWNLOAD LINK MODEL - Table: url_tai_tro_choi
// One game can carry many download links (Google Drive, OneDrive, Dropbox,
// MediaFire, MEGA...). A link may target one platform and one release.
// Links are only revealed to users who own the game.
//
// The developer of the game creates links that go live at once (active).
// Links that are still waiting for approval (pending) keep their contributor
// so the developer can decide about them.
// =============================================================================

class DownloadLinkModel extends Model {
    protected static $table = 'url_tai_tro_choi';

    public const PROVIDERS = ['google_drive', 'onedrive', 'dropbox', 'mediafire', 'mega', 'wetransfer', 'github', 'sourceforge', 'itch_io', 'custom'];
    public const PLATFORMS = ['any', 'windows', 'macos', 'linux', 'android'];
    public const STATUSES = ['pending', 'active', 'rejected', 'hidden'];

    /** Host fragments that identify a storage provider automatically. */
    private const PROVIDER_HOSTS = [
        'google_drive' => ['drive.google.com', 'docs.google.com'],
        'onedrive' => ['onedrive.live.com', '1drv.ms', 'sharepoint.com'],
        'dropbox' => ['dropbox.com', 'dropboxusercontent.com'],
        'mediafire' => ['mediafire.com'],
        'mega' => ['mega.nz', 'mega.co.nz'],
        'wetransfer' => ['wetransfer.com'],
        'github' => ['github.com', 'raw.githubusercontent.com', 'objects.githubusercontent.com'],
        'sourceforge' => ['sourceforge.net'],
        'itch_io' => ['itch.io'],
    ];

    /** Insert a download link. */
    public static function add(array $row): int {
        return self::insert([
            'tro_choi_id' => (int)$row['tro_choi_id'],
            'phien_ban_id' => !empty($row['phien_ban_id']) ? (int)$row['phien_ban_id'] : null,
            'nguoi_dong_gop_id' => !empty($row['nguoi_dong_gop_id']) ? (int)$row['nguoi_dong_gop_id'] : null,
            'nha_cung_cap' => $row['nha_cung_cap'] ?? 'custom',
            'ten_hien_thi' => $row['ten_hien_thi'],
            'url_tai' => $row['url_tai'],
            'he_dieu_ke' => $row['he_dieu_ke'] ?? 'any',
            'dung_luong' => $row['dung_luong'] ?? null,
            'ghi_chu' => $row['ghi_chu'] ?? null,
            'trang_thai' => $row['trang_thai'] ?? 'active',
            'thu_tu_sap_xep' => (int)($row['thu_tu_sap_xep'] ?? 0),
        ]);
    }

    /**
     * Every link of a game, developer view.
     * $status narrows the list; '' returns all of them.
     */
    public static function listForGame(int $gameId, string $status = ''): array {
        $sql = 'SELECT d.*, r.ten_phien_ban, r.kenh_phat_hanh, u.ten_hien_thi AS nguoi_dong_gop
                FROM url_tai_tro_choi d
                LEFT JOIN phien_ban_phat_hanh r ON r.ma = d.phien_ban_id
                LEFT JOIN nguoi_dung u ON u.ma = d.nguoi_dong_gop_id
                WHERE d.tro_choi_id = :g';
        $args = [':g' => $gameId];
        if ($status !== '') {
            $sql .= ' AND d.trang_thai = :s';
            $args[':s'] = $status;
        }
        $sql .= ' ORDER BY FIELD(d.trang_thai, \'pending\', \'active\', \'hidden\', \'rejected\'), d.thu_tu_sap_xep ASC, d.ma ASC';
        return self::query($sql, $args);
    }

    /** Links a player may see: the approved ones only, no URL. */
    public static function listPublic(int $gameId): array {
        return self::query(
            "SELECT d.ma, d.nha_cung_cap, d.ten_hien_thi, d.he_dieu_ke, d.dung_luong, d.ghi_chu, d.thu_tu_sap_xep,
                    d.phien_ban_id, r.ten_phien_ban, r.kenh_phat_hanh
             FROM url_tai_tro_choi d
             LEFT JOIN phien_ban_phat_hanh r ON r.ma = d.phien_ban_id
             WHERE d.tro_choi_id = :g AND d.trang_thai = 'active'
             ORDER BY d.thu_tu_sap_xep ASC, d.ma ASC",
            [':g' => $gameId]
        );
    }

    /** One link of a game. */
    public static function findForGame(int $id, int $gameId): ?array {
        return self::one('SELECT * FROM url_tai_tro_choi WHERE ma = :id AND tro_choi_id = :g', [':id' => $id, ':g' => $gameId]);
    }

    /** Is this URL already listed for the game? */
    public static function urlTaken(int $gameId, string $url, int $exceptId = 0): bool {
        return (bool)self::scalar('SELECT 1 FROM url_tai_tro_choi WHERE tro_choi_id = :g AND url_tai = :u AND ma <> :x LIMIT 1',
            [':g' => $gameId, ':u' => $url, ':x' => $exceptId]);
    }

    /** Update the writable columns of a link. */
    public static function updateLink(int $id, array $data): bool {
        if (empty($data)) {
            return false;
        }
        $sets = [];
        foreach (array_keys($data) as $col) {
            $sets[] = self::ident($col) . ' = :' . $col;
        }
        $params = [];
        foreach ($data as $key => $value) {
            $params[':' . $key] = $value;
        }
        $params[':id'] = $id;
        return self::db()->prepare('UPDATE ' . self::$table . ' SET ' . implode(', ', $sets) . ' WHERE ma = :id')->execute($params);
    }

    /** Count the download and move the counter up. */
    public static function countDownload(int $id): void {
        self::run('UPDATE url_tai_tro_choi SET so_lan_tai = so_lan_tai + 1 WHERE ma = :id', [':id' => $id]);
    }

    /** Guess the provider from the URL host. Returns null when nothing matches. */
    public static function detectProvider(string $url): ?string {
        $host = strtolower((string)parse_url($url, PHP_URL_HOST));
        if ($host === '') {
            return null;
        }
        foreach (self::PROVIDER_HOSTS as $provider => $needles) {
            foreach ($needles as $needle) {
                if ($host === $needle || str_ends_with($host, '.' . $needle)) {
                    return $provider;
                }
            }
        }
        return null;
    }

    /** Public label of a provider. */
    public static function providerName(string $provider): string {
        return [
            'google_drive' => 'Google Drive',
            'onedrive' => 'OneDrive',
            'dropbox' => 'Dropbox',
            'mediafire' => 'MediaFire',
            'mega' => 'MEGA',
            'wetransfer' => 'WeTransfer',
            'github' => 'GitHub',
            'sourceforge' => 'SourceForge',
            'itch_io' => 'itch.io',
            'custom' => 'Liên kết khác',
        ][$provider] ?? 'Liên kết khác';
    }

    /** Short name of a platform. */
    public static function platformName(string $platform): string {
        return [
            'any' => 'Mọi nền tảng',
            'windows' => 'Windows',
            'macos' => 'macOS',
            'linux' => 'Linux',
            'android' => 'Android',
        ][$platform] ?? 'Mọi nền tảng';
    }
}
