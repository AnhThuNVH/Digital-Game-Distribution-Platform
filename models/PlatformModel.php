<?php
// =============================================================================
// PLATFORM MODEL - Table: nen_tang
// =============================================================================

class PlatformModel extends Model {
    protected static $table = 'nen_tang';

    public static function getAll(): array {
        return self::all('ten_nen_tang ASC');
    }
}