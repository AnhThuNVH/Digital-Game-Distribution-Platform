<?php
/** Jam list. @var array $tabs @var string $tab @var array $counts @var array $jams */
$emptyText = [
    'open' => 'Hiện chưa có cuộc thi nào đang mở hoặc sắp mở.',
    'judging' => 'Không có cuộc thi nào đang trong giai đoạn chấm.',
    'past' => 'Chưa có cuộc thi nào kết thúc.',
    'hidden' => 'Không có cuộc thi nháp hoặc đã hủy.',
];
?>
<div class="title-row">
    <div>
        <h1>Cuộc thi làm game</h1>
        <p class="sub">Làm một trò chơi trong thời gian giới hạn, nộp bài và chấm điểm bài của người khác.</p>
    </div>
    <?php if (is_staff()): ?><a class="btn" href="<?= e(app_url('/admin/jams/new')) ?>">Tạo cuộc thi</a><?php endif; ?>
</div>

<nav class="tabs" aria-label="Lọc cuộc thi">
    <?php foreach ($tabs as $key => $text): ?>
        <a href="<?= e(app_url('/jams' . ($key === 'open' ? '' : '?tab=' . $key))) ?>" aria-selected="<?= $tab === $key ? 'true' : 'false' ?>"><?= e($text) ?><span class="count"><?= fmt_int($counts[$key] ?? 0) ?></span></a>
    <?php endforeach; ?>
</nav>

<?php if ($jams): ?>
    <div class="jam-list">
        <?php foreach ($jams as $j):
            $phase = JamModel::phase($j);
            $url = app_url('/jams/' . rawurlencode($j['duong_dan_rut_gon']));
            ?>
            <a class="jam-card" href="<?= e($url) ?>">
                <div class="grow">
                    <h2><?= e($j['tieu_de']) ?></h2>
                    <p class="sub">Tổ chức bởi <?= e($j['ten_hien_thi']) ?></p>
                    <?php if ($j['mo_ta']): ?><p class="blurb"><?= e(excerpt($j['mo_ta'], 180)) ?></p><?php endif; ?>
                </div>
                <dl class="jam-dates">
                    <dt>Trạng thái</dt><dd><span class="pill<?= $phase === 'submissions' || $phase === 'voting' ? ' pos' : ($phase === 'cancelled' ? ' neg' : '') ?>"><?= e(JamModel::PHASES[$phase]) ?></span></dd>
                    <?php if ($phase === 'upcoming'): ?><dt>Bắt đầu</dt><dd><?= e(fmt_datetime($j['ngay_bat_dau'])) ?></dd>
                    <?php elseif ($phase === 'submissions'): ?><dt>Hạn nộp</dt><dd><?= e(fmt_datetime($j['han_nop_bai'])) ?></dd>
                    <?php elseif ($phase === 'voting' && $j['ngay_ket_thuc_binh_chon']): ?><dt>Hết bình chọn</dt><dd><?= e(fmt_datetime($j['ngay_ket_thuc_binh_chon'])) ?></dd>
                    <?php else: ?><dt>Hạn nộp</dt><dd><?= e(fmt_date($j['han_nop_bai'])) ?></dd><?php endif; ?>
                    <dt>Bài dự thi</dt><dd class="num"><?= fmt_int((int)$j['so_bai']) ?></dd>
                </dl>
            </a>
        <?php endforeach; ?>
    </div>
    <?php partial('pagination', ['page' => $page, 'pages' => $pages, 'total' => $total]); ?>
<?php else: ?>
    <div class="empty"><p><?= e($emptyText[$tab]) ?></p><?php if ($tab !== 'past'): ?><a class="btn" href="<?= e(app_url('/jams?tab=past')) ?>">Xem cuộc thi đã kết thúc</a><?php endif; ?></div>
<?php endif; ?>
