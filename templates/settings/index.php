<?php
/** Account settings. @var array $me @var array $settings @var bool $isDeveloper */
$val = static fn(string $key, $fallback) => old($key, $fallback);
?>
<div class="title-row">
    <div>
        <h1>Cài đặt</h1>
        <p class="sub">Đăng nhập là <strong><?= e($me['ten_dang_nhap']) ?></strong> · <?= e($me['email']) ?> · <a class="link" href="<?= e(profile_url($me)) ?>">Xem hồ sơ công khai</a></p>
    </div>
</div>

<section class="settings-block" id="profile" aria-labelledby="profile-h">
    <div class="about">
        <h2 id="profile-h">Hồ sơ công khai</h2>
        <p>Hiển thị trên trang hồ sơ, đánh giá, bình luận và trang trò chơi bạn phát hành.</p>
    </div>
    <form class="panel form" method="post" action="<?= e(app_url('/settings/profile')) ?>" enctype="multipart/form-data">
        <?= csrf_field() ?>
        <div class="cluster">
            <img class="avatar lg" src="<?= e(avatar_url($me)) ?>" alt="Ảnh đại diện hiện tại">
            <div class="field grow">
                <label for="avatar">Ảnh đại diện</label>
                <input class="input" id="avatar" type="file" name="avatar" accept="image/jpeg,image/png,image/webp,image/gif">
                <span class="hint">JPG, PNG, WebP hoặc GIF, tối đa 2 MB. Ảnh vuông hiển thị đẹp nhất.</span>
                <?php if ($me['url_anh_dai_dien']): ?><label class="check"><input type="checkbox" name="remove_avatar" value="1"> Gỡ ảnh, dùng chữ cái đầu</label><?php endif; ?>
            </div>
        </div>
        <div class="field">
            <label for="cover">Ảnh bìa hồ sơ</label>
            <input class="input" id="cover" type="file" name="cover" accept="image/jpeg,image/png,image/webp,image/gif">
            <span class="hint">Tối đa 5 MB, tỉ lệ khoảng 4:1.<?= $me['url_anh_bia'] ? ' Đang có ảnh bìa.' : '' ?></span>
            <?php if ($me['url_anh_bia']): ?><label class="check"><input type="checkbox" name="remove_cover" value="1"> Gỡ ảnh bìa</label><?php endif; ?>
        </div>
        <div class="form-grid">
            <div class="field">
                <label for="ten_hien_thi">Tên hiển thị</label>
                <input class="input" id="ten_hien_thi" name="ten_hien_thi" value="<?= e($val('ten_hien_thi', $me['ten_hien_thi'])) ?>" required maxlength="100" autocomplete="nickname">
            </div>
            <div class="field">
                <label for="ma_quoc_gia">Quốc gia</label>
                <input class="input" id="ma_quoc_gia" name="ma_quoc_gia" value="<?= e($val('ma_quoc_gia', $me['ma_quoc_gia'])) ?>" maxlength="2" pattern="[A-Za-z]{2}" placeholder="VN" autocomplete="country">
                <span class="hint">Mã 2 chữ cái theo ISO 3166, có thể để trống.</span>
            </div>
            <div class="field full">
                <label for="url_website">Website</label>
                <input class="input" id="url_website" type="url" name="url_website" value="<?= e($val('url_website', $me['url_website'])) ?>" maxlength="500" placeholder="https://" autocomplete="url">
            </div>
            <div class="field full">
                <label for="gioi_thieu">Giới thiệu</label>
                <textarea class="input" id="gioi_thieu" name="gioi_thieu" rows="5" maxlength="2000"><?= e($val('gioi_thieu', $me['gioi_thieu'])) ?></textarea>
                <span class="hint">Tối đa 2000 ký tự, văn bản thuần.</span>
            </div>
        </div>
        <div class="form-actions"><button class="btn primary" type="submit">Lưu hồ sơ</button></div>
    </form>
</section>

<section class="settings-block" id="password" aria-labelledby="password-h">
    <div class="about">
        <h2 id="password-h">Mật khẩu</h2>
        <p>Đổi mật khẩu sẽ tạo phiên đăng nhập mới. Bạn sẽ nhận một thông báo xác nhận.</p>
    </div>
    <form class="panel form" method="post" action="<?= e(app_url('/settings/password')) ?>">
        <?= csrf_field() ?>
        <input type="text" name="username" value="<?= e($me['ten_dang_nhap']) ?>" autocomplete="username" hidden>
        <div class="field">
            <label for="current_password">Mật khẩu hiện tại</label>
            <input class="input" id="current_password" type="password" name="current_password" required maxlength="72" autocomplete="current-password">
        </div>
        <div class="form-grid">
            <div class="field">
                <label for="new_password">Mật khẩu mới</label>
                <input class="input" id="new_password" type="password" name="password" required minlength="8" maxlength="72" autocomplete="new-password">
                <span class="hint">8–72 ký tự.</span>
            </div>
            <div class="field">
                <label for="confirm_password">Nhập lại mật khẩu mới</label>
                <input class="input" id="confirm_password" type="password" name="confirm_password" required minlength="8" maxlength="72" autocomplete="new-password">
            </div>
        </div>
        <div class="form-actions"><button class="btn primary" type="submit">Đổi mật khẩu</button></div>
    </form>
