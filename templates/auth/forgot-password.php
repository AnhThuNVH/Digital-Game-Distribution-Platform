<div class="auth">
    <form class="auth-card" method="post" action="<?= e(app_url('/auth/forgot-password')) ?>">
        <?= csrf_field() ?>
        <div>
            <h1>Quên mật khẩu</h1>
            <p class="muted lede">Nhập email của bạn, chúng tôi sẽ gửi một mã xác nhận 6 chữ số để đặt lại mật khẩu.</p>
        </div>
        <div class="field">
            <label for="email">Email</label>
            <input class="input" id="email" type="email" name="email" value="<?= e(old('email')) ?>" required maxlength="254" autocomplete="email" autofocus>
        </div>
        <button class="btn primary block" type="submit">Gửi mã xác nhận</button>
        <p class="switch-line">Đã nhớ mật khẩu? <a href="<?= e(app_url('/auth/login')) ?>">Đăng nhập</a></p>
    </form>
</div>
