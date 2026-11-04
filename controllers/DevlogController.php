<?php
// =============================================================================
// DEVLOG CONTROLLER - Tables: nhat_ky_phat_trien, binh_luan_nhat_ky
// Public reading side. Writing devlogs lives in DevGameController.
// Devlog bodies are plain text (escaped, line breaks kept); no HTML is rendered.
// =============================================================================

class DevlogController extends Controller {
    private const PER_PAGE = 10;
    private const COMMENTS_PER_MINUTE = 5;

    public function index(array $params = []) {
        $game = $this->publishedGame($params);
        $gid = (int)$game['ma'];
        $total = (int)Model::scalar("SELECT COUNT(*) FROM nhat_ky_phat_trien WHERE tro_choi_id = :g AND trang_thai = 'published'", [':g' => $gid]);
        $pages = max(1, (int)ceil($total / self::PER_PAGE));
        $page = min($this->page(), $pages);
        $posts = Model::query("SELECT d.ma, d.tieu_de, d.duong_dan_rut_gon, d.noi_dung, d.ngay_cong_bo, u.ten_hien_thi, u.ten_dang_nhap,
                (SELECT COUNT(*) FROM binh_luan_nhat_ky c WHERE c.nhat_ky_phat_trien_id = d.ma AND c.trang_thai = 'published') so_binh_luan
            FROM nhat_ky_phat_trien d JOIN nguoi_dung u ON u.ma = d.tac_gia_nguoi_dung_id
            WHERE d.tro_choi_id = :g AND d.trang_thai = 'published' ORDER BY d.ngay_cong_bo DESC, d.ma DESC LIMIT :l OFFSET :o", [
            ':g' => $gid, ':l' => self::PER_PAGE, ':o' => ($page - 1) * self::PER_PAGE,
        ]);
        $this->render('devlog/index', [
            'pageTitle' => 'Nhật ký phát triển · ' . $game['tieu_de'],
            'game' => $game,
            'posts' => $posts,
            'page' => $page,
            'pages' => $pages,
            'total' => $total,
        ]);
    }

    public function show(array $params = []) {
        $game = $this->publishedGame($params);
        $post = $this->post($game, (string)($params['post'] ?? ''));
        $rows = Model::query("SELECT c.ma, c.nguoi_dung_id, c.binh_luan_cha_id, c.noi_dung, c.ngay_tao, u.ten_hien_thi, u.ten_dang_nhap, u.url_anh_dai_dien
            FROM binh_luan_nhat_ky c JOIN nguoi_dung u ON u.ma = c.nguoi_dung_id
            WHERE c.nhat_ky_phat_trien_id = :d AND c.trang_thai = 'published' ORDER BY c.ngay_tao, c.ma", [':d' => (int)$post['ma']]);
        $top = [];
        $replies = [];
        foreach ($rows as $row) {
            if ($row['binh_luan_cha_id']) {
                $replies[(int)$row['binh_luan_cha_id']][] = $row;
            } else {
                $top[] = $row;
            }
        }
        $neighbours = Model::query("(SELECT 'newer' dir, tieu_de, duong_dan_rut_gon FROM nhat_ky_phat_trien WHERE tro_choi_id = :g1 AND trang_thai = 'published' AND ngay_cong_bo > :d1 ORDER BY ngay_cong_bo ASC LIMIT 1)
            UNION ALL (SELECT 'older' dir, tieu_de, duong_dan_rut_gon FROM nhat_ky_phat_trien WHERE tro_choi_id = :g2 AND trang_thai = 'published' AND ngay_cong_bo < :d2 ORDER BY ngay_cong_bo DESC LIMIT 1)", [
            ':g1' => (int)$game['ma'], ':d1' => $post['ngay_cong_bo'], ':g2' => (int)$game['ma'], ':d2' => $post['ngay_cong_bo'],
        ]);
        $this->render('devlog/show', [
            'pageTitle' => $post['tieu_de'] . ' · ' . $game['tieu_de'],
            'game' => $game,
            'post' => $post,
            'comments' => $top,
            'replies' => $replies,
            'commentCount' => count($rows),
            'commentsOn' => $this->commentsOn($game),
            'neighbours' => array_column($neighbours, null, 'dir'),
        ]);
    }

    public function comment(array $params = []) {
        $user = $this->requireAuth();
        $game = $this->publishedGame($params);
        $post = $this->post($game, (string)($params['post'] ?? ''));
        $uid = (int)$user['ma'];
        $base = '/games/' . rawurlencode($game['duong_dan_rut_gon']) . '/devlogs/' . rawurlencode($post['duong_dan_rut_gon']);
        if (!$this->commentsOn($game)) {
            $this->fail('Bình luận đã bị tắt cho trò chơi này.', $base);
        }
        $body = trim((string)($_POST['noi_dung'] ?? ''));
        if ($body === '' || mb_strlen($body) > 5000) {
            $this->fail('Bình luận cần từ 1 đến 5.000 ký tự.', $base . '#comments');
        }
        $recent = (int)Model::scalar('SELECT COUNT(*) FROM binh_luan_nhat_ky WHERE nguoi_dung_id = :u AND ngay_tao > NOW() - INTERVAL 1 MINUTE', [':u' => $uid]);
        if ($recent >= self::COMMENTS_PER_MINUTE) {
            $this->fail('Bạn đang bình luận quá nhanh. Hãy đợi một phút rồi thử lại.', $base . '#comments');
        }
        $parent = null;
        $parentId = (int)($_POST['parent_id'] ?? 0);
        if ($parentId > 0) {
            $parent = Model::one("SELECT ma, nguoi_dung_id FROM binh_luan_nhat_ky WHERE ma = :p AND nhat_ky_phat_trien_id = :d AND binh_luan_cha_id IS NULL AND trang_thai = 'published'", [
                ':p' => $parentId, ':d' => (int)$post['ma'],
            ]);
            if (!$parent) {
                $this->fail('Bình luận bạn trả lời không còn tồn tại.', $base . '#comments');
            }
        }
        Model::run('INSERT INTO binh_luan_nhat_ky (nhat_ky_phat_trien_id, nguoi_dung_id, binh_luan_cha_id, noi_dung) VALUES (:d, :u, :p, :b)', [
            ':d' => (int)$post['ma'], ':u' => $uid, ':p' => $parent ? (int)$parent['ma'] : null, ':b' => $body,
        ]);
        $id = Model::lastId();
        $recipients = [(int)$post['tac_gia_nguoi_dung_id']];
        if ($parent) {
            $recipients[] = (int)$parent['nguoi_dung_id'];
        }
        NotificationModel::notifyUsers($recipients, $uid, 'devlog_comment', ($parent ? 'Trả lời mới trong nhật ký "' : 'Bình luận mới cho nhật ký "') . $post['tieu_de'] . '"',
            $user['ten_hien_thi'] . ': ' . excerpt($body, 120), $base . '#dcomment-' . $id);
        flash('success', $parent ? 'Đã gửi trả lời.' : 'Đã đăng bình luận.');
        $this->redirect($base . '#dcomment-' . $id);
    }

    public function deleteComment(array $params = []) {
        $user = $this->requireAuth();
        $comment = Model::one('SELECT c.ma, c.nguoi_dung_id, c.trang_thai, d.duong_dan_rut_gon post_slug, d.tro_choi_id, g.duong_dan_rut_gon game_slug
            FROM binh_luan_nhat_ky c JOIN nhat_ky_phat_trien d ON d.ma = c.nhat_ky_phat_trien_id JOIN tro_choi g ON g.ma = d.tro_choi_id
            WHERE c.ma = :id', [':id' => (int)($params['id'] ?? 0)]);
        if (!$comment || $comment['trang_thai'] === 'removed') {
            $this->notFound('Không tìm thấy bình luận này.');
        }
        $mine = (int)$comment['nguoi_dung_id'] === (int)$user['ma'];
        $isAuthor = GameModel::isAuthor((int)$comment['tro_choi_id'], (int)$user['ma']);
        if (!$mine && !$isAuthor && !is_staff()) {
            $this->forbidden('Bạn chỉ có thể xóa bình luận của chính mình.');
        }
        Model::run("UPDATE binh_luan_nhat_ky SET trang_thai = 'removed' WHERE ma = :id", [':id' => (int)$comment['ma']]);
        audit($mine ? 'devlog_comment_delete' : 'devlog_comment_remove', 'binh_luan_nhat_ky', (int)$comment['ma']);
        flash('success', 'Đã xóa bình luận.');
        $this->back('/games/' . rawurlencode($comment['game_slug']) . '/devlogs/' . rawurlencode($comment['post_slug']) . '#comments');
    }

    private function post(array $game, string $slug): array {
        $post = Model::one("SELECT d.*, u.ten_hien_thi, u.ten_dang_nhap, u.url_anh_dai_dien FROM nhat_ky_phat_trien d JOIN nguoi_dung u ON u.ma = d.tac_gia_nguoi_dung_id
            WHERE d.tro_choi_id = :g AND d.duong_dan_rut_gon = :s AND d.trang_thai = 'published'", [':g' => (int)$game['ma'], ':s' => $slug]);
        if (!$post) {
            $this->notFound('Không tìm thấy bài nhật ký này.');
        }
        return $post;
    }

    private function commentsOn(array $game): bool {
        return (int)$game['cho_phep_binh_luan'] === 1
            && (int)(Model::scalar('SELECT bat_cong_dong FROM cai_dat_trang_tro_choi WHERE tro_choi_id = :g', [':g' => (int)$game['ma']]) ?? 1) === 1;
    }
}
