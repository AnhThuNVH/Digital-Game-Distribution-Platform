<?php
/** Developer overview. @var array $balances @var array $games @var array $traffic @var array $recent @var bool $hasAccount */
?>
<div class="title-row">
    <div><h1>Tổng quan nhà phát triển</h1><p class="sub">Doanh thu, lưu lượng 30 ngày qua và các dự án bạn tham gia.</p></div>
    <a class="btn primary" href="<?= e(app_url('/dev/games/new')) ?>">Tạo dự án</a>
</div>

<section class="kpis" aria-label="Số dư">
    <div class="kpi"><div class="kpi-label">Có thể rút</div><div class="kpi-value"><?= e(money($balances['available'])) ?></div><div class="delta"><a class="link" href="<?= e(app_url('/dev/payouts')) ?>"><?= $hasAccount ? 'Yêu cầu chi trả' : 'Thêm tài khoản nhận tiền' ?></a></div></div>
    <div class="kpi"><div class="kpi-label">Đang giữ</div><div class="kpi-value"><?= e(money($balances['pending'])) ?></div><div class="delta">Giữ <?= (int)PAYOUT_HOLD_DAYS ?> ngày để xử lý hoàn tiền</div></div>
    <div class="kpi"><div class="kpi-label">Đã chi trả</div><div class="kpi-value"><?= e(money($balances['paid'])) ?></div></div>
    <div class="kpi"><div class="kpi-label">Doanh thu gộp</div><div class="kpi-value"><?= e(money($balances['gross'])) ?></div><div class="delta">Phí nền tảng <?= e(money($balances['fee'])) ?></div></div>
</section>

<div class="grid top section">
    <section class="panel span-8" aria-labelledby="games-h">
        <header><h2 id="games-h">Dự án</h2><span class="meta"><a class="link" href="<?= e(app_url('/dev/games')) ?>">Quản lý tất cả</a></span></header>
        <?php if (!$games): ?>
            <div class="empty"><p>Bạn chưa có dự án nào.</p><a class="btn primary" href="<?= e(app_url('/dev/games/new')) ?>">Tạo dự án đầu tiên</a></div>
        <?php else: ?>
            <div class="rows">
                <?php foreach (array_slice($games, 0, 8) as $g): ?>
                    <div class="row">
                        <div class="cell-game grow">
                            <?php if ($g['anh_bia']): ?><img src="<?= e(app_media_url($g['anh_bia'])) ?>" alt="" loading="lazy"><?php else: ?><span class="thumb"></span><?php endif; ?>
                            <div><a class="link" href="<?= e(app_url('/dev/games/' . (int)$g['ma'])) ?>"><?= e($g['tieu_de']) ?></a><span class="sub"><?= fmt_int((int)$g['so_huu']) ?> người sở hữu · <?= fmt_int((int)$g['luot_xem_30']) ?> lượt xem 30 ngày</span></div>
                        </div>
                        <?= status_pill('game_status', $g['trang_thai']) ?>
                    </div>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </section>

    <div class="span-4 stack">
        <section class="panel" aria-labelledby="traffic-h">
            <header><h2 id="traffic-h">30 ngày qua</h2></header>
            <dl class="facts">
                <dt>Lượt xem trang</dt><dd><?= fmt_int($traffic['views']) ?></dd>
                <dt>Lượt tải xuống</dt><dd><?= fmt_int($traffic['downloads']) ?></dd>
                <dt>Lượt mua</dt><dd><?= fmt_int($traffic['purchases']) ?></dd>
                <dt>Doanh thu gộp</dt><dd><?= e(money($traffic['revenue'])) ?></dd>
            </dl>
        </section>
        <section class="panel" aria-labelledby="recent-h">
            <header><h2 id="recent-h">Giao dịch gần đây</h2><span class="meta"><a class="link" href="<?= e(app_url('/dev/sales')) ?>">Xem tất cả</a></span></header>
            <?php if (!$recent): ?><p class="muted">Chưa có giao dịch nào.</p><?php endif; ?>
            <div class="rows">
                <?php foreach ($recent as $r): ?>
                    <div class="row"><div class="grow"><?= e($r['tieu_de_luc_mua']) ?><span class="sub"><?= e(fmt_date($r['ngay_dat_hang'])) ?> · <?= e(label('ledger_status', $r['trang_thai'])) ?></span></div><span><?= e(money($r['so_tien_thuc_nhan'])) ?></span></div>
                <?php endforeach; ?>
            </div>
        </section>
    </div>
</div>
