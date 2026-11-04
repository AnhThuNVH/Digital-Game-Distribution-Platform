<?php
// =============================================================================
// GAME CONTROLLER - catalogue, game page, free claim, wishlist, follow
// =============================================================================

class GameController extends Controller {
    private const PER_PAGE = 24;

    public function index(array $params = []) {
        $filters = [
            'q' => mb_substr(trim((string)($_GET['q'] ?? '')), 0, 100),
            'category' => (string)($_GET['category'] ?? ''),
            'tag' => (string)($_GET['tag'] ?? ''),
            'platform' => (string)($_GET['platform'] ?? ''),
            'price' => (string)($_GET['price'] ?? ''),
            'status' => (string)($_GET['status'] ?? ''),
            'type' => (string)($_GET['type'] ?? ''),
            'sale' => !empty($_GET['sale']) ? 1 : 0,
            'sort' => array_key_exists((string)($_GET['sort'] ?? ''), GameModel::SORTS) ? (string)$_GET['sort'] : 'popular',
        ];
        $total = GameModel::countCatalogue($filters);
        $pages = max(1, (int)ceil($total / self::PER_PAGE));
        $page = min($this->page(), $pages);
        $games = GameModel::catalogue($filters, self::PER_PAGE, ($page - 1) * self::PER_PAGE);

        $title = 'Khám phá';
        if ($filters['sale']) $title = 'Đang giảm giá';
        $categoryName = $filters['category'] !== '' ? Model::scalar('SELECT ten FROM the_loai WHERE duong_dan_rut_gon = :s', [':s' => $filters['category']]) : null;
        $tagName = $filters['tag'] !== '' ? Model::scalar('SELECT ten FROM nhan WHERE duong_dan_rut_gon = :s', [':s' => $filters['tag']]) : null;

        $this->render('game/index', [
            'pageTitle' => $categoryName ? $categoryName : $title,
            'heading' => $categoryName ?: ($tagName ? 'Thẻ: ' . $tagName : $title),
            'filters' => $filters,
            'games' => $games,
            'total' => $total,
            'page' => $page,
            'pages' => $pages,
            'categories' => Model::query('SELECT ten, duong_dan_rut_gon FROM the_loai ORDER BY ten'),
            'platforms' => Model::query('SELECT ma_nen_tang, ten_nen_tang FROM nen_tang ORDER BY ma'),
            'owned' => OwnershipModel::ownedIds(current_user_id()),
        ]);
    }

