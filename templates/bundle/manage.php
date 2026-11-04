<?php
/** Bundle list for developers (own bundles) and administrators (all). @var string $scope @var array $bundles @var int $gameCount */
$isAdmin = $scope === 'admin';
$base = $isAdmin ? '/admin/bundles' : '/dev/bundles';
?>
<div class="title-row">
    <div>
        <h1><?= $isAdmin ? 'Gói game' : 'Gói game của tôi' ?></h1>
        <p class="sub"><?= $isAdmin
            ? 'Mọi gói trên cửa hàng. Gói do quản trị viên tạo được ghi là gói do nền tảng tuyển chọn và có thể gồm trò chơi của bất kỳ ai.'
            : 'Gói gồm các trò chơi đã công bố mà bạn là tác giả. Doanh thu của gói được chia cho từng trò chơi theo giá lẻ.' ?></p>
    </div>
    <a class="btn primary" href="<?= e(app_url($base . '/new')) ?>">Tạo gói</a>
</div>

<?php if (!$isAdmin && $gameCount < 2): ?>
    <p class="hint">Cần ít nhất 2 trò chơi đã công bố mà bạn là tác giả để tạo gói. Hiện bạn có <?= fmt_int($gameCount) ?>.</p>
<?php endif; ?>

<?php if (!$bundles): ?>
    <div class="empty"><p>Chưa có gói game nào.</p><a class="btn primary" href="<?= e(app_url($base . '/new')) ?>">Tạo gói đầu tiên</a></div>
<?php else: ?>
<section class="panel">
    <div class="table-wrap">
        <table>
            <thead><tr>
                <th scope="col">Gói</th><th scope="col" class="num">Giá</th><th scope="col" class="num">Trò chơi</th><th scope="col" class="num">Đã bán</th>
                <th scope="col">Thời gian bán</th><th scope="col">Trạng thái</th><th scope="col"><span class="sr-only">Thao tác</span></th>
            </tr></thead>
            <tbody>
            <?php foreach ($bundles as $b): $id = (int)$b['ma']; ?>
                <tr>
                    <td class="lead"><a class="link" href="<?= e(app_url($base . '/' . $id)) ?>"><?= e($b['tieu_de']) ?></a>
                        <span class="sub"><?= e(label('bundle_type', $b['loai_goi_game'])) ?><?= $isAdmin ? ' · ' . e($b['nguoi_tao']) : '' ?></span></td>
                    <td class="num"><?= (float)$b['gia'] > 0 ? e(money((float)$b['gia'])) : 'Miễn phí' ?></td>
                    <td class="num"><?= fmt_int((int)$b['so_game']) ?></td>
                    <td class="num"><?= fmt_int((int)$b['so_luot_ban']) ?></td>
                    <td class="when"><?php if (!$b['ngay_bat_dau'] && !$b['ngay_ket_thuc']): ?><span class="muted">Không giới hạn</span><?php else: ?>
                        <?= $b['ngay_bat_dau'] ? 'Từ ' . e(fmt_datetime($b['ngay_bat_dau'])) : 'Từ khi công bố' ?><span class="sub"><?= $b['ngay_ket_thuc'] ? 'đến ' . e(fmt_datetime($b['ngay_ket_thuc'])) : 'không hết hạn' ?></span>
                    <?php endif; ?></td>
                    <td><?= status_pill('bundle_status', $b['trang_thai']) ?><?php if ($b['trang_thai'] === 'published' && !BundleModel::isOnSale($b)): ?><span class="sub">Ngoài thời gian bán</span><?php endif; ?></td>
                    <td class="actions"><a class="link" href="<?= e(app_url('/bundles/' . rawurlencode($b['duong_dan_rut_gon']))) ?>">Xem trang<span class="sr-only"> <?= e($b['tieu_de']) ?></span></a></td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    </div>
    <?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
</section>
<?php endif; ?>
