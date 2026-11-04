<?php
/** Admin order list. @var array $filters @var array $counts @var array $totals @var array $orders @var int $total @var int $page @var int $pages */
$all = array_sum(array_map('intval', $counts));
?>
<div class="title-row">
    <div><h1>Đơn hàng</h1><p class="sub">Tra cứu đơn theo mã, người mua hoặc email. Hoàn tiền được xử lý ở trang Hoàn tiền.</p></div>
    <a class="btn" href="<?= e(app_url('/admin/refunds')) ?>">Yêu cầu hoàn tiền</a>
</div>

<section class="kpis" aria-label="Tổng quan doanh thu">
    <div class="kpi"><div class="kpi-label">Tổng số đơn</div><div class="kpi-value"><?= fmt_int($all) ?></div></div>
    <div class="kpi"><div class="kpi-label">Doanh thu đã thanh toán</div><div class="kpi-value"><?= e(money($totals['gross'])) ?></div></div>
    <div class="kpi"><div class="kpi-label">Đã hoàn tiền</div><div class="kpi-value"><?= e(money($totals['refunded'])) ?></div></div>
</section>

<nav class="chips chips-row section" aria-label="Lọc theo trạng thái">
    <a class="chip"<?= $filters['status'] === '' ? ' aria-current="true"' : '' ?> href="<?= e(app_url('/admin/orders' . qs(['status' => null, 'page' => null]))) ?>">Tất cả <span class="muted"><?= fmt_int($all) ?></span></a>
    <?php foreach (labels('order_status') as $k => $t): if (empty($counts[$k])) continue; ?>
        <a class="chip"<?= $filters['status'] === $k ? ' aria-current="true"' : '' ?> href="<?= e(app_url('/admin/orders' . qs(['status' => $k, 'page' => null]))) ?>"><?= e($t) ?> <span class="muted"><?= fmt_int((int)$counts[$k]) ?></span></a>
    <?php endforeach; ?>
</nav>

<form class="toolbar" method="get" action="<?= e(app_url('/admin/orders')) ?>">
    <?php if ($filters['status'] !== ''): ?><input type="hidden" name="status" value="<?= e($filters['status']) ?>"><?php endif; ?>
    <div class="search">
        <label class="sr-only" for="o-q">Tìm theo mã đơn, tên đăng nhập hoặc email</label>
        <input class="input" id="o-q" type="search" name="q" value="<?= e($filters['q']) ?>" placeholder="Mã đơn, tên đăng nhập, email…" maxlength="100">
    </div>
    <span class="spacer"></span>
    <span class="count"><?= fmt_int($total) ?> đơn</span>
</form>

<?php if ($orders): ?>
<section class="panel flush">
    <table>
        <thead><tr><th scope="col">Đơn hàng</th><th scope="col">Người mua</th><th scope="col">Trạng thái</th><th scope="col" class="num">Tổng thanh toán</th><th scope="col">Ngày đặt</th></tr></thead>
        <tbody>
        <?php foreach ($orders as $o): ?>
            <tr>
                <td>
                    <details class="edit">
                        <summary class="link-btn"><?= e($o['ma_don_hang']) ?></summary>
                        <div class="well">
                            <div class="rows">
                                <?php foreach ($o['items'] as $i): ?>
                                    <div class="row">
                                        <div class="grow"><?= e($i['tieu_de_luc_mua']) ?><span class="sub"><?= $i['loai_muc'] === 'bundle' ? 'Gói game' : 'Trò chơi' ?> · <?= e(money($i['don_gia'])) ?><?= (float)$i['so_tien_giam'] > 0 ? ' · giảm ' . e(money($i['so_tien_giam'])) : '' ?></span></div>
                                        <?php if ($i['refund_status']): ?><?= status_pill('refund_status', $i['refund_status']) ?><?php endif; ?>
                                        <span><?= e(money($i['thanh_tien_dong'])) ?></span>
                                    </div>
                                <?php endforeach; ?>
                            </div>
                            <?php foreach ($o['payments'] as $p): ?>
                                <p class="small muted">Thanh toán #<?= (int)$p['ma'] ?> qua <?= e($p['nha_cung_cap']) ?> · <?= e(money($p['so_tien'])) ?> · <?= e(label('payment_status', $p['trang_thai'])) ?><?= $p['ngay_thanh_toan'] ? ' · ' . e(fmt_datetime($p['ngay_thanh_toan'])) : '' ?></p>
                            <?php endforeach; ?>
                        </div>
                    </details>
                    <span class="sub"><?= fmt_int((int)$o['item_count']) ?> mục</span>
                </td>
                <td><a class="link" href="<?= e(app_url('/admin/users/' . (int)$o['nguoi_mua_id'])) ?>"><?= e($o['buyer_name']) ?></a><span class="sub">@<?= e($o['buyer_username']) ?></span></td>
                <td><?= status_pill('order_status', $o['trang_thai']) ?></td>
                <td class="num"><?= e(money($o['tong_thanh_toan'])) ?><?php if ((float)$o['tong_tien_giam'] > 0): ?><span class="sub">giảm <?= e(money($o['tong_tien_giam'])) ?></span><?php endif; ?></td>
                <td><?= e(fmt_datetime($o['ngay_dat_hang'])) ?></td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</section>
<?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
<?php else: ?>
    <div class="empty"><p>Không có đơn hàng nào khớp bộ lọc.</p><?php if ($filters['q'] !== '' || $filters['status'] !== ''): ?><a class="btn" href="<?= e(app_url('/admin/orders')) ?>">Xóa bộ lọc</a><?php endif; ?></div>
<?php endif; ?>
