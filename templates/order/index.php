<?php
/** Buyer's order history. @var array $orders @var string $status */
$tabs = ['' => 'Tất cả', 'paid' => labels('order_status')['paid'], 'partially_refunded' => labels('order_status')['partially_refunded'], 'refunded' => labels('order_status')['refunded']];
?>
<div class="title-row">
    <div>
        <h1>Đơn hàng</h1>
        <p class="sub">Lịch sử mua hàng. Mọi thanh toán trên hệ thống này là thanh toán thử nghiệm (sandbox).</p>
    </div>
</div>

<nav class="tabs" aria-label="Lọc theo trạng thái">
    <?php foreach ($tabs as $value => $text): ?>
        <a href="<?= e(app_url('/orders' . ($value !== '' ? '?status=' . $value : ''))) ?>" aria-selected="<?= $status === $value ? 'true' : 'false' ?>"><?= e($text) ?></a>
    <?php endforeach; ?>
</nav>

<?php if (!$orders): ?>
    <div class="empty">
        <p><?= $status === '' ? 'Bạn chưa có đơn hàng nào.' : 'Không có đơn hàng ở trạng thái này.' ?></p>
        <a class="btn primary" href="<?= e(app_url('/games')) ?>">Khám phá trò chơi</a>
    </div>
<?php else: ?>
<section class="panel flush">
    <div class="table-wrap">
        <table class="stack-sm">
            <thead><tr><th>Mã đơn</th><th>Sản phẩm</th><th>Ngày đặt</th><th>Trạng thái</th><th class="n">Tổng</th></tr></thead>
            <tbody>
            <?php foreach ($orders as $order): ?>
                <tr>
                    <td><a class="link" href="<?= e(app_url('/orders/' . rawurlencode($order['ma_don_hang']))) ?>"><?= e($order['ma_don_hang']) ?></a></td>
                    <td data-label="Sản phẩm"><span class="truncate"><?= e($order['titles'] ?: '—') ?></span></td>
                    <td data-label="Ngày" class="hide-sm"><?= e(fmt_datetime($order['ngay_dat_hang'])) ?></td>
                    <td data-label="Trạng thái"><?= status_pill('order_status', $order['trang_thai']) ?></td>
                    <td class="n"><?= e(money($order['tong_thanh_toan'], $order['ma_tien_te'])) ?></td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    </div>
    <?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
</section>
<?php endif; ?>
