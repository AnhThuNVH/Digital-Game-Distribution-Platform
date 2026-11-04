<?php
/** One collection. @var array $collection @var array $games @var bool $isOwner @var array $owned */
$id = (int)$collection['ma'];
$self = '/collections/' . $id;
$asList = $collection['bo_cuc'] === 'list';
?>
<nav class="crumbs" aria-label="Đường dẫn"><a href="<?= e(app_url('/collections')) ?>">Bộ sưu tập</a><span><?= e($collection['tieu_de']) ?></span></nav>

<header class="object-head">
    <img class="avatar lg" src="<?= e(avatar_url(['ma' => $collection['nguoi_dung_so_huu_id'], 'url_anh_dai_dien' => $collection['url_anh_dai_dien']])) ?>" alt="">
    <div class="grow">
        <h1><?= e($collection['tieu_de']) ?></h1>
        <p class="meta">Tuyển chọn bởi <a class="link" href="<?= e(profile_url($collection)) ?>"><?= e($collection['ten_hien_thi']) ?></a> · cập nhật <?= e(fmt_date($collection['ngay_cap_nhat'])) ?>
            <?php if ($collection['pham_vi_hien_thi'] !== 'public'): ?> · <?= e(label('visibility', $collection['pham_vi_hien_thi'])) ?><?php endif; ?></p>
        <div class="stat-line"><span><strong><?= fmt_int(count($games)) ?></strong> trò chơi</span></div>
    </div>
    <?php if ($isOwner): ?><div class="actions"><a class="btn" href="#edit">Sửa bộ sưu tập</a></div><?php endif; ?>
</header>

<?php if ($collection['mo_ta']): ?><div class="prose section collection-intro"><?= e_multiline($collection['mo_ta']) ?></div><?php endif; ?>

<section class="section" aria-labelledby="games-h">
    <h2 class="sr-only" id="games-h">Trò chơi</h2>
    <?php if (!$games): ?>
        <div class="empty"><p><?= $isOwner ? 'Bộ sưu tập còn trống. Mở trang một trò chơi và chọn "Thêm vào bộ sưu tập".' : 'Bộ sưu tập này chưa có trò chơi nào.' ?></p><a class="btn" href="<?= e(app_url('/games')) ?>">Khám phá trò chơi</a></div>
    <?php elseif ($asList || $isOwner): ?>
        <section class="panel">
            <div class="rows">
                <?php foreach ($games as $g): ?>
                    <div class="row lib-row">
                        <a class="thumb" href="<?= e(game_url($g)) ?>">
                            <?php if ($g['anh_bia']): ?><img src="<?= e(app_media_url($g['anh_bia'])) ?>" alt="<?= e($g['anh_bia_alt'] ?: $g['tieu_de']) ?>" loading="lazy" data-fallback="<?= e($g['tieu_de']) ?>"><?php else: ?><span class="cover-fallback"><?= e($g['tieu_de']) ?></span><?php endif; ?>
                        </a>
                        <div class="grow">
                            <a class="link" href="<?= e(game_url($g)) ?>"><?= e($g['tieu_de']) ?></a>
                            <span class="sub"><?= e($g['nha_phat_trien'] ?: label('release_status', $g['trang_thai_phat_hanh'])) ?><?= $g['the_loai'] ? ' · ' . e($g['the_loai']) : '' ?></span>
                            <?php if ($g['ghi_chu'] && !$isOwner): ?><p class="curator-note"><?= e($g['ghi_chu']) ?></p><?php endif; ?>
                            <?php if ($isOwner): ?>
                                <form class="form note-form" method="post" action="<?= e(app_url($self . '/items')) ?>">
                                    <?= csrf_field() ?><?= return_field($self) ?>
                                    <input type="hidden" name="game_id" value="<?= (int)$g['ma'] ?>">
                                    <label class="sr-only" for="note-<?= (int)$g['ma'] ?>">Ghi chú cho <?= e($g['tieu_de']) ?></label>
                                    <input class="input sm" id="note-<?= (int)$g['ma'] ?>" name="ghi_chu" maxlength="500" value="<?= e((string)$g['ghi_chu']) ?>" placeholder="Ghi chú vì sao bạn chọn trò chơi này">
                                    <button class="btn sm" type="submit">Lưu ghi chú</button>
                                </form>
                            <?php endif; ?>
                        </div>
                        <div class="cluster">
                            <?= price_html($g, in_array((int)$g['ma'], $owned, true)) ?>
                            <?php if ($isOwner): ?>
                                <form method="post" action="<?= e(app_url($self . '/items/' . (int)$g['ma'] . '/remove')) ?>" data-confirm="Bỏ <?= e($g['tieu_de']) ?> khỏi bộ sưu tập?">
                                    <?= csrf_field() ?><?= return_field($self) ?>
                                    <button class="link-btn neg" type="submit">Bỏ</button>
                                </form>
                            <?php endif; ?>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </section>
    <?php else: ?>
        <div class="games-grid">
            <?php foreach ($games as $g): ?>
                <div class="collection-item">
                    <?php partial('game-card', ['game' => $g, 'owned' => in_array((int)$g['ma'], $owned, true)]); ?>
                    <?php if ($g['ghi_chu']): ?><p class="curator-note"><?= e($g['ghi_chu']) ?></p><?php endif; ?>
                </div>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>
