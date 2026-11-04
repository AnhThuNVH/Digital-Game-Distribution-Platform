<?php
/** Owned games. @var array $games @var string $q @var string $sort @var int $wishCount */
$playable = static fn(?string $url): bool => $url !== null && preg_match('#^https?://#i', $url) === 1;
?>
<div class="title-row">
    <div>
        <h1>Thư viện</h1>
        <p class="sub"><?= fmt_int($total) ?> trò chơi<?= $q !== '' ? ' khớp "' . e($q) . '"' : '' ?></p>
    </div>
</div>

<nav class="tabs" aria-label="Thư viện">
    <a href="<?= e(app_url('/library')) ?>" aria-selected="true">Đã sở hữu</a>
    <a href="<?= e(app_url('/wishlist')) ?>" aria-selected="false">Mong muốn<span class="count"><?= fmt_int($wishCount) ?></span></a>
</nav>

<div class="grid">
    <section class="panel span-8" aria-label="Trò chơi đã sở hữu">
        <form class="toolbar" method="get" action="<?= e(app_url('/library')) ?>" role="search">
            <label class="sr-only" for="lib-q">Tìm trong thư viện</label>
            <input class="input search" id="lib-q" type="search" name="q" value="<?= e($q) ?>" placeholder="Tìm trong thư viện" maxlength="100">
            <label class="sr-only" for="lib-sort">Sắp xếp</label>
            <select class="input" id="lib-sort" name="sort">
                <option value="recent"<?= $sort === 'recent' ? ' selected' : '' ?>>Mới nhận gần đây</option>
                <option value="title"<?= $sort === 'title' ? ' selected' : '' ?>>Tên A–Z</option>
            </select>
            <button class="btn" type="submit">Lọc</button>
        </form>

        <?php if (!$games): ?>
            <div class="empty">
                <p><?= $q !== '' ? 'Không có trò chơi nào khớp.' : 'Thư viện còn trống. Trò chơi bạn mua, nhận miễn phí hoặc kích hoạt bằng mã sẽ hiện ở đây.' ?></p>
                <a class="btn primary" href="<?= e(app_url('/games')) ?>">Khám phá trò chơi</a>
            </div>
        <?php else: ?>
            <div class="rows">
                <?php foreach ($games as $g): ?>
                    <div class="row lib-row">
                        <a class="thumb" href="<?= e(game_url($g)) ?>">
                            <?php if ($g['anh_bia']): ?><img src="<?= e(app_media_url($g['anh_bia'])) ?>" alt="<?= e($g['anh_bia_alt'] ?: $g['tieu_de']) ?>" loading="lazy" data-fallback="<?= e($g['tieu_de']) ?>"><?php else: ?><span class="cover-fallback"><?= e($g['tieu_de']) ?></span><?php endif; ?>
                        </a>
                        <div class="grow">
                            <a class="link" href="<?= e(game_url($g)) ?>"><?= e($g['tieu_de']) ?></a>
                            <span class="sub"><?= e(label('ownership', $g['loai_nhan_quyen'])) ?> · <?= e(fmt_date($g['ngay_nhan_quyen'])) ?><?= $g['phien_ban_moi'] ? ' · Bản mới nhất ' . e($g['phien_ban_moi']) : '' ?></span>
                        </div>
                        <?php if ($playable($g['url_choi_ngoai'])): ?>
                            <a class="btn sm primary" href="<?= e($g['url_choi_ngoai']) ?>" target="_blank" rel="noopener noreferrer">Chơi / Tải về</a>
                        <?php else: ?>
                            <a class="btn sm" href="<?= e(game_url($g)) ?>#releases">Xem bản phát hành</a>
                        <?php endif; ?>
                    </div>
                <?php endforeach; ?>
            </div>
            <?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
        <?php endif; ?>
    </section>

    <aside class="span-4">
        <section class="panel" aria-labelledby="redeem-h">
            <header><h2 id="redeem-h">Kích hoạt mã</h2></header>
            <form class="form" method="post" action="<?= e(app_url('/keys/redeem')) ?>">
                <?= csrf_field() ?>
                <div class="field">
                    <label for="key">Mã kích hoạt</label>
                    <input class="input" id="key" name="key" required maxlength="80" autocomplete="off" spellcheck="false" placeholder="XXXX-XXXX-XXXX-XXXX">
                    <span class="hint">Nhà phát triển phát mã cho người thử nghiệm, báo chí hoặc người ủng hộ. Mỗi mã dùng một lần.</span>
                </div>
                <div class="form-actions"><button class="btn primary" type="submit">Kích hoạt</button></div>
            </form>
        </section>
    </aside>
</div>
