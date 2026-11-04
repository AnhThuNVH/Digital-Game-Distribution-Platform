<?php
// =============================================================================
// ADMIN CONTROLLER - /admin overview, users, games and the system log.
// Tables: nguoi_dung, nguoi_dung_vai_tro, vai_tro, tro_choi, quyen_so_huu_tro_choi,
// bao_cao_noi_dung, hanh_dong_kiem_duyet, hoan_tien, dot_chi_tra, nhat_ky_he_thong.
// Moderators see the overview and games; everything about accounts is admin-only.
// =============================================================================

class AdminController extends Controller {
    private const PER_PAGE = 30;

    public function dashboard(array $params = []) {
        $this->requireRole('moderator', 'admin');
        $isAdmin = has_role('admin');
        $kpis = [
            'users' => (int)Model::scalar("SELECT COUNT(*) FROM nguoi_dung WHERE trang_thai = 'active'"),
            'games' => (int)Model::scalar("SELECT COUNT(*) FROM tro_choi WHERE trang_thai = 'published'"),
            'review' => (int)Model::scalar("SELECT COUNT(*) FROM tro_choi WHERE trang_thai = 'under_review'"),
            'reports' => (int)Model::scalar("SELECT COUNT(*) FROM bao_cao_noi_dung WHERE trang_thai IN ('open','investigating')"),
        ];
        if ($isAdmin) {
            $kpis['refunds'] = (int)Model::scalar("SELECT COUNT(*) FROM hoan_tien WHERE trang_thai = 'requested'");
            $kpis['payouts'] = (int)Model::scalar("SELECT COUNT(*) FROM dot_chi_tra WHERE trang_thai IN ('requested','processing')");
        }
        $this->render('admin/dashboard', [
            'pageTitle' => 'Quản trị',
            'isAdmin' => $isAdmin,
            'kpis' => $kpis,
            'reviewQueue' => Model::query("SELECT g.ma, g.tieu_de, g.duong_dan_rut_gon, g.ngay_cap_nhat, u.ten_hien_thi
                FROM tro_choi g JOIN nguoi_dung u ON u.ma = g.nguoi_tao_id WHERE g.trang_thai = 'under_review' ORDER BY g.ngay_cap_nhat LIMIT 6"),
            'reports' => Model::query("SELECT b.ma, b.loai_doi_tuong, b.doi_tuong_id, b.ma_ly_do, b.trang_thai, b.ngay_tao, u.ten_hien_thi
                FROM bao_cao_noi_dung b LEFT JOIN nguoi_dung u ON u.ma = b.nguoi_bao_cao_id
                WHERE b.trang_thai IN ('open','investigating') ORDER BY b.ngay_tao LIMIT 6"),
            'actions' => Model::query("SELECT h.loai_doi_tuong, h.doi_tuong_id, h.loai_hanh_dong, h.ly_do, h.ngay_tao, u.ten_hien_thi
                FROM hanh_dong_kiem_duyet h JOIN nguoi_dung u ON u.ma = h.nguoi_kiem_duyet_id ORDER BY h.ngay_tao DESC, h.ma DESC LIMIT 8"),
            'newUsers' => $isAdmin ? Model::query('SELECT ma, ten_dang_nhap, ten_hien_thi, url_anh_dai_dien, trang_thai, ngay_tao FROM nguoi_dung ORDER BY ngay_tao DESC, ma DESC LIMIT 6') : [],
        ]);
    }

    // ------------------------------------------------------------- users -----

    public function users(array $params = []) {
        $this->requireRole('admin');
        $filters = [
            'q' => mb_substr(trim((string)($_GET['q'] ?? '')), 0, 100),
            'status' => (string)($_GET['status'] ?? ''),
            'role' => (string)($_GET['role'] ?? ''),
        ];
        $total = UserModel::countForAdmin($filters['q'], $filters['status'], $filters['role']);
        $pages = max(1, (int)ceil($total / self::PER_PAGE));
        $page = min($this->page(), $pages);
        $this->render('admin/users', [
            'pageTitle' => 'Người dùng',
            'filters' => $filters,
            'users' => UserModel::listForAdmin($filters['q'], $filters['status'], $filters['role'], self::PER_PAGE, ($page - 1) * self::PER_PAGE),
            'total' => $total, 'page' => $page, 'pages' => $pages,
        ]);
    }

    public function user(array $params = []) {
        $this->requireRole('admin');
        $account = $this->account($params);
        $id = (int)$account['ma'];
        $this->render('admin/user', [
            'pageTitle' => $account['ten_hien_thi'],
            'account' => $account,
            'roles' => RoleModel::getAll(),
            'userRoles' => array_column(UserModel::getRoles($id), 'ma_vai_tro'),
            'owned' => Model::query('SELECT g.ma, g.tieu_de, g.duong_dan_rut_gon, o.loai_nhan_quyen, o.trang_thai, o.ngay_nhan_quyen
                FROM quyen_so_huu_tro_choi o JOIN tro_choi g ON g.ma = o.tro_choi_id WHERE o.nguoi_dung_id = :u ORDER BY o.ngay_nhan_quyen DESC LIMIT 50', [':u' => $id]),
            'created' => Model::query('SELECT ma, tieu_de, duong_dan_rut_gon, trang_thai FROM tro_choi WHERE nguoi_tao_id = :u ORDER BY ngay_tao DESC', [':u' => $id]),
            'stats' => Model::one("SELECT
                    (SELECT COUNT(*) FROM don_hang d WHERE d.nguoi_mua_id = :u1) AS don_hang,
                    (SELECT COUNT(*) FROM danh_gia r WHERE r.nguoi_dung_id = :u2) AS danh_gia,
                    (SELECT COUNT(*) FROM bao_cao_noi_dung b WHERE b.loai_doi_tuong = 'user' AND b.doi_tuong_id = :u3) AS bi_bao_cao,
                    (SELECT COUNT(*) FROM bao_cao_noi_dung b WHERE b.nguoi_bao_cao_id = :u4) AS da_bao_cao",
                [':u1' => $id, ':u2' => $id, ':u3' => $id, ':u4' => $id]),
            'actions' => Model::query("SELECT h.loai_hanh_dong, h.ly_do, h.ngay_tao, u.ten_hien_thi FROM hanh_dong_kiem_duyet h
                JOIN nguoi_dung u ON u.ma = h.nguoi_kiem_duyet_id WHERE h.loai_doi_tuong = 'user' AND h.doi_tuong_id = :u ORDER BY h.ngay_tao DESC LIMIT 20", [':u' => $id]),
            'grantable' => Model::query("SELECT ma, tieu_de FROM tro_choi WHERE trang_thai IN ('published','unlisted','hidden','under_review')
                AND ma NOT IN (SELECT tro_choi_id FROM quyen_so_huu_tro_choi WHERE nguoi_dung_id = :u AND trang_thai = 'active') ORDER BY tieu_de", [':u' => $id]),
            'isSelf' => $id === current_user_id(),
        ]);
    }

    public function updateRoles(array $params = []) {
        $this->requireRole('admin');
        $account = $this->account($params);
        $id = (int)$account['ma'];
        $back = '/admin/users/' . $id . '#roles';
        $byCode = array_column(RoleModel::getAll(), 'ma', 'ma_vai_tro');
        $codes = array_values(array_intersect(array_keys($byCode), array_map('strval', (array)($_POST['vai_tro'] ?? []))));
        if (!$codes) {
            $this->fail('Tài khoản cần ít nhất một vai trò.', $back);
        }
        if ($id === current_user_id() && !in_array('admin', $codes, true)) {
            $this->fail('Bạn không thể tự gỡ quyền quản trị của chính mình.', $back);
        }
        $before = array_column(UserModel::getRoles($id), 'ma_vai_tro');
        if (!UserModel::syncRoles($id, array_map(static fn($c) => (int)$byCode[$c], $codes))) {
            $this->fail('Không thể gỡ quản trị viên đang hoạt động cuối cùng.', $back);
        }
        audit('user_roles', 'nguoi_dung', $id, ['truoc' => $before, 'sau' => $codes]);
        flash('success', 'Đã cập nhật vai trò của ' . $account['ten_hien_thi'] . '.');
        $this->redirect($back);
    }

    public function updateUserStatus(array $params = []) {
        $moderator = $this->requireRole('admin');
        $account = $this->account($params);
        $id = (int)$account['ma'];
        $back = '/admin/users/' . $id . '#status';
        $status = (string)($_POST['trang_thai'] ?? '');
        $reason = post_str('ly_do', 1000);
        if ($reason === null) {
            $this->fail('Lý do tối đa 1.000 ký tự.', $back);
        }
        if (!in_array($status, ['active', 'suspended'], true)) {
            $this->fail('Trạng thái không hợp lệ.', $back);
        }
        if ($status === $account['trang_thai']) {
            $this->fail('Tài khoản đã ở trạng thái này.', $back);
        }
        if ($account['trang_thai'] === 'deleted') {
            $this->fail('Tài khoản đã xóa không thể đổi trạng thái tại đây.', $back);
        }
        if ($status === 'suspended') {
            if ($id === current_user_id()) {
                $this->fail('Bạn không thể tự đình chỉ tài khoản của mình.', $back);
            }
            if ($reason === '') {
                $this->fail('Hãy ghi lý do đình chỉ.', $back);
            }
        }
        $done = Model::transaction(function () use ($id, $status, $reason, $moderator) {
            $admin = RoleModel::findByCode('admin');
            if ($status === 'suspended' && $admin) {
                Model::query('SELECT ma FROM vai_tro WHERE ma = :r FOR UPDATE', [':r' => (int)$admin['ma']]);
                $isAdmin = (int)Model::scalar('SELECT COUNT(*) FROM nguoi_dung_vai_tro WHERE nguoi_dung_id = :u AND vai_tro_id = :r', [':u' => $id, ':r' => (int)$admin['ma']]);
                $active = (int)Model::scalar("SELECT COUNT(*) FROM nguoi_dung_vai_tro x JOIN nguoi_dung u ON u.ma = x.nguoi_dung_id WHERE x.vai_tro_id = :r AND u.trang_thai = 'active'", [':r' => (int)$admin['ma']]);
                if ($isAdmin && $active <= 1) {
                    return false;
                }
            }
            UserModel::update($id, ['trang_thai' => $status]);
            ModerationActionModel::log((int)$moderator['ma'], 'user', $id, $status === 'suspended' ? 'suspend' : 'restore', $reason);
            return true;
        });
        if (!$done) {
            $this->fail('Không thể đình chỉ quản trị viên đang hoạt động cuối cùng.', $back);
        }
        audit('user_status', 'nguoi_dung', $id, ['trang_thai' => $status]);
        flash('success', $status === 'suspended' ? 'Đã đình chỉ tài khoản.' : 'Đã khôi phục tài khoản.');
        $this->redirect($back);
    }

    public function grantGame(array $params = []) {
        $admin = $this->requireRole('admin');
        $account = $this->account($params);
        $id = (int)$account['ma'];
        $back = '/admin/users/' . $id . '#library';
        $game = Model::one("SELECT ma, tieu_de, duong_dan_rut_gon FROM tro_choi WHERE ma = :g AND trang_thai <> 'draft'", [':g' => post_int('tro_choi_id')]);
        if (!$game) {
            $this->fail('Chọn một trò chơi hợp lệ.', $back);
        }
        if ($account['trang_thai'] !== 'active') {
            $this->fail('Chỉ cấp quyền cho tài khoản đang hoạt động.', $back);
        }
        $granted = Model::transaction(fn() => OwnershipModel::grant($id, (int)$game['ma'], 'admin_grant'));
        if (!$granted) {
            $this->fail('Người dùng đã sở hữu trò chơi này.', $back);
        }
        audit('ownership_grant', 'tro_choi', (int)$game['ma'], ['nguoi_dung_id' => $id]);
        NotificationModel::notifyUsers([$id], (int)$admin['ma'], 'ownership_grant', 'Bạn được cấp quyền sở hữu ' . $game['tieu_de'],
            'Trò chơi đã có trong thư viện của bạn.', '/library');
        flash('success', 'Đã cấp ' . $game['tieu_de'] . ' cho ' . $account['ten_hien_thi'] . '.');
        $this->redirect($back);
    }

    // ------------------------------------------------------------- games -----

    public function games(array $params = []) {
        $this->requireRole('moderator', 'admin');
        $filters = [
            'q' => mb_substr(trim((string)($_GET['q'] ?? '')), 0, 100),
            'status' => (string)($_GET['status'] ?? ''),
        ];
        $total = GameModel::countForAdmin($filters['q'], $filters['status']);
        $pages = max(1, (int)ceil($total / self::PER_PAGE));
        $page = min($this->page(), $pages);
        $this->render('admin/games', [
            'pageTitle' => 'Trò chơi',
            'filters' => $filters,
            'games' => GameModel::listForAdmin($filters['q'], $filters['status'], self::PER_PAGE, ($page - 1) * self::PER_PAGE),
            'counts' => array_column(Model::query('SELECT trang_thai, COUNT(*) AS n FROM tro_choi GROUP BY trang_thai'), 'n', 'trang_thai'),
            'staffStatuses' => GameModel::STAFF_STATUSES,
            'total' => $total, 'page' => $page, 'pages' => $pages,
        ]);
    }

    public function updateGameStatus(array $params = []) {
        $moderator = $this->requireRole('moderator', 'admin');
        $back = safe_return((string)($_POST['return_to'] ?? ''), '/admin/games');
        $game = Model::one('SELECT ma, tieu_de, duong_dan_rut_gon, trang_thai, nguoi_tao_id FROM tro_choi WHERE ma = :g', [':g' => (int)($params['id'] ?? 0)]);
        if (!$game) {
            $this->notFound('Không tìm thấy trò chơi.');
        }
        $status = (string)($_POST['trang_thai'] ?? '');
        $reason = post_str('ly_do', 1000);
        $error = $reason === null ? 'Lý do tối đa 1.000 ký tự.' : GameModel::staffSetStatus($game, $status, (int)$moderator['ma'], $reason);
        if ($error !== null) {
            $this->fail($error, $back);
        }
        flash('success', 'Đã chuyển ' . $game['tieu_de'] . ' sang "' . label('game_status', $status) . '".');
        $this->redirect($back);
    }

    // ------------------------------------------------------------- audit -----

    public function audit(array $params = []) {
        $this->requireRole('admin');
        $filters = [
            'action' => mb_substr(trim((string)($_GET['action'] ?? '')), 0, 100),
            'user' => mb_substr(trim((string)($_GET['user'] ?? '')), 0, 100),
        ];
        $where = ['1=1'];
        $args = [];
        if ($filters['action'] !== '') {
            $where[] = 'l.ma_hanh_dong LIKE :a';
            $args[':a'] = $filters['action'] . '%';
        }
        if ($filters['user'] !== '') {
            $where[] = '(u.ten_dang_nhap = :u1 OR u.email = :u2)';
            $args += [':u1' => $filters['user'], ':u2' => $filters['user']];
        }
        $sqlWhere = implode(' AND ', $where);
        $total = (int)Model::scalar("SELECT COUNT(*) FROM nhat_ky_he_thong l LEFT JOIN nguoi_dung u ON u.ma = l.nguoi_dung_id WHERE $sqlWhere", $args);
        $per = 50;
        $pages = max(1, (int)ceil($total / $per));
        $page = min($this->page(), $pages);
        $this->render('admin/audit', [
            'pageTitle' => 'Nhật ký hệ thống',
            'filters' => $filters,
            'actions' => Model::column('SELECT DISTINCT ma_hanh_dong FROM nhat_ky_he_thong ORDER BY ma_hanh_dong'),
            'rows' => Model::query("SELECT l.*, u.ten_dang_nhap, u.ten_hien_thi FROM nhat_ky_he_thong l LEFT JOIN nguoi_dung u ON u.ma = l.nguoi_dung_id
                WHERE $sqlWhere ORDER BY l.ngay_tao DESC, l.ma DESC LIMIT :lim OFFSET :off", $args + [':lim' => $per, ':off' => ($page - 1) * $per]),
            'total' => $total, 'page' => $page, 'pages' => $pages,
        ]);
    }

    private function account(array $params): array {
        $account = Model::one('SELECT ma, ten_dang_nhap, email, ten_hien_thi, gioi_thieu, url_anh_dai_dien, url_website, ngay_xac_minh_email, trang_thai, ngay_tao, ngay_cap_nhat
            FROM nguoi_dung WHERE ma = :u', [':u' => (int)($params['id'] ?? 0)]);
        if (!$account) {
            $this->notFound('Không tìm thấy người dùng.');
        }
        return $account;
    }
}
