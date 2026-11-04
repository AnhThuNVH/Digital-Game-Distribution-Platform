<?php
/** Access keys for a project. @var array $game @var string $tab @var array $keys @var array $counts @var string $status @var array $fresh @var int $total @var int $page @var int $pages @var int $batch */
$gid = (int)$game['ma'];
$base = '/dev/games/' . $gid . '/keys';
$isPublic = in_array($game['trang_thai'], ['published', 'unlisted'], true);
$all = array_sum(array_map('intval', $counts));
?>
<?php partial('dev-game-tabs', ['game' => $game, 'tab' => $tab]); ?>

<?php if ($fresh): ?>
<section class="panel section" id="fresh" aria-labelledby="fresh-h">
    <header><h2 id="fresh-h">Mã vừa tạo</h2><span class="meta"><?= fmt_int(count($fresh)) ?> mã</span></header>
    <p class="hint">Sao chép và lưu lại ngay. Hệ thống chỉ giữ bản băm của mã nên danh sách này không hiển thị lại sau khi rời trang.</p>
    <div class="codes" aria-label="Danh sách mã">
        <?php foreach ($fresh as $code): ?><code><?= e($code) ?></code><?php endforeach; ?>
    </div>
    <label class="sr-only" for="fresh-all">Tất cả mã, mỗi dòng một mã</label>
    <textarea class="input" id="fresh-all" readonly rows="<?= min(8, count($fresh)) ?>"><?= e(implode("\n", $fresh)) ?></textarea>
</section>
<?php endif; ?>

<div class="grid top">
    <section class="panel span-8" aria-labelledby="keys-h">
        <header><h2 id="keys-h">Mã truy cập</h2><span class="meta"><?= fmt_int($all) ?> mã</span></header>
        <p class="hint">Mỗi mã cấp quyền sở hữu trò chơi cho một tài khoản, nhập tại trang Thư viện. Mã chỉ dùng được khi dự án đang công khai hoặc không niêm yết<?= $isPublic ? '.' : '; dự án hiện là bản nháp nên chưa ai dùng được.' ?></p>
        <nav class="chips chips-row" aria-label="Lọc theo trạng thái">
            <a class="chip"<?= $status === '' ? ' aria-current="true"' : '' ?> href="<?= e(app_url($base . qs(['status' => null, 'page' => null]))) ?>">Tất cả <span class="muted"><?= fmt_int($all) ?></span></a>
            <?php foreach (labels('key_status') as $k => $t): ?>
                <a class="chip"<?= $status === $k ? ' aria-current="true"' : '' ?> href="<?= e(app_url($base . qs(['status' => $k, 'page' => null]))) ?>"><?= e($t) ?> <span class="muted"><?= fmt_int((int)($counts[$k] ?? 0)) ?></span></a>
            <?php endforeach; ?>
        </nav>
        <?php if (!$keys): ?>
            <div class="empty"><p><?= $status === '' ? 'Chưa có mã nào. Tạo mã để tặng báo chí, người thử nghiệm hoặc người ủng hộ.' : 'Không có mã nào ở trạng thái này.' ?></p></div>
        <?php else: ?>
        <div class="table-wrap">
            <table>
                <thead><tr><th scope="col">Mã số</th><th scope="col">Trạng thái</th><th scope="col">Tạo</th><th scope="col">Hết hạn</th><th scope="col">Người nhận</th><th scope="col"><span class="sr-only">Thao tác</span></th></tr></thead>
                <tbody>
                <?php foreach ($keys as $k): $state = $k['trang_thai_hien_tai']; ?>
                    <tr>
                        <td>#<?= (int)$k['ma'] ?></td>
                        <td><?= status_pill('key_status', $state) ?></td>
                        <td><?= e(fmt_date($k['ngay_tao'])) ?><span class="sub"><?= e($k['nguoi_tao']) ?></span></td>
                        <td><?= $k['ngay_het_han'] ? e(fmt_date($k['ngay_het_han'])) : '<span class="muted">Không</span>' ?></td>
                        <td><?php if ($k['nguoi_nhan']): ?><?= e($k['nguoi_nhan']) ?><span class="sub">@<?= e($k['nguoi_nhan_dn']) ?> · <?= e(fmt_datetime($k['ngay_nhan_ma'])) ?></span><?php else: ?><span class="muted">Chưa có</span><?php endif; ?></td>
                        <td>
                            <?php if ($state === 'available'): ?>
                                <form method="post" action="<?= e(app_url($base . '/' . (int)$k['ma'] . '/revoke')) ?>" data-confirm="Thu hồi mã #<?= (int)$k['ma'] ?>? Mã sẽ không dùng được nữa.">
                                    <?= csrf_field() ?><?= return_field() ?>
                                    <button class="link-btn neg" type="submit">Thu hồi</button>
                                </form>
                            <?php endif; ?>
                        </td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
        <?php endif; ?>
        <?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
    </section>

    <section class="panel span-4" id="generate" aria-labelledby="gen-h">
        <header><h2 id="gen-h">Tạo mã</h2></header>
        <form class="form" method="post" action="<?= e(app_url($base)) ?>">
            <?= csrf_field() ?>
            <div class="field">
                <label for="k-count">Số lượng</label>
                <input class="input" id="k-count" type="number" name="so_luong" min="1" max="<?= (int)$batch ?>" required value="<?= e(old('so_luong', '10')) ?>">
                <span class="hint">Tối đa <?= (int)$batch ?> mã mỗi lần.</span>
            </div>
            <div class="field">
                <label for="k-exp">Hết hạn sau ngày</label>
                <input class="input" id="k-exp" type="date" name="ngay_het_han" min="<?= e(date('Y-m-d', strtotime('+1 day'))) ?>" value="<?= e(old('ngay_het_han')) ?>">
                <span class="hint">Bỏ trống: không hết hạn. Mã dùng được đến hết ngày đã chọn.</span>
            </div>
            <div class="form-actions"><button class="btn primary" type="submit">Tạo mã</button></div>
        </form>
    </section>
</div>
