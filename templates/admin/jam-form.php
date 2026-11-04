<?php
/** Create or edit a jam. @var ?array $jam @var array $members @var array $entries @var ?array $board */
$isNew = $jam === null;
$id = (int)($jam['ma'] ?? 0);
$action = $isNew ? '/admin/jams' : '/admin/jams/' . $id;
$v = static fn(string $key, $default = '') => old($key, $jam[$key] ?? $default);
$dt = static fn(string $key) => old($key, datetime_local($jam[$key] ?? null));
$hosts = count(array_filter($members, static fn($m) => $m['vai_tro_thanh_vien'] === 'host'));
?>
<nav class="crumbs" aria-label="Đường dẫn"><a href="<?= e(app_url('/admin/jams')) ?>">Game jam</a><span><?= $isNew ? 'Tạo mới' : e($jam['tieu_de']) ?></span></nav>

<div class="title-row">
    <div>
        <h1><?= $isNew ? 'Tạo cuộc thi' : e($jam['tieu_de']) ?></h1>
        <?php if (!$isNew): ?><p class="sub">Giai đoạn hiện tại: <?= e(JamModel::PHASES[JamModel::phase($jam)]) ?>. Giai đoạn tự đổi theo lịch; trạng thái chỉ cần đổi khi công bố, hủy hoặc chốt kết quả.</p><?php endif; ?>
    </div>
    <?php if (!$isNew): ?><a class="btn" href="<?= e(app_url('/jams/' . rawurlencode($jam['duong_dan_rut_gon']))) ?>">Xem trang công khai</a><?php endif; ?>
</div>

<section class="panel narrow-panel">
    <form class="form form-grid" method="post" action="<?= e(app_url($action)) ?>">
        <?= csrf_field() ?>
        <div class="field full">
            <label for="j-title">Tên cuộc thi</label>
            <input class="input" id="j-title" name="tieu_de" minlength="3" maxlength="200" required value="<?= e($v('tieu_de')) ?>">
        </div>
        <div class="field">
            <label for="j-slug">Đường dẫn</label>
            <input class="input" id="j-slug" name="duong_dan_rut_gon" maxlength="220" pattern="[a-z0-9]+(-[a-z0-9]+)*" value="<?= e($v('duong_dan_rut_gon')) ?>" placeholder="Tự tạo từ tên nếu bỏ trống">
        </div>
        <div class="field">
            <label for="j-status">Trạng thái</label>
            <select class="input" id="j-status" name="trang_thai">
                <?php foreach (JamModel::STATUSES as $s): ?><option value="<?= e($s) ?>"<?= $v('trang_thai', 'draft') === $s ? ' selected' : '' ?>><?= e(label('jam_status', $s)) ?></option><?php endforeach; ?>
            </select>
            <span class="hint">Bản nháp chỉ ban tổ chức thấy. "Đã kết thúc" công bố bảng xếp hạng.</span>
        </div>
        <div class="field">
            <label for="j-start">Bắt đầu</label>
            <input class="input" id="j-start" type="datetime-local" name="ngay_bat_dau" required value="<?= e($dt('ngay_bat_dau')) ?>">
        </div>
        <div class="field">
            <label for="j-deadline">Hạn nộp bài</label>
            <input class="input" id="j-deadline" type="datetime-local" name="han_nop_bai" required value="<?= e($dt('han_nop_bai')) ?>">
        </div>
        <label class="check full"><input type="checkbox" name="bat_binh_chon" value="1"<?= (int)$v('bat_binh_chon', 1) ? ' checked' : '' ?>> <span>Mở bình chọn công khai<span class="sub">Người dùng đăng nhập chấm 1–5 cho từng tiêu chí: <?= e(implode(', ', JamModel::CRITERIA)) ?>.</span></span></label>
        <div class="field">
            <label for="j-vstart">Mở bình chọn (không bắt buộc)</label>
            <input class="input" id="j-vstart" type="datetime-local" name="ngay_bat_dau_binh_chon" value="<?= e($dt('ngay_bat_dau_binh_chon')) ?>">
            <span class="hint">Bỏ trống: mở ngay sau hạn nộp.</span>
        </div>
        <div class="field">
            <label for="j-vend">Đóng bình chọn (không bắt buộc)</label>
            <input class="input" id="j-vend" type="datetime-local" name="ngay_ket_thuc_binh_chon" value="<?= e($dt('ngay_ket_thuc_binh_chon')) ?>">
        </div>
        <div class="field full">
            <label for="j-desc">Giới thiệu</label>
            <textarea class="input tall" id="j-desc" name="mo_ta" maxlength="20000"><?= e((string)$v('mo_ta')) ?></textarea>
        </div>
        <div class="field full">
            <label for="j-rules">Thể lệ</label>
            <textarea class="input tall" id="j-rules" name="the_le" maxlength="20000"><?= e((string)$v('the_le')) ?></textarea>
        </div>
        <?php if (!$board): ?><label class="check full"><input type="checkbox" name="tao_dien_dan" value="1"<?= $isNew ? ' checked' : '' ?>> Mở diễn đàn thảo luận cho cuộc thi</label>
        <?php else: ?><p class="small muted full">Diễn đàn: <a class="link" href="<?= e(app_url('/forums/' . (int)$board['ma'])) ?>"><?= e($board['tieu_de']) ?></a></p><?php endif; ?>
        <div class="form-actions full"><button class="btn primary" type="submit"><?= $isNew ? 'Tạo cuộc thi' : 'Lưu thay đổi' ?></button></div>
    </form>
