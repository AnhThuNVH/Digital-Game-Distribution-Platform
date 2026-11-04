<?php
// =============================================================================
// CAMPAIGN CONTROLLER - /admin/campaigns. Tables: chien_dich_giam_gia,
// tro_choi_giam_gia. Campaigns are cancelled, never deleted.
// =============================================================================

class CampaignController extends Controller {
    public function index(array $params = []) {
        $this->requireRole('admin');
        [$campaigns, $pager] = $this->paginate(DiscountCampaignModel::listAll(), 20);
        $this->render('admin/campaigns', ['pageTitle' => 'Chiến dịch giảm giá', 'campaigns' => $campaigns] + $pager);
    }

    public function create(array $params = []) {
        $this->requireRole('admin');
        $this->form(null);
    }

    public function store(array $params = []) {
        $user = $this->requireRole('admin');
        [$row, $games, $errors] = DiscountCampaignModel::fromForm($_POST);
        if ($errors) {
            $this->fail(implode(' ', $errors), '/admin/campaigns/new');
        }
        $id = DiscountCampaignModel::transaction(function () use ($row, $games, $user) {
            $id = DiscountCampaignModel::insert($row + ['nguoi_tao_id' => (int)$user['ma']]);
            DiscountCampaignModel::setGames($id, $games);
            return $id;
        });
        audit('campaign.create', 'chien_dich_giam_gia', $id, ['status' => $row['trang_thai'], 'games' => $games]);
        flash('success', 'Đã tạo chiến dịch "' . $row['tieu_de'] . '".');
        $this->redirect('/admin/campaigns/' . $id);
    }

    public function edit(array $params = []) {
        $this->requireRole('admin');
        $this->form($this->campaign($params));
    }

    public function update(array $params = []) {
        $this->requireRole('admin');
        $campaign = $this->campaign($params);
        $id = (int)$campaign['ma'];
        [$row, $games, $errors] = DiscountCampaignModel::fromForm($_POST);
        if ($errors) {
            $this->fail(implode(' ', $errors), '/admin/campaigns/' . $id);
        }
        DiscountCampaignModel::transaction(function () use ($id, $row, $games) {
            DiscountCampaignModel::update($id, $row);
            DiscountCampaignModel::setGames($id, $games);
        });
        audit('campaign.update', 'chien_dich_giam_gia', $id, ['status' => $row['trang_thai'], 'games' => $games]);
        flash('success', 'Đã lưu chiến dịch.');
        $this->redirect('/admin/campaigns/' . $id);
    }

    private function form(?array $campaign) {
        $id = $campaign ? (int)$campaign['ma'] : 0;
        $this->render('admin/campaign-form', [
            'pageTitle' => $campaign ? 'Sửa ' . $campaign['tieu_de'] : 'Tạo chiến dịch',
            'campaign' => $campaign,
            'games' => DiscountCampaignModel::eligibleGames($id),
            'picked' => $id ? DiscountCampaignModel::gameIds($id) : [],
        ]);
    }

    private function campaign(array $params): array {
        $id = (int)($params['id'] ?? 0);
        $campaign = $id > 0 ? DiscountCampaignModel::find($id) : null;
        if (!$campaign) {
            $this->notFound('Không tìm thấy chiến dịch.');
        }
        return $campaign;
    }
}
