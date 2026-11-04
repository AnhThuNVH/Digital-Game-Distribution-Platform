<?php
// =============================================================================
// USER MODEL - Tables: nguoi_dung, nguoi_dung_vai_tro, vai_tro, cai_dat_nguoi_dung
// =============================================================================

class UserModel extends Model {
    protected static $table = 'nguoi_dung';
    protected static $pk = 'ma';

    public static function create(string $username, string $email, string $password, string $displayName): int {
        return self::transaction(function () use ($username, $email, $password, $displayName) {
            $userId = self::insert([
                'ten_dang_nhap' => $username,
                'email' => $email,
                'mat_khau_da_bam' => password_hash($password, PASSWORD_DEFAULT),
                'ten_hien_thi' => $displayName,
            ]);
            $player = RoleModel::findByCode('player');
            if ($player) {
                self::addRole($userId, (int)$player['ma']);
            }
            self::run('INSERT IGNORE INTO cai_dat_nguoi_dung (nguoi_dung_id, tien_te_uu_tien) VALUES (:uid, :cur)', [':uid' => $userId, ':cur' => APP_CURRENCY]);
            return $userId;
        });
    }

    /** Look a user up by e-mail or username; returns the row including the hash. */
    public static function findForLogin(string $login): ?array {
        return self::one('SELECT * FROM nguoi_dung WHERE email = :e OR ten_dang_nhap = :u LIMIT 1', [':e' => $login, ':u' => $login]);
    }

    public static function findByUsername(string $username): ?array {
        return self::one('SELECT * FROM nguoi_dung WHERE ten_dang_nhap = :u LIMIT 1', [':u' => $username]);
    }

    public static function publicFields(array $user): array {
        unset($user['mat_khau_da_bam']);
        return $user;
    }

    public static function settings(int $userId): array {
        $row = self::one('SELECT * FROM cai_dat_nguoi_dung WHERE nguoi_dung_id = :uid', [':uid' => $userId]);
        return $row ?: [
            'nguoi_dung_id' => $userId, 'pham_vi_hien_thi_ho_so' => 'public', 'hien_thi_game_so_huu' => 1, 'cho_phep_nhan_tin' => 1,
            'email_cap_nhat_san_pham' => 1, 'email_cap_nhat_cong_dong' => 1, 'ngon_ngu_uu_tien' => 'vi', 'tien_te_uu_tien' => APP_CURRENCY,
        ];
    }

    public static function listForAdmin(string $query, string $status, string $role, int $limit, int $offset): array {
        [$where, $params] = self::adminWhere($query, $status, $role);
        $params[':limit'] = $limit;
        $params[':offset'] = $offset;
        return self::query("SELECT u.ma, u.ten_dang_nhap, u.email, u.ten_hien_thi, u.url_anh_dai_dien, u.trang_thai, u.ngay_tao,
                (SELECT GROUP_CONCAT(r.ma_vai_tro ORDER BY r.ma SEPARATOR ',') FROM nguoi_dung_vai_tro x JOIN vai_tro r ON r.ma = x.vai_tro_id WHERE x.nguoi_dung_id = u.ma) AS vai_tro,
                (SELECT COUNT(*) FROM quyen_so_huu_tro_choi o WHERE o.nguoi_dung_id = u.ma AND o.trang_thai = 'active') AS so_game
            FROM nguoi_dung u WHERE $where ORDER BY u.ngay_tao DESC, u.ma DESC LIMIT :limit OFFSET :offset", $params);
    }

    public static function countForAdmin(string $query, string $status, string $role): int {
        [$where, $params] = self::adminWhere($query, $status, $role);
        return (int)self::scalar("SELECT COUNT(*) FROM nguoi_dung u WHERE $where", $params);
    }

    private static function adminWhere(string $query, string $status, string $role): array {
        $where = ['1=1'];
        $params = [];
        if ($query !== '') {
            $where[] = '(u.ten_hien_thi LIKE :q1 OR u.ten_dang_nhap LIKE :q2 OR u.email LIKE :q3 OR CAST(u.ma AS CHAR) = :q4)';
            $params += [':q1' => "%$query%", ':q2' => "%$query%", ':q3' => "%$query%", ':q4' => $query];
        }
        if (in_array($status, ['active', 'suspended', 'deleted'], true)) {
            $where[] = 'u.trang_thai = :status';
            $params[':status'] = $status;
        }
        if (in_array($role, ['player', 'developer', 'moderator', 'admin'], true)) {
            $where[] = 'EXISTS (SELECT 1 FROM nguoi_dung_vai_tro x JOIN vai_tro r ON r.ma = x.vai_tro_id WHERE x.nguoi_dung_id = u.ma AND r.ma_vai_tro = :role)';
            $params[':role'] = $role;
        }
        return [implode(' AND ', $where), $params];
    }

    public static function getRoles(int $userId): array {
        return self::query('SELECT r.ma, r.ma_vai_tro, r.ten_vai_tro FROM vai_tro r
            JOIN nguoi_dung_vai_tro x ON x.vai_tro_id = r.ma WHERE x.nguoi_dung_id = :uid ORDER BY r.ma', [':uid' => $userId]);
    }

    public static function addRole(int $userId, int $roleId): bool {
        return self::run('INSERT IGNORE INTO nguoi_dung_vai_tro (nguoi_dung_id, vai_tro_id) VALUES (:uid, :rid)', [':uid' => $userId, ':rid' => $roleId]) >= 0;
    }

    /** Replace a user's roles. Refuses to remove the last administrator. */
    public static function syncRoles(int $userId, array $roleIds): bool {
        return self::transaction(function () use ($userId, $roleIds) {
            $adminRole = RoleModel::findByCode('admin');
            if (!$adminRole) {
                throw new RuntimeException('Không tìm thấy vai trò quản trị viên.');
            }
            $adminId = (int)$adminRole['ma'];
            self::query('SELECT ma FROM vai_tro WHERE ma = :rid FOR UPDATE', [':rid' => $adminId]);
            $current = array_map('intval', self::column('SELECT vai_tro_id FROM nguoi_dung_vai_tro WHERE nguoi_dung_id = :uid', [':uid' => $userId]));
            if (in_array($adminId, $current, true) && !in_array($adminId, $roleIds, true)) {
                $admins = (int)self::scalar("SELECT COUNT(*) FROM nguoi_dung_vai_tro x JOIN nguoi_dung u ON u.ma = x.nguoi_dung_id WHERE x.vai_tro_id = :rid AND u.trang_thai = 'active'", [':rid' => $adminId]);
                if ($admins <= 1) {
                    return false;
                }
            }
            self::run('DELETE FROM nguoi_dung_vai_tro WHERE nguoi_dung_id = :uid', [':uid' => $userId]);
            foreach (array_unique($roleIds) as $roleId) {
                self::run('INSERT INTO nguoi_dung_vai_tro (nguoi_dung_id, vai_tro_id) VALUES (:uid, :rid)', [':uid' => $userId, ':rid' => (int)$roleId]);
            }
            return true;
        });
    }
}
