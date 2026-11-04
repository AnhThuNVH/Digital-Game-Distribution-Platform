<div class="auth">
    <form class="auth-card" method="post" action="<?= e(app_url('/auth/register')) ?>">
        <?= csrf_field() ?>
        <div>
            <h1>Tạo tài khoản</h1>
            <p class="muted lede">Một tài khoản để chơi, mua, đánh giá và đăng trò chơi của riêng bạn.</p>
        </div>
        <div class="field">
            <label for="display_name">Tên hiển thị</label>
            <input class="input" id="display_name" name="display_name" value="<?= e(old('display_name')) ?>" required maxlength="100" autocomplete="nickname">
        </div>
        <div class="field">
            <label for="username">Tên đăng nhập</label>
            <input class="input" id="username" name="username" value="<?= e(old('username')) ?>" required minlength="3" maxlength="30" pattern="[A-Za-z0-9_]{3,30}" autocomplete="username">
            <span class="hint">3–30 ký tự: chữ không dấu, số hoặc dấu gạch dưới. Dùng cho địa chỉ hồ sơ của bạn.</span>
        </div>
        <div class="field">
            <label for="email">Email</label>
            <input class="input" id="email" type="email" name="email" value="<?= e(old('email')) ?>" required maxlength="254" autocomplete="email">
        </div>
        <div class="field">
            <label for="password">Mật khẩu</label>
            <input class="input" id="password" type="password" name="password" required minlength="8" maxlength="72" autocomplete="new-password">
            <span class="hint">Ít nhất 8 ký tự.</span>
        </div>
        <div class="field">
            <label for="confirm_password">Nhập lại mật khẩu</label>
            <input class="input" id="confirm_password" type="password" name="confirm_password" required minlength="8" maxlength="72" autocomplete="new-password">
        </div>
        <button class="btn primary block" type="submit">Tạo tài khoản</button>
        <p class="switch-line">Đã có tài khoản? <a href="<?= e(app_url('/auth/login')) ?>">Đăng nhập</a></p>
    </form>
</div>
