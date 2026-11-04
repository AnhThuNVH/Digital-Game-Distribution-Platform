<?php
/** Create or edit a discount campaign. @var ?array $campaign @var array $games @var int[] $picked */
$isNew = $campaign === null;
$id = (int)($campaign['ma'] ?? 0);
$action = $isNew ? '/admin/campaigns' : '/admin/campaigns/' . $id;
$hasOld = old('tieu_de', null) !== null;
$v = static fn(string $key, $default = '') => old($key, $campaign[$key] ?? $default);
$dt = static fn(string $key) => old($key, datetime_local($campaign[$key] ?? null));
$pctValue = $hasOld ? old('phan_tram_giam_gia') : ($campaign ? rtrim(rtrim((string)$campaign['phan_tram_giam_gia'], '0'), '.') : '');
$storedMode = match ($campaign['trang_thai'] ?? 'draft') { 'draft' => 'draft', 'cancelled' => 'cancelled', default => 'run' };
$mode = old('che_do', $storedMode);
$checked = array_map('intval', $hasOld ? (array)old('tro_choi', []) : $picked);
$modes = [
    'draft'     => ['Bản nháp', 'Chưa giảm giá. Dùng để chuẩn bị trước.'],
    'run'       => ['Chạy theo lịch', 'Giá giảm tự động trong khoảng thời gian đã đặt.'],
    'cancelled' => ['Hủy', 'Dừng giảm giá ngay, giữ lại bản ghi.'],
];
?>
<nav class="crumbs" aria-label="Đường dẫn"><a href="<?= e(app_url('/admin/campaigns')) ?>">Chiến dịch giảm giá</a><span><?= $isNew ? 'Tạo mới' : e($campaign['tieu_de']) ?></span></nav>

<div class="title-row">
    <div>
        <h1><?= $isNew ? 'Tạo chiến dịch' : e($campaign['tieu_de']) ?></h1>
        <?php if (!$isNew): ?><p class="sub"><?= status_pill('campaign_status', DiscountCampaignModel::phase($campaign)) ?> Tạo <?= e(fmt_datetime($campaign['ngay_tao'])) ?></p><?php endif; ?>
    </div>
</div>

<form class="form" method="post" action="<?= e(app_url($action)) ?>">
    <?= csrf_field() ?>
    <section class="settings-block" aria-labelledby="info-h">
        <div class="about">
            <h2 id="info-h">Thông tin</h2>
            <p>Mức giảm áp dụng cho giá niêm yết của trò chơi trả phí. Trò chơi trả tùy ý và miễn phí không bị ảnh hưởng.</p>
        </div>
        <div class="panel form-grid">
            <div class="field full">
                <label for="cm-title">Tiêu đề</label>
                <input class="input" id="cm-title" name="tieu_de" minlength="3" maxlength="200" required value="<?= e($v('tieu_de')) ?>">
            </div>
            <div class="field">
                <label for="cm-pct">Mức giảm (%)</label>
                <input class="input" id="cm-pct" type="number" name="phan_tram_giam_gia" min="1" max="95" step="0.01" required value="<?= e($pctValue) ?>">
                <span class="hint">Từ 1 đến 95%.</span>
            </div>
            <div class="field new-row">
                <label for="cm-start">Bắt đầu</label>
                <input class="input" id="cm-start" type="datetime-local" name="ngay_bat_dau" required value="<?= e($dt('ngay_bat_dau')) ?>">
            </div>
            <div class="field">
                <label for="cm-end">Kết thúc</label>
                <input class="input" id="cm-end" type="datetime-local" name="ngay_ket_thuc" required value="<?= e($dt('ngay_ket_thuc')) ?>">
            </div>
            <div class="field full">
                <label for="cm-desc">Mô tả nội bộ</label>
                <textarea class="input" id="cm-desc" name="mo_ta" maxlength="5000" rows="3"><?= e((string)$v('mo_ta')) ?></textarea>
                <span class="hint">Không hiển thị cho người mua.</span>
            </div>
            <fieldset class="field full">
                <legend>Trạng thái</legend>
                <div class="choice-grid">
                    <?php foreach ($modes as $k => [$name, $hint]): ?>
                        <label class="check"><input type="radio" name="che_do" value="<?= e($k) ?>"<?= $mode === $k ? ' checked' : '' ?>> <span><?= e($name) ?><span class="sub"><?= e($hint) ?></span></span></label>
                    <?php endforeach; ?>
                </div>
            </fieldset>
        </div>
    </section>

    <section class="settings-block" aria-labelledby="games-h">
        <div class="about">
            <h2 id="games-h">Trò chơi</h2>
            <p>Chỉ liệt kê trò chơi trả phí có giá. Trò chơi chưa công bố được giảm khi công bố trong thời gian chiến dịch.</p>
        </div>
        <div class="panel">
            <?php if (!$games): ?>
                <p class="muted">Chưa có trò chơi trả phí nào.</p>
            <?php else: ?>
            <fieldset class="field">
                <legend class="sr-only">Trò chơi được giảm giá</legend>
                <div class="check-list">
                    <?php foreach ($games as $g): $gid = (int)$g['ma']; ?>
                        <label class="check"><input type="checkbox" name="tro_choi[]" value="<?= $gid ?>"<?= in_array($gid, $checked, true) ? ' checked' : '' ?>>
                            <span><?= e($g['tieu_de']) ?>
                                <span class="sub"><?= e(money((float)$g['gia_toi_thieu'])) ?> · <?= e(label('game_status', $g['trang_thai'])) ?><?= $g['chien_dich_khac'] ? ' · cũng trong: ' . e($g['chien_dich_khac']) : '' ?></span>
                            </span>
                        </label>
                    <?php endforeach; ?>
                </div>
            </fieldset>
            <?php endif; ?>
        </div>
    </section>

    <div class="form-actions"><button class="btn primary" type="submit"><?= $isNew ? 'Tạo chiến dịch' : 'Lưu thay đổi' ?></button></div>
</form>
