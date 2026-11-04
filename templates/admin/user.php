<?php
/** Admin user detail. @var array $account @var array $roles @var array $userRoles @var array $owned @var array $created @var array $stats @var array $actions @var array $grantable @var bool $isSelf */
$id = (int)$account['ma'];
$base = '/admin/users/' . $id;
?>
<nav class="crumbs" aria-label="Đường dẫn"><a href="<?= e(app_url('/admin/users')) ?>">Người dùng</a><span><?= e($account['ten_hien_thi']) ?></span></nav>

<div class="title-row">
    <div class="cluster">
        <img class="avatar lg" src="<?= e(avatar_url($account)) ?>" alt="">
        <div><h1><?= e($account['ten_hien_thi']) ?></h1><p class="sub">@<?= e($account['ten_dang_nhap']) ?> · <?= e($account['email']) ?> · <?= status_pill('user_status', $account['trang_thai']) ?></p></div>
    </div>
    <?php if ($account['trang_thai'] === 'active'): ?><a class="btn" href="<?= e(profile_url($account)) ?>">Xem hồ sơ công khai</a><?php endif; ?>
</div>

<section class="kpis" aria-label="Hoạt động">
    <div class="kpi"><div class="kpi-label">Trò chơi sở hữu</div><div class="kpi-value"><?= fmt_int(count(array_filter($owned, static fn($o) => $o['trang_thai'] === 'active'))) ?></div></div>
    <div class="kpi"><div class="kpi-label">Đơn hàng</div><div class="kpi-value"><?= fmt_int((int)$stats['don_hang']) ?></div></div>
    <div class="kpi"><div class="kpi-label">Đánh giá đã viết</div><div class="kpi-value"><?= fmt_int((int)$stats['danh_gia']) ?></div></div>
    <div class="kpi"><div class="kpi-label">Bị báo cáo</div><div class="kpi-value"><?= fmt_int((int)$stats['bi_bao_cao']) ?></div></div>
</section>

