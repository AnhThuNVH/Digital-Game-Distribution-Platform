<?php
/** Genres, tags and platforms. @var string $kindKey @var array $kind @var array $items @var array $counts @var ?array $editing */
$base = '/admin/taxonomy';
$isPlatform = $kindKey === 'platform';
$keyLabel = $isPlatform ? 'Mã nền tảng' : 'Đường dẫn rút gọn';
$editId = $editing ? (int)$editing['ma'] : 0;
$val = static fn(string $field, ?string $col) => old($field, $editing && $col ? (string)($editing[$col] ?? '') : '');
?>
<div class="title-row">
    <div><h1>Danh mục</h1><p class="sub">Thể loại, thẻ và nền tảng dùng cho bộ lọc cửa hàng và trang chỉnh sửa trò chơi. Chỉ xóa được mục chưa gắn với trò chơi nào.</p></div>
</div>

<nav class="tabs" aria-label="Loại danh mục">
    <?php foreach (TaxonomyModel::KINDS as $key => $k): ?>
        <a href="<?= e(app_url($base . '?kind=' . $key)) ?>" aria-selected="<?= $key === $kindKey ? 'true' : 'false' ?>"><?= e($k['label']) ?> <span class="muted"><?= fmt_int($counts[$key]) ?></span></a>
    <?php endforeach; ?>
</nav>

<div class="grid top">
    <section class="panel span-8" aria-labelledby="list-h">
        <header><h2 id="list-h"><?= e($kind['label']) ?></h2><span class="meta"><?= fmt_int(count($items)) ?> mục</span></header>
        <?php if (!$items): ?>
            <div class="empty"><p>Chưa có <?= e($kind['one']) ?> nào.</p></div>
        <?php else: ?>
        <div class="table-wrap">
            <table>
                <thead><tr>
                    <th scope="col">Tên</th><?php if ($kind['desc']): ?><th scope="col">Mô tả</th><?php endif; ?>
                    <th scope="col" class="num">Trò chơi</th><th scope="col"><span class="sr-only">Thao tác</span></th>
                </tr></thead>
                <tbody>
                <?php foreach ($items as $it): $id = (int)$it['ma']; $n = (int)$it['so_tro_choi']; ?>
                    <tr<?= $id === $editId ? ' aria-current="true"' : '' ?>>
                        <td><?= e($it['ten_muc']) ?><span class="sub"><code><?= e($it['khoa_muc']) ?></code></span></td>
                        <?php if ($kind['desc']): ?><td class="muted"><?= $it[$kind['desc']] !== null ? e($it[$kind['desc']]) : '' ?></td><?php endif; ?>
                        <td class="num"><?php if ($n): ?><a class="link" href="<?= e(app_url('/games?' . $kind['filter'] . '=' . rawurlencode($it['khoa_muc']))) ?>"><?= fmt_int($n) ?></a><?php else: ?><span class="muted">0</span><?php endif; ?></td>
                        <td class="actions">
                            <a class="link" href="<?= e(app_url($base . '?kind=' . $kindKey . '&edit=' . $id . '#form')) ?>">Sửa<span class="sr-only"> <?= e($it['ten_muc']) ?></span></a>
                            <?php if (!$n): ?>
                                <form method="post" action="<?= e(app_url($base . '/' . $kindKey . '/' . $id . '/delete')) ?>" data-confirm="Xóa <?= e($kind['one']) ?> &quot;<?= e($it['ten_muc']) ?>&quot;?">
                                    <?= csrf_field() ?>
                                    <button class="link-btn neg" type="submit">Xóa<span class="sr-only"> <?= e($it['ten_muc']) ?></span></button>
                                </form>
                            <?php endif; ?>
                        </td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
        <?php endif; ?>
    </section>

    <section class="panel span-4" id="form" aria-labelledby="form-h">
        <header><h2 id="form-h"><?= $editing ? 'Sửa ' . e($kind['one']) : 'Thêm ' . e($kind['one']) ?></h2></header>
        <form class="form" method="post" action="<?= e(app_url($base . '/' . $kindKey . ($editing ? '/' . $editId : ''))) ?>">
            <?= csrf_field() ?>
            <div class="field">
                <label for="tx-name">Tên</label>
                <input class="input" id="tx-name" name="ten" required maxlength="<?= (int)$kind['nameMax'] ?>" value="<?= e($val('ten', $kind['name'])) ?>">
            </div>
            <div class="field">
                <label for="tx-key"><?= e($keyLabel) ?></label>
                <input class="input" id="tx-key" name="khoa" maxlength="<?= (int)$kind['slugMax'] ?>" pattern="[a-z0-9]+(-[a-z0-9]+)*" autocomplete="off" spellcheck="false" value="<?= e($val('khoa', $kind['slug'])) ?>">
                <span class="hint">Chữ thường không dấu, số, gạch ngang. Bỏ trống để tạo từ tên. Dùng trong địa chỉ trang lọc của cửa hàng<?= $editing ? '; đổi giá trị này làm hỏng liên kết cũ' : '' ?>.</span>
            </div>
            <?php if ($kind['desc']): ?>
            <div class="field">
                <label for="tx-desc">Mô tả</label>
                <textarea class="input" id="tx-desc" name="mo_ta" maxlength="<?= (int)$kind['descMax'] ?>" rows="3"><?= e($val('mo_ta', $kind['desc'])) ?></textarea>
            </div>
            <?php endif; ?>
            <div class="form-actions">
                <button class="btn primary" type="submit"><?= $editing ? 'Lưu thay đổi' : 'Thêm' ?></button>
                <?php if ($editing): ?><a class="btn" href="<?= e(app_url($base . '?kind=' . $kindKey)) ?>">Hủy</a><?php endif; ?>
            </div>
        </form>
    </section>
</div>
