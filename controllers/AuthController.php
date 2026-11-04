<?php
// =============================================================================
// AUTH CONTROLLER - login, register, logout
// Failed logins are logged to nhat_ky_he_thong; 5 failures per IP or account in
// 15 minutes lock further attempts for the rest of that window.
// =============================================================================

class AuthController extends Controller {
    private const MAX_ATTEMPTS = 5;
    private const WINDOW_MINUTES = 15;

    public function showLogin(array $params = []) {
        if ($this->currentUser()) {
            $this->redirect('/library');
        }
        $return = safe_return((string)($_GET['return_to'] ?? ''), '');
        if ($return !== '') {
            $_SESSION['redirect_after_login'] = $return;
        }
        $this->render('auth/login', ['pageTitle' => 'Đăng nhập']);
    }

    public function showRegister(array $params = []) {
        if ($this->currentUser()) {
            $this->redirect('/library');
        }
        $this->render('auth/register', ['pageTitle' => 'Tạo tài khoản']);
    }

    public function login(array $params = []) {
        $login = trim((string)($_POST['login'] ?? ''));
        $password = (string)($_POST['password'] ?? '');
        if ($login === '' || $password === '' || mb_strlen($login) > 254) {
            $this->fail('Hãy nhập email hoặc tên đăng nhập và mật khẩu.', '/auth/login');
        }

        if ($this->tooManyAttempts($login)) {
            $this->fail('Bạn đã đăng nhập sai quá nhiều lần. Hãy thử lại sau ' . self::WINDOW_MINUTES . ' phút.', '/auth/login');
        }

        $user = UserModel::findForLogin($login);
        if (!$user || !password_verify($password, $user['mat_khau_da_bam'])) {
            audit('login_failed', 'nguoi_dung', $user ? (int)$user['ma'] : null, ['login' => mb_substr($login, 0, 80)]);
            $this->fail('Email/tên đăng nhập hoặc mật khẩu không đúng.', '/auth/login');
        }
        if ($user['trang_thai'] !== 'active') {
            audit('login_blocked', 'nguoi_dung', (int)$user['ma'], ['status' => $user['trang_thai']]);
            $this->fail($user['trang_thai'] === 'suspended'
                ? 'Tài khoản này đang bị đình chỉ. Hãy liên hệ quản trị viên nếu bạn cho rằng đây là nhầm lẫn.'
                : 'Tài khoản này không còn hoạt động.', '/auth/login');
        }

        if (password_needs_rehash($user['mat_khau_da_bam'], PASSWORD_DEFAULT)) {
            UserModel::update((int)$user['ma'], ['mat_khau_da_bam' => password_hash($password, PASSWORD_DEFAULT)]);
        }

        $this->startSession($user);
        audit('login', 'nguoi_dung', (int)$user['ma']);
        flash('success', 'Chào mừng trở lại, ' . $user['ten_hien_thi'] . '.');
        $target = safe_return($_SESSION['redirect_after_login'] ?? '', '/library');
        unset($_SESSION['redirect_after_login']);
        $this->redirect($target);
    }

    public function register(array $params = []) {
        $username = trim((string)($_POST['username'] ?? ''));
        $email = mb_strtolower(trim((string)($_POST['email'] ?? '')));
        $display = trim((string)($_POST['display_name'] ?? ''));
        $password = (string)($_POST['password'] ?? '');
        $confirm = (string)($_POST['confirm_password'] ?? '');

        $errors = [];
        if (!preg_match('/^[a-zA-Z0-9_]{3,30}$/', $username)) {
            $errors[] = 'Tên đăng nhập gồm 3–30 ký tự: chữ không dấu, số hoặc dấu gạch dưới.';
        }
        if (!filter_var($email, FILTER_VALIDATE_EMAIL) || mb_strlen($email) > 254) {
            $errors[] = 'Email không hợp lệ.';
        }
        if ($display === '' || mb_strlen($display) > 100) {
            $errors[] = 'Tên hiển thị không được để trống và tối đa 100 ký tự.';
        }
        if (strlen($password) < 8 || strlen($password) > 72) {
            $errors[] = 'Mật khẩu cần từ 8 đến 72 ký tự.';
        }
        if ($password !== $confirm) {
            $errors[] = 'Mật khẩu nhập lại không khớp.';
        }
        if (!$errors) {
            if (UserModel::findBy('email', $email)) {
                $errors[] = 'Email này đã được dùng cho một tài khoản khác.';
            }
            if (UserModel::findBy('ten_dang_nhap', $username)) {
                $errors[] = 'Tên đăng nhập đã có người dùng.';
            }
        }
        if ($errors) {
            $this->fail(implode(' ', $errors), '/auth/register');
        }

        try {
            $userId = UserModel::create($username, $email, $password, $display);
        } catch (PDOException $error) {
            if ($error->getCode() === '23000') {
                $this->fail('Email hoặc tên đăng nhập đã được dùng.', '/auth/register');
            }
            throw $error;
        }
        $user = UserModel::find($userId);
        $this->startSession($user);
        audit('register', 'nguoi_dung', $userId);
        flash('success', 'Tài khoản đã được tạo. Chào mừng bạn!');
        $this->redirect('/');
    }

    public function logout(array $params = []) {
        $uid = current_user_id();
        if ($uid) {
            audit('logout', 'nguoi_dung', $uid);
        }
        $_SESSION = [];
        if (ini_get('session.use_cookies')) {
            $p = session_get_cookie_params();
            setcookie(session_name(), '', time() - 42000, $p['path'], $p['domain'], $p['secure'], $p['httponly']);
        }
        session_destroy();
        session_start();
        session_regenerate_id(true);
        flash('info', 'Bạn đã đăng xuất.');
        $this->redirect('/');
    }

    private function startSession(array $user): void {
        session_regenerate_id(true);
        unset($_SESSION['csrf_token']);
        $_SESSION['user'] = UserModel::publicFields($user);
        $_SESSION['user_roles'] = array_column(UserModel::getRoles((int)$user['ma']), 'ma_vai_tro');
    }

    private function tooManyAttempts(string $login): bool {
        $sql = "SELECT COUNT(*) FROM nhat_ky_he_thong
                WHERE ma_hanh_dong = 'login_failed' AND ngay_tao >= NOW() - INTERVAL " . self::WINDOW_MINUTES . " MINUTE
                  AND (dia_chi_ip = :ip OR du_lieu_bo_sung = :extra)";
        $extra = json_encode(['login' => mb_substr($login, 0, 80)], JSON_UNESCAPED_UNICODE);
        return (int)Model::scalar($sql, [':ip' => client_ip(), ':extra' => $extra]) >= self::MAX_ATTEMPTS;
    }
}
