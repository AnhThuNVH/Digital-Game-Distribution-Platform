<?php
/** One bundle. @var array $bundle @var array $games @var array $owned @var float $listTotal
 *  @var bool $onSale @var bool $inCart @var bool $canManage */
$price = (float)$bundle['gia'];
$ownedCount = count($owned);
$newCount = count($games) - $ownedCount;
$saving = $listTotal > $price ? $listTotal - $price : 0.0;
$editUrl = has_role('admin') && (int)$bundle['nguoi_tao_id'] !== current_user_id() ? '/admin/bundles/' : '/dev/bundles/';
?>
<nav class="crumbs" aria-label="Đường dẫn"><a href="<?= e(app_url('/bundles')) ?>">Gói game</a><span><?= e($bundle['tieu_de']) ?></span></nav>

<header class="object-head">
    <div class="grow">
        <h1><?= e($bundle['tieu_de']) ?></h1>
        <p class="meta"><?= e(label('bundle_type', $bundle['loai_goi_game'])) ?> · tạo bởi <a class="link" href="<?= e(profile_url($bundle)) ?>"><?= e($bundle['nguoi_tao']) ?></a>
            <?php if ($bundle['trang_thai'] !== 'published'): ?> · <?= status_pill('bundle_status', $bundle['trang_thai']) ?><?php endif; ?></p>
        <div class="stat-line">
            <span><strong><?= fmt_int(count($games)) ?></strong> trò chơi</span>
            <?php if ($listTotal > 0): ?><span>Giá lẻ <strong><?= e(money($listTotal)) ?></strong></span><?php endif; ?>
            <?php if ($bundle['ngay_ket_thuc']): ?><span>Kết thúc <strong><?= e(fmt_datetime($bundle['ngay_ket_thuc'])) ?></strong></span><?php endif; ?>
        </div>
    </div>
    <?php if ($canManage): ?><div class="actions"><a class="btn" href="<?= e(app_url($editUrl . (int)$bundle['ma'])) ?>">Sửa gói</a></div><?php endif; ?>
</header>

<div class="grid section">
    <div class="span-8 stack">
        <?php if ($bundle['mo_ta']): ?>
            <section class="panel" aria-labelledby="about-h">
                <header><h2 id="about-h">Giới thiệu</h2></header>
                <div class="prose"><?= e_multiline($bundle['mo_ta']) ?></div>
            </section>
        <?php endif; ?>
        <section aria-labelledby="games-h">
            <div class="section-head"><h2 id="games-h">Trò chơi trong gói</h2></div>
            <?php if ($games): ?>
                <div class="games-grid">
                    <?php foreach ($games as $game) partial('game-card', ['game' => $game, 'owned' => in_array((int)$game['ma'], $owned, true)]); ?>
                </div>
            <?php else: ?>
                <div class="empty">Gói này chưa có trò chơi nào đang phát hành.</div>
            <?php endif; ?>
        </section>
    </div>

    <aside class="span-4">
        <section class="panel buy-box" aria-labelledby="buy-h">
            <header><h2 id="buy-h">Mua gói</h2></header>
            <dl class="summary">
                <?php if ($listTotal > 0): ?><dt>Tổng giá lẻ</dt><dd><?= e(money($listTotal)) ?></dd><?php endif; ?>
                <?php if ($saving > 0): ?><dt>Tiết kiệm</dt><dd><?= e(money($saving)) ?></dd><?php endif; ?>
                <dt class="total">Giá gói</dt><dd class="total"><?= e($price > 0 ? money($price) : 'Miễn phí') ?></dd>
            </dl>
            <?php if ($ownedCount): ?><p class="small faint">Bạn đã có <?= fmt_int($ownedCount) ?>/<?= fmt_int(count($games)) ?> trò chơi trong gói. Giá gói không đổi; bạn nhận thêm <?= fmt_int($newCount) ?> trò chơi mới.</p><?php endif; ?>
            <?php if (!$onSale): ?>
                <div class="notice neutral"><?= $bundle['trang_thai'] === 'ended' || ($bundle['ngay_ket_thuc'] && strtotime($bundle['ngay_ket_thuc']) <= time()) ? 'Gói này đã kết thúc.' : 'Gói này chưa mở bán.' ?></div>
            <?php elseif (!$games || $newCount === 0): ?>
                <div class="notice neutral"><?= $games ? 'Bạn đã sở hữu mọi trò chơi trong gói này.' : 'Gói chưa có trò chơi nào.' ?></div>
            <?php elseif ($inCart): ?>
                <a class="btn primary block" href="<?= e(app_url('/cart')) ?>">Đã trong giỏ, xem giỏ hàng</a>
            <?php elseif (current_user()): ?>
                <form method="post" action="<?= e(app_url('/cart/add')) ?>">
                    <?= csrf_field() ?><?= return_field() ?>
                    <input type="hidden" name="type" value="bundle"><input type="hidden" name="id" value="<?= (int)$bundle['ma'] ?>">
                    <button class="btn primary block" type="submit">Thêm gói vào giỏ</button>
                </form>
            <?php else: ?>
                <a class="btn primary block" href="<?= e(app_url('/auth/login?return_to=' . rawurlencode('/bundles/' . $bundle['duong_dan_rut_gon']))) ?>">Đăng nhập để mua</a>
            <?php endif; ?>
        </section>
    </aside>
</div>
