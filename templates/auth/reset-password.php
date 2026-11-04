<div class="auth">
    <form class="auth-card" method="post" action="<?= e(app_url('/auth/reset-password')) ?>">
        <?= csrf_field() ?>
        <div>
            <h1>Đặt lại mật khẩu</h1>
            <p class="muted lede">Nhập mã xác nhận đã nhận qua email và chọn mật khẩu mới.</p>
        </div>
        <div class="field">
            <label for="email">Email</label>
            <input class="input" id="email" type="email" name="email" value="<?= e(old('email') ?: $email) ?>" required maxlength="254" autocomplete="email"<?= $email !== '' ? ' readonly' : '' ?>>
        </div>
        <div class="field">
            <label for="code">Mã xác nhận</label>
            <input class="input" id="code" name="code" value="<?= e(old('code')) ?>" required inputmode="numeric" pattern="[0-9]{6}" maxlength="6" autocomplete="one-time-code" autofocus>
            <span class="hint">Mã gồm 6 chữ số, hết hạn sau 10 phút.</span>
        </div>
        <div class="field">
            <label for="password">Mật khẩu mới</label>
            <input class="input" id="password" type="password" name="password" required minlength="8" maxlength="72" autocomplete="new-password">
            <span class="hint">Ít nhất 8 ký tự.</span>
        </div>
        <div class="field">
            <label for="confirm_password">Nhập lại mật khẩu mới</label>
            <input class="input" id="confirm_password" type="password" name="confirm_password" required minlength="8" maxlength="72" autocomplete="new-password">
        </div>
        <button class="btn primary block" type="submit">Đặt lại mật khẩu</button>
        <p class="switch-line">Chưa nhận được mã? <a href="<?= e(app_url('/auth/forgot-password')) ?>">Gửi lại mã</a></p>
    </form>
</div>
