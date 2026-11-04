<?php
// =============================================================================
// STORE CONTROLLER - home page
// =============================================================================

class StoreController extends Controller {
    public function home(array $params = []) {
        $uid = current_user_id();
        $popular = GameModel::catalogue(['sort' => 'popular'], 7, 0);
        // Chỉ giới thiệu trò chơi có ảnh chụp màn hình: ảnh lớn của khối nổi bật là ảnh chụp đầu tiên.
        $featured = null;
        $featuredShots = [];
        foreach (GameModel::catalogue(['sort' => 'popular'], 24, 0) as $game) {
            $shots = Model::query("SELECT url_media, van_ban_thay_the, chu_thich FROM media_tro_choi WHERE tro_choi_id = :g AND loai_media = 'screenshot' ORDER BY thu_tu_sap_xep, ma LIMIT 4", [':g' => (int)$game['ma']]);
            if ($shots) {
                $featured = $game;
                $featuredShots = $shots;
                break;
            }
        }

        $categories = Model::query("SELECT t.ten, t.duong_dan_rut_gon, COUNT(g.ma) AS so_game FROM the_loai t
            LEFT JOIN tro_choi_the_loai x ON x.the_loai_id = t.ma LEFT JOIN tro_choi g ON g.ma = x.tro_choi_id AND g.trang_thai = 'published'
            GROUP BY t.ma, t.ten, t.duong_dan_rut_gon ORDER BY so_game DESC, t.ten");
        $jams = Model::query("SELECT ma, tieu_de, duong_dan_rut_gon, trang_thai, ngay_bat_dau, han_nop_bai,
                (SELECT COUNT(*) FROM bai_du_thi b WHERE b.cuoc_thi_id = cuoc_thi_lam_game.ma AND b.trang_thai = 'submitted') AS so_bai
            FROM cuoc_thi_lam_game WHERE trang_thai IN ('published','active','judging') ORDER BY FIELD(trang_thai,'active','published','judging'), han_nop_bai LIMIT 3");

        $this->render('home/index', [
            'pageTitle' => '',
            'featured' => $featured,
            'featuredShots' => $featuredShots,
            'popular' => $popular,
            'newest' => GameModel::catalogue(['sort' => 'new'], 6, 0),
            'onSale' => GameModel::catalogue(['sale' => 1, 'sort' => 'popular'], 6, 0),
            'topRated' => GameModel::catalogue(['sort' => 'rating'], 6, 0),
            'free' => GameModel::catalogue(['price' => 'free', 'sort' => 'popular'], 6, 0),
            'categories' => $categories,
            'bundles' => BundleModel::onSale(3),
            'jams' => $jams,
            'owned' => OwnershipModel::ownedIds($uid),
            'totalGames' => GameModel::countCatalogue([]),
        ]);
    }
}
