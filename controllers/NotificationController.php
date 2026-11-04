<?php
// =============================================================================
// NOTIFICATION CONTROLLER - Table: thong_bao
// Opening a notification goes through POST /notifications/{id}/read, which marks
// it read and redirects to its (app-relative) target.
// =============================================================================

class NotificationController extends Controller {
    private const PER_PAGE = 30;

    public function index(array $params = []) {
        $user = $this->requireAuth();
        $uid = (int)$user['ma'];
        $filter = ($_GET['filter'] ?? '') === 'unread' ? 'unread' : 'all';
        $where = 'nguoi_dung_id = :u' . ($filter === 'unread' ? ' AND da_doc = 0' : '');
        $total = (int)Model::scalar("SELECT COUNT(*) FROM thong_bao WHERE $where", [':u' => $uid]);
        $pages = max(1, (int)ceil($total / self::PER_PAGE));
        $page = min($this->page(), $pages);
        $rows = Model::query("SELECT * FROM thong_bao WHERE $where ORDER BY ngay_tao DESC, ma DESC LIMIT :l OFFSET :o", [
            ':u' => $uid, ':l' => self::PER_PAGE, ':o' => ($page - 1) * self::PER_PAGE,
        ]);
        $this->render('notification/index', [
            'pageTitle' => 'Thông báo',
            'notifications' => $rows,
            'filter' => $filter,
            'unread' => NotificationModel::unreadCount($uid),
            'page' => $page,
            'pages' => $pages,
            'total' => $total,
        ]);
    }

    public function read(array $params = []) {
        $user = $this->requireAuth();
        $row = Model::one('SELECT ma, url_dich FROM thong_bao WHERE ma = :id AND nguoi_dung_id = :u', [':id' => (int)($params['id'] ?? 0), ':u' => (int)$user['ma']]);
        if (!$row) {
            $this->notFound('Không tìm thấy thông báo này.');
        }
        NotificationModel::markReadForUser((int)$row['ma'], (int)$user['ma']);
        if (!empty($_POST['open'])) {
            $this->redirect(safe_return((string)$row['url_dich'], '/notifications'));
        }
        $this->back('/notifications');
    }

    public function readAll(array $params = []) {
        $user = $this->requireAuth();
        $n = Model::run('UPDATE thong_bao SET da_doc = 1, ngay_doc = NOW() WHERE nguoi_dung_id = :u AND da_doc = 0', [':u' => (int)$user['ma']]);
        flash('success', $n ? 'Đã đánh dấu ' . fmt_int($n) . ' thông báo là đã đọc.' : 'Không có thông báo chưa đọc.');
        $this->redirect('/notifications');
    }
}
