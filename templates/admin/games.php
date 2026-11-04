<?php
/** Staff game list. @var array $filters @var array $games @var array $counts @var array $staffStatuses @var int $total @var int $page @var int $pages */
$all = array_sum(array_map('intval', $counts));
?>
<div class="title-row">
    <div><h1>Trò chơi</h1><p class="sub">Duyệt trò chơi gửi công bố, ẩn hoặc đình chỉ trang vi phạm. Mỗi thay đổi được ghi vào nhật ký và báo cho nhà phát triển.</p></div>
</div>

<nav class="chips chips-row" aria-label="Lọc theo trạng thái">
    <a class="chip"<?= $filters['status'] === '' ? ' aria-current="true"' : '' ?> href="<?= e(app_url('/admin/games' . qs(['status' => null, 'page' => null]))) ?>">Tất cả <span class="muted"><?= fmt_int($all) ?></span></a>
    <?php foreach (labels('game_status') as $k => $t): ?>
        <a class="chip"<?= $filters['status'] === $k ? ' aria-current="true"' : '' ?> href="<?= e(app_url('/admin/games' . qs(['status' => $k, 'page' => null]))) ?>"><?= e($t) ?> <span class="muted"><?= fmt_int((int)($counts[$k] ?? 0)) ?></span></a>
    <?php endforeach; ?>
</nav>

<form class="toolbar" method="get" action="<?= e(app_url('/admin/games')) ?>">
    <?php if ($filters['status'] !== ''): ?><input type="hidden" name="status" value="<?= e($filters['status']) ?>"><?php endif; ?>
    <div class="search">
        <label class="sr-only" for="g-q">Tìm theo tên, đường dẫn, người tạo hoặc mã</label>
        <input class="input" id="g-q" type="search" name="q" value="<?= e($filters['q']) ?>" placeholder="Tên, đường dẫn, người tạo hoặc mã số…" maxlength="100">
    </div>
    <span class="spacer"></span>
    <span class="count"><?= fmt_int($total) ?> trò chơi</span>
</form>

<?php if ($games): ?>
<section class="panel flush">
    <table>
        <thead><tr><th scope="col">Trò chơi</th><th scope="col">Trạng thái</th><th scope="col">Giá</th><th scope="col" class="num">Báo cáo mở</th><th scope="col">Cập nhật</th><th scope="col" aria-label="Thao tác"></th></tr></thead>
        <tbody>
        <?php foreach ($games as $g): $gid = (int)$g['ma']; $isDraft = $g['trang_thai'] === 'draft'; ?>
            <tr>
                <td><?php if (in_array($g['trang_thai'], ['published', 'unlisted'], true)): ?><a class="link" href="<?= e(game_url($g)) ?>"><?= e($g['tieu_de']) ?></a><?php else: ?><?= e($g['tieu_de']) ?><?php endif; ?><span class="sub">#<?= $gid ?> · <?= e($g['ten_hien_thi']) ?> (@<?= e($g['ten_dang_nhap']) ?>)</span></td>
                <td><?= status_pill('game_status', $g['trang_thai']) ?></td>
                <td><?= e(label('pricing', $g['mo_hinh_gia'])) ?><?= (float)$g['gia_toi_thieu'] > 0 ? '<span class="sub">từ ' . e(money($g['gia_toi_thieu'])) . '</span>' : '' ?></td>
                <td class="num"><?php if ((int)$g['bao_cao_mo'] > 0): ?><a class="link" href="<?= e(app_url('/admin/reports?target=game')) ?>"><?= fmt_int((int)$g['bao_cao_mo']) ?></a><?php else: ?>0<?php endif; ?></td>
                <td><?= e(fmt_date($g['ngay_cap_nhat'])) ?></td>
                <td class="actions">
                    <?php if ($isDraft): ?>
                        <span class="muted small">Nhà phát triển đang soạn</span>
                    <?php else: ?>
                        <details class="edit">
                            <summary class="link-btn">Đổi trạng thái</summary>
                            <form class="form well" method="post" action="<?= e(app_url('/admin/games/' . $gid . '/status')) ?>">
                                <?= csrf_field() ?><?= return_field() ?>
                                <div class="field"><label for="gs-<?= $gid ?>">Trạng thái mới</label>
                                    <select class="input sm" id="gs-<?= $gid ?>" name="trang_thai">
                                        <?php foreach ($staffStatuses as $s): if ($s === $g['trang_thai']) continue; ?><option value="<?= e($s) ?>"><?= e(label('game_status', $s)) ?></option><?php endforeach; ?>
                                    </select>
                                </div>
                                <div class="field"><label for="gr-<?= $gid ?>">Lý do</label><input class="input sm" id="gr-<?= $gid ?>" name="ly_do" maxlength="1000"><span class="hint">Bắt buộc khi ẩn hoặc đình chỉ. Gửi kèm thông báo cho nhà phát triển.</span></div>
                                <button class="btn sm primary" type="submit">Áp dụng</button>
                            </form>
                        </details>
                    <?php endif; ?>
                </td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</section>
<?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
<?php else: ?>
    <div class="empty"><p>Không có trò chơi nào khớp bộ lọc.</p><a class="btn" href="<?= e(app_url('/admin/games')) ?>">Xóa bộ lọc</a></div>
<?php endif; ?>
