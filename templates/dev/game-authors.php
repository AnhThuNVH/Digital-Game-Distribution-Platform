<?php
/** Authors and revenue split. @var array $game @var string $tab @var array $authors @var int $maxAuthors @var bool $isCreator */
$gid = (int)$game['ma'];
$creator = (int)$game['nguoi_tao_id'];
$pct = static fn($v) => rtrim(rtrim(number_format((float)$v, 2, '.', ''), '0'), '.');
$sum = array_sum(array_map(static fn($a) => (float)$a['phan_tram_huong_doanh_thu'], $authors));
?>
<?php partial('dev-game-tabs', ['game' => $game, 'tab' => $tab]); ?>

<section class="settings-block" aria-labelledby="authors-h">
    <div class="about">
        <h2 id="authors-h">Tác giả và chia doanh thu</h2>
        <p>Sau phí nền tảng, mỗi lượt bán được chia cho các tác giả theo tỷ lệ dưới đây. Tổng phải bằng 100%. Thay đổi chỉ áp dụng cho các lượt bán sau khi lưu.</p>
        <?php if (!$isCreator): ?><p>Chỉ người tạo dự án được sửa danh sách này.</p><?php endif; ?>
    </div>
    <?php if ($isCreator): ?>
    <form class="panel form" method="post" action="<?= e(app_url('/dev/games/' . $gid . '/authors')) ?>">
        <?= csrf_field() ?>
        <div class="table-wrap">
            <table>
                <thead><tr><th scope="col">Tác giả</th><th scope="col" class="num">Tỷ lệ (%)</th><th scope="col" class="num">Thứ tự</th><th scope="col">Gỡ</th></tr></thead>
                <tbody>
                <?php foreach ($authors as $a): $u = (int)$a['nguoi_dung_id']; ?>
                    <tr>
                        <td><?= e($a['ten_hien_thi'] ?? '') ?><span class="sub">@<?= e($a['ten_dang_nhap'] ?? '') ?><?= $u === $creator ? ' · người tạo' : '' ?><?= !empty($a['chua_luu']) ? ' · chưa lưu' : '' ?></span></td>
                        <td class="num"><label class="sr-only" for="sh-<?= $u ?>">Tỷ lệ của <?= e($a['ten_hien_thi'] ?? '') ?></label><input class="input sm num" id="sh-<?= $u ?>" name="share[<?= $u ?>]" inputmode="decimal" pattern="\d{1,3}([.,]\d{1,2})?" required value="<?= e(old('share', [])[$u] ?? $pct($a['phan_tram_huong_doanh_thu'])) ?>"></td>
                        <td class="num"><label class="sr-only" for="or-<?= $u ?>">Thứ tự của <?= e($a['ten_hien_thi'] ?? '') ?></label><input class="input sm num" id="or-<?= $u ?>" type="number" name="order[<?= $u ?>]" min="0" max="99" value="<?= (int)(old('order', [])[$u] ?? $a['thu_tu_hien_thi']) ?>"></td>
                        <td><?php if ($u !== $creator): ?><label class="check"><input type="checkbox" name="remove[<?= $u ?>]" value="1"<?= !empty(old('remove', [])[$u]) ? ' checked' : '' ?>> <span class="sr-only">Gỡ <?= e($a['ten_hien_thi'] ?? '') ?></span></label><?php endif; ?></td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
        <?php if (count($authors) < $maxAuthors): ?>
        <div class="form-grid">
            <div class="field">
                <label for="a-new">Thêm tác giả (tên đăng nhập)</label>
                <input class="input" id="a-new" name="tac_gia_moi" maxlength="50" autocomplete="off" value="<?= e(old('tac_gia_moi')) ?>">
                <span class="hint">Tài khoản đang hoạt động có vai trò nhà phát triển.</span>
            </div>
            <div class="field">
                <label for="a-share">Tỷ lệ của tác giả mới (%)</label>
                <input class="input" id="a-share" name="share_moi" inputmode="decimal" pattern="\d{1,3}([.,]\d{1,2})?" value="<?= e(old('share_moi')) ?>">
                <span class="hint">Giảm tỷ lệ của tác giả khác để tổng vẫn bằng 100%.</span>
            </div>
        </div>
        <?php endif; ?>
        <p class="hint">Tổng hiện tại: <?= e($pct($sum)) ?>%. Tối đa <?= (int)$maxAuthors ?> tác giả.</p>
        <div class="form-actions"><button class="btn primary" type="submit">Lưu</button></div>
    </form>
    <?php else: ?>
    <div class="panel">
        <div class="rows">
            <?php foreach ($authors as $a): ?>
                <div class="row"><div class="grow"><?= e($a['ten_hien_thi'] ?? '') ?><span class="sub">@<?= e($a['ten_dang_nhap'] ?? '') ?><?= (int)$a['nguoi_dung_id'] === $creator ? ' · người tạo' : '' ?></span></div><strong><?= e($pct($a['phan_tram_huong_doanh_thu'])) ?>%</strong></div>
            <?php endforeach; ?>
        </div>
    </div>
    <?php endif; ?>
</section>
