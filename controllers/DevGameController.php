<?php
// =============================================================================
// DEV GAME CONTROLLER - a developer's projects.
// Tables: tro_choi, tac_gia_tro_choi, tro_choi_the_loai, tro_choi_nhan, tro_choi_nen_tang,
// media_tro_choi, phien_ban_phat_hanh, nhat_ky_phat_trien, cai_dat_trang_tro_choi,
// ma_truy_cap_tro_choi, thong_ke_tro_choi_hang_ngay.
// Every action needs the developer role and authorship of the game; the author list
// (revenue split) is edited by the game's creator only.
// =============================================================================

class DevGameController extends Controller {
    private const MAX_PRICE = 1000;
    private const MAX_MEDIA = 20;
    private const MAX_AUTHORS = 10;
    private const MAX_CATEGORIES = 3;
    private const MAX_TAGS = 10;
    private const KEY_BATCH = 100;
    private const MAX_OPEN_KEYS = 5000;
    private const KEYS_PER_PAGE = 50;
    /** Statuses the developer sets; the others belong to staff. */
    public const DEV_STATUSES = ['draft', 'published', 'unlisted'];
    private const IMAGE_MEDIA = ['cover', 'thumbnail', 'screenshot', 'other'];
    private const SINGLE_MEDIA = ['cover', 'thumbnail'];
    private const KEY_ALPHABET = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

    // ------------------------------------------------------------ projects --

    public function index(array $params = []) {
        $user = $this->requireRole('developer');
        $this->render('dev/games', [
            'pageTitle' => 'Dự án',
            'games' => GameModel::listForAuthor((int)$user['ma']),
            'uid' => (int)$user['ma'],
        ]);
    }

    public function create(array $params = []) {
        $this->requireRole('developer');
        $this->render('dev/game-form', ['pageTitle' => 'Tạo dự án', 'game' => null, 'tab' => 'details', 'picked' => self::pickedFromOld()] + self::taxonomies());
    }

    public function store(array $params = []) {
        $user = $this->requireRole('developer');
        $uid = (int)$user['ma'];
        [$data, $taxonomy] = $this->readGameForm('/dev/games/new', null);
        try {
            $id = Model::transaction(function () use ($uid, $data, $taxonomy) {
                $id = GameModel::create($data + ['nguoi_tao_id' => $uid, 'trang_thai' => 'draft', 'ma_tien_te' => APP_CURRENCY]);
                GameAuthorModel::add($id, $uid, 100, 0);
                GameSettingsModel::createDefault($id);
                self::saveTaxonomy($id, $taxonomy);
                audit('game_created', 'tro_choi', $id);
                return $id;
            });
        } catch (PDOException $error) {
            $this->fail(self::isDuplicate($error) ? 'Đường dẫn này vừa được dự án khác sử dụng. Hãy chọn đường dẫn khác.' : 'Không lưu được dự án.', '/dev/games/new');
        }
        flash('success', 'Đã tạo dự án ở trạng thái bản nháp. Thêm ảnh bìa và mô tả rồi công bố khi sẵn sàng.');
        $this->redirect('/dev/games/' . $id);
    }