</section>

<section class="settings-block" id="privacy" aria-labelledby="privacy-h">
    <div class="about">
        <h2 id="privacy-h">Quyền riêng tư và tuỳ chọn</h2>
        <p>Hồ sơ riêng tư chỉ hiện tên và ảnh đại diện. Bạn luôn xem được hồ sơ của chính mình.</p>
    </div>
    <form class="panel form" method="post" action="<?= e(app_url('/settings/privacy')) ?>">
        <?= csrf_field() ?>
        <fieldset class="field">
            <legend class="label">Ai xem được hồ sơ</legend>
            <label class="check"><input type="radio" name="pham_vi_hien_thi_ho_so" value="public"<?= $settings['pham_vi_hien_thi_ho_so'] !== 'private' ? ' checked' : '' ?>><span>Mọi người<span class="sub">Giới thiệu, trò chơi đã phát hành, người theo dõi.</span></span></label>
            <label class="check"><input type="radio" name="pham_vi_hien_thi_ho_so" value="private"<?= $settings['pham_vi_hien_thi_ho_so'] === 'private' ? ' checked' : '' ?>><span>Chỉ mình tôi</span></label>
        </fieldset>
        <label class="check"><input type="checkbox" name="hien_thi_game_so_huu" value="1"<?= (int)$settings['hien_thi_game_so_huu'] ? ' checked' : '' ?>><span>Hiện thư viện trò chơi trên hồ sơ<span class="sub">Áp dụng khi hồ sơ ở chế độ công khai.</span></span></label>
        <label class="check"><input type="checkbox" name="cho_phep_nhan_tin" value="1"<?= (int)$settings['cho_phep_nhan_tin'] ? ' checked' : '' ?>><span>Cho phép người khác nhắn tin</span></label>
        <label class="check"><input type="checkbox" name="email_cap_nhat_san_pham" value="1"<?= (int)$settings['email_cap_nhat_san_pham'] ? ' checked' : '' ?>><span>Nhận email khi trò chơi tôi theo dõi có bản cập nhật</span></label>
        <label class="check"><input type="checkbox" name="email_cap_nhat_cong_dong" value="1"<?= (int)$settings['email_cap_nhat_cong_dong'] ? ' checked' : '' ?>><span>Nhận email về diễn đàn và game jam</span></label>
        <div class="form-grid">
            <div class="field">
                <label for="ngon_ngu_uu_tien">Ngôn ngữ</label>
                <select class="input" id="ngon_ngu_uu_tien" name="ngon_ngu_uu_tien">
                    <option value="vi"<?= $settings['ngon_ngu_uu_tien'] !== 'en' ? ' selected' : '' ?>>Tiếng Việt</option>
                    <option value="en"<?= $settings['ngon_ngu_uu_tien'] === 'en' ? ' selected' : '' ?>>English</option>
                </select>
                <span class="hint">Giao diện hiện chỉ có tiếng Việt; lựa chọn được lưu cho email.</span>
            </div>
            <div class="field">
                <label for="tien_te_uu_tien">Tiền tệ hiển thị</label>
                <select class="input" id="tien_te_uu_tien" name="tien_te_uu_tien">
                    <option value="USD"<?= $settings['tien_te_uu_tien'] !== 'VND' ? ' selected' : '' ?>>USD</option>
                    <option value="VND"<?= $settings['tien_te_uu_tien'] === 'VND' ? ' selected' : '' ?>>VND</option>
                </select>
                <span class="hint">Thanh toán luôn tính bằng USD.</span>
            </div>
        </div>
        <div class="form-actions"><button class="btn primary" type="submit">Lưu tuỳ chọn</button></div>
    </form>
</section>

<section class="settings-block" id="developer" aria-labelledby="developer-h">
    <div class="about">
        <h2 id="developer-h">Phát hành trò chơi</h2>
        <p>Nhà phát triển tạo trang trò chơi, tải bản phát hành, phát mã kích hoạt và nhận doanh thu sau phí nền tảng <?= e((string)round(PLATFORM_FEE_RATE * 100)) ?>%.</p>
    </div>
    <?php if ($isDeveloper): ?>
        <div class="panel form">
            <p>Tài khoản của bạn đã có quyền nhà phát triển.</p>
            <div class="form-actions"><a class="btn primary" href="<?= e(app_url('/dev')) ?>">Mở khu nhà phát triển</a></div>
        </div>
    <?php else: ?>
        <form class="panel form" method="post" action="<?= e(app_url('/settings/developer')) ?>">
            <?= csrf_field() ?>
            <label class="check"><input type="checkbox" name="agree" value="1" required><span>Tôi có quyền phát hành nội dung mình tải lên và đồng ý để quản trị viên kiểm duyệt trang trò chơi<span class="sub">Doanh thu được giữ <?= (int)PAYOUT_HOLD_DAYS ?> ngày trước khi có thể rút; người mua được hoàn tiền trong <?= (int)REFUND_WINDOW_DAYS ?> ngày.</span></span></label>
            <div class="form-actions"><button class="btn primary" type="submit">Trở thành nhà phát triển</button></div>
        </form>
    <?php endif; ?>
</section>
