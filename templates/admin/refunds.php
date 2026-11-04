<?php
/** Refund queue. @var string $status @var array $counts @var array $refunds @var int $total @var int $page @var int $pages */
?>
<div class="title-row">
    <div><h1>Hoàn tiền</h1><p class="sub">Duyệt yêu cầu hoàn tiền trong <?= (int)REFUND_WINDOW_DAYS ?> ngày sau thanh toán. Duyệt sẽ hoàn tiền, đảo doanh thu của nhà phát triển và thu hồi quyền sở hữu.</p></div>
</div>

<nav class="chips chips-row" aria-label="Lọc theo trạng thái">
    <?php foreach (labels('refund_status') as $k => $t): if ($k !== 'requested' && empty($counts[$k])) continue; ?>
        <a class="chip"<?= $status === $k ? ' aria-current="true"' : '' ?> href="<?= e(app_url('/admin/refunds' . qs(['status' => $k, 'page' => null]))) ?>"><?= e($t) ?> <span class="muted"><?= fmt_int((int)($counts[$k] ?? 0)) ?></span></a>
    <?php endforeach; ?>
    <a class="chip"<?= $status === '' ? ' aria-current="true"' : '' ?> href="<?= e(app_url('/admin/refunds' . qs(['status' => '', 'page' => null]))) ?>">Tất cả <span class="muted"><?= fmt_int(array_sum(array_map('intval', $counts))) ?></span></a>
</nav>

<?php if ($refunds): ?>
<section class="panel">
    <div class="rows">
        <?php foreach ($refunds as $r): $rid = (int)$r['ma']; ?>
            <div class="row" id="refund-<?= $rid ?>">
                <div class="grow">
                    <div><?= e($r['tieu_de_luc_mua'] ?? 'Toàn bộ đơn') ?> · <strong><?= e(money($r['so_tien'])) ?></strong></div>
                    <span class="sub">Đơn <?= e($r['ma_don_hang']) ?> · <?php if ($r['nguoi_yeu_cau_id']): ?><a class="link" href="<?= e(app_url('/admin/users/' . (int)$r['nguoi_yeu_cau_id'])) ?>"><?= e($r['buyer_name']) ?></a><?php else: ?>Tài khoản đã xóa<?php endif; ?> · gửi <?= e(fmt_datetime($r['ngay_tao'])) ?><?= $r['ngay_xu_ly'] ? ' · xử lý ' . e(fmt_datetime($r['ngay_xu_ly'])) : '' ?></span>
                    <?php if ((string)$r['ly_do'] !== ''): ?><p class="well"><?= nl2br(e($r['ly_do'])) ?></p><?php endif; ?>
                </div>
                <div class="stack">
                    <?= status_pill('refund_status', $r['trang_thai']) ?>
                    <?php if ($r['trang_thai'] === 'requested'): ?>
                        <details class="edit">
                            <summary class="link-btn">Xử lý</summary>
                            <form class="form well" method="post" action="<?= e(app_url('/admin/refunds/' . $rid)) ?>" data-confirm="Xác nhận quyết định hoàn tiền <?= e(money($r['so_tien'])) ?>?">
                                <?= csrf_field() ?><?= return_field() ?>
                                <fieldset class="field">
                                    <legend>Quyết định</legend>
                                    <label class="check"><input type="radio" name="quyet_dinh" value="approve" required> <span>Duyệt và hoàn tiền</span></label>
                                    <label class="check"><input type="radio" name="quyet_dinh" value="reject"> <span>Từ chối</span></label>
                                </fieldset>
                                <div class="field"><label for="rn-<?= $rid ?>">Ghi chú cho người mua</label><textarea class="input" id="rn-<?= $rid ?>" name="ghi_chu" maxlength="1000"></textarea><span class="hint">Bắt buộc khi từ chối.</span></div>
                                <button class="btn sm primary" type="submit">Xác nhận</button>
                            </form>
                        </details>
                    <?php endif; ?>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
</section>
<?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
<?php else: ?>
    <div class="empty"><p><?= $status === 'requested' ? 'Không có yêu cầu hoàn tiền nào đang chờ.' : 'Không có yêu cầu nào ở trạng thái này.' ?></p></div>
<?php endif; ?>
