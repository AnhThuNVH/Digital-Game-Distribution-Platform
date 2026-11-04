<?php
// =============================================================================
// ORDER CONTROLLER - Tables: don_hang, chi_tiet_don_hang, thanh_toan, hoan_tien
// Buyers see their own orders; staff (admin) can open any order.
// =============================================================================

class OrderController extends Controller {

    public function index(array $params = []) {
        $user = $this->requireAuth();
        $status = (string)($_GET['status'] ?? '');
        if ($status !== '' && !array_key_exists($status, labels('order_status'))) {
            $status = '';
        }
        [$orders, $pager] = $this->paginate(OrderModel::listForUser((int)$user['ma'], $status), 20);
        $this->render('order/index', $pager + [
            'pageTitle' => 'Đơn hàng',
            'orders' => $orders,
            'status' => $status,
        ]);
    }

    public function show(array $params = []) {
        $user = $this->requireAuth();
        $order = $this->ownOrder($params, $user);
        $items = OrderModel::items((int)$order['ma']);
        $mine = (int)$order['nguoi_mua_id'] === (int)$user['ma'];
        foreach ($items as &$item) {
            $item['refund_problem'] = $mine ? RefundModel::problem($order, $item) : 'Chỉ người mua mới có thể yêu cầu hoàn tiền.';
        }
        unset($item);
        $this->render('order/show', [
            'pageTitle' => 'Đơn hàng ' . $order['ma_don_hang'],
            'order' => $order,
            'items' => $items,
            'payments' => OrderModel::payments((int)$order['ma']),
            'refunds' => OrderModel::refunds((int)$order['ma']),
            'coupon' => OrderModel::couponUse((int)$order['ma']),
            'mine' => $mine,
        ]);
    }

    public function requestRefund(array $params = []) {
        $user = $this->requireAuth();
        $order = $this->ownOrder($params, $user);
        $to = '/orders/' . rawurlencode($order['ma_don_hang']);
        if ((int)$order['nguoi_mua_id'] !== (int)$user['ma']) {
            $this->forbidden('Chỉ người mua mới có thể yêu cầu hoàn tiền.');
        }
        $itemId = (int)($_POST['item_id'] ?? 0);
        $item = null;
        foreach (OrderModel::items((int)$order['ma']) as $row) {
            if ((int)$row['ma'] === $itemId) {
                $item = $row;
            }
        }
        if (!$item) {
            $this->fail('Mục cần hoàn tiền không thuộc đơn hàng này.', $to);
        }
        if ($problem = RefundModel::problem($order, $item)) {
            $this->fail($problem, $to);
        }
        $reason = trim((string)($_POST['ly_do'] ?? ''));
        if (mb_strlen($reason) < 10 || mb_strlen($reason) > 2000) {
            $this->fail('Lý do hoàn tiền cần từ 10 đến 2.000 ký tự.', $to . '#item-' . $itemId);
        }
        try {
            $refundId = RefundModel::request($order, $item, (int)$user['ma'], $reason);
        } catch (RuntimeException $error) {
            $this->fail($error->getMessage(), $to);
        }
        audit('refund_request', 'hoan_tien', $refundId);
        $admins = Model::column("SELECT DISTINCT x.nguoi_dung_id FROM nguoi_dung_vai_tro x JOIN vai_tro r ON r.ma = x.vai_tro_id WHERE r.ma_vai_tro = 'admin'");
        NotificationModel::notifyUsers($admins, (int)$user['ma'], 'refund', 'Yêu cầu hoàn tiền mới',
            $order['ma_don_hang'] . ' · ' . $item['tieu_de_luc_mua'] . ' · ' . money((float)$item['thanh_tien_dong']), '/admin/refunds?status=requested');
        flash('success', 'Đã gửi yêu cầu hoàn tiền. Quản trị viên sẽ xem xét và thông báo cho bạn.');
        $this->redirect($to);
    }

    private function ownOrder(array $params, array $user): array {
        $order = OrderModel::findByCode((string)($params['code'] ?? ''));
        if (!$order || ((int)$order['nguoi_mua_id'] !== (int)$user['ma'] && !has_role('admin'))) {
            $this->notFound('Không tìm thấy đơn hàng này.');
        }
        return $order;
    }
}
