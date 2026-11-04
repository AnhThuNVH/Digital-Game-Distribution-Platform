<?php
/** Report queue. @var array $filters @var array $counts @var array $reports @var int $total @var int $page @var int $pages */
$openCount = (int)($counts['open'] ?? 0) + (int)($counts['investigating'] ?? 0);
?>
<div class="title-row">
    <div><h1>Báo cáo vi phạm</h1><p class="sub">Nhận xử lý, áp dụng biện pháp và đóng báo cáo. Người báo cáo được thông báo kết quả.</p></div>
    <a class="btn" href="<?= e(app_url('/admin/moderation')) ?>">Nhật ký kiểm duyệt</a>
</div>

<nav class="chips chips-row" aria-label="Lọc theo trạng thái">
    <a class="chip"<?= $filters['status'] === '' ? ' aria-current="true"' : '' ?> href="<?= e(app_url('/admin/reports' . qs(['status' => null, 'page' => null]))) ?>">Chưa xử lý <span class="muted"><?= fmt_int($openCount) ?></span></a>
    <?php foreach (labels('report_status') as $k => $t): ?>
        <a class="chip"<?= $filters['status'] === $k ? ' aria-current="true"' : '' ?> href="<?= e(app_url('/admin/reports' . qs(['status' => $k, 'page' => null]))) ?>"><?= e($t) ?> <span class="muted"><?= fmt_int((int)($counts[$k] ?? 0)) ?></span></a>
    <?php endforeach; ?>
</nav>

<form class="toolbar" method="get" action="<?= e(app_url('/admin/reports')) ?>">
    <?php if ($filters['status'] !== ''): ?><input type="hidden" name="status" value="<?= e($filters['status']) ?>"><?php endif; ?>
    <label class="sr-only" for="r-target">Loại nội dung</label>
    <select class="input" id="r-target" name="target" data-autosubmit>
        <option value="">Mọi loại nội dung</option>
        <?php foreach (labels('report_target') as $k => $t): ?><option value="<?= e($k) ?>"<?= $filters['target'] === $k ? ' selected' : '' ?>><?= e($t) ?></option><?php endforeach; ?>
    </select>
    <noscript><button class="btn sm" type="submit">Lọc</button></noscript>
    <span class="spacer"></span>
    <span class="count"><?= fmt_int($total) ?> báo cáo</span>
</form>

<?php if ($reports): ?>
<section class="panel flush">
    <table>
        <thead><tr><th scope="col">Nội dung</th><th scope="col">Lý do</th><th scope="col">Người báo cáo</th><th scope="col">Trạng thái</th><th scope="col">Ngày gửi</th></tr></thead>
        <tbody>
        <?php foreach ($reports as $r): $others = (int)$r['cung_noi_dung'] - 1; ?>
            <tr>
                <td><a class="link" href="<?= e(app_url('/admin/reports/' . (int)$r['ma'])) ?>"><?= e(label('report_target', $r['loai_doi_tuong'])) ?> #<?= (int)$r['doi_tuong_id'] ?></a><span class="sub">Báo cáo #<?= (int)$r['ma'] ?><?= $others > 0 ? ' · thêm ' . fmt_int($others) . ' báo cáo cùng nội dung' : '' ?></span></td>
                <td><?= e(label('report_reason', $r['ma_ly_do'])) ?><?php if ((string)$r['chi_tiet'] !== ''): ?><span class="sub"><?= e(excerpt((string)$r['chi_tiet'], 80)) ?></span><?php endif; ?></td>
                <td><?= e($r['nguoi_bao_cao'] ?? 'Tài khoản đã xóa') ?></td>
                <td><?= status_pill('report_status', $r['trang_thai']) ?><?php if ($r['nguoi_xu_ly']): ?><span class="sub"><?= e($r['nguoi_xu_ly']) ?></span><?php endif; ?></td>
                <td><?= e(fmt_datetime($r['ngay_tao'])) ?></td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</section>
<?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
<?php else: ?>
    <div class="empty"><p><?= $filters['status'] === '' && $filters['target'] === '' ? 'Không còn báo cáo nào cần xử lý.' : 'Không có báo cáo nào khớp bộ lọc.' ?></p><?php if ($filters['status'] !== '' || $filters['target'] !== ''): ?><a class="btn" href="<?= e(app_url('/admin/reports')) ?>">Xóa bộ lọc</a><?php endif; ?></div>
<?php endif; ?>
