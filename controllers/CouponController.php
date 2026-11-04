<?php
// =============================================================================
// COUPON CONTROLLER - Tables: ma_giam_gia, luot_dung_ma_giam_gia (read only here)
// Developers create coupons that only discount their own games; administrators
// create platform-wide coupons. Coupons are never deleted (usage rows reference
// them); they are switched off instead.
// =============================================================================

class CouponController extends Controller {
    public function devIndex(array $params = []) {
        $user = $this->requireRole('developer');
        $this->index('dev', (int)$user['ma']);
    }

    public function adminIndex(array $params = []) {
        $this->requireRole('admin');
        $this->index('admin', null);
    }

    public function devStore(array $params = []) {
        $user = $this->requireRole('developer');
        $this->store('/dev/coupons', (int)$user['ma']);
    }

    public function adminStore(array $params = []) {
        $user = $this->requireRole('admin');
        $this->store('/admin/coupons', (int)$user['ma']);
    }

    public function devToggle(array $params = []) {
        $user = $this->requireRole('developer');
        $this->toggle((int)($params['id'] ?? 0), '/dev/coupons', (int)$user['ma']);
    }

    public function adminToggle(array $params = []) {
        $this->requireRole('admin');
        $this->toggle((int)($params['id'] ?? 0), '/admin/coupons', null);
    }

    private function index(string $scope, ?int $creatorId) {
        [$coupons, $pager] = $this->paginate(CouponModel::listFor($creatorId), 20);
        $this->render('coupons/index', $pager + [
            'pageTitle' => 'Mã giảm giá',
            'scope' => $scope,
            'coupons' => $coupons,
            'gameCount' => $creatorId === null ? 0 : count(GameModel::listForAuthor($creatorId)),
        ]);
    }

    private function store(string $back, int $creatorId) {
        [$data, $errors] = CouponModel::fromForm($_POST);
        if ($errors) {
            $this->fail(implode(' ', $errors), $back . '#new');
        }
        $data['nguoi_tao_id'] = $creatorId;
        $data['dang_hoat_dong'] = 1;
        $id = CouponModel::insert($data);
        audit('coupon.create', 'ma_giam_gia', $id, ['code' => $data['ma_uu_dai']]);
        flash('success', 'Đã tạo mã ' . $data['ma_uu_dai'] . '.');
        $this->redirect($back);
    }

    /** $ownerId null: any coupon (admin); otherwise only coupons that user created. */
    private function toggle(int $id, string $back, ?int $ownerId) {
        $coupon = $id > 0 ? CouponModel::find($id) : null;
        if (!$coupon || ($ownerId !== null && (int)$coupon['nguoi_tao_id'] !== $ownerId)) {
            $this->notFound('Không tìm thấy mã giảm giá.');
        }
        $on = (int)$coupon['dang_hoat_dong'] ? 0 : 1;
        CouponModel::update($id, ['dang_hoat_dong' => $on]);
        audit($on ? 'coupon.enable' : 'coupon.disable', 'ma_giam_gia', $id, ['code' => $coupon['ma_uu_dai']]);
        flash('success', ($on ? 'Đã bật mã ' : 'Đã tắt mã ') . $coupon['ma_uu_dai'] . '.');
        $this->back($back);
    }
}
