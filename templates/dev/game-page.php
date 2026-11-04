<?php
/** Public page look: colours, layout, community. @var array $game @var string $tab @var array $settings */
$gid = (int)$game['ma'];
$v = static fn(string $key) => old($key, (string)($settings[$key] ?? ''));
$hasOld = old('bo_cuc_trang', null) !== null;
$on = static fn(string $key) => $hasOld ? old($key) !== '' : (int)($settings[$key] ?? 1) === 1;
$pickedLayout = old('bo_cuc_trang', $settings['bo_cuc_trang'] ?? 'default');
$layouts = [
    'default' => ['Mặc định', 'Ảnh và mô tả bên trái, khung mua và thông tin bên phải.'],
    'wide'    => ['Rộng', 'Thư viện ảnh lớn hơn, cột thông tin hẹp lại.'],
    'minimal' => ['Tối giản', 'Ẩn cột thông tin, chỉ giữ một cột nội dung.'],
];
$colors = [
    'mau_nen'      => ['Màu nền', 'Để trống: nền đen của cửa hàng.'],
    'mau_chu'      => ['Màu chữ', 'Để trống: chữ trắng.'],
    'mau_lien_ket' => ['Màu liên kết', 'Để trống: cùng màu chữ.'],
];
// Preview uses the saved values, the same way the public page does.
$saved = array_filter([
    '--page-bg'   => $settings['mau_nen'] ?? null,
    '--page-ink'  => $settings['mau_chu'] ?? null,
    '--page-link' => $settings['mau_lien_ket'] ?? null,
]);
$style = implode(';', array_map(static fn($k, $c) => $k . ':' . $c, array_keys($saved), $saved));
?>
<?php partial('dev-game-tabs', ['game' => $game, 'tab' => $tab]); ?>

<form class="form" method="post" action="<?= e(app_url('/dev/games/' . $gid . '/page')) ?>">
    <?= csrf_field() ?>
    <section class="settings-block" aria-labelledby="colors-h">
        <div class="about">
            <h2 id="colors-h">Màu sắc</h2>
            <p>Nhập mã màu dạng #RRGGBB. Chữ và liên kết phải có độ tương phản ít nhất 4.5:1 với nền để ai cũng đọc được; hệ thống kiểm tra khi lưu.</p>
        </div>
        <div class="panel">
            <div class="form-grid">
                <?php foreach ($colors as $key => [$name, $hint]): ?>
                    <div class="field">
                        <label for="c-<?= e($key) ?>"><?= e($name) ?></label>
                        <input class="input" id="c-<?= e($key) ?>" name="<?= e($key) ?>" maxlength="7" pattern="#[0-9a-fA-F]{6}" placeholder="#000000" autocomplete="off" spellcheck="false" value="<?= e($v($key)) ?>">
                        <span class="hint"><?= e($hint) ?></span>
                    </div>
                <?php endforeach; ?>
            </div>
            <div class="game-page themed has-bg page-preview"<?= $style ? ' style="' . e($style) . '"' : '' ?> aria-label="Xem trước màu đã lưu">
                <strong><?= e($game['tieu_de']) ?></strong>
                <p class="prose">Đoạn văn mẫu với <a href="#colors-h" tabindex="-1">một liên kết</a>. Xem trước dùng màu đã lưu.</p>
            </div>
        </div>
    </section>

    <section class="settings-block" aria-labelledby="layout-h">
        <div class="about">
            <h2 id="layout-h">Bố cục</h2>
            <p>Cách sắp xếp trang trò chơi trên màn hình rộng. Trên điện thoại mọi bố cục đều hiển thị một cột.</p>
        </div>
        <div class="panel">
            <fieldset class="field">
                <legend class="sr-only">Bố cục trang</legend>
                <div class="choice-grid">
                    <?php foreach ($layouts as $k => [$name, $hint]): ?>
                        <label class="check"><input type="radio" name="bo_cuc_trang" value="<?= e($k) ?>"<?= $pickedLayout === $k ? ' checked' : '' ?>> <span><?= e($name) ?><span class="sub"><?= e($hint) ?></span></span></label>
                    <?php endforeach; ?>
                </div>
            </fieldset>
        </div>
    </section>

    <section class="settings-block" aria-labelledby="community-h">
        <div class="about">
            <h2 id="community-h">Cộng đồng</h2>
            <p>Bình luận chỉ hiện khi cả hai nơi đều bật: tùy chọn "Cho phép bình luận" ở tab Chi tiết và tùy chọn dưới đây.</p>
        </div>
        <div class="panel">
            <label class="check"><input type="checkbox" name="bat_cong_dong" value="1"<?= $on('bat_cong_dong') ? ' checked' : '' ?>> <span>Bật bình luận cộng đồng<span class="sub">Áp dụng cho trang trò chơi và các bài nhật ký.</span></span></label>
            <label class="check"><input type="checkbox" name="hien_thi_nha_sang_tao" value="1"<?= $on('hien_thi_nha_sang_tao') ? ' checked' : '' ?>> <span>Hiện danh sách tác giả<span class="sub">Tên các tác giả trên trang trò chơi.</span></span></label>
        </div>
    </section>

    <div class="form-actions"><button class="btn primary" type="submit">Lưu giao diện</button></div>
</form>
