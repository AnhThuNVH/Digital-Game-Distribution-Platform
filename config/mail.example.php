<?php
// =============================================================================
// MAIL CONFIGURATION — file mẫu, được commit vào git.
//
// Sao chép thành config/mail.php rồi điền thông tin thật:
//
//     cp config/mail.example.php config/mail.php
//
// Nhắc lại:
//   - Gmail: dùng Mật khẩu ứng dụng (App Password), không phải mật khẩu
//     tài khoản. Bật 2FA trước rồi tạo App Password trong
//     https://myaccount.google.com/apppasswords
//   - MAIL_FROM_ADDRESS phải trùng MAIL_USERNAME, nếu không Gmail sẽ từ chối.
//   - Cổng 465 dùng 'ssl'; cổng 587 dùng 'tls'.
// =============================================================================

// --- Thông tin máy chủ SMTP -------------------------------------------------
define('MAIL_HOST', 'smtp.gmail.com');
define('MAIL_PORT', 465);
define('MAIL_ENCRYPTION', 'ssl');

// --- Tài khoản gửi thư (bí mật) ----------------------------------------------
define('MAIL_USERNAME', '');
define('MAIL_PASSWORD', '');

// --- Địa chỉ người gửi ------------------------------------------------------
define('MAIL_FROM_ADDRESS', MAIL_USERNAME);
define('MAIL_FROM_NAME', 'Kho Game Độc Lập');
