<?php
/** @var int $page @var int $pages @var int $total */
if (($pages ?? 1) <= 1) return;
?>
<nav class="pagination" aria-label="Phân trang">
    <span>Trang <?= fmt_int($page) ?> / <?= fmt_int($pages) ?> · <?= fmt_int($total) ?> mục</span>
    <span class="pages">
        <?php if ($page > 1): ?><a class="btn sm" href="<?= e(qs(['page' => $page - 1])) ?>">Trang trước</a><?php endif; ?>
        <?php if ($page < $pages): ?><a class="btn sm" href="<?= e(qs(['page' => $page + 1])) ?>">Trang sau</a><?php endif; ?>
    </span>
</nav>
