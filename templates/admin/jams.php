<?php
/** Jam admin list. @var array $jams */
?>
<div class="title-row">
    <div><h1>Game jam</h1><p class="sub">Tạo cuộc thi, đặt lịch nộp bài và bình chọn, quản lý ban tổ chức và bài dự thi.</p></div>
    <a class="btn primary" href="<?= e(app_url('/admin/jams/new')) ?>">Tạo cuộc thi</a>
</div>

<?php if ($jams): ?>
<section class="panel">
    <div class="table-wrap"><table>
        <thead><tr><th scope="col">Cuộc thi</th><th scope="col">Trạng thái</th><th scope="col">Giai đoạn hiện tại</th><th scope="col">Hạn nộp</th><th scope="col" class="num">Bài</th><th scope="col" class="num">Người chấm</th></tr></thead>
        <tbody>
        <?php foreach ($jams as $j): $phase = JamModel::phase($j); ?>
            <tr>
                <td class="lead"><a class="link" href="<?= e(app_url('/admin/jams/' . (int)$j['ma'])) ?>"><?= e($j['tieu_de']) ?></a><span class="sub">/jams/<?= e($j['duong_dan_rut_gon']) ?> · <?= e($j['ten_hien_thi']) ?></span></td>
                <td><?= e(label('jam_status', $j['trang_thai'])) ?></td>
                <td><span class="pill<?= in_array($phase, ['submissions', 'voting'], true) ? ' pos' : ($phase === 'cancelled' ? ' neg' : '') ?>"><?= e(JamModel::PHASES[$phase]) ?></span></td>
                <td><?= e(fmt_datetime($j['han_nop_bai'])) ?></td>
                <td class="num"><?= fmt_int((int)$j['so_bai']) ?></td>
                <td class="num"><?= fmt_int((int)$j['so_nguoi_cham']) ?></td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table></div>
    <?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
</section>
<?php else: ?>
    <div class="empty"><p>Chưa có cuộc thi nào.</p><a class="btn primary" href="<?= e(app_url('/admin/jams/new')) ?>">Tạo cuộc thi đầu tiên</a></div>
<?php endif; ?>
