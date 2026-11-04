<?php
// =============================================================================
// MAILER - gửi email qua SMTP (PHPMailer).
//
// Cấu hình nằm trong config/mail.php. Khi chưa điền MAIL_USERNAME/MAIL_PASSWORD
// hoặc chưa cài thư viện, hàm gửi trả về false và ghi log, không làm hỏng
// luồng của trang.
// =============================================================================

use PHPMailer\PHPMailer\PHPMailer;

class Mailer {
    /** Gửi một email. Trả về true khi thư đã được gửi đi. */
    public static function send(string $to, string $subject, string $htmlBody, ?string $textBody = null): bool {
        if (!self::configured()) {
            error_log('mail skipped: cấu hình SMTP hoặc thư viện PHPMailer chưa sẵn sàng.');
            return false;
        }
        try {
            $mail = new PHPMailer(true);
            $mail->isSMTP();
            $mail->Host = MAIL_HOST;
            $mail->Port = (int)MAIL_PORT;
            $mail->SMTPAuth = true;
            $mail->Username = MAIL_USERNAME;
            $mail->Password = MAIL_PASSWORD;
            $mail->SMTPSecure = MAIL_ENCRYPTION;
            $mail->CharSet = PHPMailer::CHARSET_UTF8;
            $mail->setFrom(MAIL_FROM_ADDRESS, MAIL_FROM_NAME);
            $mail->addAddress($to);
            $mail->Subject = $subject;
            $mail->isHTML(true);
            $mail->Body = $htmlBody;
            $mail->AltBody = $textBody ?? trim(strip_tags($htmlBody));
            return $mail->send();
        } catch (Throwable $error) {
            error_log('mail failed: ' . $error->getMessage());
            return false;
        }
    }

    /** Đã đủ điều kiện để gửi email chưa. */
    public static function configured(): bool {
        return class_exists(PHPMailer::class)
            && MAIL_USERNAME !== '' && MAIL_PASSWORD !== '';
    }
}
