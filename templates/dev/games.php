<?php
/** Developer projects. @var array $games @var int $uid */
?>
<div class="title-row">
    <div><h1>Dự án</h1><p class="sub">Dự án bạn tạo hoặc tham gia với vai trò đồng tác giả.</p></div>
    <a class="btn primary" href="<?= e(app_url('/dev/games/new')) ?>">Tạo dự án</a>
</div>

<?php if (!$games): ?>
    <div class="empty"><p>Bạn chưa có dự án nào. Tạo dự án ở trạng thái bản nháp, thêm ảnh và mô tả, rồi công bố khi sẵn sàng.</p><a class="btn primary" href="<?= e(app_url('/dev/games/new')) ?>">Tạo dự án đầu tiên</a></div>
<?php else: ?>
<section class="panel flush">
    <table>
        <thead><tr><th scope="col">Dự án</th><th scope="col">Trạng thái</th><th scope="col">Giá</th><th scope="col" class="num">Sở hữu</th><th scope="col" class="num">Lượt xem 30 ngày</th><th scope="col">Vai trò</th></tr></thead>
        <tbody>
        <?php foreach ($games as $g): ?>
            <tr>
                <td>
                    <div class="cell-game">
                        <?php if ($g['anh_bia']): ?><img src="<?= e(app_media_url($g['anh_bia'])) ?>" alt="" loading="lazy"><?php else: ?><span class="thumb"></span><?php endif; ?>
                        <div><a class="link" href="<?= e(app_url('/dev/games/' . (int)$g['ma'])) ?>"><?= e($g['tieu_de']) ?></a><span class="sub"><?= e(label('project_type', $g['loai_du_an'])) ?> · <?= e(label('release_status', $g['trang_thai_phat_hanh'])) ?></span></div>
                    </div>
                </td>
                <td><?= status_pill('game_status', $g['trang_thai']) ?></td>
                <td><?= e(label('pricing', $g['mo_hinh_gia'])) ?><?= (float)$g['gia_toi_thieu'] > 0 ? '<span class="sub">' . e(money($g['gia_toi_thieu'])) . '</span>' : '' ?></td>
                <td class="num"><?= fmt_int((int)$g['so_huu']) ?></td>
                <td class="num"><?= fmt_int((int)$g['luot_xem_30']) ?></td>
                <td><?= (int)$g['nguoi_tao_id'] === $uid ? 'Người tạo' : 'Đồng tác giả' ?></td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</section>
<?php endif; ?>
