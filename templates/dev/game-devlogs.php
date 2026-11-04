<?php
/** Project devlog posts, every status. @var array $game @var string $tab @var array $posts */
$gid = (int)$game['ma'];
$isPublic = in_array($game['trang_thai'], ['published', 'unlisted'], true);
?>
<?php partial('dev-game-tabs', ['game' => $game, 'tab' => $tab]); ?>

<div class="title-row">
    <div><h2>Nhật ký phát triển</h2><p class="sub">Chia sẻ tiến độ với người chơi. Bài đã đăng hiện trên trang trò chơi; người theo dõi nhận thông báo khi bài được đăng lần đầu.</p></div>
    <a class="btn primary" href="<?= e(app_url('/dev/games/' . $gid . '/devlogs/new')) ?>">Viết bài</a>
</div>

<?php if (!$posts): ?>
    <div class="empty"><p>Chưa có bài nhật ký nào.</p></div>
<?php else: ?>
<section class="panel flush">
    <table>
        <thead><tr><th scope="col">Bài viết</th><th scope="col">Trạng thái</th><th scope="col" class="num">Bình luận</th><th scope="col">Cập nhật</th></tr></thead>
        <tbody>
        <?php foreach ($posts as $p): ?>
            <tr>
                <td>
                    <a class="link" href="<?= e(app_url('/dev/games/' . $gid . '/devlogs/' . (int)$p['ma'])) ?>"><?= e($p['tieu_de']) ?></a>
                    <span class="sub"><?= e($p['ten_hien_thi']) ?><?= $p['ngay_cong_bo'] ? ' · đăng ' . e(fmt_date($p['ngay_cong_bo'])) : '' ?>
                    <?php if ($p['trang_thai'] === 'published' && $isPublic): ?> · <a class="link" href="<?= e(app_url('/games/' . rawurlencode($game['duong_dan_rut_gon']) . '/devlogs/' . rawurlencode($p['duong_dan_rut_gon']))) ?>">Xem</a><?php endif; ?></span>
                </td>
                <td><?= status_pill('content_status', $p['trang_thai']) ?></td>
                <td class="num"><?= fmt_int((int)$p['so_binh_luan']) ?></td>
                <td><?= e(fmt_datetime($p['ngay_cap_nhat'])) ?></td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</section>
<?php endif; ?>
