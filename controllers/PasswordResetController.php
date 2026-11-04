<?php
// =============================================================================
// PASSWORD RESET CONTROLLER - quên mật khẩu bằng mã xác nhận gửi qua email.
//
// Luồng:
//   1. Người dùng nhập email -> hệ thống sinh mã 6 chữ số, lưu dạng băm kèm
//      thời hạn, gửi mã về email và trả lời chung chung (không tiết lộ email
//      nào có trong hệ thống).
//   2. Người dùng nhận mã, nhập mã + mật khẩu mới -> mật khẩu được đổi, mã bị
//      vô hiệu, các phiên đang đăng nhập khác không còn dùng được mật khẩu cũ.
//
// Mã xác nhận chỉ dùng được trong 10 phút và tối đa 5 lần nhập sai.
// =============================================================================

class PasswordResetController extends Controller {
    /** Số lần yêu cầu gửi mã cho cùng một email trong khung thời gian. */
    private const MAX_REQUESTS = 5;
    private const WINDOW_MINUTES = 15;

    public function showForgotPassword(array $params = []) {
        if ($this->currentUser()) {
            $this->redirect('/library');
        }
        $this->render('auth/forgot-password', ['pageTitle' => 'Quên mật khẩu']);
    }

    /** Nhận email, sinh mã xác nhận và gửi đi. */
    public function sendResetCode(array $params = []) {
        $email = mb_strtolower(trim((string)($_POST['email'] ?? '')));
        if (!filter_var($email, FILTER_VALIDATE_EMAIL) || mb_strlen($email) > 254) {
            $this->fail('Email không hợp lệ.', '/auth/forgot-password');
        }

        if (!Mailer::configured()) {
            $this->fail('Hệ thống chưa cấu hình gửi email. Vui lòng liên hệ quản trị viên.', '/auth/forgot-password');
        }

        if ($this->tooManyRequests($email)) {
            $this->fail('Bạn đã yêu cầu mã xác nhận quá nhiều lần. Hãy thử lại sau ' . self::WINDOW_MINUTES . ' phút.', '/auth/forgot-password');
        }

        $user = UserModel::findBy('email', $email);
        if ($user && $user['trang_thai'] === 'active') {
            $code = str_pad((string)random_int(0, 999999), 6, '0', STR_PAD_LEFT);
            $expiresAt = (new DateTime('now', new DateTimeZone(APP_TIMEZONE)))
                ->modify('+' . PasswordResetModel::TTL_MINUTES . ' minutes')
                ->format('Y-m-d H:i:s');
            PasswordResetModel::issue((int)$user['ma'], $email, $code, $expiresAt);

            $sent = Mailer::send(
                $email,
                'Mã xác nhận đặt lại mật khẩu',
                $this->mailBody($user, $code, $expiresAt)
            );
            audit('password_reset_requested', 'nguoi_dung', (int)$user['ma'], ['email' => $email, 'sent' => $sent]);
        } else {
            // Không tiết lộ email có tồn tại hay không.
            audit('password_reset_requested', 'nguoi_dung', null, ['email' => $email]);
        }

        flash('success', 'Nếu email này có trong hệ thống, mã xác nhận đã được gửi. Vui lòng kiểm tra hộp thư của bạn.');
        $this->redirect('/auth/reset-password?email=' . rawurlencode($email));
    }

    public function showResetPassword(array $params = []) {
        if ($this->currentUser()) {
            $this->redirect('/library');
        }
        $email = mb_strtolower(trim((string)($_GET['email'] ?? '')));
        $this->render('auth/reset-password', [
            'pageTitle' => 'Đặt lại mật khẩu',
            'email' => $email,
        ]);
    }

    /** Kiểm tra mã xác nhận và đổi mật khẩu. */
    public function resetPassword(array $params = []) {
        $email = mb_strtolower(trim((string)($_POST['email'] ?? '')));
        $code = trim((string)($_POST['code'] ?? ''));
        $password = (string)($_POST['password'] ?? '');
        $confirm = (string)($_POST['confirm_password'] ?? '');

        if (!filter_var($email, FILTER_VALIDATE_EMAIL) || mb_strlen($email) > 254) {
            $this->fail('Email không hợp lệ.', '/auth/reset-password');
        }
        if (!preg_match('/^\d{6}$/', $code)) {
            $this->fail('Mã xác nhận gồm 6 chữ số.', '/auth/reset-password');
        }
        if (strlen($password) < 8 || strlen($password) > 72) {
            $this->fail('Mật khẩu mới cần 8–72 ký tự.', '/auth/reset-password');
        }
        if (!hash_equals($password, $confirm)) {
            $this->fail('Hai lần nhập mật khẩu mới không khớp.', '/auth/reset-password');
        }

        $user = UserModel::findBy('email', $email);
        $candidates = $user ? PasswordResetModel::pendingForEmail((int)$user['ma'], $email) : [];
        $matched = null;
        foreach ($candidates as $row) {
            if (password_verify($code, $row['ma_bam'])) {
                $matched = $row;
                break;
            }
        }
        if (!$matched) {
            foreach ($candidates as $row) {
                PasswordResetModel::registerFailure((int)$row['ma']);
            }
            audit('password_reset_failed', 'nguoi_dung', $user ? (int)$user['ma'] : null, ['email' => $email]);
            $this->fail('Mã xác nhận không đúng hoặc đã hết hạn.', '/auth/reset-password');
        }

        $userId = (int)$user['ma'];
        PasswordResetModel::markUsed((int)$matched['ma']);
        UserModel::update($userId, ['mat_khau_da_bam' => password_hash($password, PASSWORD_DEFAULT)]);
        // Các mã khác của tài khoản cũng không dùng lại được.
        PasswordResetModel::invalidateAll($userId);
        audit('password_reset', 'nguoi_dung', $userId, ['email' => $email]);
        NotificationModel::create($userId, 'account', 'Mật khẩu đã được đặt lại', 'Mật khẩu của bạn vừa được đặt lại bằng mã xác nhận. Nếu không phải bạn, hãy liên hệ quản trị viên ngay.', '/settings#password');

        flash('success', 'Đặt lại mật khẩu thành công. Vui lòng đăng nhập với mật khẩu mới.');
        $this->redirect('/auth/login');
    }

    /** Số lần yêu cầu gửi mã cho email này trong khung thời gian. */
    private function tooManyRequests(string $email): bool {
        $sql = "SELECT COUNT(*) FROM nhat_ky_he_thong
                WHERE ma_hanh_dong = 'password_reset_requested'
                  AND ngay_tao >= NOW() - INTERVAL " . self::WINDOW_MINUTES . " MINUTE
                  AND du_lieu_bo_sung LIKE :email ESCAPE '!'";
        $pattern = '%"email":"' . str_replace(['!', '%', '_'], ['!!', '!%', '!_'], $email) . '"%';
        return (int)Model::scalar($sql, [':email' => $pattern]) >= self::MAX_REQUESTS;
    }

    /** Nội dung email chứa mã xác nhận. */
    private function mailBody(array $user, string $code, string $expiresAt): string {
        $view = new View();
        return $view->render('mail/reset-code', [
            'user' => $user,
            'code' => $code,
            'expiresAt' => $expiresAt,
            'minutes' => PasswordResetModel::TTL_MINUTES,
            'resetUrl' => app_url('/auth/reset-password?email=' . rawurlencode((string)$user['email'])),
        ], null);
    }
}
