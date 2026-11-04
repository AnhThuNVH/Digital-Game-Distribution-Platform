<?php
// =============================================================================
// BASE CONTROLLER
// CSRF for every state-changing request is enforced once, in public/index.php.
// =============================================================================

class Controller {
    protected $view;

    public function __construct() {
        $this->view = new View();
    }

    protected function render(string $template, array $data = [], string $layout = 'layout') {
        echo $this->view->render($template, $data, $layout);
    }

    protected function redirect(string $url) {
        header('Location: ' . app_url($url));
        exit;
    }

    /** Redirect back to a local URL posted as "return_to", or to $fallback. */
    protected function back(string $fallback = '/') {
        $target = safe_return((string)($_POST['return_to'] ?? ''), '');
        if ($target !== '') {
            header('Location: ' . app_url($target));
            exit;
        }
        $this->redirect($fallback);
    }

    protected function currentUser(): ?array {
        return $_SESSION['user'] ?? null;
    }

    /** Re-read roles and status from the database on every protected request. */
    protected function currentUserRoles(): array {
        $user = $this->currentUser();
        if (!$user) {
            return [];
        }
        $roles = array_column(UserModel::getRoles((int)$user['ma']), 'ma_vai_tro');
        $_SESSION['user_roles'] = $roles;
        return $roles;
    }

    protected function requireAuth(): array {
        $user = $this->currentUser();
        if (!$user) {
            if (($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'GET') {
                $_SESSION['redirect_after_login'] = $this->relativeRequestUri();
            }
            flash('info', 'Vui lòng đăng nhập để tiếp tục.');
            $this->redirect('/auth/login');
        }
        // A suspended or deleted account loses its session immediately.
        $fresh = UserModel::find((int)$user['ma']);
        if (!$fresh || $fresh['trang_thai'] !== 'active') {
            $_SESSION = [];
            session_regenerate_id(true);
            flash('error', 'Tài khoản của bạn đã bị đình chỉ hoặc không còn hoạt động.');
            $this->redirect('/auth/login');
        }
        unset($fresh['mat_khau_da_bam']);
        $_SESSION['user'] = $fresh;
        $this->currentUserRoles();
        return $fresh;
    }

    /** Require any one of the given roles. */
    protected function requireRole(string ...$roles): array {
        $user = $this->requireAuth();
        $userRoles = $this->currentUserRoles();
        if (!array_intersect($roles, $userRoles)) {
            $this->forbidden('Bạn không có quyền truy cập trang này.');
        }
        return $user;
    }

    protected function forbidden(string $message = 'Bạn không có quyền thực hiện thao tác này.') {
        http_response_code(403);
        $this->render('errors/403', ['message' => $message, 'pageTitle' => 'Không có quyền']);
        exit;
    }

    protected function notFound(string $message = 'Không tìm thấy trang bạn yêu cầu.') {
        http_response_code(404);
        $this->render('errors/404', ['message' => $message, 'pageTitle' => 'Không tìm thấy']);
        exit;
    }

    protected function csrfToken(): string {
        return csrf_token();
    }

    protected function validateCsrf(string $token): bool {
        return csrf_valid($token);
    }

    protected function json($data, int $status = 200) {
        http_response_code($status);
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode($data, JSON_UNESCAPED_UNICODE);
        exit;
    }

    /** Fail a form: flash the message, keep the input, go back. */
    protected function fail(string $message, string $to) {
        flash('error', $message);
        remember_input($_POST);
        $this->redirect($to);
    }

    protected function relativeRequestUri(): string {
        $uri = (string)($_SERVER['REQUEST_URI'] ?? '/');
        $base = rtrim(APP_BASE_URL, '/');
        if ($base !== '' && str_starts_with($uri, $base)) {
            $uri = substr($uri, strlen($base)) ?: '/';
        }
        return safe_return($uri, '/');
    }

    /** Game by route slug that the public may interact with (published or unlisted). */
    protected function publishedGame(array $params): array {
        $game = GameModel::findBySlug((string)($params['slug'] ?? ''));
        if (!$game || !in_array($game['trang_thai'], ['published', 'unlisted'], true)) {
            $this->notFound('Không tìm thấy trò chơi này.');
        }
        return $game;
    }

    protected function page(): int {
        return max(1, (int)($_GET['page'] ?? 1));
    }

    /**
     * Cut an already-loaded list into one page (for lists bounded per user or per creator).
     * Returns [rows of this page, ['total', 'page', 'pages']]; merge the second part into the view data
     * for the pagination partial.
     */
    protected function paginate(array $rows, int $per): array {
        $total = count($rows);
        $pages = max(1, (int)ceil($total / $per));
        $page = min($this->page(), $pages);
        return [array_slice($rows, ($page - 1) * $per, $per), ['total' => $total, 'page' => $page, 'pages' => $pages]];
    }
}
