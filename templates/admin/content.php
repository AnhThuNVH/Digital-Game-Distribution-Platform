<?php
/** User content moderation. @var array $filters @var array $types @var array $statusesFor @var array $items @var int $total @var int $page @var int $pages */
$filtered = $filters['type'] !== '' || $filters['status'] !== '' || $filters['q'] !== '';
?>
<div class="title-row">
    <div><h1>Nội dung người dùng</h1><p class="sub">Đánh giá, bình luận, nhật ký phát triển và thảo luận diễn đàn. Ẩn hoặc gỡ cần ghi lý do; tác giả được thông báo.</p></div>
</div>

<nav class="chips chips-row" aria-label="Lọc theo loại nội dung">
    <a class="chip"<?= $filters['type'] === '' ? ' aria-current="true"' : '' ?> href="<?= e(app_url('/admin/comments' . qs(['type' => null, 'id' => null, 'page' => null]))) ?>">Tất cả</a>
    <?php foreach ($types as $t): ?>
        <a class="chip"<?= $filters['type'] === $t ? ' aria-current="true"' : '' ?> href="<?= e(app_url('/admin/comments' . qs(['type' => $t, 'id' => null, 'page' => null]))) ?>"><?= e(label('report_target', $t)) ?></a>
    <?php endforeach; ?>
</nav>

<form class="toolbar" method="get" action="<?= e(app_url('/admin/comments')) ?>">
    <?php if ($filters['type'] !== ''): ?><input type="hidden" name="type" value="<?= e($filters['type']) ?>"><?php endif; ?>
    <div class="search">
        <label class="sr-only" for="c-q">Tìm trong nội dung</label>
        <input class="input" id="c-q" type="search" name="q" value="<?= e($filters['q']) ?>" placeholder="Tìm trong nội dung…" maxlength="100">
    </div>
    <label class="sr-only" for="c-status">Trạng thái</label>
    <select class="input" id="c-status" name="status" data-autosubmit>
        <option value="">Mọi trạng thái</option>
        <?php foreach (['published', 'hidden', 'removed'] as $k): ?><option value="<?= e($k) ?>"<?= $filters['status'] === $k ? ' selected' : '' ?>><?= e(label('content_status', $k)) ?></option><?php endforeach; ?>
    </select>
    <span class="spacer"></span>
    <span class="count"><?= fmt_int($total) ?> mục<?= $filters['id'] > 0 && $filters['type'] !== '' ? ' · mã #' . (int)$filters['id'] : '' ?></span>
</form>

<?php if ($items): ?>
<section class="panel">
    <div class="rows">
        <?php foreach ($items as $c): $kind = $c['kind']; $cid = (int)$c['ma']; $key = $kind . '-' . $cid; ?>
            <div class="row" id="item-<?= e($key) ?>">
                <div class="grow">
                    <div class="small muted"><?= e(label('report_target', $kind)) ?> #<?= $cid ?> · <?= e($c['ngu_canh']) ?></div>
                    <?php if ((string)$c['tieu_de'] !== ''): ?><strong><?= e($c['tieu_de']) ?></strong><?php endif; ?>
                    <p><?= e(excerpt((string)$c['noi_dung'], 260)) ?></p>
                    <span class="sub"><?= e($c['ten_hien_thi']) ?> @<?= e($c['ten_dang_nhap']) ?> · <?= e(fmt_datetime($c['ngay_tao'])) ?><?php if ($c['trang_thai'] === 'published'): ?> · <a class="link" href="<?= e(app_url($c['url'])) ?>">Xem tại trang gốc</a><?php endif; ?></span>
                </div>
                <div class="stack">
                    <?= status_pill('content_status', $c['trang_thai']) ?>
                    <details class="edit">
                        <summary class="link-btn">Đổi trạng thái</summary>
                        <form class="form well" method="post" action="<?= e(app_url('/admin/content/' . rawurlencode($kind) . '/' . $cid)) ?>">
                            <?= csrf_field() ?><?= return_field() ?>
                            <div class="field"><label for="cs-<?= e($key) ?>">Trạng thái mới</label>
                                <select class="input sm" id="cs-<?= e($key) ?>" name="trang_thai">
                                    <?php foreach ($statusesFor[$kind] as $s): if ($s === $c['trang_thai']) continue; ?><option value="<?= e($s) ?>"><?= e(label('content_status', $s)) ?></option><?php endforeach; ?>
                                </select>
                            </div>
                            <div class="field"><label for="cr-<?= e($key) ?>">Lý do</label><input class="input sm" id="cr-<?= e($key) ?>" name="ly_do" maxlength="1000"><span class="hint">Bắt buộc khi ẩn hoặc gỡ. Gửi kèm thông báo cho tác giả.</span></div>
                            <button class="btn sm primary" type="submit">Áp dụng</button>
                        </form>
                    </details>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
</section>
<?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
<?php else: ?>
    <div class="empty"><p><?= $filtered ? 'Không có nội dung nào khớp bộ lọc.' : 'Chưa có nội dung nào do người dùng đăng.' ?></p><?php if ($filtered): ?><a class="btn" href="<?= e(app_url('/admin/comments')) ?>">Xóa bộ lọc</a><?php endif; ?></div>
<?php endif; ?>
