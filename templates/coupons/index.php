<?php
/** Coupon list and create form, shared by developers and administrators. @var string $scope @var array $coupons @var int $gameCount */
$isAdmin = $scope === 'admin';
$base = $isAdmin ? '/admin/coupons' : '/dev/coupons';
$amount = static fn(array $c): string => $c['loai_giam_gia'] === 'percent'
    ? rtrim(rtrim(number_format((float)$c['gia_tri_giam_gia'], 2, ',', ''), '0'), ',') . '%'
    : money((float)$c['gia_tri_giam_gia']);
$type = old('loai_giam_gia', 'percent');
?>
<div class="title-row">
    <div>
        <h1>Mã giảm giá</h1>
        <p class="sub"><?= $isAdmin
            ? 'Mã do quản trị viên tạo giảm giá cho cả giỏ hàng. Mã do nhà phát triển tạo chỉ giảm giá trò chơi của họ.'
            : 'Mã của bạn chỉ giảm giá các trò chơi bạn là tác giả, kể cả khi người mua có trò chơi khác trong giỏ.' ?></p>
    </div>
</div>

<div class="grid top">
    <section class="panel span-8" aria-labelledby="list-h">
        <header><h2 id="list-h"><?= $isAdmin ? 'Tất cả mã' : 'Mã của bạn' ?></h2><span class="meta"><?= fmt_int($total) ?> mã</span></header>
        <?php if (!$coupons): ?>
            <div class="empty"><p>Chưa có mã giảm giá nào.</p></div>
        <?php else: ?>
        <div class="table-wrap">
            <table>
                <thead><tr>
                    <th scope="col">Mã</th><th scope="col">Giảm</th><th scope="col" class="num">Đã dùng</th><th scope="col">Hiệu lực</th>
                    <th scope="col">Trạng thái</th><th scope="col" class="num">Tổng đã giảm</th><th scope="col"><span class="sr-only">Thao tác</span></th>
                </tr></thead>
                <tbody>
                <?php foreach ($coupons as $c): $state = CouponModel::state($c); $on = (int)$c['dang_hoat_dong'] === 1; ?>
                    <tr>
                        <td><code><?= e($c['ma_uu_dai']) ?></code>
                            <?php if ($isAdmin): ?><span class="sub"><?= (int)$c['toan_cua_hang'] ? 'Toàn cửa hàng' : 'Chỉ trò chơi của' ?><?= $c['nguoi_tao_dn'] ? ' · @' . e($c['nguoi_tao_dn']) : '' ?></span><?php endif; ?>
                        </td>
                        <td><?= e($amount($c)) ?></td>
                        <td class="num"><?= fmt_int((int)$c['so_luot_da_dung']) ?><?= $c['so_luot_dung_toi_da'] !== null ? '/' . fmt_int((int)$c['so_luot_dung_toi_da']) : '' ?></td>
                        <td class="when"><?php if (!$c['ngay_bat_dau'] && !$c['ngay_ket_thuc']): ?><span class="muted">Không giới hạn</span><?php else: ?>
                            <?= $c['ngay_bat_dau'] ? 'Từ ' . e(fmt_datetime($c['ngay_bat_dau'])) : 'Từ khi tạo' ?><span class="sub"><?= $c['ngay_ket_thuc'] ? 'đến ' . e(fmt_datetime($c['ngay_ket_thuc'])) : 'không hết hạn' ?></span>
                        <?php endif; ?></td>
                        <td><?= status_pill('coupon_state', $state) ?></td>
                        <td class="num"><?= e(money((float)$c['tong_giam'])) ?></td>
                        <td>
                            <form method="post" action="<?= e(app_url($base . '/' . (int)$c['ma'] . '/toggle')) ?>"<?= $on ? ' data-confirm="Tắt mã ' . e($c['ma_uu_dai']) . '? Người mua sẽ không áp dụng được mã này nữa."' : '' ?>>
                                <?= csrf_field() ?><?= return_field() ?>
                                <button class="link-btn<?= $on ? ' neg' : '' ?>" type="submit"><?= $on ? 'Tắt' : 'Bật' ?></button>
                            </form>
                        </td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
        <?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
        <?php endif; ?>
    </section>

    <section class="panel span-4" id="new" aria-labelledby="new-h">
        <header><h2 id="new-h">Tạo mã</h2></header>
        <?php if (!$isAdmin && $gameCount === 0): ?>
            <p class="hint">Bạn chưa là tác giả của trò chơi nào nên mã sẽ chưa giảm giá được gì cho đến khi có trò chơi.</p>
        <?php endif; ?>
        <form class="form" method="post" action="<?= e(app_url($base)) ?>">
            <?= csrf_field() ?>
            <div class="field">
                <label for="cp-code">Mã</label>
                <input class="input" id="cp-code" name="ma_uu_dai" required minlength="4" maxlength="40" pattern="[A-Za-z0-9_\-]{4,40}" autocomplete="off" spellcheck="false" value="<?= e(old('ma_uu_dai')) ?>">
                <span class="hint">4–40 ký tự: chữ không dấu, số, gạch ngang, gạch dưới. Tự chuyển thành chữ in hoa.</span>
            </div>
            <fieldset class="field">
                <legend>Loại giảm giá</legend>
                <div class="choice-grid">
                    <label class="check"><input type="radio" name="loai_giam_gia" value="percent"<?= $type === 'percent' ? ' checked' : '' ?>> <span>Phần trăm<span class="sub">Từ 0,01 đến 100%.</span></span></label>
                    <label class="check"><input type="radio" name="loai_giam_gia" value="fixed_amount"<?= $type === 'fixed_amount' ? ' checked' : '' ?>> <span>Số tiền<span class="sub">Tính bằng <?= e(APP_CURRENCY) ?>, không vượt quá giá trị đơn.</span></span></label>
                </div>
            </fieldset>
            <div class="field">
                <label for="cp-value">Mức giảm</label>
                <input class="input" id="cp-value" name="gia_tri_giam_gia" required inputmode="decimal" pattern="\d{1,9}([.,]\d{1,2})?" value="<?= e(old('gia_tri_giam_gia')) ?>">
            </div>
            <div class="field">
                <label for="cp-max">Số lượt dùng tối đa</label>
                <input class="input" id="cp-max" type="number" name="so_luot_dung_toi_da" min="1" max="1000000" value="<?= e(old('so_luot_dung_toi_da')) ?>">
                <span class="hint">Bỏ trống: không giới hạn. Mỗi đơn hàng dùng một lượt.</span>
            </div>
            <div class="field">
                <label for="cp-start">Bắt đầu</label>
                <input class="input" id="cp-start" type="datetime-local" name="ngay_bat_dau" value="<?= e(old('ngay_bat_dau')) ?>">
            </div>
            <div class="field">
                <label for="cp-end">Kết thúc</label>
                <input class="input" id="cp-end" type="datetime-local" name="ngay_ket_thuc" value="<?= e(old('ngay_ket_thuc')) ?>">
                <span class="hint">Bỏ trống cả hai: dùng được ngay và không hết hạn.</span>
            </div>
            <div class="form-actions"><button class="btn primary" type="submit">Tạo mã</button></div>
        </form>
    </section>
</div>
