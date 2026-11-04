<?php
/** Store home. */
$shelf = function (string $title, array $games, string $more, string $meta = '') use ($owned) {
    if (!$games) return;
    ?>
    <section class="section">
        <div class="section-head">
            <h2><?= e($title) ?></h2>
            <a class="meta link" href="<?= e(app_url($more)) ?>">Xem tất cả<?= $meta !== '' ? ' · ' . e($meta) : '' ?></a>
        </div>
        <div class="shelf">
            <?php foreach ($games as $game) partial('game-card', ['game' => $game, 'owned' => in_array((int)$game['ma'], $owned, true)]); ?>
        </div>
    </section>
    <?php
};
?>
<div class="title-row">
    <div>
        <h1>Cửa hàng</h1>
        <p class="sub"><?= fmt_int($totalGames) ?> trò chơi độc lập đang được công bố.</p>
    </div>
    <div class="actions">
        <a class="btn" href="<?= e(app_url('/games?sale=1')) ?>">Đang giảm giá</a>
        <a class="btn primary" href="<?= e(app_url('/games')) ?>">Khám phá tất cả</a>
    </div>
</div>

<?php if ($featured): $isOwned = in_array((int)$featured['ma'], $owned, true); $hero = $featuredShots[0]; ?>
    <section class="feature" aria-label="Nổi bật">
        <figure class="feature-art">
            <a href="<?= e(game_url($featured)) ?>"><img src="<?= e(app_media_url($hero['url_media'])) ?>" alt="<?= e($hero['van_ban_thay_the'] ?: $featured['tieu_de']) ?>" data-fallback="<?= e($featured['tieu_de']) ?>"></a>
            <?php if ($hero['chu_thich']): ?><figcaption><?= media_credit_html($hero['chu_thich']) ?></figcaption><?php endif; ?>
        </figure>
        <div class="feature-info">
            <h2><a href="<?= e(game_url($featured)) ?>"><?= e($featured['tieu_de']) ?></a></h2>
            <?php if ($featured['nha_phat_trien']): ?><p class="small muted"><?= e($featured['nha_phat_trien']) ?></p><?php endif; ?>
            <?php if ($featured['mo_ta_ngan']): ?><p><?= e($featured['mo_ta_ngan']) ?></p><?php endif; ?>
            <?php if (count($featuredShots) > 1): ?>
                <div class="feature-thumbs">
                    <?php foreach (array_slice($featuredShots, 1) as $shot): ?>
                        <img src="<?= e(app_media_url($shot['url_media'])) ?>" alt="<?= e($shot['van_ban_thay_the'] ?: 'Ảnh chụp ' . $featured['tieu_de']) ?>" loading="lazy" data-fallback="">
                    <?php endforeach; ?>
                </div>
            <?php endif; ?>
            <div class="cluster small muted">
                <span><?= e(label('release_status', $featured['trang_thai_phat_hanh'])) ?></span>
                <?php if ($featured['the_loai']): ?><span><?= e($featured['the_loai']) ?></span><?php endif; ?>
                <?php if ($featured['so_danh_gia']): ?><span><?= stars((float)$featured['diem_tb']) ?> <?= fmt_int($featured['so_danh_gia']) ?> đánh giá</span><?php endif; ?>
            </div>
            <div class="foot">
                <?= price_html($featured, $isOwned) ?>
                <a class="btn primary" href="<?= e(game_url($featured)) ?>"><?= $isOwned ? 'Mở trang trò chơi' : 'Xem chi tiết' ?></a>
            </div>
        </div>
    </section>
<?php endif; ?>

<?php $shelf('Mới công bố', $newest, '/games?sort=new'); ?>
<?php $shelf('Đang giảm giá', $onSale, '/games?sale=1'); ?>

