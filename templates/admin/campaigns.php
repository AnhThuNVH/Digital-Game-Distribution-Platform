<?php
/** Discount campaign list. @var array $campaigns */
$pct = static fn($p): string => rtrim(rtrim(number_format((float)$p, 2, ',', ''), '0'), ',') . '%';
?>
<div class="title-row">
    <div><h1>Chiến dịch giảm giá</h1><p class="sub">Giảm theo phần trăm cho các trò chơi trả phí trong khoảng thời gian đã đặt. Khi một trò chơi ở nhiều chiến dịch cùng lúc, mức giảm cao nhất được áp dụng.</p></div>
    <a class="btn primary" href="<?= e(app_url('/admin/campaigns/new')) ?>">Tạo chiến dịch</a>
</div>

<?php if ($campaigns): ?>
<section class="panel">
    <div class="table-wrap">
        <table>
            <thead><tr><th scope="col">Chiến dịch</th><th scope="col" class="num">Giảm</th><th scope="col">Thời gian</th><th scope="col">Trạng thái</th><th scope="col" class="num">Trò chơi</th></tr></thead>
            <tbody>
            <?php foreach ($campaigns as $c): ?>
                <tr>
                    <td class="lead"><a class="link" href="<?= e(app_url('/admin/campaigns/' . (int)$c['ma'])) ?>"><?= e($c['tieu_de']) ?></a><span class="sub">#<?= (int)$c['ma'] ?> · <?= e($c['nguoi_tao']) ?></span></td>
                    <td class="num"><?= e($pct($c['phan_tram_giam_gia'])) ?></td>
                    <td class="when"><?= e(fmt_datetime($c['ngay_bat_dau'])) ?><span class="sub">đến <?= e(fmt_datetime($c['ngay_ket_thuc'])) ?></span></td>
                    <td><?= status_pill('campaign_status', DiscountCampaignModel::phase($c)) ?></td>
                    <td class="num"><?= fmt_int((int)$c['so_tro_choi']) ?></td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    </div>
    <?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
</section>
<?php else: ?>
    <div class="empty"><p>Chưa có chiến dịch giảm giá nào.</p><a class="btn primary" href="<?= e(app_url('/admin/campaigns/new')) ?>">Tạo chiến dịch đầu tiên</a></div>
<?php endif; ?>
