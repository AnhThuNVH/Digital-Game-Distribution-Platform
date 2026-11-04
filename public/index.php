<?php
// =============================================================================
// PUBLIC ENTRY POINT - bootstrap, CSRF gate, routes, error pages
// =============================================================================

require_once dirname(__DIR__) . '/config/config.php';

spl_autoload_register(function (string $class): void {
    foreach (['core', 'controllers', 'models'] as $directory) {
        $file = dirname(__DIR__) . DIRECTORY_SEPARATOR . $directory . DIRECTORY_SEPARATOR . $class . '.php';
        if (is_file($file)) {
            require_once $file;
            return;
        }
    }
});

// Form values remembered by the previous request are readable for exactly one page view.
$_SESSION['old_input_view'] = $_SESSION['old_input'] ?? [];
unset($_SESSION['old_input']);

function render_error_page(int $status, string $title, string $message): void {
    http_response_code($status);
    try {
        echo (new View())->render('errors/error', ['status' => $status, 'message' => $message, 'pageTitle' => $title], 'layout');
    } catch (Throwable $inner) {
        error_log('Error page failed: ' . $inner->getMessage());
        echo '<!doctype html><meta charset="utf-8"><title>' . e($title) . '</title><p>' . e($message) . '</p>';
    }
}

set_exception_handler(function (Throwable $error): void {
    error_log('Unhandled ' . get_class($error) . ': ' . $error->getMessage() . ' @ ' . $error->getFile() . ':' . $error->getLine());
    while (ob_get_level() > 0) {
        ob_end_clean();
    }
    $message = APP_DEBUG ? $error->getMessage() : 'Đã có lỗi xảy ra phía máy chủ. Vui lòng thử lại sau.';
    render_error_page(500, 'Lỗi máy chủ', $message);
});

$method = strtoupper($_SERVER['REQUEST_METHOD'] ?? 'GET');

// One CSRF gate for every state-changing request.
if (in_array($method, ['POST', 'PUT', 'PATCH', 'DELETE'], true)) {
    $token = $_POST['csrf_token'] ?? ($_SERVER['HTTP_X_CSRF_TOKEN'] ?? '');
    if (!csrf_valid(is_string($token) ? $token : '')) {
        $path = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?: '/';
        if (str_contains($path, '/api/')) {
            http_response_code(419);
            header('Content-Type: application/json; charset=utf-8');
            echo json_encode(['error' => 'csrf_invalid'], JSON_UNESCAPED_UNICODE);
            exit;
        }
        flash('error', 'Phiên gửi biểu mẫu đã hết hạn hoặc không hợp lệ. Vui lòng thử lại.');
        $referer = (string)($_SERVER['HTTP_REFERER'] ?? '');
        $refPath = parse_url($referer, PHP_URL_PATH);
        $refHost = parse_url($referer, PHP_URL_HOST);
        $sameHost = $refHost === null || $refHost === ($_SERVER['HTTP_HOST'] ?? '') || $refHost === parse_url('http://' . ($_SERVER['HTTP_HOST'] ?? ''), PHP_URL_HOST);
        $target = ($sameHost && is_string($refPath) && $refPath !== '') ? $refPath : app_url('/');
        header('Location: ' . $target, true, 303);
        exit;
    }
}

$router = new Router();

// ----------------------------------------------------------- store ----------
$router->get('/', 'StoreController@home');
$router->get('/games', 'GameController@index');
$router->get('/games/{slug}', 'GameController@show');
$router->post('/games/{slug}/claim', 'GameController@claim');
$router->post('/games/{slug}/wishlist', 'GameController@wishlist');
$router->post('/games/{slug}/follow', 'GameController@follow');
$router->post('/games/{slug}/reviews', 'ReviewController@save');
$router->post('/games/{slug}/reviews/delete', 'ReviewController@delete');
$router->post('/reviews/{id}/vote', 'ReviewController@vote');
$router->post('/games/{slug}/comments', 'CommentController@create');
$router->post('/comments/{id}/delete', 'CommentController@delete');
$router->get('/games/{slug}/devlogs', 'DevlogController@index');
$router->get('/games/{slug}/devlogs/{post}', 'DevlogController@show');
$router->post('/games/{slug}/devlogs/{post}/comments', 'DevlogController@comment');
$router->post('/devlog-comments/{id}/delete', 'DevlogController@deleteComment');
$router->get('/games/{slug}/downloads', 'DownloadController@index');
$router->get('/games/{slug}/download/{link}', 'DownloadController@go');
$router->get('/bundles', 'BundleController@index');
$router->get('/bundles/{slug}', 'BundleController@show');
$router->post('/reports', 'ReportController@create');

