# Digital Game Distribution Platform

An open-source digital game distribution platform built with PHP and MySQL, inspired by Steam and itch.io.

Developed as part of the **Open Source Software Development** course.

## Contributors

- Nguyễn Thành Đạt
- Nguyễn Thị Ngọc Thảo
- Nguyễn Võ Hoàng Anh Thư
- Hồ Xuân Phúc

## Requirements

- PHP 8.2 or newer
- MySQL
- Composer 2.x
- [XAMPP](https://www.apachefriends.org/download.html) (Apache and MySQL)
- PHP extensions: `mbstring`, `openssl`

## Installation

1. Clone or download the project into the XAMPP `htdocs` directory.
2. Start **Apache** and **MySQL** from XAMPP Control Panel.
3. Open phpMyAdmin and create the project database using the `utf8mb4_unicode_ci` collation.
4. Import the SQL file containing the complete database schema and data from the `database/` directory.
5. Check the database configuration in `config/config.php`.
6. Install dependencies from the project root:

   ```bash
   composer install
   ```

7. Configure email by copying the example file:

   ```bash
   copy config\mail.example.php config\mail.php
   ```

   Update the SMTP settings in `config/mail.php` to enable password-reset emails.

8. Open the application:

   ```text
   http://localhost/<project-folder>/
   ```

9. Register an account to get started.

**Note:** Keep `public/uploads/` intact because the database references images stored in this directory.

## Demo accounts

`database/du_lieu.sql` ships with a complete set of sample accounts. Every one of them uses the same password:

```text
a1234567
```

Sign in at `http://localhost/<project-folder>/auth/login` with the username (or the email address) from the table below:

| Username | Email | Roles | What it demonstrates |
|---|---|---|---|
| `admin_test` | `admin_test@test.local` | player, admin | Full administration area: user management, game moderation, audits, reports, payouts |
| `mod_test` | `mod_test@test.local` | player, moderator | Moderation queue, content review, report handling |
| `dev_test` | `dev_test@test.local` | player, developer | Developer dashboard, own games, releases, download links, sales and payouts |
| `player_test` | `player_test@test.local` | player | Store browsing, cart, library, reviews, comments, forums |
| `demo_dev` | `demo_dev@mau.local` | developer | Minh Khang Studio — owner of the sample project, sees every download link and its moderation state |
| `demo_player` | `demo_player@mau.local` | player | Bảo An — already owns the sample game, so the download links are visible |
| `demo_mirror` | `demo_mirror@mau.local` | player | Chí Dũng — submitted a mirror that is still waiting for the developer to approve it |

## Admin Access

To grant administrator privileges, run the following SQL in phpMyAdmin after registering an account. Replace `YOUR_USERNAME` with the account's username.

```sql
INSERT IGNORE INTO nguoi_dung_vai_tro (nguoi_dung_id, vai_tro_id)
SELECT u.ma, r.ma
FROM nguoi_dung u
JOIN vai_tro r ON r.ma_vai_tro = 'admin'
WHERE u.ten_dang_nhap = 'YOUR_USERNAME';
```
