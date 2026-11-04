<?php
// =============================================================================
// APP CONFIGURATION
// =============================================================================

define('APP_NAME', 'Kho Game Độc Lập');
define('APP_FULL_NAME', 'Nền Tảng Phân Phối Trò Chơi Kỹ Thuật Số');
$scriptDirectory = rtrim(str_replace('\\', '/', dirname($_SERVER['SCRIPT_NAME'] ?? '/')), '/');
define('APP_BASE_URL', $scriptDirectory === '.' ? '' : $scriptDirectory);
define('APP_TIMEZONE', 'Asia/Ho_Chi_Minh');

// Một đơn vị tiền tệ cho toàn hệ thống: giá game, giỏ hàng, đơn hàng và sổ kế toán đều dùng USD
// (khớp giá trị mặc định của tro_choi.ma_tien_te và gio_hang.ma_tien_te trong database/du_lieu.sql).
define('APP_CURRENCY', 'USD');
// Phí nền tảng trừ vào doanh thu của tác giả khi ghi sổ kế toán (10%).
define('PLATFORM_FEE_RATE', 0.10);
// Số ngày giữ doanh thu trước khi tác giả được rút (khớp thời hạn hoàn tiền).
define('PAYOUT_HOLD_DAYS', 14);
define('REFUND_WINDOW_DAYS', 14);

// XAMPP defaults; import database/du_lieu.sql into the nen_tang_game_doc_lap_vi_v2 database.
define('DB_HOST', '127.0.0.1');
define('DB_NAME', 'nen_tang_game_doc_lap_vi_v2');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_PORT', 3306);

// Paths
define('APP_DIR', dirname(__DIR__));
define('VIEWS_DIR', APP_DIR . '/templates');
define('PUBLIC_DIR', APP_DIR . '/public');

// Đặt APP_DEBUG = true chỉ khi phát triển cục bộ. Không bao giờ hiện lỗi PHP cho người dùng.
define('APP_DEBUG', false);
error_reporting(E_ALL);
ini_set('display_errors', APP_DEBUG ? '1' : '0');
ini_set('log_errors', '1');
date_default_timezone_set(APP_TIMEZONE);

if (session_status() !== PHP_SESSION_ACTIVE) {
    ini_set('session.use_strict_mode', '1');
    ini_set('session.use_only_cookies', '1');
    session_name('kgdl_session');
    session_set_cookie_params([
        'lifetime' => 0,
        'path' => APP_BASE_URL === '' ? '/' : APP_BASE_URL . '/',
        'secure' => !empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off',
        'httponly' => true,
        'samesite' => 'Lax',
    ]);
    session_start();
}

if (!headers_sent()) {
    header('X-Content-Type-Options: nosniff');
    header('X-Frame-Options: SAMEORIGIN');
    header('Referrer-Policy: strict-origin-when-cross-origin');
}

function app_url(string $path = ''): string {
    $base = rtrim(APP_BASE_URL, '/');
    $path = '/' . ltrim($path, '/');
    if ($base === '' || $path === $base || strpos($path, $base . '/') === 0) {
        return $path;
    }
    return $base . $path;
}

function app_media_url(?string $url): string {
    $url = (string)$url;
    if ($url === '') {
        return '';
    }
    $parts = parse_url($url);
    if ($parts === false) {
        return '';
    }
    if (isset($parts['host'])) {
        $scheme = strtolower($parts['scheme'] ?? '');
        return in_array($scheme, ['http', 'https'], true) ? $url : '';
    }

    $path = $parts['path'] ?? '';
    $uploadPath = '/public/uploads/';
    $position = strrpos($path, $uploadPath);
    if ($position === false) {
        return app_url($path);
    }

    return app_url(substr($path, $position));
}

require_once APP_DIR . '/core/helpers.php';
