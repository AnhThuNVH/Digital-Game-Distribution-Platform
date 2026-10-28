<?php
// =============================================================================
// JAM MODEL - Table: cuoc_thi_lam_game
// =============================================================================

class JamModel extends Model {
    protected static $table = 'cuoc_thi_lam_game';

    public static function create(int $creatorId, string $title, string $slug, string $description, string $rules, string $start, string $end, ?string $voteStart = null, ?string $voteEnd = null): int {
        return self::insert([
            'nguoi_tao_id' => $creatorId,
            'tieu_de' => $title,
            'duong_dan_rut_gon' => $slug,
            'mo_ta' => $description,
            'the_le' => $rules,
            'ngay_bat_dau' => $start,
            'han_nop_bai' => $end,
            'ngay_bat_dau_binh_chon' => $voteStart,
            'ngay_ket_thuc_binh_chon' => $voteEnd,
        ]);
    }

    public static function getAll(): array {
        return self::all('ngay_bat_dau DESC');
    }

    public static function findBySlug(string $slug): ?array {
        return self::findBy('duong_dan_rut_gon', $slug);
    }
}