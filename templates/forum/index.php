<?php
/** Forum hub. @var array $groups @var array $myGames @var array $jamsWithoutBoard */
$user = current_user();
$staff = is_staff();
$titles = ['platform' => 'Thảo luận chung', 'game' => 'Theo trò chơi', 'jam' => 'Theo cuộc thi làm game'];
$empty = ['platform' => 'Chưa có diễn đàn chung nào.', 'game' => 'Chưa trò chơi nào mở diễn đàn. Nhà phát triển có thể mở một diễn đàn cho trò chơi của mình.', 'jam' => 'Chưa cuộc thi nào có diễn đàn.'];
$canCreate = $staff || $myGames;
?>
<div class="title-row">
    <div>
        <h1>Diễn đàn</h1>
        <p class="sub">Hỏi đáp, góp ý và chia sẻ cùng người chơi, nhà phát triển và người tham gia cuộc thi.</p>
    </div>
    <?php if ($canCreate): ?><a class="btn" href="#new">Mở diễn đàn</a><?php endif; ?>
</div>

<?php foreach ($groups as $kind => $boards): ?>
<section class="section" aria-labelledby="g-<?= e($kind) ?>">
    <div class="section-head"><h2 id="g-<?= e($kind) ?>"><?= e($titles[$kind]) ?></h2><span class="meta"><?= fmt_int(count($boards)) ?> diễn đàn</span></div>
    <?php if ($boards): ?>
        <div class="panel">
            <div class="rows">
                <?php foreach ($boards as $b): ?>
                    <div class="row board-row">
                        <div class="grow">
                            <a class="link t" href="<?= e(app_url('/forums/' . (int)$b['ma'])) ?>"><?= e($b['tieu_de']) ?></a>
                            <?php if (!(int)$b['cong_khai']): ?> <span class="pill">Riêng tư</span><?php endif; ?>
                            <?php if ($kind === 'game' && $b['game_status'] !== 'published'): ?> <span class="pill warn"><?= e(label('game_status', $b['game_status'])) ?></span><?php endif; ?>
                            <span class="sub">
                                <?php if ($kind === 'game'): ?>Trò chơi: <?= e($b['game_title']) ?><?php elseif ($kind === 'jam'): ?>Cuộc thi: <?= e($b['jam_title']) ?><?php endif; ?>
                                <?= $kind !== 'platform' && $b['mo_ta'] ? ' · ' : '' ?><?= $b['mo_ta'] ? e(excerpt($b['mo_ta'], 140)) : '' ?>
                            </span>
                        </div>
                        <div class="board-stats">
                            <span><strong><?= fmt_int((int)$b['so_chu_de']) ?></strong> chủ đề</span>
                            <span><strong><?= fmt_int((int)$b['so_bai']) ?></strong> trả lời</span>
                            <span class="faint"><?= $b['hoat_dong_cuoi'] ? e(time_ago($b['hoat_dong_cuoi'])) : 'Chưa có bài' ?></span>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    <?php else: ?>
        <div class="empty"><p><?= e($empty[$kind]) ?></p></div>
    <?php endif; ?>
</section>
<?php endforeach; ?>

<?php if ($canCreate): ?>
<section class="panel section narrow-panel" id="new" aria-labelledby="new-h">
    <header><h2 id="new-h">Mở diễn đàn mới</h2></header>
    <form class="form form-grid" method="post" action="<?= e(app_url('/forums')) ?>">
        <?= csrf_field() ?>
        <div class="field">
            <label for="f-kind">Loại</label>
            <select class="input" id="f-kind" name="loai_dien_dan" required>
                <?php if ($myGames): ?><option value="game"<?= old('loai_dien_dan') === 'game' ? ' selected' : '' ?>>Cho trò chơi của tôi</option><?php endif; ?>
                <?php if ($staff): ?><option value="platform"<?= old('loai_dien_dan') === 'platform' ? ' selected' : '' ?>>Diễn đàn chung</option><?php endif; ?>
                <?php if ($staff && $jamsWithoutBoard): ?><option value="jam"<?= old('loai_dien_dan') === 'jam' ? ' selected' : '' ?>>Cho cuộc thi</option><?php endif; ?>
            </select>
        </div>
        <?php if ($myGames): ?>
        <div class="field">
            <label for="f-game">Trò chơi (khi chọn loại trò chơi)</label>
            <select class="input" id="f-game" name="tro_choi_id">
                <?php foreach ($myGames as $g): ?><option value="<?= (int)$g['ma'] ?>"<?= (int)old('tro_choi_id') === (int)$g['ma'] ? ' selected' : '' ?>><?= e($g['tieu_de']) ?></option><?php endforeach; ?>
            </select>
        </div>
        <?php endif; ?>
        <?php if ($staff && $jamsWithoutBoard): ?>
        <div class="field">
            <label for="f-jam">Cuộc thi (khi chọn loại cuộc thi)</label>
            <select class="input" id="f-jam" name="cuoc_thi_id">
                <?php foreach ($jamsWithoutBoard as $j): ?><option value="<?= (int)$j['ma'] ?>"<?= (int)old('cuoc_thi_id') === (int)$j['ma'] ? ' selected' : '' ?>><?= e($j['tieu_de']) ?></option><?php endforeach; ?>
            </select>
        </div>
        <?php endif; ?>
        <div class="field full">
            <label for="f-title">Tên diễn đàn</label>
            <input class="input" id="f-title" name="tieu_de" maxlength="180" value="<?= e(old('tieu_de')) ?>" placeholder="Bỏ trống để dùng tên trò chơi hoặc cuộc thi">
        </div>
        <div class="field full">
            <label for="f-desc">Mô tả (không bắt buộc)</label>
            <textarea class="input" id="f-desc" name="mo_ta" maxlength="1000"><?= e(old('mo_ta')) ?></textarea>
        </div>
        <label class="check full"><input type="checkbox" name="cong_khai" value="1" checked> Công khai cho mọi người</label>
        <div class="form-actions full"><button class="btn primary" type="submit">Mở diễn đàn</button></div>
    </form>
</section>
<?php endif; ?>
