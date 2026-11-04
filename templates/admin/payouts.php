<?php
/** Developer payouts. @var string $status @var array $counts @var array $payouts @var array $accounts @var array $ledger */
$mask = static fn(string $acc): string => mb_strlen($acc) > 4 ? '•••• ' . mb_substr($acc, -4) : $acc;
$ledgerBy = array_column($ledger, null, 'trang_thai');
$net = static fn(string $s): float => (float)($ledgerBy[$s]['net'] ?? 0);
$openCount = (int)($counts['requested'] ?? 0) + (int)($counts['processing'] ?? 0);
?>
<div class="title-row">
    <div><h1>Chi trả cho nhà phát triển</h1><p class="sub">Doanh thu được giữ <?= (int)PAYOUT_HOLD_DAYS ?> ngày rồi mới có thể rút. Nền tảng thu phí <?= rtrim(rtrim(number_format(PLATFORM_FEE_RATE * 100, 1), '0'), '.') ?>%.</p></div>
</div>

<section class="kpis" aria-label="Sổ kế toán">
    <div class="kpi"><div class="kpi-label">Đang giữ</div><div class="kpi-value"><?= e(money($net('pending'))) ?></div></div>
    <div class="kpi"><div class="kpi-label">Có thể rút</div><div class="kpi-value"><?= e(money($net('available'))) ?></div></div>
    <div class="kpi"><div class="kpi-label">Đang chi trả</div><div class="kpi-value"><?= e(money($net('held'))) ?></div></div>
    <div class="kpi"><div class="kpi-label">Đã chi trả</div><div class="kpi-value"><?= e(money($net('paid'))) ?></div></div>
</section>

<nav class="chips chips-row section" aria-label="Lọc theo trạng thái">
    <a class="chip"<?= $status === '' ? ' aria-current="true"' : '' ?> href="<?= e(app_url('/admin/payouts')) ?>">Cần xử lý <span class="muted"><?= fmt_int($openCount) ?></span></a>
    <?php foreach (labels('payout_status') as $k => $t): ?>
        <a class="chip"<?= $status === $k ? ' aria-current="true"' : '' ?> href="<?= e(app_url('/admin/payouts?status=' . $k)) ?>"><?= e($t) ?> <span class="muted"><?= fmt_int((int)($counts[$k] ?? 0)) ?></span></a>
    <?php endforeach; ?>
</nav>

<section class="panel" aria-labelledby="po-h">
    <header><h2 id="po-h">Đợt chi trả</h2></header>
    <?php if (!$payouts): ?><p class="muted"><?= $status === '' ? 'Không có yêu cầu chi trả nào cần xử lý.' : 'Không có đợt chi trả nào ở trạng thái này.' ?></p><?php endif; ?>
    <div class="rows">
        <?php foreach ($payouts as $p): $pid = (int)$p['ma']; ?>
            <div class="row">
                <div class="grow">
                    <div>#<?= $pid ?> · <strong><?= e(money($p['so_tien'])) ?></strong> · <a class="link" href="<?= e(app_url('/admin/users/' . (int)$p['nguoi_dung_id'])) ?>"><?= e($p['ten_hien_thi']) ?></a></div>
                    <span class="sub"><?= e(label('payout_provider', $p['nha_cung_cap'])) ?> · <?= e($p['ten_tai_khoan'] ?: '') ?> <?= e($mask((string)$p['ma_tai_khoan_ben_ngoai'])) ?> · <?= fmt_int((int)$p['so_dong']) ?> dòng sổ · yêu cầu <?= e(fmt_datetime($p['ngay_yeu_cau'])) ?><?= $p['ma_chi_tra_nha_cung_cap'] ? ' · mã ' . e($p['ma_chi_tra_nha_cung_cap']) : '' ?><?= $p['ly_do_that_bai'] ? ' · ' . e($p['ly_do_that_bai']) : '' ?></span>
                </div>
                <div class="stack">
                    <?= status_pill('payout_status', $p['trang_thai']) ?>
                    <?php if (in_array($p['trang_thai'], ['requested', 'processing'], true)): ?>
                        <details class="edit">
                            <summary class="link-btn">Cập nhật</summary>
                            <form class="form well" method="post" action="<?= e(app_url('/admin/payouts/' . $pid)) ?>">
                                <?= csrf_field() ?>
                                <div class="field"><label for="ps-<?= $pid ?>">Trạng thái mới</label>
                                    <select class="input sm" id="ps-<?= $pid ?>" name="trang_thai">
                                        <?php foreach (['processing', 'paid', 'failed', 'cancelled'] as $s): if ($s === $p['trang_thai']) continue; ?><option value="<?= $s ?>"><?= e(label('payout_status', $s)) ?></option><?php endforeach; ?>
                                    </select>
                                </div>
                                <div class="field"><label for="pr-<?= $pid ?>">Mã tham chiếu chuyển khoản</label><input class="input sm" id="pr-<?= $pid ?>" name="ma_tham_chieu" maxlength="190"><span class="hint">Bắt buộc khi đánh dấu đã chi trả.</span></div>
                                <div class="field"><label for="pl-<?= $pid ?>">Lý do</label><input class="input sm" id="pl-<?= $pid ?>" name="ly_do" maxlength="1000"><span class="hint">Bắt buộc khi thất bại hoặc hủy; các dòng sổ trở lại "Có thể rút".</span></div>
                                <button class="btn sm primary" type="submit">Lưu</button>
                            </form>
                        </details>
                    <?php endif; ?>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
    <?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
</section>

<section class="panel section" id="accounts" aria-labelledby="acc-h">
    <header><h2 id="acc-h">Tài khoản nhận tiền</h2><span class="meta"><?= fmt_int(count($accounts)) ?> tài khoản</span></header>
    <?php if (!$accounts): ?><p class="muted">Chưa có nhà phát triển nào thêm tài khoản nhận tiền.</p><?php endif; ?>
    <div class="rows">
        <?php foreach ($accounts as $a): $aid = (int)$a['ma']; ?>
            <div class="row">
                <div class="grow"><?= e(label('payout_provider', $a['nha_cung_cap'])) ?> · <?= e($a['ten_tai_khoan'] ?: 'Không tên') ?> <?= e($mask((string)$a['ma_tai_khoan_ben_ngoai'])) ?><span class="sub"><a class="link" href="<?= e(app_url('/admin/users/' . (int)$a['nguoi_dung_id'])) ?>"><?= e($a['ten_hien_thi']) ?></a> · <?= e($a['ma_tien_te']) ?><?= $a['mac_dinh'] ? ' · mặc định' : '' ?> · thêm <?= e(fmt_date($a['ngay_tao'])) ?></span></div>
                <?= status_pill('payout_account_status', $a['trang_thai']) ?>
                <?php if ($a['trang_thai'] !== 'active'): ?>
                    <form method="post" action="<?= e(app_url('/admin/payout-accounts/' . $aid)) ?>"><?= csrf_field() ?><input type="hidden" name="trang_thai" value="active"><button class="btn sm" type="submit">Xác minh</button></form>
                <?php endif; ?>
                <?php if ($a['trang_thai'] !== 'disabled'): ?>
                    <form method="post" action="<?= e(app_url('/admin/payout-accounts/' . $aid)) ?>" data-confirm="Vô hiệu hóa tài khoản nhận tiền này?"><?= csrf_field() ?><input type="hidden" name="trang_thai" value="disabled"><button class="btn sm danger" type="submit">Vô hiệu</button></form>
                <?php endif; ?>
            </div>
        <?php endforeach; ?>
    </div>
</section>