</section>

<?php if (!$isNew): ?>
<div class="grid section">
    <section class="panel span-6" id="members" aria-labelledby="members-h">
        <header><h2 id="members-h">Ban tổ chức</h2><span class="meta"><?= fmt_int(count($members)) ?> người</span></header>
        <div class="rows">
            <?php foreach ($members as $m): ?>
                <div class="row">
                    <img class="avatar" src="<?= e(avatar_url($m)) ?>" alt="" loading="lazy">
                    <div class="grow"><a class="link" href="<?= e(profile_url($m)) ?>"><?= e($m['ten_hien_thi']) ?></a><span class="sub">@<?= e($m['ten_dang_nhap']) ?> · <?= e(label('jam_role', $m['vai_tro_thanh_vien'])) ?></span></div>
                    <?php if ($m['vai_tro_thanh_vien'] !== 'host' || $hosts > 1): ?>
                        <form method="post" action="<?= e(app_url('/admin/jams/' . $id . '/members/' . (int)$m['ma'] . '/remove')) ?>" data-confirm="Gỡ <?= e($m['ten_hien_thi']) ?> khỏi ban tổ chức?">
                            <?= csrf_field() ?><button class="link-btn neg" type="submit">Gỡ</button>
                        </form>
                    <?php endif; ?>
                </div>
            <?php endforeach; ?>
        </div>
        <form class="form inline-add" method="post" action="<?= e(app_url('/admin/jams/' . $id . '/members')) ?>">
            <?= csrf_field() ?>
            <div class="field"><label for="m-user">Tên đăng nhập hoặc email</label><input class="input" id="m-user" name="nguoi_dung" required maxlength="190"></div>
            <div class="field"><label for="m-role">Vai trò</label>
                <select class="input" id="m-role" name="vai_tro_thanh_vien"><?php foreach (labels('jam_role') as $r => $t): ?><option value="<?= e($r) ?>"<?= $r === 'judge' ? ' selected' : '' ?>><?= e($t) ?></option><?php endforeach; ?></select>
            </div>
            <div class="form-actions"><button class="btn" type="submit">Thêm hoặc đổi vai trò</button></div>
        </form>
    </section>

    <section class="panel span-6" id="entries" aria-labelledby="entries-h">
        <header><h2 id="entries-h">Bài dự thi</h2><span class="meta"><?= fmt_int(count($entries)) ?> bài</span></header>
        <?php if (!$entries): ?><p class="muted">Chưa có bài nào.</p><?php endif; ?>
        <div class="rows">
            <?php foreach ($entries as $en): $eid = (int)$en['entry_id']; ?>
                <div class="row entry-admin">
                    <div class="grow">
                        <a class="link" href="<?= e(game_url($en)) ?>"><?= e($en['tieu_de']) ?></a>
                        <span class="sub"><?= e($en['nop_ten']) ?> · <?= e(fmt_date($en['ngay_nop'])) ?> · <?= fmt_int((int)$en['so_phieu']) ?> lượt chấm<?= $en['diem_tb'] !== null ? ' · TB ' . number_format((float)$en['diem_tb'], 2, ',', '.') : '' ?></span>
                    </div>
                    <span class="pill<?= $en['entry_status'] === 'disqualified' ? ' neg' : ($en['entry_status'] === 'withdrawn' ? '' : ' pos') ?>"><?= e(['submitted' => 'Đang dự thi', 'withdrawn' => 'Đã rút', 'disqualified' => 'Bị loại'][$en['entry_status']]) ?></span>
                    <?php if ($en['entry_status'] === 'submitted'): ?>
                        <details class="edit">
                            <summary class="link-btn neg">Loại</summary>
                            <form class="form well" method="post" action="<?= e(app_url('/admin/jams/' . $id . '/entries/' . $eid)) ?>">
                                <?= csrf_field() ?><input type="hidden" name="trang_thai" value="disqualified">
                                <div class="field"><label for="dq-<?= $eid ?>">Lý do (gửi cho người nộp)</label><input class="input sm" id="dq-<?= $eid ?>" name="ly_do" maxlength="500" required></div>
                                <button class="btn sm danger" type="submit">Loại bài</button>
                            </form>
                        </details>
                    <?php elseif ($en['entry_status'] === 'disqualified'): ?>
                        <form method="post" action="<?= e(app_url('/admin/jams/' . $id . '/entries/' . $eid)) ?>">
                            <?= csrf_field() ?><input type="hidden" name="trang_thai" value="submitted"><button class="link-btn" type="submit">Khôi phục</button>
                        </form>
                    <?php endif; ?>
                </div>
            <?php endforeach; ?>
        </div>
    </section>
</div>
<?php endif; ?>
