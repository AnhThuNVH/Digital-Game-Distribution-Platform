<?php
// =============================================================================
// DOWNLOAD CONTROLLER - download links of a game.
//
// Developer side: manage the links of a project (/dev/games/{id}/downloads),
// including the mirrors that are waiting for approval.
// Player side: pick a link from the game page (/games/{slug}/downloads) and
// start the download (/games/{slug}/download/{link}).
//
// Links are never printed in the public HTML. A player must own the game and
// the request goes through the server, which counts the download, writes an
// audit row and only then redirects to the storage provider.
// =============================================================================

class DownloadController extends Controller {
    private const MAX_LINKS = 20;

    // ------------------------------------------------------- developer ----

    public function manage(array $params = []) {
        [, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $status = (string)($_GET['status'] ?? '');
        if (!in_array($status, DownloadLinkModel::STATUSES, true)) {
            $status = '';
        }
        $counts = array_column(Model::query('SELECT trang_thai, COUNT(*) n FROM url_tai_tro_choi WHERE tro_choi_id = :g GROUP BY trang_thai', [':g' => $gid]), 'n', 'trang_thai');
        $this->render('dev/game-downloads', [
            'pageTitle' => 'Liên kết tải về · ' . $game['tieu_de'],
            'game' => $game,
            'tab' => 'downloads',
            'isCreator' => (int)$game['nguoi_tao_id'] === current_user_id(),
            'links' => DownloadLinkModel::listForGame($gid, $status),
            'counts' => $counts,
            'status' => $status,
            'releases' => Model::query('SELECT ma, ten_phien_ban, kenh_phat_hanh FROM phien_ban_phat_hanh WHERE tro_choi_id = :g ORDER BY ngay_phat_hanh DESC, ma DESC', [':g' => $gid]),
            'maxLinks' => self::MAX_LINKS,
        ]);
    }

    public function addLink(array $params = []) {
        [, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $back = '/dev/games/' . $gid . '/downloads#add-download';
        $count = (int)Model::scalar('SELECT COUNT(*) FROM url_tai_tro_choi WHERE tro_choi_id = :g', [':g' => $gid]);
        if ($count >= self::MAX_LINKS) {
            $this->fail('Mỗi dự án có tối đa ' . self::MAX_LINKS . ' liên kết tải về.', $back);
        }
        $row = $this->readLink($gid, $back);
        if (DownloadLinkModel::urlTaken($gid, $row['url_tai'])) {
            $this->fail('Đường dẫn này đã có trong danh sách.', $back);
        }
        $id = Model::transaction(function () use ($gid, $row) {
            $id = DownloadLinkModel::add(array_merge($row, ['tro_choi_id' => $gid]));
            audit('download_link_added', 'url_tai_tro_choi', $id, ['tro_choi_id' => $gid, 'nha_cung_cap' => $row['nha_cung_cap']]);
            return $id;
        });
        flash('success', 'Đã thêm liên kết tải về.');
        $this->redirect('/dev/games/' . $gid . '/downloads#download-' . $id);
    }

    public function updateLink(array $params = []) {
        [, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $item = $this->link($gid, $params);
        $back = '/dev/games/' . $gid . '/downloads#download-' . (int)$item['ma'];
        $row = $this->readLink($gid, $back, $item);
        if (DownloadLinkModel::urlTaken($gid, $row['url_tai'], (int)$item['ma'])) {
            $this->fail('Đường dẫn này đã có trong danh sách.', $back);
        }
        Model::transaction(function () use ($item, $row) {
            DownloadLinkModel::updateLink((int)$item['ma'], $row);
            audit('download_link_updated', 'url_tai_tro_choi', (int)$item['ma']);
        });
        flash('success', 'Đã lưu liên kết tải về.');
        $this->redirect($back);
    }

    /** Approve a mirror contributed by a player. */
    public function approveLink(array $params = []) {
        [$user, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $item = $this->link($gid, $params);
        $back = '/dev/games/' . $gid . '/downloads#download-' . (int)$item['ma'];
        if ($item['trang_thai'] === 'active') {
            $this->fail('Liên kết này đã được duyệt.', $back);
        }
        Model::transaction(function () use ($item, $user) {
            DownloadLinkModel::updateLink((int)$item['ma'], ['trang_thai' => 'active', 'ly_do_tu_choi' => null]);
            audit('download_link_approved', 'url_tai_tro_choi', (int)$item['ma'], ['tro_choi_id' => (int)$item['tro_choi_id']]);
        });
        if ($item['nguoi_dong_gop_id']) {
            NotificationModel::notifyUsers([(int)$item['nguoi_dong_gop_id']], (int)$user['ma'], 'download_link',
                'Liên kết tải về của bạn đã được duyệt',
                'Liên kết "' . $item['ten_hien_thi'] . '" bạn gửi cho "' . $game['tieu_de'] . '" đã được nhà phát triển duyệt.',
                '/games/' . rawurlencode($game['duong_dan_rut_gon']) . '/downloads');
        }
        flash('success', 'Đã duyệt liên kết.');
        $this->redirect($back);
    }

    /** Refuse a mirror contributed by a player. */
    public function rejectLink(array $params = []) {
        [$user, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $item = $this->link($gid, $params);
        $back = '/dev/games/' . $gid . '/downloads#download-' . (int)$item['ma'];
        $reason = post_str('ly_do', 500);
        if ($reason === null) {
            $this->fail('Lý do tối đa 500 ký tự.', $back);
        }
        if ($reason === '') {
            $this->fail('Ghi lý do để người gửi biết vì sao link bị từ chối.', $back);
        }
        Model::transaction(function () use ($item, $reason) {
            DownloadLinkModel::updateLink((int)$item['ma'], ['trang_thai' => 'rejected', 'ly_do_tu_choi' => $reason]);
            audit('download_link_rejected', 'url_tai_tro_choi', (int)$item['ma'], ['tro_choi_id' => (int)$item['tro_choi_id']]);
        });
        if ($item['nguoi_dong_gop_id']) {
            NotificationModel::notifyUsers([(int)$item['nguoi_dong_gop_id']], (int)$user['ma'], 'download_link',
                'Liên kết tải về của bạn không được duyệt',
                'Lý do: ' . $reason,
                '/games/' . rawurlencode($game['duong_dan_rut_gon']) . '/downloads');
        }
        flash('success', 'Đã từ chối liên kết.');
        $this->redirect($back);
    }

    public function deleteLink(array $params = []) {
        [, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $item = $this->link($gid, $params);
        Model::transaction(function () use ($item, $gid) {
            Model::run('DELETE FROM url_tai_tro_choi WHERE ma = :m', [':m' => (int)$item['ma']]);
            audit('download_link_deleted', 'url_tai_tro_choi', (int)$item['ma'], ['tro_choi_id' => $gid]);
        });
        flash('success', 'Đã xóa liên kết tải về.');
        $this->redirect('/dev/games/' . $gid . '/downloads');
    }

    // ---------------------------------------------------------- player ----

    /** The list of links a player may pick from. */
    public function index(array $params = []) {
        $game = $this->publishedGame($params);
        $user = $this->requireAuth();
        $uid = (int)$user['ma'];
        $gid = (int)$game['ma'];
        $owned = OwnershipModel::has($uid, $gid);
        $links = $owned ? DownloadLinkModel::listPublic($gid) : [];
        $this->render('game/downloads', [
            'pageTitle' => 'Tải ' . $game['tieu_de'],
            'game' => $game,
            'owned' => $owned,
            'links' => $links,
            'releases' => Model::query('SELECT ma, ten_phien_ban, kenh_phat_hanh, ngay_phat_hanh FROM phien_ban_phat_hanh
                WHERE tro_choi_id = :g AND cong_khai = 1 AND ngay_phat_hanh <= NOW() ORDER BY ngay_phat_hanh DESC, ma DESC LIMIT 5', [':g' => $gid]),
        ]);
    }

    /**
     * Start a download: check the ownership, count it, log it, then redirect to
     * the provider. The real URL is never part of a rendered page.
     */
    public function go(array $params = []) {
        $game = $this->publishedGame($params);
        $user = $this->requireAuth();
        $uid = (int)$user['ma'];
        $gid = (int)$game['ma'];
        $linkId = (int)($params['link'] ?? 0);

        $link = Model::one("SELECT d.* FROM url_tai_tro_choi d WHERE d.ma = :m AND d.tro_choi_id = :g AND d.trang_thai = 'active'",
            [':m' => $linkId, ':g' => $gid]);
        if (!$link) {
            $this->notFound('Không tìm thấy liên kết tải về.');
        }
        if (!OwnershipModel::has($uid, $gid)) {
            $this->forbidden('Bạn cần sở hữu trò chơi này để tải về. Hãy mua hoặc nhận miễn phí trước.');
        }

        DownloadLinkModel::countDownload((int)$link['ma']);
        DailyStatsModel::bump($gid, 'luot_nhan_tai_xuong');
        audit('game_download', 'url_tai_tro_choi', (int)$link['ma'], [
            'tro_choi_id' => $gid,
            'nha_cung_cap' => $link['nha_cung_cap'],
        ]);

        header('Location: ' . $link['url_tai'], true, 302);
        exit;
    }

    // --------------------------------------------------------- helpers ----

    /** The game in the route, if the current developer is one of its authors. */
    private function owned(array $params): array {
        $user = $this->requireRole('developer');
        $game = GameModel::find((int)($params['id'] ?? 0));
        if (!$game || !GameModel::isAuthor((int)$game['ma'], (int)$user['ma'])) {
            $this->notFound('Không tìm thấy dự án.');
        }
        return [$user, $game];
    }

    private function link(int $gameId, array $params): array {
        $item = DownloadLinkModel::findForGame((int)($params['link'] ?? 0), $gameId);
        if (!$item) {
            $this->notFound('Không tìm thấy liên kết tải về.');
        }
        return $item;
    }

    /** Validate the link form; returns the columns to write. */
    private function readLink(int $gameId, string $back, ?array $current = null): array {
        $url = post_str('url_tai', 1500);
        if ($url === null || $url === '') {
            $this->fail('Nhập đường dẫn tải về.', $back);
        }
        if (!filter_var($url, FILTER_VALIDATE_URL) || !preg_match('#^https?://#i', $url)) {
            $this->fail('Đường dẫn tải về phải là địa chỉ http:// hoặc https:// hợp lệ.', $back);
        }
        $url = preg_replace('#^http://#i', 'https://', $url);

        $provider = (string)($_POST['nha_cung_cap'] ?? '');
        if ($provider === '') {
            $provider = DownloadLinkModel::detectProvider($url) ?? 'custom';
        }
        if (!in_array($provider, DownloadLinkModel::PROVIDERS, true)) {
            $this->fail('Chọn nơi lưu trữ hợp lệ.', $back);
        }

        $platform = (string)($_POST['he_dieu_ke'] ?? 'any');
        if (!in_array($platform, DownloadLinkModel::PLATFORMS, true)) {
            $this->fail('Chọn hệ điều hành hợp lệ.', $back);
        }

        $title = post_str('ten_hien_thi', 200);
        if ($title === null) {
            $this->fail('Tên hiển thị tối đa 200 ký tự.', $back);
        }
        if ($title === '') {
            $title = DownloadLinkModel::providerName($provider) . ' · ' . DownloadLinkModel::platformName($platform);
        }

        $size = post_str('dung_luong', 40);
        if ($size === null) {
            $this->fail('Dung lượng tối đa 40 ký tự.', $back);
        }
        $note = post_str('ghi_chu', 500);
        if ($note === null) {
            $this->fail('Ghi chú tối đa 500 ký tự.', $back);
        }

        $releaseId = post_int('phien_ban_id');
        if ($releaseId > 0 && !Model::scalar('SELECT 1 FROM phien_ban_phat_hanh WHERE ma = :r AND tro_choi_id = :g', [':r' => $releaseId, ':g' => $gameId])) {
            $this->fail('Phiên bản không thuộc dự án này.', $back);
        }

        $status = (string)($_POST['trang_thai'] ?? 'active');
        if (!in_array($status, ['active', 'hidden'], true)) {
            $this->fail('Trạng thái không hợp lệ.', $back);
        }

        $order = max(0, min(1000, post_int('thu_tu_sap_xep')));

        return [
            'phien_ban_id' => $releaseId > 0 ? $releaseId : null,
            'nha_cung_cap' => $provider,
            'ten_hien_thi' => $title,
            'url_tai' => $url,
            'he_dieu_ke' => $platform,
            'dung_luong' => $size !== '' ? $size : null,
            'ghi_chu' => $note !== '' ? $note : null,
            'trang_thai' => $status,
            'thu_tu_sap_xep' => $order,
        ];
    }
}