// ------------------------------------------------------- people -------------
$router->get('/u/{username}', 'ProfileController@show');
$router->post('/u/{username}/follow', 'ProfileController@follow');
$router->get('/author/{id}', 'ProfileController@legacy');
$router->get('/avatars/{id}', 'AvatarController@show');

// --------------------------------------------------------- auth -------------
$router->get('/auth/login', 'AuthController@showLogin');
$router->post('/auth/login', 'AuthController@login');
$router->get('/auth/register', 'AuthController@showRegister');
$router->post('/auth/register', 'AuthController@register');
$router->post('/auth/logout', 'AuthController@logout');

// ------------------------------------------------------- player -------------
$router->get('/library', 'LibraryController@index');
$router->get('/wishlist', 'LibraryController@wishlist');
$router->post('/keys/redeem', 'LibraryController@redeem');
$router->get('/notifications', 'NotificationController@index');
$router->post('/notifications/read-all', 'NotificationController@readAll');
$router->post('/notifications/{id}/read', 'NotificationController@read');
$router->get('/settings', 'SettingsController@index');
$router->post('/settings/profile', 'SettingsController@profile');
$router->post('/settings/password', 'SettingsController@password');
$router->post('/settings/privacy', 'SettingsController@privacy');
$router->post('/settings/developer', 'SettingsController@developer');
$router->get('/account', 'SettingsController@legacy');
$router->get('/account/profile', 'SettingsController@legacy');

$router->get('/cart', 'CartController@index');
$router->post('/cart/add', 'CartController@add');
$router->post('/cart/items/{id}/remove', 'CartController@remove');
$router->post('/cart/coupon', 'CartController@applyCoupon');
$router->post('/cart/coupon/remove', 'CartController@removeCoupon');
$router->post('/cart/checkout', 'CartController@checkout');
$router->get('/orders', 'OrderController@index');
$router->get('/orders/{code}', 'OrderController@show');
$router->post('/orders/{code}/refund', 'OrderController@requestRefund');

$router->get('/collections', 'CollectionController@index');
$router->post('/collections', 'CollectionController@create');
$router->get('/collections/{id}', 'CollectionController@show');
$router->post('/collections/{id}', 'CollectionController@update');
$router->post('/collections/{id}/delete', 'CollectionController@delete');
$router->post('/collections/{id}/items', 'CollectionController@addItem');
$router->post('/collections/{id}/items/{game}/remove', 'CollectionController@removeItem');

// ---------------------------------------------------- community -------------
$router->get('/forums', 'ForumController@index');
$router->post('/forums', 'ForumController@create');
$router->get('/forums/{id}', 'ForumController@show');
$router->get('/forums/{id}/topics/new', 'ForumController@newTopic');
$router->post('/forums/{id}/topics', 'ForumController@createTopic');
$router->get('/forums/{id}/topics/{topic}', 'ForumController@topic');
$router->post('/forums/{id}/topics/{topic}/posts', 'ForumController@reply');
$router->post('/forums/{id}/topics/{topic}/moderate', 'ForumController@moderateTopic');
$router->post('/posts/{id}/react', 'ForumController@react');
$router->post('/posts/{id}/edit', 'ForumController@editPost');
$router->post('/posts/{id}/delete', 'ForumController@deletePost');

