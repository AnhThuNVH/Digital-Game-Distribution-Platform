<?php
// =============================================================================
// DISCOUNT CAMPAIGN MODEL - Tables: chien_dich_giam_gia, tro_choi_giam_gia
// A campaign lowers the price of its "paid" games while its status is active or
// scheduled and NOW() is between the start and end (GameModel::cardColumns).
// There is no scheduler, so the stored status is set from the dates on save and
// the list shows the phase computed from the dates.
// =============================================================================

class DiscountCampaignModel extends Model {
    protected static $table = 'chien_dich_giam_gia';

    public static function listAll(): array {
        return self::query("SELECT c.*, u.ten_hien_thi AS nguoi_tao,
                (SELECT COUNT(*) FROM tro_choi_giam_gia x WHERE x.chien_dich_id = c.ma) AS so_tro_choi
            FROM chien_dich_giam_gia c JOIN nguoi_dung u ON u.ma = c.nguoi_tao_id
            ORDER BY c.ngay_bat_dau DESC, c.ma DESC");
    }

    /** campaign_status key for display: running campaigns follow their dates. */
    public static function phase(array $c): string {
        if (!in_array($c['trang_thai'], ['active', 'scheduled'], true)) {
            return $c['trang_thai'];
        }
        $now = time();
        if (strtotime($c['ngay_bat_dau']) > $now) return 'scheduled';
        if (strtotime($c['ngay_ket_thuc']) <= $now) return 'ended';
        return 'active';
    }

    public static function gameIds(int $id): array {
        return array_map('intval', self::column('SELECT tro_choi_id FROM tro_choi_giam_gia WHERE chien_dich_id = :c', [':c' => $id]));
    }

    /** Games a campaign can discount: fixed-price games with a price above zero. */
    public static function eligibleGames(int $exceptCampaign = 0): array {
        return self::query("SELECT g.ma, g.tieu_de, g.trang_thai, g.gia_toi_thieu,
                (SELECT GROUP_CONCAT(c.tieu_de SEPARATOR ', ') FROM tro_choi_giam_gia x JOIN chien_dich_giam_gia c ON c.ma = x.chien_dich_id
                  WHERE x.tro_choi_id = g.ma AND c.ma <> :c AND c.trang_thai IN ('active','scheduled') AND c.ngay_ket_thuc > NOW()) AS chien_dich_khac
            FROM tro_choi g WHERE g.mo_hinh_gia = 'paid' AND g.gia_toi_thieu > 0
            ORDER BY g.tieu_de", [':c' => $exceptCampaign]);
    }

    /** Validate the campaign form; returns [row, gameIds, errors]. */
    public static function fromForm(array $post): array {
        $errors = [];
        $title = trim((string)($post['tieu_de'] ?? ''));
        if (mb_strlen($title) < 3 || mb_strlen($title) > 200) {
            $errors[] = 'Tiêu đề cần 3–200 ký tự.';
        }
        $desc = trim((string)($post['mo_ta'] ?? ''));
        if (mb_strlen($desc) > 5000) {
            $errors[] = 'Mô tả tối đa 5.000 ký tự.';
        }
        $percent = parse_money($post['phan_tram_giam_gia'] ?? '');
        if ($percent === null || $percent < 1 || $percent > 95) {
            $errors[] = 'Mức giảm phải từ 1 đến 95%.';
        }
        $start = parse_datetime($post['ngay_bat_dau'] ?? '');
        $end = parse_datetime($post['ngay_ket_thuc'] ?? '');
        if (!$start || !$end) {
            $errors[] = 'Nhập ngày bắt đầu và ngày kết thúc.';
        } elseif (strtotime($end) <= strtotime($start)) {
            $errors[] = 'Ngày kết thúc phải sau ngày bắt đầu.';
        }
        $mode = (string)($post['che_do'] ?? '');
        if (!in_array($mode, ['draft', 'run', 'cancelled'], true)) {
            $errors[] = 'Chọn trạng thái chiến dịch.';
        }
        $picked = array_values(array_unique(array_map('intval', (array)($post['tro_choi'] ?? []))));
        $eligible = array_map('intval', self::column("SELECT ma FROM tro_choi WHERE mo_hinh_gia = 'paid' AND gia_toi_thieu > 0"));
        if (array_diff($picked, $eligible)) {
            $errors[] = 'Chỉ chọn được trò chơi trả phí có giá.';
        }
        if ($mode === 'run' && !$picked) {
            $errors[] = 'Chọn ít nhất một trò chơi trước khi chạy chiến dịch.';
        }
        if ($mode === 'run' && $end && strtotime($end) <= time()) {
            $errors[] = 'Ngày kết thúc đã qua: chọn ngày sau thời điểm hiện tại hoặc lưu bản nháp.';
        }
        $status = $mode === 'run' ? ($start && strtotime($start) > time() ? 'scheduled' : 'active') : $mode;
        return [[
            'tieu_de' => $title,
            'mo_ta' => $desc !== '' ? $desc : null,
            'phan_tram_giam_gia' => $percent,
            'trang_thai' => $status,
            'ngay_bat_dau' => $start,
            'ngay_ket_thuc' => $end,
        ], $picked, $errors];
    }

    /** Replace the campaign's game list. Call inside a transaction. */
    public static function setGames(int $id, array $gameIds): void {
        self::run('DELETE FROM tro_choi_giam_gia WHERE chien_dich_id = :c', [':c' => $id]);
        foreach ($gameIds as $gid) {
            DiscountGameModel::add($id, (int)$gid);
        }
    }
}
