<?php
// =============================================================================
// USER MODEL - Table: nguoi_dung
// =============================================================================

class UserModel extends Model {
    protected static $table = 'nguoi_dung';
    protected static $pk = 'ma';

    public static function create(string $username, string $email, string $password, string $displayName): int {
        $hash = password_hash($password, PASSWORD_DEFAULT);
        return self::insert([
            'ten_dang_nhap' => $username,
            'email' => $email,
            'mat_khau_da_bam' => $hash,
            'ten_hien_thi' => $displayName,
        ]);
    }

    public static function authenticate(string $email, string $password): ?array {
        $user = self::findBy('email', $email);
        if ($user && password_verify($password, $user['mat_khau_da_bam'])) {
            unset($user['mat_khau_da_bam']);
            return $user;
        }
        return null;
    }

    public static function updateProfile(int $id, array $data): bool {
        return self::update($id, $data);
    }

    public static function getRoles(int $userId): array {
        $sql = "SELECT r.ma_vai_tro, r.ten_vai_tro
                FROM vai_tro r
                INNER JOIN nguoi_dung_vai_tro uvr ON uvr.vai_tro_id = r.ma
                WHERE uvr.nguoi_dung_id = :uid";
        $stmt = self::db()->prepare($sql);
        $stmt->execute([':uid' => $userId]);
        return $stmt->fetchAll();
    }

    public static function addRole(int $userId, int $roleId): bool {
        $sql = "INSERT IGNORE INTO nguoi_dung_vai_tro (nguoi_dung_id, vai_tro_id) VALUES (:uid, :rid)";
        $stmt = self::db()->prepare($sql);
        return $stmt->execute([':uid' => $userId, ':rid' => $roleId]);
    }
}