<?php
// =============================================================================
// TAXONOMY MODEL - Tables: the_loai, nhan, nen_tang (and their game link tables
// tro_choi_the_loai, tro_choi_nhan, tro_choi_nen_tang, read-only here).
// One admin screen manages the three lists; KINDS maps each URL kind to its
// table and columns. Entries linked to a game cannot be deleted: genre and tag
// links would cascade away, and nen_tang has no cascade at all.
// =============================================================================

class TaxonomyModel extends Model {
    public const KINDS = [
        'genre' => [
            'label' => 'Thể loại', 'one' => 'thể loại', 'table' => 'the_loai',
            'name' => 'ten', 'nameMax' => 100, 'slug' => 'duong_dan_rut_gon', 'slugMax' => 120,
            'desc' => 'mo_ta', 'descMax' => 500,
            'link' => 'tro_choi_the_loai', 'fk' => 'the_loai_id', 'filter' => 'category',
        ],
        'tag' => [
            'label' => 'Thẻ', 'one' => 'thẻ', 'table' => 'nhan',
            'name' => 'ten', 'nameMax' => 80, 'slug' => 'duong_dan_rut_gon', 'slugMax' => 100,
            'desc' => null, 'descMax' => 0,
            'link' => 'tro_choi_nhan', 'fk' => 'nhan_id', 'filter' => 'tag',
        ],
        'platform' => [
            'label' => 'Nền tảng', 'one' => 'nền tảng', 'table' => 'nen_tang',
            'name' => 'ten_nen_tang', 'nameMax' => 80, 'slug' => 'ma_nen_tang', 'slugMax' => 40,
            'desc' => null, 'descMax' => 0,
            'link' => 'tro_choi_nen_tang', 'fk' => 'nen_tang_id', 'filter' => 'platform',
        ],
    ];

    public static function kind(string $kind): ?array {
        return self::KINDS[$kind] ?? null;
    }

    /** Entries of one kind with the number of games linked to each. */
    public static function listKind(array $k): array {
        return self::query("SELECT t.*, t.{$k['name']} AS ten_muc, t.{$k['slug']} AS khoa_muc,
                (SELECT COUNT(*) FROM {$k['link']} x WHERE x.{$k['fk']} = t.ma) AS so_tro_choi
            FROM {$k['table']} t ORDER BY t.{$k['name']}");
    }

    public static function counts(): array {
        $out = [];
        foreach (self::KINDS as $key => $k) {
            $out[$key] = (int)self::scalar("SELECT COUNT(*) FROM {$k['table']}");
        }
        return $out;
    }

    public static function findIn(array $k, int $id): ?array {
        return $id > 0 ? self::one("SELECT * FROM {$k['table']} WHERE ma = :id", [':id' => $id]) : null;
    }

    public static function gameCount(array $k, int $id): int {
        return (int)self::scalar("SELECT COUNT(*) FROM {$k['link']} WHERE {$k['fk']} = :id", [':id' => $id]);
    }

    /** Validate the entry form; returns [row, errors]. $id excludes the entry itself from duplicate checks. */
    public static function fromForm(array $k, array $post, int $id = 0): array {
        $errors = [];
        $name = trim((string)($post['ten'] ?? ''));
        if ($name === '' || mb_strlen($name) > $k['nameMax']) {
            $errors[] = 'Tên cần 1–' . $k['nameMax'] . ' ký tự.';
        }
        $slugIn = trim((string)($post['khoa'] ?? ''));
        $slug = $slugIn !== '' ? $slugIn : slugify($name);
        if ($slug === '' || strlen($slug) > $k['slugMax'] || !preg_match('/^[a-z0-9]+(-[a-z0-9]+)*$/', $slug)) {
            $errors[] = ($k['table'] === 'nen_tang' ? 'Mã nền tảng' : 'Đường dẫn rút gọn') . ' chỉ gồm chữ thường không dấu, số và gạch ngang, tối đa ' . $k['slugMax'] . ' ký tự.';
        }
        $row = [$k['name'] => $name, $k['slug'] => $slug];
        if ($k['desc']) {
            $desc = trim((string)($post['mo_ta'] ?? ''));
            if (mb_strlen($desc) > $k['descMax']) {
                $errors[] = 'Mô tả tối đa ' . $k['descMax'] . ' ký tự.';
            }
            $row[$k['desc']] = $desc !== '' ? $desc : null;
        }
        if (!$errors) {
            // Compare in SQL so the check follows the column collation used by the UNIQUE keys.
            foreach ([$k['name'] => 'Tên', $k['slug'] => $k['table'] === 'nen_tang' ? 'Mã nền tảng' : 'Đường dẫn rút gọn'] as $col => $what) {
                $dup = self::scalar("SELECT {$k['name']} FROM {$k['table']} WHERE $col = :v AND ma <> :id LIMIT 1", [':v' => $row[$col], ':id' => $id]);
                if ($dup !== null && $dup !== false) {
                    $errors[] = $what . ' đã được dùng bởi "' . $dup . '".';
                }
            }
        }
        return [$row, $errors];
    }

    public static function insertIn(array $k, array $row): int {
        $cols = array_keys($row);
        self::run("INSERT INTO {$k['table']} (" . implode(', ', $cols) . ') VALUES (:' . implode(', :', $cols) . ')', array_combine(array_map(fn($c) => ':' . $c, $cols), array_values($row)));
        return self::lastId();
    }

    public static function updateIn(array $k, int $id, array $row): void {
        $sets = implode(', ', array_map(fn($c) => "$c = :$c", array_keys($row)));
        self::run("UPDATE {$k['table']} SET $sets WHERE ma = :id", array_combine(array_map(fn($c) => ':' . $c, array_keys($row)), array_values($row)) + [':id' => $id]);
    }

    /** Delete an entry only while no game uses it; returns false when it is in use. */
    public static function deleteIn(array $k, int $id): bool {
        return self::run("DELETE FROM {$k['table']} WHERE ma = :id AND NOT EXISTS (SELECT 1 FROM {$k['link']} WHERE {$k['fk']} = :id2)", [':id' => $id, ':id2' => $id]) > 0;
    }
}
