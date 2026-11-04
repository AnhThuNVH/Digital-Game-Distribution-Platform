<?php
/** @var array $game  a row from GameModel::cardColumns(); optional $owned (bool) */
$owned = !empty($owned);
$cover = app_media_url($game['anh_bia'] ?? '');
?>
<a class="game-card" href="<?= e(game_url($game)) ?>">
    <div class="cover">
        <?php if ($cover !== ''): ?>
            <img src="<?= e($cover) ?>" alt="<?= e($game['anh_bia_alt'] ?: $game['tieu_de']) ?>" loading="lazy" data-fallback="<?= e($game['tieu_de']) ?>">
        <?php else: ?>
            <div class="cover-fallback"><?= e($game['tieu_de']) ?></div>
        <?php endif; ?>
    </div>
    <h3><?= e($game['tieu_de']) ?></h3>
    <div class="meta-line">
        <span class="by"><?= e($game['nha_phat_trien'] ?: label('release_status', $game['trang_thai_phat_hanh'])) ?></span>
        <?= price_html($game, $owned) ?>
    </div>
    <?php if (!empty($game['mo_ta_ngan'])): ?><p class="blurb"><?= e($game['mo_ta_ngan']) ?></p><?php endif; ?>
</a>
