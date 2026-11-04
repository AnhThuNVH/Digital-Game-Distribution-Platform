<?php
/** Header and section tabs of a developer project. @var array $game @var string $tab */
$gid = (int)$game['ma'];
$base = '/dev/games/' . $gid;
$sections = [
    'details' => ['', 'Chi tiết'],
    'media' => ['/media', 'Ảnh & video'],
    'authors' => ['/authors', 'Tác giả'],
    'releases' => ['/releases', 'Phiên bản'],
    'devlogs' => ['/devlogs', 'Nhật ký'],
    'page' => ['/page', 'Giao diện trang'],
    'keys' => ['/keys', 'Mã truy cập'],
    'stats' => ['/stats', 'Thống kê'],
];
$isPublic = in_array($game['trang_thai'], ['published', 'unlisted'], true);
?>
<nav class="crumbs" aria-label="Đường dẫn"><a href="<?= e(app_url('/dev/games')) ?>">Dự án</a><span><?= e($sections[$tab][1] ?? '') ?></span></nav>
<div class="title-row">
    <div>
        <h1><?= e($game['tieu_de']) ?></h1>
        <p class="sub"><?= status_pill('game_status', $game['trang_thai']) ?> <?= e(label('project_type', $game['loai_du_an'])) ?> · <?= e(label('pricing', $game['mo_hinh_gia'])) ?><?= (float)$game['gia_toi_thieu'] > 0 ? ' ' . e(money($game['gia_toi_thieu'])) : '' ?></p>
    </div>
    <?php if ($isPublic): ?>
        <a class="btn" href="<?= e(game_url($game)) ?>">Xem trang công khai</a>
    <?php endif; ?>
</div>
<nav class="tabs" aria-label="Quản lý dự án">
    <?php foreach ($sections as $key => [$path, $text]): ?>
        <a href="<?= e(app_url($base . $path)) ?>"<?= $tab === $key ? ' aria-selected="true"' : '' ?>><?= e($text) ?></a>
    <?php endforeach; ?>
</nav>
