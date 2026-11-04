<?php
/** Admin user list. @var array $filters @var array $users @var int $total @var int $page @var int $pages */
?>
<div class="title-row">
    <div><h1>Người dùng</h1><p class="sub">Tìm tài khoản, đổi vai trò, đình chỉ hoặc cấp quyền sở hữu trò chơi.</p></div>
</div>

<form class="toolbar" method="get" action="<?= e(app_url('/admin/users')) ?>">
    <div class="search">
        <label class="sr-only" for="u-q">Tìm theo tên đăng nhập, email hoặc tên hiển thị</label>
        <input class="input" id="u-q" type="search" name="q" value="<?= e($filters['q']) ?>" placeholder="Tên đăng nhập, email, tên hiển thị…" maxlength="100">
    </div>
    <label class="sr-only" for="u-status">Trạng thái</label>
    <select class="input" id="u-status" name="status" data-autosubmit>
        <option value="">Mọi trạng thái</option>
        <?php foreach (labels('user_status') as $k => $t): ?><option value="<?= e($k) ?>"<?= $filters['status'] === $k ? ' selected' : '' ?>><?= e($t) ?></option><?php endforeach; ?>
    </select>
    <label class="sr-only" for="u-role">Vai trò</label>
    <select class="input" id="u-role" name="role" data-autosubmit>
        <option value="">Mọi vai trò</option>
        <?php foreach (labels('role') as $k => $t): ?><option value="<?= e($k) ?>"<?= $filters['role'] === $k ? ' selected' : '' ?>><?= e($t) ?></option><?php endforeach; ?>
    </select>
    <span class="spacer"></span>
    <span class="count"><?= fmt_int($total) ?> tài khoản</span>
</form>

<?php if ($users): ?>
<section class="panel flush">
    <table>
        <thead><tr><th scope="col">Tài khoản</th><th scope="col">Vai trò</th><th scope="col">Trạng thái</th><th scope="col" class="num">Trò chơi sở hữu</th><th scope="col">Ngày tạo</th></tr></thead>
        <tbody>
        <?php foreach ($users as $u): $roles = array_filter(explode(',', (string)$u['vai_tro'])); ?>
            <tr>
                <td><a class="link" href="<?= e(app_url('/admin/users/' . (int)$u['ma'])) ?>"><?= e($u['ten_hien_thi']) ?></a><span class="sub">@<?= e($u['ten_dang_nhap']) ?> · <?= e($u['email']) ?></span></td>
                <td><?= $roles ? e(implode(', ', array_map(static fn($r) => label('role', $r), $roles))) : '—' ?></td>
                <td><?= status_pill('user_status', $u['trang_thai']) ?></td>
                <td class="num"><?= fmt_int((int)$u['so_game']) ?></td>
                <td><?= e(fmt_date($u['ngay_tao'])) ?></td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</section>
<?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
<?php else: ?>
    <div class="empty"><p>Không có tài khoản nào khớp bộ lọc.</p><a class="btn" href="<?= e(app_url('/admin/users')) ?>">Xóa bộ lọc</a></div>
<?php endif; ?>
