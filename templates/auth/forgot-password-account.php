<div class="auth">
    <div class="auth-card">
        <div>
            <h1>Kiểm tra tài khoản</h1>
            <p class="muted lede">Đây là tài khoản đăng ký với email <strong><?= e($email) ?></strong>. Xác nhận đúng tài khoản của bạn trước khi tiếp tục.</p>
        </div>
        <div class="account-preview">
            <img class="avatar lg" src="<?= e(avatar_url($user)) ?>" alt="">
            <div class="grow">
                <strong class="account-name">@<?= e($user['ten_dang_nhap']) ?></strong>
                <span class="muted"><?= e($user['ten_hien_thi']) ?></span>
                <span class="muted"><?= e($user['email']) ?></span>
            </div>
        </div>
        <form method="post" action="<?= e(app_url('/auth/forgot-password/send')) ?>">
            <?= csrf_field() ?>
            <input type="hidden" name="email" value="<?= e($email) ?>">
            <button class="btn primary block" type="submit">Tiếp tục quên mật khẩu</button>
        </form>
        <p class="switch-line"><a href="<?= e(app_url('/auth/forgot-password')) ?>">Không phải tài khoản của tôi</a></p>
    </div>
</div>