$router->get('/jams', 'JamController@index');
$router->get('/jams/{slug}', 'JamController@show');
$router->post('/jams/{slug}/entries', 'JamController@submit');
$router->post('/jams/{slug}/entries/{entry}/withdraw', 'JamController@withdraw');
$router->post('/jams/{slug}/entries/{entry}/vote', 'JamController@vote');

// ---------------------------------------------------- developer -------------
$router->get('/dev', 'DevController@overview');
$router->get('/dev/games', 'DevGameController@index');
$router->get('/dev/games/new', 'DevGameController@create');
$router->post('/dev/games', 'DevGameController@store');
$router->get('/dev/games/{id}', 'DevGameController@edit');
$router->post('/dev/games/{id}', 'DevGameController@update');
$router->get('/dev/games/{id}/media', 'DevGameController@media');
$router->post('/dev/games/{id}/media', 'DevGameController@addMedia');
$router->post('/dev/games/{id}/media/{media}', 'DevGameController@updateMedia');
$router->post('/dev/games/{id}/media/{media}/delete', 'DevGameController@deleteMedia');
$router->get('/dev/games/{id}/downloads', 'DownloadController@manage');
$router->post('/dev/games/{id}/downloads', 'DownloadController@addLink');
$router->post('/dev/games/{id}/downloads/{link}', 'DownloadController@updateLink');
$router->post('/dev/games/{id}/downloads/{link}/approve', 'DownloadController@approveLink');
$router->post('/dev/games/{id}/downloads/{link}/reject', 'DownloadController@rejectLink');
$router->post('/dev/games/{id}/downloads/{link}/delete', 'DownloadController@deleteLink');
$router->get('/dev/games/{id}/authors', 'DevGameController@authors');
$router->post('/dev/games/{id}/authors', 'DevGameController@saveAuthors');
$router->get('/dev/games/{id}/releases', 'DevGameController@releases');
$router->post('/dev/games/{id}/releases', 'DevGameController@addRelease');
$router->post('/dev/games/{id}/releases/{release}', 'DevGameController@updateRelease');
$router->post('/dev/games/{id}/releases/{release}/delete', 'DevGameController@deleteRelease');
$router->get('/dev/games/{id}/devlogs', 'DevGameController@devlogs');
$router->get('/dev/games/{id}/devlogs/new', 'DevGameController@newDevlog');
$router->post('/dev/games/{id}/devlogs', 'DevGameController@storeDevlog');
$router->get('/dev/games/{id}/devlogs/{post}', 'DevGameController@editDevlog');
$router->post('/dev/games/{id}/devlogs/{post}', 'DevGameController@updateDevlog');
$router->get('/dev/games/{id}/page', 'DevGameController@design');
$router->post('/dev/games/{id}/page', 'DevGameController@saveDesign');
$router->get('/dev/games/{id}/keys', 'DevGameController@keys');
$router->post('/dev/games/{id}/keys', 'DevGameController@generateKeys');
$router->post('/dev/games/{id}/keys/{key}/revoke', 'DevGameController@revokeKey');
$router->get('/dev/games/{id}/stats', 'DevGameController@stats');
$router->get('/dev/sales', 'DevController@sales');
$router->get('/dev/payouts', 'DevController@payouts');
$router->post('/dev/payouts/accounts', 'DevController@addPayoutAccount');
$router->post('/dev/payouts/accounts/{id}/default', 'DevController@defaultPayoutAccount');
$router->post('/dev/payouts/request', 'DevController@requestPayout');
$router->get('/dev/coupons', 'CouponController@devIndex');
$router->post('/dev/coupons', 'CouponController@devStore');
$router->post('/dev/coupons/{id}/toggle', 'CouponController@devToggle');
$router->get('/dev/bundles', 'BundleAdminController@devIndex');
$router->get('/dev/bundles/new', 'BundleAdminController@devCreate');
$router->post('/dev/bundles', 'BundleAdminController@devStore');
$router->get('/dev/bundles/{id}', 'BundleAdminController@devEdit');
$router->post('/dev/bundles/{id}', 'BundleAdminController@devUpdate');