<div class="grid top section">
    <div class="span-5 stack">
        <section class="panel" id="info" aria-labelledby="info-h">
            <header><h2 id="info-h">Thông tin tài khoản</h2></header>
            <dl class="facts">
                <dt>Mã</dt><dd><?= $id ?></dd>
                <dt>Ngày tạo</dt><dd><?= e(fmt_datetime($account['ngay_tao'])) ?></dd>
                <dt>Cập nhật</dt><dd><?= e(fmt_datetime($account['ngay_cap_nhat'])) ?></dd>
                <dt>Xác minh email</dt><dd><?= $account['ngay_xac_minh_email'] ? e(fmt_datetime($account['ngay_xac_minh_email'])) : 'Chưa xác minh' ?></dd>
                <dt>Website</dt><dd><?= $account['url_website'] ? '<a class="link" href="' . e($account['url_website']) . '" target="_blank" rel="noopener noreferrer nofollow">' . e($account['url_website']) . '</a>' : '—' ?></dd>
                <dt>Đã báo cáo</dt><dd><?= fmt_int((int)$stats['da_bao_cao']) ?> nội dung</dd>
            </dl>
        </section>

        <section class="panel" id="roles" aria-labelledby="roles-h">
            <header><h2 id="roles-h">Vai trò</h2></header>
            <form class="form" method="post" action="<?= e(app_url($base . '/roles')) ?>">
                <?= csrf_field() ?>
                <?php foreach ($roles as $r): $code = $r['ma_vai_tro']; $lock = $isSelf && $code === 'admin'; ?>
                    <label class="check"><input type="checkbox" name="vai_tro[]" value="<?= e($code) ?>"<?= in_array($code, $userRoles, true) ? ' checked' : '' ?><?= $lock ? ' disabled' : '' ?>> <span><?= e(label('role', $code)) ?><?php if ($lock): ?><span class="sub">Bạn không thể tự gỡ quyền quản trị.</span><?php endif; ?></span></label>
                    <?php if ($lock): ?><input type="hidden" name="vai_tro[]" value="admin"><?php endif; ?>
                <?php endforeach; ?>
                <div class="form-actions"><button class="btn" type="submit">Lưu vai trò</button></div>
            </form>
        </section>

        <section class="panel" id="status" aria-labelledby="status-h">
            <header><h2 id="status-h">Trạng thái</h2></header>
            <?php if ($account['trang_thai'] === 'deleted'): ?>
                <p class="muted">Tài khoản đã bị xóa bởi người dùng; không thể khôi phục tại đây.</p>
            <?php elseif ($account['trang_thai'] === 'active'): ?>
                <?php if ($isSelf): ?><p class="muted">Bạn không thể tự đình chỉ tài khoản của mình.</p><?php else: ?>
                <form class="form" method="post" action="<?= e(app_url($base . '/status')) ?>" data-confirm="Đình chỉ <?= e($account['ten_hien_thi']) ?>? Người này sẽ không đăng nhập được.">
                    <?= csrf_field() ?><input type="hidden" name="trang_thai" value="suspended">
                    <div class="field"><label for="s-reason">Lý do đình chỉ</label><textarea class="input" id="s-reason" name="ly_do" maxlength="1000" required><?= e(old('ly_do')) ?></textarea><span class="hint">Lưu vào nhật ký kiểm duyệt.</span></div>
                    <div class="form-actions"><button class="btn danger" type="submit">Đình chỉ tài khoản</button></div>
                </form>
                <?php endif; ?>
            <?php else: ?>
                <form class="form" method="post" action="<?= e(app_url($base . '/status')) ?>">
                    <?= csrf_field() ?><input type="hidden" name="trang_thai" value="active">
                    <div class="field"><label for="s-reason">Ghi chú (không bắt buộc)</label><textarea class="input" id="s-reason" name="ly_do" maxlength="1000"><?= e(old('ly_do')) ?></textarea></div>
                    <div class="form-actions"><button class="btn primary" type="submit">Khôi phục tài khoản</button></div>
                </form>
            <?php endif; ?>
        </section>
    </div>

    <div class="span-7 stack">
        <section class="panel" id="library" aria-labelledby="lib-h">
            <header><h2 id="lib-h">Thư viện</h2><span class="meta"><?= fmt_int(count($owned)) ?> mục</span></header>
            <?php if ($account['trang_thai'] === 'active' && $grantable): ?>
                <form class="form inline-add" method="post" action="<?= e(app_url($base . '/grant')) ?>">
                    <?= csrf_field() ?>
                    <div class="field"><label for="g-game">Cấp quyền sở hữu</label>
                        <select class="input" id="g-game" name="tro_choi_id" required>
                            <option value="">Chọn trò chơi…</option>
                            <?php foreach ($grantable as $g): ?><option value="<?= (int)$g['ma'] ?>"><?= e($g['tieu_de']) ?></option><?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-actions"><button class="btn" type="submit">Cấp quyền</button></div>
                </form>
            <?php endif; ?>
            <?php if (!$owned): ?><p class="muted">Chưa sở hữu trò chơi nào.</p><?php endif; ?>
            <div class="rows">
                <?php foreach ($owned as $o): ?>
                    <div class="row">
                        <div class="grow"><a class="link" href="<?= e(game_url($o)) ?>"><?= e($o['tieu_de']) ?></a><span class="sub"><?= e(label('ownership', $o['loai_nhan_quyen'])) ?> · <?= e(fmt_date($o['ngay_nhan_quyen'])) ?></span></div>
                        <?php if ($o['trang_thai'] !== 'active'): ?><span class="pill neg"><?= $o['trang_thai'] === 'refunded' ? 'Đã hoàn tiền' : 'Đã thu hồi' ?></span><?php endif; ?>
                    </div>
                <?php endforeach; ?>
            </div>
        </section>

        <?php if ($created): ?>
        <section class="panel" aria-labelledby="created-h">
            <header><h2 id="created-h">Dự án đã tạo</h2><span class="meta"><?= fmt_int(count($created)) ?> dự án</span></header>
            <div class="rows">
                <?php foreach ($created as $g): ?>
                    <div class="row">
                        <div class="grow"><a class="link" href="<?= e(app_url('/admin/games?q=' . (int)$g['ma'])) ?>"><?= e($g['tieu_de']) ?></a><span class="sub">/games/<?= e($g['duong_dan_rut_gon']) ?></span></div>
                        <?= status_pill('game_status', $g['trang_thai']) ?>
                    </div>
                <?php endforeach; ?>
            </div>
        </section>
        <?php endif; ?>

        <section class="panel" aria-labelledby="mod-h">
            <header><h2 id="mod-h">Lịch sử kiểm duyệt</h2></header>
            <?php if (!$actions): ?><p class="muted">Chưa có thao tác nào với tài khoản này.</p><?php endif; ?>
            <div class="rows">
                <?php foreach ($actions as $a): ?>
                    <div class="row">
                        <div class="grow"><?= e(label('mod_action', $a['loai_hanh_dong'])) ?><span class="sub"><?= e($a['ten_hien_thi']) ?> · <?= e(fmt_datetime($a['ngay_tao'])) ?><?= (string)$a['ly_do'] !== '' ? ' · ' . e($a['ly_do']) : '' ?></span></div>
                    </div>
                <?php endforeach; ?>
            </div>
        </section>
    </div>
</div>
