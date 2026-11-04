<?php
// =============================================================================
// REPORT CONTROLLER - Table: bao_cao_noi_dung
// Any signed-in user can report content; staff triage it in /admin/reports.
// =============================================================================

class ReportController extends Controller {
    public const TARGETS = [
        'user' => 'nguoi_dung', 'game' => 'tro_choi', 'review' => 'danh_gia', 'game_comment' => 'binh_luan_tro_choi',
        'devlog' => 'nhat_ky_phat_trien', 'community_topic' => 'chu_de_thao_luan', 'community_post' => 'bai_viet_thao_luan',
    ];
    public const REASONS = ['spam', 'abuse', 'illegal', 'copyright', 'malware', 'other'];

    public function create(array $params = []) {
        $user = $this->requireAuth();
        $type = (string)($_POST['type'] ?? '');
        $id = (int)($_POST['id'] ?? 0);
        $reason = (string)($_POST['reason'] ?? '');
        $detail = trim((string)($_POST['detail'] ?? ''));
        if (!isset(self::TARGETS[$type]) || $id <= 0) {
            flash('error', 'Nội dung cần báo cáo không hợp lệ.');
            $this->back('/');
        }
        if (!in_array($reason, self::REASONS, true)) {
            flash('error', 'Hãy chọn lý do báo cáo.');
            $this->back('/');
        }
        if (mb_strlen($detail) > 2000) {
            flash('error', 'Chi tiết tối đa 2.000 ký tự.');
            $this->back('/');
        }
        $table = self::TARGETS[$type];
        if (!Model::scalar("SELECT 1 FROM `$table` WHERE ma = :id", [':id' => $id])) {
            flash('error', 'Nội dung này không còn tồn tại.');
            $this->back('/');
        }
        if ($type === 'user' && $id === (int)$user['ma']) {
            flash('error', 'Bạn không thể báo cáo chính mình.');
            $this->back('/');
        }
        $open = Model::scalar("SELECT 1 FROM bao_cao_noi_dung WHERE nguoi_bao_cao_id = :u AND loai_doi_tuong = :t AND doi_tuong_id = :id AND trang_thai IN ('open','investigating')", [
            ':u' => (int)$user['ma'], ':t' => $type, ':id' => $id,
        ]);
        if ($open) {
            flash('info', 'Bạn đã báo cáo nội dung này. Điều hành viên đang xem xét.');
            $this->back('/');
        }
        Model::run('INSERT INTO bao_cao_noi_dung (nguoi_bao_cao_id, loai_doi_tuong, doi_tuong_id, ma_ly_do, chi_tiet) VALUES (:u, :t, :id, :r, :d)', [
            ':u' => (int)$user['ma'], ':t' => $type, ':id' => $id, ':r' => $reason, ':d' => $detail !== '' ? $detail : null,
        ]);
        $reportId = Model::lastId();
        $staff = Model::column("SELECT DISTINCT x.nguoi_dung_id FROM nguoi_dung_vai_tro x JOIN vai_tro r ON r.ma = x.vai_tro_id WHERE r.ma_vai_tro IN ('moderator','admin')");
        NotificationModel::notifyUsers($staff, (int)$user['ma'], 'report', 'Báo cáo mới: ' . label('report_target', $type), 'Lý do: ' . label('report_reason', $reason), '/admin/reports/' . $reportId);
        flash('success', 'Cảm ơn bạn. Báo cáo đã được gửi tới điều hành viên.');
        $this->back('/');
    }
}
