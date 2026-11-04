<?php
// =============================================================================
// JAM CONTROLLER - public side of game jams: list, detail, submit, withdraw,
// vote. Jams are created and run from /admin/jams (JamAdminController).
// =============================================================================

class JamController extends Controller {
    private const TABS = ['open' => 'Đang mở', 'judging' => 'Đang chấm', 'past' => 'Đã kết thúc'];

    public function index(array $params = []) {
        $tabs = self::TABS + (is_staff() ? ['hidden' => 'Nháp và đã hủy'] : []);
        $tab = (string)($_GET['tab'] ?? 'open');
        if (!isset($tabs[$tab])) {
            $tab = 'open';
        }
        [$jams, $pager] = $this->paginate(JamModel::listing($tab), 12);
        $this->render('jam/index', [
            'pageTitle' => 'Cuộc thi làm game',
            'tabs' => $tabs,
            'tab' => $tab,
            'counts' => JamModel::tabCounts(),
            'jams' => $jams,
        ] + $pager);
    }

    public function show(array $params = []) {
        $jam = $this->visibleJam($params);
        $jid = (int)$jam['ma'];
        $uid = current_user_id();
        $phase = JamModel::phase($jam);
        $manager = $this->canManage($jam);
        $entries = JamModel::entries($jid, $manager);
        $myVotes = JamModel::myVotes($jid, $uid);
        $authored = [];
        foreach ($entries as $en) {
            if ($uid && GameModel::isAuthor((int)$en['ma'], $uid)) {
                $authored[(int)$en['entry_id']] = true;
            }
        }
        if ($phase === 'results') {
            usort($entries, static fn($a, $b) => [(float)$b['diem_tb'], (int)$b['so_phieu']] <=> [(float)$a['diem_tb'], (int)$a['so_phieu']]);
        } elseif ($phase === 'voting') {
            // Stable per-viewer order so early entries do not collect every vote.
            $seed = (string)($uid ?: session_id());
            usort($entries, static fn($a, $b) => crc32($seed . ':' . $a['entry_id']) <=> crc32($seed . ':' . $b['entry_id']));
        }
        $this->render('jam/show', [
            'pageTitle' => $jam['tieu_de'],
            'jam' => $jam,
            'phase' => $phase,
            'entries' => $entries,
            'scores' => $phase === 'results' || $manager ? JamModel::criteriaScores($jid) : [],
            'myVotes' => $myVotes,
            'authored' => $authored,
            'members' => JamModel::members($jid),
            'eligible' => $uid && $phase === 'submissions' ? JamModel::eligibleGames($jid, $uid) : [],
            'board' => Model::one('SELECT ma, tieu_de FROM dien_dan WHERE cuoc_thi_id = :j' . (is_staff() ? '' : ' AND cong_khai = 1'), [':j' => $jid]),
            'manager' => $manager,
        ]);
    }

    public function submit(array $params = []) {
        $jam = $this->visibleJam($params);
        $user = $this->requireAuth();
        $uid = (int)$user['ma'];
        $self = '/jams/' . rawurlencode($jam['duong_dan_rut_gon']);
        if (JamModel::phase($jam) !== 'submissions') {
            $this->fail('Cuộc thi hiện không nhận bài.', $self);
        }
        $gameId = (int)($_POST['tro_choi_id'] ?? 0);
        $game = Model::one('SELECT ma, tieu_de, trang_thai FROM tro_choi WHERE ma = :g', [':g' => $gameId]);
        if (!$game || !GameModel::isAuthor($gameId, $uid)) {
            $this->fail('Bạn chỉ nộp được trò chơi do mình phát triển.', $self . '#submit');
        }
        if (!in_array($game['trang_thai'], ['published', 'unlisted'], true)) {
            $this->fail('Trò chơi cần ở trạng thái công bố hoặc không liệt kê thì người chấm mới mở được.', $self . '#submit');
        }
        $existing = Model::scalar('SELECT trang_thai FROM bai_du_thi WHERE cuoc_thi_id = :j AND tro_choi_id = :g', [':j' => (int)$jam['ma'], ':g' => $gameId]);
        if ($existing === 'submitted') {
            $this->fail('Trò chơi này đã có trong cuộc thi.', $self . '#entries');
        }
        if ($existing === 'disqualified') {
            $this->fail('Trò chơi này đã bị loại khỏi cuộc thi và không nộp lại được.', $self . '#submit');
        }
        $entryId = JamModel::submit((int)$jam['ma'], $gameId, $uid);
        audit('jam_submit', 'bai_du_thi', $entryId, ['jam' => (int)$jam['ma'], 'game' => $gameId]);
        $hosts = array_map('intval', Model::column("SELECT nguoi_dung_id FROM thanh_vien_cuoc_thi WHERE cuoc_thi_id = :j AND vai_tro_thanh_vien IN ('host','admin')", [':j' => (int)$jam['ma']]));
        NotificationModel::notifyUsers($hosts, $uid, 'jam_entry', 'Bài dự thi mới: ' . $game['tieu_de'], 'Nộp vào ' . $jam['tieu_de'], $self . '#entry-' . $entryId);
        flash('success', 'Đã nộp ' . $game['tieu_de'] . ' vào cuộc thi.');
        $this->redirect($self . '#entry-' . $entryId);
    }