// ---------------------------------------------------- staff -----------------
$router->get('/admin', 'AdminController@dashboard');
$router->get('/admin/users', 'AdminController@users');
$router->get('/admin/users/{id}', 'AdminController@user');
$router->post('/admin/users/{id}/roles', 'AdminController@updateRoles');
$router->post('/admin/users/{id}/status', 'AdminController@updateUserStatus');
$router->post('/admin/users/{id}/grant', 'AdminController@grantGame');
$router->get('/admin/games', 'AdminController@games');
$router->post('/admin/games/{id}/status', 'AdminController@updateGameStatus');
$router->get('/admin/reports', 'ModerationController@reports');
$router->get('/admin/reports/{id}', 'ModerationController@report');
$router->post('/admin/reports/{id}', 'ModerationController@resolve');
$router->get('/admin/moderation', 'ModerationController@log');
$router->get('/admin/comments', 'ModerationController@content');
$router->post('/admin/content/{type}/{id}', 'ModerationController@setContentStatus');
$router->get('/admin/campaigns', 'CampaignController@index');
$router->get('/admin/campaigns/new', 'CampaignController@create');
$router->post('/admin/campaigns', 'CampaignController@store');
$router->get('/admin/campaigns/{id}', 'CampaignController@edit');
$router->post('/admin/campaigns/{id}', 'CampaignController@update');
$router->get('/admin/coupons', 'CouponController@adminIndex');
$router->post('/admin/coupons', 'CouponController@adminStore');
$router->post('/admin/coupons/{id}/toggle', 'CouponController@adminToggle');
$router->get('/admin/bundles', 'BundleAdminController@adminIndex');
$router->get('/admin/bundles/new', 'BundleAdminController@adminCreate');
$router->post('/admin/bundles', 'BundleAdminController@adminStore');
$router->get('/admin/bundles/{id}', 'BundleAdminController@adminEdit');
$router->post('/admin/bundles/{id}', 'BundleAdminController@adminUpdate');
$router->get('/admin/orders', 'FinanceController@orders');
$router->get('/admin/refunds', 'FinanceController@refunds');
$router->post('/admin/refunds/{id}', 'FinanceController@decideRefund');
$router->get('/admin/payouts', 'FinanceController@payouts');
$router->post('/admin/payouts/{id}', 'FinanceController@decidePayout');
$router->post('/admin/payout-accounts/{id}', 'FinanceController@decideAccount');
$router->get('/admin/jams', 'JamAdminController@index');
$router->get('/admin/jams/new', 'JamAdminController@create');
$router->post('/admin/jams', 'JamAdminController@store');
$router->get('/admin/jams/{id}', 'JamAdminController@edit');
$router->post('/admin/jams/{id}', 'JamAdminController@update');
$router->post('/admin/jams/{id}/members', 'JamAdminController@addMember');
$router->post('/admin/jams/{id}/members/{user}/remove', 'JamAdminController@removeMember');
$router->post('/admin/jams/{id}/entries/{entry}', 'JamAdminController@entryStatus');
$router->get('/admin/taxonomy', 'TaxonomyController@index');
$router->post('/admin/taxonomy/{kind}', 'TaxonomyController@store');
$router->post('/admin/taxonomy/{kind}/{id}', 'TaxonomyController@update');
$router->post('/admin/taxonomy/{kind}/{id}/delete', 'TaxonomyController@delete');
$router->get('/admin/audit', 'AdminController@audit');

// ------------------------------------------------------ dispatch ------------
$result = $router->dispatch($_SERVER['REQUEST_URI'] ?? '/', $method);
if (!$result) {
    render_error_page(404, 'Không tìm thấy', 'Trang bạn tìm không tồn tại hoặc đã được di chuyển.');
    exit;
}

[$handler, $params] = $result;
[$controllerName, $methodName] = explode('@', $handler, 2);
if (!class_exists($controllerName) || !method_exists($controllerName, $methodName)) {
    render_error_page(404, 'Không tìm thấy', 'Trang bạn tìm không tồn tại hoặc đã được di chuyển.');
    exit;
}
(new $controllerName())->$methodName($params);
