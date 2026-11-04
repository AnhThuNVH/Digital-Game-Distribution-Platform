<?php
// =============================================================================
// BUNDLE CONTROLLER - Tables: goi_game, tro_choi_goi_game (public side)
// Creating and editing bundles lives in BundleAdminController.
// =============================================================================

class BundleController extends Controller {
    public function index(array $params = []) {
        [$bundles, $pager] = $this->paginate(BundleModel::onSale(500), 12);
        $this->render('bundle/index', [
            'pageTitle' => 'Gói game',
            'bundles' => $bundles,
        ] + $pager);
    }

    public function show(array $params = []) {
        $bundle = BundleModel::findBySlug((string)($params['slug'] ?? ''));
        $uid = current_user_id();
        $canManage = $bundle && $uid && ((int)$bundle['nguoi_tao_id'] === $uid || has_role('admin'));
        // Drafts and hidden bundles are only visible to their creator and admins.
        if (!$bundle || (!in_array($bundle['trang_thai'], ['published', 'ended'], true) && !$canManage)) {
            $this->notFound('Không tìm thấy gói game này.');
        }
        $games = BundleModel::games((int)$bundle['ma']);
        $owned = $uid ? OwnershipModel::ownedIds($uid, array_map('intval', array_column($games, 'ma'))) : [];
        $listTotal = 0.0;
        foreach ($games as $g) {
            $listTotal += GameModel::basePrice($g);
        }
        $inCart = $uid && Model::scalar("SELECT 1 FROM muc_gio_hang i JOIN gio_hang c ON c.ma = i.gio_hang_id
            WHERE c.nguoi_dung_id = :u AND c.trang_thai = 'active' AND i.goi_game_id = :b", [':u' => $uid, ':b' => (int)$bundle['ma']]);
        $this->render('bundle/show', [
            'pageTitle' => $bundle['tieu_de'],
            'bundle' => $bundle,
            'games' => $games,
            'owned' => $owned,
            'listTotal' => round($listTotal, 2),
            'onSale' => BundleModel::isOnSale($bundle),
            'inCart' => (bool)$inCart,
            'canManage' => (bool)$canManage,
        ]);
    }
}
