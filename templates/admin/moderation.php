<?php
/** Moderation action log. @var array $filters @var array $rows @var int $total @var int $page @var int $pages */
?>
<div class="title-row">
    <div><h1>Nhật ký kiểm duyệt</h1><p class="sub">Mọi thao tác ẩn, gỡ, đình chỉ, cảnh cáo và khôi phục của đội ngũ điều hành.</p></div>
</div>

<form class="toolbar" method="get" action="<?= e(app_url('/admin/moderation')) ?>">
    <label class="sr-only" for="m-target">Loại đối tượng</label>
    <select class="input" id="m-target" name="target" data-autosubmit>
        <option value="">Mọi đối tượng</option>
        <?php foreach (labels('report_target') as $k => $t): ?><option value="<?= e($k) ?>"<?= $filters['target'] === $k ? ' selected' : '' ?>><?= e($t) ?></option><?php endforeach; ?>
    </select>
    <label class="sr-only" for="m-action">Thao tác</label>
    <select class="input" id="m-action" name="action" data-autosubmit>
        <option value="">Mọi thao tác</option>
        <?php foreach (labels('mod_action') as $k => $t): ?><option value="<?= e($k) ?>"<?= $filters['action'] === $k ? ' selected' : '' ?>><?= e($t) ?></option><?php endforeach; ?>
    </select>
    <span class="spacer"></span>
    <span class="count"><?= fmt_int($total) ?> thao tác</span>
</form>

<?php if ($rows): ?>
<section class="panel flush">
    <table>
        <thead><tr><th scope="col">Thời gian</th><th scope="col">Điều hành viên</th><th scope="col">Thao tác</th><th scope="col">Đối tượng</th><th scope="col">Lý do</th></tr></thead>
        <tbody>
        <?php foreach ($rows as $h): ?>
            <tr>
                <td><?= e(fmt_datetime($h['ngay_tao'])) ?></td>
                <td><?= e($h['ten_hien_thi']) ?></td>
                <td><?= e(label('mod_action', $h['loai_hanh_dong'])) ?></td>
                <td><a class="link" href="<?= e(app_url(mod_target_url($h['loai_doi_tuong'], (int)$h['doi_tuong_id']))) ?>"><?= e(label('report_target', $h['loai_doi_tuong'])) ?> #<?= (int)$h['doi_tuong_id'] ?></a></td>
                <td><?= (string)$h['ly_do'] !== '' ? e(excerpt((string)$h['ly_do'], 140)) : '<span class="muted">—</span>' ?></td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</section>
<?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
<?php else: ?>
    <div class="empty"><p>Không có thao tác nào khớp bộ lọc.</p><?php if ($filters['target'] !== '' || $filters['action'] !== ''): ?><a class="btn" href="<?= e(app_url('/admin/moderation')) ?>">Xóa bộ lọc</a><?php endif; ?></div>
<?php endif; ?>
