<?php
// =============================================================================
// JAM MODEL - Tables: cuoc_thi_lam_game, bai_du_thi, binh_chon_bai_du_thi,
// thanh_vien_cuoc_thi
//
// The phase a visitor sees is derived from trang_thai plus the dates, so a jam
// opens and closes on time without anyone changing its status by hand.
// =============================================================================

class JamModel extends Model {
    protected static $table = 'cuoc_thi_lam_game';

    public const STATUSES = ['draft', 'published', 'active', 'judging', 'completed', 'cancelled'];

    /** Scoring criteria stored in binh_chon_bai_du_thi.tieu_chi. "overall" decides the ranking. */
    public const CRITERIA = [
        'overall' => 'Tổng thể',
        'gameplay' => 'Lối chơi',
        'visuals' => 'Hình ảnh',
        'audio' => 'Âm thanh',
        'theme' => 'Bám chủ đề',
    ];

    public const PHASES = [
        'draft' => 'Bản nháp',
        'upcoming' => 'Sắp mở',
        'submissions' => 'Đang nhận bài',
        'waiting' => 'Chờ bình chọn',
        'voting' => 'Đang bình chọn',
        'closed' => 'Đang tổng hợp kết quả',
        'results' => 'Đã có kết quả',
        'cancelled' => 'Đã hủy',
    ];

    public static function phase(array $jam, ?int $now = null): string {
        $now = $now ?? time();
        $status = $jam['trang_thai'];
        if ($status === 'draft' || $status === 'cancelled') {
            return $status;
        }
        if ($status === 'completed') {
            return 'results';
        }
        if ($now < strtotime($jam['ngay_bat_dau'])) {
            return 'upcoming';
        }
        if ($now <= strtotime($jam['han_nop_bai'])) {
            return 'submissions';
        }
        if ((int)$jam['bat_binh_chon']) {
            $start = $jam['ngay_bat_dau_binh_chon'] ? strtotime($jam['ngay_bat_dau_binh_chon']) : strtotime($jam['han_nop_bai']);
            $end = $jam['ngay_ket_thuc_binh_chon'] ? strtotime($jam['ngay_ket_thuc_binh_chon']) : null;
            if ($now < $start) {
                return 'waiting';
            }
            if ($end === null || $now <= $end) {
                return 'voting';
            }
        }
        return 'closed';
    }

    private static function listColumns(): string {
        return "j.*, u.ten_dang_nhap, u.ten_hien_thi,
            (SELECT COUNT(*) FROM bai_du_thi e JOIN tro_choi g ON g.ma = e.tro_choi_id
              WHERE e.cuoc_thi_id = j.ma AND e.trang_thai = 'submitted' AND g.trang_thai IN ('published','unlisted')) AS so_bai,
            (SELECT COUNT(*) FROM thanh_vien_cuoc_thi m WHERE m.cuoc_thi_id = j.ma) AS so_thanh_vien";
    }

    /** Jams for the index tab: open (upcoming or taking entries), judging, past, or hidden (staff: draft/cancelled). */
    public static function listing(string $tab): array {
        $where = [
            'open' => "j.trang_thai IN ('published','active') AND j.han_nop_bai >= NOW()",
            'judging' => "j.trang_thai IN ('published','active','judging') AND j.han_nop_bai < NOW()",
            'past' => "j.trang_thai = 'completed'",
            'hidden' => "j.trang_thai IN ('draft','cancelled')",
        ][$tab] ?? '0 = 1';
        $order = $tab === 'open' ? 'j.ngay_bat_dau, j.ma' : 'j.han_nop_bai DESC, j.ma DESC';
        return self::query('SELECT ' . self::listColumns() . " FROM cuoc_thi_lam_game j JOIN nguoi_dung u ON u.ma = j.nguoi_tao_id WHERE $where ORDER BY $order");
    }

