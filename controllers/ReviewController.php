<?php
// =============================================================================
// REVIEW CONTROLLER - Tables: danh_gia, binh_chon_danh_gia
// One review per player per game (uq_reviews_user_game). Authors cannot review
// their own game. Editing never lifts a moderator's hide/remove.
// =============================================================================

class ReviewController extends Controller {

    public function save(array $params = []) {
        $user = $this->requireAuth();
        $game = $this->publishedGame($params);
        $uid = (int)$user['ma'];
        $gid = (int)$game['ma'];
        $to = '/games/' . rawurlencode($game['duong_dan_rut_gon']) . '#reviews';

        if (!(int)$game['cho_phep_danh_gia']) {
            $this->fail('Nhà phát triển đã tắt đánh giá cho trò chơi này.', $to);
        }
        if (GameModel::isAuthor($gid, $uid)) {
            $this->fail('Bạn không thể đánh giá trò chơi do chính mình phát triển.', $to);
        }
        $rating = (int)($_POST['diem'] ?? 0);
        $title = trim((string)($_POST['tieu_de'] ?? ''));
        $body = trim((string)($_POST['noi_dung'] ?? ''));
        if ($rating < 1 || $rating > 5) {
            $this->fail('Hãy chọn điểm từ 1 đến 5.', $to);
        }
        if (mb_strlen($title) > 200) {
            $this->fail('Tiêu đề tối đa 200 ký tự.', $to);
        }
        if (mb_strlen($body) > 10000) {
            $this->fail('Nhận xét tối đa 10.000 ký tự.', $to);
        }
        $verified = OwnershipModel::has($uid, $gid) ? 1 : 0;
        $existing = Model::one('SELECT ma FROM danh_gia WHERE tro_choi_id = :g AND nguoi_dung_id = :u', [':g' => $gid, ':u' => $uid]);
        if ($existing) {
            Model::run('UPDATE danh_gia SET diem_danh_gia = :r, tieu_de = :t, noi_dung_danh_gia = :b, da_xac_minh_so_huu = :v WHERE ma = :id', [
                ':r' => $rating, ':t' => $title !== '' ? $title : null, ':b' => $body !== '' ? $body : null, ':v' => $verified, ':id' => (int)$existing['ma'],
            ]);
            flash('success', 'Đã cập nhật đánh giá của bạn.');
        } else {
            Model::run('INSERT INTO danh_gia (tro_choi_id, nguoi_dung_id, diem_danh_gia, tieu_de, noi_dung_danh_gia, da_xac_minh_so_huu) VALUES (:g, :u, :r, :t, :b, :v)', [
                ':g' => $gid, ':u' => $uid, ':r' => $rating, ':t' => $title !== '' ? $title : null, ':b' => $body !== '' ? $body : null, ':v' => $verified,
            ]);
            NotificationModel::notifyUsers(GameModel::authorIds($gid), $uid, 'review', 'Đánh giá mới cho ' . $game['tieu_de'],
                $user['ten_hien_thi'] . ' chấm ' . $rating . '/5.', '/games/' . $game['duong_dan_rut_gon'] . '#reviews');
            flash('success', 'Cảm ơn bạn đã đánh giá.');
        }
        $this->redirect($to);
    }

    public function delete(array $params = []) {
        $user = $this->requireAuth();
        $game = $this->publishedGame($params);
        $deleted = Model::run('DELETE FROM danh_gia WHERE tro_choi_id = :g AND nguoi_dung_id = :u', [':g' => (int)$game['ma'], ':u' => (int)$user['ma']]);
        flash($deleted ? 'success' : 'info', $deleted ? 'Đã xóa đánh giá của bạn.' : 'Bạn chưa có đánh giá nào để xóa.');
        $this->redirect('/games/' . rawurlencode($game['duong_dan_rut_gon']) . '#reviews');
    }

    /** Helpful / not helpful. The same choice twice removes the vote. */
    public function vote(array $params = []) {
        $user = $this->requireAuth();
        $uid = (int)$user['ma'];
        $review = Model::one("SELECT r.ma, r.nguoi_dung_id, g.duong_dan_rut_gon FROM danh_gia r JOIN tro_choi g ON g.ma = r.tro_choi_id
            WHERE r.ma = :id AND r.trang_thai = 'published' AND g.trang_thai IN ('published','unlisted')", [':id' => (int)($params['id'] ?? 0)]);
        if (!$review) {
            $this->notFound('Không tìm thấy đánh giá này.');
        }
        $fallback = '/games/' . rawurlencode($review['duong_dan_rut_gon']) . '#review-' . (int)$review['ma'];
        if ((int)$review['nguoi_dung_id'] === $uid) {
            flash('error', 'Bạn không thể bình chọn cho đánh giá của chính mình.');
            $this->back($fallback);
        }
        $helpful = ($_POST['co_ich'] ?? '') === '1' ? 1 : 0;
        $current = Model::scalar('SELECT co_ich FROM binh_chon_danh_gia WHERE danh_gia_id = :r AND nguoi_dung_id = :u', [':r' => (int)$review['ma'], ':u' => $uid]);
        if ($current !== null && $current !== false && (int)$current === $helpful) {
            Model::run('DELETE FROM binh_chon_danh_gia WHERE danh_gia_id = :r AND nguoi_dung_id = :u', [':r' => (int)$review['ma'], ':u' => $uid]);
        } else {
            Model::run('INSERT INTO binh_chon_danh_gia (danh_gia_id, nguoi_dung_id, co_ich) VALUES (:r, :u, :h) ON DUPLICATE KEY UPDATE co_ich = VALUES(co_ich)', [
                ':r' => (int)$review['ma'], ':u' => $uid, ':h' => $helpful,
            ]);
        }
        $this->back($fallback);
    }
}
