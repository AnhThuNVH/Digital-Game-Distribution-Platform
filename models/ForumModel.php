<?php
// =============================================================================
// FORUM MODEL - Table: dien_dan
// =============================================================================

class ForumModel extends Model {
    protected static $table = 'dien_dan';

    public static function getAll(): array {
        return self::all();
    }

    public static function findByType(string $type): array {
        return self::findAllBy('loai_dien_dan', $type);
    }
}