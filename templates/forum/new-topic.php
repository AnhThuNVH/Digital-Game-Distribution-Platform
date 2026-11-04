<?php
/** New topic form. @var array $board */
$id = (int)$board['ma'];
?>
<nav class="crumbs" aria-label="Đường dẫn"><a href="<?= e(app_url('/forums')) ?>">Diễn đàn</a><a href="<?= e(app_url('/forums/' . $id)) ?>"><?= e($board['tieu_de']) ?></a><span>Chủ đề mới</span></nav>

<div class="title-row"><div><h1>Chủ đề mới</h1><p class="sub">Đăng trong <?= e($board['tieu_de']) ?>. Tiêu đề rõ ràng giúp người khác tìm thấy và trả lời nhanh hơn.</p></div></div>

<section class="panel narrow-panel">
    <form class="form" method="post" action="<?= e(app_url('/forums/' . $id . '/topics')) ?>">
        <?= csrf_field() ?>
        <div class="field">
            <label for="t-title">Tiêu đề</label>
            <input class="input" id="t-title" name="tieu_de" minlength="3" maxlength="220" required value="<?= e(old('tieu_de')) ?>">
        </div>
        <div class="field">
            <label for="t-body">Nội dung</label>
            <textarea class="input tall" id="t-body" name="noi_dung" maxlength="20000" required><?= e(old('noi_dung')) ?></textarea>
            <span class="hint">Văn bản thuần, xuống dòng được giữ nguyên. Tối đa 20.000 ký tự.</span>
        </div>
        <div class="form-actions">
            <button class="btn primary" type="submit">Đăng chủ đề</button>
            <a class="btn ghost" href="<?= e(app_url('/forums/' . $id)) ?>">Hủy</a>
        </div>
    </form>
</section>
