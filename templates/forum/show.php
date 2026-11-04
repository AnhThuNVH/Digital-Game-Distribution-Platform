<?php
/** One board with its topics. @var array $board @var array $topics @var string $q @var int $page @var int $pages @var int $total */
$id = (int)$board['ma'];
$self = '/forums/' . $id;
$user = current_user();
?>
<nav class="crumbs" aria-label="Đường dẫn"><a href="<?= e(app_url('/forums')) ?>">Diễn đàn</a><span><?= e($board['tieu_de']) ?></span></nav>

<header class="object-head">
    <div class="grow">
        <h1><?= e($board['tieu_de']) ?></h1>
        <p class="meta">
            <?php if ($board['loai_dien_dan'] === 'game'): ?>Diễn đàn của <a class="link" href="<?= e(app_url('/games/' . rawurlencode($board['game_slug']))) ?>"><?= e($board['game_title']) ?></a>
            <?php elseif ($board['loai_dien_dan'] === 'jam'): ?>Diễn đàn của cuộc thi <a class="link" href="<?= e(app_url('/jams/' . rawurlencode($board['jam_slug']))) ?>"><?= e($board['jam_title']) ?></a>
            <?php else: ?>Diễn đàn chung của nền tảng<?php endif; ?>
            <?php if (!(int)$board['cong_khai']): ?> · Riêng tư<?php endif; ?>
        </p>
        <div class="stat-line"><span><strong><?= fmt_int((int)$board['so_chu_de']) ?></strong> chủ đề</span><span><strong><?= fmt_int((int)$board['so_bai']) ?></strong> trả lời</span></div>
    </div>
    <div class="actions">
        <?php if ($user): ?>
            <a class="btn primary" href="<?= e(app_url($self . '/topics/new')) ?>">Chủ đề mới</a>
        <?php else: ?>
            <a class="btn" href="<?= e(app_url('/auth/login?return_to=' . rawurlencode($self . '/topics/new'))) ?>">Đăng nhập để đăng bài</a>
        <?php endif; ?>
    </div>
</header>

<?php if ($board['mo_ta']): ?><div class="prose section"><?= e_multiline($board['mo_ta']) ?></div><?php endif; ?>

<section class="section" aria-labelledby="topics-h">
    <div class="section-head">
        <h2 id="topics-h">Chủ đề</h2>
        <form class="search-inline" method="get" action="<?= e(app_url($self)) ?>" role="search">
            <label class="sr-only" for="tq">Tìm chủ đề</label>
            <input class="input sm" id="tq" type="search" name="q" value="<?= e($q) ?>" maxlength="100" placeholder="Tìm theo tiêu đề">
            <button class="btn sm" type="submit">Tìm</button>
        </form>
    </div>
    <?php if ($topics): ?>
        <div class="panel">
            <div class="rows">
                <?php foreach ($topics as $t): ?>
                    <div class="row topic-row">
                        <img class="avatar" src="<?= e(avatar_url(['ma' => $t['tac_gia_nguoi_dung_id'], 'url_anh_dai_dien' => $t['url_anh_dai_dien']])) ?>" alt="" loading="lazy">
                        <div class="grow">
                            <?php if ((int)$t['da_ghim']): ?><span class="pill">Đã ghim</span> <?php endif; ?>
                            <?php if ((int)$t['da_khoa']): ?><span class="pill">Đã khóa</span> <?php endif; ?>
                            <?php if ($t['trang_thai'] !== 'published'): ?><span class="pill warn"><?= e(label('content_status', $t['trang_thai'])) ?></span> <?php endif; ?>
                            <a class="link t" href="<?= e(app_url($self . '/topics/' . (int)$t['ma'])) ?>"><?= e($t['tieu_de']) ?></a>
                            <span class="sub"><?= e($t['ten_hien_thi']) ?> · <?= e(time_ago($t['ngay_tao'])) ?></span>
                        </div>
                        <div class="board-stats">
                            <span><strong><?= fmt_int((int)$t['so_tra_loi']) ?></strong> trả lời</span>
                            <span class="faint"><?= $t['tra_loi_cuoi'] ? 'Mới nhất ' . e(time_ago($t['tra_loi_cuoi'])) : 'Chưa có trả lời' ?></span>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
        <?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
    <?php elseif ($q !== ''): ?>
        <div class="empty"><p>Không có chủ đề nào khớp với "<?= e($q) ?>".</p><a class="btn" href="<?= e(app_url($self)) ?>">Xem tất cả chủ đề</a></div>
    <?php else: ?>
        <div class="empty"><p>Chưa có chủ đề nào. Hãy là người mở đầu cuộc thảo luận.</p></div>
    <?php endif; ?>
</section>
