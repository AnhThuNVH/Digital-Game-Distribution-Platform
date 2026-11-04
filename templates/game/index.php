<?php
/** Catalogue with filters. */
$priceOptions = ['' => 'Mọi mức giá', 'free' => 'Miễn phí', 'paid' => 'Trả phí', 'under5' => 'Dưới $5', 'under15' => 'Dưới $15'];
$hasFilters = $filters['q'] !== '' || $filters['category'] !== '' || $filters['tag'] !== '' || $filters['platform'] !== '' || $filters['price'] !== '' || $filters['status'] !== '' || $filters['type'] !== '' || $filters['sale'];
?>
<div class="title-row">
    <div>
        <h1><?= e($heading) ?></h1>
        <p class="sub"><?= fmt_int($total) ?> kết quả<?= $filters['q'] !== '' ? ' cho “' . e($filters['q']) . '”' : '' ?></p>
    </div>
</div>

<form class="toolbar" method="get" action="<?= e(app_url('/games')) ?>">
    <div class="search">
        <label class="sr-only" for="catalogue-q">Tìm theo tên hoặc thẻ</label>
        <input class="input" id="catalogue-q" type="search" name="q" value="<?= e($filters['q']) ?>" placeholder="Tên trò chơi, thẻ…" maxlength="100">
    </div>
    <label class="sr-only" for="f-category">Thể loại</label>
    <select class="input" id="f-category" name="category" data-autosubmit>
        <option value="">Mọi thể loại</option>
        <?php foreach ($categories as $c): ?><option value="<?= e($c['duong_dan_rut_gon']) ?>"<?= $filters['category'] === $c['duong_dan_rut_gon'] ? ' selected' : '' ?>><?= e($c['ten']) ?></option><?php endforeach; ?>
    </select>
    <label class="sr-only" for="f-platform">Nền tảng</label>
    <select class="input" id="f-platform" name="platform" data-autosubmit>
        <option value="">Mọi nền tảng</option>
        <?php foreach ($platforms as $p): ?><option value="<?= e($p['ma_nen_tang']) ?>"<?= $filters['platform'] === $p['ma_nen_tang'] ? ' selected' : '' ?>><?= e($p['ten_nen_tang']) ?></option><?php endforeach; ?>
    </select>
    <label class="sr-only" for="f-price">Giá</label>
    <select class="input" id="f-price" name="price" data-autosubmit>
        <?php foreach ($priceOptions as $value => $text): ?><option value="<?= e($value) ?>"<?= $filters['price'] === $value ? ' selected' : '' ?>><?= e($text) ?></option><?php endforeach; ?>
    </select>
    <label class="sr-only" for="f-status">Giai đoạn</label>
    <select class="input" id="f-status" name="status" data-autosubmit>
        <option value="">Mọi giai đoạn</option>
        <?php foreach (GameModel::RELEASE_STATUSES as $s): ?><option value="<?= e($s) ?>"<?= $filters['status'] === $s ? ' selected' : '' ?>><?= e(label('release_status', $s)) ?></option><?php endforeach; ?>
    </select>
    <span class="spacer"></span>
    <label class="sr-only" for="f-sort">Sắp xếp</label>
    <select class="input" id="f-sort" name="sort" data-autosubmit>
        <?php foreach (GameModel::SORTS as $value => $text): ?><option value="<?= e($value) ?>"<?= $filters['sort'] === $value ? ' selected' : '' ?>><?= e($text) ?></option><?php endforeach; ?>
    </select>
    <?php if ($filters['sale']): ?><input type="hidden" name="sale" value="1"><?php endif; ?>
    <?php if ($filters['tag'] !== ''): ?><input type="hidden" name="tag" value="<?= e($filters['tag']) ?>"><?php endif; ?>
    <?php if ($filters['type'] !== ''): ?><input type="hidden" name="type" value="<?= e($filters['type']) ?>"><?php endif; ?>
    <button class="btn" type="submit">Lọc</button>
</form>

<div class="chips chips-row" aria-label="Lọc nhanh">
    <a class="chip" href="<?= e(app_url('/games' . qs(['sale' => $filters['sale'] ? null : 1, 'page' => null]))) ?>" aria-pressed="<?= $filters['sale'] ? 'true' : 'false' ?>">Đang giảm giá</a>
    <a class="chip" href="<?= e(app_url('/games' . qs(['price' => $filters['price'] === 'free' ? null : 'free', 'page' => null]))) ?>" aria-pressed="<?= $filters['price'] === 'free' ? 'true' : 'false' ?>">Miễn phí</a>
    <a class="chip" href="<?= e(app_url('/games' . qs(['status' => $filters['status'] === 'early_access' ? null : 'early_access', 'page' => null]))) ?>" aria-pressed="<?= $filters['status'] === 'early_access' ? 'true' : 'false' ?>">Truy cập sớm</a>
    <a class="chip" href="<?= e(app_url('/games' . qs(['platform' => $filters['platform'] === 'browser' ? null : 'browser', 'page' => null]))) ?>" aria-pressed="<?= $filters['platform'] === 'browser' ? 'true' : 'false' ?>">Chơi trên trình duyệt</a>
    <?php if ($hasFilters): ?><a class="chip" href="<?= e(app_url('/games')) ?>">Xóa bộ lọc</a><?php endif; ?>
</div>

<?php if ($games): ?>
    <div class="games-grid">
        <?php foreach ($games as $game) partial('game-card', ['game' => $game, 'owned' => in_array((int)$game['ma'], $owned, true)]); ?>
    </div>
    <?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
<?php else: ?>
    <div class="empty">
        <p>Không có trò chơi nào khớp với bộ lọc hiện tại.</p>
        <a class="btn" href="<?= e(app_url('/games')) ?>">Xóa bộ lọc</a>
    </div>
<?php endif; ?>
