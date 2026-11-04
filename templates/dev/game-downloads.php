<?php
/**
 * Download links of a project.
 * @var array $game @var string $tab @var array $links @var array $counts @var string $status
 * @var array $releases @var int $maxLinks
 */
$gid = (int)$game['ma'];
$base = '/dev/games/' . $gid . '/downloads';
$providerSelect = static function (string $id, string $selected): void {
    echo '<select class="input sm" id="' . e($id) . '" name="nha_cung_cap">';
    echo '<option value=""' . ($selected === '' ? ' selected' : '') . '>Tự nhận diện từ đường dẫn</option>';
    foreach (labels('download_provider') as $k => $t) {
        echo '<option value="' . e($k) . '"' . ($selected === $k ? ' selected' : '') . '>' . e($t) . '</option>';
    }
    echo '</select>';
};
$statusTabs = [
    '' => 'Tất cả',
    'pending' => 'Chờ duyệt',
    'active' => 'Đang hoạt động',
    'hidden' => 'Đã ẩn',
    'rejected' => 'Bị từ chối',
];
?>
<?php partial('dev-game-tabs', ['game' => $game, 'tab' => $tab]); ?>

<div class="grid top">
    <section class="panel span-8" aria-labelledby="dl-h">
        <header>
            <h2 id="dl-h">Liên kết tải về</h2>
            <span class="meta"><?= fmt_int((int)($counts['active'] ?? 0)) ?> đang hoạt động<?= ($counts['pending'] ?? 0) > 0 ? ' · ' . fmt_int((int)$counts['pending']) . ' chờ duyệt' : '' ?></span>
        </header>
        <p class="hint">Người chơi đã sở hữu dự án sẽ thấy các liên kết đang hoạt động trong mục Tải về. Đường dẫn thật không xuất hiện trong mã trang: hệ thống đếm lượt tải và ghi nhật ký rồi mới chuyển hướng, nên bạn có thể đổi đường dẫn bất cứ lúc nào.</p>
        <p class="hint">Dự án của bạn cũng có thể chạy thẳng trên trình duyệt: đặt <a class="link" href="<?= e(app_url('/dev/games/' . $gid)) ?>">liên kết chơi trên web</a> để người chơi thấy nút “Chơi trên trình duyệt” bên cạnh các nút tải về.</p>

        <nav class="tabs" aria-label="Lọc liên kết tải về">
            <?php foreach ($statusTabs as $key => $text): ?>
                <a href="<?= e(app_url($base . ($key !== '' ? '?status=' . $key : ''))) ?>"<?= $status === $key ? ' aria-selected="true"' : '' ?>><?= e($text) ?><?= isset($counts[$key]) ? '<span class="count">' . fmt_int((int)$counts[$key]) . '</span>' : '' ?></a>
            <?php endforeach; ?>
        </nav>

        <?php if (!$links): ?>
            <div class="empty"><p><?= $status !== '' ? 'Không có liên kết nào ở trạng thái này.' : 'Chưa có liên kết tải về nào. Thêm Google Drive, OneDrive, Dropbox hoặc bất kỳ đường dẫn nào để người chơi tải dự án.' ?></p></div>
        <?php endif; ?>
        <div class="rows">
            <?php foreach ($links as $l): $lid = (int)$l['ma']; ?>
                <div class="row" id="download-<?= $lid ?>">
                    <div class="grow">
                        <strong><?= e($l['ten_hien_thi']) ?></strong>
                        <?= status_pill('download_provider', $l['nha_cung_cap']) ?>
                        <?= status_pill('download_platform', $l['he_dieu_ke']) ?>
                        <?= status_pill('download_link_status', $l['trang_thai']) ?>
                        <span class="sub">
                            <?= $l['ten_phien_ban'] ? 'Phiên bản ' . e($l['ten_phien_ban']) . ' (' . e(label('channel', $l['kenh_phat_hanh'])) . ')' : 'Không gắn phiên bản' ?>
                            <?= $l['dung_luong'] ? ' · ' . e($l['dung_luong']) : '' ?>
                            · <?= fmt_int((int)$l['so_lan_tai']) ?> lượt tải
                            · thứ tự <?= (int)$l['thu_tu_sap_xep'] ?>
                            <?= $l['nguoi_dong_gop'] ? ' · gửi bởi ' . e($l['nguoi_dong_gop']) : '' ?>
                        </span>
                        <?php if ($l['ghi_chu']): ?><span class="sub"><?= e($l['ghi_chu']) ?></span><?php endif; ?>
                        <?php if ($l['ly_do_tu_choi']): ?><span class="sub neg-text">Lý do từ chối: <?= e($l['ly_do_tu_choi']) ?></span><?php endif; ?>
                        <span class="sub"><a class="link" href="<?= e($l['url_tai']) ?>" target="_blank" rel="noopener noreferrer"><?= e(excerpt($l['url_tai'], 80)) ?></a></span>
                    </div>
                    <div class="cluster">
                        <?php if ($l['trang_thai'] === 'pending'): ?>
                            <form method="post" action="<?= e(app_url($base . '/' . $lid . '/approve')) ?>">
                                <?= csrf_field() ?><button class="btn sm primary" type="submit">Duyệt</button>
                            </form>
                            <details class="edit">
                                <summary class="link-btn">Từ chối</summary>
                                <form class="form well" method="post" action="<?= e(app_url($base . '/' . $lid . '/reject')) ?>">
                                    <?= csrf_field() ?>
                                    <div class="field"><label for="rj-<?= $lid ?>">Lý do</label><input class="input sm" id="rj-<?= $lid ?>" name="ly_do" maxlength="500" required placeholder="Ví dụ: Link không tải được"></div>
                                    <button class="btn sm primary" type="submit">Từ chối</button>
                                </form>
                            </details>
                        <?php endif; ?>
                        <details class="edit">
                            <summary class="link-btn">Sửa</summary>
                            <form class="form well" method="post" action="<?= e(app_url($base . '/' . $lid)) ?>">
                                <?= csrf_field() ?>
                                <div class="field"><label for="du-<?= $lid ?>">Tên hiển thị</label><input class="input sm" id="du-<?= $lid ?>" name="ten_hien_thi" maxlength="200" value="<?= e($l['ten_hien_thi']) ?>"></div>
                                <div class="field"><label for="dp-<?= $lid ?>">Nơi lưu trữ</label><?php $providerSelect('dp-' . $lid, $l['nha_cung_cap']); ?></div>
                                <div class="field"><label for="dk-<?= $lid ?>">Đường dẫn tải về</label><input class="input sm" id="dk-<?= $lid ?>" type="url" name="url_tai" maxlength="1500" required value="<?= e($l['url_tai']) ?>"></div>
                                <div class="field"><label for="dh-<?= $lid ?>">Hệ điều hành</label>
                                    <select class="input sm" id="dh-<?= $lid ?>" name="he_dieu_ke">
                                        <?php foreach (labels('download_platform') as $k => $t): ?>
                                            <option value="<?= e($k) ?>"<?= $l['he_dieu_ke'] === $k ? ' selected' : '' ?>><?= e($t) ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                                <div class="field"><label for="dr-<?= $lid ?>">Phiên bản</label>
                                    <select class="input sm" id="dr-<?= $lid ?>" name="phien_ban_id">
                                        <option value="0">Không gắn</option>
                                        <?php foreach ($releases as $r): ?>
                                            <option value="<?= (int)$r['ma'] ?>"<?= (int)$l['phien_ban_id'] === (int)$r['ma'] ? ' selected' : '' ?>><?= e($r['ten_phien_ban']) ?> (<?= e(label('channel', $r['kenh_phat_hanh'])) ?>)</option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                                <div class="field"><label for="ds-<?= $lid ?>">Dung lượng</label><input class="input sm" id="ds-<?= $lid ?>" name="dung_luong" maxlength="40" value="<?= e((string)$l['dung_luong']) ?>" placeholder="Ví dụ: 850 MB"></div>
                                <div class="field"><label for="dn-<?= $lid ?>">Ghi chú</label><input class="input sm" id="dn-<?= $lid ?>" name="ghi_chu" maxlength="500" value="<?= e((string)$l['ghi_chu']) ?>"></div>
                                <div class="field"><label for="do-<?= $lid ?>">Thứ tự</label><input class="input sm" id="do-<?= $lid ?>" type="number" name="thu_tu_sap_xep" min="0" max="1000" value="<?= (int)$l['thu_tu_sap_xep'] ?>"></div>
                                <label class="check"><input type="checkbox" name="trang_thai" value="active"<?= $l['trang_thai'] === 'active' ? ' checked' : '' ?>> <span>Hiện với người chơi</span></label>
                                <button class="btn sm primary" type="submit">Lưu</button>
                            </form>
                        </details>
                        <form method="post" action="<?= e(app_url($base . '/' . $lid . '/delete')) ?>" data-confirm="Xóa liên kết tải về này?">
                            <?= csrf_field() ?><button class="link-btn neg" type="submit">Xóa</button>
                        </form>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
    </section>

    <?php if (count($links) < $maxLinks): ?>
    <section class="panel span-4" id="add-download" aria-labelledby="add-dl-h">
        <header><h2 id="add-dl-h">Thêm liên kết</h2></header>
        <form class="form" method="post" action="<?= e(app_url($base)) ?>">
            <?= csrf_field() ?>
            <div class="field"><label for="m-title">Tên hiển thị</label><input class="input" id="m-title" name="ten_hien_thi" maxlength="200" value="<?= e(old('ten_hien_thi')) ?>" placeholder="Bỏ trống: dùng tên nơi lưu trữ"><span class="hint">Ví dụ: "Bản Windows 1.2.0".</span></div>
            <div class="field"><label for="m-provider">Nơi lưu trữ</label><?php $providerSelect('m-provider', (string)old('nha_cung_cap', '')); ?><span class="hint">Để trống để hệ thống tự nhận diện từ đường dẫn.</span></div>
            <div class="field"><label for="m-url">Đường dẫn tải về</label><input class="input" id="m-url" type="url" name="url_tai" maxlength="1500" required placeholder="https://" value="<?= e(old('url_tai')) ?>"><span class="hint">Google Drive, OneDrive, Dropbox, MediaFire, MEGA, WeTransfer, GitHub…</span></div>
            <div class="field"><label for="m-platform">Hệ điều hành</label>
                <select class="input" id="m-platform" name="he_dieu_ke">
                    <?php foreach (labels('download_platform') as $k => $t): ?>
                        <option value="<?= e($k) ?>"<?= old('he_dieu_ke', 'any') === $k ? ' selected' : '' ?>><?= e($t) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="field"><label for="m-release">Phiên bản</label>
                <select class="input" id="m-release" name="phien_ban_id">
                    <option value="0">Không gắn</option>
                    <?php foreach ($releases as $r): ?>
                        <option value="<?= (int)$r['ma'] ?>"<?= (int)old('phien_ban_id', 0) === (int)$r['ma'] ? ' selected' : '' ?>><?= e($r['ten_phien_ban']) ?> (<?= e(label('channel', $r['kenh_phat_hanh'])) ?>)</option>
                    <?php endforeach; ?>
                </select>
                <span class="hint">Gắn phiên bản để người chơi biết link này tương ứng bản nào.</span>
            </div>
            <div class="field"><label for="m-size">Dung lượng</label><input class="input" id="m-size" name="dung_luong" maxlength="40" value="<?= e(old('dung_luong')) ?>" placeholder="Ví dụ: 850 MB"></div>
            <div class="field"><label for="m-note">Ghi chú</label><input class="input" id="m-note" name="ghi_chu" maxlength="500" value="<?= e(old('ghi_chu')) ?>" placeholder="Ví dụ: Cần giải nén bằng 7-Zip"></div>
            <div class="field"><label for="m-order">Thứ tự</label><input class="input" id="m-order" type="number" name="thu_tu_sap_xep" min="0" max="1000" value="<?= e(old('thu_tu_sap_xep', (string)count($links))) ?>"></div>
            <div class="form-actions"><button class="btn primary" type="submit">Thêm</button></div>
        </form>
    </section>
    <?php endif; ?>
</div>
