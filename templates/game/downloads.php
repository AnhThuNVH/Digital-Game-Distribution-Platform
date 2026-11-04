<?php
/**
 * Download page of a game.
 * @var array $game @var bool $owned @var array $links @var array $releases
 */
$slug = $game['duong_dan_rut_gon'];
$base = '/games/' . rawurlencode($slug);
$playUrl = game_play_url($game);
?>
<nav class="crumbs" aria-label="Đường dẫn">
    <a href="<?= e(app_url('/')) ?>">Cửa hàng</a>
    <a href="<?= e(app_url('/games')) ?>">Khám phá</a>
    <span><?= e($game['tieu_de']) ?></span>
</nav>

<div class="title-row">
    <div>
        <h1>Tải <?= e($game['tieu_de']) ?></h1>
        <p class="sub">Chọn một liên kết để bắt đầu tải về.</p>
    </div>
    <div class="cluster">
        <?php if ($owned && $playUrl): ?>
            <a class="btn primary" href="<?= e($playUrl) ?>" target="_blank" rel="noopener noreferrer">Chơi trên trình duyệt</a>
        <?php endif; ?>
        <a class="btn" href="<?= e(app_url($base)) ?>">Về trang trò chơi</a>
    </div>
</div>

<?php if (!$owned): ?>
    <section class="panel">
        <div class="empty">
            <p>Bạn cần sở hữu trò chơi này để xem các liên kết tải về.</p>
            <?php if (!current_user()): ?>
                <a class="btn primary" href="<?= e(app_url('/auth/login?return_to=' . rawurlencode($base . '/downloads'))) ?>">Đăng nhập</a>
            <?php else: ?>
                <a class="btn primary" href="<?= e(app_url($base)) ?>">Mua hoặc nhận trò chơi</a>
            <?php endif; ?>
        </div>
    </section>
<?php elseif (!$links): ?>
    <section class="panel">
        <div class="empty">
            <?php if ($playUrl): ?>
                <p>Trò chơi này chạy ngay trên trình duyệt, nhà phát triển không đăng link tải về nào.</p>
                <a class="btn primary" href="<?= e($playUrl) ?>" target="_blank" rel="noopener noreferrer">Chơi trên trình duyệt</a>
            <?php else: ?>
                <p>Nhà phát triển chưa đăng liên kết tải về nào cho trò chơi này.</p>
                <a class="btn" href="<?= e(app_url($base)) ?>">Về trang trò chơi</a>
            <?php endif; ?>
        </div>
    </section>
<?php else: ?>
    <section class="panel" aria-labelledby="dl-list-h">
        <header><h2 id="dl-list-h">Liên kết tải về</h2><span class="meta"><?= count($links) ?> liên kết</span></header>
        <div class="rows">
            <?php foreach ($links as $l): $lid = (int)$l['ma']; ?>
                <div class="row">
                    <div class="grow">
                        <strong><?= e($l['ten_hien_thi']) ?></strong>
                        <?= status_pill('download_provider', $l['nha_cung_cap']) ?>
                        <?= status_pill('download_platform', $l['he_dieu_ke']) ?>
                        <span class="sub">
                            <?= $l['ten_phien_ban'] ? 'Phiên bản ' . e($l['ten_phien_ban']) . ' (' . e(label('channel', $l['kenh_phat_hanh'])) . ')' : '' ?>
                            <?= $l['dung_luong'] ? ' · ' . e($l['dung_luong']) : '' ?>
                        </span>
                        <?php if ($l['ghi_chu']): ?><span class="sub"><?= e($l['ghi_chu']) ?></span><?php endif; ?>
                    </div>
                    <a class="btn sm primary" href="<?= e(app_url($base . '/download/' . $lid)) ?>">Tải về</a>
                </div>
            <?php endforeach; ?>
        </div>
        <p class="hint">Liên kết mở ở nơi lưu trữ của nhà phát triển. Trình duyệt có thể chặn cửa sổ mới — hãy cho phép pop-up cho trang này nếu chưa mở.</p>
    </section>
<?php endif; ?>

<?php if ($owned && $releases): ?>
    <section class="panel" style="margin-top: 18px" aria-labelledby="dl-rel-h">
        <header><h2 id="dl-rel-h">Phiên bản đã phát hành</h2></header>
        <div class="rows">
            <?php foreach ($releases as $r): ?>
                <div class="row">
                    <span class="grow"><?= e($r['ten_phien_ban']) ?></span>
                    <span class="pill"><?= e(label('channel', $r['kenh_phat_hanh'])) ?></span>
                    <span class="sub" style="flex:none"><?= e(fmt_date($r['ngay_phat_hanh'])) ?></span>
                </div>
            <?php endforeach; ?>
        </div>
    </section>
<?php endif; ?>