</section>

<?php if ($isOwner): ?>
<div class="grid section">
    <section class="panel span-8" id="edit" aria-labelledby="edit-h">
        <header><h2 id="edit-h">Sửa bộ sưu tập</h2></header>
        <form class="form form-grid" method="post" action="<?= e(app_url($self)) ?>">
            <?= csrf_field() ?>
            <div class="field full">
                <label for="e-title">Tên</label>
                <input class="input" id="e-title" name="tieu_de" maxlength="180" required value="<?= e(old('tieu_de', $collection['tieu_de'])) ?>">
            </div>
            <div class="field full">
                <label for="e-desc">Mô tả</label>
                <textarea class="input" id="e-desc" name="mo_ta" maxlength="5000"><?= e(old('mo_ta', (string)$collection['mo_ta'])) ?></textarea>
            </div>
            <div class="field">
                <label for="e-vis">Ai xem được</label>
                <select class="input" id="e-vis" name="pham_vi_hien_thi">
                    <?php foreach (labels('visibility') as $v => $t): ?><option value="<?= e($v) ?>"<?= old('pham_vi_hien_thi', $collection['pham_vi_hien_thi']) === $v ? ' selected' : '' ?>><?= e($t) ?></option><?php endforeach; ?>
                </select>
            </div>
            <div class="field">
                <label for="e-layout">Bố cục cho người xem</label>
                <select class="input" id="e-layout" name="bo_cuc">
                    <option value="grid"<?= old('bo_cuc', $collection['bo_cuc']) === 'grid' ? ' selected' : '' ?>>Lưới ảnh bìa</option>
                    <option value="list"<?= old('bo_cuc', $collection['bo_cuc']) === 'list' ? ' selected' : '' ?>>Danh sách kèm ghi chú</option>
                </select>
            </div>
            <div class="form-actions full"><button class="btn primary" type="submit">Lưu thay đổi</button></div>
        </form>
    </section>
    <section class="panel span-4" id="danger" aria-labelledby="del-h">
        <header><h2 id="del-h">Xóa bộ sưu tập</h2></header>
        <p class="small muted">Chỉ xóa danh sách này. Trò chơi và quyền sở hữu của bạn không bị ảnh hưởng.</p>
        <form class="form" method="post" action="<?= e(app_url($self . '/delete')) ?>">
            <?= csrf_field() ?>
            <div class="field">
                <label for="del-confirm">Nhập XOA để xác nhận</label>
                <input class="input" id="del-confirm" name="confirm" autocomplete="off" required pattern="[Xx][Oo][Aa]">
            </div>
            <div class="form-actions"><button class="btn danger" type="submit">Xóa bộ sưu tập</button></div>
        </form>
    </section>
</div>
<?php endif; ?>
