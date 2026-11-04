<?php
/** Report detail. @var array $report @var ?array $target @var array $options @var array $related @var array $history */
$rid = (int)$report['ma'];
$type = $report['loai_doi_tuong'];
$tid = (int)$report['doi_tuong_id'];
$isOpen = in_array($report['trang_thai'], ['open', 'investigating'], true);
$openRelated = count(array_filter($related, static fn($r) => in_array($r['trang_thai'], ['open', 'investigating'], true)));
?>
<nav class="crumbs" aria-label="Đường dẫn"><a href="<?= e(app_url('/admin/reports')) ?>">Báo cáo vi phạm</a><span>Báo cáo #<?= $rid ?></span></nav>

<div class="title-row">
    <div><h1><?= e(label('report_target', $type)) ?> #<?= $tid ?></h1><p class="sub"><?= e(label('report_reason', $report['ma_ly_do'])) ?> · gửi <?= e(fmt_datetime($report['ngay_tao'])) ?> · <?= status_pill('report_status', $report['trang_thai']) ?></p></div>
    <?php if ($target): ?><a class="btn" href="<?= e(app_url(mod_target_url($type, $tid))) ?>">Mở trong trang quản lý</a><?php endif; ?>
</div>

<div class="grid top section">
    <div class="span-7 stack">
        <section class="panel" aria-labelledby="rep-h">
            <header><h2 id="rep-h">Nội dung báo cáo</h2></header>
            <dl class="facts">
                <dt>Người báo cáo</dt><dd><?= $report['nguoi_bao_cao'] ? e($report['nguoi_bao_cao']) . ' <span class="muted">@' . e($report['nguoi_bao_cao_dn']) . '</span>' : 'Tài khoản đã xóa' ?></dd>
                <dt>Lý do</dt><dd><?= e(label('report_reason', $report['ma_ly_do'])) ?></dd>
                <dt>Người xử lý</dt><dd><?= $report['nguoi_xu_ly'] ? e($report['nguoi_xu_ly']) : 'Chưa có' ?></dd>
                <?php if ($report['ngay_giai_quyet']): ?><dt>Đóng lúc</dt><dd><?= e(fmt_datetime($report['ngay_giai_quyet'])) ?></dd><?php endif; ?>
            </dl>
            <?php if ((string)$report['chi_tiet'] !== ''): ?><div class="well"><?= nl2br(e($report['chi_tiet'])) ?></div><?php else: ?><p class="muted">Người báo cáo không ghi thêm chi tiết.</p><?php endif; ?>
        </section>

        <section class="panel" aria-labelledby="target-h">
            <header><h2 id="target-h">Đối tượng bị báo cáo</h2><?php if ($target): ?><span class="meta"><?= status_pill($type === 'game' ? 'game_status' : ($type === 'user' ? 'user_status' : 'content_status'), $target['trang_thai']) ?></span><?php endif; ?></header>
            <?php if (!$target): ?>
                <p class="muted">Đối tượng này không còn tồn tại. Có thể đóng báo cáo mà không áp dụng biện pháp.</p>
            <?php elseif ($type === 'game'): ?>
                <dl class="facts">
                    <dt>Trò chơi</dt><dd><?php if (in_array($target['trang_thai'], ['published', 'unlisted'], true)): ?><a class="link" href="<?= e(game_url($target)) ?>"><?= e($target['tieu_de']) ?></a><?php else: ?><?= e($target['tieu_de']) ?><?php endif; ?></dd>
                    <dt>Người tạo</dt><dd><?= e($target['ten_hien_thi']) ?> <span class="muted">@<?= e($target['ten_dang_nhap']) ?></span></dd>
                </dl>
                <?php if ((string)$target['mo_ta_ngan'] !== ''): ?><div class="well"><?= e($target['mo_ta_ngan']) ?></div><?php endif; ?>
            <?php elseif ($type === 'user'): ?>
                <div class="row">
                    <img class="avatar lg" src="<?= e(avatar_url($target)) ?>" alt="">
                    <div class="grow"><?php if ($target['trang_thai'] === 'active'): ?><a class="link" href="<?= e(profile_url($target)) ?>"><?= e($target['ten_hien_thi']) ?></a><?php else: ?><?= e($target['ten_hien_thi']) ?><?php endif; ?><span class="sub">@<?= e($target['ten_dang_nhap']) ?></span></div>
                </div>
                <?php if ((string)$target['gioi_thieu'] !== ''): ?><div class="well"><?= nl2br(e($target['gioi_thieu'])) ?></div><?php endif; ?>
            <?php else: ?>
                <dl class="facts">
                    <dt>Tác giả</dt><dd><?= e($target['ten_hien_thi']) ?> <span class="muted">@<?= e($target['ten_dang_nhap']) ?></span></dd>
                    <dt>Thuộc</dt><dd><?= e($target['ngu_canh']) ?></dd>
                    <dt>Đăng lúc</dt><dd><?= e(fmt_datetime($target['ngay_tao'])) ?></dd>
                </dl>
                <div class="well">
                    <?php if ((string)$target['tieu_de'] !== ''): ?><strong><?= e($target['tieu_de']) ?></strong><br><?php endif; ?>
                    <?= nl2br(e(excerpt((string)$target['noi_dung'], 1200))) ?>
                </div>
                <?php if ($target['trang_thai'] === 'published'): ?><p><a class="link" href="<?= e(app_url($target['url'])) ?>">Xem tại trang gốc</a></p><?php endif; ?>
            <?php endif; ?>
        </section>

        <section class="panel" aria-labelledby="hist-h">
            <header><h2 id="hist-h">Lịch sử kiểm duyệt của đối tượng</h2></header>
            <?php if (!$history): ?><p class="muted">Chưa có thao tác kiểm duyệt nào.</p><?php endif; ?>
            <div class="rows">
                <?php foreach ($history as $h): ?>
                    <div class="row"><div class="grow"><?= e(label('mod_action', $h['loai_hanh_dong'])) ?><span class="sub"><?= e($h['ten_hien_thi']) ?> · <?= e(fmt_datetime($h['ngay_tao'])) ?><?= (string)$h['ly_do'] !== '' ? ' · ' . e($h['ly_do']) : '' ?></span></div></div>
                <?php endforeach; ?>
            </div>
        </section>
    </div>

    <div class="span-5 stack">
        <?php if ($isOpen): ?>
            <?php if ($report['trang_thai'] === 'open'): ?>
            <section class="panel" aria-labelledby="claim-h">
                <header><h2 id="claim-h">Nhận xử lý</h2></header>
                <p class="muted">Đánh dấu báo cáo đang được xem xét để các điều hành viên khác không xử lý trùng.</p>
                <form class="form" method="post" action="<?= e(app_url('/admin/reports/' . $rid)) ?>">
                    <?= csrf_field() ?><input type="hidden" name="do" value="investigate">
                    <div class="form-actions"><button class="btn" type="submit">Tôi sẽ xử lý</button></div>
                </form>
            </section>
            <?php endif; ?>

            <section class="panel" aria-labelledby="close-h">
                <header><h2 id="close-h">Đóng báo cáo</h2></header>
                <form class="form" method="post" action="<?= e(app_url('/admin/reports/' . $rid)) ?>">
                    <?= csrf_field() ?>
                    <fieldset class="field">
                        <legend>Kết quả</legend>
                        <label class="check"><input type="radio" name="ket_qua" value="resolved" required<?= old('ket_qua') === 'resolved' ? ' checked' : '' ?>> <span>Vi phạm, đã xử lý</span></label>
                        <label class="check"><input type="radio" name="ket_qua" value="rejected"<?= old('ket_qua') === 'rejected' ? ' checked' : '' ?>> <span>Không vi phạm, bác bỏ</span></label>
                    </fieldset>
                    <?php if ($options): ?>
                    <div class="field"><label for="r-apply">Biện pháp</label>
                        <select class="input" id="r-apply" name="xu_ly">
                            <option value="">Không áp dụng thêm</option>
                            <?php foreach ($options as $k => $t): ?><option value="<?= e($k) ?>"<?= old('xu_ly') === $k ? ' selected' : '' ?>><?= e($t) ?></option><?php endforeach; ?>
                        </select>
                        <span class="hint">Chỉ dùng khi kết quả là "đã xử lý". Thay đổi được ghi nhật ký và báo cho chủ nội dung.</span>
                    </div>
                    <?php endif; ?>
                    <div class="field"><label for="r-note">Ghi chú</label><textarea class="input" id="r-note" name="ghi_chu" maxlength="1000"><?= e(old('ghi_chu')) ?></textarea><span class="hint">Dùng làm lý do của biện pháp. Bắt buộc khi ẩn, gỡ, đình chỉ hoặc cảnh cáo.</span></div>
                    <?php if ($openRelated > 0): ?>
                        <label class="check"><input type="checkbox" name="dong_cung_noi_dung" value="1" checked> <span>Đóng luôn <?= fmt_int($openRelated) ?> báo cáo khác cùng nội dung</span></label>
                    <?php endif; ?>
                    <div class="form-actions"><button class="btn primary" type="submit">Đóng báo cáo</button></div>
                </form>
            </section>
        <?php else: ?>
            <section class="panel"><header><h2>Đã đóng</h2></header><p class="muted">Báo cáo này đã đóng với kết quả "<?= e(label('report_status', $report['trang_thai'])) ?>".</p></section>
        <?php endif; ?>

        <section class="panel" aria-labelledby="rel-h">
            <header><h2 id="rel-h">Báo cáo khác cùng nội dung</h2><span class="meta"><?= fmt_int(count($related)) ?></span></header>
            <?php if (!$related): ?><p class="muted">Chỉ có báo cáo này.</p><?php endif; ?>
            <div class="rows">
                <?php foreach ($related as $o): ?>
                    <div class="row">
                        <div class="grow"><a class="link" href="<?= e(app_url('/admin/reports/' . (int)$o['ma'])) ?>">#<?= (int)$o['ma'] ?> · <?= e(label('report_reason', $o['ma_ly_do'])) ?></a><span class="sub"><?= e($o['ten_hien_thi'] ?? 'Tài khoản đã xóa') ?> · <?= e(fmt_datetime($o['ngay_tao'])) ?></span></div>
                        <?= status_pill('report_status', $o['trang_thai']) ?>
                    </div>
                <?php endforeach; ?>
            </div>
        </section>
    </div>
</div>
