<?php
// =============================================================================
// COMMENT CONTROLLER - Table: binh_luan_tro_choi
// One level of replies. Deleting marks the comment "removed" so replies and
// moderation history stay intact.
// =============================================================================

class CommentController extends Controller {
    private const PER_MINUTE = 5;

    public function create(array $params = []) {
        $user = $this->requireAuth();
        $game = $this->publishedGame($params);
        $uid = (int)$user['ma'];
        $gid = (int)$game['ma'];
        $to = '/games/' . rawurlencode($game['duong_dan_rut_gon']) . '#comments';

        $enabled = (int)$game['cho_phep_binh_luan'] && (int)(Model::scalar('SELECT bat_cong_dong FROM cai_dat_trang_tro_choi WHERE tro_choi_id = :g', [':g' => $gid]) ?? 1);
        if (!$enabled) {
            $this->fail('Bình luận đã bị tắt cho trò chơi này.', $to);
        }
        $body = trim((string)($_POST['noi_dung'] ?? ''));
        if ($body === '' || mb_strlen($body) > 5000) {
            $this->fail('Bình luận cần từ 1 đến 5.000 ký tự.', $to);
        }
        $recent = (int)Model::scalar('SELECT COUNT(*) FROM binh_luan_tro_choi WHERE nguoi_dung_id = :u AND ngay_tao > NOW() - INTERVAL 1 MINUTE', [':u' => $uid]);
        if ($recent >= self::PER_MINUTE) {
            $this->fail('Bạn đang bình luận quá nhanh. Hãy đợi một phút rồi thử lại.', $to);
        }
        $parentId = (int)($_POST['parent_id'] ?? 0);
        $parent = null;
        if ($parentId > 0) {
            $parent = Model::one("SELECT ma, nguoi_dung_id FROM binh_luan_tro_choi WHERE ma = :p AND tro_choi_id = :g AND binh_luan_cha_id IS NULL AND trang_thai = 'published'", [':p' => $parentId, ':g' => $gid]);
            if (!$parent) {
                $this->fail('Bình luận bạn trả lời không còn tồn tại.', $to);
            }
        }
        Model::run('INSERT INTO binh_luan_tro_choi (tro_choi_id, nguoi_dung_id, binh_luan_cha_id, noi_dung) VALUES (:g, :u, :p, :b)', [
            ':g' => $gid, ':u' => $uid, ':p' => $parent ? (int)$parent['ma'] : null, ':b' => $body,
        ]);
        $id = Model::lastId();
        DailyStatsModel::bump($gid, 'so_luong_binh_luan');
        $url = '/games/' . $game['duong_dan_rut_gon'] . '#comment-' . $id;
        $recipients = GameModel::authorIds($gid);
        if ($parent) {
            $recipients[] = (int)$parent['nguoi_dung_id'];
        }
        NotificationModel::notifyUsers($recipients, $uid, 'comment', ($parent ? 'Trả lời mới trong ' : 'Bình luận mới cho ') . $game['tieu_de'],
            $user['ten_hien_thi'] . ': ' . excerpt($body, 120), $url);
        flash('success', $parent ? 'Đã gửi trả lời.' : 'Đã đăng bình luận.');
        $this->redirect('/games/' . rawurlencode($game['duong_dan_rut_gon']) . '#comment-' . $id);
    }

    public function delete(array $params = []) {
        $user = $this->requireAuth();
        $comment = Model::one('SELECT c.ma, c.nguoi_dung_id, c.trang_thai, g.duong_dan_rut_gon FROM binh_luan_tro_choi c JOIN tro_choi g ON g.ma = c.tro_choi_id WHERE c.ma = :id', [':id' => (int)($params['id'] ?? 0)]);
        if (!$comment || $comment['trang_thai'] === 'removed') {
            $this->notFound('Không tìm thấy bình luận này.');
        }
        $mine = (int)$comment['nguoi_dung_id'] === (int)$user['ma'];
        if (!$mine && !is_staff()) {
            $this->forbidden('Bạn chỉ có thể xóa bình luận của chính mình.');
        }
        Model::run("UPDATE binh_luan_tro_choi SET trang_thai = 'removed' WHERE ma = :id", [':id' => (int)$comment['ma']]);
        if (!$mine) {
            Model::run("INSERT INTO hanh_dong_kiem_duyet (nguoi_kiem_duyet_id, loai_doi_tuong, doi_tuong_id, loai_hanh_dong, ly_do) VALUES (:m, 'game_comment', :id, 'remove', :r)", [
                ':m' => (int)$user['ma'], ':id' => (int)$comment['ma'], ':r' => 'Gỡ trực tiếp từ trang trò chơi',
            ]);
        }
        audit('comment_remove', 'binh_luan_tro_choi', (int)$comment['ma']);
        flash('success', 'Đã xóa bình luận.');
        $this->back('/games/' . rawurlencode($comment['duong_dan_rut_gon']) . '#comments');
    }
}
