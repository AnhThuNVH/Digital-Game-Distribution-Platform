<!doctype html>
<html lang="vi">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Mã xác nhận đặt lại mật khẩu</title>
</head>
<body style="margin:0;padding:24px;background:#f4f5f7;font-family:Arial,Helvetica,sans-serif;color:#1f2430;">
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="max-width:560px;margin:0 auto;background:#ffffff;border-radius:12px;overflow:hidden;">
        <tr>
            <td style="padding:24px 32px 8px 32px;">
                <h1 style="margin:0;font-size:20px;">Đặt lại mật khẩu</h1>
            </td>
        </tr>
        <tr>
            <td style="padding:0 32px;font-size:14px;line-height:1.6;">
                <p>Xin chào <?= e($user['ten_hien_thi']) ?>,</p>
                <p>Bạn (hoặc ai đó) đã yêu cầu đặt lại mật khẩu cho tài khoản <strong><?= e($user['email']) ?></strong>.</p>
                <p>Nhập mã xác nhận dưới đây tại trang đặt lại mật khẩu:</p>
            </td>
        </tr>
        <tr>
            <td style="padding:16px 32px;">
                <div style="font-size:32px;font-weight:bold;letter-spacing:8px;text-align:center;background:#f0f4ff;border:1px solid #d7e0ff;border-radius:10px;padding:16px;"><?= e($code) ?></div>
            </td>
        </tr>
        <tr>
            <td style="padding:0 32px 24px 32px;font-size:14px;line-height:1.6;">
                <p>Mã có hiệu lực trong <strong><?= (int)$minutes ?> phút</strong> (đến <?= e(fmt_datetime($expiresAt)) ?>) và chỉ dùng được một lần.</p>
                <p><a href="<?= e($resetUrl) ?>" style="display:inline-block;background:#2f6fed;color:#ffffff;text-decoration:none;padding:12px 20px;border-radius:8px;">Mở trang đặt lại mật khẩu</a></p>
                <p style="color:#6b7280;font-size:13px;">Nếu bạn không yêu cầu đặt lại mật khẩu, hãy bỏ qua email này — mật khẩu của bạn vẫn giữ nguyên.</p>
            </td>
        </tr>
        <tr>
            <td style="padding:16px 32px;background:#fafbfc;border-top:1px solid #eef0f4;font-size:12px;color:#8a93a3;">
                <?= e(MAIL_FROM_NAME) ?>
            </td>
        </tr>
    </table>
</body>
</html>
