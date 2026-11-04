<?php
/** Project releases. @var array $game @var string $tab @var array $releases */
$gid = (int)$game['ma'];
$base = '/dev/games/' . $gid . '/releases';
$isPublic = in_array($game['trang_thai'], ['published', 'unlisted'], true);
$channelSelect = static function (string $id, string $selected): void {
    echo '<select class="input sm" id="' . e($id) . '" name="kenh_phat_hanh" required>';
    foreach (labels('channel') as $k => $t) {
        echo '<option value="' . e($k) . '"' . ($selected === $k ? ' selected' : '') . '>' . e($t) . '</option>';
    }
    echo '</select>';
};
?>
<?php partial('dev-game-tabs', ['game' => $game, 'tab' => $tab]); ?>

<div class="grid top">
    <section class="panel span-8" aria-labelledby="rel-h">
        <header><h2 id="rel-h">Lịch sử phiên bản</h2><span class="meta"><?= count($releases) ?> phiên bản</span></header>
        <?php if (!$releases): ?><div class="empty"><p>Chưa có phiên bản nào. Ghi lại từng bản cập nhật để người chơi biết trò chơi đang thay đổi thế nào.</p></div><?php endif; ?>
        <div class="rows">
            <?php foreach ($releases as $r): $rid = (int)$r['ma']; ?>
                <div class="row" id="release-<?= $rid ?>">
                    <div class="grow">
                        <strong><?= e($r['ten_phien_ban']) ?></strong> <?= status_pill('channel', $r['kenh_phat_hanh']) ?><?= (int)$r['cong_khai'] ? '' : ' <span class="pill">Ẩn</span>' ?>
                        <span class="sub"><?= e(fmt_datetime($r['ngay_phat_hanh'])) ?><?= strtotime($r['ngay_phat_hanh']) > time() ? ' (đã lên lịch)' : '' ?> · <?= e($r['ten_hien_thi']) ?></span>
                        <?php if ($r['ghi_chu_phat_hanh']): ?><div class="prose small"><?= e_multiline(excerpt($r['ghi_chu_phat_hanh'], 280)) ?></div><?php endif; ?>
                    </div>
                    <div class="cluster">
                        <details class="edit">
                            <summary class="link-btn">Sửa</summary>
                            <form class="form well" method="post" action="<?= e(app_url($base . '/' . $rid)) ?>">
                                <?= csrf_field() ?>
                                <div class="field"><label for="rv-<?= $rid ?>">Phiên bản</label><input class="input sm" id="rv-<?= $rid ?>" name="ten_phien_ban" maxlength="60" required value="<?= e($r['ten_phien_ban']) ?>"></div>
                                <div class="field"><label for="rc-<?= $rid ?>">Kênh</label><?php $channelSelect('rc-' . $rid, $r['kenh_phat_hanh']); ?></div>
                                <div class="field"><label for="rd-<?= $rid ?>">Ngày phát hành</label><input class="input sm" id="rd-<?= $rid ?>" type="datetime-local" name="ngay_phat_hanh" required value="<?= e(datetime_local($r['ngay_phat_hanh'])) ?>"></div>
                                <div class="field"><label for="rn-<?= $rid ?>">Ghi chú phát hành</label><textarea class="input" id="rn-<?= $rid ?>" name="ghi_chu_phat_hanh" maxlength="20000"><?= e((string)$r['ghi_chu_phat_hanh']) ?></textarea></div>
                                <label class="check"><input type="checkbox" name="cong_khai" value="1"<?= (int)$r['cong_khai'] ? ' checked' : '' ?>> <span>Công khai</span></label>
                                <button class="btn sm primary" type="submit">Lưu</button>
                            </form>
                        </details>
                        <form method="post" action="<?= e(app_url($base . '/' . $rid . '/delete')) ?>" data-confirm="Xóa phiên bản <?= e($r['ten_phien_ban']) ?>?"><?= csrf_field() ?><button class="link-btn neg" type="submit">Xóa</button></form>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
    </section>

    <section class="panel span-4" id="add-release" aria-labelledby="add-rel-h">
        <header><h2 id="add-rel-h">Thêm phiên bản</h2></header>
        <form class="form" method="post" action="<?= e(app_url($base)) ?>">
            <?= csrf_field() ?>
            <div class="field"><label for="r-ver">Phiên bản</label><input class="input" id="r-ver" name="ten_phien_ban" maxlength="60" required placeholder="Ví dụ: 1.2.0" value="<?= e(old('ten_phien_ban')) ?>"></div>
            <div class="field"><label for="r-ch">Kênh</label><?php $channelSelect('r-ch', old('kenh_phat_hanh', 'stable')); ?></div>
            <div class="field"><label for="r-date">Ngày phát hành</label><input class="input" id="r-date" type="datetime-local" name="ngay_phat_hanh" value="<?= e(old('ngay_phat_hanh')) ?>"><span class="hint">Bỏ trống: phát hành ngay.</span></div>
            <div class="field"><label for="r-notes">Ghi chú phát hành</label><textarea class="input" id="r-notes" name="ghi_chu_phat_hanh" maxlength="20000"><?= e(old('ghi_chu_phat_hanh')) ?></textarea></div>
            <label class="check"><input type="checkbox" name="cong_khai" value="1"<?= old('ten_phien_ban', null) === null || old('cong_khai') !== '' ? ' checked' : '' ?>> <span>Công khai<span class="sub"><?= $isPublic ? 'Người theo dõi nhận thông báo khi phiên bản công khai được phát hành.' : 'Dự án đang là bản nháp nên chưa gửi thông báo.' ?></span></span></label>
            <div class="form-actions"><button class="btn primary" type="submit">Thêm</button></div>
        </form>
    </section>
</div>
