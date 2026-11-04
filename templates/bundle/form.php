<?php
/** Create or edit a bundle. @var string $scope @var ?array $bundle @var array $games @var int[] $picked @var string[] $dropped @var int $sales */
$isAdmin = $scope === 'admin';
$base = $isAdmin ? '/admin/bundles' : '/dev/bundles';
$isNew = $bundle === null;
$id = (int)($bundle['ma'] ?? 0);
$hasOld = old('tieu_de', null) !== null;
$v = static fn(string $key) => old($key, (string)($bundle[$key] ?? ''));
$dt = static fn(string $key) => old($key, datetime_local($bundle[$key] ?? null));
$price = $hasOld ? old('gia') : ($bundle ? number_format((float)$bundle['gia'], 2, '.', '') : '');
$status = old('trang_thai', $bundle['trang_thai'] ?? 'draft');
$checked = array_map('intval', $hasOld ? (array)old('games', []) : $picked);
$statuses = [
    'draft'     => 'Chỉ người tạo gói và quản trị viên xem được.',
    'published' => 'Bán trên cửa hàng trong thời gian bán.',
    'hidden'    => 'Ngừng bán và ẩn trang gói khỏi người mua.',
    'ended'     => 'Ngừng bán, trang gói vẫn xem được.',
];
?>
<nav class="crumbs" aria-label="Đường dẫn"><a href="<?= e(app_url($base)) ?>"><?= $isAdmin ? 'Gói game' : 'Gói game của tôi' ?></a><span><?= $isNew ? 'Tạo mới' : e($bundle['tieu_de']) ?></span></nav>

<div class="title-row">
    <div>
        <h1><?= $isNew ? 'Tạo gói game' : e($bundle['tieu_de']) ?></h1>
        <?php if (!$isNew): ?><p class="sub"><?= status_pill('bundle_status', $bundle['trang_thai']) ?> <?= e(label('bundle_type', $bundle['loai_goi_game'])) ?> · đã bán <?= fmt_int($sales) ?> lần · cập nhật <?= e(fmt_datetime($bundle['ngay_cap_nhat'])) ?></p><?php endif; ?>
    </div>
    <?php if (!$isNew): ?><a class="btn" href="<?= e(app_url('/bundles/' . rawurlencode($bundle['duong_dan_rut_gon']))) ?>">Xem trang gói</a><?php endif; ?>
</div>

<form class="form" method="post" action="<?= e(app_url($isNew ? $base : $base . '/' . $id)) ?>">
    <?= csrf_field() ?>
    <section class="settings-block" aria-labelledby="info-h">
        <div class="about">
            <h2 id="info-h">Thông tin</h2>
            <p>Giá gói tính bằng <?= e(APP_CURRENCY) ?>. Người mua đã có một số trò chơi trong gói vẫn trả đủ giá gói; trang gói cho họ biết trước điều này.</p>
        </div>
        <div class="panel form-grid">
            <div class="field full">
                <label for="bd-title">Tên gói</label>
                <input class="input" id="bd-title" name="tieu_de" required maxlength="200" value="<?= e($v('tieu_de')) ?>">
            </div>
            <div class="field">
                <label for="bd-slug">Đường dẫn rút gọn</label>
                <input class="input" id="bd-slug" name="duong_dan_rut_gon" maxlength="220" autocomplete="off" spellcheck="false" value="<?= e($v('duong_dan_rut_gon')) ?>">
                <span class="hint">Bỏ trống để tạo từ tên.<?= $isNew ? '' : ' Đổi giá trị này làm hỏng liên kết cũ.' ?></span>
            </div>
            <div class="field">
                <label for="bd-price">Giá gói (<?= e(APP_CURRENCY) ?>)</label>
                <input class="input" id="bd-price" name="gia" required inputmode="decimal" pattern="\d{1,9}([.,]\d{1,2})?" value="<?= e($price) ?>">
                <span class="hint">Chỉ đặt 0 khi mọi trò chơi trong gói đều miễn phí.</span>
            </div>
            <div class="field">
                <label for="bd-start">Bắt đầu bán</label>
                <input class="input" id="bd-start" type="datetime-local" name="ngay_bat_dau" value="<?= e($dt('ngay_bat_dau')) ?>">
            </div>
            <div class="field">
                <label for="bd-end">Kết thúc bán</label>
                <input class="input" id="bd-end" type="datetime-local" name="ngay_ket_thuc" value="<?= e($dt('ngay_ket_thuc')) ?>">
                <span class="hint">Bỏ trống cả hai: bán ngay khi công bố và không hết hạn.</span>
            </div>
            <div class="field full">
                <label for="bd-desc">Giới thiệu</label>
                <textarea class="input" id="bd-desc" name="mo_ta" maxlength="20000" rows="5"><?= e($v('mo_ta')) ?></textarea>
            </div>
            <fieldset class="field full">
                <legend>Trạng thái</legend>
                <div class="choice-grid">
                    <?php foreach ($statuses as $k => $hint): ?>
                        <label class="check"><input type="radio" name="trang_thai" value="<?= e($k) ?>"<?= $status === $k ? ' checked' : '' ?>> <span><?= e(label('bundle_status', $k)) ?><span class="sub"><?= e($hint) ?></span></span></label>
                    <?php endforeach; ?>
                </div>
            </fieldset>
        </div>
    </section>

    <section class="settings-block" aria-labelledby="games-h">
        <div class="about">
            <h2 id="games-h">Trò chơi</h2>
            <p><?= $isAdmin ? 'Mọi trò chơi đã công bố.' : 'Trò chơi đã công bố mà bạn là tác giả.' ?> Cần ít nhất 2. Doanh thu gói chia cho từng trò chơi theo giá lẻ, rồi cho các tác giả theo tỷ lệ đã đặt.</p>
            <?php if ($sales): ?><p>Đổi trò chơi không ảnh hưởng người đã mua: họ giữ những trò chơi đã nhận.</p><?php endif; ?>
        </div>
        <div class="panel">
            <?php if ($dropped): ?>
                <p class="hint">Sẽ bị gỡ khỏi gói khi lưu vì không còn chọn được: <?= e(implode(', ', $dropped)) ?>.</p>
            <?php endif; ?>
            <?php if (!$games): ?>
                <p class="muted">Chưa có trò chơi đã công bố nào để đưa vào gói.</p>
            <?php else: ?>
            <fieldset class="field">
                <legend class="sr-only">Trò chơi trong gói</legend>
                <div class="check-list">
                    <?php foreach ($games as $g): $gid = (int)$g['ma']; $base_price = GameModel::basePrice($g); ?>
                        <label class="check"><input type="checkbox" name="games[]" value="<?= $gid ?>"<?= in_array($gid, $checked, true) ? ' checked' : '' ?>>
                            <span><?= e($g['tieu_de']) ?>
                                <span class="sub"><?= $base_price > 0 ? 'Giá lẻ ' . e(money($base_price)) : 'Miễn phí' ?><?= $isAdmin ? ' · ' . e($g['nguoi_tao']) : '' ?></span>
                            </span>
                        </label>
                    <?php endforeach; ?>
                </div>
            </fieldset>
            <?php endif; ?>
        </div>
    </section>

    <div class="form-actions"><button class="btn primary" type="submit"><?= $isNew ? 'Tạo gói' : 'Lưu thay đổi' ?></button></div>
</form>
