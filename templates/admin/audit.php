<?php
/** System log. @var array $filters @var array $actions @var array $rows @var int $total @var int $page @var int $pages */
?>
<div class="title-row">
    <div><h1>Nhật ký hệ thống</h1><p class="sub">Mọi thao tác quan trọng: đăng nhập, đơn hàng, thay đổi quyền, kiểm duyệt. Chỉ đọc.</p></div>
</div>

<form class="toolbar" method="get" action="<?= e(app_url('/admin/audit')) ?>">
    <div class="search">
        <label class="sr-only" for="a-user">Tên đăng nhập hoặc email</label>
        <input class="input" id="a-user" type="search" name="user" value="<?= e($filters['user']) ?>" placeholder="Tên đăng nhập hoặc email chính xác" maxlength="100">
    </div>
    <label class="sr-only" for="a-action">Hành động</label>
    <select class="input" id="a-action" name="action" data-autosubmit>
        <option value="">Mọi hành động</option>
        <?php foreach ($actions as $a): ?><option value="<?= e($a) ?>"<?= $filters['action'] === $a ? ' selected' : '' ?>><?= e($a) ?></option><?php endforeach; ?>
    </select>
    <span class="spacer"></span>
    <span class="count"><?= fmt_int($total) ?> bản ghi</span>
</form>

<?php if ($rows): ?>
<section class="panel flush">
    <table>
        <thead><tr><th scope="col">Thời điểm</th><th scope="col">Người thực hiện</th><th scope="col">Hành động</th><th scope="col">Đối tượng</th><th scope="col">Chi tiết</th><th scope="col">IP</th></tr></thead>
        <tbody>
        <?php foreach ($rows as $r): ?>
            <tr>
                <td><?= e(fmt_datetime($r['ngay_tao'])) ?></td>
                <td><?php if ($r['nguoi_dung_id']): ?><a class="link" href="<?= e(app_url('/admin/users/' . (int)$r['nguoi_dung_id'])) ?>"><?= e($r['ten_hien_thi'] ?? ('#' . (int)$r['nguoi_dung_id'])) ?></a><?php else: ?><span class="muted">Hệ thống</span><?php endif; ?></td>
                <td><code><?= e($r['ma_hanh_dong']) ?></code></td>
                <td><?= $r['loai_thuc_the'] ? e($r['loai_thuc_the']) . ($r['thuc_the_id'] ? ' #' . (int)$r['thuc_the_id'] : '') : '—' ?></td>
                <td><span class="truncate"><?= $r['du_lieu_bo_sung'] ? e(excerpt((string)$r['du_lieu_bo_sung'], 120)) : '—' ?></span></td>
                <td class="small muted"><?= e((string)$r['dia_chi_ip']) ?></td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</section>
<?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
<?php else: ?>
    <div class="empty"><p>Không có bản ghi nào khớp bộ lọc.</p><a class="btn" href="<?= e(app_url('/admin/audit')) ?>">Xóa bộ lọc</a></div>
<?php endif; ?>
