<?php
/** Wishlist. @var array $games @var array $owned @var array $inCart @var int $libCount */
?>
<div class="title-row">
    <div>
        <h1>Danh sách mong muốn</h1>
        <p class="sub"><?= fmt_int($total) ?> trò chơi. Giá giảm theo chiến dịch được cập nhật tự động.</p>
    </div>
</div>

<nav class="tabs" aria-label="Thư viện">
    <a href="<?= e(app_url('/library')) ?>" aria-selected="false">Đã sở hữu<span class="count"><?= fmt_int($libCount) ?></span></a>
    <a href="<?= e(app_url('/wishlist')) ?>" aria-selected="true">Mong muốn</a>
</nav>

<?php if (!$games): ?>
    <div class="empty">
        <p>Bạn chưa thêm trò chơi nào. Bấm "Thêm vào mong muốn" trên trang trò chơi để theo dõi giá.</p>
        <a class="btn primary" href="<?= e(app_url('/games')) ?>">Khám phá trò chơi</a>
    </div>
<?php else: ?>
<section class="panel">
    <div class="rows">
        <?php foreach ($games as $g): $gid = (int)$g['ma']; $isOwned = in_array($gid, $owned, true); ?>
            <div class="row lib-row">
                <a class="thumb" href="<?= e(game_url($g)) ?>">
                    <?php if ($g['anh_bia']): ?><img src="<?= e(app_media_url($g['anh_bia'])) ?>" alt="<?= e($g['anh_bia_alt'] ?: $g['tieu_de']) ?>" loading="lazy" data-fallback="<?= e($g['tieu_de']) ?>"><?php else: ?><span class="cover-fallback"><?= e($g['tieu_de']) ?></span><?php endif; ?>
                </a>
                <div class="grow">
                    <a class="link" href="<?= e(game_url($g)) ?>"><?= e($g['tieu_de']) ?></a>
                    <span class="sub"><?= e($g['nha_phat_trien'] ?: label('release_status', $g['trang_thai_phat_hanh'])) ?> · thêm <?= e(time_ago($g['ngay_them'])) ?></span>
                </div>
                <?= price_html($g, $isOwned) ?>
                <div class="cluster">
                    <?php if ($isOwned): ?>
                        <a class="btn sm" href="<?= e(app_url('/library')) ?>">Trong thư viện</a>
                    <?php elseif (game_is_free($g)): ?>
                        <form method="post" action="<?= e(app_url('/games/' . rawurlencode($g['duong_dan_rut_gon']) . '/claim')) ?>"><?= csrf_field() ?><?= return_field('/wishlist') ?><button class="btn sm primary" type="submit">Nhận miễn phí</button></form>
                    <?php elseif (in_array($gid, $inCart, true)): ?>
                        <a class="btn sm" href="<?= e(app_url('/cart')) ?>">Đã trong giỏ</a>
                    <?php elseif ($g['mo_hinh_gia'] === 'pay_what_you_want'): ?>
                        <a class="btn sm primary" href="<?= e(game_url($g)) ?>">Chọn mức giá</a>
                    <?php else: ?>
                        <form method="post" action="<?= e(app_url('/cart/add')) ?>"><?= csrf_field() ?><?= return_field('/wishlist') ?><input type="hidden" name="type" value="game"><input type="hidden" name="id" value="<?= $gid ?>"><button class="btn sm primary" type="submit">Thêm vào giỏ</button></form>
                    <?php endif; ?>
                    <form method="post" action="<?= e(app_url('/games/' . rawurlencode($g['duong_dan_rut_gon']) . '/wishlist')) ?>"><?= csrf_field() ?><?= return_field('/wishlist') ?><button class="link-btn" type="submit">Bỏ</button></form>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
    <?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
</section>
<?php endif; ?>