<div class="grid top section">
    <section class="panel span-7">
        <header><h2>Được sở hữu nhiều nhất</h2><a class="meta link" href="<?= e(app_url('/games?sort=popular')) ?>">Bảng xếp hạng</a></header>
        <?php if ($popular): ?>
            <div class="rank-list">
                <?php foreach (array_slice($popular, 0, 6) as $i => $game): ?>
                    <a class="rank-row row-link" href="<?= e(game_url($game)) ?>">
                        <span class="n"><?= $i + 1 ?></span>
                        <?php if ($game['anh_bia']): ?>
                            <img src="<?= e(app_media_url($game['anh_bia'])) ?>" alt="" loading="lazy" data-fallback="">
                        <?php else: ?><span class="thumb"></span><?php endif; ?>
                        <span class="rank-text">
                            <span class="t"><?= e($game['tieu_de']) ?></span>
                            <span class="sub"><?= fmt_int($game['so_huu']) ?> người sở hữu<?= $game['the_loai'] ? ' · ' . e($game['the_loai']) : '' ?></span>
                        </span>
                        <?= price_html($game, in_array((int)$game['ma'], $owned, true)) ?>
                    </a>
                <?php endforeach; ?>
            </div>
        <?php else: ?>
            <div class="empty">Chưa có trò chơi nào được công bố.</div>
        <?php endif; ?>
    </section>
    <section class="panel span-5">
        <header><h2>Thể loại</h2></header>
        <div class="chips">
            <?php foreach ($categories as $cat): ?>
                <a class="chip" href="<?= e(app_url('/games?category=' . rawurlencode($cat['duong_dan_rut_gon']))) ?>"><?= e($cat['ten']) ?> <span class="faint"><?= fmt_int($cat['so_game']) ?></span></a>
            <?php endforeach; ?>
        </div>
        <?php if ($jams): ?>
            <h3 class="sub-head">Game jam</h3>
            <div class="rows">
                <?php foreach ($jams as $jam): ?>
                    <a class="row row-link" href="<?= e(app_url('/jams/' . rawurlencode($jam['duong_dan_rut_gon']))) ?>">
                        <span class="grow"><?= e($jam['tieu_de']) ?><span class="sub">Hạn nộp <?= e(fmt_datetime($jam['han_nop_bai'])) ?> · <?= fmt_int($jam['so_bai']) ?> bài dự thi</span></span>
                        <?= status_pill('jam_status', $jam['trang_thai']) ?>
                    </a>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </section>
</div>

<?php $shelf('Đánh giá cao', $topRated, '/games?sort=rating'); ?>
<?php $shelf('Miễn phí', $free, '/games?price=free'); ?>

<?php if ($bundles): ?>
    <section class="section">
        <div class="section-head"><h2>Gói game</h2><a class="meta link" href="<?= e(app_url('/bundles')) ?>">Xem tất cả</a></div>
        <div class="games-grid">
            <?php foreach ($bundles as $b): ?>
                <a class="game-card" href="<?= e(app_url('/bundles/' . rawurlencode($b['duong_dan_rut_gon']))) ?>">
                    <div class="cover">
                        <?php if ($b['anh_bia']): ?><img src="<?= e(app_media_url($b['anh_bia'])) ?>" alt="" loading="lazy" data-fallback="<?= e($b['tieu_de']) ?>"><?php else: ?><div class="cover-fallback"><?= e($b['tieu_de']) ?></div><?php endif; ?>
                    </div>
                    <h3><?= e($b['tieu_de']) ?></h3>
                    <div class="meta-line">
                        <span class="by"><?= fmt_int($b['so_game']) ?> trò chơi</span>
                        <span class="price"><?php if ((float)$b['tong_gia_le'] > (float)$b['gia']): ?><span class="was"><?= e(money($b['tong_gia_le'])) ?></span><?php endif; ?><span<?= (float)$b['gia'] <= 0 ? ' class="free"' : '' ?>><?= (float)$b['gia'] <= 0 ? 'Miễn phí' : e(money($b['gia'])) ?></span></span>
                    </div>
                </a>
            <?php endforeach; ?>
        </div>
    </section>
<?php endif; ?>