    public function edit(array $params = []) {
        [, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $picked = old('the_loai') !== '' || old('tieu_de') !== '' ? self::pickedFromOld() : [
            'the_loai' => array_map('intval', Model::column('SELECT the_loai_id FROM tro_choi_the_loai WHERE tro_choi_id = :g', [':g' => $gid])),
            'nhan' => array_map('intval', Model::column('SELECT nhan_id FROM tro_choi_nhan WHERE tro_choi_id = :g', [':g' => $gid])),
            'nen_tang' => array_map('intval', Model::column('SELECT nen_tang_id FROM tro_choi_nen_tang WHERE tro_choi_id = :g', [':g' => $gid])),
        ];
        $this->view('game-form', $game, 'details', ['picked' => $picked] + self::taxonomies());
    }

    public function update(array $params = []) {
        [$user, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        [$data, $taxonomy] = $this->readGameForm('/dev/games/' . $gid, $game);
        $firstPublish = in_array($data['trang_thai'], ['published', 'unlisted'], true) && !$game['ngay_cong_bo'];
        if ($firstPublish) {
            $data['ngay_cong_bo'] = date('Y-m-d H:i:s');
        }
        try {
            Model::transaction(function () use ($gid, $data, $taxonomy, $game) {
                GameModel::update($gid, $data);
                self::saveTaxonomy($gid, $taxonomy);
                audit('game_updated', 'tro_choi', $gid, $data['trang_thai'] !== $game['trang_thai'] ? ['truoc' => $game['trang_thai'], 'sau' => $data['trang_thai']] : []);
            });
        } catch (PDOException $error) {
            $this->fail(self::isDuplicate($error) ? 'Đường dẫn này vừa được dự án khác sử dụng. Hãy chọn đường dẫn khác.' : 'Không lưu được dự án.', '/dev/games/' . $gid);
        }
        if ($firstPublish && $data['trang_thai'] === 'published') {
            NotificationModel::notifyUserFollowers((int)$game['nguoi_tao_id'], 'game_published', 'Dự án mới: ' . $data['tieu_de'],
                $user['ten_hien_thi'] . ' vừa công bố ' . $data['tieu_de'] . '.', '/games/' . rawurlencode($data['duong_dan_rut_gon']));
        }
        flash('success', $data['trang_thai'] !== $game['trang_thai'] ? 'Đã lưu. Trạng thái: ' . label('game_status', $data['trang_thai']) . '.' : 'Đã lưu thay đổi.');
        $this->redirect('/dev/games/' . $gid);
    }

    // --------------------------------------------------------------- media --

    public function media(array $params = []) {
        [, $game] = $this->owned($params);
        $this->view('game-media', $game, 'media', ['media' => GameMediaModel::listForGame((int)$game['ma']), 'maxMedia' => self::MAX_MEDIA]);
    }

    public function addMedia(array $params = []) {
        [, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $back = '/dev/games/' . $gid . '/media#add-media';
        $type = (string)($_POST['loai_media'] ?? '');
        if (!isset(labels('media_type')[$type])) {
            $this->fail('Chọn loại tệp.', $back);
        }
        $existing = GameMediaModel::listForGame($gid);
        if (count($existing) >= self::MAX_MEDIA) {
            $this->fail('Mỗi dự án có tối đa ' . self::MAX_MEDIA . ' ảnh và liên kết.', $back);
        }
        if (in_array($type, self::SINGLE_MEDIA, true) && in_array($type, array_column($existing, 'loai_media'), true)) {
            $this->fail('Dự án đã có ' . mb_strtolower(label('media_type', $type)) . '. Xóa ảnh cũ trước khi thêm ảnh mới.', $back);
        }
        [$caption, $alt, $order] = $this->readMediaText($type, $back);
        if (in_array($type, self::IMAGE_MEDIA, true)) {
            $upload = store_image_upload($_FILES['tep'] ?? null, 'games');
            if ($upload === null) {
                $this->fail('Chọn một tệp ảnh để tải lên.', $back);
            }
            if (isset($upload['error'])) {
                $this->fail($upload['error'], $back);
            }
            $url = $upload['path'];
        } else {
            $url = $this->readLink($back);
        }
        try {
            $id = Model::transaction(function () use ($gid, $type, $url, $caption, $alt, $order) {
                $id = GameMediaModel::add($gid, $type, $url, $caption, $alt, $order);
                audit('media_added', 'media_tro_choi', $id, ['tro_choi_id' => $gid, 'loai' => $type]);
                return $id;
            });
        } catch (Throwable $error) {
            delete_upload($url);
            throw $error;
        }
        flash('success', 'Đã thêm ' . mb_strtolower(label('media_type', $type)) . '.');
        $this->redirect('/dev/games/' . $gid . '/media#media-' . $id);
    }

    public function updateMedia(array $params = []) {
        [, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $item = $this->mediaItem($gid, $params);
        $back = '/dev/games/' . $gid . '/media#media-' . (int)$item['ma'];
        [$caption, $alt, $order] = $this->readMediaText($item['loai_media'], $back);
        $data = ['chu_thich' => $caption !== '' ? $caption : null, 'van_ban_thay_the' => $alt !== '' ? $alt : null, 'thu_tu_sap_xep' => $order];
        if (!in_array($item['loai_media'], self::IMAGE_MEDIA, true)) {
            $data['url_media'] = $this->readLink($back);
        }
        Model::transaction(function () use ($item, $data) {
            GameMediaModel::update((int)$item['ma'], $data);
            audit('media_updated', 'media_tro_choi', (int)$item['ma']);
        });
        flash('success', 'Đã lưu thông tin.');
        $this->redirect($back);
    }

    public function deleteMedia(array $params = []) {
        [, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $item = $this->mediaItem($gid, $params);
        Model::transaction(function () use ($item, $gid) {
            GameMediaModel::delete((int)$item['ma']);
            audit('media_deleted', 'media_tro_choi', (int)$item['ma'], ['tro_choi_id' => $gid, 'loai' => $item['loai_media']]);
        });
        delete_upload($item['url_media']);
        flash('success', 'Đã xóa ' . mb_strtolower(label('media_type', $item['loai_media'])) . '.');
        $this->redirect('/dev/games/' . $gid . '/media');
    }

    // ------------------------------------------------------------- authors --

    public function authors(array $params = []) {
        [$user, $game] = $this->owned($params);
        $this->view('game-authors', $game, 'authors', ['authors' => self::authorRows($game), 'maxAuthors' => self::MAX_AUTHORS]);
    }

    public function saveAuthors(array $params = []) {
        [$user, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $creator = (int)$game['nguoi_tao_id'];
        $back = '/dev/games/' . $gid . '/authors';
        if ((int)$user['ma'] !== $creator) {
            $this->forbidden('Chỉ người tạo dự án được thay đổi danh sách tác giả và tỷ lệ chia doanh thu.');
        }
        $current = self::authorRows($game);
        $shares = (array)($_POST['share'] ?? []);
        $orders = (array)($_POST['order'] ?? []);
        $remove = (array)($_POST['remove'] ?? []);
        $rows = [];
        $removed = [];
        foreach ($current as $a) {
            $u = (int)$a['nguoi_dung_id'];
            if (!empty($remove[$u])) {
                if ($u === $creator) {
                    $this->fail('Không thể gỡ người tạo dự án khỏi danh sách tác giả.', $back);
                }
                $removed[] = $u;
                continue;
            }
            $pct = self::parsePercent($shares[$u] ?? '');
            if ($pct === null) {
                $this->fail('Tỷ lệ của ' . $a['ten_hien_thi'] . ' phải là số từ 0 đến 100, tối đa 2 chữ số thập phân.', $back);
            }
            $rows[$u] = ['share' => $pct, 'order' => max(0, min(99, (int)($orders[$u] ?? 0))), 'new' => !empty($a['chua_luu'])];
        }
        $newName = post_str('tac_gia_moi', 50);
        $newId = 0;
        if ($newName === null) {
            $this->fail('Tên đăng nhập quá dài.', $back);
        }
        if ($newName !== '') {
            $newUser = Model::one("SELECT u.ma, u.ten_hien_thi FROM nguoi_dung u JOIN nguoi_dung_vai_tro r ON r.nguoi_dung_id = u.ma JOIN vai_tro v ON v.ma = r.vai_tro_id
                WHERE u.ten_dang_nhap = :n AND u.trang_thai = 'active' AND v.ma_vai_tro = 'developer' LIMIT 1", [':n' => $newName]);
            if (!$newUser) {
                $this->fail('Không tìm thấy nhà phát triển "' . $newName . '". Tác giả phải là tài khoản đang hoạt động có vai trò nhà phát triển.', $back);
            }
            $newId = (int)$newUser['ma'];
            if (isset($rows[$newId]) || in_array($newId, $removed, true)) {
                $this->fail($newUser['ten_hien_thi'] . ' đã có trong danh sách tác giả.', $back);
            }
            $pct = self::parsePercent((string)($_POST['share_moi'] ?? ''));
            if ($pct === null) {
                $this->fail('Nhập tỷ lệ cho tác giả mới (0 đến 100).', $back);
            }
            $rows[$newId] = ['share' => $pct, 'order' => count($rows), 'new' => true];
        }
        if (count($rows) > self::MAX_AUTHORS) {
            $this->fail('Một dự án có tối đa ' . self::MAX_AUTHORS . ' tác giả.', $back);
        }
        $sum = round(array_sum(array_column($rows, 'share')), 2);
        if (abs($sum - 100) > 0.001) {
            $this->fail('Tổng tỷ lệ chia doanh thu phải bằng 100%, hiện là ' . rtrim(rtrim(number_format($sum, 2, '.', ''), '0'), '.') . '%.', $back);
        }
        Model::transaction(function () use ($gid, $rows, $removed) {
            foreach ($removed as $u) {
                Model::run('DELETE FROM tac_gia_tro_choi WHERE tro_choi_id = :g AND nguoi_dung_id = :u', [':g' => $gid, ':u' => $u]);
            }
            foreach ($rows as $u => $r) {
                if ($r['new']) {
                    GameAuthorModel::add($gid, $u, $r['share'], $r['order']);
                } else {
                    Model::run('UPDATE tac_gia_tro_choi SET phan_tram_huong_doanh_thu = :p, thu_tu_hien_thi = :o WHERE tro_choi_id = :g AND nguoi_dung_id = :u',
                        [':p' => $r['share'], ':o' => $r['order'], ':g' => $gid, ':u' => $u]);
                }
            }
            audit('game_authors', 'tro_choi', $gid, ['tac_gia' => array_map(fn($r) => $r['share'], $rows), 'go' => $removed]);
        });
        if ($newId) {
            NotificationModel::notifyUsers([$newId], (int)$user['ma'], 'game_author', 'Bạn được thêm làm tác giả',
                $user['ten_hien_thi'] . ' đã thêm bạn vào dự án ' . $game['tieu_de'] . ' với tỷ lệ ' . $rows[$newId]['share'] . '% doanh thu.', '/dev/games/' . $gid);
        }
        if ($removed) {
            NotificationModel::notifyUsers($removed, (int)$user['ma'], 'game_author', 'Bạn không còn là tác giả',
                'Bạn đã được gỡ khỏi danh sách tác giả của ' . $game['tieu_de'] . '. Doanh thu đã ghi sổ trước đó không thay đổi.', '/dev');
        }
        flash('success', 'Đã lưu danh sách tác giả. Tỷ lệ mới áp dụng cho các lượt bán từ bây giờ.');
        $this->redirect($back);
    }

    // ------------------------------------------------------------ releases --

    public function releases(array $params = []) {
        [, $game] = $this->owned($params);
        $this->view('game-releases', $game, 'releases', ['releases' => ReleaseModel::listForGame((int)$game['ma'])]);
    }

    public function addRelease(array $params = []) {
        [$user, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $r = $this->readRelease($gid, 0, '/dev/games/' . $gid . '/releases#add-release');
        $id = Model::transaction(function () use ($gid, $r, $user) {
            $id = ReleaseModel::create($gid, $r['ten_phien_ban'], $r['kenh_phat_hanh'], (string)$r['ghi_chu_phat_hanh'], (int)$user['ma'], (bool)$r['cong_khai'], $r['ngay_phat_hanh']);
            audit('release_added', 'phien_ban_phat_hanh', $id, ['tro_choi_id' => $gid, 'phien_ban' => $r['ten_phien_ban']]);
            return $id;
        });
        flash('success', 'Đã thêm phiên bản ' . $r['ten_phien_ban'] . '.');
        $this->redirect('/dev/games/' . $gid . '/releases#release-' . $id);
    }

    public function updateRelease(array $params = []) {
        [, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $release = $this->release($gid, $params);
        $id = (int)$release['ma'];
        $r = $this->readRelease($gid, $id, '/dev/games/' . $gid . '/releases#release-' . $id);
        Model::transaction(function () use ($id, $r) {
            ReleaseModel::update($id, $r);
            audit('release_updated', 'phien_ban_phat_hanh', $id);
        });
        flash('success', 'Đã lưu phiên bản ' . $r['ten_phien_ban'] . '.');
        $this->redirect('/dev/games/' . $gid . '/releases#release-' . $id);
    }

    public function deleteRelease(array $params = []) {
        [, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $release = $this->release($gid, $params);
        Model::transaction(function () use ($release, $gid) {
            ReleaseModel::delete((int)$release['ma']);
            audit('release_deleted', 'phien_ban_phat_hanh', (int)$release['ma'], ['tro_choi_id' => $gid, 'phien_ban' => $release['ten_phien_ban'], 'kenh' => $release['kenh_phat_hanh']]);
        });
        flash('success', 'Đã xóa phiên bản ' . $release['ten_phien_ban'] . '.');
        $this->redirect('/dev/games/' . $gid . '/releases');
    }

    // ------------------------------------------------------------- devlogs --

    public function devlogs(array $params = []) {
        [, $game] = $this->owned($params);
        $posts = Model::query("SELECT d.ma, d.tieu_de, d.duong_dan_rut_gon, d.trang_thai, d.ngay_cong_bo, d.ngay_cap_nhat, u.ten_hien_thi,
                (SELECT COUNT(*) FROM binh_luan_nhat_ky c WHERE c.nhat_ky_phat_trien_id = d.ma AND c.trang_thai = 'published') AS so_binh_luan
            FROM nhat_ky_phat_trien d JOIN nguoi_dung u ON u.ma = d.tac_gia_nguoi_dung_id
            WHERE d.tro_choi_id = :g ORDER BY FIELD(d.trang_thai, 'draft') DESC, COALESCE(d.ngay_cong_bo, d.ngay_tao) DESC, d.ma DESC", [':g' => (int)$game['ma']]);
        $this->view('game-devlogs', $game, 'devlogs', ['posts' => $posts]);
    }

    public function newDevlog(array $params = []) {
        [, $game] = $this->owned($params);
        $this->view('devlog-form', $game, 'devlogs', ['post' => null]);
    }

    public function storeDevlog(array $params = []) {
        [$user, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        [$title, $content, $status] = $this->readDevlog(null, '/dev/games/' . $gid . '/devlogs/new');
        $id = Model::transaction(function () use ($gid, $user, $title, $content, $status) {
            $id = DevlogModel::create($gid, (int)$user['ma'], $title, DevlogModel::uniqueSlug($gid, $title), $content, $status === 'published');
            audit('devlog_created', 'nhat_ky_phat_trien', $id, ['trang_thai' => $status]);
            return $id;
        });
        flash('success', $status === 'published' ? 'Đã đăng bài. Người theo dõi trò chơi sẽ nhận được thông báo.' : 'Đã lưu bản nháp.');
        $this->redirect('/dev/games/' . $gid . '/devlogs/' . $id);
    }

    public function editDevlog(array $params = []) {
        [, $game] = $this->owned($params);
        $this->view('devlog-form', $game, 'devlogs', ['post' => $this->devlog((int)$game['ma'], $params)]);
    }

    public function updateDevlog(array $params = []) {
        [$user, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $post = $this->devlog($gid, $params);
        $id = (int)$post['ma'];
        [$title, $content, $status] = $this->readDevlog($post, '/dev/games/' . $gid . '/devlogs/' . $id);
        $firstPublish = $status === 'published' && !$post['ngay_cong_bo'];
        $data = ['tieu_de' => $title, 'noi_dung' => $content, 'trang_thai' => $status];
        if ($firstPublish) {
            $data['ngay_cong_bo'] = date('Y-m-d H:i:s');
        }
        Model::transaction(function () use ($id, $data, $post) {
            DevlogModel::update($id, $data);
            audit('devlog_updated', 'nhat_ky_phat_trien', $id, $data['trang_thai'] !== $post['trang_thai'] ? ['truoc' => $post['trang_thai'], 'sau' => $data['trang_thai']] : []);
        });
        if ($firstPublish) {
            DevlogModel::notifyPublished($gid, (int)$user['ma'], $title, $post['duong_dan_rut_gon']);
        }
        flash('success', $firstPublish ? 'Đã đăng bài. Người theo dõi trò chơi sẽ nhận được thông báo.' : 'Đã lưu bài viết.');
        $this->redirect('/dev/games/' . $gid . '/devlogs/' . $id);
    }

    // ---------------------------------------------------------------- page --

    public function design(array $params = []) {
        [, $game] = $this->owned($params);
        $this->view('game-page', $game, 'page', ['settings' => self::pageSettings((int)$game['ma'])]);
    }

    public function saveDesign(array $params = []) {
        [, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $back = '/dev/games/' . $gid . '/page';
        $colors = [];
        foreach (['mau_nen' => 'Màu nền', 'mau_chu' => 'Màu chữ', 'mau_lien_ket' => 'Màu liên kết'] as $key => $name) {
            $value = strtolower(trim((string)($_POST[$key] ?? '')));
            if ($value !== '' && !preg_match('/^#[0-9a-f]{6}$/', $value)) {
                $this->fail($name . ' phải có dạng #RRGGBB, ví dụ #1a1a2e, hoặc để trống để dùng màu mặc định.', $back);
            }
            $colors[$key] = $value !== '' ? $value : null;
        }
        $layout = (string)($_POST['bo_cuc_trang'] ?? '');
        if (!in_array($layout, ['default', 'wide', 'minimal'], true)) {
            $this->fail('Chọn bố cục trang.', $back);
        }
        // Defaults mirror .game-page.themed in app.css: black ground, white ink, links inherit ink.
        $bg = $colors['mau_nen'] ?? '#000000';
        $ink = $colors['mau_chu'] ?? '#ffffff';
        $link = $colors['mau_lien_ket'] ?? $ink;
        if (self::contrast($bg, $ink) < 4.5) {
            $this->fail('Màu chữ và màu nền có độ tương phản ' . number_format(self::contrast($bg, $ink), 1) . ':1, cần ít nhất 4.5:1 để dễ đọc.', $back);
        }
        if (self::contrast($bg, $link) < 4.5) {
            $this->fail('Màu liên kết và màu nền có độ tương phản ' . number_format(self::contrast($bg, $link), 1) . ':1, cần ít nhất 4.5:1.', $back);
        }
        $row = $colors + ['bo_cuc_trang' => $layout, 'bat_cong_dong' => post_bool('bat_cong_dong'), 'hien_thi_nha_sang_tao' => post_bool('hien_thi_nha_sang_tao')];
        Model::transaction(function () use ($gid, $row) {
            Model::run('INSERT INTO cai_dat_trang_tro_choi (tro_choi_id, mau_nen, mau_chu, mau_lien_ket, bo_cuc_trang, bat_cong_dong, hien_thi_nha_sang_tao)
                VALUES (:g, :bg, :ink, :link, :layout, :community, :creators)
                ON DUPLICATE KEY UPDATE mau_nen = VALUES(mau_nen), mau_chu = VALUES(mau_chu), mau_lien_ket = VALUES(mau_lien_ket), bo_cuc_trang = VALUES(bo_cuc_trang),
                    bat_cong_dong = VALUES(bat_cong_dong), hien_thi_nha_sang_tao = VALUES(hien_thi_nha_sang_tao), ngay_cap_nhat = NOW()', [
                ':g' => $gid, ':bg' => $row['mau_nen'], ':ink' => $row['mau_chu'], ':link' => $row['mau_lien_ket'], ':layout' => $row['bo_cuc_trang'],
                ':community' => $row['bat_cong_dong'], ':creators' => $row['hien_thi_nha_sang_tao'],
            ]);
            audit('game_page_saved', 'tro_choi', $gid, $row);
        });
        flash('success', 'Đã lưu giao diện trang.');
        $this->redirect($back);
    }

    // ---------------------------------------------------------------- keys --

    public function keys(array $params = []) {
        [, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $status = (string)($_GET['status'] ?? '');
        if (!isset(labels('key_status')[$status])) {
            $status = '';
        }
        // "expired" covers both the stored status and available keys whose date has passed.
        $states = "CASE WHEN k.trang_thai = 'available' AND k.ngay_het_han IS NOT NULL AND k.ngay_het_han < NOW() THEN 'expired' ELSE k.trang_thai END";
        $counts = array_column(Model::query("SELECT $states AS s, COUNT(*) n FROM ma_truy_cap_tro_choi k WHERE k.tro_choi_id = :g GROUP BY s", [':g' => $gid]), 'n', 's');
        $where = 'k.tro_choi_id = :g' . ($status !== '' ? " AND $states = :s" : '');
        $bind = [':g' => $gid] + ($status !== '' ? [':s' => $status] : []);
        $total = (int)Model::scalar("SELECT COUNT(*) FROM ma_truy_cap_tro_choi k WHERE $where", $bind);
        $pages = max(1, (int)ceil($total / self::KEYS_PER_PAGE));
        $page = min($this->page(), $pages);
        $keys = Model::query("SELECT k.ma, k.ngay_tao, k.ngay_het_han, k.ngay_nhan_ma, $states AS trang_thai_hien_tai, c.ten_hien_thi nguoi_tao, r.ten_hien_thi nguoi_nhan, r.ten_dang_nhap nguoi_nhan_dn
            FROM ma_truy_cap_tro_choi k JOIN nguoi_dung c ON c.ma = k.nguoi_tao_ma_id LEFT JOIN nguoi_dung r ON r.ma = k.nguoi_nhan_ma_id
            WHERE $where ORDER BY k.ma DESC LIMIT :l OFFSET :o", $bind + [':l' => self::KEYS_PER_PAGE, ':o' => ($page - 1) * self::KEYS_PER_PAGE]);
        $fresh = $_SESSION['dev_new_keys'][$gid] ?? [];
        unset($_SESSION['dev_new_keys'][$gid]);
        $this->view('game-keys', $game, 'keys', [
            'keys' => $keys, 'counts' => $counts, 'status' => $status, 'fresh' => $fresh,
            'total' => $total, 'page' => $page, 'pages' => $pages, 'batch' => self::KEY_BATCH,
        ]);
    }

    public function generateKeys(array $params = []) {
        [$user, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $back = '/dev/games/' . $gid . '/keys#generate';
        $count = post_int('so_luong');
        if ($count < 1 || $count > self::KEY_BATCH) {
            $this->fail('Số lượng mã mỗi lần từ 1 đến ' . self::KEY_BATCH . '.', $back);
        }
        $expires = null;
        $rawDate = trim((string)($_POST['ngay_het_han'] ?? ''));
        if ($rawDate !== '') {
            $date = DateTime::createFromFormat('!Y-m-d', $rawDate);
            if (!$date || $date->format('Y-m-d') !== $rawDate) {
                $this->fail('Ngày hết hạn không hợp lệ.', $back);
            }
            if ($rawDate <= date('Y-m-d')) {
                $this->fail('Ngày hết hạn phải sau hôm nay.', $back);
            }
            $expires = $rawDate . ' 23:59:59';
        }
        $open = (int)Model::scalar("SELECT COUNT(*) FROM ma_truy_cap_tro_choi WHERE tro_choi_id = :g AND trang_thai = 'available'", [':g' => $gid]);
        if ($open + $count > self::MAX_OPEN_KEYS) {
            $this->fail('Mỗi dự án giữ tối đa ' . fmt_int(self::MAX_OPEN_KEYS) . ' mã chưa dùng; hiện có ' . fmt_int($open) . '.', $back);
        }
        $raw = Model::transaction(function () use ($gid, $user, $count, $expires) {
            $out = [];
            while (count($out) < $count) {
                $key = self::newKey();
                if (isset($out[$key])) {
                    continue;
                }
                AccessKeyModel::create($gid, (int)$user['ma'], hash('sha256', $key), $expires);
                $out[$key] = true;
            }
            audit('keys_generated', 'tro_choi', $gid, ['so_luong' => $count, 'het_han' => $expires]);
            return array_keys($out);
        });
        $_SESSION['dev_new_keys'][$gid] = $raw;
        flash('success', 'Đã tạo ' . fmt_int($count) . ' mã truy cập. Sao chép ngay: hệ thống chỉ lưu bản băm và không thể hiển thị lại mã.');
        $this->redirect('/dev/games/' . $gid . '/keys#fresh');
    }

    public function revokeKey(array $params = []) {
        [, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $key = Model::one('SELECT * FROM ma_truy_cap_tro_choi WHERE ma = :k AND tro_choi_id = :g', [':k' => (int)($params['key'] ?? 0), ':g' => $gid]);
        if (!$key) {
            $this->notFound('Không tìm thấy mã truy cập.');
        }
        $back = safe_return($_POST['return_to'] ?? null, '/dev/games/' . $gid . '/keys');
        if ($key['trang_thai'] !== 'available') {
            $this->fail('Chỉ thu hồi được mã chưa sử dụng. Mã này: ' . mb_strtolower(label('key_status', $key['trang_thai'])) . '.', $back);
        }
        Model::transaction(function () use ($key) {
            Model::run("UPDATE ma_truy_cap_tro_choi SET trang_thai = 'revoked' WHERE ma = :k AND trang_thai = 'available'", [':k' => (int)$key['ma']]);
            audit('key_revoked', 'ma_truy_cap_tro_choi', (int)$key['ma']);
        });
        flash('success', 'Đã thu hồi mã #' . (int)$key['ma'] . '.');
        $this->redirect($back);
    }

    // --------------------------------------------------------------- stats --

    public function stats(array $params = []) {
        [, $game] = $this->owned($params);
        $gid = (int)$game['ma'];
        $days = (int)($_GET['days'] ?? 30);
        if (!in_array($days, [7, 30, 90], true)) {
            $days = 30;
        }
        $series = DailyStatsModel::series([$gid], $days);
        $totals = [];
        foreach (['luot_xem_trang', 'luot_nhan_tai_xuong', 'so_luot_mua', 'doanh_thu_gop', 'luot_them_yeu_thich', 'so_luong_binh_luan'] as $c) {
            $totals[$c] = array_sum(array_column($series, $c));
        }
        $lifetime = Model::one("SELECT
                (SELECT COUNT(*) FROM quyen_so_huu_tro_choi WHERE tro_choi_id = :g1 AND trang_thai = 'active') AS so_huu,
                (SELECT COUNT(*) FROM tro_choi_yeu_thich WHERE tro_choi_id = :g2) AS yeu_thich,
                (SELECT COUNT(*) FROM theo_doi_tro_choi WHERE tro_choi_id = :g3) AS theo_doi,
                (SELECT COUNT(*) FROM danh_gia WHERE tro_choi_id = :g4 AND trang_thai = 'published') AS so_danh_gia,
                (SELECT ROUND(AVG(diem_danh_gia), 1) FROM danh_gia WHERE tro_choi_id = :g5 AND trang_thai = 'published') AS diem_tb",
            [':g1' => $gid, ':g2' => $gid, ':g3' => $gid, ':g4' => $gid, ':g5' => $gid]);
        $this->view('game-stats', $game, 'stats', ['series' => $series, 'totals' => $totals, 'days' => $days, 'lifetime' => $lifetime]);
    }

    // ------------------------------------------------------------- helpers --

    /** The game in the route, if the current developer is one of its authors; otherwise 404. */
    private function owned(array $params): array {
        $user = $this->requireRole('developer');
        $game = GameModel::find((int)($params['id'] ?? 0));
        if (!$game || !GameModel::isAuthor((int)$game['ma'], (int)$user['ma'])) {
            $this->notFound('Không tìm thấy dự án.');
        }
        return [$user, $game];
    }

    private function view(string $template, array $game, string $tab, array $data = []): void {
        $this->render('dev/' . $template, $data + [
            'pageTitle' => $game['tieu_de'],
            'game' => $game,
            'tab' => $tab,
            'isCreator' => (int)$game['nguoi_tao_id'] === current_user_id(),
        ]);
    }

    private static function taxonomies(): array {
        return [
            'categories' => Model::query('SELECT ma, ten FROM the_loai ORDER BY ten'),
            'tags' => Model::query('SELECT ma, ten FROM nhan ORDER BY ten'),
            'platforms' => Model::query('SELECT ma, ten_nen_tang FROM nen_tang ORDER BY ma'),
        ];
    }

    private static function pickedFromOld(): array {
        $ids = static fn($v) => array_map('intval', is_array($v) ? $v : []);
        return ['the_loai' => $ids(old('the_loai', [])), 'nhan' => $ids(old('nhan', [])), 'nen_tang' => $ids(old('nen_tang', []))];
    }

    /** Validate the project form. Returns [columns for tro_choi, taxonomy ids]. */
    private function readGameForm(string $back, ?array $game): array {
        $title = post_str('tieu_de', 200);
        if ($title === null || $title === '') {
            $this->fail('Nhập tên dự án (tối đa 200 ký tự).', $back);
        }
        $short = post_str('mo_ta_ngan', 500);
        if ($short === null) {
            $this->fail('Mô tả ngắn tối đa 500 ký tự.', $back);
        }
        $desc = post_str('mo_ta', 20000);
        if ($desc === null) {
            $this->fail('Mô tả chi tiết tối đa 20.000 ký tự.', $back);
        }
        $type = (string)($_POST['loai_du_an'] ?? '');
        $release = (string)($_POST['trang_thai_phat_hanh'] ?? '');
        $pricing = (string)($_POST['mo_hinh_gia'] ?? '');
        if (!in_array($type, GameModel::PROJECT_TYPES, true) || !in_array($release, GameModel::RELEASE_STATUSES, true) || !in_array($pricing, GameModel::PRICING, true)) {
            $this->fail('Chọn loại dự án, tình trạng phát triển và mô hình giá.', $back);
        }

        $rawMin = trim((string)($_POST['gia_toi_thieu'] ?? ''));
        $rawSug = trim((string)($_POST['gia_de_xuat'] ?? ''));
        $min = parse_money($rawMin);
        $sug = parse_money($rawSug);
        if (($rawMin !== '' && $min === null) || ($rawSug !== '' && $sug === null)) {
            $this->fail('Giá phải là số không âm, tối đa 2 chữ số thập phân, ví dụ 4.99.', $back);
        }
        switch ($pricing) {
            case 'free':
                [$min, $sug] = [0.0, null];
                break;
            case 'paid':
                if (!$min || $min <= 0) {
                    $this->fail('Trò chơi trả phí cần giá lớn hơn 0.', $back);
                }
                $sug = null;
                break;
            case 'pay_what_you_want':
                $min = $min ?? 0.0;
                if ($sug !== null && $sug < $min) {
                    $this->fail('Giá đề xuất không được thấp hơn giá tối thiểu.', $back);
                }
                break;
            case 'donation':
                $min = 0.0;
                if ($sug !== null && $sug <= 0) {
                    $sug = null;
                }
                break;
        }
        if ($min > self::MAX_PRICE || ($sug ?? 0) > self::MAX_PRICE) {
            $this->fail('Giá tối đa ' . money(self::MAX_PRICE) . '.', $back);
        }

        $age = post_str('phan_loai_do_tuoi', 40);
        $license = post_str('ten_giay_phep', 120);
        $url = post_str('url_choi_ngoai', 1000);
        if ($age === null || $license === null || $url === null) {
            $this->fail('Phân loại độ tuổi tối đa 40 ký tự, giấy phép 120 ký tự, liên kết 1000 ký tự.', $back);
        }
        if ($url !== '' && (!filter_var($url, FILTER_VALIDATE_URL) || !preg_match('#^https?://#i', $url))) {
            $this->fail('Liên kết chơi ngoài phải là địa chỉ http:// hoặc https:// hợp lệ.', $back);
        }

        $id = $game ? (int)$game['ma'] : 0;
        $slugInput = post_str('duong_dan_rut_gon', 220);
        if ($slugInput === null) {
            $this->fail('Đường dẫn tối đa 220 ký tự.', $back);
        }
        if ($slugInput === '') {
            $slug = self::uniqueGameSlug($title, $id);
        } else {
            $slug = strtolower($slugInput);
            if (!preg_match('/^[a-z0-9]+(?:-[a-z0-9]+)*$/', $slug)) {
                $this->fail('Đường dẫn chỉ gồm chữ thường không dấu, số và dấu gạch ngang, ví dụ ham-nguc-moi.', $back);
            }
            if (Model::scalar('SELECT 1 FROM tro_choi WHERE duong_dan_rut_gon = :s AND ma <> :i', [':s' => $slug, ':i' => $id])) {
                $this->fail('Đường dẫn "' . $slug . '" đã được dự án khác sử dụng.', $back);
            }
        }

        $status = $game ? $game['trang_thai'] : 'draft';
        if ($game && in_array($game['trang_thai'], self::DEV_STATUSES, true)) {
            $status = (string)($_POST['trang_thai'] ?? $game['trang_thai']);
            if (!in_array($status, self::DEV_STATUSES, true)) {
                $this->fail('Trạng thái không hợp lệ.', $back);
            }
            if ($status !== 'draft' && $short === '') {
                $this->fail('Thêm mô tả ngắn trước khi công bố: mô tả này hiển thị trên thẻ trò chơi ở cửa hàng.', $back);
            }
        }

        $taxonomy = [
            'the_loai' => self::validIds('the_loai', 'the_loai'),
            'nhan' => self::validIds('nhan', 'nhan'),
            'nen_tang' => self::validIds('nen_tang', 'nen_tang'),
        ];
        if (count($taxonomy['the_loai']) > self::MAX_CATEGORIES) {
            $this->fail('Chọn tối đa ' . self::MAX_CATEGORIES . ' thể loại.', $back);
        }
        if (count($taxonomy['nhan']) > self::MAX_TAGS) {
            $this->fail('Chọn tối đa ' . self::MAX_TAGS . ' nhãn.', $back);
        }

        return [[
            'tieu_de' => $title,
            'duong_dan_rut_gon' => $slug,
            'mo_ta_ngan' => $short !== '' ? $short : null,
            'mo_ta' => $desc !== '' ? $desc : null,
            'loai_du_an' => $type,
            'trang_thai' => $status,
            'trang_thai_phat_hanh' => $release,
            'mo_hinh_gia' => $pricing,
            'gia_toi_thieu' => $min,
            'gia_de_xuat' => $sug,
            'phan_loai_do_tuoi' => $age !== '' ? $age : null,
            'ten_giay_phep' => $license !== '' ? $license : null,
            'url_choi_ngoai' => $url !== '' ? $url : null,
            'cho_phep_binh_luan' => post_bool('cho_phep_binh_luan'),
            'cho_phep_danh_gia' => post_bool('cho_phep_danh_gia'),
        ], $taxonomy];
    }

    /** Posted ids of one taxonomy, kept only when they exist in $table. */
    private static function validIds(string $field, string $table): array {
        $ids = array_values(array_unique(array_filter(array_map('intval', (array)($_POST[$field] ?? [])), fn($i) => $i > 0)));
        if (!$ids) {
            return [];
        }
        $in = implode(',', $ids);
        return array_map('intval', Model::column("SELECT ma FROM $table WHERE ma IN ($in)"));
    }

    private static function saveTaxonomy(int $gameId, array $taxonomy): void {
        GameCategoryModel::setForGame($gameId, $taxonomy['the_loai']);
        GameTagModel::setForGame($gameId, $taxonomy['nhan']);
        GamePlatformModel::setForGame($gameId, $taxonomy['nen_tang']);
    }

    private static function uniqueGameSlug(string $title, int $exceptId): string {
        $base = mb_substr(slugify($title), 0, 200) ?: 'du-an';
        $slug = $base;
        for ($i = 2; Model::scalar('SELECT 1 FROM tro_choi WHERE duong_dan_rut_gon = :s AND ma <> :i', [':s' => $slug, ':i' => $exceptId]); $i++) {
            $slug = $base . '-' . $i;
        }
        return $slug;
    }

    private static function isDuplicate(PDOException $error): bool {
        return ($error->errorInfo[1] ?? 0) === 1062;
    }

    private function mediaItem(int $gameId, array $params): array {
        $item = Model::one('SELECT * FROM media_tro_choi WHERE ma = :m AND tro_choi_id = :g', [':m' => (int)($params['media'] ?? 0), ':g' => $gameId]);
        if (!$item) {
            $this->notFound('Không tìm thấy tệp.');
        }
        return $item;
    }

    /** Caption, alt text and order; images need alt text. */
    private function readMediaText(string $type, string $back): array {
        $caption = post_str('chu_thich', 300);
        $alt = post_str('van_ban_thay_the', 300);
        if ($caption === null || $alt === null) {
            $this->fail('Chú thích và văn bản thay thế tối đa 300 ký tự.', $back);
        }
        if (in_array($type, self::IMAGE_MEDIA, true) && $alt === '') {
            $this->fail('Mô tả ngắn nội dung ảnh (văn bản thay thế) cho người dùng trình đọc màn hình.', $back);
        }
        return [$caption, $alt, max(0, min(1000, post_int('thu_tu_sap_xep')))];
    }

    private function readLink(string $back): string {
        $url = post_str('url_media', 1500);
        if ($url === null || $url === '' || !filter_var($url, FILTER_VALIDATE_URL) || !preg_match('#^https?://#i', $url)) {
            $this->fail('Nhập địa chỉ http:// hoặc https:// hợp lệ.', $back);
        }
        return $url;
    }

    /** Authors in display order; a legacy game without rows shows its creator at 100%, unsaved. */
    private static function authorRows(array $game): array {
        $rows = GameAuthorModel::listForGame((int)$game['ma']);
        $creator = (int)$game['nguoi_tao_id'];
        if (!in_array($creator, array_map('intval', array_column($rows, 'nguoi_dung_id')), true)) {
            $u = Model::one('SELECT ten_dang_nhap, ten_hien_thi, url_anh_dai_dien FROM nguoi_dung WHERE ma = :u', [':u' => $creator]);
            array_unshift($rows, ($u ?: []) + ['nguoi_dung_id' => $creator, 'phan_tram_huong_doanh_thu' => $rows ? 0 : 100, 'thu_tu_hien_thi' => 0, 'chua_luu' => true]);
        }
        return $rows;
    }

    private static function parsePercent($value): ?float {
        $pct = parse_money($value);
        return $pct !== null && $pct <= 100 ? $pct : null;
    }

    private function release(int $gameId, array $params): array {
        $release = Model::one('SELECT * FROM phien_ban_phat_hanh WHERE ma = :r AND tro_choi_id = :g', [':r' => (int)($params['release'] ?? 0), ':g' => $gameId]);
        if (!$release) {
            $this->notFound('Không tìm thấy phiên bản.');
        }
        return $release;
    }

    /** Validated release columns (for insert and update). */
    private function readRelease(int $gameId, int $exceptId, string $back): array {
        $version = post_str('ten_phien_ban', 60);
        if ($version === null || $version === '') {
            $this->fail('Nhập tên phiên bản, ví dụ 1.2.0 (tối đa 60 ký tự).', $back);
        }
        $channel = (string)($_POST['kenh_phat_hanh'] ?? '');
        if (!isset(labels('channel')[$channel])) {
            $this->fail('Chọn kênh phát hành.', $back);
        }
        $notes = post_str('ghi_chu_phat_hanh', 20000);
        if ($notes === null) {
            $this->fail('Ghi chú phát hành tối đa 20.000 ký tự.', $back);
        }
        $rawDate = trim((string)($_POST['ngay_phat_hanh'] ?? ''));
        $date = $rawDate === '' ? date('Y-m-d H:i:s') : parse_datetime($rawDate);
        if ($date === null) {
            $this->fail('Ngày phát hành không hợp lệ.', $back);
        }
        if (ReleaseModel::versionTaken($gameId, $version, $channel, $exceptId)) {
            $this->fail('Phiên bản ' . $version . ' đã có trên kênh ' . label('channel', $channel) . '.', $back);
        }
        return ['ten_phien_ban' => $version, 'kenh_phat_hanh' => $channel, 'ghi_chu_phat_hanh' => $notes !== '' ? $notes : null, 'cong_khai' => post_bool('cong_khai'), 'ngay_phat_hanh' => $date];
    }

    private function devlog(int $gameId, array $params): array {
        $post = Model::one('SELECT * FROM nhat_ky_phat_trien WHERE ma = :p AND tro_choi_id = :g', [':p' => (int)($params['post'] ?? 0), ':g' => $gameId]);
        if (!$post) {
            $this->notFound('Không tìm thấy bài nhật ký.');
        }
        return $post;
    }

    /** Title, body and status. A post hidden by moderators keeps that status. */
    private function readDevlog(?array $post, string $back): array {
        $title = post_str('tieu_de', 200);
        if ($title === null || $title === '') {
            $this->fail('Nhập tiêu đề (tối đa 200 ký tự).', $back);
        }
        $content = post_str('noi_dung', 50000);
        if ($content === null || $content === '') {
            $this->fail('Nhập nội dung bài viết (tối đa 50.000 ký tự).', $back);
        }
        if ($post && $post['trang_thai'] === 'hidden') {
            return [$title, $content, 'hidden'];
        }
        $status = (string)($_POST['trang_thai'] ?? 'draft');
        if (!in_array($status, ['draft', 'published'], true)) {
            $this->fail('Trạng thái không hợp lệ.', $back);
        }
        return [$title, $content, $status];
    }

    private static function pageSettings(int $gameId): array {
        return Model::one('SELECT * FROM cai_dat_trang_tro_choi WHERE tro_choi_id = :g', [':g' => $gameId]) ?: [
            'mau_nen' => null, 'mau_chu' => null, 'mau_lien_ket' => null, 'bo_cuc_trang' => 'default', 'bat_cong_dong' => 1, 'hien_thi_nha_sang_tao' => 1,
        ];
    }

    /** WCAG 2 contrast ratio of two #rrggbb colours. */
    private static function contrast(string $a, string $b): float {
        $lum = static function (string $hex): float {
            $c = array_map(static function (string $h): float {
                $v = hexdec($h) / 255;
                return $v <= 0.03928 ? $v / 12.92 : (($v + 0.055) / 1.055) ** 2.4;
            }, str_split(ltrim($hex, '#'), 2));
            return 0.2126 * $c[0] + 0.7152 * $c[1] + 0.0722 * $c[2];
        };
        [$hi, $lo] = [max($lum($a), $lum($b)), min($lum($a), $lum($b))];
        return ($hi + 0.05) / ($lo + 0.05);
    }

    /** XXXXX-XXXXX-XXXXX-XXXXX from an alphabet without 0/O/1/I; matches the redeem format. */
    private static function newKey(): string {
        $groups = [];
        for ($g = 0; $g < 4; $g++) {
            $s = '';
            for ($i = 0; $i < 5; $i++) {
                $s .= self::KEY_ALPHABET[random_int(0, strlen(self::KEY_ALPHABET) - 1)];
            }
            $groups[] = $s;
        }
        return implode('-', $groups);
    }
}