    public function show(array $params = []) {
        $game = GameModel::findBySlug((string)($params['slug'] ?? ''));
        if (!$game) {
            $this->notFound('Không tìm thấy trò chơi này.');
        }
        $uid = current_user_id();
        $gid = (int)$game['ma'];
        $isAuthor = GameModel::isAuthor($gid, $uid);
        $public = in_array($game['trang_thai'], ['published', 'unlisted'], true);
        if (!$public && !$isAuthor && !is_staff()) {
            $this->notFound('Không tìm thấy trò chơi này.');
        }
        if ($public) {
            DailyStatsModel::countView($gid);
        }

        $settings = Model::one('SELECT * FROM cai_dat_trang_tro_choi WHERE tro_choi_id = :g', [':g' => $gid]) ?: [
            'mau_nen' => null, 'mau_chu' => null, 'mau_lien_ket' => null, 'bo_cuc_trang' => 'default', 'bat_cong_dong' => 1, 'hien_thi_nha_sang_tao' => 1,
        ];
        $media = Model::query('SELECT * FROM media_tro_choi WHERE tro_choi_id = :g ORDER BY FIELD(loai_media,\'cover\',\'screenshot\',\'thumbnail\',\'trailer\',\'external_link\',\'other\'), thu_tu_sap_xep, ma', [':g' => $gid]);
        $gallery = array_values(array_filter($media, fn($m) => in_array($m['loai_media'], ['screenshot', 'cover'], true)));
        // Screenshots first in the gallery; the cover leads only when there are none.
        usort($gallery, fn($a, $b) => [$a['loai_media'] === 'cover' ? 1 : 0, (int)$a['thu_tu_sap_xep'], (int)$a['ma']] <=> [$b['loai_media'] === 'cover' ? 1 : 0, (int)$b['thu_tu_sap_xep'], (int)$b['ma']]);
        $links = array_values(array_filter($media, fn($m) => in_array($m['loai_media'], ['trailer', 'external_link'], true)));

        $authors = Model::query('SELECT u.ma, u.ten_dang_nhap, u.ten_hien_thi, u.url_anh_dai_dien, a.phan_tram_huong_doanh_thu FROM tac_gia_tro_choi a
            JOIN nguoi_dung u ON u.ma = a.nguoi_dung_id WHERE a.tro_choi_id = :g ORDER BY a.thu_tu_hien_thi, a.ngay_them', [':g' => $gid]);
        $publisher = Model::one('SELECT ma, ten_dang_nhap, ten_hien_thi, url_anh_dai_dien FROM nguoi_dung WHERE ma = :u', [':u' => (int)$game['nguoi_tao_id']]);
        $categories = Model::query('SELECT t.ten, t.duong_dan_rut_gon FROM tro_choi_the_loai x JOIN the_loai t ON t.ma = x.the_loai_id WHERE x.tro_choi_id = :g ORDER BY t.ten', [':g' => $gid]);
        $platforms = Model::query('SELECT p.ma_nen_tang, p.ten_nen_tang FROM tro_choi_nen_tang x JOIN nen_tang p ON p.ma = x.nen_tang_id WHERE x.tro_choi_id = :g ORDER BY p.ma', [':g' => $gid]);
        $tags = Model::query('SELECT n.ten, n.duong_dan_rut_gon FROM tro_choi_nhan x JOIN nhan n ON n.ma = x.nhan_id WHERE x.tro_choi_id = :g ORDER BY n.ten', [':g' => $gid]);
        $releases = Model::query('SELECT * FROM phien_ban_phat_hanh WHERE tro_choi_id = :g AND cong_khai = 1 AND ngay_phat_hanh <= NOW() ORDER BY ngay_phat_hanh DESC, ma DESC LIMIT 5', [':g' => $gid]);
        $devlogs = Model::query("SELECT d.ma, d.tieu_de, d.duong_dan_rut_gon, d.noi_dung, d.ngay_cong_bo, u.ten_hien_thi FROM nhat_ky_phat_trien d JOIN nguoi_dung u ON u.ma = d.tac_gia_nguoi_dung_id
            WHERE d.tro_choi_id = :g AND d.trang_thai = 'published' ORDER BY d.ngay_cong_bo DESC LIMIT 3", [':g' => $gid]);
        $devlogCount = (int)Model::scalar("SELECT COUNT(*) FROM nhat_ky_phat_trien WHERE tro_choi_id = :g AND trang_thai = 'published'", [':g' => $gid]);

        $reviewSort = ($_GET['reviews'] ?? '') === 'helpful' ? 'helpful' : 'recent';
        $reviews = Model::query("SELECT r.*, u.ten_dang_nhap, u.ten_hien_thi, u.url_anh_dai_dien,
                (SELECT COUNT(*) FROM binh_chon_danh_gia v WHERE v.danh_gia_id = r.ma AND v.co_ich = 1) AS co_ich,
                (SELECT COUNT(*) FROM binh_chon_danh_gia v WHERE v.danh_gia_id = r.ma AND v.co_ich = 0) AS khong_co_ich,
                (SELECT v.co_ich FROM binh_chon_danh_gia v WHERE v.danh_gia_id = r.ma AND v.nguoi_dung_id = :me) AS phieu_cua_toi
            FROM danh_gia r JOIN nguoi_dung u ON u.ma = r.nguoi_dung_id
            WHERE r.tro_choi_id = :g AND r.trang_thai = 'published'
            ORDER BY " . ($reviewSort === 'helpful' ? 'co_ich DESC, r.ngay_tao DESC' : 'r.ngay_tao DESC') . ' LIMIT 30', [':g' => $gid, ':me' => $uid]);
        $breakdown = array_fill(1, 5, 0);
        foreach (Model::query("SELECT diem_danh_gia, COUNT(*) c FROM danh_gia WHERE tro_choi_id = :g AND trang_thai = 'published' GROUP BY diem_danh_gia", [':g' => $gid]) as $row) {
            $breakdown[(int)$row['diem_danh_gia']] = (int)$row['c'];
        }
        $myReview = $uid ? Model::one('SELECT * FROM danh_gia WHERE tro_choi_id = :g AND nguoi_dung_id = :u', [':g' => $gid, ':u' => $uid]) : null;

        $comments = [];
        $replies = [];
        if ((int)$game['cho_phep_binh_luan'] && (int)$settings['bat_cong_dong']) {
            $rows = Model::query("SELECT c.*, u.ten_dang_nhap, u.ten_hien_thi, u.url_anh_dai_dien FROM binh_luan_tro_choi c JOIN nguoi_dung u ON u.ma = c.nguoi_dung_id
                WHERE c.tro_choi_id = :g AND c.trang_thai = 'published' ORDER BY c.ngay_tao ASC LIMIT 300", [':g' => $gid]);
            foreach ($rows as $row) {
                if ($row['binh_luan_cha_id']) {
                    $replies[(int)$row['binh_luan_cha_id']][] = $row;
                } else {
                    $comments[] = $row;
                }
            }
            $comments = array_reverse($comments);
        }

        $bundles = Model::query("SELECT b.ma, b.tieu_de, b.duong_dan_rut_gon, b.gia FROM tro_choi_goi_game x JOIN goi_game b ON b.ma = x.goi_game_id
            WHERE x.tro_choi_id = :g AND b.trang_thai = 'published' AND (b.ngay_bat_dau IS NULL OR b.ngay_bat_dau <= NOW()) AND (b.ngay_ket_thuc IS NULL OR b.ngay_ket_thuc > NOW())", [':g' => $gid]);
        $forum = Model::one("SELECT ma, tieu_de, (SELECT COUNT(*) FROM chu_de_thao_luan t WHERE t.dien_dan_id = dien_dan.ma AND t.trang_thai = 'published') AS so_chu_de
            FROM dien_dan WHERE tro_choi_id = :g AND loai_dien_dan = 'game'", [':g' => $gid]);
        $authorIds = array_map('intval', array_column($authors, 'ma')) ?: [(int)$game['nguoi_tao_id']];
        $in = implode(',', $authorIds);
        $moreGames = Model::query('SELECT ' . GameModel::cardColumns() . " FROM tro_choi g WHERE g.trang_thai = 'published' AND g.ma <> :g
            AND (g.nguoi_tao_id IN ($in) OR EXISTS (SELECT 1 FROM tac_gia_tro_choi a WHERE a.tro_choi_id = g.ma AND a.nguoi_dung_id IN ($in))) ORDER BY g.ngay_cong_bo DESC LIMIT 4", [':g' => $gid]);

        $owned = OwnershipModel::has($uid, $gid);
        $inCart = $uid ? (bool)Model::scalar("SELECT 1 FROM muc_gio_hang i JOIN gio_hang c ON c.ma = i.gio_hang_id WHERE c.nguoi_dung_id = :u AND c.trang_thai = 'active' AND i.tro_choi_id = :g", [':u' => $uid, ':g' => $gid]) : false;

        $this->render('game/show', [
            'pageTitle' => $game['tieu_de'],
            'metaDescription' => $game['mo_ta_ngan'] ?: excerpt($game['mo_ta'], 155),
            'game' => $game,
            'settings' => $settings,
            'gallery' => $gallery,
            'links' => $links,
            'authors' => $authors,
            'publisher' => $publisher,
            'categories' => $categories,
            'platforms' => $platforms,
            'tags' => $tags,
            'releases' => $releases,
            'devlogs' => $devlogs,
            'devlogCount' => $devlogCount,
            'reviews' => $reviews,
            'reviewSort' => $reviewSort,
            'breakdown' => $breakdown,
            'myReview' => $myReview,
            'comments' => $comments,
            'replies' => $replies,
            'bundles' => $bundles,
            'forum' => $forum,
            'moreGames' => $moreGames,
            'owned' => $owned,
            'inCart' => $inCart,
            'isAuthor' => $isAuthor,
            'wishlisted' => $uid ? (bool)Model::scalar('SELECT 1 FROM tro_choi_yeu_thich WHERE nguoi_dung_id = :u AND tro_choi_id = :g', [':u' => $uid, ':g' => $gid]) : false,
            'following' => $uid ? WatchModel::exists($uid, $gid) : false,
            'collections' => $uid ? CollectionModel::pickerFor($uid, $gid) : [],
            'ownerCount' => (int)Model::scalar("SELECT COUNT(*) FROM quyen_so_huu_tro_choi WHERE tro_choi_id = :g AND trang_thai = 'active'", [':g' => $gid]),
        ]);
    }

    /** Add a free game to the library. */
    public function claim(array $params = []) {
        $user = $this->requireAuth();
        $game = $this->publishedGame($params);
        if (!game_is_free($game)) {
            $this->fail('Trò chơi này cần thanh toán — hãy thêm vào giỏ hàng.', '/games/' . rawurlencode($game['duong_dan_rut_gon']));
        }
        if (OwnershipModel::grant((int)$user['ma'], (int)$game['ma'], 'free_claim')) {
            DailyStatsModel::bump((int)$game['ma'], 'luot_nhan_tai_xuong');
            audit('game_claim', 'tro_choi', (int)$game['ma']);
            flash('success', '"' . $game['tieu_de'] . '" đã có trong thư viện của bạn.');
        } else {
            flash('info', 'Bạn đã sở hữu trò chơi này.');
        }
        $this->back('/games/' . rawurlencode($game['duong_dan_rut_gon']));
    }

    public function wishlist(array $params = []) {
        $user = $this->requireAuth();
        $game = $this->publishedGame($params);
        $uid = (int)$user['ma'];
        $gid = (int)$game['ma'];
        if (Model::scalar('SELECT 1 FROM tro_choi_yeu_thich WHERE nguoi_dung_id = :u AND tro_choi_id = :g', [':u' => $uid, ':g' => $gid])) {
            Model::run('DELETE FROM tro_choi_yeu_thich WHERE nguoi_dung_id = :u AND tro_choi_id = :g', [':u' => $uid, ':g' => $gid]);
            flash('info', 'Đã bỏ "' . $game['tieu_de'] . '" khỏi danh sách mong muốn.');
        } else {
            Model::run('INSERT IGNORE INTO tro_choi_yeu_thich (nguoi_dung_id, tro_choi_id) VALUES (:u, :g)', [':u' => $uid, ':g' => $gid]);
            DailyStatsModel::bump($gid, 'luot_them_yeu_thich');
            flash('success', 'Đã thêm "' . $game['tieu_de'] . '" vào danh sách mong muốn.');
        }
        $this->back('/games/' . rawurlencode($game['duong_dan_rut_gon']));
    }

    public function follow(array $params = []) {
        $user = $this->requireAuth();
        $game = $this->publishedGame($params);
        $uid = (int)$user['ma'];
        if (WatchModel::exists($uid, (int)$game['ma'])) {
            WatchModel::unwatch($uid, (int)$game['ma']);
            flash('info', 'Đã ngừng theo dõi cập nhật của "' . $game['tieu_de'] . '".');
        } else {
            WatchModel::watch($uid, (int)$game['ma']);
            flash('success', 'Bạn sẽ nhận thông báo khi "' . $game['tieu_de'] . '" có phiên bản hoặc nhật ký mới.');
        }
        $this->back('/games/' . rawurlencode($game['duong_dan_rut_gon']));
    }
}
