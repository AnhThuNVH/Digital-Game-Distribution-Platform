<?php
// =============================================================================
// CATEGORY MODEL - Table: the_loai
// =============================================================================

class CategoryModel extends Model {
    protected static $table = 'the_loai';

    public static function getAll(): array {
        return self::all('ten ASC');
    }
}