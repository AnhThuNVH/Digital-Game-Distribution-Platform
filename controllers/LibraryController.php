<?php
// =============================================================================
// LIBRARY CONTROLLER - Tables: quyen_so_huu_tro_choi, tro_choi_yeu_thich,
// ma_truy_cap_tro_choi (key redemption)
// =============================================================================

class LibraryController extends Controller {
    private const REDEEM_PER_HOUR = 10;

    public function index(array $params = []) {
        $user = $this->requireAuth();
        $q = mb_substr(trim((string)($_GET['q'] ?? '')), 0, 100);
        $sort = ($_GET['sort'] ?? '') === 'title' ? 'title' : 'recent';
        [$games, $pager] = $this->paginate(OwnershipModel::library((int)$user['ma'], $q, $sort), 24);
        $this->render('library/index', $pager + [
            'pageTitle' => 'Thư viện',
            'games' => $games,
            'q' => $q,
            'sort' => $sort,
            'wishCount' => (int)Model::scalar('SELECT COUNT(*) FROM tro_choi_yeu_thich WHERE nguoi_dung_id = :u', [':u' => (int)$user['ma']]),
        ]);
    }

    public function wishlist(array $params = []) {
        $user = $this->requireAuth();
        $uid = (int)$user['ma'];
        $games = Model::query('SELECT ' . GameModel::cardColumns() . ", f.ngay_tao AS ngay_them
            FROM tro_choi_yeu_thich f JOIN tro_choi g ON g.ma = f.tro_choi_id
            WHERE f.nguoi_dung_id = :u AND g.trang_thai IN ('published','unlisted') ORDER BY f.ngay_tao DESC", [':u' => $uid]);
        [$games, $pager] = $this->paginate($games, 24);
        $this->render('library/wishlist', $pager + [
            'pageTitle' => 'Danh sách mong muốn',
            'games' => $games,
            'owned' => OwnershipModel::ownedIds($uid, array_map('intval', array_column($games, 'ma'))),
            'inCart' => array_map('intval', Model::column("SELECT i.tro_choi_id FROM muc_gio_hang i JOIN gio_hang c ON c.ma = i.gio_hang_id
                WHERE c.nguoi_dung_id = :u AND c.trang_thai = 'active' AND i.tro_choi_id IS NOT NULL", [':u' => $uid])),
            'libCount' => (int)Model::scalar("SELECT COUNT(*) FROM quyen_so_huu_tro_choi WHERE nguoi_dung_id = :u AND trang_thai = 'active'", [':u' => $uid]),
        ]);
    }

    /** Redeem an access key. Keys are stored only as sha256 hashes. */
    public function redeem(array $params = []) {
        $user = $this->requireAuth();
        $uid = (int)$user['ma'];
        $raw = strtoupper(preg_replace('/\s+/', '', (string)($_POST['key'] ?? '')));
        if (!preg_match('/^[A-Z0-9-]{8,64}$/', $raw)) {
            $this->fail('Mã kích hoạt chỉ gồm chữ, số và gạch ngang (8–64 ký tự).', '/library');
        }
        $attempts = (int)Model::scalar("SELECT COUNT(*) FROM nhat_ky_he_thong WHERE nguoi_dung_id = :u AND ma_hanh_dong = 'key_redeem_fail' AND ngay_tao > NOW() - INTERVAL 1 HOUR", [':u' => $uid]);
        if ($attempts >= self::REDEEM_PER_HOUR) {
            $this->fail('Bạn đã nhập sai quá nhiều lần. Hãy thử lại sau một giờ.', '/library');
        }
        try {
            $game = Model::transaction(function () use ($raw, $uid) {
                $key = Model::one("SELECT k.*, g.tieu_de, g.duong_dan_rut_gon, g.trang_thai game_status FROM ma_truy_cap_tro_choi k JOIN tro_choi g ON g.ma = k.tro_choi_id
                    WHERE k.ma_bam = :h FOR UPDATE", [':h' => hash('sha256', $raw)]);
                if (!$key) {
                    throw new RuntimeException('Mã kích hoạt không đúng.');
                }
                if ($key['trang_thai'] === 'claimed') {
                    throw new RuntimeException('Mã này đã được sử dụng.');
                }
                if ($key['trang_thai'] !== 'available' || ($key['ngay_het_han'] && strtotime($key['ngay_het_han']) < time())) {
                    throw new RuntimeException('Mã này đã hết hạn hoặc bị thu hồi.');
                }
                if (!in_array($key['game_status'], ['published', 'unlisted'], true)) {
                    throw new RuntimeException('Trò chơi của mã này hiện không khả dụng.');
                }
                if (OwnershipModel::has($uid, (int)$key['tro_choi_id'])) {
                    throw new RuntimeException('Bạn đã sở hữu "' . $key['tieu_de'] . '". Mã chưa bị dùng, bạn có thể tặng cho người khác.');
                }
                Model::run("UPDATE ma_truy_cap_tro_choi SET trang_thai = 'claimed', nguoi_nhan_ma_id = :u, ngay_nhan_ma = NOW() WHERE ma = :id", [':u' => $uid, ':id' => (int)$key['ma']]);
                OwnershipModel::grant($uid, (int)$key['tro_choi_id'], 'access_key');
                return $key;
            });
        } catch (RuntimeException $error) {
            audit('key_redeem_fail', 'ma_truy_cap_tro_choi', null);
            $this->fail($error->getMessage(), '/library');
        }
        audit('key_redeem', 'ma_truy_cap_tro_choi', (int)$game['ma']);
        flash('success', 'Đã kích hoạt "' . $game['tieu_de'] . '". Trò chơi đã có trong thư viện.');
        $this->redirect('/library');
    }
}
