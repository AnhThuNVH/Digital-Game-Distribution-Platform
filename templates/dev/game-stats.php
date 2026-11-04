<?php
/** Project statistics. @var array $game @var string $tab @var array $series @var array $totals @var int $days @var array $lifetime */
$gid = (int)$game['ma'];
$base = '/dev/games/' . $gid . '/stats';
$fmt = static fn(string $col, $v) => $col === 'doanh_thu_gop' ? money((float)$v) : fmt_int((int)$v);
$day = static fn(string $ymd) => date('d/m', strtotime($ymd));
// One chart per measure: the scales differ too much to share an axis.
$charts = [
    'luot_xem_trang'      => 'Lượt xem trang',
    'luot_nhan_tai_xuong' => 'Lượt tải xuống',
    'so_luot_mua'         => 'Lượt mua',
    'doanh_thu_gop'       => 'Doanh thu gộp',
];
/** Smallest 1, 2 or 5 times a power of ten that is at least $v. */
$niceMax = static function (float $v): float {
    if ($v <= 0) return 1;
    $p = 10 ** floor(log10($v));
    foreach ([1, 2, 5, 10] as $m) {
        if ($m * $p >= $v) return $m * $p;
    }
    return 10 * $p;
};
$n = count($series);
$hasData = array_sum(array_map('floatval', $totals)) > 0;
?>
<?php partial('dev-game-tabs', ['game' => $game, 'tab' => $tab]); ?>

<nav class="chips chips-row" aria-label="Khoảng thời gian">
    <?php foreach ([7, 30, 90] as $d): ?>
        <a class="chip"<?= $days === $d ? ' aria-current="true"' : '' ?> href="<?= e(app_url($base . qs(['days' => $d === 30 ? null : $d]))) ?>"><?= $d ?> ngày</a>
    <?php endforeach; ?>
</nav>

<section class="kpis section" aria-label="Tổng <?= $days ?> ngày">
    <?php foreach ($charts as $col => $name): ?>
        <div class="kpi"><div class="kpi-label"><?= e($name) ?></div><div class="kpi-value"><?= e($fmt($col, $totals[$col])) ?></div><div class="delta"><?= $days ?> ngày qua</div></div>
    <?php endforeach; ?>
</section>

<?php if (!$hasData): ?>
    <div class="empty section"><p>Chưa có số liệu trong <?= $days ?> ngày qua. Lượt xem chỉ được ghi khi dự án công khai hoặc không niêm yết, mỗi phiên trình duyệt một lần mỗi ngày.</p></div>
<?php else: ?>
<div class="chart-grid section">
    <?php foreach ($charts as $col => $name):
        $values = array_map(static fn($r) => (float)$r[$col], $series);
        $top = $niceMax(max($values));
        $peak = max($values);
    ?>
        <section class="panel" aria-labelledby="ch-<?= e($col) ?>">
            <header><h2 id="ch-<?= e($col) ?>"><?= e($name) ?> theo ngày</h2><?php if ($peak > 0): ?><span class="meta">Cao nhất <?= e($fmt($col, $peak)) ?></span><?php endif; ?></header>
            <?php if ($peak <= 0): ?>
            <p class="muted">Chưa có số liệu trong <?= $days ?> ngày qua.</p>
            <?php else: ?>
            <div class="chart" role="img" aria-label="<?= e($name) ?> theo ngày, <?= $days ?> ngày qua. Tổng <?= e($fmt($col, $totals[$col])) ?>, cao nhất <?= e($fmt($col, $peak)) ?> trong một ngày. Số liệu từng ngày có trong bảng bên dưới.">
                <div class="chart-y" aria-hidden="true"><span><?= e($fmt($col, $top)) ?></span><span>0</span></div>
                <div>
                    <div class="bars" style="--n: <?= $n ?>">
                        <?php foreach ($series as $i => $r): $val = (float)$r[$col]; $side = $i < $n / 4 ? ' tip-l' : ($i >= $n * 3 / 4 ? ' tip-r' : ''); ?>
                            <div class="col<?= $side ?>" data-tip="<?= e($fmt($col, $val) . ' · ' . fmt_date($r['ngay'])) ?>"><?php if ($val > 0): ?><span class="bar" style="height: <?= round($val / $top * 100, 2) ?>%"></span><?php endif; ?></div>
                        <?php endforeach; ?>
                    </div>
                    <div class="bars-axis" aria-hidden="true"><span><?= e($day($series[0]['ngay'])) ?></span><span><?= e($day($series[intdiv($n, 2)]['ngay'])) ?></span><span><?= e($day($series[$n - 1]['ngay'])) ?></span></div>
                </div>
            </div>
            <?php endif; ?>
        </section>
    <?php endforeach; ?>
</div>

<details class="panel section">
    <summary class="link-btn">Xem số liệu dạng bảng</summary>
    <div class="table-wrap">
        <table>
            <thead><tr><th scope="col">Ngày</th><?php foreach ($charts as $name): ?><th scope="col" class="num"><?= e($name) ?></th><?php endforeach; ?><th scope="col" class="num">Thêm yêu thích</th><th scope="col" class="num">Bình luận</th></tr></thead>
            <tbody>
            <?php foreach (array_reverse($series) as $r): ?>
                <tr>
                    <td><?= e(fmt_date($r['ngay'])) ?></td>
                    <?php foreach (array_keys($charts) as $col): ?><td class="num"><?= e($fmt($col, $r[$col])) ?></td><?php endforeach; ?>
                    <td class="num"><?= fmt_int((int)$r['luot_them_yeu_thich']) ?></td>
                    <td class="num"><?= fmt_int((int)$r['so_luong_binh_luan']) ?></td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</details>
<?php endif; ?>

<section class="panel section" aria-labelledby="life-h">
    <header><h2 id="life-h">Từ trước đến nay</h2></header>
    <dl class="facts">
        <dt>Người sở hữu</dt><dd><?= fmt_int((int)$lifetime['so_huu']) ?></dd>
        <dt>Trong danh sách yêu thích</dt><dd><?= fmt_int((int)$lifetime['yeu_thich']) ?></dd>
        <dt>Người theo dõi</dt><dd><?= fmt_int((int)$lifetime['theo_doi']) ?></dd>
        <dt>Đánh giá</dt><dd><?= fmt_int((int)$lifetime['so_danh_gia']) ?><?= $lifetime['diem_tb'] !== null ? ' · trung bình ' . e(number_format((float)$lifetime['diem_tb'], 1, ',', '')) . '/5' : '' ?></dd>
        <dt>Thêm yêu thích (<?= $days ?> ngày)</dt><dd><?= fmt_int((int)$totals['luot_them_yeu_thich']) ?></dd>
        <dt>Bình luận mới (<?= $days ?> ngày)</dt><dd><?= fmt_int((int)$totals['so_luong_binh_luan']) ?></dd>
    </dl>
</section>
