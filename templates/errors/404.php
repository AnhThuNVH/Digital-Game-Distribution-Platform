<div class="auth">
    <div class="auth-card">
        <span class="faint">Lỗi <?= (int)($status ?? 404) ?></span>
        <h1><?= e($pageTitle ?? 'Đã có lỗi') ?></h1>
        <p class="muted"><?= e($message) ?></p>
        <div class="form-actions">
            <a class="btn primary" href="<?= e(app_url('/')) ?>">Về trang chủ</a>
            <a class="btn" href="<?= e(app_url('/games')) ?>">Khám phá trò chơi</a>
        </div>
    </div>
</div>
