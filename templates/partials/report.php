<?php
/** Report form for any content. @var string $type @var int $id */
if (!current_user()) return;
$reasons = labels('report_reason');
?>
<details class="edit">
    <summary class="link-btn"><?= e($labelText ?? 'Báo cáo') ?></summary>
    <form method="post" action="<?= e(app_url('/reports')) ?>" class="form well report-form">
        <?= csrf_field() ?><?= return_field() ?>
        <input type="hidden" name="type" value="<?= e($type) ?>">
        <input type="hidden" name="id" value="<?= (int)$id ?>">
        <div class="field">
            <label for="reason-<?= e($type . $id) ?>">Lý do</label>
            <select class="input" id="reason-<?= e($type . $id) ?>" name="reason" required>
                <?php foreach ($reasons as $value => $text): ?><option value="<?= e($value) ?>"><?= e($text) ?></option><?php endforeach; ?>
            </select>
        </div>
        <div class="field">
            <label for="detail-<?= e($type . $id) ?>">Chi tiết (không bắt buộc)</label>
            <textarea class="input" id="detail-<?= e($type . $id) ?>" name="detail" maxlength="2000"></textarea>
        </div>
        <div class="form-actions"><button class="btn sm" type="submit">Gửi báo cáo</button></div>
    </form>
</details>
