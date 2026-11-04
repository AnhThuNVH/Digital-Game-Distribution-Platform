<?php
// =============================================================================
// MAIL CONFIGURATION - cấu hình SMTP để gửi email.
//
// Giá trị mặc định bên dưới dùng cho môi trường chạy thử. Muốn dùng tài
// khoản email thật, tạo file config/mail.local.php (file này không được
// commit) và định nghĩa lại những hằng muốn thay đổi:
//
//     <?php
//     define('MAIL_USERNAME', 'ban@gmail.com');
//     define('MAIL_PASSWORD', 'mat-khau ung dung');
//
// File local được nạp trước nên chỉ cần định nghĩa những hằng muốn thay đổi.
// =============================================================================

if (is_file(__DIR__ . '/mail.local.php')) {
    require_once __DIR__ . '/mail.local.php';
}

define('MAIL_HOST', 'smtp.gmail.com');
define('MAIL_PORT', 465);
define('MAIL_ENCRYPTION', 'ssl');
define('MAIL_USERNAME', '');
define('MAIL_PASSWORD', '');
define('MAIL_FROM_ADDRESS', 'no-reply@example.com');
define('MAIL_FROM_NAME', defined('APP_FULL_NAME') ? APP_FULL_NAME : 'Kho Game');
