<?php
// =============================================================================
// MODERATION CONTROLLER - report queue, user content, moderation log.
// Tables: bao_cao_noi_dung, hanh_dong_kiem_duyet, danh_gia, binh_luan_tro_choi,
// nhat_ky_phat_trien, binh_luan_nhat_ky, chu_de_thao_luan, bai_viet_thao_luan,
// tro_choi, nguoi_dung, thong_bao, nhat_ky_he_thong.
// =============================================================================

class ModerationController extends Controller {
    /**
     * Moderatable user content. 'log' is the matching value of hanh_dong_kiem_duyet.loai_doi_tuong;
     * devlog comments have none in the schema, so their changes go to the system log only.
     */
    private const CONTENT = [
        'review' => ['table' => 'danh_gia', 'statuses' => ['published', 'hidden', 'removed'], 'log' => 'review',
            'select' => "SELECT 'review' AS kind, x.ma, x.trang_thai, x.ngay_tao, x.tieu_de, x.noi_dung_danh_gia AS noi_dung, x.nguoi_dung_id AS tac_gia_id,
                g.tieu_de AS ngu_canh, CONCAT('/games/', g.duong_dan_rut_gon, '#review-', x.ma) AS url
                FROM danh_gia x JOIN tro_choi g ON g.ma = x.tro_choi_id", 'body' => 'x.noi_dung_danh_gia'],
        'game_comment' => ['table' => 'binh_luan_tro_choi', 'statuses' => ['published', 'hidden', 'removed'], 'log' => 'game_comment',
            'select' => "SELECT 'game_comment' AS kind, x.ma, x.trang_thai, x.ngay_tao, NULL AS tieu_de, x.noi_dung, x.nguoi_dung_id AS tac_gia_id,
                g.tieu_de AS ngu_canh, CONCAT('/games/', g.duong_dan_rut_gon, '#comment-', x.ma) AS url
                FROM binh_luan_tro_choi x JOIN tro_choi g ON g.ma = x.tro_choi_id", 'body' => 'x.noi_dung'],
        'devlog' => ['table' => 'nhat_ky_phat_trien', 'statuses' => ['published', 'hidden'], 'log' => 'devlog',
            'select' => "SELECT 'devlog' AS kind, x.ma, x.trang_thai, x.ngay_tao, x.tieu_de, x.noi_dung, x.tac_gia_nguoi_dung_id AS tac_gia_id,
                g.tieu_de AS ngu_canh, CONCAT('/games/', g.duong_dan_rut_gon, '/devlogs/', x.duong_dan_rut_gon) AS url
                FROM nhat_ky_phat_trien x JOIN tro_choi g ON g.ma = x.tro_choi_id", 'body' => 'x.noi_dung', 'where' => "x.trang_thai <> 'draft'"],
        'devlog_comment' => ['table' => 'binh_luan_nhat_ky', 'statuses' => ['published', 'hidden', 'removed'], 'log' => null,
            'select' => "SELECT 'devlog_comment' AS kind, x.ma, x.trang_thai, x.ngay_tao, NULL AS tieu_de, x.noi_dung, x.nguoi_dung_id AS tac_gia_id,
                d.tieu_de AS ngu_canh, CONCAT('/games/', g.duong_dan_rut_gon, '/devlogs/', d.duong_dan_rut_gon, '#comments') AS url
                FROM binh_luan_nhat_ky x JOIN nhat_ky_phat_trien d ON d.ma = x.nhat_ky_phat_trien_id JOIN tro_choi g ON g.ma = d.tro_choi_id", 'body' => 'x.noi_dung'],
        'community_topic' => ['table' => 'chu_de_thao_luan', 'statuses' => ['published', 'hidden', 'removed'], 'log' => 'community_topic',
            'select' => "SELECT 'community_topic' AS kind, x.ma, x.trang_thai, x.ngay_tao, x.tieu_de, x.noi_dung_mo_dau AS noi_dung, x.tac_gia_nguoi_dung_id AS tac_gia_id,
                f.tieu_de AS ngu_canh, CONCAT('/forums/', x.dien_dan_id, '/topics/', x.ma) AS url
                FROM chu_de_thao_luan x JOIN dien_dan f ON f.ma = x.dien_dan_id", 'body' => 'x.noi_dung_mo_dau'],
        'community_post' => ['table' => 'bai_viet_thao_luan', 'statuses' => ['published', 'hidden', 'removed'], 'log' => 'community_post',
            'select' => "SELECT 'community_post' AS kind, x.ma, x.trang_thai, x.ngay_tao, NULL AS tieu_de, x.noi_dung, x.tac_gia_nguoi_dung_id AS tac_gia_id,
                t.tieu_de AS ngu_canh, CONCAT('/forums/', t.dien_dan_id, '/topics/', t.ma, '#post-', x.ma) AS url
                FROM bai_viet_thao_luan x JOIN chu_de_thao_luan t ON t.ma = x.chu_de_id", 'body' => 'x.noi_dung'],
    ];

    private const CONTENT_ACTION = ['hidden' => 'hide', 'removed' => 'remove', 'published' => 'restore'];

    // ----------------------------------------------------------- reports -----

    public function reports(array $params = []) {
        $this->requireRole('moderator', 'admin');
        $status = (string)($_GET['status'] ?? '');
        $target = (string)($_GET['target'] ?? '');
        $where = [];
        $args = [];
        if ($status === '') {
            $where[] = "b.trang_thai IN ('open','investigating')";
        } elseif (isset(labels('report_status')[$status])) {
            $where[] = 'b.trang_thai = :s';
            $args[':s'] = $status;
        }
        if (isset(ReportController::TARGETS[$target])) {
            $where[] = 'b.loai_doi_tuong = :t';
            $args[':t'] = $target;
        }
        $sqlWhere = $where ? 'WHERE ' . implode(' AND ', $where) : '';
        $total = (int)Model::scalar("SELECT COUNT(*) FROM bao_cao_noi_dung b $sqlWhere", $args);
        $per = 30;
        $pages = max(1, (int)ceil($total / $per));
        $page = min($this->page(), $pages);
        $this->render('admin/reports', [
            'pageTitle' => 'Báo cáo vi phạm',
            'filters' => ['status' => $status, 'target' => $target],
            'counts' => array_column(Model::query('SELECT trang_thai, COUNT(*) AS n FROM bao_cao_noi_dung GROUP BY trang_thai'), 'n', 'trang_thai'),
            'reports' => Model::query("SELECT b.*, r.ten_hien_thi AS nguoi_bao_cao, a.ten_hien_thi AS nguoi_xu_ly,
                    (SELECT COUNT(*) FROM bao_cao_noi_dung o WHERE o.loai_doi_tuong = b.loai_doi_tuong AND o.doi_tuong_id = b.doi_tuong_id) AS cung_noi_dung
                FROM bao_cao_noi_dung b LEFT JOIN nguoi_dung r ON r.ma = b.nguoi_bao_cao_id LEFT JOIN nguoi_dung a ON a.ma = b.nguoi_duoc_phan_cong_id
                $sqlWhere ORDER BY FIELD(b.trang_thai, 'open', 'investigating') DESC, b.ngay_tao DESC, b.ma DESC LIMIT :lim OFFSET :off",
                $args + [':lim' => $per, ':off' => ($page - 1) * $per]),
            'total' => $total, 'page' => $page, 'pages' => $pages,
        ]);
    }

    public function report(array $params = []) {
        $this->requireRole('moderator', 'admin');
        $report = $this->findReport($params);
        $type = $report['loai_doi_tuong'];
        $targetId = (int)$report['doi_tuong_id'];
        $target = $this->target($type, $targetId);
        $this->render('admin/report', [
            'pageTitle' => 'Báo cáo #' . (int)$report['ma'],
            'report' => $report,
            'target' => $target,
            'options' => $this->options($type, $target),
            'related' => Model::query('SELECT b.ma, b.ma_ly_do, b.trang_thai, b.ngay_tao, r.ten_hien_thi FROM bao_cao_noi_dung b LEFT JOIN nguoi_dung r ON r.ma = b.nguoi_bao_cao_id
                WHERE b.loai_doi_tuong = :t AND b.doi_tuong_id = :i AND b.ma <> :m ORDER BY b.ngay_tao DESC', [':t' => $type, ':i' => $targetId, ':m' => (int)$report['ma']]),
            'history' => Model::query('SELECT h.loai_hanh_dong, h.ly_do, h.ngay_tao, u.ten_hien_thi FROM hanh_dong_kiem_duyet h JOIN nguoi_dung u ON u.ma = h.nguoi_kiem_duyet_id
                WHERE h.loai_doi_tuong = :t AND h.doi_tuong_id = :i ORDER BY h.ngay_tao DESC, h.ma DESC', [':t' => $type, ':i' => $targetId]),
        ]);
    }

    public function resolve(array $params = []) {
        $moderator = $this->requireRole('moderator', 'admin');
        $modId = (int)$moderator['ma'];
        $report = $this->findReport($params);
        $id = (int)$report['ma'];
        $back = '/admin/reports/' . $id;
        $isOpen = in_array($report['trang_thai'], ['open', 'investigating'], true);

        if (($_POST['do'] ?? '') === 'investigate') {
            if ($report['trang_thai'] !== 'open') {
                $this->fail('Chỉ nhận xử lý báo cáo đang ở trạng thái "Mới".', $back);
            }
            Model::run("UPDATE bao_cao_noi_dung SET trang_thai = 'investigating', nguoi_duoc_phan_cong_id = :u WHERE ma = :b AND trang_thai = 'open'", [':u' => $modId, ':b' => $id]);
            audit('report_investigate', 'bao_cao_noi_dung', $id);
            flash('success', 'Bạn đang xử lý báo cáo này.');
            $this->redirect($back);
        }

        if (!$isOpen) {
            $this->fail('Báo cáo này đã được đóng.', $back);
        }
        $outcome = (string)($_POST['ket_qua'] ?? '');
        $apply = (string)($_POST['xu_ly'] ?? '');
        $note = post_str('ghi_chu', 1000);
        if (!in_array($outcome, ['resolved', 'rejected'], true)) {
            $this->fail('Chọn kết quả xử lý.', $back);
        }
        if ($note === null) {
            $this->fail('Ghi chú tối đa 1.000 ký tự.', $back);
        }
        $type = $report['loai_doi_tuong'];
        $targetId = (int)$report['doi_tuong_id'];
        $target = $this->target($type, $targetId);
        if ($apply !== '') {
            if ($outcome !== 'resolved') {
                $this->fail('Bác bỏ báo cáo thì không áp dụng biện pháp xử lý.', $back);
            }
            if (!$target || !isset($this->options($type, $target)[$apply])) {
                $this->fail('Biện pháp xử lý không hợp lệ cho nội dung này.', $back);
            }
        }
        $closeRelated = !empty($_POST['dong_cung_noi_dung']);

        $error = Model::transaction(function () use ($apply, $type, $target, $targetId, $note, $modId, $outcome, $id, $closeRelated) {
            if ($apply !== '') {
                $error = match (true) {
                    $type === 'game' => GameModel::staffSetStatus($target, $apply, $modId, $note),
                    $type === 'user' => $this->warnUser($target, $modId, $note),
                    default => $this->applyContent($type, $target, $apply, $modId, $note),
                };
                if ($error !== null) {
                    return $error;
                }
            }
            $ids = [$id];
            if ($closeRelated) {
                $ids = array_map('intval', Model::column("SELECT ma FROM bao_cao_noi_dung WHERE loai_doi_tuong = :t AND doi_tuong_id = :i AND trang_thai IN ('open','investigating') FOR UPDATE",
                    [':t' => $type, ':i' => $targetId])) ?: [$id];
            }
            $reporters = [];
            foreach ($ids as $rid) {
                Model::run('UPDATE bao_cao_noi_dung SET trang_thai = :s, ngay_giai_quyet = NOW(), nguoi_duoc_phan_cong_id = COALESCE(nguoi_duoc_phan_cong_id, :u) WHERE ma = :b',
                    [':s' => $outcome, ':u' => $modId, ':b' => $rid]);
                $reporters[] = (int)Model::scalar('SELECT nguoi_bao_cao_id FROM bao_cao_noi_dung WHERE ma = :b', [':b' => $rid]);
                audit('report_' . $outcome, 'bao_cao_noi_dung', $rid, ['xu_ly' => $apply ?: null]);
            }
            NotificationModel::notifyUsers($reporters, $modId, 'report_result',
                $outcome === 'resolved' ? 'Báo cáo của bạn đã được xử lý' : 'Báo cáo của bạn đã được xem xét',
                $outcome === 'resolved' ? 'Cảm ơn bạn. Điều hành viên đã xử lý nội dung bạn báo cáo.' : 'Điều hành viên không thấy nội dung vi phạm quy định nên không xử lý thêm.', '/notifications');
            return null;
        });
        if ($error !== null) {
            $this->fail($error, $back);
        }
        flash('success', $outcome === 'resolved' ? 'Đã đóng báo cáo: đã xử lý.' : 'Đã bác bỏ báo cáo.');
        $this->redirect($back);
    }

    // ----------------------------------------------------------- content -----

    public function content(array $params = []) {
        $this->requireRole('moderator', 'admin');
        $filters = [
            'type' => isset(self::CONTENT[$_GET['type'] ?? '']) ? (string)$_GET['type'] : '',
            'status' => isset(labels('content_status')[$_GET['status'] ?? '']) ? (string)$_GET['status'] : '',
            'q' => mb_substr(trim((string)($_GET['q'] ?? '')), 0, 100),
            'id' => ctype_digit((string)($_GET['id'] ?? '')) ? (int)$_GET['id'] : 0,
        ];
        [$union, $args] = $this->contentUnion($filters);
        $total = (int)Model::scalar("SELECT COUNT(*) FROM ($union) c", $args);
        $per = 25;
        $pages = max(1, (int)ceil($total / $per));
        $page = min($this->page(), $pages);
        $this->render('admin/content', [
            'pageTitle' => 'Nội dung người dùng',
            'filters' => $filters,
            'types' => array_keys(self::CONTENT),
            'statusesFor' => array_map(static fn($c) => $c['statuses'], self::CONTENT),
            'items' => Model::query("SELECT c.*, u.ten_hien_thi, u.ten_dang_nhap FROM ($union) c JOIN nguoi_dung u ON u.ma = c.tac_gia_id
                ORDER BY c.ngay_tao DESC, c.ma DESC LIMIT :lim OFFSET :off", $args + [':lim' => $per, ':off' => ($page - 1) * $per]),
            'total' => $total, 'page' => $page, 'pages' => $pages,
        ]);
    }

    public function setContentStatus(array $params = []) {
        $moderator = $this->requireRole('moderator', 'admin');
        $type = (string)($params['type'] ?? '');
        if (!isset(self::CONTENT[$type])) {
            $this->notFound();
        }
        $back = safe_return((string)($_POST['return_to'] ?? ''), '/admin/comments');
        $row = $this->contentRow($type, (int)($params['id'] ?? 0));
        if (!$row) {
            $this->notFound('Không tìm thấy nội dung.');
        }
        $status = (string)($_POST['trang_thai'] ?? '');
        $reason = post_str('ly_do', 1000);
        $error = $reason === null ? 'Lý do tối đa 1.000 ký tự.' : Model::transaction(fn() => $this->applyContent($type, $row, $status, (int)$moderator['ma'], $reason));
        if ($error !== null) {
            $this->fail($error, $back);
        }
        flash('success', 'Đã chuyển nội dung sang "' . label('content_status', $status) . '".');
        $this->redirect($back);
    }

    // --------------------------------------------------------------- log -----

    public function log(array $params = []) {
        $this->requireRole('moderator', 'admin');
        $filters = [
            'target' => isset(labels('report_target')[$_GET['target'] ?? '']) ? (string)$_GET['target'] : '',
            'action' => isset(labels('mod_action')[$_GET['action'] ?? '']) ? (string)$_GET['action'] : '',
        ];
        $where = ['1=1'];
        $args = [];
        if ($filters['target'] !== '') {
            $where[] = 'h.loai_doi_tuong = :t';
            $args[':t'] = $filters['target'];
        }
        if ($filters['action'] !== '') {
            $where[] = 'h.loai_hanh_dong = :a';
            $args[':a'] = $filters['action'];
        }
        $sqlWhere = implode(' AND ', $where);
        $total = (int)Model::scalar("SELECT COUNT(*) FROM hanh_dong_kiem_duyet h WHERE $sqlWhere", $args);
        $per = 50;
        $pages = max(1, (int)ceil($total / $per));
        $page = min($this->page(), $pages);
        $this->render('admin/moderation', [
            'pageTitle' => 'Nhật ký kiểm duyệt',
            'filters' => $filters,
            'rows' => Model::query("SELECT h.*, u.ten_hien_thi FROM hanh_dong_kiem_duyet h JOIN nguoi_dung u ON u.ma = h.nguoi_kiem_duyet_id
                WHERE $sqlWhere ORDER BY h.ngay_tao DESC, h.ma DESC LIMIT :lim OFFSET :off", $args + [':lim' => $per, ':off' => ($page - 1) * $per]),
            'total' => $total, 'page' => $page, 'pages' => $pages,
        ]);
    }

    // ----------------------------------------------------------- helpers -----

    private function findReport(array $params): array {
        $report = Model::one('SELECT b.*, r.ten_hien_thi AS nguoi_bao_cao, r.ten_dang_nhap AS nguoi_bao_cao_dn, a.ten_hien_thi AS nguoi_xu_ly
            FROM bao_cao_noi_dung b LEFT JOIN nguoi_dung r ON r.ma = b.nguoi_bao_cao_id LEFT JOIN nguoi_dung a ON a.ma = b.nguoi_duoc_phan_cong_id
            WHERE b.ma = :b', [':b' => (int)($params['id'] ?? 0)]);
        if (!$report) {
            $this->notFound('Không tìm thấy báo cáo.');
        }
        return $report;
    }

    /** The reported object, normalised enough for the report page. Null when it no longer exists. */
    private function target(string $type, int $id): ?array {
        return match ($type) {
            'game' => Model::one('SELECT g.ma, g.tieu_de, g.duong_dan_rut_gon, g.trang_thai, g.mo_ta_ngan, u.ten_hien_thi, u.ten_dang_nhap
                FROM tro_choi g JOIN nguoi_dung u ON u.ma = g.nguoi_tao_id WHERE g.ma = :i', [':i' => $id]),
            'user' => Model::one('SELECT ma, ten_dang_nhap, ten_hien_thi, gioi_thieu, url_anh_dai_dien, trang_thai FROM nguoi_dung WHERE ma = :i', [':i' => $id]),
            default => $this->contentRow($type, $id),
        };
    }

    /** Actions a moderator can apply from a report: value => label. */
    private function options(string $type, ?array $target): array {
        if (!$target) {
            return [];
        }
        if ($type === 'user') {
            return $target['trang_thai'] === 'active' ? ['warning' => 'Gửi cảnh cáo cho người dùng'] : [];
        }
        $statuses = $type === 'game' ? ($target['trang_thai'] === 'draft' ? [] : GameModel::STAFF_STATUSES) : self::CONTENT[$type]['statuses'];
        $group = $type === 'game' ? 'game_status' : 'content_status';
        $out = [];
        foreach ($statuses as $s) {
            if ($s !== $target['trang_thai']) {
                $out[$s] = 'Chuyển sang "' . label($group, $s) . '"';
            }
        }
        return $out;
    }

    private function contentRow(string $type, int $id): ?array {
        $spec = self::CONTENT[$type] ?? null;
        if (!$spec) {
            return null;
        }
        return Model::one('SELECT c.*, u.ten_hien_thi, u.ten_dang_nhap FROM (' . $spec['select'] . ' WHERE x.ma = :i) c JOIN nguoi_dung u ON u.ma = c.tac_gia_id', [':i' => $id]);
    }

    /** UNION of every content type (or one), with filters bound under unique names. */
    private function contentUnion(array $filters): array {
        $parts = [];
        $args = [];
        $n = 0;
        foreach (self::CONTENT as $type => $spec) {
            if ($filters['type'] !== '' && $filters['type'] !== $type) {
                continue;
            }
            $n++;
            $where = isset($spec['where']) ? [$spec['where']] : [];
            if ($filters['status'] !== '') {
                $where[] = "x.trang_thai = :s$n";
                $args[":s$n"] = $filters['status'];
            }
            if ($filters['q'] !== '') {
                $where[] = "{$spec['body']} LIKE :q$n";
                $args[":q$n"] = '%' . $filters['q'] . '%';
            }
            if ($filters['id'] > 0 && $filters['type'] !== '') {
                $where[] = "x.ma = :i$n";
                $args[":i$n"] = $filters['id'];
            }
            $parts[] = $spec['select'] . ($where ? ' WHERE ' . implode(' AND ', $where) : '');
        }
        return [implode(' UNION ALL ', $parts), $args];
    }

    /** Change a content row's status; run inside a transaction. Returns an error message or null. */
    private function applyContent(string $type, array $row, string $status, int $modId, string $reason): ?string {
        $spec = self::CONTENT[$type];
        if (!in_array($status, $spec['statuses'], true)) {
            return 'Trạng thái không hợp lệ cho loại nội dung này.';
        }
        if ($row['trang_thai'] === 'draft') {
            return 'Bản nháp chưa công khai, không cần kiểm duyệt.';
        }
        if ($status === $row['trang_thai']) {
            return 'Nội dung đã ở trạng thái này.';
        }
        if ($status !== 'published' && $reason === '') {
            return 'Hãy ghi lý do khi ẩn hoặc gỡ nội dung.';
        }
        $id = (int)$row['ma'];
        Model::run("UPDATE `{$spec['table']}` SET trang_thai = :s WHERE ma = :i", [':s' => $status, ':i' => $id]);
        if ($spec['log'] !== null) {
            ModerationActionModel::log($modId, $spec['log'], $id, self::CONTENT_ACTION[$status], $reason);
        }
        audit('content_status', $spec['table'], $id, ['truoc' => $row['trang_thai'], 'sau' => $status, 'ly_do' => $reason]);
        $what = mb_strtolower(label('report_target', $type));
        $title = match ($status) {
            'hidden' => 'Một ' . $what . ' của bạn đã bị ẩn',
            'removed' => 'Một ' . $what . ' của bạn đã bị gỡ',
            default => 'Một ' . $what . ' của bạn đã được hiển thị lại',
        };
        NotificationModel::notifyUsers([(int)$row['tac_gia_id']], $modId, 'moderation', $title,
            $reason !== '' ? 'Lý do: ' . $reason : 'Điều hành viên đã xem xét lại nội dung.', $status === 'published' ? $row['url'] : '/notifications');
        return null;
    }

    private function warnUser(array $user, int $modId, string $note): ?string {
        if ($note === '') {
            return 'Hãy ghi nội dung cảnh cáo; người dùng sẽ nhận được ghi chú này.';
        }
        ModerationActionModel::log($modId, 'user', (int)$user['ma'], 'warning', $note);
        audit('user_warning', 'nguoi_dung', (int)$user['ma']);
        NotificationModel::notifyUsers([(int)$user['ma']], $modId, 'moderation', 'Cảnh cáo từ điều hành viên', $note, '/notifications');
        return null;
    }
}
