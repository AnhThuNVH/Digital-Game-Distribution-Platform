<?php
/**
 * Create or edit a project. @var ?array $game @var string $tab @var array $picked
 * @var array $categories @var array $tags @var array $platforms
 */
$isNew = $game === null;
$hasOld = old('tieu_de', null) !== null;
$v = static fn(string $key, $fallback = '') => old($key, $game[$key] ?? $fallback);
$flag = static fn(string $key) => $hasOld ? old($key, '') !== '' : (int)($game[$key] ?? 1) === 1;
$money = static fn($value) => $value === null || $value === '' ? '' : rtrim(rtrim(number_format((float)$value, 2, '.', ''), '0'), '.');
$statusLocked = !$isNew && !in_array($game['trang_thai'], DevGameController::DEV_STATUSES, true);
$action = $isNew ? '/dev/games' : '/dev/games/' . (int)$game['ma'];
$checks = static function (string $name, array $items, string $text, array $selected): void {
    foreach ($items as $item) {
        $id = (int)$item['ma'];
        echo '<label class="check"><input type="checkbox" name="' . e($name) . '[]" value="' . $id . '"' . (in_array($id, $selected, true) ? ' checked' : '') . '> <span>' . e($item[$text]) . '</span></label>';
    }
};
?>
<?php if ($isNew): ?>
<nav class="crumbs" aria-label="Đường dẫn"><a href="<?= e(app_url('/dev/games')) ?>">Dự án</a><span>Tạo mới</span></nav>
<div class="title-row"><div><h1>Tạo dự án</h1><p class="sub">Dự án mới bắt đầu ở trạng thái bản nháp, chỉ bạn và các đồng tác giả nhìn thấy.</p></div></div>
<?php else: ?>
<?php partial('dev-game-tabs', ['game' => $game, 'tab' => $tab]); ?>
<?php endif; ?>

