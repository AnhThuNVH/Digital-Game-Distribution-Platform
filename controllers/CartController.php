<?php
// =============================================================================
// CART CONTROLLER - Tables: gio_hang, muc_gio_hang (checkout lives in CartModel)
// Payment is a sandbox: no real money moves and every order is marked TEST-.
// =============================================================================

class CartController extends Controller {
    private const PWYW_MAX = 1000;

    public function index(array $params = []) {
        $user = $this->requireAuth();
        $lines = CartModel::lines((int)$user['ma']);
        $coupon = CartModel::appliedCoupon();
        $totals = CartModel::totals($lines, $coupon);
        $this->render('cart/index', [
            'pageTitle' => 'Giỏ hàng',
            'lines' => $lines,
            'coupon' => $coupon,
            'totals' => $totals,
        ]);
    }

    public function add(array $params = []) {
        $user = $this->requireAuth();
        $uid = (int)$user['ma'];
        $type = (string)($_POST['type'] ?? '');
        $id = (int)($_POST['id'] ?? 0);

        if ($type === 'game' && isset($_POST['amount'])) {
            $game = GameModel::findWithCard($id);
            if ($game && $game['mo_hinh_gia'] === 'pay_what_you_want') {
                $amount = parse_money($_POST['amount']);
                $min = (float)$game['gia_toi_thieu'];
                if ($amount === null || $amount < $min || $amount > self::PWYW_MAX) {
                    flash('error', 'Số tiền phải từ ' . money($min) . ' đến ' . money(self::PWYW_MAX) . '.');
                    $this->back('/cart');
                }
                $_SESSION['pwyw'][$id] = $amount;
            }
        }

        $fromCart = ($_POST['from'] ?? '') === 'cart';
        $error = CartModel::add($uid, $type, $id);
        if ($error === CartModel::ALREADY && !$fromCart) {
            flash('info', $error);
            $this->back('/cart');
        }
        if ($error && $error !== CartModel::ALREADY) {
            flash('error', $error);
            $this->back('/cart');
        }
        if ($fromCart) {
            flash('success', 'Đã cập nhật giỏ hàng.');
            $this->redirect('/cart');
        }
        flash('success', 'Đã thêm vào giỏ hàng.');
        $this->back('/cart');
    }

    public function remove(array $params = []) {
        $user = $this->requireAuth();
        $itemId = (int)($params['id'] ?? 0);
        $gameId = (int)Model::scalar('SELECT i.tro_choi_id FROM muc_gio_hang i JOIN gio_hang c ON c.ma = i.gio_hang_id WHERE i.ma = :i AND c.nguoi_dung_id = :u', [':i' => $itemId, ':u' => (int)$user['ma']]);
        if (CartModel::remove((int)$user['ma'], $itemId)) {
            if ($gameId) {
                unset($_SESSION['pwyw'][$gameId]);
            }
            flash('success', 'Đã bỏ sản phẩm khỏi giỏ hàng.');
        }
        $this->redirect('/cart');
    }

    public function applyCoupon(array $params = []) {
        $user = $this->requireAuth();
        $code = strtoupper(trim((string)($_POST['code'] ?? '')));
        if (!preg_match('/^[A-Z0-9_-]{4,40}$/', $code)) {
            $this->fail('Mã giảm giá gồm 4–40 ký tự chữ, số, gạch ngang hoặc gạch dưới.', '/cart');
        }
        $coupon = CouponModel::findByCode($code);
        if (!$coupon) {
            $this->fail('Không tìm thấy mã giảm giá này.', '/cart');
        }
        if ($problem = CouponModel::problem($coupon)) {
            $this->fail($problem, '/cart');
        }
        $lines = CartModel::lines((int)$user['ma']);
        $totals = CartModel::totals($lines, $coupon);
        if (!$totals['coupon_applies']) {
            $this->fail('Mã này không áp dụng cho sản phẩm nào trong giỏ hàng.', '/cart');
        }
        $_SESSION['cart_coupon'] = $code;
        flash('success', 'Đã áp dụng mã ' . $code . ', giảm ' . money($totals['coupon']) . '.');
        $this->redirect('/cart');
    }

    public function removeCoupon(array $params = []) {
        $this->requireAuth();
        unset($_SESSION['cart_coupon']);
        flash('info', 'Đã gỡ mã giảm giá.');
        $this->redirect('/cart');
    }

    public function checkout(array $params = []) {
        $user = $this->requireAuth();
        if (empty($_POST['confirm_sandbox'])) {
            $this->fail('Hãy xác nhận bạn hiểu đây là thanh toán thử nghiệm.', '/cart');
        }
        try {
            $code = CartModel::checkout((int)$user['ma']);
        } catch (RuntimeException $error) {
            $this->fail($error->getMessage(), '/cart');
        }
        audit('order_paid', 'don_hang', (int)Model::scalar('SELECT ma FROM don_hang WHERE ma_don_hang = :c', [':c' => $code]));
        flash('success', 'Thanh toán thử nghiệm thành công. Trò chơi đã được thêm vào thư viện.');
        $this->redirect('/orders/' . rawurlencode($code));
    }
}
