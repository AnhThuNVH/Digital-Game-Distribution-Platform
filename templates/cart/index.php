<?php
/** Cart. @var array $lines @var ?array $coupon @var array $totals */
?>
<div class="title-row">
    <div>
        <h1>Giỏ hàng</h1>
        <p class="sub"><?= $lines ? fmt_int(count($lines)) . ' sản phẩm' : 'Chưa có sản phẩm nào' ?></p>
    </div>
    <div class="actions"><a class="btn" href="<?= e(app_url('/games')) ?>">Tiếp tục mua sắm</a></div>
</div>

<?php if (!$lines): ?>
    <div class="empty">
        <p>Giỏ hàng của bạn đang trống.</p>
        <a class="btn primary" href="<?= e(app_url('/games')) ?>">Khám phá trò chơi</a>
    </div>
<?php else: ?>
<div class="grid">
    <section class="panel span-8" aria-label="Sản phẩm trong giỏ">
        <div class="cart-lines">
            <?php foreach ($lines as $line): ?>
                <article class="cart-line<?= $line['problem'] ? ' is-blocked' : '' ?>">
                    <a class="thumb" href="<?= e($line['url']) ?>">
                        <?php if ($line['cover']): ?><img src="<?= e(app_media_url($line['cover'])) ?>" alt="<?= e($line['cover_alt'] ?: $line['title']) ?>" loading="lazy" data-fallback="<?= e($line['title']) ?>"><?php else: ?><span class="cover-fallback"><?= e($line['title']) ?></span><?php endif; ?>
                    </a>
                    <div class="body">
                        <h2><a href="<?= e($line['url']) ?>"><?= e($line['title']) ?></a></h2>
                        <p class="small muted">
                            <?php if ($line['type'] === 'bundle'): ?>
                                Gói <?= fmt_int($line['game_count']) ?> trò chơi<?= $line['new_games'] < $line['game_count'] ? ' · bạn đã có ' . fmt_int($line['game_count'] - $line['new_games']) : '' ?>
                            <?php else: ?>
                                <?= e(label('pricing', $line['pricing'])) ?><?= $line['sale_percent'] > 0 ? ' · đang giảm ' . e(rtrim(rtrim(number_format($line['sale_percent'], 2), '0'), '.')) . '%' : '' ?>
                            <?php endif; ?>
                        </p>
                        <?php if ($line['problem']): ?><p class="notice small"><?= e($line['problem']) ?></p><?php endif; ?>
                        <?php if ($line['pricing'] === 'pay_what_you_want' && !$line['problem']): ?>
                            <form method="post" action="<?= e(app_url('/cart/add')) ?>" class="inline-form">
                                <?= csrf_field() ?>
                                <input type="hidden" name="type" value="game">
                                <input type="hidden" name="id" value="<?= (int)$line['id'] ?>">
                                <input type="hidden" name="from" value="cart">
                                <label class="small faint" for="amount-<?= (int)$line['id'] ?>">Số tiền bạn trả</label>
                                <input class="input sm" id="amount-<?= (int)$line['id'] ?>" name="amount" type="number" step="0.01" min="<?= e(number_format($line['min'], 2, '.', '')) ?>" max="1000" value="<?= e(number_format($line['price'], 2, '.', '')) ?>" required>
                                <button class="btn sm" type="submit">Cập nhật</button>
                            </form>
                        <?php endif; ?>
                    </div>
                    <div class="side">
                        <div class="price">
                            <?php if ($line['sale'] > 0 || $line['coupon'] > 0): ?><span class="was"><?= e(money($line['list'])) ?></span><?php endif; ?>
                            <span><?= e(money($line['net'])) ?></span>
                        </div>
                        <?php if ($line['coupon'] > 0): ?><span class="small faint">Mã giảm −<?= e(money($line['coupon'])) ?></span><?php endif; ?>
                        <form method="post" action="<?= e(app_url('/cart/items/' . (int)$line['item_id'] . '/remove')) ?>">
                            <?= csrf_field() ?>
                            <button class="link-btn" type="submit">Bỏ khỏi giỏ</button>
                        </form>
                    </div>
                </article>
            <?php endforeach; ?>
        </div>
    </section>

    <aside class="span-4 stack">
        <section class="panel" aria-labelledby="summary-h">
            <header><h2 id="summary-h">Tóm tắt đơn hàng</h2></header>
            <dl class="summary">
                <dt>Giá gốc</dt><dd><?= e(money($totals['list'])) ?></dd>
                <?php if ($totals['sale'] > 0): ?><dt>Giảm giá chiến dịch</dt><dd>−<?= e(money($totals['sale'])) ?></dd><?php endif; ?>
                <?php if ($totals['coupon'] > 0): ?><dt>Mã <?= e($coupon['ma_uu_dai']) ?></dt><dd>−<?= e(money($totals['coupon'])) ?></dd><?php endif; ?>
                <dt>Thuế</dt><dd><?= e(money(0)) ?></dd>
                <dt class="total">Tổng thanh toán</dt><dd class="total"><?= e(money($totals['total'])) ?></dd>
            </dl>

            <?php if ($coupon): ?>
                <form method="post" action="<?= e(app_url('/cart/coupon/remove')) ?>" class="split coupon-on">
                    <?= csrf_field() ?>
                    <span class="small">Đang dùng mã <strong><?= e($coupon['ma_uu_dai']) ?></strong><?= $totals['coupon_applies'] ? '' : ' (không áp dụng cho sản phẩm hiện tại)' ?></span>
                    <button class="link-btn" type="submit">Gỡ mã</button>
                </form>
            <?php else: ?>
                <form method="post" action="<?= e(app_url('/cart/coupon')) ?>" class="coupon-form">
                    <?= csrf_field() ?>
                    <label class="sr-only" for="coupon-code">Mã giảm giá</label>
                    <input class="input" id="coupon-code" name="code" maxlength="40" placeholder="Mã giảm giá" value="<?= e(old('code')) ?>" autocomplete="off">
                    <button class="btn" type="submit">Áp dụng</button>
                </form>
            <?php endif; ?>

            <?php if ($totals['blocked']): ?>
                <p class="notice small">Có <?= fmt_int($totals['blocked']) ?> sản phẩm không thể thanh toán. Hãy bỏ chúng khỏi giỏ để tiếp tục.</p>
            <?php else: ?>
                <form method="post" action="<?= e(app_url('/cart/checkout')) ?>" class="form checkout-form">
                    <?= csrf_field() ?>
                    <label class="check">
                        <input type="checkbox" name="confirm_sandbox" value="1" required>
                        <span>Tôi hiểu đây là <strong>thanh toán thử nghiệm (sandbox)</strong><span class="sub">Không có tiền thật được trừ. Đơn hàng được đánh dấu TEST- và chỉ dùng để kiểm thử hệ thống.</span></span>
                    </label>
                    <button class="btn primary block" type="submit">Thanh toán thử <?= e(money($totals['total'])) ?></button>
                </form>
            <?php endif; ?>
        </section>
        <p class="small faint">Bạn có thể yêu cầu hoàn tiền trong <?= (int)REFUND_WINDOW_DAYS ?> ngày kể từ khi thanh toán, tại trang chi tiết đơn hàng.</p>
    </aside>
</div>
<?php endif; ?>
