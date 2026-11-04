<?php
// =============================================================================
// JAM ADMIN CONTROLLER - /admin/jams. Tables: cuoc_thi_lam_game,
// thanh_vien_cuoc_thi, bai_du_thi, dien_dan (optional jam board).
// =============================================================================

class JamAdminController extends Controller {
    public function index(array $params = []) {
        $this->requireRole('admin');
        $jams = Model::query("SELECT j.*, u.ten_hien_thi,
                (SELECT COUNT(*) FROM bai_du_thi e WHERE e.cuoc_thi_id = j.ma AND e.trang_thai = 'submitted') AS so_bai,
                (SELECT COUNT(DISTINCT v.nguoi_binh_chon_id) FROM binh_chon_bai_du_thi v JOIN bai_du_thi e ON e.ma = v.bai_du_thi_id WHERE e.cuoc_thi_id = j.ma) AS so_nguoi_cham
            FROM cuoc_thi_lam_game j JOIN nguoi_dung u ON u.ma = j.nguoi_tao_id ORDER BY j.ngay_bat_dau DESC, j.ma DESC");
        [$jams, $pager] = $this->paginate($jams, 20);
        $this->render('admin/jams', ['pageTitle' => 'Quản lý game jam', 'jams' => $jams] + $pager);
    }

    public function create(array $params = []) {
        $this->requireRole('admin');
        $this->render('admin/jam-form', ['pageTitle' => 'Tạo cuộc thi', 'jam' => null, 'members' => [], 'entries' => [], 'board' => null]);
    }

    public function store(array $params = []) {
        $user = $this->requireRole('admin');
        $row = $this->validated(null, '/admin/jams/new');
        $id = JamModel::transaction(function () use ($row, $user) {
            $id = JamModel::insert($row + ['nguoi_tao_id' => (int)$user['ma']]);
            Model::run("INSERT INTO thanh_vien_cuoc_thi (cuoc_thi_id, nguoi_dung_id, vai_tro_thanh_vien) VALUES (:j, :u, 'host')", [':j' => $id, ':u' => (int)$user['ma']]);
            if (post_bool('tao_dien_dan')) {
                Model::run("INSERT INTO dien_dan (loai_dien_dan, cuoc_thi_id, tieu_de, mo_ta, cong_khai) VALUES ('jam', :j, :t, NULL, 1)", [':j' => $id, ':t' => mb_substr('Thảo luận ' . $row['tieu_de'], 0, 180)]);
            }
            return $id;
        });
        audit('jam_create', 'cuoc_thi_lam_game', $id);
        flash('success', 'Đã tạo cuộc thi "' . $row['tieu_de'] . '".');
        $this->redirect('/admin/jams/' . $id);
    }

    public function edit(array $params = []) {
        $this->requireRole('admin');
        $jam = $this->jam($params);
        $this->render('admin/jam-form', [
            'pageTitle' => 'Sửa ' . $jam['tieu_de'],
            'jam' => $jam,
            'members' => JamModel::members((int)$jam['ma']),
            'entries' => JamModel::entries((int)$jam['ma'], true),
            'board' => Model::one('SELECT ma, tieu_de FROM dien_dan WHERE cuoc_thi_id = :j', [':j' => (int)$jam['ma']]),
        ]);
    }

    public function update(array $params = []) {
        $this->requireRole('admin');
        $jam = $this->jam($params);
        $id = (int)$jam['ma'];
        $row = $this->validated($jam, '/admin/jams/' . $id);
        JamModel::transaction(function () use ($row, $id) {
            JamModel::update($id, $row + ['ngay_cap_nhat' => date('Y-m-d H:i:s')]);
            if (post_bool('tao_dien_dan') && !Model::scalar('SELECT 1 FROM dien_dan WHERE cuoc_thi_id = :j', [':j' => $id])) {
                Model::run("INSERT INTO dien_dan (loai_dien_dan, cuoc_thi_id, tieu_de, cong_khai) VALUES ('jam', :j, :t, 1)", [':j' => $id, ':t' => mb_substr('Thảo luận ' . $row['tieu_de'], 0, 180)]);
            }
        });
        audit('jam_update', 'cuoc_thi_lam_game', $id, ['trang_thai' => $row['trang_thai']]);
        if ($row['trang_thai'] === 'completed' && $jam['trang_thai'] !== 'completed') {
            $entrants = array_map('intval', Model::column("SELECT DISTINCT nguoi_nop_id FROM bai_du_thi WHERE cuoc_thi_id = :j AND trang_thai = 'submitted'", [':j' => $id]));
            NotificationModel::notifyUsers($entrants, current_user_id(), 'jam_results', 'Đã có kết quả ' . $row['tieu_de'], 'Xem thứ hạng và điểm của bài dự thi.', '/jams/' . rawurlencode($row['duong_dan_rut_gon']) . '#entries');
        }
        flash('success', 'Đã lưu cuộc thi.');
        $this->redirect('/admin/jams/' . $id);
    }

    public function addMember(array $params = []) {
        $this->requireRole('admin');
        $jam = $this->jam($params);
        $back = '/admin/jams/' . (int)$jam['ma'] . '#members';
        $login = trim((string)($_POST['nguoi_dung'] ?? ''));
        $role = (string)($_POST['vai_tro_thanh_vien'] ?? '');
        if (!array_key_exists($role, labels('jam_role'))) {
            $this->fail('Vai trò không hợp lệ.', $back);
        }
        $member = Model::one("SELECT ma, ten_hien_thi FROM nguoi_dung WHERE (ten_dang_nhap = :a OR email = :b) AND trang_thai = 'active'", [':a' => $login, ':b' => $login]);
        if (!$member) {
            $this->fail('Không tìm thấy người dùng đang hoạt động với tên đăng nhập hoặc email này.', $back);
        }
        Model::run('INSERT INTO thanh_vien_cuoc_thi (cuoc_thi_id, nguoi_dung_id, vai_tro_thanh_vien) VALUES (:j, :u, :r)
            ON DUPLICATE KEY UPDATE vai_tro_thanh_vien = VALUES(vai_tro_thanh_vien)', [':j' => (int)$jam['ma'], ':u' => (int)$member['ma'], ':r' => $role]);
        audit('jam_member_set', 'cuoc_thi_lam_game', (int)$jam['ma'], ['user' => (int)$member['ma'], 'role' => $role]);
        NotificationModel::notifyUsers([(int)$member['ma']], current_user_id(), 'jam_member', 'Bạn được thêm vào ban tổ chức ' . $jam['tieu_de'], 'Vai trò: ' . label('jam_role', $role), '/jams/' . rawurlencode($jam['duong_dan_rut_gon']));
        flash('success', 'Đã thêm ' . $member['ten_hien_thi'] . ' với vai trò ' . label('jam_role', $role) . '.');
        $this->redirect($back);
    }

    public function removeMember(array $params = []) {
        $this->requireRole('admin');
        $jam = $this->jam($params);
        $back = '/admin/jams/' . (int)$jam['ma'] . '#members';
        $userId = (int)($params['user'] ?? 0);
        $role = JamModel::memberRole((int)$jam['ma'], $userId);
        if (!$role) {
            $this->notFound('Người này không thuộc ban tổ chức.');
        }
        if ($role === 'host' && (int)Model::scalar("SELECT COUNT(*) FROM thanh_vien_cuoc_thi WHERE cuoc_thi_id = :j AND vai_tro_thanh_vien = 'host'", [':j' => (int)$jam['ma']]) <= 1) {
            $this->fail('Cuộc thi cần ít nhất một người chủ trì.', $back);
        }
        Model::run('DELETE FROM thanh_vien_cuoc_thi WHERE cuoc_thi_id = :j AND nguoi_dung_id = :u', [':j' => (int)$jam['ma'], ':u' => $userId]);
        audit('jam_member_remove', 'cuoc_thi_lam_game', (int)$jam['ma'], ['user' => $userId]);
        flash('success', 'Đã gỡ khỏi ban tổ chức.');
        $this->redirect($back);
    }

    /** Disqualify an entry or reinstate it. Withdrawing is the entrant's own action. */
    public function entryStatus(array $params = []) {
        $this->requireRole('admin');
        $jam = $this->jam($params);
        $back = '/admin/jams/' . (int)$jam['ma'] . '#entries';
        $entry = JamModel::entry((int)$jam['ma'], (int)($params['entry'] ?? 0));
        if (!$entry) {
            $this->notFound('Không tìm thấy bài dự thi.');
        }
        $status = (string)($_POST['trang_thai'] ?? '');
        if (!in_array($status, ['submitted', 'disqualified'], true) || $status === $entry['trang_thai']) {
            $this->fail('Trạng thái không hợp lệ.', $back);
        }
        $reason = post_str('ly_do', 500);
        if ($status === 'disqualified' && ($reason === null || $reason === '')) {
            $this->fail('Hãy ghi lý do loại bài (tối đa 500 ký tự). Lý do được gửi cho người nộp.', $back);
        }
        Model::run('UPDATE bai_du_thi SET trang_thai = :s WHERE ma = :e', [':s' => $status, ':e' => (int)$entry['ma']]);
        audit('jam_entry_' . $status, 'bai_du_thi', (int)$entry['ma'], ['reason' => $reason]);
        NotificationModel::notifyUsers([(int)$entry['nguoi_nop_id']], current_user_id(), 'jam_entry_status',
            ($status === 'disqualified' ? 'Bài dự thi bị loại: ' : 'Bài dự thi được khôi phục: ') . $entry['game_title'],
            $status === 'disqualified' ? 'Lý do: ' . $reason : 'Bài của bạn đã trở lại cuộc thi ' . $jam['tieu_de'] . '.',
            '/jams/' . rawurlencode($jam['duong_dan_rut_gon']));
        flash('success', $status === 'disqualified' ? 'Đã loại bài dự thi.' : 'Đã khôi phục bài dự thi.');
        $this->redirect($back);
    }

    // ------------------------------------------------------------------ helpers

    private function jam(array $params): array {
        $jam = Model::one('SELECT * FROM cuoc_thi_lam_game WHERE ma = :id', [':id' => (int)($params['id'] ?? 0)]);
        if (!$jam) {
            $this->notFound('Không tìm thấy cuộc thi.');
        }
        return $jam;
    }

    private function validated(?array $jam, string $back): array {
        $errors = [];
        $title = post_str('tieu_de', 200);
        if ($title === null || mb_strlen($title) < 3) {
            $errors[] = 'Tên cuộc thi cần 3–200 ký tự.';
        }
        $slug = trim((string)($_POST['duong_dan_rut_gon'] ?? ''));
        $slug = $slug === '' ? slugify((string)$title) : $slug;
        if (!preg_match('/^[a-z0-9]+(?:-[a-z0-9]+)*$/', $slug) || strlen($slug) > 220) {
            $errors[] = 'Đường dẫn chỉ gồm chữ thường không dấu, số và dấu gạch ngang.';
        } elseif (Model::scalar('SELECT 1 FROM cuoc_thi_lam_game WHERE duong_dan_rut_gon = :s AND ma <> :id', [':s' => $slug, ':id' => (int)($jam['ma'] ?? 0)])) {
            $errors[] = 'Đường dẫn "' . $slug . '" đã được cuộc thi khác dùng.';
        }
        $description = post_str('mo_ta', 20000);
        $rules = post_str('the_le', 20000);
        if ($description === null || $rules === null) {
            $errors[] = 'Giới thiệu và thể lệ tối đa 20.000 ký tự mỗi phần.';
        }
        $status = (string)($_POST['trang_thai'] ?? 'draft');
        if (!in_array($status, JamModel::STATUSES, true)) {
            $errors[] = 'Trạng thái không hợp lệ.';
        }
        $start = parse_datetime($_POST['ngay_bat_dau'] ?? '');
        $deadline = parse_datetime($_POST['han_nop_bai'] ?? '');
        $voteStart = parse_datetime($_POST['ngay_bat_dau_binh_chon'] ?? '');
        $voteEnd = parse_datetime($_POST['ngay_ket_thuc_binh_chon'] ?? '');
        $voting = post_bool('bat_binh_chon');
        if (!$start || !$deadline) {
            $errors[] = 'Cần ngày bắt đầu và hạn nộp bài.';
        } elseif ($deadline <= $start) {
            $errors[] = 'Hạn nộp bài phải sau ngày bắt đầu.';
        }
        if ($voteStart && $deadline && $voteStart < $deadline) {
            $errors[] = 'Bình chọn chỉ mở sau hạn nộp bài.';
        }
        if ($voteEnd && ($voteEnd <= ($voteStart ?: $deadline))) {
            $errors[] = 'Ngày đóng bình chọn phải sau ngày mở bình chọn.';
        }
        if ($errors) {
            $this->fail(implode(' ', $errors), $back);
        }
        return [
            'tieu_de' => $title,
            'duong_dan_rut_gon' => $slug,
            'mo_ta' => $description !== '' ? $description : null,
            'the_le' => $rules !== '' ? $rules : null,
            'ngay_bat_dau' => $start,
            'han_nop_bai' => $deadline,
            'ngay_bat_dau_binh_chon' => $voting ? $voteStart : null,
            'ngay_ket_thuc_binh_chon' => $voting ? $voteEnd : null,
            'bat_binh_chon' => $voting,
            'trang_thai' => $status,
        ];
    }
}
