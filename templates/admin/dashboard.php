<?php
/** Staff overview. @var bool $isAdmin @var array $kpis @var array $reviewQueue @var array $reports @var array $actions @var array $newUsers */
?>
<div class="title-row">
    <div><h1>Tổng quan quản trị</h1><p class="sub">Hàng đợi cần xử lý và các thao tác kiểm duyệt gần nhất.</p></div>
</div>

<section class="kpis" aria-label="Chỉ số chính">
    <div class="kpi"><div class="kpi-label">Tài khoản hoạt động</div><div class="kpi-value"><?= fmt_int($kpis['users']) ?></div></div>
    <div class="kpi"><div class="kpi-label">Trò chơi đã công bố</div><div class="kpi-value"><?= fmt_int($kpis['games']) ?></div></div>
    <div class="kpi"><div class="kpi-label">Chờ duyệt</div><div class="kpi-value"><a class="link" href="<?= e(app_url('/admin/games?status=under_review')) ?>"><?= fmt_int($kpis['review']) ?></a></div></div>
    <div class="kpi"><div class="kpi-label">Báo cáo chưa xử lý</div><div class="kpi-value"><a class="link" href="<?= e(app_url('/admin/reports')) ?>"><?= fmt_int($kpis['reports']) ?></a></div></div>
    <?php if ($isAdmin): ?>
        <div class="kpi"><div class="kpi-label">Yêu cầu hoàn tiền</div><div class="kpi-value"><a class="link" href="<?= e(app_url('/admin/refunds')) ?>"><?= fmt_int($kpis['refunds']) ?></a></div></div>
        <div class="kpi"><div class="kpi-label">Yêu cầu chi trả</div><div class="kpi-value"><a class="link" href="<?= e(app_url('/admin/payouts')) ?>"><?= fmt_int($kpis['payouts']) ?></a></div></div>
    <?php endif; ?>
</section>

<div class="grid top section">
    <section class="panel span-6" aria-labelledby="queue-h">
        <header><h2 id="queue-h">Trò chơi chờ duyệt</h2><a class="link meta" href="<?= e(app_url('/admin/games?status=under_review')) ?>">Xem tất cả</a></header>
        <?php if (!$reviewQueue): ?><p class="muted">Không có trò chơi nào đang chờ.</p><?php endif; ?>
        <div class="rows">
            <?php foreach ($reviewQueue as $g): ?>
                <div class="row">
                    <div class="grow"><a class="link" href="<?= e(app_url('/admin/games?q=' . rawurlencode($g['duong_dan_rut_gon']))) ?>"><?= e($g['tieu_de']) ?></a><span class="sub"><?= e($g['ten_hien_thi']) ?> · cập nhật <?= e(fmt_datetime($g['ngay_cap_nhat'])) ?></span></div>
                </div>
            <?php endforeach; ?>
        </div>
    </section>

    <section class="panel span-6" aria-labelledby="reports-h">
        <header><h2 id="reports-h">Báo cáo chưa xử lý</h2><a class="link meta" href="<?= e(app_url('/admin/reports')) ?>">Mở hàng đợi</a></header>
        <?php if (!$reports): ?><p class="muted">Không có báo cáo nào chưa xử lý.</p><?php endif; ?>
        <div class="rows">
            <?php foreach ($reports as $r): ?>
                <div class="row">
                    <div class="grow"><a class="link" href="<?= e(app_url('/admin/reports/' . (int)$r['ma'])) ?>"><?= e(label('report_target', $r['loai_doi_tuong'])) ?> #<?= (int)$r['doi_tuong_id'] ?> · <?= e(label('report_reason', $r['ma_ly_do'])) ?></a><span class="sub"><?= e($r['ten_hien_thi'] ?? 'Tài khoản đã xóa') ?> · <?= e(fmt_datetime($r['ngay_tao'])) ?></span></div>
                    <?= status_pill('report_status', $r['trang_thai']) ?>
                </div>
            <?php endforeach; ?>
        </div>
    </section>

    <section class="panel <?= $isAdmin ? 'span-7' : 'span-12' ?>" aria-labelledby="actions-h">
        <header><h2 id="actions-h">Thao tác kiểm duyệt gần đây</h2><a class="link meta" href="<?= e(app_url('/admin/moderation')) ?>">Toàn bộ nhật ký</a></header>
        <?php if (!$actions): ?><p class="muted">Chưa có thao tác nào.</p><?php endif; ?>
        <div class="rows">
            <?php foreach ($actions as $a): ?>
                <div class="row">
                    <div class="grow"><?= e(label('mod_action', $a['loai_hanh_dong'])) ?> · <a class="link" href="<?= e(app_url(mod_target_url($a['loai_doi_tuong'], (int)$a['doi_tuong_id']))) ?>"><?= e(label('report_target', $a['loai_doi_tuong'])) ?> #<?= (int)$a['doi_tuong_id'] ?></a><span class="sub"><?= e($a['ten_hien_thi']) ?> · <?= e(fmt_datetime($a['ngay_tao'])) ?><?= (string)$a['ly_do'] !== '' ? ' · ' . e(excerpt((string)$a['ly_do'], 90)) : '' ?></span></div>
                </div>
            <?php endforeach; ?>
        </div>
    </section>

    <?php if ($isAdmin): ?>
    <section class="panel span-5" aria-labelledby="new-users-h">
        <header><h2 id="new-users-h">Tài khoản mới</h2><a class="link meta" href="<?= e(app_url('/admin/users')) ?>">Quản lý người dùng</a></header>
        <div class="rows">
            <?php foreach ($newUsers as $u): ?>
                <div class="row">
                    <img class="avatar" src="<?= e(avatar_url($u)) ?>" alt="" loading="lazy">
                    <div class="grow"><a class="link" href="<?= e(app_url('/admin/users/' . (int)$u['ma'])) ?>"><?= e($u['ten_hien_thi']) ?></a><span class="sub">@<?= e($u['ten_dang_nhap']) ?> · <?= e(fmt_date($u['ngay_tao'])) ?></span></div>
                    <?= status_pill('user_status', $u['trang_thai']) ?>
                </div>
            <?php endforeach; ?>
        </div>
    </section>
    <?php endif; ?>
</div>
