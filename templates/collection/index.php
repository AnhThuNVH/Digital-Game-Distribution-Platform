<?php
/** Collections hub. @var array $mine @var array $community @var int $page @var int $pages @var int $total */
$user = current_user();
$card = function (array $c, bool $showOwner) {
    $cover = app_media_url((string)($c['anh_bia'] ?? ''));
    ?>
    <a class="game-card" href="<?= e(app_url('/collections/' . (int)$c['ma'])) ?>">
        <div class="cover">
            <?php if ($cover !== ''): ?><img src="<?= e($cover) ?>" alt="" loading="lazy" data-fallback="<?= e($c['tieu_de']) ?>"><?php else: ?><div class="cover-fallback"><?= e($c['tieu_de']) ?></div><?php endif; ?>
        </div>
        <h3><?= e($c['tieu_de']) ?></h3>
        <div class="meta-line">
            <span class="by"><?= fmt_int((int)$c['so_game']) ?> trò chơi<?= $showOwner ? ' · ' . e($c['ten_hien_thi']) : '' ?></span>
            <?php if (!$showOwner && $c['pham_vi_hien_thi'] !== 'public'): ?><span class="small faint"><?= e(label('visibility', $c['pham_vi_hien_thi'])) ?></span><?php endif; ?>
        </div>
        <?php if ($c['mo_ta']): ?><p class="blurb"><?= e(excerpt($c['mo_ta'], 120)) ?></p><?php endif; ?>
    </a>
    <?php
};
?>
<div class="title-row">
    <div>
        <h1>Bộ sưu tập</h1>
        <p class="sub">Danh sách trò chơi do người chơi tự tuyển chọn. Tạo bộ sưu tập riêng, rồi thêm trò chơi từ trang của từng trò chơi.</p>
    </div>
</div>

<?php if ($user): ?>
<div class="grid section">
    <section class="span-8" aria-labelledby="mine-h">
        <div class="section-head"><h2 id="mine-h">Của bạn</h2><span class="meta"><?= fmt_int(count($mine)) ?> bộ sưu tập</span></div>
        <?php if ($mine): ?>
            <div class="games-grid">
                <?php foreach ($mine as $c) $card($c, false); ?>
            </div>
        <?php else: ?>
            <div class="empty"><p>Bạn chưa có bộ sưu tập nào. Tạo một bộ ở khung bên cạnh.</p></div>
        <?php endif; ?>
    </section>
    <aside class="span-4">
        <section class="panel" aria-labelledby="new-h" id="new">
            <header><h2 id="new-h">Tạo bộ sưu tập</h2></header>
            <form class="form" method="post" action="<?= e(app_url('/collections')) ?>">
                <?= csrf_field() ?>
                <div class="field">
                    <label for="c-title">Tên</label>
                    <input class="input" id="c-title" name="tieu_de" maxlength="180" required value="<?= e(old('tieu_de')) ?>" placeholder="Ví dụ: Chơi cùng bạn bè cuối tuần">
                </div>
                <div class="field">
                    <label for="c-desc">Mô tả (không bắt buộc)</label>
                    <textarea class="input" id="c-desc" name="mo_ta" maxlength="5000"><?= e(old('mo_ta')) ?></textarea>
                </div>
                <div class="field">
                    <label for="c-vis">Ai xem được</label>
                    <select class="input" id="c-vis" name="pham_vi_hien_thi">
                        <?php foreach (labels('visibility') as $v => $t): ?><option value="<?= e($v) ?>"<?= old('pham_vi_hien_thi', 'public') === $v ? ' selected' : '' ?>><?= e($t) ?></option><?php endforeach; ?>
                    </select>
                    <span class="hint">Không liệt kê: ai có đường dẫn mới xem được. Riêng tư: chỉ bạn.</span>
                </div>
                <input type="hidden" name="bo_cuc" value="grid">
                <div class="form-actions"><button class="btn primary" type="submit">Tạo bộ sưu tập</button></div>
            </form>
        </section>
    </aside>
</div>
<?php endif; ?>

<section class="section" aria-labelledby="community-h">
    <div class="section-head"><h2 id="community-h">Từ cộng đồng</h2><span class="meta"><?= fmt_int($total) ?> bộ sưu tập công khai</span></div>
    <?php if ($community): ?>
        <div class="games-grid">
            <?php foreach ($community as $c) $card($c, true); ?>
        </div>
        <?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
    <?php else: ?>
        <div class="empty"><p>Chưa có bộ sưu tập công khai nào có trò chơi.</p><?php if (!$user): ?><a class="btn" href="<?= e(app_url('/auth/login?return_to=' . rawurlencode('/collections'))) ?>">Đăng nhập để tạo bộ sưu tập</a><?php endif; ?></div>
    <?php endif; ?>
</section>