<form method="post" action="<?= e(app_url($action)) ?>">
    <?= csrf_field() ?>
    <section class="settings-block" aria-labelledby="basic-h">
        <div class="about"><h2 id="basic-h">Thông tin cơ bản</h2><p>Tên, đường dẫn và mô tả hiển thị trên cửa hàng và trang trò chơi.</p></div>
        <div class="panel form">
            <div class="field">
                <label for="g-title">Tên dự án</label>
                <input class="input" id="g-title" name="tieu_de" maxlength="200" required value="<?= e($v('tieu_de')) ?>">
            </div>
            <div class="field">
                <label for="g-slug">Đường dẫn</label>
                <input class="input" id="g-slug" name="duong_dan_rut_gon" maxlength="220" pattern="[a-z0-9]+(-[a-z0-9]+)*" value="<?= e($v('duong_dan_rut_gon')) ?>" placeholder="Tự tạo từ tên nếu bỏ trống">
                <span class="hint">Chữ thường không dấu, số và dấu gạch ngang.<?= !$isNew && $game['ngay_cong_bo'] ? ' Đổi đường dẫn sau khi công bố sẽ làm hỏng các liên kết đã chia sẻ.' : '' ?></span>
            </div>
            <div class="form-grid">
                <div class="field">
                    <label for="g-type">Loại dự án</label>
                    <select class="input" id="g-type" name="loai_du_an" required>
                        <?php foreach (GameModel::PROJECT_TYPES as $t): ?><option value="<?= e($t) ?>"<?= $v('loai_du_an', 'game') === $t ? ' selected' : '' ?>><?= e(label('project_type', $t)) ?></option><?php endforeach; ?>
                    </select>
                </div>
                <div class="field">
                    <label for="g-release">Tình trạng phát triển</label>
                    <select class="input" id="g-release" name="trang_thai_phat_hanh" required>
                        <?php foreach (GameModel::RELEASE_STATUSES as $s): ?><option value="<?= e($s) ?>"<?= $v('trang_thai_phat_hanh', 'in_development') === $s ? ' selected' : '' ?>><?= e(label('release_status', $s)) ?></option><?php endforeach; ?>
                    </select>
                </div>
            </div>
            <div class="field">
                <label for="g-short">Mô tả ngắn</label>
                <textarea class="input" id="g-short" name="mo_ta_ngan" maxlength="500" rows="3"><?= e((string)$v('mo_ta_ngan')) ?></textarea>
                <span class="hint">Tối đa 500 ký tự, hiển thị trên thẻ trò chơi. Bắt buộc trước khi công bố.</span>
            </div>
            <div class="field">
                <label for="g-desc">Mô tả chi tiết</label>
                <textarea class="input tall" id="g-desc" name="mo_ta" maxlength="20000"><?= e((string)$v('mo_ta')) ?></textarea>
                <span class="hint">Văn bản thuần, xuống dòng được giữ nguyên.</span>
            </div>
        </div>
    </section>

    <section class="settings-block" aria-labelledby="price-h">
        <div class="about"><h2 id="price-h">Giá</h2><p>Giá tính bằng <?= e(APP_CURRENCY) ?>. Nền tảng thu phí <?= rtrim(rtrim(number_format(PLATFORM_FEE_RATE * 100, 1), '0'), '.') ?>% mỗi lượt bán; phần còn lại chia cho các tác giả theo tỷ lệ.</p></div>
        <div class="panel form">
            <fieldset class="field">
                <legend>Mô hình giá</legend>
                <div class="choice-grid">
                    <?php foreach (GameModel::PRICING as $p): ?>
                        <label class="check"><input type="radio" name="mo_hinh_gia" value="<?= e($p) ?>" required<?= $v('mo_hinh_gia', 'free') === $p ? ' checked' : '' ?>> <span><?= e(label('pricing', $p)) ?></span></label>
                    <?php endforeach; ?>
                </div>
            </fieldset>
            <div class="form-grid">
                <div class="field">
                    <label for="g-min">Giá / giá tối thiểu</label>
                    <input class="input" id="g-min" name="gia_toi_thieu" inputmode="decimal" pattern="\d{1,9}([.,]\d{1,2})?" value="<?= e($money($v('gia_toi_thieu'))) ?>" placeholder="0">
                    <span class="hint">Trả phí: giá bán, lớn hơn 0. Trả tùy ý: mức thấp nhất người mua có thể trả. Miễn phí và ủng hộ: bỏ qua.</span>
                </div>
                <div class="field">
                    <label for="g-sug">Giá đề xuất</label>
                    <input class="input" id="g-sug" name="gia_de_xuat" inputmode="decimal" pattern="\d{1,9}([.,]\d{1,2})?" value="<?= e($money($v('gia_de_xuat'))) ?>">
                    <span class="hint">Chỉ dùng cho trả tùy ý và ủng hộ.</span>
                </div>
            </div>
        </div>
    </section>

    <section class="settings-block" aria-labelledby="tax-h">
        <div class="about"><h2 id="tax-h">Phân loại</h2><p>Giúp người chơi tìm thấy dự án khi lọc trên trang Khám phá.</p></div>
        <div class="panel form">
            <fieldset class="field">
                <legend>Thể loại <span class="muted">(tối đa 3)</span></legend>
                <div class="choice-grid"><?php $checks('the_loai', $categories, 'ten', $picked['the_loai']); ?></div>
            </fieldset>
            <fieldset class="field">
                <legend>Nhãn <span class="muted">(tối đa 10)</span></legend>
                <div class="choice-grid"><?php $checks('nhan', $tags, 'ten', $picked['nhan']); ?></div>
            </fieldset>
            <fieldset class="field">
                <legend>Nền tảng</legend>
                <div class="choice-grid"><?php $checks('nen_tang', $platforms, 'ten_nen_tang', $picked['nen_tang']); ?></div>
            </fieldset>
            <div class="form-grid">
                <div class="field">
                    <label for="g-age">Phân loại độ tuổi</label>
                    <input class="input" id="g-age" name="phan_loai_do_tuoi" maxlength="40" value="<?= e((string)$v('phan_loai_do_tuoi')) ?>" placeholder="Ví dụ: 12+">
                </div>
                <div class="field">
                    <label for="g-license">Giấy phép</label>
                    <input class="input" id="g-license" name="ten_giay_phep" maxlength="120" value="<?= e((string)$v('ten_giay_phep')) ?>" placeholder="Ví dụ: GPL-3.0, CC BY 4.0">
                </div>
            </div>
            <div class="field">
                <label for="g-url">Liên kết chơi trên web</label>
                <input class="input" id="g-url" type="url" name="url_choi_ngoai" maxlength="1000" value="<?= e((string)$v('url_choi_ngoai')) ?>" placeholder="https://">
                <span class="hint">Trang chơi trên trình duyệt (game môi trường web) hoặc trang chủ dự án. Dùng cùng lúc với các liên kết tải về được.</span>
            </div>
        </div>
    </section>

    <section class="settings-block" aria-labelledby="vis-h">
        <div class="about"><h2 id="vis-h">Hiển thị</h2><p>Bản nháp chỉ tác giả thấy. "Không liệt kê" mở được bằng đường dẫn nhưng không xuất hiện trên cửa hàng.</p></div>
        <div class="panel form">
            <?php if ($isNew): ?>
                <p class="hint">Dự án được tạo ở trạng thái bản nháp. Bạn có thể công bố sau khi lưu.</p>
            <?php elseif ($statusLocked): ?>
                <p>Trạng thái hiện tại: <?= status_pill('game_status', $game['trang_thai']) ?></p>
                <p class="hint">Trạng thái này do đội ngũ kiểm duyệt đặt. Bạn vẫn sửa được nội dung; liên hệ quản trị viên để được xem xét lại.</p>
            <?php else: ?>
                <fieldset class="field">
                    <legend>Trạng thái</legend>
                    <div class="choice-grid">
                        <?php foreach (DevGameController::DEV_STATUSES as $s): ?>
                            <label class="check"><input type="radio" name="trang_thai" value="<?= e($s) ?>"<?= $v('trang_thai', 'draft') === $s ? ' checked' : '' ?>> <span><?= e(label('game_status', $s)) ?></span></label>
                        <?php endforeach; ?>
                    </div>
                </fieldset>
            <?php endif; ?>
            <label class="check"><input type="checkbox" name="cho_phep_binh_luan" value="1"<?= $flag('cho_phep_binh_luan') ? ' checked' : '' ?>> <span>Cho phép bình luận</span></label>
            <label class="check"><input type="checkbox" name="cho_phep_danh_gia" value="1"<?= $flag('cho_phep_danh_gia') ? ' checked' : '' ?>> <span>Cho phép đánh giá</span></label>
        </div>
    </section>

    <div class="form-actions section">
        <button class="btn primary" type="submit"><?= $isNew ? 'Tạo dự án' : 'Lưu thay đổi' ?></button>
        <a class="btn ghost" href="<?= e(app_url($isNew ? '/dev/games' : '/dev/games/' . (int)$game['ma'])) ?>">Hủy</a>
    </div>
</form>
