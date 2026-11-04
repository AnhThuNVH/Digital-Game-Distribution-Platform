<?php
// =============================================================================
// HELPERS - escaping, CSRF, flash messages, formatting, input
// =============================================================================

/** Escape a value for HTML text or attribute context. */
function e($value): string {
    return htmlspecialchars((string)($value ?? ''), ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}

/** Escape and keep line breaks. */
function e_multiline($value): string {
    return nl2br(e($value), false);
}

// ---------------------------------------------------------------- CSRF -----

function csrf_token(): string {
    if (empty($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['csrf_token'];
}

function csrf_field(): string {
    return '<input type="hidden" name="csrf_token" value="' . e(csrf_token()) . '">';
}

function csrf_valid(?string $token): bool {
    return is_string($token) && $token !== ''
        && !empty($_SESSION['csrf_token'])
        && hash_equals($_SESSION['csrf_token'], $token);
}

// --------------------------------------------------------------- flash -----

function flash(string $type, string $message): void {
    $_SESSION['flash'][] = ['type' => $type, 'message' => $message];
}

function take_flashes(): array {
    $messages = $_SESSION['flash'] ?? [];
    // Backwards compatibility with the old single-message keys.
    foreach (['success' => 'success', 'error' => 'error'] as $key => $type) {
        if (!empty($_SESSION[$key])) {
            $messages[] = ['type' => $type, 'message' => (string)$_SESSION[$key]];
        }
        unset($_SESSION[$key]);
    }
    unset($_SESSION['flash']);
    return $messages;
}

/** Remember submitted form values for one redirect. */
function remember_input(array $data): void {
    unset($data['csrf_token'], $data['password'], $data['confirm_password'], $data['current_password']);
    $_SESSION['old_input'] = $data;
}

function old(string $key, $default = '') {
    return $_SESSION['old_input_view'][$key] ?? $default;
}

// ---------------------------------------------------------------- auth -----

function current_user(): ?array {
    return $_SESSION['user'] ?? null;
}

function current_user_id(): int {
    return (int)($_SESSION['user']['ma'] ?? 0);
}

function user_roles(): array {
    return $_SESSION['user_roles'] ?? [];
}

function has_role(string $role): bool {
    return in_array($role, user_roles(), true);
}

function is_staff(): bool {
    return has_role('admin') || has_role('moderator');
}

// ---------------------------------------------------------- formatting -----

function money($amount, string $currency = APP_CURRENCY): string {
    $amount = (float)$amount;
    $negative = $amount < 0;
    $formatted = number_format(abs($amount), 2, '.', ',');
    $text = $currency === 'USD' ? '$' . $formatted : $formatted . ' ' . $currency;
    return ($negative ? '−' : '') . $text;
}

function price_label(array $game): string {
    $model = $game['mo_hinh_gia'] ?? 'free';
    $min = (float)($game['gia_toi_thieu'] ?? 0);
    if ($model === 'free') {
        return 'Miễn phí';
    }
    if ($model === 'donation') {
        return 'Miễn phí · ủng hộ tùy ý';
    }
    if ($model === 'pay_what_you_want') {
        return $min > 0 ? 'Từ ' . money($min) : 'Trả tùy ý';
    }
    return money($min);
}

function fmt_date(?string $value): string {
    if (!$value) {
        return '—';
    }
    $ts = strtotime($value);
    return $ts ? date('d/m/Y', $ts) : '—';
}

function fmt_datetime(?string $value): string {
    if (!$value) {
        return '—';
    }
    $ts = strtotime($value);
    return $ts ? date('d/m/Y H:i', $ts) : '—';
}

function time_ago(?string $value): string {
    if (!$value) {
        return '—';
    }
    $ts = strtotime($value);
    if (!$ts) {
        return '—';
    }
    $diff = time() - $ts;
    if ($diff < 60) return 'vừa xong';
    if ($diff < 3600) return floor($diff / 60) . ' phút trước';
    if ($diff < 86400) return floor($diff / 3600) . ' giờ trước';
    if ($diff < 86400 * 30) return floor($diff / 86400) . ' ngày trước';
    return date('d/m/Y', $ts);
}

function fmt_int($value): string {
    return number_format((int)$value, 0, ',', '.');
}

function avatar_url(?array $user): string {
    if (!$user) {
        return '';
    }
    $id = (int)($user['ma'] ?? $user['nguoi_dung_id'] ?? 0);
    $url = (string)($user['url_anh_dai_dien'] ?? '');
    if ($url === '' || preg_match('#/avatars/\d+$#', $url)) {
        return app_url('/avatars/' . $id);
    }
    return app_media_url($url);
}

function profile_url(array $user): string {
    return app_url('/u/' . rawurlencode((string)$user['ten_dang_nhap']));
}

function game_url(array $game): string {
    return app_url('/games/' . rawurlencode((string)$game['duong_dan_rut_gon']));
}

/**
 * The link to the game itself when it runs in the browser (or points at the
 * project page). Null when the game has no such link or the link is not a
 * valid http(s) address.
 */
function game_play_url(array $game): ?string {
    $url = trim((string)($game['url_choi_ngoai'] ?? ''));
    if ($url === '' || !preg_match('#^https?://#i', $url)) {
        return null;
    }
    return $url;
}

/** Truncate plain text to a number of characters, on a word boundary. */
/** Split a media credit "Ảnh: … · https://source" into [text, url]; url is '' when absent. */
function media_credit(?string $credit): array {
    $credit = trim((string)$credit);
    return preg_match('~^(.*?)\s*·\s*(https?://\S+)$~u', $credit, $m) ? [$m[1], $m[2]] : [$credit, ''];
}

/** Escaped credit HTML: the text, then a "Nguồn ảnh" link when the credit ends in a URL. */
function media_credit_html(?string $credit): string {
    [$text, $url] = media_credit($credit);
    return e($text) . ($url !== '' ? ' · <a href="' . e($url) . '" target="_blank" rel="noopener noreferrer">Nguồn ảnh</a>' : '');
}

function excerpt(?string $text, int $length = 160): string {
    $text = trim(preg_replace('/\s+/u', ' ', (string)$text));
    if (mb_strlen($text) <= $length) {
        return $text;
    }
    $cut = mb_substr($text, 0, $length);
    $space = mb_strrpos($cut, ' ');
    if ($space !== false && $space > $length * 0.6) {
        $cut = mb_substr($cut, 0, $space);
    }
    return rtrim($cut, " ,.;:") . '…';
}

/** Vietnamese-aware slug: "Trò chơi mới" → "tro-choi-moi". */
function slugify(string $text): string {
    $map = [
        'à'=>'a','á'=>'a','ạ'=>'a','ả'=>'a','ã'=>'a','â'=>'a','ầ'=>'a','ấ'=>'a','ậ'=>'a','ẩ'=>'a','ẫ'=>'a','ă'=>'a','ằ'=>'a','ắ'=>'a','ặ'=>'a','ẳ'=>'a','ẵ'=>'a',
        'è'=>'e','é'=>'e','ẹ'=>'e','ẻ'=>'e','ẽ'=>'e','ê'=>'e','ề'=>'e','ế'=>'e','ệ'=>'e','ể'=>'e','ễ'=>'e',
        'ì'=>'i','í'=>'i','ị'=>'i','ỉ'=>'i','ĩ'=>'i',
        'ò'=>'o','ó'=>'o','ọ'=>'o','ỏ'=>'o','õ'=>'o','ô'=>'o','ồ'=>'o','ố'=>'o','ộ'=>'o','ổ'=>'o','ỗ'=>'o','ơ'=>'o','ờ'=>'o','ớ'=>'o','ợ'=>'o','ở'=>'o','ỡ'=>'o',
        'ù'=>'u','ú'=>'u','ụ'=>'u','ủ'=>'u','ũ'=>'u','ư'=>'u','ừ'=>'u','ứ'=>'u','ự'=>'u','ử'=>'u','ữ'=>'u',
        'ỳ'=>'y','ý'=>'y','ỵ'=>'y','ỷ'=>'y','ỹ'=>'y','đ'=>'d',
    ];
    $text = mb_strtolower(trim($text), 'UTF-8');
    $text = strtr($text, $map);
    $text = preg_replace('/[^a-z0-9]+/', '-', $text);
    return trim((string)$text, '-');
}

// --------------------------------------------------------------- input -----

/** Trimmed string from POST, or null when longer than $max characters. */
function post_str(string $key, int $max = 255): ?string {
    $value = trim((string)($_POST[$key] ?? ''));
    return mb_strlen($value) > $max ? null : $value;
}

function post_int(string $key, int $default = 0): int {
    $value = $_POST[$key] ?? null;
    return is_numeric($value) ? (int)$value : $default;
}

function post_bool(string $key): int {
    return !empty($_POST[$key]) ? 1 : 0;
}

/** Validate a money amount like "4.99"; returns float or null. */
function parse_money($value): ?float {
    $value = str_replace(',', '.', trim((string)$value));
    if ($value === '') {
        return null;
    }
    if (!preg_match('/^\d{1,9}(?:\.\d{1,2})?$/', $value)) {
        return null;
    }
    return round((float)$value, 2);
}

/** Validate a datetime-local input ("2026-11-03T10:00"). */
function parse_datetime(?string $value): ?string {
    $value = trim((string)$value);
    if ($value === '') {
        return null;
    }
    $dt = DateTime::createFromFormat('Y-m-d\TH:i', $value) ?: DateTime::createFromFormat('Y-m-d H:i:s', $value) ?: DateTime::createFromFormat('Y-m-d', $value);
    return $dt ? $dt->format('Y-m-d H:i:s') : null;
}

function datetime_local(?string $value): string {
    if (!$value) {
        return '';
    }
    $ts = strtotime($value);
    return $ts ? date('Y-m-d\TH:i', $ts) : '';
}

/** A safe local redirect target; anything else falls back to $fallback. */
function safe_return(?string $target, string $fallback = '/'): string {
    $target = (string)$target;
    if ($target === '' || $target[0] !== '/' || str_starts_with($target, '//') || str_contains($target, "\n") || str_contains($target, "\r")) {
        return $fallback;
    }
    return $target;
}

/** Current query string with overrides (null removes a key). */
function qs(array $overrides = []): string {
    $params = array_merge($_GET, $overrides);
    $params = array_filter($params, static fn($v) => $v !== null && $v !== '' && $v !== []);
    return $params ? '?' . http_build_query($params) : '';
}

function client_ip(): string {
    return substr((string)($_SERVER['REMOTE_ADDR'] ?? ''), 0, 45);
}

/** Write one row to nhat_ky_he_thong. Never breaks the request. */
function audit(string $action, ?string $entityType = null, ?int $entityId = null, array $extra = []): void {
    try {
        $stmt = Model::db()->prepare(
            'INSERT INTO nhat_ky_he_thong (nguoi_dung_id, ma_hanh_dong, loai_thuc_the, thuc_the_id, dia_chi_ip, trinh_duyet_nguoi_dung, du_lieu_bo_sung)
             VALUES (:uid, :action, :type, :eid, :ip, :ua, :extra)'
        );
        $stmt->execute([
            ':uid' => current_user_id() ?: null,
            ':action' => substr($action, 0, 100),
            ':type' => $entityType,
            ':eid' => $entityId,
            ':ip' => client_ip(),
            ':ua' => substr((string)($_SERVER['HTTP_USER_AGENT'] ?? ''), 0, 500),
            ':extra' => $extra ? json_encode($extra, JSON_UNESCAPED_UNICODE) : null,
        ]);
    } catch (Throwable $error) {
        error_log('audit failed: ' . $error->getMessage());
    }
}

// ---------------------------------------------------------- labels (vi) -----

/** All [value => label] pairs of a group (for filters and selects). */
function labels(string $group): array {
    static $labels = [
        'game_status' => ['draft' => 'Bản nháp', 'published' => 'Đã công bố', 'unlisted' => 'Không liệt kê', 'hidden' => 'Đã ẩn', 'under_review' => 'Chờ duyệt', 'suspended' => 'Bị đình chỉ'],
        'release_status' => ['prototype' => 'Bản mẫu', 'in_development' => 'Đang phát triển', 'early_access' => 'Truy cập sớm', 'released' => 'Đã phát hành', 'cancelled' => 'Đã hủy'],
        'pricing' => ['free' => 'Miễn phí', 'paid' => 'Trả phí', 'pay_what_you_want' => 'Trả tùy ý', 'donation' => 'Ủng hộ'],
        'project_type' => ['game' => 'Trò chơi', 'asset' => 'Tài nguyên', 'tool' => 'Công cụ', 'soundtrack' => 'Nhạc nền', 'comic' => 'Truyện tranh', 'book' => 'Sách', 'physical' => 'Sản phẩm vật lý', 'other' => 'Khác'],
        'user_status' => ['active' => 'Hoạt động', 'suspended' => 'Bị đình chỉ', 'deleted' => 'Đã xóa'],
        'order_status' => ['pending' => 'Chờ thanh toán', 'paid' => 'Đã thanh toán', 'partially_refunded' => 'Hoàn một phần', 'refunded' => 'Đã hoàn tiền', 'cancelled' => 'Đã hủy', 'failed' => 'Thất bại'],
        'payment_status' => ['initiated' => 'Khởi tạo', 'pending' => 'Đang chờ', 'succeeded' => 'Thành công', 'failed' => 'Thất bại', 'cancelled' => 'Đã hủy'],
        'refund_status' => ['requested' => 'Đã yêu cầu', 'approved' => 'Đã duyệt', 'rejected' => 'Từ chối', 'processing' => 'Đang xử lý', 'completed' => 'Hoàn tất', 'failed' => 'Thất bại'],
        'ledger_status' => ['pending' => 'Đang giữ', 'available' => 'Có thể rút', 'held' => 'Đang chi trả', 'paid' => 'Đã chi trả', 'reversed' => 'Đã đảo'],
        'payout_status' => ['requested' => 'Đã yêu cầu', 'processing' => 'Đang xử lý', 'paid' => 'Đã chi trả', 'failed' => 'Thất bại', 'cancelled' => 'Đã hủy'],
        'payout_account_status' => ['pending_verification' => 'Chờ xác minh', 'active' => 'Hoạt động', 'disabled' => 'Vô hiệu'],
        'payout_provider' => ['bank_transfer' => 'Chuyển khoản ngân hàng', 'paypal' => 'PayPal', 'stripe' => 'Stripe Connect'],
        'report_status' => ['open' => 'Mới', 'investigating' => 'Đang xem xét', 'resolved' => 'Đã xử lý', 'rejected' => 'Bác bỏ'],
        'report_reason' => ['spam' => 'Spam hoặc quảng cáo', 'abuse' => 'Quấy rối, xúc phạm', 'illegal' => 'Nội dung vi phạm pháp luật', 'copyright' => 'Vi phạm bản quyền', 'malware' => 'Tệp độc hại hoặc lừa đảo', 'other' => 'Lý do khác'],
        'report_target' => ['user' => 'Người dùng', 'game' => 'Trò chơi', 'review' => 'Đánh giá', 'game_comment' => 'Bình luận trò chơi', 'devlog' => 'Nhật ký phát triển', 'devlog_comment' => 'Bình luận nhật ký', 'community_topic' => 'Chủ đề diễn đàn', 'community_post' => 'Bài viết diễn đàn'],
        'mod_action' => ['warning' => 'Cảnh cáo', 'hide' => 'Ẩn', 'remove' => 'Gỡ bỏ', 'suspend' => 'Đình chỉ', 'restore' => 'Khôi phục', 'other' => 'Khác'],
        'content_status' => ['published' => 'Hiển thị', 'hidden' => 'Đã ẩn', 'removed' => 'Đã gỡ', 'draft' => 'Bản nháp'],
        'campaign_status' => ['draft' => 'Bản nháp', 'scheduled' => 'Đã lên lịch', 'active' => 'Đang chạy', 'ended' => 'Đã kết thúc', 'cancelled' => 'Đã hủy'],
        'bundle_type' => ['creator_created' => 'Gói của nhà phát triển', 'platform_curated' => 'Gói do nền tảng tuyển chọn'],
        'bundle_status' => ['draft' => 'Bản nháp', 'published' => 'Đang bán', 'hidden' => 'Đã ẩn', 'ended' => 'Đã kết thúc'],
        'jam_status' => ['draft' => 'Bản nháp', 'published' => 'Sắp diễn ra', 'active' => 'Đang diễn ra', 'judging' => 'Đang chấm', 'completed' => 'Đã kết thúc', 'cancelled' => 'Đã hủy'],
        'jam_role' => ['host' => 'Chủ trì', 'admin' => 'Quản trị', 'judge' => 'Giám khảo', 'moderator' => 'Điều hành'],
        'entry_status' => ['submitted' => 'Đã nộp', 'withdrawn' => 'Đã rút', 'disqualified' => 'Bị loại'],
        'channel' => ['stable' => 'Ổn định', 'beta' => 'Beta', 'alpha' => 'Alpha', 'preview' => 'Xem trước'],
        'media_type' => ['cover' => 'Ảnh bìa', 'thumbnail' => 'Ảnh thu nhỏ', 'screenshot' => 'Ảnh chụp màn hình', 'trailer' => 'Video giới thiệu', 'external_link' => 'Liên kết ngoài', 'other' => 'Khác'],
        'ownership' => ['purchase' => 'Đã mua', 'bundle' => 'Từ gói game', 'gift' => 'Quà tặng', 'free_claim' => 'Nhận miễn phí', 'access_key' => 'Mã truy cập', 'admin_grant' => 'Quản trị cấp'],
        'key_status' => ['available' => 'Chưa dùng', 'claimed' => 'Đã dùng', 'revoked' => 'Đã thu hồi', 'expired' => 'Hết hạn'],
        'role' => ['player' => 'Người chơi', 'developer' => 'Nhà phát triển', 'moderator' => 'Điều hành viên', 'admin' => 'Quản trị viên'],
        'reaction' => ['like' => 'Thích', 'helpful' => 'Hữu ích', 'love' => 'Yêu thích', 'laugh' => 'Vui'],
        'visibility' => ['public' => 'Công khai', 'unlisted' => 'Không liệt kê', 'private' => 'Riêng tư'],
        'coupon_type' => ['percent' => 'Phần trăm', 'fixed_amount' => 'Số tiền cố định'],
        'coupon_state' => ['active' => 'Đang dùng được', 'scheduled' => 'Chưa bắt đầu', 'expired' => 'Hết hạn', 'used_up' => 'Hết lượt', 'disabled' => 'Đã tắt'],
        'download_provider' => ['google_drive' => 'Google Drive', 'onedrive' => 'OneDrive', 'dropbox' => 'Dropbox', 'mediafire' => 'MediaFire',
            'mega' => 'MEGA', 'wetransfer' => 'WeTransfer', 'github' => 'GitHub', 'sourceforge' => 'SourceForge', 'itch_io' => 'itch.io', 'custom' => 'Liên kết khác'],
        'download_platform' => ['any' => 'Mọi nền tảng', 'windows' => 'Windows', 'macos' => 'macOS', 'linux' => 'Linux', 'android' => 'Android'],
        'download_link_status' => ['pending' => 'Chờ duyệt', 'active' => 'Đang hoạt động', 'rejected' => 'Bị từ chối', 'hidden' => 'Đã ẩn'],
    ];
    return $labels[$group] ?? [];
}

function label(string $group, ?string $value): string {
    if ($value === null || $value === '') {
        return '—';
    }
    return labels($group)[$value] ?? $value;
}

/** Pill tone for a status value. */
function status_tone(?string $value): string {
    $positive = ['published', 'active', 'paid', 'succeeded', 'completed', 'resolved', 'available', 'released', 'approved', 'claimed', 'submitted'];
    $negative = ['suspended', 'removed', 'failed', 'refunded', 'rejected', 'reversed', 'revoked', 'disqualified', 'cancelled', 'deleted'];
    $warning = ['under_review', 'pending', 'requested', 'processing', 'open', 'investigating', 'held', 'pending_verification', 'judging', 'scheduled', 'partially_refunded', 'early_access'];
    if (in_array($value, $positive, true)) return 'pos';
    if (in_array($value, $negative, true)) return 'neg';
    if (in_array($value, $warning, true)) return 'warn';
    return '';
}

/** Staff page for a moderated object (hanh_dong_kiem_duyet / bao_cao_noi_dung target). */
function mod_target_url(string $type, int $id): string {
    return match ($type) {
        'game' => '/admin/games?q=' . $id,
        'user' => has_role('admin') ? '/admin/users/' . $id : '/admin/moderation?target=user',
        default => '/admin/comments?type=' . rawurlencode($type) . '&id=' . $id,
    };
}

function status_pill(string $group, ?string $value): string {
    return '<span class="pill ' . status_tone($value) . '">' . e(label($group, $value)) . '</span>';
}

// ---------------------------------------------------------- view bits -----

/** Render templates/partials/{name}.php with its own variables. */
function partial(string $name, array $vars = []): void {
    extract($vars, EXTR_SKIP);
    include VIEWS_DIR . '/partials/' . $name . '.php';
}

/** Path of the current request relative to the app base, without query. */
function current_path(): string {
    $path = parse_url((string)($_SERVER['REQUEST_URI'] ?? '/'), PHP_URL_PATH) ?: '/';
    $base = rtrim(APP_BASE_URL, '/');
    if ($base !== '' && str_starts_with($path, $base)) {
        $path = substr($path, strlen($base)) ?: '/';
    }
    return rtrim($path, '/') ?: '/';
}

/** aria-current for a nav link: exact match, or prefix match when $prefix is true. */
function nav_current(string $path, bool $prefix = false): string {
    $current = current_path();
    $hit = $prefix ? ($current === $path || str_starts_with($current, rtrim($path, '/') . '/')) : $current === $path;
    return $hit ? ' aria-current="page"' : '';
}

/** Counts for the top bar, read once per request. */
function shell_counts(): array {
    static $counts = null;
    if ($counts !== null) {
        return $counts;
    }
    $counts = ['cart' => 0, 'unread' => 0];
    $uid = current_user_id();
    if ($uid <= 0) {
        return $counts;
    }
    try {
        $counts['cart'] = (int)Model::scalar(
            "SELECT COUNT(*) FROM muc_gio_hang i JOIN gio_hang c ON c.ma = i.gio_hang_id WHERE c.nguoi_dung_id = :uid AND c.trang_thai = 'active'",
            [':uid' => $uid]
        );
        $counts['unread'] = (int)Model::scalar('SELECT COUNT(*) FROM thong_bao WHERE nguoi_dung_id = :uid AND da_doc = 0', [':uid' => $uid]);
    } catch (Throwable $error) {
        error_log('shell_counts: ' . $error->getMessage());
    }
    return $counts;
}

/** Five steps of a 1–5 rating as text. */
function stars(float $value): string {
    $full = (int)round($value);
    $out = '<span class="stars" aria-hidden="true">';
    for ($i = 1; $i <= 5; $i++) {
        $out .= $i <= $full ? '★' : '<span class="off">★</span>';
    }
    return $out . '</span><span class="sr-only">' . e(number_format($value, 1)) . ' trên 5</span>';
}

/** Price block for a game card or page; $discount is the active sale percent. */
function price_html(array $game, bool $owned = false): string {
    if ($owned) {
        return '<span class="owned">Đã sở hữu</span>';
    }
    $model = $game['mo_hinh_gia'] ?? 'free';
    $discount = (float)($game['giam_gia'] ?? 0);
    if ($model === 'paid' && $discount > 0) {
        $base = (float)$game['gia_toi_thieu'];
        $now = round($base * (1 - $discount / 100), 2);
        return '<span class="price"><span class="off">−' . e(rtrim(rtrim(number_format($discount, 2), '0'), '.')) . '%</span><span class="was">'
            . e(money($base)) . '</span><span>' . e(money($now)) . '</span></span>';
    }
    $text = price_label($game);
    return '<span class="price' . ($model === 'free' || $text === 'Miễn phí' ? ' free' : '') . '">' . e($text) . '</span>';
}

/** Is the game free to add to the library without checkout? */
function game_is_free(array $game): bool {
    $model = $game['mo_hinh_gia'] ?? 'free';
    if ($model === 'free' || $model === 'donation') {
        return true;
    }
    return $model === 'pay_what_you_want' && (float)($game['gia_toi_thieu'] ?? 0) <= 0;
}

/** Hidden input that sends the user back to the page they came from. */
function return_field(?string $path = null): string {
    $path = $path ?? (current_path() . (empty($_SERVER['QUERY_STRING']) ? '' : '?' . $_SERVER['QUERY_STRING']));
    return '<input type="hidden" name="return_to" value="' . e(safe_return($path, '/')) . '">';
}

// ---------------------------------------------------------- uploads -------

/**
 * Store an uploaded image under public/uploads/{folder}. The type is read from the
 * file's bytes (finfo), never from the client name; the stored name is random.
 * Returns ['path' => '/public/uploads/...'] or ['error' => message]; null when no file was sent.
 */
function store_image_upload(?array $file, string $folder, int $maxBytes = 5242880): ?array {
    if (!$file || ($file['error'] ?? UPLOAD_ERR_NO_FILE) === UPLOAD_ERR_NO_FILE) {
        return null;
    }
    if ($file['error'] !== UPLOAD_ERR_OK || !is_uploaded_file($file['tmp_name'])) {
        return ['error' => in_array($file['error'], [UPLOAD_ERR_INI_SIZE, UPLOAD_ERR_FORM_SIZE], true) ? 'Ảnh vượt quá dung lượng cho phép.' : 'Tải ảnh lên không thành công.'];
    }
    if ($file['size'] > $maxBytes) {
        return ['error' => 'Ảnh tối đa ' . round($maxBytes / 1048576, 1) . ' MB.'];
    }
    $types = ['image/jpeg' => 'jpg', 'image/png' => 'png', 'image/webp' => 'webp', 'image/gif' => 'gif'];
    $mime = (new finfo(FILEINFO_MIME_TYPE))->file($file['tmp_name']);
    if (!isset($types[$mime]) || @getimagesize($file['tmp_name']) === false) {
        return ['error' => 'Chỉ nhận ảnh JPG, PNG, WebP hoặc GIF.'];
    }
    $folder = preg_replace('/[^a-z0-9-]/', '', $folder);
    $dir = APP_DIR . '/public/uploads/' . $folder;
    if (!is_dir($dir) && !mkdir($dir, 0755, true)) {
        return ['error' => 'Không tạo được thư mục lưu ảnh.'];
    }
    $name = bin2hex(random_bytes(16)) . '.' . $types[$mime];
    if (!move_uploaded_file($file['tmp_name'], $dir . '/' . $name)) {
        return ['error' => 'Không lưu được ảnh.'];
    }
    return ['path' => '/public/uploads/' . $folder . '/' . $name];
}

/** Delete a file previously stored by store_image_upload (ignores anything else). */
function delete_upload(?string $path): void {
    $path = (string)$path;
    if (preg_match('#^/public/uploads/[a-z0-9-]+/[a-f0-9]{32}\.(?:jpg|png|webp|gif)$#', $path)) {
        @unlink(APP_DIR . $path);
    }
}
