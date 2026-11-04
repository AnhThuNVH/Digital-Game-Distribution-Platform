<?php
// =============================================================================
// PROFILE CONTROLLER - Tables: nguoi_dung, cai_dat_nguoi_dung, theo_doi_nguoi_dung,
// tac_gia_tro_choi, tro_choi, quyen_so_huu_tro_choi, danh_gia, bo_suu_tap
// Public profile at /u/{username}. Privacy comes from cai_dat_nguoi_dung:
// a private profile shows only name and avatar to everyone except its owner and staff.
// =============================================================================

class ProfileController extends Controller {
    public function show(array $params = []) {
        $profile = UserModel::findByUsername((string)($params['username'] ?? ''));
        if (!$profile || $profile['trang_thai'] === 'deleted') {
            $this->notFound('Không tìm thấy người dùng này.');
        }
        $pid = (int)$profile['ma'];
        $viewer = current_user_id();
        $isSelf = $viewer === $pid;
        $settings = UserModel::settings($pid);
        $canSee = $isSelf || is_staff() || $settings['pham_vi_hien_thi_ho_so'] !== 'private';
        if ($profile['trang_thai'] === 'suspended' && !$isSelf && !is_staff()) {
            $canSee = false;
        }

        $data = [
            'pageTitle' => $profile['ten_hien_thi'],
            'profile' => UserModel::publicFields($profile),
            'isSelf' => $isSelf,
            'libraryPublic' => (int)$settings['hien_thi_game_so_huu'] === 1 && $settings['pham_vi_hien_thi_ho_so'] !== 'private',
            'canSee' => $canSee,
            'isFollowing' => $viewer && !$isSelf ? FollowModel::isFollowing($viewer, $pid) : false,
            'followers' => (int)Model::scalar('SELECT COUNT(*) FROM theo_doi_nguoi_dung WHERE nguoi_duoc_theo_doi_id = :u', [':u' => $pid]),
            'following' => (int)Model::scalar('SELECT COUNT(*) FROM theo_doi_nguoi_dung WHERE nguoi_theo_doi_id = :u', [':u' => $pid]),
            'published' => [], 'owned' => [], 'ownedTotal' => 0, 'showLibrary' => false, 'reviews' => [], 'collections' => [],
        ];

        if ($canSee) {
            $data['published'] = Model::query('SELECT ' . GameModel::cardColumns() . " FROM tro_choi g
                WHERE g.trang_thai = 'published' AND (g.nguoi_tao_id = :u1 OR EXISTS (SELECT 1 FROM tac_gia_tro_choi a WHERE a.tro_choi_id = g.ma AND a.nguoi_dung_id = :u2))
                ORDER BY COALESCE(g.ngay_cong_bo, g.ngay_tao) DESC", [':u1' => $pid, ':u2' => $pid]);
            $data['showLibrary'] = $isSelf || (int)$settings['hien_thi_game_so_huu'] === 1;
            if ($data['showLibrary']) {
                $data['ownedTotal'] = (int)Model::scalar("SELECT COUNT(*) FROM quyen_so_huu_tro_choi o JOIN tro_choi g ON g.ma = o.tro_choi_id
                    WHERE o.nguoi_dung_id = :u AND o.trang_thai = 'active' AND g.trang_thai = 'published'", [':u' => $pid]);
                $data['owned'] = Model::query('SELECT ' . GameModel::cardColumns() . " FROM quyen_so_huu_tro_choi o JOIN tro_choi g ON g.ma = o.tro_choi_id
                    WHERE o.nguoi_dung_id = :u AND o.trang_thai = 'active' AND g.trang_thai = 'published'
                    ORDER BY o.ngay_nhan_quyen DESC LIMIT 12", [':u' => $pid]);
            }
            $data['reviews'] = Model::query("SELECT r.ma, r.diem_danh_gia, r.tieu_de, r.noi_dung_danh_gia, r.da_xac_minh_so_huu, r.ngay_tao,
                    g.tieu_de game_title, g.duong_dan_rut_gon
                FROM danh_gia r JOIN tro_choi g ON g.ma = r.tro_choi_id
                WHERE r.nguoi_dung_id = :u AND r.trang_thai = 'published' AND g.trang_thai = 'published'
                ORDER BY r.ngay_tao DESC LIMIT 6", [':u' => $pid]);
            $data['collections'] = Model::query("SELECT c.ma, c.tieu_de, c.duong_dan_rut_gon, c.mo_ta,
                    (SELECT COUNT(*) FROM tro_choi_bo_suu_tap i WHERE i.bo_suu_tap_id = c.ma) so_muc
                FROM bo_suu_tap c WHERE c.nguoi_dung_so_huu_id = :u AND c.pham_vi_hien_thi = 'public' ORDER BY c.ngay_cap_nhat DESC LIMIT 6", [':u' => $pid]);
        }
        $this->render('profile/show', $data);
    }

    public function follow(array $params = []) {
        $user = $this->requireAuth();
        $profile = UserModel::findByUsername((string)($params['username'] ?? ''));
        if (!$profile || $profile['trang_thai'] !== 'active') {
            $this->notFound('Không tìm thấy người dùng này.');
        }
        $uid = (int)$user['ma'];
        $pid = (int)$profile['ma'];
        if ($uid === $pid) {
            $this->fail('Bạn không thể tự theo dõi chính mình.', '/u/' . rawurlencode($profile['ten_dang_nhap']));
        }
        if (FollowModel::isFollowing($uid, $pid)) {
            FollowModel::unfollow($uid, $pid);
            flash('success', 'Đã bỏ theo dõi ' . $profile['ten_hien_thi'] . '.');
        } else {
            FollowModel::follow($uid, $pid);
            NotificationModel::create($pid, 'follow', $user['ten_hien_thi'] . ' đã theo dõi bạn', '', '/u/' . rawurlencode($user['ten_dang_nhap']));
            flash('success', 'Đang theo dõi ' . $profile['ten_hien_thi'] . '. Bạn sẽ được báo khi họ phát hành trò chơi hoặc nhật ký mới.');
        }
        $this->back('/u/' . rawurlencode($profile['ten_dang_nhap']));
    }

    /** Old /author/{id} links. */
    public function legacy(array $params = []) {
        $username = Model::scalar("SELECT ten_dang_nhap FROM nguoi_dung WHERE ma = :id AND trang_thai <> 'deleted'", [':id' => (int)($params['id'] ?? 0)]);
        if (!$username) {
            $this->notFound('Không tìm thấy người dùng này.');
        }
        $this->redirect('/u/' . rawurlencode((string)$username));
    }
}
