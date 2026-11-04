<?php
$user = current_user();
$roles = user_roles();
$isDev = in_array('developer', $roles, true);
$isAdmin = in_array('admin', $roles, true);
$isMod = $isAdmin || in_array('moderator', $roles, true);
$counts = shell_counts();
$flashes = take_flashes();
$pageTitle = isset($pageTitle) && $pageTitle !== '' ? $pageTitle . ' · ' . APP_NAME : APP_NAME;
$searchValue = current_path() === '/games' ? (string)($_GET['q'] ?? '') : '';
?>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= e($pageTitle) ?></title>
    <meta name="description" content="<?= e($metaDescription ?? 'Cửa hàng và cộng đồng trò chơi độc lập: khám phá, mua, sưu tầm và thảo luận.') ?>">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap">
    <link rel="stylesheet" href="<?= e(app_url('/public/assets/app.css')) ?>?v=<?= (int)@filemtime(__DIR__ . '/../public/assets/app.css') ?>">
</head>
<body>
<a class="sr-only" href="#main">Bỏ qua tới nội dung</a>
<div class="app">
    <aside class="sidebar" id="sidebar" aria-label="Điều hướng chính">
        <div class="brand">
            <span class="brand-mark" aria-hidden="true">K</span>
            <a href="<?= e(app_url('/')) ?>"><?= e(APP_NAME) ?></a>
            <span class="spacer"></span>
            <button type="button" class="menu-toggle close" data-menu-close aria-label="Đóng menu">✕</button>
        </div>
        <nav class="nav">
            <div class="group-label">Cửa hàng</div>
            <a class="nav-item" href="<?= e(app_url('/')) ?>"<?= nav_current('/') ?>>Trang chủ</a>
            <a class="nav-item" href="<?= e(app_url('/games')) ?>"<?= nav_current('/games', true) ?>>Khám phá</a>
            <a class="nav-item" href="<?= e(app_url('/games?sale=1')) ?>">Đang giảm giá</a>
            <a class="nav-item" href="<?= e(app_url('/bundles')) ?>"<?= nav_current('/bundles', true) ?>>Gói game</a>

            <div class="group-label">Cộng đồng</div>
            <a class="nav-item" href="<?= e(app_url('/forums')) ?>"<?= nav_current('/forums', true) ?>>Diễn đàn</a>
            <a class="nav-item" href="<?= e(app_url('/jams')) ?>"<?= nav_current('/jams', true) ?>>Game jam</a>
            <a class="nav-item" href="<?= e(app_url('/collections')) ?>"<?= nav_current('/collections', true) ?>>Bộ sưu tập</a>

            <?php if ($user): ?>
                <div class="group-label">Của tôi</div>
                <a class="nav-item" href="<?= e(app_url('/library')) ?>"<?= nav_current('/library') ?>>Thư viện</a>
                <a class="nav-item" href="<?= e(app_url('/wishlist')) ?>"<?= nav_current('/wishlist') ?>>Mong muốn</a>
                <a class="nav-item" href="<?= e(app_url('/orders')) ?>"<?= nav_current('/orders', true) ?>>Đơn hàng</a>
                <a class="nav-item" href="<?= e(app_url('/notifications')) ?>"<?= nav_current('/notifications') ?>>Thông báo<?php if ($counts['unread']): ?><span class="count"><?= fmt_int($counts['unread']) ?></span><?php endif; ?></a>
                <a class="nav-item" href="<?= e(app_url('/settings')) ?>"<?= nav_current('/settings') ?>>Cài đặt</a>
            <?php endif; ?>

            <?php if ($isDev): ?>
                <div class="group-label">Nhà phát triển</div>
                <a class="nav-item" href="<?= e(app_url('/dev')) ?>"<?= nav_current('/dev') ?>>Tổng quan</a>
                <a class="nav-item" href="<?= e(app_url('/dev/games')) ?>"<?= nav_current('/dev/games', true) ?>>Dự án</a>
                <a class="nav-item" href="<?= e(app_url('/dev/sales')) ?>"<?= nav_current('/dev/sales') ?>>Doanh thu</a>
                <a class="nav-item" href="<?= e(app_url('/dev/payouts')) ?>"<?= nav_current('/dev/payouts') ?>>Chi trả</a>
                <a class="nav-item" href="<?= e(app_url('/dev/coupons')) ?>"<?= nav_current('/dev/coupons') ?>>Mã giảm giá</a>
                <a class="nav-item" href="<?= e(app_url('/dev/bundles')) ?>"<?= nav_current('/dev/bundles', true) ?>>Gói game của tôi</a>
            <?php endif; ?>

            <?php if ($isMod): ?>
                <div class="group-label">Quản trị</div>
                <a class="nav-item" href="<?= e(app_url('/admin')) ?>"<?= nav_current('/admin') ?>>Tổng quan</a>
                <a class="nav-item" href="<?= e(app_url('/admin/reports')) ?>"<?= nav_current('/admin/reports', true) ?>>Báo cáo vi phạm</a>
                <a class="nav-item" href="<?= e(app_url('/admin/games')) ?>"<?= nav_current('/admin/games') ?>>Trò chơi</a>
                <a class="nav-item" href="<?= e(app_url('/admin/comments')) ?>"<?= nav_current('/admin/comments') ?>>Nội dung</a>
                <?php if ($isAdmin): ?>
                    <a class="nav-item" href="<?= e(app_url('/admin/users')) ?>"<?= nav_current('/admin/users', true) ?>>Người dùng</a>
                    <a class="nav-item" href="<?= e(app_url('/admin/orders')) ?>"<?= nav_current('/admin/orders') ?>>Đơn hàng</a>
                    <a class="nav-item" href="<?= e(app_url('/admin/refunds')) ?>"<?= nav_current('/admin/refunds') ?>>Hoàn tiền</a>
                    <a class="nav-item" href="<?= e(app_url('/admin/payouts')) ?>"<?= nav_current('/admin/payouts') ?>>Chi trả</a>
                    <a class="nav-item" href="<?= e(app_url('/admin/campaigns')) ?>"<?= nav_current('/admin/campaigns', true) ?>>Chiến dịch giảm giá</a>
                    <a class="nav-item" href="<?= e(app_url('/admin/coupons')) ?>"<?= nav_current('/admin/coupons') ?>>Mã giảm giá</a>
                    <a class="nav-item" href="<?= e(app_url('/admin/bundles')) ?>"<?= nav_current('/admin/bundles', true) ?>>Gói game</a>
                    <a class="nav-item" href="<?= e(app_url('/admin/jams')) ?>"<?= nav_current('/admin/jams', true) ?>>Game jam</a>
                    <a class="nav-item" href="<?= e(app_url('/admin/taxonomy')) ?>"<?= nav_current('/admin/taxonomy') ?>>Danh mục</a>
                    <a class="nav-item" href="<?= e(app_url('/admin/audit')) ?>"<?= nav_current('/admin/audit') ?>>Nhật ký hệ thống</a>
                <?php endif; ?>
                <a class="nav-item" href="<?= e(app_url('/admin/moderation')) ?>"<?= nav_current('/admin/moderation') ?>>Lịch sử kiểm duyệt</a>
            <?php endif; ?>
        </nav>
        <div class="bottom">Thanh toán trên nền tảng này là môi trường thử nghiệm (sandbox). Không có tiền thật được thu.</div>
    </aside>

    <div class="main">
        <header class="topbar">
            <button type="button" class="menu-toggle" data-menu-open aria-controls="sidebar" aria-expanded="false" aria-label="Mở menu">
                <svg width="20" height="20" viewBox="0 0 20 20" aria-hidden="true"><path d="M3 6h14M3 10h14M3 14h14" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/></svg>
            </button>
            <form class="search" action="<?= e(app_url('/games')) ?>" method="get" role="search">
                <label class="sr-only" for="top-search">Tìm trò chơi</label>
                <input class="input" id="top-search" type="search" name="q" value="<?= e($searchValue) ?>" placeholder="Tìm trò chơi, thẻ…" maxlength="100">
            </form>
            <span class="spacer"></span>
            <nav class="topbar-links" aria-label="Tài khoản">
                <?php if ($user): ?>
                    <a class="top-link hide-mobile" href="<?= e(app_url('/library')) ?>"<?= nav_current('/library') ?>>Thư viện</a>
                    <a class="top-link" href="<?= e(app_url('/cart')) ?>"<?= nav_current('/cart') ?>>Giỏ<span class="hide-mobile">&nbsp;hàng</span><span class="badge"><?= fmt_int($counts['cart']) ?></span></a>
                    <details class="account">
                        <summary aria-label="Menu tài khoản">
                            <img class="avatar" src="<?= e(avatar_url($user)) ?>" alt="">
                            <span class="name"><?= e($user['ten_hien_thi']) ?></span>
                        </summary>
                        <div class="menu">
                            <div class="who"><?= e($user['ten_hien_thi']) ?><span>@<?= e($user['ten_dang_nhap']) ?></span></div>
                            <a href="<?= e(profile_url($user)) ?>">Hồ sơ công khai</a>
                            <a href="<?= e(app_url('/notifications')) ?>">Thông báo<?= $counts['unread'] ? ' (' . fmt_int($counts['unread']) . ')' : '' ?></a>
                            <a href="<?= e(app_url('/collections')) ?>">Bộ sưu tập</a>
                            <a href="<?= e(app_url('/settings')) ?>">Cài đặt</a>
                            <?php if ($isDev): ?><a href="<?= e(app_url('/dev')) ?>">Bảng nhà phát triển</a><?php endif; ?>
                            <?php if ($isMod): ?><a href="<?= e(app_url('/admin')) ?>">Quản trị</a><?php endif; ?>
                            <form method="post" action="<?= e(app_url('/auth/logout')) ?>">
                                <?= csrf_field() ?>
                                <button type="submit">Đăng xuất</button>
                            </form>
                        </div>
                    </details>
                <?php else: ?>
                    <a class="top-link" href="<?= e(app_url('/auth/login')) ?>"<?= nav_current('/auth/login') ?>>Đăng nhập</a>
                    <a class="btn primary" href="<?= e(app_url('/auth/register')) ?>">Tạo tài khoản</a>
                <?php endif; ?>
            </nav>
        </header>

        <main class="canvas" id="main">
            <?php if ($flashes): ?>
                <div class="flashes" role="status">
                    <?php foreach ($flashes as $flash): ?>
                        <div class="flash <?= e($flash['type']) ?>"><?= e($flash['message']) ?></div>
                    <?php endforeach; ?>
                </div>
            <?php endif; ?>
            <?= $content ?>
        </main>

        <footer class="site-foot">
            <span><?= e(APP_FULL_NAME) ?></span>
            <span>Hình ảnh trò chơi thuộc về tác giả tương ứng; nguồn và giấy phép ghi dưới mỗi ảnh.</span>
            <span>Giá hiển thị bằng USD.</span>
        </footer>
    </div>
</div>
<script src="<?= e(app_url('/public/assets/app.js')) ?>?v=<?= (int)@filemtime(__DIR__ . '/../public/assets/app.js') ?>" defer></script>
</body>
</html>
