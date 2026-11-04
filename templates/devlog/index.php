<?php
/** Devlog list for one game. @var array $game @var array $posts @var int $page @var int $pages @var int $total */
$base = '/games/' . rawurlencode($game['duong_dan_rut_gon']);
?>
<nav class="crumbs" aria-label="Đường dẫn"><a href="<?= e(app_url($base)) ?>"><?= e($game['tieu_de']) ?></a><span>Nhật ký phát triển</span></nav>
<div class="title-row">
    <div>
        <h1>Nhật ký phát triển</h1>
        <p class="sub"><?= fmt_int($total) ?> bài về <?= e($game['tieu_de']) ?>. Theo dõi trò chơi để nhận thông báo khi có bài mới.</p>
    </div>
</div>

<?php if (!$posts): ?>
    <div class="empty"><p>Nhà phát triển chưa đăng nhật ký nào.</p><a class="btn" href="<?= e(app_url($base)) ?>">Về trang trò chơi</a></div>
<?php else: ?>
<section class="panel">
    <div class="rows">
        <?php foreach ($posts as $p): ?>
            <a class="row row-link devlog-row" href="<?= e(app_url($base . '/devlogs/' . rawurlencode($p['duong_dan_rut_gon']))) ?>">
                <span class="grow">
                    <strong><?= e($p['tieu_de']) ?></strong>
                    <span class="sub"><?= e(excerpt($p['noi_dung'], 220)) ?></span>
                </span>
                <span class="small faint"><?= e(fmt_date($p['ngay_cong_bo'])) ?><br><?= fmt_int((int)$p['so_binh_luan']) ?> bình luận</span>
            </a>
        <?php endforeach; ?>
    </div>
    <?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
</section>
<?php endif; ?>
