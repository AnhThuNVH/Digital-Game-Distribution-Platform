<?php
// =============================================================================
// BUNDLE ADMIN CONTROLLER - /dev/bundles and /admin/bundles.
// Tables: goi_game, tro_choi_goi_game. Developers bundle published games they
// are an author of (creator_created); admins bundle any published game
// (platform_curated) and can edit every bundle. Bundles are never deleted:
// order lines reference them, so they are hidden or ended instead.
// =============================================================================

class BundleAdminController extends Controller {
    public function devIndex(array $params = []) {
        $user = $this->requireRole('developer');
        $this->index('dev', (int)$user['ma']);
    }

    public function adminIndex(array $params = []) {
        $this->requireRole('admin');
        $this->index('admin', null);
    }

    public function devCreate(array $params = []) {
        $user = $this->requireRole('developer');
        $this->form('dev', null, (int)$user['ma']);
    }

    public function adminCreate(array $params = []) {
        $this->requireRole('admin');
        $this->form('admin', null, null);
    }

    public function devStore(array $params = []) {
        $user = $this->requireRole('developer');
        $this->store('dev', $user, (int)$user['ma']);
    }

    public function adminStore(array $params = []) {
        $user = $this->requireRole('admin');
        $this->store('admin', $user, null);
    }

    public function devEdit(array $params = []) {
        $user = $this->requireRole('developer');
        $this->form('dev', $this->bundle($params, (int)$user['ma']), (int)$user['ma']);
    }

    public function adminEdit(array $params = []) {
        $this->requireRole('admin');
        $this->form('admin', $this->bundle($params, null), null);
    }

    public function devUpdate(array $params = []) {
        $user = $this->requireRole('developer');
        $this->update('dev', $this->bundle($params, (int)$user['ma']), (int)$user['ma']);
    }

    public function adminUpdate(array $params = []) {
        $this->requireRole('admin');
        $this->update('admin', $this->bundle($params, null), null);
    }

    private function index(string $scope, ?int $creatorId) {
        [$bundles, $pager] = $this->paginate(BundleModel::listFor($creatorId), 20);
        $this->render('bundle/manage', $pager + [
            'pageTitle' => $scope === 'admin' ? 'Gói game' : 'Gói game của tôi',
            'scope' => $scope,
            'bundles' => $bundles,
            'gameCount' => $creatorId === null ? 0 : count(BundleModel::eligibleGames($creatorId)),
        ]);
    }

    /** $authorId limits the selectable games to the developer's own published games. */
    private function form(string $scope, ?array $bundle, ?int $authorId) {
        $id = $bundle ? (int)$bundle['ma'] : 0;
        $games = BundleModel::eligibleGames($authorId);
        $picked = $id ? BundleModel::gameIds($id) : [];
        // Games already in the bundle that can no longer be picked (unpublished, or not this developer's).
        $gone = array_diff($picked, array_map('intval', array_column($games, 'ma')));
        $this->render('bundle/form', [
            'pageTitle' => $bundle ? 'Sửa ' . $bundle['tieu_de'] : 'Tạo gói game',
            'scope' => $scope,
            'bundle' => $bundle,
            'games' => $games,
            'picked' => $picked,
            'dropped' => $gone ? Model::column('SELECT tieu_de FROM tro_choi WHERE ma IN (' . implode(',', $gone) . ') ORDER BY tieu_de') : [],
            'sales' => $id ? (int)Model::scalar("SELECT COUNT(*) FROM chi_tiet_don_hang WHERE goi_game_id = :b", [':b' => $id]) : 0,
        ]);
    }

    private function store(string $scope, array $user, ?int $authorId) {
        $base = '/' . $scope . '/bundles';
        [$row, $games, $errors] = BundleModel::fromForm($_POST, $this->allowed($authorId));
        if ($errors) {
            $this->fail(implode(' ', $errors), $base . '/new');
        }
        $row += [
            'nguoi_tao_id' => (int)$user['ma'],
            'loai_goi_game' => $scope === 'admin' ? 'platform_curated' : 'creator_created',
            'ma_tien_te' => APP_CURRENCY,
        ];
        $id = BundleModel::transaction(function () use ($row, $games) {
            $id = BundleModel::insert($row);
            BundleModel::saveGames($id, $games);
            return $id;
        });
        audit('bundle.create', 'goi_game', $id, ['status' => $row['trang_thai'], 'price' => $row['gia'], 'games' => $games]);
        flash('success', 'Đã tạo gói "' . $row['tieu_de'] . '".');
        $this->redirect($base . '/' . $id);
    }

    private function update(string $scope, array $bundle, ?int $authorId) {
        $id = (int)$bundle['ma'];
        $back = '/' . $scope . '/bundles/' . $id;
        [$row, $games, $errors] = BundleModel::fromForm($_POST, $this->allowed($authorId), $id);
        if ($errors) {
            $this->fail(implode(' ', $errors), $back);
        }
        BundleModel::transaction(function () use ($id, $row, $games) {
            BundleModel::update($id, $row);
            BundleModel::saveGames($id, $games);
        });
        audit('bundle.update', 'goi_game', $id, ['status' => $row['trang_thai'], 'price' => $row['gia'], 'games' => $games]);
        flash('success', 'Đã lưu gói "' . $row['tieu_de'] . '".');
        $this->redirect($back);
    }

    /** Game ids the form may use: null for admins (any published game). */
    private function allowed(?int $authorId): ?array {
        return $authorId === null ? null : array_map('intval', array_column(BundleModel::eligibleGames($authorId), 'ma'));
    }

    /** The bundle from the URL; developers only reach their own (404 otherwise). */
    private function bundle(array $params, ?int $ownerId): array {
        $id = (int)($params['id'] ?? 0);
        $bundle = $id > 0 ? BundleModel::find($id) : null;
        if (!$bundle || ($ownerId !== null && (int)$bundle['nguoi_tao_id'] !== $ownerId)) {
            $this->notFound('Không tìm thấy gói game.');
        }
        return $bundle;
    }
}
