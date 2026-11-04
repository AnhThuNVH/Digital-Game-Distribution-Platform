<?php
// =============================================================================
// PASSWORD RESET MODEL - Table: ma_xac_nhan_dat_lai_mat_khau
//
// Mỗi lần yêu cầu đặt lại mật khẩu tạo một mã xác nhận 6 chữ số. Mã được lưu
// dạng băm (bcrypt) nên đọc được database cũng không dùng lại được mã.
// =============================================================================

class PasswordResetModel extends Model {
    protected static $table = 'ma_xac_nhan_dat_lai_mat_khau';
    protected static $pk = 'ma';

    /** Thời hạn của mã xác nhận (phút). */
    public const TTL_MINUTES = 10;
    /** Số lần nhập sai tối đa trước khi mã bị vô hiệu. */
    public const MAX_ATTEMPTS = 5;

    /** Tạo mã mới cho tài khoản; các mã cũ chưa dùng bị vô hiệu. */
    public static function issue(int $userId, string $email, string $code, string $expiresAt): int {
        return self::transaction(function () use ($userId, $email, $code, $expiresAt) {
            self::invalidateAll($userId);
            self::run('DELETE FROM ' . self::$table . ' WHERE nguoi_dung_id = :u AND ngay_het_han < NOW()', [':u' => $userId]);
            return self::insert([
                'nguoi_dung_id' => $userId,
                'email' => $email,
                'ma_bam' => password_hash($code, PASSWORD_DEFAULT),
                'ngay_het_han' => $expiresAt,
            ]);
        });
    }

    /** Vô hiệu mọi mã chưa dùng của tài khoản. */
    public static function invalidateAll(int $userId): int {
        return self::run(
            'UPDATE ' . self::$table . ' SET da_su_dung = 1 WHERE nguoi_dung_id = :u AND da_su_dung = 0',
            [':u' => $userId]
        );
    }

    /** Các mã còn hiệu lực của tài khoản, mới nhất trước. */
    public static function pending(int $userId): array {
        return self::query(
            'SELECT * FROM ' . self::$table . ' WHERE nguoi_dung_id = :u AND da_su_dung = 0 AND ngay_het_han > NOW() ORDER BY ma DESC',
            [':u' => $userId]
        );
    }

    /** Mã còn hiệu lực tương ứng với email đã yêu cầu. */
    public static function pendingForEmail(int $userId, string $email): array {
        return self::query(
            'SELECT * FROM ' . self::$table . ' WHERE nguoi_dung_id = :u AND email = :e AND da_su_dung = 0 AND ngay_het_han > NOW() ORDER BY ma DESC',
            [':u' => $userId, ':e' => $email]
        );
    }

    /** Thời điểm yêu cầu gửi mã gần nhất của tài khoản (null nếu chưa có). */
    public static function lastRequestedAt(int $userId): ?int {
        $value = self::scalar(
            'SELECT UNIX_TIMESTAMP(MAX(ngay_tao)) FROM ' . self::$table . ' WHERE nguoi_dung_id = :u',
            [':u' => $userId]
        );
        return $value === null ? null : (int)$value;
    }

    /** Đánh dấu mã đã dùng. */
    public static function markUsed(int $id): bool {
        return self::update($id, ['da_su_dung' => 1]);
    }

    /** Ghi nhận một lần nhập sai; vượt số lần cho phép thì mã bị vô hiệu. */
    public static function registerFailure(int $id): void {
        self::run(
            'UPDATE ' . self::$table . ' SET so_lan_thu = so_lan_thu + 1, da_su_dung = IF(so_lan_thu + 1 >= ' . self::MAX_ATTEMPTS . ', 1, da_su_dung) WHERE ma = :id',
            [':id' => $id]
        );
    }
}
