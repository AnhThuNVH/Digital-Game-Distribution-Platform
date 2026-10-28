<?php
// =============================================================================
// ACCESS KEY MODEL - Table: ma_truy_cap_tro_choi
// =============================================================================

class AccessKeyModel extends Model {
    protected static $table = 'ma_truy_cap_tro_choi';

    public static function create(int $gameId, int $creatorId, string $hash, ?string $expires = null): int {
        return self::insert([
            'tro_choi_id' => $gameId,
            'nguoi_tao_ma_id' => $creatorId,
            'ma_bam' => $hash,
            'ngay_het_han' => $expires,
        ]);
    }
}