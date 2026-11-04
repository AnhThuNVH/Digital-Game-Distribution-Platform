<?php
/** Developer sales ledger. @var array $balances @var string $status @var array $counts @var array $byGame @var array $rows @var int $total @var int $page @var int $pages */
$all = array_sum(array_map('intval', $counts));
?>
<div class="title-row">
    <div><h1>Doanh thu</h1><p class="sub">Mỗi lượt bán tạo một dòng sổ cho từng tác giả theo tỷ lệ chia doanh thu. Nền tảng thu phí <?= rtrim(rtrim(number_format(PLATFORM_FEE_RATE * 100, 1), '0'), '.') ?>%.</p></div>
    <a class="btn" href="<?= e(app_url('/dev/payouts')) ?>">Chi trả</a>
</div>

<section class="kpis" aria-label="Số dư">
    <div class="kpi"><div class="kpi-label">Doanh thu gộp</div><div class="kpi-value"><?= e(money($balances['gross'])) ?></div></div>
    <div class="kpi"><div class="kpi-label">Phí nền tảng</div><div class="kpi-value"><?= e(money($balances['fee'])) ?></div></div>
    <div class="kpi"><div class="kpi-label">Thực nhận</div><div class="kpi-value"><?= e(money($balances['pending'] + $balances['available'] + $balances['held'] + $balances['paid'])) ?></div></div>
    <div class="kpi"><div class="kpi-label">Đã đảo do hoàn tiền</div><div class="kpi-value"><?= e(money($balances['reversed'])) ?></div></div>
</section>

<?php if ($byGame): ?>
<section class="panel flush section" aria-labelledby="bygame-h">
    <header><h2 id="bygame-h">Theo sản phẩm</h2></header>
    <table>
        <thead><tr><th scope="col">Sản phẩm</th><th scope="col" class="num">Lượt bán</th><th scope="col" class="num">Doanh thu gộp</th><th scope="col" class="num">Thực nhận</th></tr></thead>
        <tbody>
        <?php foreach ($byGame as $g): ?>
            <tr><td><?= e($g['tieu_de_luc_mua']) ?><span class="sub"><?= $g['loai_muc'] === 'bundle' ? 'Gói game' : 'Trò chơi' ?></span></td><td class="num"><?= fmt_int((int)$g['so_luot']) ?></td><td class="num"><?= e(money($g['gop'])) ?></td><td class="num"><?= e(money($g['thuc_nhan'])) ?></td></tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</section>
<?php endif; ?>

<h2 class="sub-head">Sổ doanh thu</h2>
<nav class="chips chips-row" aria-label="Lọc theo trạng thái">
    <a class="chip"<?= $status === '' ? ' aria-current="true"' : '' ?> href="<?= e(app_url('/dev/sales')) ?>">Tất cả <span class="muted"><?= fmt_int($all) ?></span></a>
    <?php foreach (labels('ledger_status') as $k => $t): if (empty($counts[$k])) continue; ?>
        <a class="chip"<?= $status === $k ? ' aria-current="true"' : '' ?> href="<?= e(app_url('/dev/sales?status=' . $k)) ?>"><?= e($t) ?> <span class="muted"><?= fmt_int((int)$counts[$k]) ?></span></a>
    <?php endforeach; ?>
</nav>

<?php if ($rows): ?>
<section class="panel flush">
    <table>
        <thead><tr><th scope="col">Ngày</th><th scope="col">Sản phẩm</th><th scope="col" class="num">Tỷ lệ</th><th scope="col" class="num">Gộp</th><th scope="col" class="num">Phí</th><th scope="col" class="num">Thực nhận</th><th scope="col">Trạng thái</th></tr></thead>
        <tbody>
        <?php foreach ($rows as $r): ?>
            <tr>
                <td><?= e(fmt_date($r['ngay_dat_hang'])) ?></td>
                <td><?= e($r['tieu_de_luc_mua']) ?><span class="sub">Đơn <?= e($r['ma_don_hang']) ?></span></td>
                <td class="num"><?= e(rtrim(rtrim((string)$r['phan_tram_huong_doanh_thu'], '0'), '.')) ?>%</td>
                <td class="num"><?= e(money($r['doanh_thu_truoc_phi'])) ?></td>
                <td class="num"><?= e(money($r['phi_nen_tang'])) ?></td>
                <td class="num"><?= e(money($r['so_tien_thuc_nhan'])) ?></td>
                <td><?= status_pill('ledger_status', $r['trang_thai']) ?><?php if ($r['trang_thai'] === 'pending'): ?><span class="sub">từ <?= e(fmt_date($r['ngay_co_the_chi_tra'])) ?></span><?php endif; ?></td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</section>
<?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
<?php else: ?>
    <div class="empty"><p><?= $status === '' ? 'Chưa có lượt bán nào. Doanh thu sẽ xuất hiện ở đây khi người chơi mua sản phẩm của bạn.' : 'Không có dòng nào ở trạng thái này.' ?></p></div>
<?php endif; ?>
