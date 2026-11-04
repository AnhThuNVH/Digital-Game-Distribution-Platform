<div class="auth">
    <form class="auth-card" method="post" action="<?= e(app_url('/auth/login')) ?>">
        <?= csrf_field() ?>
        <div>
            <h1>Đăng nhập</h1>
            <p class="muted lede">Truy cập thư viện, giỏ hàng và cộng đồng của bạn.</p>
        </div>
        <div class="field">
            <label for="login">Email hoặc tên đăng nhập</label>
            <input class="input" id="login" name="login" value="<?= e(old('login')) ?>" required maxlength="254" autocomplete="username" autofocus>
        </div>
        <div class="field">
            <label for="password">Mật khẩu</label>
            <input class="input" id="password" type="password" name="password" required maxlength="72" autocomplete="current-password">
        </div>
        <button class="btn primary block" type="submit">Đăng nhập</button>
        <p class="switch-line"><a href="<?= e(app_url('/auth/forgot-password')) ?>">Quên mật khẩu?</a></p>
        <p class="switch-line">Chưa có tài khoản? <a href="<?= e(app_url('/auth/register')) ?>">Tạo tài khoản</a></p>
    </form>
</div>