    public function withdraw(array $params = []) {
        $jam = $this->visibleJam($params);
        $user = $this->requireAuth();
        $self = '/jams/' . rawurlencode($jam['duong_dan_rut_gon']);
        $entry = JamModel::entry((int)$jam['ma'], (int)($params['entry'] ?? 0));
        if (!$entry || $entry['trang_thai'] !== 'submitted') {
            $this->notFound('Không tìm thấy bài dự thi này.');
        }
        if (!GameModel::isAuthor((int)$entry['tro_choi_id'], (int)$user['ma'])) {
            $this->forbidden('Chỉ nhà phát triển của trò chơi mới rút được bài.');
        }
        if (JamModel::phase($jam) !== 'submissions') {
            $this->fail('Đã hết hạn nộp bài nên không rút bài được nữa.', $self . '#entry-' . (int)$entry['ma']);
        }
        Model::run("UPDATE bai_du_thi SET trang_thai = 'withdrawn' WHERE ma = :e", [':e' => (int)$entry['ma']]);
        audit('jam_withdraw', 'bai_du_thi', (int)$entry['ma']);
        flash('success', 'Đã rút ' . $entry['game_title'] . ' khỏi cuộc thi. Bạn có thể nộp lại trước hạn.');
        $this->redirect($self . '#submit');
    }

    public function vote(array $params = []) {
        $jam = $this->visibleJam($params);
        $user = $this->requireAuth();
        $uid = (int)$user['ma'];
        $self = '/jams/' . rawurlencode($jam['duong_dan_rut_gon']);
        $entry = JamModel::entry((int)$jam['ma'], (int)($params['entry'] ?? 0));
        if (!$entry || $entry['trang_thai'] !== 'submitted' || !in_array($entry['game_status'], ['published', 'unlisted'], true)) {
            $this->notFound('Không tìm thấy bài dự thi này.');
        }
        $anchor = $self . '#entry-' . (int)$entry['ma'];
        if (JamModel::phase($jam) !== 'voting') {
            $this->fail('Cuộc thi hiện không mở bình chọn.', $anchor);
        }
        if (GameModel::isAuthor((int)$entry['tro_choi_id'], $uid)) {
            $this->fail('Bạn không chấm điểm trò chơi của chính mình.', $anchor);
        }
        $scores = [];
        foreach (array_keys(JamModel::CRITERIA) as $criterion) {
            $value = (int)($_POST['diem'][$criterion] ?? 0);
            if ($value < 1 || $value > 5) {
                $this->fail('Hãy chấm từ 1 đến 5 cho mọi tiêu chí.', $anchor);
            }
            $scores[$criterion] = $value;
        }
        $comment = post_str('binh_luan', 1000);
        if ($comment === null) {
            $this->fail('Nhận xét tối đa 1.000 ký tự.', $anchor);
        }
        JamModel::vote((int)$entry['ma'], $uid, $scores, $comment !== '' ? $comment : null);
        audit('jam_vote', 'bai_du_thi', (int)$entry['ma']);
        flash('success', 'Đã lưu điểm cho ' . $entry['game_title'] . '.');
        $this->redirect($anchor);
    }

    // ------------------------------------------------------------------ helpers

    private function canManage(array $jam): bool {
        $uid = current_user_id();
        if (!$uid) {
            return false;
        }
        return is_staff() || in_array(JamModel::memberRole((int)$jam['ma'], $uid), ['host', 'admin'], true);
    }

    /** Drafts are only visible to staff and the jam's own team; cancelled jams stay readable. */
    private function visibleJam(array $params): array {
        $jam = JamModel::bySlug((string)($params['slug'] ?? ''));
        if (!$jam) {
            $this->notFound('Không tìm thấy cuộc thi này.');
        }
        if ($jam['trang_thai'] === 'draft' && !is_staff() && !JamModel::memberRole((int)$jam['ma'], current_user_id())) {
            $this->notFound('Không tìm thấy cuộc thi này.');
        }
        return $jam;
    }
}