    public static function tabCounts(): array {
        $row = self::one("SELECT
            SUM(trang_thai IN ('published','active') AND han_nop_bai >= NOW()) AS open,
            SUM(trang_thai IN ('published','active','judging') AND han_nop_bai < NOW()) AS judging,
            SUM(trang_thai = 'completed') AS past,
            SUM(trang_thai IN ('draft','cancelled')) AS hidden
            FROM cuoc_thi_lam_game") ?: [];
        return array_map('intval', $row);
    }

    public static function bySlug(string $slug): ?array {
        return self::one('SELECT ' . self::listColumns() . ' FROM cuoc_thi_lam_game j JOIN nguoi_dung u ON u.ma = j.nguoi_tao_id WHERE j.duong_dan_rut_gon = :s', [':s' => $slug]);
    }

    public static function members(int $jamId): array {
        return self::query("SELECT m.vai_tro_thanh_vien, m.nguoi_dung_id AS ma, u.ten_dang_nhap, u.ten_hien_thi, u.url_anh_dai_dien
            FROM thanh_vien_cuoc_thi m JOIN nguoi_dung u ON u.ma = m.nguoi_dung_id
            WHERE m.cuoc_thi_id = :j ORDER BY FIELD(m.vai_tro_thanh_vien,'host','admin','judge','moderator'), u.ten_hien_thi", [':j' => $jamId]);
    }

    public static function memberRole(int $jamId, int $userId): ?string {
        $role = self::scalar('SELECT vai_tro_thanh_vien FROM thanh_vien_cuoc_thi WHERE cuoc_thi_id = :j AND nguoi_dung_id = :u', [':j' => $jamId, ':u' => $userId]);
        return $role ? (string)$role : null;
    }

    /** Entries with game card data, submitter and the overall average. Non-staff only see submitted entries of visible games. */
    public static function entries(int $jamId, bool $all = false): array {
        $filter = $all ? '' : " AND e.trang_thai = 'submitted' AND g.trang_thai IN ('published','unlisted')";
        return self::query('SELECT e.ma AS entry_id, e.trang_thai AS entry_status, e.ngay_nop, e.nguoi_nop_id,
                s.ten_dang_nhap AS nop_ten_dang_nhap, s.ten_hien_thi AS nop_ten,
                ' . GameModel::cardColumns() . ",
                (SELECT AVG(v.diem_so) FROM binh_chon_bai_du_thi v WHERE v.bai_du_thi_id = e.ma AND v.tieu_chi = 'overall') AS diem_tb,
                (SELECT COUNT(DISTINCT v.nguoi_binh_chon_id) FROM binh_chon_bai_du_thi v WHERE v.bai_du_thi_id = e.ma) AS so_phieu
            FROM bai_du_thi e JOIN tro_choi g ON g.ma = e.tro_choi_id JOIN nguoi_dung s ON s.ma = e.nguoi_nop_id
            WHERE e.cuoc_thi_id = :j$filter ORDER BY e.ngay_nop, e.ma", [':j' => $jamId]);
    }

    /** [entryId][criterion] => average score. */
    public static function criteriaScores(int $jamId): array {
        $out = [];
        foreach (self::query('SELECT v.bai_du_thi_id, v.tieu_chi, AVG(v.diem_so) AS tb FROM binh_chon_bai_du_thi v
                JOIN bai_du_thi e ON e.ma = v.bai_du_thi_id WHERE e.cuoc_thi_id = :j GROUP BY v.bai_du_thi_id, v.tieu_chi', [':j' => $jamId]) as $r) {
            $out[(int)$r['bai_du_thi_id']][$r['tieu_chi']] = (float)$r['tb'];
        }
        return $out;
    }

    /** The viewer's own scores: [entryId] => ['scores' => [criterion => n], 'comment' => ?string]. */
    public static function myVotes(int $jamId, int $userId): array {
        $out = [];
        if ($userId <= 0) {
            return $out;
        }
        foreach (self::query('SELECT v.bai_du_thi_id, v.tieu_chi, v.diem_so, v.binh_luan FROM binh_chon_bai_du_thi v
                JOIN bai_du_thi e ON e.ma = v.bai_du_thi_id WHERE e.cuoc_thi_id = :j AND v.nguoi_binh_chon_id = :u', [':j' => $jamId, ':u' => $userId]) as $r) {
            $id = (int)$r['bai_du_thi_id'];
            $out[$id]['scores'][$r['tieu_chi']] = (int)$r['diem_so'];
            if ($r['tieu_chi'] === 'overall') {
                $out[$id]['comment'] = $r['binh_luan'];
            }
        }
        return $out;
    }

    /** Games the user develops that can still be entered (not entered yet, or withdrawn earlier). */
    public static function eligibleGames(int $jamId, int $userId): array {
        return self::query("SELECT g.ma, g.tieu_de FROM tro_choi g
            WHERE g.trang_thai IN ('published','unlisted')
              AND (g.nguoi_tao_id = :u1 OR EXISTS (SELECT 1 FROM tac_gia_tro_choi a WHERE a.tro_choi_id = g.ma AND a.nguoi_dung_id = :u2))
              AND NOT EXISTS (SELECT 1 FROM bai_du_thi e WHERE e.cuoc_thi_id = :j AND e.tro_choi_id = g.ma AND e.trang_thai <> 'withdrawn')
            ORDER BY g.tieu_de", [':u1' => $userId, ':u2' => $userId, ':j' => $jamId]);
    }

    public static function entry(int $jamId, int $entryId): ?array {
        return self::one('SELECT e.*, g.tieu_de AS game_title, g.trang_thai AS game_status FROM bai_du_thi e JOIN tro_choi g ON g.ma = e.tro_choi_id
            WHERE e.ma = :e AND e.cuoc_thi_id = :j', [':e' => $entryId, ':j' => $jamId]);
    }

    /** Insert an entry, or re-open a withdrawn one (the jam+game pair is unique). Returns the entry id. */
    public static function submit(int $jamId, int $gameId, int $userId): int {
        $existing = self::one('SELECT ma, trang_thai FROM bai_du_thi WHERE cuoc_thi_id = :j AND tro_choi_id = :g', [':j' => $jamId, ':g' => $gameId]);
        if ($existing) {
            self::run("UPDATE bai_du_thi SET trang_thai = 'submitted', nguoi_nop_id = :u, ngay_nop = NOW() WHERE ma = :e AND trang_thai = 'withdrawn'", [':u' => $userId, ':e' => (int)$existing['ma']]);
            return (int)$existing['ma'];
        }
        self::run('INSERT INTO bai_du_thi (cuoc_thi_id, tro_choi_id, nguoi_nop_id) VALUES (:j, :g, :u)', [':j' => $jamId, ':g' => $gameId, ':u' => $userId]);
        return self::lastId();
    }

    /** Save one voter's scores for an entry (all criteria at once). */
    public static function vote(int $entryId, int $userId, array $scores, ?string $comment): void {
        self::transaction(function () use ($entryId, $userId, $scores, $comment) {
            foreach ($scores as $criterion => $score) {
                self::run('INSERT INTO binh_chon_bai_du_thi (bai_du_thi_id, nguoi_binh_chon_id, tieu_chi, diem_so, binh_luan) VALUES (:e, :u, :c, :s, :b)
                    ON DUPLICATE KEY UPDATE diem_so = VALUES(diem_so), binh_luan = VALUES(binh_luan), ngay_tao = NOW()', [
                    ':e' => $entryId, ':u' => $userId, ':c' => $criterion, ':s' => (int)$score,
                    ':b' => $criterion === 'overall' ? $comment : null,
                ]);
            }
        });
    }
}
