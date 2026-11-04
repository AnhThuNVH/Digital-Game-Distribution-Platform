<?php
/** Write or edit a devlog post. @var array $game @var string $tab @var ?array $post */
$gid = (int)$game['ma'];
$isNew = $post === null;
$v = static fn(string $key, $fallback = '') => old($key, $post[$key] ?? $fallback);
$action = '/dev/games/' . $gid . '/devlogs' . ($isNew ? '' : '/' . (int)$post['ma']);
$hidden = !$isNew && $post['trang_thai'] === 'hidden';
$publicUrl = !$isNew && $post['trang_thai'] === 'published' && in_array($game['trang_thai'], ['published', 'unlisted'], true)
    ? app_url('/games/' . rawurlencode($game['duong_dan_rut_gon']) . '/devlogs/' . rawurlencode($post['duong_dan_rut_gon'])) : null;
?>
<?php partial('dev-game-tabs', ['game' => $game, 'tab' => $tab]); ?>

<div class="title-row">
    <div>
        <h2><?= $isNew ? 'Viết bài nhật ký' : 'Sửa bài nhật ký' ?></h2>
        <?php if (!$isNew): ?><p class="sub"><?= status_pill('content_status', $post['trang_thai']) ?><?= $post['ngay_cong_bo'] ? ' Đăng ' . e(fmt_datetime($post['ngay_cong_bo'])) : '' ?> · đường dẫn /<?= e($post['duong_dan_rut_gon']) ?></p><?php endif; ?>
    </div>
    <div class="cluster">
        <a class="btn ghost" href="<?= e(app_url('/dev/games/' . $gid . '/devlogs')) ?>">Tất cả bài viết</a>
        <?php if ($publicUrl): ?><a class="btn" href="<?= e($publicUrl) ?>">Xem bài</a><?php endif; ?>
    </div>
</div>

<section class="panel narrow-panel">
    <form class="form" method="post" action="<?= e(app_url($action)) ?>">
        <?= csrf_field() ?>
        <div class="field">
            <label for="d-title">Tiêu đề</label>
            <input class="input" id="d-title" name="tieu_de" maxlength="200" required value="<?= e($v('tieu_de')) ?>">
            <?php if ($isNew): ?><span class="hint">Đường dẫn bài viết được tạo từ tiêu đề và không đổi sau đó.</span><?php endif; ?>
        </div>
        <div class="field">
            <label for="d-body">Nội dung</label>
            <textarea class="input tall" id="d-body" name="noi_dung" maxlength="50000" required><?= e((string)$v('noi_dung')) ?></textarea>
            <span class="hint">Văn bản thuần, xuống dòng được giữ nguyên. Tối đa 50.000 ký tự.</span>
        </div>
        <?php if ($hidden): ?>
            <p class="hint">Bài viết đã bị đội ngũ kiểm duyệt ẩn. Bạn vẫn sửa được nội dung nhưng không thể tự hiển thị lại.</p>
        <?php else: ?>
            <fieldset class="field">
                <legend>Trạng thái</legend>
                <div class="choice-grid">
                    <label class="check"><input type="radio" name="trang_thai" value="draft"<?= $v('trang_thai', 'draft') === 'draft' ? ' checked' : '' ?>> <span>Bản nháp<span class="sub">Chỉ tác giả thấy.</span></span></label>
                    <label class="check"><input type="radio" name="trang_thai" value="published"<?= $v('trang_thai', 'draft') === 'published' ? ' checked' : '' ?>> <span>Đăng<span class="sub">Hiện trên trang trò chơi.</span></span></label>
                </div>
            </fieldset>
        <?php endif; ?>
        <div class="form-actions"><button class="btn primary" type="submit"><?= $isNew ? 'Lưu bài viết' : 'Lưu thay đổi' ?></button></div>
    </form>
</section>
