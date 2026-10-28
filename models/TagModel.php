<?php
// =============================================================================
// TAG MODEL - Table: nhan
// =============================================================================

class TagModel extends Model {
    protected static $table = 'nhan';

    public static function getAll(): array {
        return self::all();
    }
}