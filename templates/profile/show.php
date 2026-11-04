<?php
/** Public profile. @var array $profile @var bool $isSelf @var bool $canSee @var bool $isFollowing
 *  @var int $followers @var int $following @var array $published @var array $owned @var int $ownedTotal
 *  @var bool $showLibrary @var array $reviews @var array $collections */
$site = (string)($profile['url_website'] ?? '');
$siteOk = $site !== '' && preg_match('#^https?://#i', $site) === 1;
$cover = app_media_url((string)($profile['url_anh_bia'] ?? ''));
?>
<?php if ($cover !== '' && $canSee): ?>
    <div class="profile-cover"><img src="<?= e($cover) ?>" alt=""></div>
<?php endif; ?>

<header class="object-head">
    <img class="avatar lg" src="<?= e(avatar_url($profile)) ?>" alt="">
    <div class="grow">
        <h1><?= e($profile['ten_hien_thi']) ?></h1>
        <p class="meta">@<?= e($profile['ten_dang_nhap']) ?><?= $profile['ma_quoc_gia'] && $canSee ? ' · ' . e($profile['ma_quoc_gia']) : '' ?> · tham gia <?= e(fmt_date($profile['ngay_tao'])) ?><?= $profile['trang_thai'] === 'suspended' ? ' · ' . status_pill('user_status', 'suspended') : '' ?></p>
        <div class="stat-line">
            <span><strong><?= fmt_int($followers) ?></strong> người theo dõi</span>
            <span><strong><?= fmt_int($following) ?></strong> đang theo dõi</span>
            <?php if ($canSee): ?><span><strong><?= fmt_int(count($published)) ?></strong> trò chơi đã phát hành</span><?php endif; ?>
        </div>
    </div>
    <div class="actions">
        <?php if ($isSelf): ?>
            <a class="btn" href="<?= e(app_url('/settings#profile')) ?>">Sửa hồ sơ</a>
        <?php elseif (current_user()): ?>
            <form method="post" action="<?= e(app_url('/u/' . rawurlencode($profile['ten_dang_nhap']) . '/follow')) ?>"><?= csrf_field() ?><?= return_field() ?>
                <button class="btn<?= $isFollowing ? '' : ' primary' ?>" type="submit" aria-pressed="<?= $isFollowing ? 'true' : 'false' ?>"><?= $isFollowing ? 'Đang theo dõi' : 'Theo dõi' ?></button>
            </form>
        <?php else: ?>
            <a class="btn primary" href="<?= e(app_url('/auth/login?return_to=' . rawurlencode('/u/' . $profile['ten_dang_nhap']))) ?>">Đăng nhập để theo dõi</a>
        <?php endif; ?>
    </div>
</header>

<?php if (!$canSee): ?>
    <div class="empty"><p>Hồ sơ này ở chế độ riêng tư.</p></div>
<?php else: ?>
<div class="grid section">
    <div class="span-8 stack">
        <?php if ($published): ?>
            <section aria-labelledby="pub-h">
                <div class="section-head"><h2 id="pub-h">Trò chơi đã phát hành</h2></div>
                <div class="games-grid">
                    <?php foreach ($published as $game) partial('game-card', ['game' => $game]); ?>
                </div>
            </section>
        <?php endif; ?>

        <?php if ($showLibrary): ?>
            <section aria-labelledby="lib-h">
                <div class="section-head">
                    <h2 id="lib-h">Thư viện<?= $ownedTotal ? ' <span class="faint">' . fmt_int($ownedTotal) . '</span>' : '' ?></h2>
                    <?php if ($isSelf): ?><a class="link" href="<?= e(app_url('/library')) ?>">Mở thư viện</a><?php endif; ?>
                </div>
                <?php if ($owned): ?>
                    <div class="games-grid">
                        <?php foreach ($owned as $game) partial('game-card', ['game' => $game, 'owned' => $isSelf]); ?>
                    </div>
                <?php else: ?>
                    <p class="muted">Chưa có trò chơi nào.</p>
                <?php endif; ?>
                <?php if ($isSelf): ?><p class="small faint">Người khác <?= $libraryPublic ? 'thấy' : 'không thấy' ?> mục này. Đổi trong <a class="link" href="<?= e(app_url('/settings#privacy')) ?>">Cài đặt</a>.</p><?php endif; ?>
            </section>
        <?php endif; ?>

        <?php if ($reviews): ?>
            <section class="panel" aria-labelledby="rev-h">
                <header><h2 id="rev-h">Đánh giá gần đây</h2></header>
                <?php foreach ($reviews as $r): ?>
                    <article class="review">
                        <header>
                            <div class="who">
                                <a class="link" href="<?= e(app_url('/games/' . rawurlencode($r['duong_dan_rut_gon']))) ?>#reviews"><?= e($r['game_title']) ?></a>
                                <span><?= e(fmt_date($r['ngay_tao'])) ?><?= (int)$r['da_xac_minh_so_huu'] ? ' · Đã sở hữu' : '' ?></span>
                            </div>
                            <?= stars((float)$r['diem_danh_gia']) ?>
                        </header>
                        <?php if ($r['tieu_de']): ?><h4><?= e($r['tieu_de']) ?></h4><?php endif; ?>
                        <?php if ($r['noi_dung_danh_gia']): ?><p><?= e(excerpt($r['noi_dung_danh_gia'], 320)) ?></p><?php endif; ?>
                    </article>
                <?php endforeach; ?>
            </section>
        <?php endif; ?>

        <?php if (!$published && !$showLibrary && !$reviews): ?>
            <div class="empty"><p>Chưa có hoạt động công khai.</p></div>
        <?php endif; ?>
    </div>

    <aside class="span-4 stack">
        <section class="panel" aria-labelledby="about-h">
            <header><h2 id="about-h">Giới thiệu</h2></header>
            <?php if ($profile['gioi_thieu']): ?><p class="prose"><?= e_multiline($profile['gioi_thieu']) ?></p><?php else: ?><p class="muted">Chưa có giới thiệu.</p><?php endif; ?>
            <?php if ($siteOk): ?><p class="small"><a class="link" href="<?= e($site) ?>" rel="nofollow noopener noreferrer ugc" target="_blank"><?= e(preg_replace('#^https?://#i', '', $site)) ?></a></p><?php endif; ?>
        </section>
        <?php if ($collections): ?>
            <section class="panel" aria-labelledby="col-h">
                <header><h2 id="col-h">Bộ sưu tập</h2></header>
                <div class="rows">
                    <?php foreach ($collections as $c): ?>
                        <a class="row" href="<?= e(app_url('/collections/' . (int)$c['ma'])) ?>">
                            <span class="grow"><strong><?= e($c['tieu_de']) ?></strong><?php if ($c['mo_ta']): ?><span class="sub"><?= e(excerpt($c['mo_ta'], 90)) ?></span><?php endif; ?></span>
                            <span class="small faint"><?= fmt_int((int)$c['so_muc']) ?> trò chơi</span>
                        </a>
                    <?php endforeach; ?>
                </div>
            </section>
        <?php endif; ?>
        <?php if (!$isSelf) partial('report', ['type' => 'user', 'id' => (int)$profile['ma'], 'labelText' => 'Báo cáo người dùng này']); ?>
    </aside>
</div>
<?php endif; ?>
