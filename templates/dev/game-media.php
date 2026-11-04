<?php
/** Project images and links. @var array $game @var string $tab @var array $media @var int $maxMedia */
$gid = (int)$game['ma'];
$base = '/dev/games/' . $gid . '/media';
$isImage = static fn(string $type) => in_array($type, ['cover', 'thumbnail', 'screenshot', 'other'], true);
$taken = array_column($media, 'loai_media');
?>
<?php partial('dev-game-tabs', ['game' => $game, 'tab' => $tab]); ?>

<div class="grid top">
    <section class="panel span-8" aria-labelledby="media-h">
        <header><h2 id="media-h">Ảnh và liên kết</h2><span class="meta"><?= count($media) ?>/<?= (int)$maxMedia ?></span></header>
        <p class="hint">Ảnh bìa và ảnh chụp màn hình hiển thị trong thư viện ảnh của trang trò chơi; ảnh thu nhỏ dùng cho thẻ ở cửa hàng. Đoạn giới thiệu và liên kết ngoài hiện trong mục Liên kết.</p>
        <?php if (!$media): ?><div class="empty"><p>Chưa có ảnh nào. Thêm ảnh bìa để dự án hiển thị đẹp trên cửa hàng.</p></div><?php endif; ?>
        <div class="rows">
            <?php foreach ($media as $m): $mid = (int)$m['ma']; $image = $isImage($m['loai_media']); ?>
                <div class="row" id="media-<?= $mid ?>">
                    <div class="cell-game grow">
                        <?php if ($image): ?><img src="<?= e(app_media_url($m['url_media'])) ?>" alt="<?= e($m['van_ban_thay_the'] ?: '') ?>" loading="lazy" data-fallback=""><?php else: ?><span class="thumb"></span><?php endif; ?>
                        <div>
                            <strong><?= e(label('media_type', $m['loai_media'])) ?></strong> <span class="muted">· thứ tự <?= (int)$m['thu_tu_sap_xep'] ?></span>
                            <span class="sub"><?= $m['chu_thich'] !== null && $m['chu_thich'] !== '' ? media_credit_html($m['chu_thich']) : 'Chưa có chú thích' ?></span>
                            <?php if (!$image): ?><span class="sub"><a class="link" href="<?= e($m['url_media']) ?>" target="_blank" rel="noopener noreferrer"><?= e(excerpt($m['url_media'], 60)) ?></a></span><?php endif; ?>
                        </div>
                    </div>
                    <div class="cluster">
                        <details class="edit">
                            <summary class="link-btn">Sửa</summary>
                            <form class="form well" method="post" action="<?= e(app_url($base . '/' . $mid)) ?>">
                                <?= csrf_field() ?>
                                <?php if (!$image): ?>
                                    <div class="field"><label for="mu-<?= $mid ?>">Địa chỉ</label><input class="input sm" id="mu-<?= $mid ?>" type="url" name="url_media" maxlength="1500" required value="<?= e($m['url_media']) ?>"></div>
                                <?php endif; ?>
                                <div class="field"><label for="mc-<?= $mid ?>">Chú thích</label><input class="input sm" id="mc-<?= $mid ?>" name="chu_thich" maxlength="300" value="<?= e((string)$m['chu_thich']) ?>"></div>
                                <div class="field"><label for="ma-<?= $mid ?>">Văn bản thay thế</label><input class="input sm" id="ma-<?= $mid ?>" name="van_ban_thay_the" maxlength="300"<?= $image ? ' required' : '' ?> value="<?= e((string)$m['van_ban_thay_the']) ?>"></div>
                                <div class="field"><label for="mo-<?= $mid ?>">Thứ tự</label><input class="input sm" id="mo-<?= $mid ?>" type="number" name="thu_tu_sap_xep" min="0" max="1000" value="<?= (int)$m['thu_tu_sap_xep'] ?>"></div>
                                <button class="btn sm primary" type="submit">Lưu</button>
                            </form>
                        </details>
                        <form method="post" action="<?= e(app_url($base . '/' . $mid . '/delete')) ?>" data-confirm="Xóa <?= e(mb_strtolower(label('media_type', $m['loai_media']))) ?> này?<?= $image ? " Tệp ảnh đã tải lên cũng bị xóa." : "" ?>"><?= csrf_field() ?><button class="link-btn neg" type="submit">Xóa</button></form>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
    </section>

    <?php if (count($media) < $maxMedia): ?>
    <section class="panel span-4" id="add-media" aria-labelledby="add-media-h">
        <header><h2 id="add-media-h">Thêm</h2></header>
        <form class="form" method="post" action="<?= e(app_url($base)) ?>" enctype="multipart/form-data">
            <?= csrf_field() ?>
            <div class="field"><label for="m-type">Loại</label>
                <select class="input" id="m-type" name="loai_media" required>
                    <option value="">Chọn…</option>
                    <?php foreach (labels('media_type') as $k => $t): if (in_array($k, ['cover', 'thumbnail'], true) && in_array($k, $taken, true)) continue; ?>
                        <option value="<?= e($k) ?>"<?= old('loai_media') === $k ? ' selected' : '' ?>><?= e($t) ?></option>
                    <?php endforeach; ?>
                </select>
                <span class="hint">Mỗi dự án có một ảnh bìa và một ảnh thu nhỏ.</span>
            </div>
            <div class="field"><label for="m-file">Tệp ảnh</label><input class="input" id="m-file" type="file" name="tep" accept="image/jpeg,image/png,image/webp,image/gif"><span class="hint">Cho ảnh bìa, ảnh thu nhỏ, ảnh chụp màn hình và ảnh khác. JPG, PNG, WebP hoặc GIF, tối đa 5 MB.</span></div>
            <div class="field"><label for="m-url">Địa chỉ liên kết</label><input class="input" id="m-url" type="url" name="url_media" maxlength="1500" placeholder="https://" value="<?= e(old('url_media')) ?>"><span class="hint">Cho đoạn giới thiệu (trailer) và liên kết ngoài.</span></div>
            <div class="field"><label for="m-cap">Chú thích</label><input class="input" id="m-cap" name="chu_thich" maxlength="300" value="<?= e(old('chu_thich')) ?>"><span class="hint">Ghi nguồn ảnh nếu không phải ảnh của bạn: "Ảnh: tác giả, giấy phép · https://nguồn".</span></div>
            <div class="field"><label for="m-alt">Văn bản thay thế</label><input class="input" id="m-alt" name="van_ban_thay_the" maxlength="300" value="<?= e(old('van_ban_thay_the')) ?>"><span class="hint">Mô tả nội dung ảnh cho trình đọc màn hình. Bắt buộc với ảnh.</span></div>
            <div class="field"><label for="m-order">Thứ tự</label><input class="input" id="m-order" type="number" name="thu_tu_sap_xep" min="0" max="1000" value="<?= e(old('thu_tu_sap_xep', (string)count($media))) ?>"></div>
            <div class="form-actions"><button class="btn primary" type="submit">Thêm</button></div>
        </form>
    </section>
    <?php endif; ?>
</div>
