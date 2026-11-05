-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 05, 2026 at 03:57 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `game_distribution_platform_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `bai_du_thi`
--

CREATE TABLE `bai_du_thi` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `cuoc_thi_id` bigint(20) UNSIGNED NOT NULL,
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `nguoi_nop_id` bigint(20) UNSIGNED NOT NULL,
  `trang_thai` enum('submitted','withdrawn','disqualified') NOT NULL DEFAULT 'submitted',
  `ngay_nop` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bai_du_thi`
--

INSERT INTO `bai_du_thi` (`ma`, `cuoc_thi_id`, `tro_choi_id`, `nguoi_nop_id`, `trang_thai`, `ngay_nop`) VALUES
(3, 2, 4, 10, 'submitted', '2025-01-11 08:56:06'),
(4, 2, 51, 86, 'submitted', '2025-01-11 07:51:29'),
(5, 3, 5, 11, 'submitted', '2025-02-10 04:18:11'),
(6, 4, 8, 14, 'submitted', '2025-03-12 09:38:08'),
(7, 4, 6, 12, 'submitted', '2025-03-12 05:30:20'),
(8, 5, 9, 15, 'submitted', '2025-04-11 08:07:15'),
(9, 6, 7, 13, 'submitted', '2025-05-11 05:09:56'),
(10, 7, 4, 10, 'submitted', '2025-06-10 05:47:51'),
(11, 7, 9, 15, 'submitted', '2025-06-10 05:05:56'),
(12, 8, 6, 12, 'submitted', '2025-07-10 04:10:57'),
(13, 9, 9, 15, 'submitted', '2025-08-09 08:37:21'),
(14, 10, 10, 16, 'submitted', '2025-09-08 05:37:36'),
(15, 11, 7, 13, 'submitted', '2025-10-08 03:13:07'),
(16, 11, 3, 9, 'submitted', '2025-10-08 05:16:51'),
(17, 12, 52, 87, 'submitted', '2025-11-07 06:35:57'),
(18, 13, 5, 11, 'submitted', '2025-12-07 02:59:37'),
(19, 14, 4, 10, 'submitted', '2026-01-06 02:34:35'),
(20, 15, 5, 11, 'submitted', '2026-02-05 05:28:24'),
(21, 15, 10, 16, 'submitted', '2026-02-05 09:30:00'),
(22, 16, 51, 86, 'submitted', '2026-03-07 08:39:13'),
(23, 17, 3, 9, 'submitted', '2026-04-06 04:05:45'),
(24, 17, 47, 82, 'submitted', '2026-04-06 07:53:54'),
(25, 18, 50, 85, 'submitted', '2026-05-06 02:24:13'),
(26, 19, 8, 14, 'submitted', '2026-06-05 05:41:36'),
(27, 19, 10, 16, 'submitted', '2026-06-05 06:47:22'),
(28, 20, 52, 87, 'submitted', '2026-07-05 02:34:43'),
(29, 21, 8, 14, 'submitted', '2026-10-30 04:26:17'),
(30, 21, 3, 9, 'submitted', '2026-10-30 07:28:01'),
(31, 21, 6, 12, 'submitted', '2026-10-30 13:35:52'),
(32, 22, 52, 87, 'submitted', '2026-10-29 02:51:25'),
(33, 22, 50, 85, 'submitted', '2026-10-29 09:11:36');

-- --------------------------------------------------------

--
-- Table structure for table `bai_viet_thao_luan`
--

CREATE TABLE `bai_viet_thao_luan` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `chu_de_id` bigint(20) UNSIGNED NOT NULL,
  `tac_gia_nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `bai_viet_cha_id` bigint(20) UNSIGNED DEFAULT NULL,
  `noi_dung` mediumtext NOT NULL,
  `trang_thai` enum('published','hidden','removed') NOT NULL DEFAULT 'published',
  `ngay_chinh_sua` datetime DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bai_viet_thao_luan`
--

INSERT INTO `bai_viet_thao_luan` (`ma`, `chu_de_id`, `tac_gia_nguoi_dung_id`, `bai_viet_cha_id`, `noi_dung`, `trang_thai`, `ngay_chinh_sua`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(19, 6, 20, NULL, 'Tiệm net và mấy game chiến thuật cài sẵn. Mỗi giờ vài nghìn đồng, chơi tới khi bị mẹ tìm.', 'published', NULL, '2026-08-11 10:01:26', '2026-08-11 10:01:26'),
(20, 6, 32, NULL, 'Máy tính bảng của anh trai. Game đua xe là thứ đầu tiên mình chơi.', 'published', NULL, '2026-08-11 22:39:26', '2026-08-11 22:39:26'),
(21, 6, 49, NULL, 'An old family PC with a CD drive. Strategy games with huge manuals.', 'published', NULL, '2026-08-12 02:01:26', '2026-08-12 02:01:26'),
(22, 6, 31, 21, 'Thời đó sách hướng dẫn dày như từ điển, đọc còn vui hơn chơi.', 'published', NULL, '2026-08-12 16:05:26', '2026-08-12 16:05:26'),
(23, 6, 34, NULL, 'Mình bắt đầu muộn, trên Linux luôn. Game đầu tiên là SuperTuxKart vì có sẵn trong kho phần mềm.', 'published', NULL, '2026-08-13 13:20:26', '2026-08-13 13:20:26'),
(24, 6, 19, 23, 'Đồng môn rồi.', 'published', NULL, '2026-08-13 22:50:26', '2026-08-13 22:50:26'),
(25, 7, 27, NULL, 'Luanti chế độ sáng tạo. Không có quái, không có mục tiêu, chỉ xây.', 'published', NULL, '2026-09-01 08:33:26', '2026-09-01 08:33:26'),
(26, 7, 19, NULL, 'SuperTuxKart một hai cúp là vừa, mỗi cúp tầm mười phút.', 'published', NULL, '2026-09-01 12:53:26', '2026-09-01 12:53:26'),
(27, 7, 21, 25, 'Đồng ý với Luanti. Bật nhạc nhẹ lên là quên giờ luôn.', 'published', NULL, '2026-09-02 14:02:26', '2026-09-02 14:02:26'),
(28, 7, 22, NULL, 'OpenTTD cũng được nếu bạn thích xếp đặt, nhưng cẩn thận vì rất dễ chơi quá giờ.', 'published', NULL, '2026-09-03 07:24:26', '2026-09-03 07:24:26'),
(29, 7, 35, NULL, 'Cảm ơn mọi người, tối nay thử Luanti trước.', 'published', NULL, '2026-09-03 19:32:26', '2026-09-03 19:32:26'),
(30, 8, 24, NULL, 'Instagib cho người mới là chuẩn bài, một phát là xong nên ai cũng có cơ hội.', 'published', NULL, '2026-10-13 23:45:26', '2026-10-13 23:45:26'),
(31, 8, 19, NULL, 'Chế độ đá bóng của STK đúng là vũ khí phá băng của mọi buổi tụ tập.', 'published', NULL, '2026-10-14 22:25:26', '2026-10-14 22:25:26'),
(32, 8, 38, NULL, 'Lần sau thử Wesnoth chơi mạng nhưng chắc phải chơi từ chiều.', 'published', NULL, '2026-10-15 10:56:26', '2026-10-15 10:56:26'),
(33, 8, 28, 32, 'Wesnoth chơi LAN thì nên chọn bản đồ nhỏ cho 2 người, bản 4 người kéo dài lắm.', 'published', NULL, '2026-10-16 13:58:26', '2026-10-16 13:58:26'),
(34, 8, 50, NULL, 'LAN parties are the best. We still do one every few months in Monterrey.', 'published', NULL, '2026-10-17 07:45:26', '2026-10-17 07:45:26'),
(35, 9, 44, NULL, 'Soundtracks are my study music. Calm strategy game music works best for me.', 'published', NULL, '2026-09-11 16:10:26', '2026-09-11 16:10:26'),
(36, 9, 29, NULL, 'Là người làm nhạc game, đọc topic này vui ghê. Nhạc nền tốt là nhạc không giành sự chú ý của người chơi.', 'published', NULL, '2026-09-12 16:04:26', '2026-09-12 16:04:26'),
(37, 9, 21, 36, 'Câu này hay quá, nghĩ lại đúng là vậy.', 'published', NULL, '2026-09-12 18:09:26', '2026-09-12 18:09:26'),
(38, 9, 20, NULL, 'Nhạc của 0 A.D. nghe rất có không khí cổ đại, mình hay bật khi đọc sách.', 'published', NULL, '2026-09-12 19:01:26', '2026-09-12 19:01:26'),
(39, 11, 25, NULL, 'Báo cáo xong thì mình có biết kết quả không ạ?', 'published', NULL, '2026-07-07 10:14:26', '2026-07-07 10:14:26'),
(40, 11, 7, 39, 'Hiện tại kết quả xử lý được ghi trong hệ thống kiểm duyệt. Nếu nội dung bị ẩn thì bạn sẽ không còn thấy nó nữa.', 'published', NULL, '2026-07-07 17:49:26', '2026-07-07 17:49:26'),
(41, 12, 34, NULL, 'File .tar.xz là định dạng nén phổ biến trên Linux. Trên Windows bạn dùng 7-Zip để giải nén. Nhưng nếu đó là bản Linux thì giải nén xong cũng không chạy được trên Windows, bạn nên tải lại bản Windows.', 'published', NULL, '2026-09-03 12:26:26', '2026-09-03 12:26:26'),
(42, 12, 35, 41, 'À ra vậy, mình tải nhầm bản. Cảm ơn bạn nhiều!', 'published', NULL, '2026-09-03 13:46:26', '2026-09-03 13:46:26'),
(43, 12, 41, NULL, 'Tip: on the game page, files are usually labeled by platform. Look for the Windows icon.', 'published', NULL, '2026-09-04 05:57:26', '2026-09-04 05:57:26'),
(44, 13, 24, NULL, 'Thử ép game chạy bằng card rời. Trên Windows vào Cài đặt > Hiển thị > Đồ họa, chọn file chạy của game và đặt Hiệu năng cao.', 'published', NULL, '2026-08-25 05:57:26', '2026-08-25 05:57:26'),
(45, 13, 34, NULL, 'On Linux with PRIME you can start it with the dedicated GPU. The exact command depends on your driver, check your distro wiki.', 'published', NULL, '2026-08-25 14:01:26', '2026-08-25 14:01:26'),
(46, 13, 41, 45, 'I am on Linux, the PRIME option fixed it. Thanks!', 'published', NULL, '2026-08-25 23:16:26', '2026-08-25 23:16:26'),
(47, 13, 50, NULL, 'Also try turning off vsync, it helped on my old laptop.', 'published', NULL, '2026-08-27 04:39:26', '2026-08-27 04:39:26'),
(48, 14, 34, NULL, 'Bạn vào mục Thư viện trên thanh menu. Game đã nhận sẽ nằm ở đó, bấm vào để xem các bản phát hành và tệp tải.', 'published', NULL, '2026-08-04 11:15:26', '2026-08-04 11:15:26'),
(49, 14, 25, 48, 'Thấy rồi, cảm ơn bạn!', 'published', NULL, '2026-08-05 14:30:26', '2026-08-05 14:30:26'),
(50, 14, 27, NULL, 'Mình cũng từng bị y vậy hồi mới vào, topic này nên ghim.', 'published', NULL, '2026-08-06 16:58:26', '2026-08-06 16:58:26'),
(51, 15, 47, NULL, 'Yes, the portable build may not include base graphics. Use the in-game online content download and get OpenGFX. It is free and open source.', 'published', NULL, '2026-09-23 15:00:26', '2026-09-23 15:00:26'),
(52, 15, 22, 51, 'Tải OpenGFX xong là vào được rồi. Cảm ơn Tomasz.', 'published', NULL, '2026-09-24 16:08:26', '2026-09-24 16:08:26'),
(53, 15, 34, NULL, 'Âm thanh và nhạc cũng tương tự, có OpenSFX và OpenMSX.', 'published', NULL, '2026-09-25 03:36:26', '2026-09-25 03:36:26'),
(54, 16, 41, NULL, 'Agree. Flatpak is my default for games now.', 'published', NULL, '2026-08-26 07:58:26', '2026-08-26 07:58:26'),
(55, 16, 26, NULL, 'Với Luanti thì mình dùng bản trong kho vì cần thư viện để build mod, nhưng người chơi bình thường dùng Flatpak là ổn.', 'published', NULL, '2026-08-27 03:10:26', '2026-08-27 03:10:26'),
(56, 16, 31, NULL, 'Bài hữu ích, cảm ơn anh Long.', 'published', NULL, '2026-08-28 07:05:26', '2026-08-28 07:05:26'),
(63, 18, 23, NULL, 'Màu đẹp quá. Giới hạn 16 màu mà vẫn có chiều sâu.', 'published', NULL, '2026-08-07 03:59:26', '2026-08-07 03:59:26'),
(64, 18, 31, NULL, 'Nhìn rất có cảm giác máy chơi game ngày xưa.', 'published', NULL, '2026-08-07 13:00:26', '2026-08-07 13:00:26'),
(65, 18, 37, NULL, 'Kiên trì 30 ngày là đáng nể rồi.', 'published', NULL, '2026-08-08 03:50:26', '2026-08-08 03:50:26'),
(66, 18, 18, 63, 'Cảm ơn mọi người, tháng sau thử vẽ nhân vật.', 'published', NULL, '2026-08-08 08:56:26', '2026-08-08 08:56:26'),
(67, 19, 42, NULL, 'This is so kind. Will credit you in my next jam game.', 'published', NULL, '2026-07-28 05:30:26', '2026-07-28 05:30:26'),
(68, 19, 17, NULL, 'Mình xin một bản cho màn cuối của platformer nhé.', 'published', NULL, '2026-07-28 13:45:26', '2026-07-28 13:45:26'),
(69, 19, 44, NULL, 'Listened to all five, the third one is my favorite.', 'published', NULL, '2026-07-28 19:28:26', '2026-07-28 19:28:26'),
(70, 19, 29, 68, 'Cứ dùng thoải mái, gửi link game cho mình nghe thử với.', 'published', NULL, '2026-07-29 01:39:26', '2026-07-29 01:39:26'),
(71, 20, 19, NULL, 'Nhìn ngon! Bánh xe hơi to so với thân, thu nhỏ một chút sẽ cân hơn.', 'published', NULL, '2026-10-23 12:53:26', '2026-10-23 12:53:26'),
(72, 20, 48, NULL, 'Love the flat colors. Maybe add a small bevel on the edges for nicer highlights.', 'published', NULL, '2026-10-24 12:06:26', '2026-10-24 12:06:26'),
(73, 20, 37, 71, 'Mình chỉnh lại bánh xe rồi, đúng là cân hơn hẳn.', 'published', NULL, '2026-10-25 15:51:26', '2026-10-25 15:51:26'),
(74, 21, 27, NULL, 'Nghe ý tưởng đã thấy thích. Có bản chơi thử chưa bạn?', 'published', NULL, '2026-09-02 13:15:26', '2026-09-02 13:15:26'),
(75, 21, 48, 74, 'Not yet, aiming for a demo next month!', 'published', NULL, '2026-09-02 19:24:26', '2026-09-02 19:24:26'),
(76, 21, 23, NULL, 'Farming plus roguelike is a great mix. Good luck!', 'published', NULL, '2026-09-03 10:16:26', '2026-09-03 10:16:26'),
(77, 21, 17, NULL, 'Cân bằng để không bắt buộc mà vẫn có ích là bài toán khó nhất, đồng cảm.', 'published', NULL, '2026-09-04 03:22:26', '2026-09-04 03:22:26'),
(78, 22, 23, NULL, 'Mình quan tâm phần vẽ nhân vật. Kịch bản có mấy nhân vật vậy bạn?', 'published', NULL, '2026-07-20 03:58:26', '2026-07-20 03:58:26'),
(79, 22, 33, 78, 'Bốn nhân vật chính, mỗi người hai ba biểu cảm là đủ.', 'published', NULL, '2026-07-20 16:47:26', '2026-07-20 16:47:26'),
(80, 22, 17, NULL, 'Lập trình visual novel thì dùng Ren\'Py là nhanh nhất, mình có thể giúp phần setup ban đầu.', 'published', NULL, '2026-07-21 08:04:26', '2026-07-21 08:04:26'),
(81, 22, 33, NULL, 'Tuyệt quá, mình nhắn hai bạn nhé.', 'published', NULL, '2026-07-21 14:57:26', '2026-07-21 14:57:26'),
(82, 23, 18, NULL, 'Texture 16x16 là sở trường của mình. Nhắn mình nhé.', 'published', NULL, '2026-09-25 21:46:26', '2026-09-25 21:46:26'),
(83, 23, 51, NULL, 'I can help test on my server, I have a few friends who love farming mods.', 'published', NULL, '2026-09-26 08:42:26', '2026-09-26 08:42:26'),
(84, 23, 26, 82, 'Hai bạn quá tuyệt, mình mở repo rồi gửi link riêng.', 'published', NULL, '2026-09-26 22:58:26', '2026-09-26 22:58:26'),
(91, 25, 18, NULL, 'Two weeks one screen sounds doable. What is the theme?', 'published', NULL, '2026-10-15 21:59:26', '2026-10-15 21:59:26'),
(92, 25, 42, 91, 'Theme is announced at the start, but I want to keep the art style simple and readable.', 'published', NULL, '2026-10-16 10:58:26', '2026-10-16 10:58:26'),
(93, 25, 29, NULL, 'If you need music too, I can help.', 'published', NULL, '2026-10-17 09:23:26', '2026-10-17 09:23:26'),
(97, 27, 39, NULL, 'Yes please! Although I am learning Vietnamese with this site now.', 'published', NULL, '2026-09-24 09:48:26', '2026-09-24 09:48:26'),
(98, 27, 25, NULL, 'Ủng hộ, cộng đồng quốc tế ngày càng đông.', 'published', NULL, '2026-09-25 13:59:26', '2026-09-25 13:59:26'),
(99, 28, 21, NULL, 'Thêm ô tìm kiếm trong thư viện nữa là đẹp.', 'published', NULL, '2026-10-11 01:54:26', '2026-10-11 01:54:26'),
(100, 28, 34, NULL, '+1', 'published', NULL, '2026-10-12 02:10:26', '2026-10-12 02:10:26'),
(101, 29, 52, NULL, 'I go heavy on food early, then switch to wood once the fields are up.', 'published', NULL, '2026-10-04 17:11:26', '2026-10-04 17:11:26'),
(102, 29, 43, NULL, 'Do not forget cavalry for hunting at the start, it speeds up food a lot.', 'published', NULL, '2026-10-05 02:32:26', '2026-10-05 02:32:26'),
(103, 29, 20, 102, 'Dùng kỵ binh săn thú đầu game đúng là tăng tốc rõ rệt.', 'published', NULL, '2026-10-05 12:18:26', '2026-10-05 12:18:26'),
(104, 29, 28, NULL, 'Mình chơi Athens nhưng ý tưởng chung giống vậy, quan trọng là không để dân làng đứng không.', 'published', NULL, '2026-10-06 14:38:26', '2026-10-06 14:38:26'),
(113, 32, 19, NULL, 'Black Forest có mấy khúc cua liên tiếp, mình hay mất đà ở đó.', 'published', NULL, '2026-10-21 23:14:26', '2026-10-21 23:14:26'),
(114, 32, 32, 113, 'Mấy khúc đó phải drift sớm hơn mình tưởng.', 'published', NULL, '2026-10-22 13:17:26', '2026-10-22 13:17:26'),
(115, 32, 39, NULL, 'Still learning the tracks. Lighthouse is my favorite so far.', 'published', NULL, '2026-10-23 01:34:26', '2026-10-23 01:34:26'),
(116, 33, 19, NULL, 'Mình thích các đường đua cộng đồng làm theo chủ đề mùa đông. Cứ vào mục Add-on, sắp xếp theo đánh giá là ra nhiều cái hay.', 'published', NULL, '2026-09-06 01:41:26', '2026-09-06 01:41:26'),
(117, 33, 37, NULL, 'Mình đang học làm kart để đóng góp lên đó, chiếc kart low-poly ở mục Khoe dự án là bước đầu.', 'published', NULL, '2026-09-07 03:08:26', '2026-09-07 03:08:26'),
(118, 34, 49, NULL, 'Time of day is everything. Lawful units fight much better during the day.', 'published', NULL, '2026-11-01 15:56:26', '2026-11-01 15:56:26'),
(119, 34, 46, NULL, 'Also, do not neglect healers. A White Mage line unit saves so many veterans.', 'published', NULL, '2026-11-01 21:55:26', '2026-11-01 21:55:26'),
(120, 34, 28, 119, 'Đơn vị hồi máu đi cạnh tiền tuyến là tiết kiệm rất nhiều lượt.', 'published', NULL, '2026-11-02 06:31:26', '2026-11-02 06:31:26'),
(121, 34, 36, NULL, 'Đọc mà muốn chơi lại từ đầu.', 'published', NULL, '2026-11-02 12:08:26', '2026-11-02 12:08:26'),
(122, 35, 28, NULL, 'Loyalists khá dễ hiểu: nhiều loại đơn vị rõ vai trò, lại có kỵ binh để trinh sát.', 'published', NULL, '2026-09-03 05:16:26', '2026-09-03 05:16:26'),
(123, 35, 46, NULL, 'I started with Northerners, cheap units so mistakes hurt less.', 'published', NULL, '2026-09-03 15:34:26', '2026-09-03 15:34:26'),
(124, 35, 49, 123, 'Cheap units forgiving mistakes, that sounds like exactly what I need.', 'published', NULL, '2026-09-04 07:20:26', '2026-09-04 07:20:26'),
(125, 36, 26, NULL, 'Là một dự án. Minetest được đổi tên thành Luanti vào năm 2024. Các hướng dẫn cũ vẫn dùng được phần lớn.', 'published', NULL, '2026-09-15 02:29:26', '2026-09-15 02:29:26'),
(126, 36, 51, NULL, 'Same engine, new name. Mods and games from ContentDB still work.', 'published', NULL, '2026-09-15 22:05:26', '2026-09-15 22:05:26'),
(127, 36, 21, 125, 'Cảm ơn hai bạn, giờ thì yên tâm làm theo hướng dẫn cũ.', 'published', NULL, '2026-09-16 02:10:26', '2026-09-16 02:10:26'),
(128, 37, 51, NULL, 'Area protection is a must if you play with more than three people.', 'published', NULL, '2026-10-23 02:51:26', '2026-10-23 02:51:26'),
(129, 37, 21, NULL, 'Có mod trang trí nội thất nào hay không anh?', 'published', NULL, '2026-10-23 08:20:26', '2026-10-23 08:20:26'),
(130, 37, 26, 129, 'Có nhiều, vào ContentDB tìm từ khóa furniture, chọn cái nhiều đánh giá.', 'published', NULL, '2026-10-24 12:21:26', '2026-10-24 12:21:26'),
(131, 38, 45, NULL, 'Nice. I always forget power for the smelters and wonder why nothing works.', 'published', NULL, '2026-10-22 08:40:26', '2026-10-22 08:40:26'),
(132, 38, 39, NULL, 'Saving this idea. My silicon line is still spaghetti.', 'published', NULL, '2026-10-22 19:50:26', '2026-10-22 19:50:26'),
(133, 38, 30, 131, 'Điện là thứ ai cũng quên, mình cũng vậy.', 'published', NULL, '2026-10-22 21:27:26', '2026-10-22 21:27:26'),
(134, 39, 30, NULL, 'Erekir có cơ chế khác hẳn, nên chơi chậm và đọc kỹ thông tin từng khối trước khi xây.', 'published', NULL, '2026-10-20 07:58:26', '2026-10-20 07:58:26'),
(135, 39, 39, NULL, 'Same feeling here. Taking it slower helped.', 'published', NULL, '2026-10-20 20:05:26', '2026-10-20 20:05:26'),
(136, 40, 47, NULL, 'Good summary. Also: one-way path signals on main lines prevent trains from turning around in weird places.', 'published', NULL, '2026-09-13 22:36:26', '2026-09-13 22:36:26'),
(137, 40, 22, 136, 'Đúng rồi, tàu quay đầu giữa đường là thảm họa.', 'published', NULL, '2026-09-14 10:25:26', '2026-09-14 10:25:26'),
(138, 40, 41, NULL, 'This finally makes sense to me. Bookmarking.', 'published', NULL, '2026-09-15 03:26:26', '2026-09-15 03:26:26'),
(139, 40, 49, NULL, 'Spent two hours debugging a deadlock yesterday. It was one wrong signal.', 'published', NULL, '2026-09-15 22:43:26', '2026-09-15 22:43:26'),
(140, 41, 22, NULL, 'Mạng của mình nhỏ hơn nhưng có một ga trung tâm 12 đường. Thiết kế mất cả buổi tối.', 'published', NULL, '2026-08-28 11:06:26', '2026-08-28 11:06:26'),
(141, 41, 49, NULL, 'Mostly buses here. I like small towns connected by road.', 'published', NULL, '2026-08-29 16:27:26', '2026-08-29 16:27:26'),
(142, 42, 50, NULL, 'Good list. Practice a little every day instead of long sessions.', 'published', NULL, '2026-07-26 01:21:26', '2026-07-26 01:21:26'),
(143, 42, 38, NULL, 'Nhìn bạn Đức Anh bay khắp bản đồ ở buổi LAN là biết tập thật.', 'published', NULL, '2026-07-26 14:44:26', '2026-07-26 14:44:26'),
(144, 42, 24, 143, 'Haha vẫn còn đâm tường nhiều lắm.', 'published', NULL, '2026-07-27 06:53:26', '2026-07-27 06:53:26'),
(145, 43, 24, NULL, 'Instagib cho buổi đầu để vui, sau đó chuyển sang bình thường để học vũ khí.', 'published', NULL, '2026-09-01 20:13:26', '2026-09-01 20:13:26'),
(146, 43, 38, NULL, 'Nhóm mình làm y vậy và hiệu quả.', 'published', NULL, '2026-09-02 05:49:26', '2026-09-02 05:49:26'),
(147, 44, 46, NULL, 'civ2civ3 is what most multiplayer games I joined use. Worth learning.', 'published', NULL, '2026-07-28 17:33:26', '2026-07-28 17:33:26'),
(148, 44, 49, NULL, 'Classic is simpler to start with if you just want to learn the basics.', 'published', NULL, '2026-07-29 11:34:26', '2026-07-29 11:34:26'),
(149, 44, 36, 147, 'Vậy mình học classic trước rồi chuyển sang civ2civ3.', 'published', NULL, '2026-07-30 08:58:26', '2026-07-30 08:58:26'),
(153, 46, 21, NULL, 'Mình đang xây một ngôi làng trên núi trong Luanti, chơi chế độ sáng tạo nên rất thư giãn.', 'published', NULL, '2026-11-02 03:26:19', '2026-11-02 03:26:19'),
(154, 46, 19, NULL, 'SuperTuxKart như mọi tuần. Tối thứ Sáu nhóm mình có đua online, ai muốn vào thì nhắn nhé.', 'published', NULL, '2026-11-02 04:11:19', '2026-11-02 04:11:19'),
(155, 46, 20, 154, 'Tường thành là chân ái, nhưng nhớ để cổng không thì quân mình kẹt luôn trong thành.', 'published', NULL, '2026-11-02 05:04:19', '2026-11-02 05:04:19'),
(156, 46, 39, NULL, 'Playing Mindustry this week. My conveyors look like spaghetti.', 'published', NULL, '2026-11-02 05:48:19', '2026-11-02 05:48:19'),
(157, 46, 30, 156, 'Spaghetti cũng là một phong cách, miễn là chạy được.', 'published', NULL, '2026-11-02 06:18:19', '2026-11-02 06:18:19'),
(158, 46, 35, NULL, 'Mình không chơi gì nặng, chỉ vài ván Freeciv trước khi ngủ. Nói là vài ván nhưng thường thành ba tiếng.', 'published', NULL, '2026-11-02 08:55:19', '2026-11-02 08:55:19'),
(159, 46, 36, 158, 'Một lượt nữa thôi, câu nói kinh điển.', 'published', NULL, '2026-11-02 09:18:19', '2026-11-02 09:18:19'),
(160, 46, 24, NULL, 'Xonotic. Đang tập di chuyển, bắn trúng thì tính sau.', 'published', NULL, '2026-11-02 11:59:19', '2026-11-02 11:59:19'),
(161, 47, 19, NULL, 'Chào mừng Kaito! Welcome, cứ viết tiếng Anh thoải mái nhé.', 'published', NULL, '2026-11-02 23:17:19', '2026-11-02 23:17:19'),
(162, 47, 40, NULL, 'Welcome! Another Asian neighbor here, hello from Seoul.', 'published', NULL, '2026-11-03 00:23:19', '2026-11-03 00:23:19'),
(163, 47, 39, 161, 'Thank you! Cảm ơn (I hope this is correct).', 'published', NULL, '2026-11-03 01:52:19', '2026-11-03 01:52:19'),
(164, 47, 25, 163, 'Đúng rồi đó Kaito, viết chuẩn luôn.', 'published', NULL, '2026-11-03 02:59:19', '2026-11-03 02:59:19'),
(165, 47, 41, NULL, 'Welcome! The forum boards per game are really useful, check them out.', 'published', NULL, '2026-11-03 03:35:19', '2026-11-03 03:35:19'),
(166, 48, 48, NULL, 'Coyote time and jump buffering! A few frames of grace make a huge difference.', 'published', NULL, '2026-11-02 07:15:19', '2026-11-02 07:15:19'),
(167, 48, 42, NULL, 'Also make the fall faster than the rise. Higher gravity when falling feels much better.', 'published', NULL, '2026-11-02 09:43:19', '2026-11-02 09:43:19'),
(168, 48, 17, 166, 'Mình chưa có coyote time, để thêm thử. Cảm ơn hai bạn.', 'published', NULL, '2026-11-02 10:59:19', '2026-11-02 10:59:19'),
(169, 48, 18, NULL, 'Nếu cần vẽ lại sprite nhân vật thì nhắn mình, đang muốn tập vẽ animation.', 'published', NULL, '2026-11-02 13:05:19', '2026-11-02 13:05:19'),
(170, 48, 17, 169, 'Có chứ! Mình nhắn bạn ngay.', 'published', NULL, '2026-11-02 15:48:19', '2026-11-02 15:48:19'),
(171, 48, 32, NULL, 'Thêm chế độ tính giờ đi, dân speedrun sẽ cày cho.', 'published', NULL, '2026-11-02 17:28:19', '2026-11-02 17:28:19'),
(172, 49, 19, NULL, 'Có mình, tên trong game giống tên ở đây.', 'published', NULL, '2026-11-02 13:35:19', '2026-11-02 13:35:19'),
(173, 49, 32, NULL, 'Đăng ký. Hứa không ăn gian bằng đường tắt.', 'published', NULL, '2026-11-02 14:27:19', '2026-11-02 14:27:19'),
(174, 49, 40, NULL, 'Is it okay if I join? Time zone is two hours ahead but 23:00 works for me.', 'published', NULL, '2026-11-02 14:54:19', '2026-11-02 14:54:19'),
(175, 49, 38, 174, 'Welcome Yuna, càng đông càng vui.', 'published', NULL, '2026-11-02 16:22:19', '2026-11-02 16:22:19'),
(176, 49, 35, NULL, 'Mình chơi dở nhưng muốn tham gia cho vui được không?', 'published', NULL, '2026-11-02 18:48:19', '2026-11-02 18:48:19'),
(177, 49, 19, 176, 'Được chứ, nhóm toàn người chơi cho vui thôi.', 'published', NULL, '2026-11-02 20:46:19', '2026-11-02 20:46:19'),
(178, 50, 35, NULL, 'Đồng ý, mình cũng cần cái này.', 'published', NULL, '2026-11-02 01:26:19', '2026-11-02 01:26:19'),
(179, 50, 43, NULL, 'Good idea. Developers could set an estimated playtime on the game page.', 'published', NULL, '2026-11-02 09:43:19', '2026-11-02 09:43:19'),
(180, 50, 7, 178, 'Đã ghi nhận đề xuất, cảm ơn bạn.', 'published', NULL, '2026-11-02 13:39:19', '2026-11-02 13:39:19'),
(181, 51, 20, NULL, 'Xây vài tháp canh gần chỗ khai thác và luôn để dân làng có thể rút vào trụ sở. Tháp và trụ sở có người bên trong sẽ bắn mạnh hơn.', 'published', NULL, '2026-11-02 18:56:19', '2026-11-02 18:56:19'),
(182, 51, 43, NULL, 'Scout the AI base early so you know which units to counter.', 'published', NULL, '2026-11-02 20:14:19', '2026-11-02 20:14:19'),
(183, 51, 52, 181, 'Garrisoning helped a lot. Survived the first attack for the first time!', 'published', NULL, '2026-11-02 22:28:19', '2026-11-02 22:28:19'),
(184, 51, 20, 183, 'Chúc mừng! Bước tiếp theo là phản công lúc AI vừa mất quân.', 'published', NULL, '2026-11-02 23:09:19', '2026-11-02 23:09:19'),
(185, 52, 35, NULL, 'Ồ mình chơi cả tháng mà không biết cái này. Cảm ơn!', 'published', NULL, '2026-11-01 06:12:19', '2026-11-01 06:12:19'),
(186, 52, 32, NULL, 'Thêm nữa: nhặt bình nitro trên đường và giữ lại cho đoạn thẳng dài.', 'published', NULL, '2026-11-01 11:06:19', '2026-11-01 11:06:19'),
(187, 52, 40, NULL, 'Drifting changed everything for me. Now I can finally beat the AI on harder difficulty.', 'published', NULL, '2026-11-01 14:42:19', '2026-11-01 14:42:19'),
(188, 52, 19, 186, 'Đúng rồi, đừng xài nitro ngay khi vừa nhặt.', 'published', NULL, '2026-11-01 23:49:19', '2026-11-01 23:49:19'),
(189, 53, 36, NULL, 'Mình tham gia! Một lượt một ngày thì không lo bị nghiện.', 'published', NULL, '2026-11-03 02:27:19', '2026-11-03 02:27:19'),
(190, 53, 49, NULL, 'Count me in.', 'published', NULL, '2026-11-03 03:05:19', '2026-11-03 03:05:19'),
(191, 53, 43, NULL, 'I would join if the timezone works for Europe.', 'published', NULL, '2026-11-03 04:09:19', '2026-11-03 04:09:19');

-- --------------------------------------------------------

--
-- Table structure for table `bao_cao_noi_dung`
--

CREATE TABLE `bao_cao_noi_dung` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `nguoi_bao_cao_id` bigint(20) UNSIGNED DEFAULT NULL,
  `loai_doi_tuong` enum('user','game','review','game_comment','devlog','community_topic','community_post') NOT NULL,
  `doi_tuong_id` bigint(20) UNSIGNED NOT NULL,
  `ma_ly_do` varchar(60) NOT NULL,
  `chi_tiet` mediumtext DEFAULT NULL,
  `trang_thai` enum('open','investigating','resolved','rejected') NOT NULL DEFAULT 'open',
  `nguoi_duoc_phan_cong_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_giai_quyet` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bao_cao_noi_dung`
--

INSERT INTO `bao_cao_noi_dung` (`ma`, `nguoi_bao_cao_id`, `loai_doi_tuong`, `doi_tuong_id`, `ma_ly_do`, `chi_tiet`, `trang_thai`, `nguoi_duoc_phan_cong_id`, `ngay_tao`, `ngay_giai_quyet`) VALUES
(3, 5, 'user', 8, 'abuse', '[KIỂM THỬ] Báo cáo thử tài khoản dev_test.', 'rejected', 6, '2026-11-03 11:30:50', '2026-11-03 18:32:21'),
(5, 51, 'review', 51, 'spam', 'Nội dung đánh giá có vẻ trùng với một bài khác.', 'resolved', 7, '2026-10-29 17:59:32', '2026-10-31 00:59:32'),
(6, 23, 'review', 87, 'other', 'Đánh giá tiết lộ cốt truyện mà không cảnh báo trước.', 'resolved', 7, '2026-10-22 16:13:05', '2026-10-24 23:13:05'),
(7, 35, 'review', 14, 'other', 'Đánh giá tiết lộ cốt truyện mà không cảnh báo trước.', 'resolved', 7, '2026-10-10 20:08:31', '2026-10-12 03:08:31'),
(8, 28, 'review', 114, 'spam', 'Nội dung đánh giá có vẻ trùng với một bài khác.', 'resolved', 7, '2026-10-17 01:18:28', '2026-10-18 08:18:28'),
(9, 19, 'review', 102, 'other', 'Đánh giá tiết lộ cốt truyện mà không cảnh báo trước.', 'resolved', 7, '2026-10-28 20:25:06', '2026-10-30 03:25:06'),
(10, 50, 'review', 46, 'spam', 'Nội dung đánh giá có vẻ trùng với một bài khác.', 'resolved', 7, '2026-10-24 23:49:28', '2026-10-26 06:49:28'),
(11, 23, 'review', 13, 'spam', 'Nội dung đánh giá có vẻ trùng với một bài khác.', 'resolved', 7, '2026-10-28 01:47:11', '2026-10-29 08:47:11'),
(12, 17, 'review', 93, 'other', 'Đánh giá tiết lộ cốt truyện mà không cảnh báo trước.', 'resolved', 7, '2026-10-18 20:01:07', '2026-10-20 03:01:07'),
(13, 38, 'review', 38, 'spam', 'Nội dung đánh giá có vẻ trùng với một bài khác.', 'resolved', 7, '2026-10-14 20:23:38', '2026-10-17 03:23:38'),
(14, 48, 'review', 10, 'spam', 'Nội dung đánh giá có vẻ trùng với một bài khác.', 'resolved', 7, '2026-10-20 19:22:11', '2026-10-23 02:22:11'),
(15, 23, 'user', 40, 'spam', 'Tài khoản đăng nhiều liên kết giống nhau trong thời gian ngắn.', 'rejected', 7, '2026-10-27 15:33:56', '2026-10-29 22:33:56'),
(16, 31, 'user', 23, 'spam', 'Tài khoản đăng nhiều liên kết giống nhau trong thời gian ngắn.', 'rejected', 7, '2026-10-21 19:38:35', '2026-10-25 02:38:35'),
(17, 25, 'review', 67, 'other', 'Đánh giá tiết lộ cốt truyện mà không cảnh báo trước.', 'rejected', 7, '2026-10-10 18:33:11', '2026-10-13 01:33:11'),
(18, 46, 'review', 79, 'spam', 'Nội dung đánh giá có vẻ trùng với một bài khác.', 'rejected', 7, '2026-10-25 19:20:19', '2026-10-29 02:20:19'),
(19, 19, 'game_comment', 95, 'other', 'Bình luận lạc đề, không liên quan đến trò chơi.', 'rejected', 7, '2026-10-16 16:06:27', '2026-10-19 23:06:27'),
(20, 27, 'game_comment', 53, 'other', 'Bình luận lạc đề, không liên quan đến trò chơi.', 'rejected', 7, '2026-10-12 19:12:02', '2026-10-16 02:12:02'),
(21, 19, 'game_comment', 24, 'spam', 'Bình luận lặp lại nhiều lần.', 'rejected', 7, '2026-10-10 23:30:18', '2026-10-14 06:30:18'),
(22, 49, 'game_comment', 89, 'other', 'Bình luận lạc đề, không liên quan đến trò chơi.', 'rejected', 7, '2026-10-12 23:53:01', '2026-10-15 06:53:01'),
(23, 28, 'game_comment', 45, 'spam', 'Bình luận lặp lại nhiều lần.', 'rejected', 7, '2026-10-23 23:01:00', '2026-10-27 06:01:00'),
(24, 49, 'game_comment', 110, 'other', 'Bình luận lạc đề, không liên quan đến trò chơi.', 'rejected', 7, '2026-10-19 22:11:42', '2026-10-21 05:11:42'),
(25, 46, 'game_comment', 39, 'other', 'Bình luận lạc đề, không liên quan đến trò chơi.', 'investigating', 7, '2026-10-24 18:50:59', NULL),
(26, 36, 'game_comment', 97, 'other', 'Bình luận lạc đề, không liên quan đến trò chơi.', 'investigating', 7, '2026-10-11 21:32:07', NULL),
(27, 32, 'game_comment', 25, 'other', 'Bình luận lạc đề, không liên quan đến trò chơi.', 'investigating', 7, '2026-10-28 15:57:02', NULL),
(28, 19, 'game_comment', 79, 'spam', 'Bình luận lặp lại nhiều lần.', 'investigating', 7, '2026-10-12 20:09:42', NULL),
(29, 37, 'community_post', 187, 'other', 'Bài viết nên chuyển sang chuyên mục phù hợp hơn.', 'investigating', 7, '2026-10-12 20:39:57', NULL),
(30, 36, 'community_post', 92, 'abuse', 'Lời lẽ hơi gay gắt với thành viên khác.', 'open', NULL, '2026-10-20 22:04:21', NULL),
(31, 50, 'community_post', 179, 'abuse', 'Lời lẽ hơi gay gắt với thành viên khác.', 'open', NULL, '2026-10-21 18:27:51', NULL),
(32, 37, 'community_post', 115, 'abuse', 'Lời lẽ hơi gay gắt với thành viên khác.', 'open', NULL, '2026-10-25 01:18:34', NULL),
(33, 52, 'community_post', 27, 'abuse', 'Lời lẽ hơi gay gắt với thành viên khác.', 'open', NULL, '2026-10-11 18:46:54', NULL),
(34, 17, 'community_post', 26, 'other', 'Bài viết nên chuyển sang chuyên mục phù hợp hơn.', 'open', NULL, '2026-10-23 02:04:27', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `binh_chon_bai_du_thi`
--

CREATE TABLE `binh_chon_bai_du_thi` (
  `bai_du_thi_id` bigint(20) UNSIGNED NOT NULL,
  `nguoi_binh_chon_id` bigint(20) UNSIGNED NOT NULL,
  `tieu_chi` varchar(80) NOT NULL DEFAULT 'overall',
  `diem_so` tinyint(3) UNSIGNED NOT NULL,
  `binh_luan` varchar(1000) DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `binh_chon_bai_du_thi`
--

INSERT INTO `binh_chon_bai_du_thi` (`bai_du_thi_id`, `nguoi_binh_chon_id`, `tieu_chi`, `diem_so`, `binh_luan`, `ngay_tao`) VALUES
(3, 23, 'audio', 5, NULL, '2025-01-19 14:55:37'),
(3, 23, 'gameplay', 3, NULL, '2025-01-19 14:55:37'),
(3, 23, 'overall', 4, NULL, '2025-01-19 14:55:37'),
(3, 23, 'theme', 3, NULL, '2025-01-19 14:55:37'),
(3, 23, 'visuals', 3, NULL, '2025-01-19 14:55:37'),
(3, 24, 'audio', 3, NULL, '2025-01-15 06:30:03'),
(3, 24, 'gameplay', 4, NULL, '2025-01-15 06:30:03'),
(3, 24, 'overall', 5, NULL, '2025-01-15 06:30:03'),
(3, 24, 'theme', 4, NULL, '2025-01-15 06:30:03'),
(3, 24, 'visuals', 4, NULL, '2025-01-15 06:30:03'),
(3, 48, 'audio', 5, NULL, '2025-01-19 04:22:47'),
(3, 48, 'gameplay', 5, NULL, '2025-01-19 04:22:47'),
(3, 48, 'overall', 5, 'Lối chơi chắc tay, hợp chủ đề.', '2025-01-19 04:22:47'),
(3, 48, 'theme', 4, NULL, '2025-01-19 04:22:47'),
(3, 48, 'visuals', 5, NULL, '2025-01-19 04:22:47'),
(4, 18, 'audio', 5, NULL, '2025-01-19 22:36:52'),
(4, 18, 'gameplay', 3, NULL, '2025-01-19 22:36:52'),
(4, 18, 'overall', 3, NULL, '2025-01-19 22:36:52'),
(4, 18, 'theme', 4, NULL, '2025-01-19 22:36:52'),
(4, 18, 'visuals', 4, NULL, '2025-01-19 22:36:52'),
(4, 20, 'audio', 4, NULL, '2025-01-15 23:09:40'),
(4, 20, 'gameplay', 3, NULL, '2025-01-15 23:09:40'),
(4, 20, 'overall', 3, 'Hình ảnh đơn giản mà rõ ràng.', '2025-01-15 23:09:40'),
(4, 20, 'theme', 4, NULL, '2025-01-15 23:09:40'),
(4, 20, 'visuals', 5, NULL, '2025-01-15 23:09:40'),
(4, 43, 'audio', 5, NULL, '2025-01-18 23:43:50'),
(4, 43, 'gameplay', 5, NULL, '2025-01-18 23:43:50'),
(4, 43, 'overall', 5, 'Hình ảnh đơn giản mà rõ ràng.', '2025-01-18 23:43:50'),
(4, 43, 'theme', 3, NULL, '2025-01-18 23:43:50'),
(4, 43, 'visuals', 4, NULL, '2025-01-18 23:43:50'),
(5, 23, 'audio', 4, NULL, '2025-02-16 01:43:00'),
(5, 23, 'gameplay', 5, NULL, '2025-02-16 01:43:00'),
(5, 23, 'overall', 3, 'Hình ảnh đơn giản mà rõ ràng.', '2025-02-16 01:43:00'),
(5, 23, 'theme', 4, NULL, '2025-02-16 01:43:00'),
(5, 23, 'visuals', 4, NULL, '2025-02-16 01:43:00'),
(5, 30, 'audio', 3, NULL, '2025-02-12 06:02:25'),
(5, 30, 'gameplay', 5, NULL, '2025-02-12 06:02:25'),
(5, 30, 'overall', 5, NULL, '2025-02-12 06:02:25'),
(5, 30, 'theme', 3, NULL, '2025-02-12 06:02:25'),
(5, 30, 'visuals', 5, NULL, '2025-02-12 06:02:25'),
(5, 39, 'audio', 3, NULL, '2025-02-18 23:42:52'),
(5, 39, 'gameplay', 4, NULL, '2025-02-18 23:42:52'),
(5, 39, 'overall', 4, NULL, '2025-02-18 23:42:52'),
(5, 39, 'theme', 5, NULL, '2025-02-18 23:42:52'),
(5, 39, 'visuals', 3, NULL, '2025-02-18 23:42:52'),
(5, 52, 'audio', 3, NULL, '2025-02-15 11:28:43'),
(5, 52, 'gameplay', 5, NULL, '2025-02-15 11:28:43'),
(5, 52, 'overall', 4, NULL, '2025-02-15 11:28:43'),
(5, 52, 'theme', 3, NULL, '2025-02-15 11:28:43'),
(5, 52, 'visuals', 4, NULL, '2025-02-15 11:28:43'),
(6, 19, 'audio', 3, NULL, '2025-03-19 12:32:28'),
(6, 19, 'gameplay', 4, NULL, '2025-03-19 12:32:28'),
(6, 19, 'overall', 5, 'Phần âm thanh làm mình nhớ lâu.', '2025-03-19 12:32:28'),
(6, 19, 'theme', 5, NULL, '2025-03-19 12:32:28'),
(6, 19, 'visuals', 3, NULL, '2025-03-19 12:32:28'),
(6, 23, 'audio', 5, NULL, '2025-03-19 23:57:55'),
(6, 23, 'gameplay', 5, NULL, '2025-03-19 23:57:55'),
(6, 23, 'overall', 5, NULL, '2025-03-19 23:57:55'),
(6, 23, 'theme', 3, NULL, '2025-03-19 23:57:55'),
(6, 23, 'visuals', 3, NULL, '2025-03-19 23:57:55'),
(6, 43, 'audio', 4, NULL, '2025-03-15 10:42:16'),
(6, 43, 'gameplay', 5, NULL, '2025-03-15 10:42:16'),
(6, 43, 'overall', 3, 'Hình ảnh đơn giản mà rõ ràng.', '2025-03-15 10:42:16'),
(6, 43, 'theme', 3, NULL, '2025-03-15 10:42:16'),
(6, 43, 'visuals', 3, NULL, '2025-03-15 10:42:16'),
(6, 44, 'audio', 3, NULL, '2025-03-18 18:52:07'),
(6, 44, 'gameplay', 5, NULL, '2025-03-18 18:52:07'),
(6, 44, 'overall', 4, 'Cần thời gian làm quen nhưng xứng đáng.', '2025-03-18 18:52:07'),
(6, 44, 'theme', 5, NULL, '2025-03-18 18:52:07'),
(6, 44, 'visuals', 4, NULL, '2025-03-18 18:52:07'),
(6, 45, 'audio', 5, NULL, '2025-03-18 23:43:25'),
(6, 45, 'gameplay', 4, NULL, '2025-03-18 23:43:25'),
(6, 45, 'overall', 4, 'Giao diện hơi nhiều chữ nhưng rất đầy đủ.', '2025-03-18 23:43:25'),
(6, 45, 'theme', 4, NULL, '2025-03-18 23:43:25'),
(6, 45, 'visuals', 3, NULL, '2025-03-18 23:43:25'),
(7, 19, 'audio', 3, NULL, '2025-03-16 14:16:03'),
(7, 19, 'gameplay', 3, NULL, '2025-03-16 14:16:03'),
(7, 19, 'overall', 3, 'Cách diễn giải chủ đề thú vị.', '2025-03-16 14:16:03'),
(7, 19, 'theme', 4, NULL, '2025-03-16 14:16:03'),
(7, 19, 'visuals', 3, NULL, '2025-03-16 14:16:03'),
(7, 20, 'audio', 5, NULL, '2025-03-19 12:39:09'),
(7, 20, 'gameplay', 3, NULL, '2025-03-19 12:39:09'),
(7, 20, 'overall', 4, 'Giao diện hơi nhiều chữ nhưng rất đầy đủ.', '2025-03-19 12:39:09'),
(7, 20, 'theme', 5, NULL, '2025-03-19 12:39:09'),
(7, 20, 'visuals', 5, NULL, '2025-03-19 12:39:09'),
(7, 34, 'audio', 3, NULL, '2025-03-20 00:35:41'),
(7, 34, 'gameplay', 4, NULL, '2025-03-20 00:35:41'),
(7, 34, 'overall', 3, NULL, '2025-03-20 00:35:41'),
(7, 34, 'theme', 3, NULL, '2025-03-20 00:35:41'),
(7, 34, 'visuals', 4, NULL, '2025-03-20 00:35:41'),
(7, 44, 'audio', 3, NULL, '2025-03-19 10:24:37'),
(7, 44, 'gameplay', 4, NULL, '2025-03-19 10:24:37'),
(7, 44, 'overall', 3, 'Bản đồ thiết kế tốt.', '2025-03-19 10:24:37'),
(7, 44, 'theme', 4, NULL, '2025-03-19 10:24:37'),
(7, 44, 'visuals', 4, NULL, '2025-03-19 10:24:37'),
(7, 50, 'audio', 4, NULL, '2025-03-15 20:31:11'),
(7, 50, 'gameplay', 4, NULL, '2025-03-15 20:31:11'),
(7, 50, 'overall', 5, NULL, '2025-03-15 20:31:11'),
(7, 50, 'theme', 5, NULL, '2025-03-15 20:31:11'),
(7, 50, 'visuals', 5, NULL, '2025-03-15 20:31:11'),
(8, 29, 'audio', 5, NULL, '2025-04-19 03:08:42'),
(8, 29, 'gameplay', 5, NULL, '2025-04-19 03:08:42'),
(8, 29, 'overall', 3, NULL, '2025-04-19 03:08:42'),
(8, 29, 'theme', 4, NULL, '2025-04-19 03:08:42'),
(8, 29, 'visuals', 4, NULL, '2025-04-19 03:08:42'),
(8, 44, 'audio', 5, NULL, '2025-04-15 19:25:27'),
(8, 44, 'gameplay', 5, NULL, '2025-04-15 19:25:27'),
(8, 44, 'overall', 3, 'Cách diễn giải chủ đề thú vị.', '2025-04-15 19:25:27'),
(8, 44, 'theme', 3, NULL, '2025-04-15 19:25:27'),
(8, 44, 'visuals', 5, NULL, '2025-04-15 19:25:27'),
(8, 48, 'audio', 4, NULL, '2025-04-16 10:42:08'),
(8, 48, 'gameplay', 4, NULL, '2025-04-16 10:42:08'),
(8, 48, 'overall', 5, NULL, '2025-04-16 10:42:08'),
(8, 48, 'theme', 4, NULL, '2025-04-16 10:42:08'),
(8, 48, 'visuals', 4, NULL, '2025-04-16 10:42:08'),
(9, 18, 'audio', 3, NULL, '2025-05-15 07:57:59'),
(9, 18, 'gameplay', 4, NULL, '2025-05-15 07:57:59'),
(9, 18, 'overall', 5, 'Hình ảnh đơn giản mà rõ ràng.', '2025-05-15 07:57:59'),
(9, 18, 'theme', 5, NULL, '2025-05-15 07:57:59'),
(9, 18, 'visuals', 4, NULL, '2025-05-15 07:57:59'),
(9, 21, 'audio', 5, NULL, '2025-05-15 01:42:41'),
(9, 21, 'gameplay', 3, NULL, '2025-05-15 01:42:41'),
(9, 21, 'overall', 5, 'Rất nhiều nội dung cho một trò chơi miễn phí.', '2025-05-15 01:42:41'),
(9, 21, 'theme', 5, NULL, '2025-05-15 01:42:41'),
(9, 21, 'visuals', 5, NULL, '2025-05-15 01:42:41'),
(9, 42, 'audio', 5, NULL, '2025-05-16 12:34:25'),
(9, 42, 'gameplay', 5, NULL, '2025-05-16 12:34:25'),
(9, 42, 'overall', 3, 'Hình ảnh đơn giản mà rõ ràng.', '2025-05-16 12:34:25'),
(9, 42, 'theme', 4, NULL, '2025-05-16 12:34:25'),
(9, 42, 'visuals', 5, NULL, '2025-05-16 12:34:25'),
(10, 17, 'audio', 3, NULL, '2025-06-17 02:44:18'),
(10, 17, 'gameplay', 3, NULL, '2025-06-17 02:44:18'),
(10, 17, 'overall', 3, NULL, '2025-06-17 02:44:18'),
(10, 17, 'theme', 4, NULL, '2025-06-17 02:44:18'),
(10, 17, 'visuals', 4, NULL, '2025-06-17 02:44:18'),
(10, 24, 'audio', 3, NULL, '2025-06-18 05:11:55'),
(10, 24, 'gameplay', 5, NULL, '2025-06-18 05:11:55'),
(10, 24, 'overall', 3, 'Giao diện hơi nhiều chữ nhưng rất đầy đủ.', '2025-06-18 05:11:55'),
(10, 24, 'theme', 4, NULL, '2025-06-18 05:11:55'),
(10, 24, 'visuals', 4, NULL, '2025-06-18 05:11:55'),
(10, 43, 'audio', 4, NULL, '2025-06-15 05:49:50'),
(10, 43, 'gameplay', 5, NULL, '2025-06-15 05:49:50'),
(10, 43, 'overall', 5, 'Chơi cùng bạn rất vui.', '2025-06-15 05:49:50'),
(10, 43, 'theme', 3, NULL, '2025-06-15 05:49:50'),
(10, 43, 'visuals', 5, NULL, '2025-06-15 05:49:50'),
(10, 49, 'audio', 4, NULL, '2025-06-13 20:00:06'),
(10, 49, 'gameplay', 3, NULL, '2025-06-13 20:00:06'),
(10, 49, 'overall', 4, NULL, '2025-06-13 20:00:06'),
(10, 49, 'theme', 5, NULL, '2025-06-13 20:00:06'),
(10, 49, 'visuals', 4, NULL, '2025-06-13 20:00:06'),
(11, 17, 'audio', 5, NULL, '2025-06-12 08:23:47'),
(11, 17, 'gameplay', 4, NULL, '2025-06-12 08:23:47'),
(11, 17, 'overall', 4, 'Giao diện hơi nhiều chữ nhưng rất đầy đủ.', '2025-06-12 08:23:47'),
(11, 17, 'theme', 3, NULL, '2025-06-12 08:23:47'),
(11, 17, 'visuals', 3, NULL, '2025-06-12 08:23:47'),
(11, 19, 'audio', 4, NULL, '2025-06-13 14:30:09'),
(11, 19, 'gameplay', 4, NULL, '2025-06-13 14:30:09'),
(11, 19, 'overall', 5, 'Giao diện hơi nhiều chữ nhưng rất đầy đủ.', '2025-06-13 14:30:09'),
(11, 19, 'theme', 5, NULL, '2025-06-13 14:30:09'),
(11, 19, 'visuals', 5, NULL, '2025-06-13 14:30:09'),
(11, 31, 'audio', 5, NULL, '2025-06-17 05:39:04'),
(11, 31, 'gameplay', 5, NULL, '2025-06-17 05:39:04'),
(11, 31, 'overall', 3, NULL, '2025-06-17 05:39:04'),
(11, 31, 'theme', 5, NULL, '2025-06-17 05:39:04'),
(11, 31, 'visuals', 4, NULL, '2025-06-17 05:39:04'),
(11, 38, 'audio', 5, NULL, '2025-06-14 12:41:50'),
(11, 38, 'gameplay', 5, NULL, '2025-06-14 12:41:50'),
(11, 38, 'overall', 5, NULL, '2025-06-14 12:41:50'),
(11, 38, 'theme', 3, NULL, '2025-06-14 12:41:50'),
(11, 38, 'visuals', 4, NULL, '2025-06-14 12:41:50'),
(12, 32, 'audio', 3, NULL, '2025-07-12 07:38:49'),
(12, 32, 'gameplay', 5, NULL, '2025-07-12 07:38:49'),
(12, 32, 'overall', 4, NULL, '2025-07-12 07:38:49'),
(12, 32, 'theme', 5, NULL, '2025-07-12 07:38:49'),
(12, 32, 'visuals', 4, NULL, '2025-07-12 07:38:49'),
(12, 38, 'audio', 4, NULL, '2025-07-16 09:28:59'),
(12, 38, 'gameplay', 5, NULL, '2025-07-16 09:28:59'),
(12, 38, 'overall', 5, NULL, '2025-07-16 09:28:59'),
(12, 38, 'theme', 4, NULL, '2025-07-16 09:28:59'),
(12, 38, 'visuals', 4, NULL, '2025-07-16 09:28:59'),
(12, 40, 'audio', 3, NULL, '2025-07-18 10:15:10'),
(12, 40, 'gameplay', 5, NULL, '2025-07-18 10:15:10'),
(12, 40, 'overall', 3, NULL, '2025-07-18 10:15:10'),
(12, 40, 'theme', 4, NULL, '2025-07-18 10:15:10'),
(12, 40, 'visuals', 3, NULL, '2025-07-18 10:15:10'),
(13, 20, 'audio', 5, NULL, '2025-08-14 01:15:47'),
(13, 20, 'gameplay', 3, NULL, '2025-08-14 01:15:47'),
(13, 20, 'overall', 4, 'Cách diễn giải chủ đề thú vị.', '2025-08-14 01:15:47'),
(13, 20, 'theme', 3, NULL, '2025-08-14 01:15:47'),
(13, 20, 'visuals', 4, NULL, '2025-08-14 01:15:47'),
(13, 21, 'audio', 4, NULL, '2025-08-17 18:03:58'),
(13, 21, 'gameplay', 5, NULL, '2025-08-17 18:03:58'),
(13, 21, 'overall', 3, NULL, '2025-08-17 18:03:58'),
(13, 21, 'theme', 4, NULL, '2025-08-17 18:03:58'),
(13, 21, 'visuals', 3, NULL, '2025-08-17 18:03:58'),
(13, 26, 'audio', 4, NULL, '2025-08-16 14:36:07'),
(13, 26, 'gameplay', 5, NULL, '2025-08-16 14:36:07'),
(13, 26, 'overall', 5, 'Dễ vào, khó thành thạo.', '2025-08-16 14:36:07'),
(13, 26, 'theme', 5, NULL, '2025-08-16 14:36:07'),
(13, 26, 'visuals', 4, NULL, '2025-08-16 14:36:07'),
(13, 29, 'audio', 5, NULL, '2025-08-11 17:24:12'),
(13, 29, 'gameplay', 3, NULL, '2025-08-11 17:24:12'),
(13, 29, 'overall', 4, 'Hình ảnh đơn giản mà rõ ràng.', '2025-08-11 17:24:12'),
(13, 29, 'theme', 4, NULL, '2025-08-11 17:24:12'),
(13, 29, 'visuals', 5, NULL, '2025-08-11 17:24:12'),
(13, 43, 'audio', 4, NULL, '2025-08-17 09:49:51'),
(13, 43, 'gameplay', 4, NULL, '2025-08-17 09:49:51'),
(13, 43, 'overall', 5, NULL, '2025-08-17 09:49:51'),
(13, 43, 'theme', 5, NULL, '2025-08-17 09:49:51'),
(13, 43, 'visuals', 5, NULL, '2025-08-17 09:49:51'),
(14, 23, 'audio', 4, NULL, '2025-09-15 15:42:38'),
(14, 23, 'gameplay', 5, NULL, '2025-09-15 15:42:38'),
(14, 23, 'overall', 5, 'Lối chơi chắc tay, hợp chủ đề.', '2025-09-15 15:42:38'),
(14, 23, 'theme', 4, NULL, '2025-09-15 15:42:38'),
(14, 23, 'visuals', 4, NULL, '2025-09-15 15:42:38'),
(14, 29, 'audio', 3, NULL, '2025-09-12 18:32:36'),
(14, 29, 'gameplay', 5, NULL, '2025-09-12 18:32:36'),
(14, 29, 'overall', 5, 'Phần âm thanh làm mình nhớ lâu.', '2025-09-12 18:32:36'),
(14, 29, 'theme', 5, NULL, '2025-09-12 18:32:36'),
(14, 29, 'visuals', 4, NULL, '2025-09-12 18:32:36'),
(14, 32, 'audio', 3, NULL, '2025-09-13 06:07:48'),
(14, 32, 'gameplay', 3, NULL, '2025-09-13 06:07:48'),
(14, 32, 'overall', 3, 'Rất nhiều nội dung cho một trò chơi miễn phí.', '2025-09-13 06:07:48'),
(14, 32, 'theme', 4, NULL, '2025-09-13 06:07:48'),
(14, 32, 'visuals', 4, NULL, '2025-09-13 06:07:48'),
(14, 36, 'audio', 4, NULL, '2025-09-11 08:45:19'),
(14, 36, 'gameplay', 3, NULL, '2025-09-11 08:45:19'),
(14, 36, 'overall', 5, 'Rất nhiều nội dung cho một trò chơi miễn phí.', '2025-09-11 08:45:19'),
(14, 36, 'theme', 5, NULL, '2025-09-11 08:45:19'),
(14, 36, 'visuals', 5, NULL, '2025-09-11 08:45:19'),
(15, 19, 'audio', 4, NULL, '2025-10-10 09:02:22'),
(15, 19, 'gameplay', 5, NULL, '2025-10-10 09:02:22'),
(15, 19, 'overall', 5, 'Dễ vào, khó thành thạo.', '2025-10-10 09:02:22'),
(15, 19, 'theme', 5, NULL, '2025-10-10 09:02:22'),
(15, 19, 'visuals', 3, NULL, '2025-10-10 09:02:22'),
(15, 20, 'audio', 3, NULL, '2025-10-14 05:01:25'),
(15, 20, 'gameplay', 3, NULL, '2025-10-14 05:01:25'),
(15, 20, 'overall', 4, 'Lối chơi chắc tay, hợp chủ đề.', '2025-10-14 05:01:25'),
(15, 20, 'theme', 5, NULL, '2025-10-14 05:01:25'),
(15, 20, 'visuals', 4, NULL, '2025-10-14 05:01:25'),
(15, 28, 'audio', 4, NULL, '2025-10-12 08:39:42'),
(15, 28, 'gameplay', 5, NULL, '2025-10-12 08:39:42'),
(15, 28, 'overall', 3, 'Bản đồ thiết kế tốt.', '2025-10-12 08:39:42'),
(15, 28, 'theme', 5, NULL, '2025-10-12 08:39:42'),
(15, 28, 'visuals', 4, NULL, '2025-10-12 08:39:42'),
(15, 30, 'audio', 3, NULL, '2025-10-15 07:35:10'),
(15, 30, 'gameplay', 3, NULL, '2025-10-15 07:35:10'),
(15, 30, 'overall', 3, 'Lối chơi chắc tay, hợp chủ đề.', '2025-10-15 07:35:10'),
(15, 30, 'theme', 5, NULL, '2025-10-15 07:35:10'),
(15, 30, 'visuals', 4, NULL, '2025-10-15 07:35:10'),
(16, 18, 'audio', 5, NULL, '2025-10-16 13:47:16'),
(16, 18, 'gameplay', 3, NULL, '2025-10-16 13:47:16'),
(16, 18, 'overall', 5, 'Dễ vào, khó thành thạo.', '2025-10-16 13:47:16'),
(16, 18, 'theme', 4, NULL, '2025-10-16 13:47:16'),
(16, 18, 'visuals', 5, NULL, '2025-10-16 13:47:16'),
(16, 34, 'audio', 5, NULL, '2025-10-12 00:19:23'),
(16, 34, 'gameplay', 3, NULL, '2025-10-12 00:19:23'),
(16, 34, 'overall', 4, 'Cách diễn giải chủ đề thú vị.', '2025-10-12 00:19:23'),
(16, 34, 'theme', 3, NULL, '2025-10-12 00:19:23'),
(16, 34, 'visuals', 3, NULL, '2025-10-12 00:19:23'),
(16, 52, 'audio', 3, NULL, '2025-10-14 20:35:40'),
(16, 52, 'gameplay', 4, NULL, '2025-10-14 20:35:40'),
(16, 52, 'overall', 4, 'Cần thời gian làm quen nhưng xứng đáng.', '2025-10-14 20:35:40'),
(16, 52, 'theme', 3, NULL, '2025-10-14 20:35:40'),
(16, 52, 'visuals', 4, NULL, '2025-10-14 20:35:40'),
(17, 19, 'audio', 4, NULL, '2025-11-15 14:07:35'),
(17, 19, 'gameplay', 3, NULL, '2025-11-15 14:07:35'),
(17, 19, 'overall', 4, 'Hình ảnh đơn giản mà rõ ràng.', '2025-11-15 14:07:35'),
(17, 19, 'theme', 5, NULL, '2025-11-15 14:07:35'),
(17, 19, 'visuals', 3, NULL, '2025-11-15 14:07:35'),
(17, 31, 'audio', 4, NULL, '2025-11-13 13:53:38'),
(17, 31, 'gameplay', 3, NULL, '2025-11-13 13:53:38'),
(17, 31, 'overall', 4, 'Chơi cùng bạn rất vui.', '2025-11-13 13:53:38'),
(17, 31, 'theme', 5, NULL, '2025-11-13 13:53:38'),
(17, 31, 'visuals', 4, NULL, '2025-11-13 13:53:38'),
(17, 34, 'audio', 4, NULL, '2025-11-11 11:32:07'),
(17, 34, 'gameplay', 3, NULL, '2025-11-11 11:32:07'),
(17, 34, 'overall', 5, 'Giao diện hơi nhiều chữ nhưng rất đầy đủ.', '2025-11-11 11:32:07'),
(17, 34, 'theme', 5, NULL, '2025-11-11 11:32:07'),
(17, 34, 'visuals', 5, NULL, '2025-11-11 11:32:07'),
(18, 22, 'audio', 3, NULL, '2025-12-09 09:17:02'),
(18, 22, 'gameplay', 5, NULL, '2025-12-09 09:17:02'),
(18, 22, 'overall', 3, NULL, '2025-12-09 09:17:02'),
(18, 22, 'theme', 5, NULL, '2025-12-09 09:17:02'),
(18, 22, 'visuals', 4, NULL, '2025-12-09 09:17:02'),
(18, 24, 'audio', 4, NULL, '2025-12-12 11:30:17'),
(18, 24, 'gameplay', 4, NULL, '2025-12-12 11:30:17'),
(18, 24, 'overall', 4, 'Chơi cùng bạn rất vui.', '2025-12-12 11:30:17'),
(18, 24, 'theme', 5, NULL, '2025-12-12 11:30:17'),
(18, 24, 'visuals', 3, NULL, '2025-12-12 11:30:17'),
(18, 26, 'audio', 5, NULL, '2025-12-10 08:31:03'),
(18, 26, 'gameplay', 5, NULL, '2025-12-10 08:31:03'),
(18, 26, 'overall', 5, 'Bản đồ thiết kế tốt.', '2025-12-10 08:31:03'),
(18, 26, 'theme', 3, NULL, '2025-12-10 08:31:03'),
(18, 26, 'visuals', 5, NULL, '2025-12-10 08:31:03'),
(18, 35, 'audio', 4, NULL, '2025-12-09 04:01:37'),
(18, 35, 'gameplay', 5, NULL, '2025-12-09 04:01:37'),
(18, 35, 'overall', 4, NULL, '2025-12-09 04:01:37'),
(18, 35, 'theme', 4, NULL, '2025-12-09 04:01:37'),
(18, 35, 'visuals', 3, NULL, '2025-12-09 04:01:37'),
(18, 41, 'audio', 4, NULL, '2025-12-15 07:13:07'),
(18, 41, 'gameplay', 3, NULL, '2025-12-15 07:13:07'),
(18, 41, 'overall', 5, 'Chơi cùng bạn rất vui.', '2025-12-15 07:13:07'),
(18, 41, 'theme', 5, NULL, '2025-12-15 07:13:07'),
(18, 41, 'visuals', 3, NULL, '2025-12-15 07:13:07'),
(19, 31, 'audio', 3, NULL, '2026-01-14 00:22:24'),
(19, 31, 'gameplay', 3, NULL, '2026-01-14 00:22:24'),
(19, 31, 'overall', 4, 'Lối chơi chắc tay, hợp chủ đề.', '2026-01-14 00:22:24'),
(19, 31, 'theme', 3, NULL, '2026-01-14 00:22:24'),
(19, 31, 'visuals', 5, NULL, '2026-01-14 00:22:24'),
(19, 33, 'audio', 4, NULL, '2026-01-11 00:34:15'),
(19, 33, 'gameplay', 4, NULL, '2026-01-11 00:34:15'),
(19, 33, 'overall', 4, NULL, '2026-01-11 00:34:15'),
(19, 33, 'theme', 3, NULL, '2026-01-11 00:34:15'),
(19, 33, 'visuals', 3, NULL, '2026-01-11 00:34:15'),
(19, 38, 'audio', 3, NULL, '2026-01-09 06:34:31'),
(19, 38, 'gameplay', 5, NULL, '2026-01-09 06:34:31'),
(19, 38, 'overall', 3, 'Cần thời gian làm quen nhưng xứng đáng.', '2026-01-09 06:34:31'),
(19, 38, 'theme', 4, NULL, '2026-01-09 06:34:31'),
(19, 38, 'visuals', 5, NULL, '2026-01-09 06:34:31'),
(20, 17, 'audio', 5, NULL, '2026-02-11 14:39:14'),
(20, 17, 'gameplay', 3, NULL, '2026-02-11 14:39:14'),
(20, 17, 'overall', 5, 'Hình ảnh đơn giản mà rõ ràng.', '2026-02-11 14:39:14'),
(20, 17, 'theme', 3, NULL, '2026-02-11 14:39:14'),
(20, 17, 'visuals', 4, NULL, '2026-02-11 14:39:14'),
(20, 19, 'audio', 5, NULL, '2026-02-08 09:09:07'),
(20, 19, 'gameplay', 4, NULL, '2026-02-08 09:09:07'),
(20, 19, 'overall', 3, NULL, '2026-02-08 09:09:07'),
(20, 19, 'theme', 5, NULL, '2026-02-08 09:09:07'),
(20, 19, 'visuals', 4, NULL, '2026-02-08 09:09:07'),
(20, 47, 'audio', 4, NULL, '2026-02-13 05:19:44'),
(20, 47, 'gameplay', 4, NULL, '2026-02-13 05:19:44'),
(20, 47, 'overall', 3, 'Cách diễn giải chủ đề thú vị.', '2026-02-13 05:19:44'),
(20, 47, 'theme', 3, NULL, '2026-02-13 05:19:44'),
(20, 47, 'visuals', 4, NULL, '2026-02-13 05:19:44'),
(21, 25, 'audio', 4, NULL, '2026-02-12 23:55:17'),
(21, 25, 'gameplay', 3, NULL, '2026-02-12 23:55:17'),
(21, 25, 'overall', 3, 'Chơi cùng bạn rất vui.', '2026-02-12 23:55:17'),
(21, 25, 'theme', 4, NULL, '2026-02-12 23:55:17'),
(21, 25, 'visuals', 4, NULL, '2026-02-12 23:55:17'),
(21, 31, 'audio', 3, NULL, '2026-02-12 23:41:01'),
(21, 31, 'gameplay', 3, NULL, '2026-02-12 23:41:01'),
(21, 31, 'overall', 4, 'Cần thời gian làm quen nhưng xứng đáng.', '2026-02-12 23:41:01'),
(21, 31, 'theme', 4, NULL, '2026-02-12 23:41:01'),
(21, 31, 'visuals', 3, NULL, '2026-02-12 23:41:01'),
(21, 33, 'audio', 5, NULL, '2026-02-10 12:16:52'),
(21, 33, 'gameplay', 4, NULL, '2026-02-10 12:16:52'),
(21, 33, 'overall', 5, 'Chơi cùng bạn rất vui.', '2026-02-10 12:16:52'),
(21, 33, 'theme', 3, NULL, '2026-02-10 12:16:52'),
(21, 33, 'visuals', 3, NULL, '2026-02-10 12:16:52'),
(21, 43, 'audio', 3, NULL, '2026-02-09 10:27:40'),
(21, 43, 'gameplay', 5, NULL, '2026-02-09 10:27:40'),
(21, 43, 'overall', 5, 'Giao diện hơi nhiều chữ nhưng rất đầy đủ.', '2026-02-09 10:27:40'),
(21, 43, 'theme', 3, NULL, '2026-02-09 10:27:40'),
(21, 43, 'visuals', 3, NULL, '2026-02-09 10:27:40'),
(22, 25, 'audio', 5, NULL, '2026-03-15 16:50:53'),
(22, 25, 'gameplay', 5, NULL, '2026-03-15 16:50:53'),
(22, 25, 'overall', 4, 'Giao diện hơi nhiều chữ nhưng rất đầy đủ.', '2026-03-15 16:50:53'),
(22, 25, 'theme', 3, NULL, '2026-03-15 16:50:53'),
(22, 25, 'visuals', 5, NULL, '2026-03-15 16:50:53'),
(22, 33, 'audio', 3, NULL, '2026-03-14 22:46:27'),
(22, 33, 'gameplay', 3, NULL, '2026-03-14 22:46:27'),
(22, 33, 'overall', 5, NULL, '2026-03-14 22:46:27'),
(22, 33, 'theme', 4, NULL, '2026-03-14 22:46:27'),
(22, 33, 'visuals', 4, NULL, '2026-03-14 22:46:27'),
(22, 39, 'audio', 3, NULL, '2026-03-11 13:39:30'),
(22, 39, 'gameplay', 5, NULL, '2026-03-11 13:39:30'),
(22, 39, 'overall', 5, 'Phần âm thanh làm mình nhớ lâu.', '2026-03-11 13:39:30'),
(22, 39, 'theme', 3, NULL, '2026-03-11 13:39:30'),
(22, 39, 'visuals', 3, NULL, '2026-03-11 13:39:30'),
(23, 17, 'audio', 5, NULL, '2026-04-08 11:55:31'),
(23, 17, 'gameplay', 5, NULL, '2026-04-08 11:55:31'),
(23, 17, 'overall', 4, 'Giao diện hơi nhiều chữ nhưng rất đầy đủ.', '2026-04-08 11:55:31'),
(23, 17, 'theme', 5, NULL, '2026-04-08 11:55:31'),
(23, 17, 'visuals', 3, NULL, '2026-04-08 11:55:31'),
(23, 34, 'audio', 4, NULL, '2026-04-09 05:11:40'),
(23, 34, 'gameplay', 5, NULL, '2026-04-09 05:11:40'),
(23, 34, 'overall', 3, 'Giao diện hơi nhiều chữ nhưng rất đầy đủ.', '2026-04-09 05:11:40'),
(23, 34, 'theme', 3, NULL, '2026-04-09 05:11:40'),
(23, 34, 'visuals', 5, NULL, '2026-04-09 05:11:40'),
(23, 52, 'audio', 3, NULL, '2026-04-08 21:22:46'),
(23, 52, 'gameplay', 4, NULL, '2026-04-08 21:22:46'),
(23, 52, 'overall', 3, 'Dễ vào, khó thành thạo.', '2026-04-08 21:22:46'),
(23, 52, 'theme', 3, NULL, '2026-04-08 21:22:46'),
(23, 52, 'visuals', 3, NULL, '2026-04-08 21:22:46'),
(24, 25, 'audio', 4, NULL, '2026-04-12 13:44:59'),
(24, 25, 'gameplay', 4, NULL, '2026-04-12 13:44:59'),
(24, 25, 'overall', 5, 'Phần âm thanh làm mình nhớ lâu.', '2026-04-12 13:44:59'),
(24, 25, 'theme', 3, NULL, '2026-04-12 13:44:59'),
(24, 25, 'visuals', 5, NULL, '2026-04-12 13:44:59'),
(24, 26, 'audio', 5, NULL, '2026-04-14 01:56:32'),
(24, 26, 'gameplay', 5, NULL, '2026-04-14 01:56:32'),
(24, 26, 'overall', 5, 'Dễ vào, khó thành thạo.', '2026-04-14 01:56:32'),
(24, 26, 'theme', 4, NULL, '2026-04-14 01:56:32'),
(24, 26, 'visuals', 3, NULL, '2026-04-14 01:56:32'),
(24, 43, 'audio', 4, NULL, '2026-04-12 18:39:34'),
(24, 43, 'gameplay', 5, NULL, '2026-04-12 18:39:34'),
(24, 43, 'overall', 4, NULL, '2026-04-12 18:39:34'),
(24, 43, 'theme', 3, NULL, '2026-04-12 18:39:34'),
(24, 43, 'visuals', 3, NULL, '2026-04-12 18:39:34'),
(24, 50, 'audio', 5, NULL, '2026-04-12 13:16:40'),
(24, 50, 'gameplay', 5, NULL, '2026-04-12 13:16:40'),
(24, 50, 'overall', 4, 'Lối chơi chắc tay, hợp chủ đề.', '2026-04-12 13:16:40'),
(24, 50, 'theme', 5, NULL, '2026-04-12 13:16:40'),
(24, 50, 'visuals', 4, NULL, '2026-04-12 13:16:40'),
(25, 26, 'audio', 4, NULL, '2026-05-13 19:14:51'),
(25, 26, 'gameplay', 4, NULL, '2026-05-13 19:14:51'),
(25, 26, 'overall', 3, 'Hình ảnh đơn giản mà rõ ràng.', '2026-05-13 19:14:51'),
(25, 26, 'theme', 5, NULL, '2026-05-13 19:14:51'),
(25, 26, 'visuals', 4, NULL, '2026-05-13 19:14:51'),
(25, 38, 'audio', 3, NULL, '2026-05-15 01:56:08'),
(25, 38, 'gameplay', 5, NULL, '2026-05-15 01:56:08'),
(25, 38, 'overall', 4, 'Dễ vào, khó thành thạo.', '2026-05-15 01:56:08'),
(25, 38, 'theme', 3, NULL, '2026-05-15 01:56:08'),
(25, 38, 'visuals', 4, NULL, '2026-05-15 01:56:08'),
(25, 45, 'audio', 3, NULL, '2026-05-14 22:12:30'),
(25, 45, 'gameplay', 4, NULL, '2026-05-14 22:12:30'),
(25, 45, 'overall', 5, 'Bản đồ thiết kế tốt.', '2026-05-14 22:12:30'),
(25, 45, 'theme', 3, NULL, '2026-05-14 22:12:30'),
(25, 45, 'visuals', 5, NULL, '2026-05-14 22:12:30'),
(25, 48, 'audio', 4, NULL, '2026-05-09 15:48:20'),
(25, 48, 'gameplay', 4, NULL, '2026-05-09 15:48:20'),
(25, 48, 'overall', 3, 'Lối chơi chắc tay, hợp chủ đề.', '2026-05-09 15:48:20'),
(25, 48, 'theme', 4, NULL, '2026-05-09 15:48:20'),
(25, 48, 'visuals', 5, NULL, '2026-05-09 15:48:20'),
(25, 50, 'audio', 5, NULL, '2026-05-14 05:00:29'),
(25, 50, 'gameplay', 4, NULL, '2026-05-14 05:00:29'),
(25, 50, 'overall', 4, NULL, '2026-05-14 05:00:29'),
(25, 50, 'theme', 5, NULL, '2026-05-14 05:00:29'),
(25, 50, 'visuals', 4, NULL, '2026-05-14 05:00:29'),
(26, 23, 'audio', 3, NULL, '2026-06-07 21:39:26'),
(26, 23, 'gameplay', 4, NULL, '2026-06-07 21:39:26'),
(26, 23, 'overall', 3, 'Chơi cùng bạn rất vui.', '2026-06-07 21:39:26'),
(26, 23, 'theme', 4, NULL, '2026-06-07 21:39:26'),
(26, 23, 'visuals', 3, NULL, '2026-06-07 21:39:26'),
(26, 38, 'audio', 4, NULL, '2026-06-07 04:49:27'),
(26, 38, 'gameplay', 3, NULL, '2026-06-07 04:49:27'),
(26, 38, 'overall', 4, 'Lối chơi chắc tay, hợp chủ đề.', '2026-06-07 04:49:27'),
(26, 38, 'theme', 3, NULL, '2026-06-07 04:49:27'),
(26, 38, 'visuals', 5, NULL, '2026-06-07 04:49:27'),
(26, 42, 'audio', 4, NULL, '2026-06-10 14:29:28'),
(26, 42, 'gameplay', 5, NULL, '2026-06-10 14:29:28'),
(26, 42, 'overall', 4, 'Cách diễn giải chủ đề thú vị.', '2026-06-10 14:29:28'),
(26, 42, 'theme', 3, NULL, '2026-06-10 14:29:28'),
(26, 42, 'visuals', 4, NULL, '2026-06-10 14:29:28'),
(26, 47, 'audio', 4, NULL, '2026-06-12 16:07:27'),
(26, 47, 'gameplay', 5, NULL, '2026-06-12 16:07:27'),
(26, 47, 'overall', 4, 'Chơi cùng bạn rất vui.', '2026-06-12 16:07:27'),
(26, 47, 'theme', 5, NULL, '2026-06-12 16:07:27'),
(26, 47, 'visuals', 4, NULL, '2026-06-12 16:07:27'),
(27, 21, 'audio', 5, NULL, '2026-06-12 08:01:49'),
(27, 21, 'gameplay', 5, NULL, '2026-06-12 08:01:49'),
(27, 21, 'overall', 4, 'Dễ vào, khó thành thạo.', '2026-06-12 08:01:49'),
(27, 21, 'theme', 5, NULL, '2026-06-12 08:01:49'),
(27, 21, 'visuals', 3, NULL, '2026-06-12 08:01:49'),
(27, 38, 'audio', 4, NULL, '2026-06-08 02:36:52'),
(27, 38, 'gameplay', 4, NULL, '2026-06-08 02:36:52'),
(27, 38, 'overall', 3, NULL, '2026-06-08 02:36:52'),
(27, 38, 'theme', 5, NULL, '2026-06-08 02:36:52'),
(27, 38, 'visuals', 4, NULL, '2026-06-08 02:36:52'),
(27, 51, 'audio', 3, NULL, '2026-06-11 22:50:13'),
(27, 51, 'gameplay', 5, NULL, '2026-06-11 22:50:13'),
(27, 51, 'overall', 3, NULL, '2026-06-11 22:50:13'),
(27, 51, 'theme', 3, NULL, '2026-06-11 22:50:13'),
(27, 51, 'visuals', 4, NULL, '2026-06-11 22:50:13'),
(28, 38, 'audio', 5, NULL, '2026-07-10 04:18:31'),
(28, 38, 'gameplay', 3, NULL, '2026-07-10 04:18:31'),
(28, 38, 'overall', 3, 'Chơi cùng bạn rất vui.', '2026-07-10 04:18:31'),
(28, 38, 'theme', 3, NULL, '2026-07-10 04:18:31'),
(28, 38, 'visuals', 3, NULL, '2026-07-10 04:18:31'),
(28, 41, 'audio', 3, NULL, '2026-07-07 23:49:21'),
(28, 41, 'gameplay', 5, NULL, '2026-07-07 23:49:21'),
(28, 41, 'overall', 3, NULL, '2026-07-07 23:49:21'),
(28, 41, 'theme', 3, NULL, '2026-07-07 23:49:21'),
(28, 41, 'visuals', 3, NULL, '2026-07-07 23:49:21'),
(28, 43, 'audio', 4, NULL, '2026-07-08 10:01:33'),
(28, 43, 'gameplay', 3, NULL, '2026-07-08 10:01:33'),
(28, 43, 'overall', 3, NULL, '2026-07-08 10:01:33'),
(28, 43, 'theme', 5, NULL, '2026-07-08 10:01:33'),
(28, 43, 'visuals', 5, NULL, '2026-07-08 10:01:33'),
(28, 48, 'audio', 5, NULL, '2026-07-07 03:29:25'),
(28, 48, 'gameplay', 4, NULL, '2026-07-07 03:29:25'),
(28, 48, 'overall', 3, 'Phần âm thanh làm mình nhớ lâu.', '2026-07-07 03:29:25'),
(28, 48, 'theme', 5, NULL, '2026-07-07 03:29:25'),
(28, 48, 'visuals', 4, NULL, '2026-07-07 03:29:25'),
(28, 52, 'audio', 4, NULL, '2026-07-12 12:26:37'),
(28, 52, 'gameplay', 3, NULL, '2026-07-12 12:26:37'),
(28, 52, 'overall', 4, NULL, '2026-07-12 12:26:37'),
(28, 52, 'theme', 4, NULL, '2026-07-12 12:26:37'),
(28, 52, 'visuals', 4, NULL, '2026-07-12 12:26:37'),
(29, 29, 'audio', 4, NULL, '2026-11-01 08:27:12'),
(29, 29, 'gameplay', 4, NULL, '2026-11-01 08:27:12'),
(29, 29, 'overall', 5, 'Bản đồ thiết kế tốt.', '2026-11-01 08:27:12'),
(29, 29, 'theme', 3, NULL, '2026-11-01 08:27:12'),
(29, 29, 'visuals', 5, NULL, '2026-11-01 08:27:12'),
(29, 42, 'audio', 5, NULL, '2026-11-03 23:13:56'),
(29, 42, 'gameplay', 5, NULL, '2026-11-03 23:13:56'),
(29, 42, 'overall', 4, 'Chơi cùng bạn rất vui.', '2026-11-03 23:13:56'),
(29, 42, 'theme', 5, NULL, '2026-11-03 23:13:56'),
(29, 42, 'visuals', 4, NULL, '2026-11-03 23:13:56'),
(30, 22, 'audio', 5, NULL, '2026-11-01 04:53:54'),
(30, 22, 'gameplay', 5, NULL, '2026-11-01 04:53:54'),
(30, 22, 'overall', 4, NULL, '2026-11-01 04:53:54'),
(30, 22, 'theme', 3, NULL, '2026-11-01 04:53:54'),
(30, 22, 'visuals', 5, NULL, '2026-11-01 04:53:54'),
(30, 33, 'audio', 3, NULL, '2026-11-02 15:24:14'),
(30, 33, 'gameplay', 3, NULL, '2026-11-02 15:24:14'),
(30, 33, 'overall', 4, NULL, '2026-11-02 15:24:14'),
(30, 33, 'theme', 3, NULL, '2026-11-02 15:24:14'),
(30, 33, 'visuals', 3, NULL, '2026-11-02 15:24:14'),
(31, 39, 'audio', 5, NULL, '2026-11-02 15:22:28'),
(31, 39, 'gameplay', 3, NULL, '2026-11-02 15:22:28'),
(31, 39, 'overall', 3, 'Hình ảnh đơn giản mà rõ ràng.', '2026-11-02 15:22:28'),
(31, 39, 'theme', 5, NULL, '2026-11-02 15:22:28'),
(31, 39, 'visuals', 3, NULL, '2026-11-02 15:22:28'),
(31, 48, 'audio', 3, NULL, '2026-11-03 20:14:26'),
(31, 48, 'gameplay', 3, NULL, '2026-11-03 20:14:26'),
(31, 48, 'overall', 4, NULL, '2026-11-03 20:14:26'),
(31, 48, 'theme', 3, NULL, '2026-11-03 20:14:26'),
(31, 48, 'visuals', 5, NULL, '2026-11-03 20:14:26'),
(32, 29, 'audio', 3, NULL, '2026-10-31 06:26:41'),
(32, 29, 'gameplay', 3, NULL, '2026-10-31 06:26:41'),
(32, 29, 'overall', 4, 'Cần thời gian làm quen nhưng xứng đáng.', '2026-10-31 06:26:41'),
(32, 29, 'theme', 4, NULL, '2026-10-31 06:26:41'),
(32, 29, 'visuals', 3, NULL, '2026-10-31 06:26:41'),
(32, 34, 'audio', 5, NULL, '2026-11-03 08:45:54'),
(32, 34, 'gameplay', 4, NULL, '2026-11-03 08:45:54'),
(32, 34, 'overall', 5, 'Phần âm thanh làm mình nhớ lâu.', '2026-11-03 08:45:54'),
(32, 34, 'theme', 4, NULL, '2026-11-03 08:45:54'),
(32, 34, 'visuals', 5, NULL, '2026-11-03 08:45:54'),
(33, 17, 'audio', 3, NULL, '2026-11-03 23:16:15'),
(33, 17, 'gameplay', 3, NULL, '2026-11-03 23:16:15'),
(33, 17, 'overall', 3, 'Dễ vào, khó thành thạo.', '2026-11-03 23:16:15'),
(33, 17, 'theme', 3, NULL, '2026-11-03 23:16:15'),
(33, 17, 'visuals', 5, NULL, '2026-11-03 23:16:15'),
(33, 34, 'audio', 5, NULL, '2026-11-03 07:51:58'),
(33, 34, 'gameplay', 4, NULL, '2026-11-03 07:51:58'),
(33, 34, 'overall', 3, 'Rất nhiều nội dung cho một trò chơi miễn phí.', '2026-11-03 07:51:58'),
(33, 34, 'theme', 3, NULL, '2026-11-03 07:51:58'),
(33, 34, 'visuals', 4, NULL, '2026-11-03 07:51:58');

-- --------------------------------------------------------

--
-- Table structure for table `binh_chon_danh_gia`
--

CREATE TABLE `binh_chon_danh_gia` (
  `danh_gia_id` bigint(20) UNSIGNED NOT NULL,
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `co_ich` tinyint(1) NOT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `binh_chon_danh_gia`
--

INSERT INTO `binh_chon_danh_gia` (`danh_gia_id`, `nguoi_dung_id`, `co_ich`, `ngay_tao`) VALUES
(2, 26, 1, '2026-11-03 06:10:26'),
(2, 32, 1, '2026-11-02 07:38:26'),
(2, 40, 1, '2026-11-02 01:10:26'),
(3, 17, 1, '2026-11-02 17:20:26'),
(3, 21, 1, '2026-11-02 09:26:26'),
(3, 23, 0, '2026-11-02 13:01:26'),
(3, 32, 0, '2026-11-01 13:11:26'),
(3, 38, 0, '2026-11-02 18:31:26'),
(3, 44, 1, '2026-11-01 11:02:26'),
(3, 45, 1, '2026-11-01 12:50:26'),
(4, 19, 1, '2026-11-02 18:09:26'),
(4, 26, 1, '2026-11-03 05:17:26'),
(4, 40, 0, '2026-11-03 07:01:26'),
(4, 49, 1, '2026-11-02 11:33:26'),
(5, 35, 1, '2026-11-01 13:11:26'),
(5, 41, 1, '2026-11-01 16:39:26'),
(5, 51, 1, '2026-11-02 05:59:26'),
(6, 20, 1, '2026-11-03 05:06:26'),
(6, 25, 1, '2026-11-02 12:12:26'),
(6, 32, 1, '2026-11-01 11:16:26'),
(6, 33, 1, '2026-11-01 13:03:26'),
(7, 42, 1, '2026-11-02 07:10:26'),
(8, 27, 1, '2026-11-02 05:33:26'),
(8, 39, 1, '2026-11-01 19:52:26'),
(8, 41, 1, '2026-11-02 04:23:26'),
(8, 48, 1, '2026-11-01 17:29:26'),
(10, 31, 1, '2026-11-02 16:23:26'),
(10, 34, 1, '2026-11-02 16:56:26'),
(10, 46, 0, '2026-11-02 21:51:26'),
(10, 47, 1, '2026-11-03 00:46:26'),
(10, 49, 1, '2026-11-02 21:15:26'),
(11, 22, 1, '2026-11-01 09:49:26'),
(11, 26, 1, '2026-11-01 20:24:26'),
(11, 30, 1, '2026-11-01 15:57:26'),
(11, 42, 0, '2026-11-03 00:14:26'),
(11, 44, 1, '2026-11-02 08:30:26'),
(11, 50, 1, '2026-11-02 06:27:26'),
(12, 25, 1, '2026-11-02 04:23:26'),
(12, 34, 1, '2026-11-03 02:14:26'),
(12, 35, 0, '2026-11-02 22:02:26'),
(12, 51, 1, '2026-11-02 17:39:26'),
(13, 38, 1, '2026-11-03 05:43:26'),
(13, 43, 1, '2026-11-02 09:11:26'),
(13, 50, 1, '2026-11-01 13:17:26'),
(14, 34, 1, '2026-11-02 15:50:26'),
(14, 35, 1, '2026-11-02 11:57:26'),
(14, 39, 1, '2026-11-01 19:28:26'),
(14, 46, 1, '2026-11-01 15:01:26'),
(14, 52, 1, '2026-11-02 05:13:26'),
(15, 18, 0, '2026-11-02 07:56:26'),
(15, 32, 1, '2026-11-02 05:53:26'),
(15, 39, 1, '2026-11-02 00:37:26'),
(15, 44, 0, '2026-11-02 11:17:26'),
(15, 46, 1, '2026-11-02 18:00:26'),
(15, 47, 1, '2026-11-02 22:37:26'),
(15, 48, 1, '2026-11-01 20:17:26'),
(16, 30, 1, '2026-11-02 08:53:26'),
(16, 31, 1, '2026-11-03 01:03:26'),
(16, 44, 1, '2026-11-02 18:35:26'),
(16, 46, 1, '2026-11-03 03:54:26'),
(16, 47, 0, '2026-11-01 14:44:26'),
(16, 50, 1, '2026-11-02 04:57:26'),
(17, 17, 1, '2026-11-02 11:17:26'),
(17, 19, 1, '2026-11-01 08:05:26'),
(17, 29, 1, '2026-11-03 03:40:26'),
(17, 41, 1, '2026-11-01 20:54:26'),
(18, 20, 1, '2026-11-02 14:02:26'),
(19, 29, 1, '2026-11-02 21:09:26'),
(19, 34, 0, '2026-11-02 10:54:26'),
(19, 35, 1, '2026-11-01 23:34:26'),
(19, 39, 1, '2026-11-02 15:04:26'),
(19, 46, 1, '2026-11-02 02:06:26'),
(19, 48, 1, '2026-11-02 05:23:26'),
(22, 20, 1, '2026-11-01 13:01:26'),
(22, 35, 1, '2026-11-02 00:11:26'),
(22, 38, 1, '2026-11-02 11:47:26'),
(23, 36, 0, '2026-11-02 22:23:26'),
(24, 18, 1, '2026-11-01 08:33:26'),
(24, 19, 1, '2026-11-02 09:47:26'),
(24, 29, 1, '2026-11-02 12:10:26'),
(24, 34, 1, '2026-11-01 23:07:26'),
(24, 48, 1, '2026-11-02 23:53:26'),
(25, 21, 0, '2026-11-02 18:27:26'),
(25, 25, 0, '2026-11-01 18:09:26'),
(25, 30, 1, '2026-11-03 02:52:26'),
(25, 31, 0, '2026-11-01 09:23:26'),
(25, 36, 1, '2026-11-02 08:27:26'),
(25, 40, 0, '2026-11-02 16:54:26'),
(26, 17, 1, '2026-11-03 07:31:26'),
(26, 25, 1, '2026-11-02 20:05:26'),
(26, 33, 1, '2026-11-02 01:12:26'),
(26, 42, 0, '2026-11-03 06:09:26'),
(26, 43, 0, '2026-11-01 20:42:26'),
(26, 52, 1, '2026-11-02 20:42:26'),
(27, 36, 1, '2026-11-02 23:18:26'),
(27, 41, 1, '2026-11-01 08:23:26'),
(27, 48, 1, '2026-11-03 06:09:26'),
(27, 49, 1, '2026-11-01 12:05:26'),
(28, 51, 1, '2026-11-02 21:03:26'),
(29, 25, 1, '2026-11-02 23:06:26'),
(29, 26, 1, '2026-11-01 09:38:26'),
(29, 30, 0, '2026-11-01 14:31:26'),
(29, 41, 1, '2026-11-01 11:16:26'),
(29, 49, 1, '2026-11-03 00:03:26'),
(31, 22, 1, '2026-11-03 11:16:29'),
(31, 40, 1, '2026-11-03 05:48:29'),
(32, 17, 1, '2026-11-03 19:15:29'),
(32, 18, 1, '2026-11-03 12:49:29'),
(32, 32, 1, '2026-11-02 23:41:29'),
(32, 41, 1, '2026-11-03 01:14:29'),
(32, 50, 0, '2026-11-03 12:18:29'),
(33, 26, 1, '2026-11-03 07:59:29'),
(33, 27, 0, '2026-11-03 13:55:29'),
(33, 30, 1, '2026-11-03 12:45:29'),
(33, 39, 1, '2026-11-03 03:20:29'),
(33, 40, 1, '2026-11-03 02:09:29'),
(33, 50, 0, '2026-11-03 12:18:29'),
(34, 29, 1, '2026-11-03 01:19:29'),
(34, 35, 1, '2026-11-03 09:33:29'),
(34, 36, 1, '2026-11-03 12:17:29'),
(34, 40, 1, '2026-11-02 23:23:29'),
(34, 48, 1, '2026-11-02 22:20:29'),
(35, 37, 0, '2026-11-03 11:14:29'),
(35, 48, 1, '2026-11-03 11:34:29'),
(35, 52, 1, '2026-11-03 16:56:29'),
(36, 23, 1, '2026-11-03 14:47:29'),
(36, 24, 1, '2026-11-03 12:53:29'),
(36, 28, 1, '2026-11-03 04:29:29'),
(37, 23, 1, '2026-11-03 09:52:29'),
(37, 27, 1, '2026-11-03 10:18:29'),
(37, 32, 1, '2026-11-03 06:24:29'),
(37, 41, 0, '2026-11-03 05:12:29'),
(37, 43, 1, '2026-11-03 06:08:29'),
(37, 48, 1, '2026-11-03 10:12:29'),
(38, 17, 1, '2026-11-03 01:54:29'),
(38, 33, 1, '2026-11-03 01:40:29'),
(38, 41, 1, '2026-11-03 02:16:29'),
(39, 33, 1, '2026-11-03 03:02:29'),
(39, 37, 1, '2026-11-02 20:29:29'),
(39, 43, 1, '2026-11-03 11:00:29'),
(39, 49, 1, '2026-11-03 18:17:29'),
(40, 31, 1, '2026-11-03 14:21:29'),
(40, 36, 1, '2026-11-03 12:23:29'),
(40, 37, 1, '2026-11-03 02:48:29'),
(40, 43, 1, '2026-11-03 00:05:29'),
(40, 47, 0, '2026-11-03 13:41:29'),
(40, 50, 1, '2026-11-03 12:37:29'),
(41, 19, 1, '2026-11-03 02:41:29'),
(41, 20, 1, '2026-11-03 02:58:29'),
(41, 28, 1, '2026-11-03 00:27:29'),
(41, 35, 1, '2026-11-02 19:19:29'),
(41, 39, 1, '2026-11-03 08:53:29'),
(41, 50, 1, '2026-11-03 13:49:29'),
(42, 20, 1, '2026-11-03 16:10:29'),
(42, 25, 0, '2026-11-03 06:26:29'),
(42, 31, 1, '2026-11-03 02:05:29'),
(42, 43, 1, '2026-11-03 13:00:29'),
(42, 46, 1, '2026-11-03 18:20:29'),
(43, 17, 1, '2026-11-03 02:55:29'),
(43, 20, 1, '2026-11-03 07:36:29'),
(43, 21, 1, '2026-11-03 04:50:29'),
(44, 22, 1, '2026-11-02 19:19:29'),
(44, 23, 1, '2026-11-02 23:41:29'),
(44, 25, 1, '2026-11-03 06:45:29'),
(44, 35, 1, '2026-11-02 22:35:29'),
(44, 40, 1, '2026-11-02 23:41:29'),
(44, 45, 1, '2026-11-03 12:20:29'),
(45, 30, 1, '2026-11-03 08:45:29'),
(45, 38, 0, '2026-11-03 04:13:29'),
(46, 41, 0, '2026-11-02 22:40:29'),
(46, 43, 1, '2026-11-02 20:28:29'),
(46, 52, 1, '2026-11-03 00:09:29'),
(47, 27, 1, '2026-11-03 00:11:29'),
(47, 29, 1, '2026-11-02 20:12:29'),
(47, 30, 1, '2026-11-03 00:59:29'),
(47, 38, 1, '2026-11-03 17:17:29'),
(47, 39, 0, '2026-11-03 15:35:29'),
(47, 41, 1, '2026-11-03 08:37:29'),
(48, 23, 1, '2026-11-03 11:07:29'),
(48, 44, 1, '2026-11-02 22:19:29'),
(48, 52, 1, '2026-11-03 14:07:29'),
(49, 20, 1, '2026-11-03 07:04:29'),
(49, 31, 1, '2026-11-03 18:59:29'),
(49, 38, 1, '2026-11-02 22:43:29'),
(49, 42, 1, '2026-11-03 14:13:29'),
(50, 22, 1, '2026-11-03 07:37:29'),
(50, 23, 1, '2026-11-03 15:21:29'),
(50, 27, 1, '2026-11-02 23:36:29'),
(50, 47, 1, '2026-11-03 15:58:29'),
(50, 48, 1, '2026-11-03 02:41:29'),
(51, 39, 1, '2026-11-03 06:13:29'),
(52, 24, 1, '2026-11-02 21:19:29'),
(52, 49, 1, '2026-11-03 15:04:29'),
(52, 51, 1, '2026-11-03 18:53:29'),
(53, 32, 0, '2026-11-02 21:33:29'),
(53, 47, 1, '2026-11-03 09:23:29'),
(53, 52, 1, '2026-11-03 19:07:29'),
(54, 21, 1, '2026-11-03 14:18:29'),
(54, 28, 1, '2026-11-03 08:25:29'),
(54, 31, 1, '2026-11-03 12:43:29'),
(54, 35, 1, '2026-11-03 13:00:29'),
(54, 40, 1, '2026-11-03 01:12:29'),
(54, 44, 1, '2026-11-03 18:01:29'),
(55, 26, 1, '2026-11-03 12:49:29'),
(55, 41, 1, '2026-11-03 19:06:29'),
(55, 48, 1, '2026-11-02 19:38:29'),
(56, 21, 0, '2026-11-03 11:23:29'),
(56, 23, 1, '2026-11-02 20:03:29'),
(56, 33, 1, '2026-11-02 19:44:29'),
(56, 36, 1, '2026-11-03 03:46:29'),
(56, 38, 1, '2026-11-03 08:44:29'),
(57, 38, 1, '2026-11-02 21:21:05'),
(57, 40, 1, '2026-11-03 13:43:05'),
(57, 47, 1, '2026-11-02 20:49:05'),
(58, 22, 1, '2026-11-03 06:15:05'),
(58, 27, 1, '2026-11-02 21:24:05'),
(58, 34, 1, '2026-11-03 09:35:05'),
(58, 35, 1, '2026-11-03 08:57:05'),
(58, 36, 1, '2026-11-03 10:30:05'),
(58, 40, 0, '2026-11-02 23:16:05'),
(59, 49, 1, '2026-11-02 22:14:05'),
(60, 24, 1, '2026-11-02 22:51:05'),
(60, 33, 1, '2026-11-03 07:11:05'),
(60, 44, 1, '2026-11-03 03:47:05'),
(60, 45, 1, '2026-11-03 02:13:05'),
(61, 51, 1, '2026-11-03 02:09:05'),
(62, 21, 1, '2026-11-03 19:23:05'),
(62, 23, 1, '2026-11-03 02:53:05'),
(63, 41, 1, '2026-11-03 18:06:05'),
(63, 42, 1, '2026-11-03 01:12:05'),
(64, 18, 1, '2026-11-03 10:31:05'),
(64, 22, 1, '2026-11-03 16:55:05'),
(64, 38, 1, '2026-11-03 15:28:05'),
(64, 40, 1, '2026-11-03 17:29:05'),
(64, 52, 1, '2026-11-03 13:34:05'),
(65, 17, 1, '2026-11-03 03:25:05'),
(65, 19, 1, '2026-11-03 01:14:05'),
(65, 24, 1, '2026-11-02 22:00:05'),
(65, 30, 1, '2026-11-03 17:35:05'),
(65, 37, 1, '2026-11-03 04:39:05'),
(65, 48, 1, '2026-11-02 21:23:05'),
(66, 26, 1, '2026-11-03 06:43:05'),
(66, 30, 1, '2026-11-03 06:37:05'),
(66, 32, 0, '2026-11-03 05:03:05'),
(66, 39, 1, '2026-11-02 22:33:05'),
(66, 40, 0, '2026-11-02 20:41:05'),
(66, 44, 1, '2026-11-03 01:14:05'),
(67, 20, 1, '2026-11-03 10:23:05'),
(67, 24, 1, '2026-11-03 07:27:05'),
(67, 25, 1, '2026-11-03 04:37:05'),
(67, 29, 1, '2026-11-03 14:57:05'),
(68, 18, 1, '2026-11-03 00:07:05'),
(68, 23, 1, '2026-11-03 07:29:05'),
(68, 29, 1, '2026-11-03 01:45:05'),
(68, 35, 0, '2026-11-03 02:48:05'),
(68, 40, 1, '2026-11-03 14:50:05'),
(68, 47, 0, '2026-11-03 09:31:05'),
(69, 30, 1, '2026-11-03 18:10:05'),
(69, 35, 1, '2026-11-03 18:19:05'),
(69, 41, 1, '2026-11-02 20:07:05'),
(70, 21, 1, '2026-11-03 15:58:05'),
(70, 35, 1, '2026-11-03 05:35:05'),
(70, 38, 1, '2026-11-03 02:24:05'),
(70, 44, 0, '2026-11-03 17:32:05'),
(70, 46, 1, '2026-11-03 11:05:05'),
(71, 17, 1, '2026-11-03 11:21:05'),
(71, 19, 1, '2026-11-03 08:31:05'),
(71, 26, 1, '2026-11-03 14:09:05'),
(71, 40, 1, '2026-11-03 09:54:05'),
(71, 45, 0, '2026-11-03 03:59:05'),
(71, 47, 1, '2026-11-03 01:08:05'),
(72, 51, 1, '2026-11-03 02:44:05'),
(73, 28, 1, '2026-11-03 12:43:05'),
(73, 29, 1, '2026-11-03 04:35:05'),
(73, 32, 1, '2026-11-03 06:17:05'),
(73, 34, 0, '2026-11-03 10:13:05'),
(73, 52, 1, '2026-11-03 16:40:05'),
(74, 18, 1, '2026-11-03 09:10:05'),
(74, 19, 1, '2026-11-03 11:45:05'),
(74, 20, 1, '2026-11-03 18:09:05'),
(74, 37, 0, '2026-11-03 09:28:05'),
(74, 45, 1, '2026-11-02 21:52:05'),
(74, 49, 1, '2026-11-03 15:14:05'),
(75, 22, 1, '2026-11-03 03:11:05'),
(75, 35, 1, '2026-11-02 23:44:05'),
(75, 51, 0, '2026-11-03 08:03:05'),
(76, 24, 1, '2026-11-02 23:18:05'),
(76, 49, 1, '2026-11-03 02:01:05'),
(77, 18, 0, '2026-11-03 05:00:05'),
(77, 20, 1, '2026-11-02 20:53:05'),
(77, 22, 0, '2026-11-03 04:38:05'),
(77, 41, 1, '2026-11-03 18:15:05'),
(77, 49, 0, '2026-11-03 02:11:05'),
(77, 52, 1, '2026-11-03 14:38:05'),
(78, 17, 1, '2026-11-03 15:14:05'),
(78, 35, 0, '2026-11-03 04:04:05'),
(78, 44, 0, '2026-11-03 01:28:05'),
(78, 50, 1, '2026-11-03 06:22:05'),
(79, 17, 1, '2026-11-03 03:31:05'),
(79, 22, 1, '2026-11-03 19:08:05'),
(80, 21, 1, '2026-11-03 15:43:05'),
(80, 30, 1, '2026-11-03 11:40:05'),
(80, 41, 1, '2026-11-03 01:21:05'),
(81, 26, 0, '2026-11-03 19:14:05'),
(82, 29, 1, '2026-11-03 08:45:05'),
(82, 33, 0, '2026-11-03 15:27:05'),
(82, 35, 1, '2026-11-03 02:24:05'),
(82, 36, 0, '2026-11-03 15:09:05'),
(82, 45, 1, '2026-11-02 21:29:05'),
(82, 50, 1, '2026-11-03 17:50:05'),
(83, 19, 1, '2026-11-02 19:58:05'),
(83, 21, 1, '2026-11-02 23:34:05'),
(83, 28, 0, '2026-11-03 01:01:05'),
(83, 29, 0, '2026-11-03 13:54:05'),
(83, 34, 1, '2026-11-02 23:26:05'),
(83, 47, 1, '2026-11-03 18:30:05'),
(84, 31, 0, '2026-11-03 14:23:05'),
(84, 44, 1, '2026-11-02 21:44:05'),
(85, 24, 1, '2026-11-03 10:19:05'),
(85, 52, 1, '2026-11-03 19:18:05'),
(86, 19, 1, '2026-11-03 16:44:05'),
(86, 46, 1, '2026-11-03 13:41:05'),
(86, 47, 1, '2026-11-03 14:49:05'),
(86, 49, 1, '2026-11-03 12:12:05'),
(86, 50, 1, '2026-11-03 10:48:05'),
(87, 19, 1, '2026-11-03 19:40:05'),
(87, 24, 1, '2026-11-02 20:09:05'),
(87, 38, 1, '2026-11-03 17:43:05'),
(87, 41, 1, '2026-11-03 07:27:05'),
(87, 43, 1, '2026-11-02 22:32:05'),
(88, 20, 1, '2026-11-03 19:17:05'),
(88, 29, 1, '2026-11-03 17:11:05'),
(88, 31, 1, '2026-11-03 11:37:05'),
(88, 32, 1, '2026-11-03 02:00:05'),
(88, 44, 1, '2026-11-03 02:26:05'),
(89, 17, 1, '2026-11-02 23:33:05'),
(89, 22, 1, '2026-11-03 19:10:05'),
(89, 28, 1, '2026-11-03 02:35:05'),
(89, 32, 0, '2026-11-03 03:11:05'),
(89, 41, 1, '2026-11-03 01:23:05'),
(89, 46, 1, '2026-11-03 14:40:05'),
(90, 29, 1, '2026-11-03 19:34:05'),
(90, 37, 1, '2026-11-02 21:47:05'),
(90, 41, 1, '2026-11-03 16:42:05'),
(90, 45, 0, '2026-11-02 20:56:05'),
(90, 48, 1, '2026-11-03 19:30:05'),
(91, 42, 1, '2026-11-03 14:34:05'),
(91, 43, 1, '2026-11-03 04:25:05'),
(91, 48, 1, '2026-11-03 00:13:05'),
(92, 29, 1, '2026-11-02 20:09:05'),
(92, 43, 1, '2026-11-03 12:59:05'),
(93, 26, 1, '2026-11-02 20:54:05'),
(93, 28, 1, '2026-11-03 14:19:05'),
(93, 35, 1, '2026-11-03 10:07:05'),
(93, 41, 1, '2026-11-02 22:58:05'),
(93, 42, 1, '2026-11-03 03:29:05'),
(93, 48, 1, '2026-11-03 00:56:05'),
(94, 17, 1, '2026-11-03 08:38:05'),
(94, 20, 1, '2026-11-02 21:23:05'),
(94, 28, 0, '2026-11-03 06:34:05'),
(94, 32, 1, '2026-11-03 11:42:05'),
(94, 35, 1, '2026-11-03 08:21:05'),
(94, 42, 1, '2026-11-03 14:35:05'),
(95, 22, 1, '2026-11-02 22:55:05'),
(96, 34, 1, '2026-11-03 12:55:05'),
(96, 40, 1, '2026-11-03 17:58:05'),
(96, 42, 1, '2026-11-02 20:54:05'),
(96, 43, 1, '2026-11-03 04:50:05'),
(97, 22, 0, '2026-11-02 23:00:05'),
(97, 23, 1, '2026-11-03 05:29:05'),
(97, 28, 1, '2026-11-02 21:48:05'),
(97, 29, 0, '2026-11-02 23:48:05'),
(97, 31, 1, '2026-11-03 01:33:05'),
(97, 51, 0, '2026-11-03 04:31:05'),
(98, 21, 0, '2026-11-03 12:06:05'),
(98, 49, 0, '2026-11-03 05:04:05'),
(99, 17, 1, '2026-11-03 15:02:05'),
(99, 22, 1, '2026-11-03 13:57:05'),
(99, 28, 0, '2026-11-03 04:40:05'),
(99, 31, 1, '2026-11-03 05:04:05'),
(99, 41, 1, '2026-11-03 00:39:05'),
(100, 26, 1, '2026-11-03 13:29:05'),
(100, 29, 0, '2026-11-03 02:43:05'),
(100, 32, 1, '2026-11-03 19:07:05'),
(100, 33, 1, '2026-11-03 04:11:05'),
(100, 46, 1, '2026-11-03 16:45:05'),
(100, 50, 1, '2026-11-03 00:08:05'),
(101, 17, 0, '2026-11-03 18:03:05'),
(101, 21, 0, '2026-11-02 23:53:05'),
(101, 28, 1, '2026-11-03 16:18:05'),
(101, 29, 1, '2026-11-03 19:12:05'),
(101, 48, 1, '2026-11-03 14:34:05'),
(102, 24, 1, '2026-11-03 07:15:05'),
(102, 25, 0, '2026-11-02 23:23:05'),
(102, 29, 0, '2026-11-03 06:20:05'),
(102, 35, 0, '2026-11-03 14:55:05'),
(102, 45, 1, '2026-11-03 06:54:05'),
(102, 51, 1, '2026-11-03 05:28:05'),
(103, 22, 1, '2026-11-03 01:05:05'),
(103, 23, 0, '2026-11-03 00:51:05'),
(103, 26, 0, '2026-11-03 13:34:05'),
(103, 32, 1, '2026-11-03 14:16:05'),
(103, 40, 1, '2026-11-03 09:48:05'),
(103, 44, 1, '2026-11-03 03:21:05'),
(104, 19, 1, '2026-11-03 11:53:05'),
(104, 31, 1, '2026-11-02 23:29:05'),
(104, 42, 1, '2026-11-03 07:24:05'),
(104, 43, 1, '2026-11-03 02:43:05'),
(104, 48, 1, '2026-11-02 21:56:05'),
(104, 51, 0, '2026-11-03 11:39:05'),
(105, 38, 1, '2026-11-03 03:18:05'),
(106, 32, 0, '2026-11-03 16:40:05'),
(107, 18, 1, '2026-11-03 03:37:05'),
(107, 40, 1, '2026-11-02 21:28:05'),
(107, 44, 1, '2026-11-03 08:56:05'),
(107, 52, 1, '2026-11-02 22:24:05'),
(108, 24, 1, '2026-11-03 08:20:05'),
(108, 28, 1, '2026-11-02 22:09:05'),
(108, 47, 1, '2026-11-03 04:12:05'),
(109, 17, 0, '2026-11-03 02:42:05'),
(109, 37, 1, '2026-11-03 10:42:05'),
(109, 50, 1, '2026-11-03 11:01:05'),
(109, 52, 0, '2026-11-02 20:28:05'),
(110, 18, 1, '2026-11-03 12:33:05'),
(110, 31, 1, '2026-11-03 13:24:05'),
(110, 37, 1, '2026-11-03 00:47:05'),
(110, 51, 1, '2026-11-03 01:00:05'),
(110, 52, 1, '2026-11-03 10:30:05'),
(111, 22, 1, '2026-11-03 04:55:05'),
(111, 23, 1, '2026-11-03 10:07:05'),
(111, 36, 1, '2026-11-03 04:18:05'),
(111, 38, 1, '2026-11-03 01:10:05'),
(111, 50, 0, '2026-11-02 21:08:05'),
(111, 51, 1, '2026-11-03 14:38:05'),
(112, 27, 0, '2026-11-03 14:33:05'),
(113, 35, 1, '2026-11-03 02:04:05'),
(113, 39, 1, '2026-11-02 21:57:05'),
(113, 41, 1, '2026-11-03 08:35:05'),
(113, 50, 1, '2026-11-03 04:08:05'),
(114, 25, 1, '2026-11-03 02:42:05'),
(114, 49, 0, '2026-11-03 13:25:05'),
(115, 26, 1, '2026-11-03 09:33:05'),
(116, 19, 1, '2026-11-03 00:32:05'),
(116, 22, 0, '2026-11-02 20:08:05'),
(117, 35, 1, '2026-11-03 04:18:05');

-- --------------------------------------------------------

--
-- Table structure for table `binh_luan_nhat_ky`
--

CREATE TABLE `binh_luan_nhat_ky` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `nhat_ky_phat_trien_id` bigint(20) UNSIGNED NOT NULL,
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `binh_luan_cha_id` bigint(20) UNSIGNED DEFAULT NULL,
  `noi_dung` text NOT NULL,
  `trang_thai` enum('published','hidden','removed') NOT NULL DEFAULT 'published',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `binh_luan_nhat_ky`
--

INSERT INTO `binh_luan_nhat_ky` (`ma`, `nhat_ky_phat_trien_id`, `nguoi_dung_id`, `binh_luan_cha_id`, `noi_dung`, `trang_thai`, `ngay_tao`) VALUES
(1, 5, 33, NULL, 'Mình mới biết tin này, cảm ơn nhé.', 'published', '2026-09-06 14:00:00'),
(2, 6, 51, NULL, 'Mình mới biết tin này, cảm ơn nhé.', 'published', '2026-09-23 09:00:00'),
(3, 7, 26, NULL, 'Cảm ơn bản tóm tắt, dễ đọc hơn bản gốc.', 'published', '2026-10-14 19:00:00'),
(4, 8, 41, NULL, 'Cảm ơn bản tóm tắt, dễ đọc hơn bản gốc.', 'published', '2026-09-10 06:00:00'),
(5, 9, 29, NULL, 'Cảm ơn bản tóm tắt, dễ đọc hơn bản gốc.', 'published', '2026-10-04 08:00:00'),
(6, 10, 38, NULL, 'Mình mới biết tin này, cảm ơn nhé.', 'published', '2026-09-13 12:00:00'),
(7, 11, 20, NULL, 'Không ngờ đã lâu như vậy rồi.', 'published', '2026-10-08 00:00:00'),
(8, 12, 42, NULL, 'Bản cập nhật này đáng giá thật.', 'published', '2026-09-14 04:30:00'),
(9, 13, 39, NULL, 'Cảm ơn bản tóm tắt, dễ đọc hơn bản gốc.', 'published', '2026-09-16 15:00:00'),
(10, 13, 21, NULL, 'Mình chờ bản này lâu lắm rồi.', 'published', '2026-09-14 15:00:00'),
(11, 14, 47, NULL, 'Hy vọng sẽ có thêm nội dung như vậy.', 'published', '2026-10-11 06:00:00'),
(12, 15, 44, NULL, 'Hy vọng sẽ có thêm nội dung như vậy.', 'published', '2026-09-19 02:30:00'),
(13, 15, 46, NULL, 'Hy vọng sẽ có thêm nội dung như vậy.', 'published', '2026-09-18 20:30:00'),
(14, 16, 22, NULL, 'Có ai biết bản này nặng bao nhiêu không?', 'published', '2026-09-21 02:00:00'),
(15, 16, 48, NULL, 'Đọc xong lại muốn chơi lại từ đầu.', 'published', '2026-09-20 22:00:00'),
(16, 17, 24, NULL, 'Tóm tắt ngắn gọn, có nguồn rõ ràng, thích.', 'published', '2026-09-23 12:00:00'),
(17, 18, 25, NULL, 'Có ai biết bản này nặng bao nhiêu không?', 'published', '2026-10-16 12:00:00'),
(18, 19, 41, NULL, 'Đọc xong lại muốn chơi lại từ đầu.', 'published', '2026-09-25 11:00:00'),
(19, 20, 30, NULL, 'Không ngờ đã lâu như vậy rồi.', 'published', '2026-09-04 10:00:00'),
(20, 20, 44, NULL, 'Hồi đó mình chơi ngay ngày đầu, vui lắm.', 'published', '2026-09-03 03:00:00'),
(21, 21, 37, NULL, 'Mình mới biết tin này, cảm ơn nhé.', 'published', '2026-10-23 00:00:00'),
(22, 21, 31, NULL, 'Hy vọng sẽ có thêm nội dung như vậy.', 'published', '2026-10-23 15:00:00'),
(23, 22, 29, NULL, 'Không ngờ đã lâu như vậy rồi.', 'published', '2026-09-09 22:00:00'),
(24, 23, 18, NULL, 'Có ai biết bản này nặng bao nhiêu không?', 'published', '2026-09-29 08:00:00'),
(25, 24, 27, NULL, 'Hy vọng sẽ có thêm nội dung như vậy.', 'published', '2026-10-20 07:00:00'),
(26, 25, 36, NULL, 'Đọc xong lại muốn chơi lại từ đầu.', 'published', '2026-09-27 06:00:00'),
(27, 26, 48, NULL, 'Hồi đó mình chơi ngay ngày đầu, vui lắm.', 'published', '2026-10-03 05:00:00'),
(28, 27, 35, NULL, 'Tóm tắt ngắn gọn, có nguồn rõ ràng, thích.', 'published', '2026-10-06 07:00:00'),
(29, 28, 21, NULL, 'Hy vọng sẽ có thêm nội dung như vậy.', 'published', '2026-10-08 17:00:00'),
(30, 29, 52, NULL, 'Đọc xong lại muốn chơi lại từ đầu.', 'published', '2026-10-10 02:00:00'),
(31, 29, 48, NULL, 'Đọc xong lại muốn chơi lại từ đầu.', 'published', '2026-10-09 06:00:00'),
(32, 30, 23, NULL, 'Mình chờ bản này lâu lắm rồi.', 'published', '2026-10-14 08:00:00'),
(33, 31, 30, NULL, 'Tóm tắt ngắn gọn, có nguồn rõ ràng, thích.', 'published', '2026-10-16 09:00:00'),
(34, 32, 34, NULL, 'Mình chờ bản này lâu lắm rồi.', 'published', '2026-10-16 19:00:00'),
(35, 33, 28, NULL, 'Mình chờ bản này lâu lắm rồi.', 'published', '2026-10-22 14:00:00'),
(36, 33, 27, NULL, 'Cảm ơn bản tóm tắt, dễ đọc hơn bản gốc.', 'published', '2026-10-20 12:00:00'),
(37, 34, 24, NULL, 'Không ngờ đã lâu như vậy rồi.', 'published', '2026-09-02 19:00:00'),
(38, 35, 22, NULL, 'Bản cập nhật này đáng giá thật.', 'published', '2026-09-07 22:00:00'),
(39, 36, 34, NULL, 'Đọc xong lại muốn chơi lại từ đầu.', 'published', '2026-09-10 14:00:00'),
(40, 37, 35, NULL, 'Mình mới biết tin này, cảm ơn nhé.', 'published', '2026-09-13 16:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `binh_luan_tro_choi`
--

CREATE TABLE `binh_luan_tro_choi` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `binh_luan_cha_id` bigint(20) UNSIGNED DEFAULT NULL,
  `noi_dung` mediumtext NOT NULL,
  `trang_thai` enum('published','hidden','removed') NOT NULL DEFAULT 'published',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `binh_luan_tro_choi`
--

INSERT INTO `binh_luan_tro_choi` (`ma`, `tro_choi_id`, `nguoi_dung_id`, `binh_luan_cha_id`, `noi_dung`, `trang_thai`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(1, 3, 20, NULL, 'Game chiến thuật cổ đại miễn phí mà chất lượng thế này thì quá đáng nể.', 'published', '2026-08-21 18:39:26', '2026-08-21 18:39:26'),
(2, 3, 52, 1, 'Agreed, hard to believe it is free.', 'published', '2026-08-21 20:59:26', '2026-08-21 20:59:26'),
(3, 3, 43, NULL, 'The historical detail on each civilization is lovely.', 'published', '2026-09-02 03:38:26', '2026-09-02 03:38:26'),
(4, 3, 31, NULL, 'Gợi nhớ những game chiến thuật mình chơi hồi nhỏ.', 'published', '2026-09-14 17:08:26', '2026-09-14 17:08:26'),
(5, 3, 20, 4, 'Đúng chất luôn, cả việc xây nhà để tăng dân số.', 'published', '2026-09-15 05:04:26', '2026-09-15 05:04:26'),
(6, 3, 52, NULL, 'The AI is a good teacher. Losing a lot, learning a lot.', 'published', '2026-09-17 22:51:26', '2026-09-17 22:51:26'),
(7, 4, 19, NULL, 'Game đua xe vui nhất mình từng chơi với bạn bè.', 'published', '2026-10-29 16:43:26', '2026-10-29 16:43:26'),
(8, 4, 38, 7, 'Cứ LAN là phải có STK.', 'published', '2026-10-29 20:34:26', '2026-10-29 20:34:26'),
(9, 4, 40, 7, 'Same here!', 'published', '2026-10-30 04:56:26', '2026-10-30 04:56:26'),
(10, 4, 35, NULL, 'Chơi chế độ câu chuyện rất vui, mỗi khu vực một kiểu.', 'published', '2026-08-07 08:01:26', '2026-08-07 08:01:26'),
(11, 4, 32, NULL, 'Time trial gây nghiện quá.', 'published', '2026-10-05 12:42:26', '2026-10-05 12:42:26'),
(12, 4, 19, 11, 'Đợi xem kỷ lục mới của bạn trên diễn đàn.', 'published', '2026-10-05 23:04:26', '2026-10-05 23:04:26'),
(13, 4, 39, NULL, 'My kids love this one. Easy to pick up.', 'published', '2026-08-06 15:10:26', '2026-08-06 15:10:26'),
(14, 4, 37, NULL, 'Mô hình kart ở đây là nguồn cảm hứng để mình học Blender.', 'published', '2026-08-06 07:55:26', '2026-08-06 07:55:26'),
(15, 5, 28, NULL, 'Chiến dịch hay, mỗi nước đi đều phải tính.', 'published', '2026-09-15 10:36:26', '2026-09-15 10:36:26'),
(16, 5, 49, 15, 'And the random hits keep you humble.', 'published', '2026-09-15 18:30:26', '2026-09-15 18:30:26'),
(17, 5, 46, NULL, 'The add-on server has so many community campaigns.', 'published', '2026-10-05 17:23:26', '2026-10-05 17:23:26'),
(18, 5, 36, NULL, 'Đồ họa 2D nhưng rất có hồn.', 'published', '2026-08-11 16:24:26', '2026-08-11 16:24:26'),
(19, 5, 28, 18, 'Chân dung nhân vật vẽ đẹp lắm.', 'published', '2026-08-12 11:22:26', '2026-08-12 11:22:26'),
(20, 6, 21, NULL, 'Xây nhà ở đây là cách mình thư giãn mỗi tối.', 'published', '2026-09-29 14:20:26', '2026-09-29 14:20:26'),
(21, 6, 27, 20, 'Mình cũng vậy, kiếm được một góc đồi đẹp là xây luôn.', 'published', '2026-09-30 06:34:26', '2026-09-30 06:34:26'),
(22, 6, 26, NULL, 'Viết mod bằng Lua rất dễ bắt đầu, ai muốn học thì hỏi mình.', 'published', '2026-08-26 14:40:26', '2026-08-26 14:40:26'),
(23, 6, 51, 22, 'I might take you up on that!', 'published', '2026-08-27 11:38:26', '2026-08-27 11:38:26'),
(24, 6, 51, NULL, 'Built a castle with my friends on our server. Took three weekends.', 'published', '2026-10-02 03:39:26', '2026-10-02 03:39:26'),
(25, 6, 41, NULL, 'Runs great on my old Linux laptop.', 'published', '2026-09-15 05:24:26', '2026-09-15 05:24:26'),
(26, 7, 30, NULL, 'Dây chuyền tự động chạy đều là cảm giác thỏa mãn nhất.', 'published', '2026-10-23 07:21:26', '2026-10-23 07:21:26'),
(27, 7, 45, 26, 'Watching the core fill up is so relaxing.', 'published', '2026-10-24 06:50:26', '2026-10-24 06:50:26'),
(28, 7, 39, NULL, 'Tower defense plus factory, perfect combination.', 'published', '2026-08-19 01:30:26', '2026-08-19 01:30:26'),
(29, 7, 45, NULL, 'Campaign is long and rewarding.', 'published', '2026-09-12 00:37:26', '2026-09-12 00:37:26'),
(30, 7, 30, 29, 'Chơi xong một hành tinh mất cả tháng của mình.', 'published', '2026-09-12 14:47:26', '2026-09-12 14:47:26'),
(31, 8, 22, NULL, 'Game duy nhất khiến mình nghĩ về tín hiệu đường sắt lúc đi ngủ.', 'published', '2026-08-22 00:30:26', '2026-08-22 00:30:26'),
(32, 8, 47, 31, 'Welcome to the club.', 'published', '2026-08-22 19:40:26', '2026-08-22 19:40:26'),
(33, 8, 47, NULL, 'Decades of content and still getting updates. Amazing.', 'published', '2026-09-18 01:11:26', '2026-09-18 01:11:26'),
(34, 8, 49, NULL, 'Bus networks are underrated.', 'published', '2026-09-28 09:45:26', '2026-09-28 09:45:26'),
(35, 8, 22, 34, 'Xe buýt kiếm tiền đầu game tốt lắm.', 'published', '2026-09-28 17:31:26', '2026-09-28 17:31:26'),
(36, 8, 41, NULL, 'Lost a whole weekend to this. No regrets.', 'published', '2026-09-27 08:59:26', '2026-09-27 08:59:26'),
(37, 9, 24, NULL, 'Tốc độ của game rất đã, cảm giác di chuyển cực mượt.', 'published', '2026-10-09 21:46:26', '2026-10-09 21:46:26'),
(38, 9, 50, 37, 'Movement is the real skill here.', 'published', '2026-10-10 14:53:26', '2026-10-10 14:53:26'),
(39, 9, 50, NULL, 'Great arena shooter, and free. What more do you want?', 'published', '2026-09-28 13:31:26', '2026-09-28 13:31:26'),
(40, 9, 38, NULL, 'Chơi LAN rất ổn, không cần internet.', 'published', '2026-08-17 09:25:26', '2026-08-17 09:25:26'),
(41, 10, 36, NULL, 'Đã mất ngủ vì câu một lượt nữa thôi.', 'published', '2026-09-23 01:11:26', '2026-09-23 01:11:26'),
(42, 10, 46, 41, 'Classic Freeciv experience.', 'published', '2026-09-23 17:49:26', '2026-09-23 17:49:26'),
(43, 10, 35, 41, 'Mình cũng vậy.', 'published', '2026-09-24 12:02:26', '2026-09-24 12:02:26'),
(44, 10, 46, NULL, 'Longturn games are a great way to meet people.', 'published', '2026-10-12 08:14:26', '2026-10-12 08:14:26'),
(45, 10, 49, NULL, 'Deep strategy, gentle learning curve if you start on classic rules.', 'published', '2026-09-25 12:34:26', '2026-09-25 12:34:26'),
(46, 15, 27, NULL, 'Năm đầu tiên nên trồng gì cho nhanh có tiền vậy mọi người?', 'published', '2026-11-01 11:18:29', '2026-11-01 11:18:29'),
(47, 15, 21, 46, 'Mùa xuân trồng súp lơ, sang hè thì việt quất. Nhớ để dành tiền mua balo trước nhé.', 'published', '2026-11-01 12:32:29', '2026-11-01 12:32:29'),
(48, 15, 35, 46, 'Đừng quên tưới cây mỗi ngày, mình toàn quên rồi cây héo hết.', 'published', '2026-11-01 20:50:29', '2026-11-01 20:50:29'),
(49, 15, 48, NULL, 'Played co-op with my sister for 60 hours. Best cozy game ever.', 'published', '2026-11-01 01:30:29', '2026-11-01 01:30:29'),
(50, 15, 41, 49, 'Same here, co-op makes the farm feel alive.', 'published', '2026-11-01 08:45:29', '2026-11-01 08:45:29'),
(51, 16, 24, NULL, 'Hornet ở Greenpath làm mình chết 15 lần mới qua.', 'published', '2026-11-02 02:26:29', '2026-11-02 02:26:29'),
(52, 16, 32, 51, 'Học cách né rồi đánh lại 2 nhát thôi, đừng tham. Qua được rồi thì các trùm sau còn khó hơn.', 'published', '2026-11-02 11:41:29', '2026-11-02 11:41:29'),
(53, 16, 39, NULL, 'The atmosphere in City of Tears is incredible. The music is perfect.', 'published', '2026-11-01 22:39:29', '2026-11-01 22:39:29'),
(54, 16, 33, 53, 'Đồng ý, đoạn mưa ở City of Tears là phần mình thích nhất.', 'published', '2026-11-02 03:08:29', '2026-11-02 03:08:29'),
(55, 16, 38, NULL, 'Có ai mở được hết bản đồ mà không xem hướng dẫn chưa?', 'published', '2026-10-31 20:00:29', '2026-10-31 20:00:29'),
(56, 17, 32, NULL, 'Chương 7 dài nhưng cảm giác lên được đỉnh thật sự đáng.', 'published', '2026-10-31 07:07:29', '2026-10-31 07:07:29'),
(57, 17, 31, 56, 'Bật chế độ hỗ trợ cũng không sao đâu, game khuyến khích mà.', 'published', '2026-10-31 12:02:29', '2026-10-31 12:02:29'),
(58, 17, 43, NULL, 'The soundtrack by Lena Raine is on repeat on my playlist.', 'published', '2026-10-31 23:24:29', '2026-10-31 23:24:29'),
(59, 18, 44, NULL, 'Each death actually moves the story forward. Brilliant design.', 'published', '2026-11-01 10:21:29', '2026-11-01 10:21:29'),
(60, 18, 22, 59, 'Đúng vậy, mình chết nhiều mà không thấy bực, lại muốn về nhà nói chuyện với mọi người.', 'published', '2026-11-01 13:30:29', '2026-11-01 13:30:29'),
(61, 18, 20, NULL, 'Combo phúc lành Zeus với Athena chơi an toàn nhất cho người mới.', 'published', '2026-10-31 14:47:29', '2026-10-31 14:47:29'),
(62, 18, 24, 61, 'Thử giáo Varatha với Poseidon đi, đẩy quái vào tường rất sướng.', 'published', '2026-10-31 18:32:29', '2026-10-31 18:32:29'),
(63, 19, 32, NULL, 'Mới chơi nên chọn vũ khí nào khởi đầu cho dễ?', 'published', '2026-11-01 23:51:29', '2026-11-01 23:51:29'),
(64, 19, 47, 63, 'Rusty Sword is fine, but grab a bow or turrets early for safety.', 'published', '2026-11-02 07:24:29', '2026-11-02 07:24:29'),
(65, 19, 30, 63, 'Nhớ mở khóa bình máu thêm trước, dễ thở hơn hẳn.', 'published', '2026-11-02 11:49:29', '2026-11-02 11:49:29'),
(66, 19, 42, NULL, 'Combat feels so smooth. Hard to stop after one run.', 'published', '2026-10-31 14:16:29', '2026-10-31 14:16:29'),
(67, 20, 28, NULL, 'Silent bộ độc rất mạnh nếu nhặt được Catalyst sớm.', 'published', '2026-11-01 19:49:29', '2026-11-01 19:49:29'),
(68, 20, 36, 67, 'Mình thích Defect hơn, chồng quả cầu băng rồi phòng thủ cả trận.', 'published', '2026-11-02 00:33:29', '2026-11-02 00:33:29'),
(69, 20, 51, NULL, 'Ascension 20 with Watcher finally done after 300 hours.', 'published', '2026-11-01 04:35:29', '2026-11-01 04:35:29'),
(70, 20, 52, 69, 'Congrats! Watcher is so fun but punishing when you forget to leave Wrath.', 'published', '2026-11-01 12:38:29', '2026-11-01 12:38:29'),
(71, 20, 25, NULL, 'May là có tiếng Việt, đọc mô tả bài dễ hiểu hơn nhiều.', 'published', '2026-11-01 01:01:29', '2026-11-01 01:01:29'),
(72, 21, 26, NULL, 'Ai chơi bản mod Calamity chưa? Nội dung nhiều gấp đôi.', 'published', '2026-10-30 23:17:29', '2026-10-30 23:17:29'),
(73, 21, 34, 72, 'Có, nhưng nên chơi bản gốc xong trước rồi hãy cài mod.', 'published', '2026-10-31 04:08:29', '2026-10-31 04:08:29'),
(74, 21, 19, NULL, 'Server 4 người chơi với bạn cùng lớp, xây hẳn cái lâu đài trên trời.', 'published', '2026-11-02 12:39:29', '2026-11-02 12:39:29'),
(75, 21, 50, 74, 'Sky castles are the best. Post a screenshot!', 'published', '2026-11-02 17:57:29', '2026-11-02 17:57:29'),
(76, 22, 21, NULL, 'Chơi chừng 2 tiếng là xong mà nhớ mãi. Rất hợp để thư giãn cuối tuần.', 'published', '2026-11-02 09:45:29', '2026-11-02 09:45:29'),
(77, 22, 27, 76, 'Mình còn ở lại câu cá thêm cả tiếng nữa.', 'published', '2026-11-02 16:25:29', '2026-11-02 16:25:29'),
(78, 22, 49, NULL, 'Gliding off the summit at sunset is a perfect moment.', 'published', '2026-11-01 16:46:29', '2026-11-01 16:46:29'),
(79, 23, 35, NULL, 'Tưởng game đơn giản ai ngờ chơi xuyên đêm luôn.', 'published', '2026-10-31 07:12:29', '2026-10-31 07:12:29'),
(80, 23, 30, 79, 'Cứ nhặt thêm một cái rương nữa rồi thôi, kiểu vậy.', 'published', '2026-10-31 11:14:29', '2026-10-31 11:14:29'),
(81, 23, 46, NULL, 'Local co-op with 4 friends is pure chaos, in a good way.', 'published', '2026-10-31 10:59:29', '2026-10-31 10:59:29'),
(82, 24, 33, NULL, 'Cứ tưởng chỉ là kiểm tra giấy tờ mà mình bị cuốn vào câu chuyện từng người.', 'published', '2026-11-02 07:12:29', '2026-11-02 07:12:29'),
(83, 24, 25, 82, 'Đoạn người chồng đi trước, người vợ thiếu giấy đi sau làm mình phân vân mãi.', 'published', '2026-11-02 16:52:29', '2026-11-02 16:52:29'),
(84, 24, 47, NULL, 'Glory to Arstotzka. One of the best games about moral choices.', 'published', '2026-11-02 03:54:29', '2026-11-02 03:54:29'),
(85, 25, 28, NULL, 'Phần đầu tưởng chỉ là game bài, ai ngờ càng chơi càng lạ. Đừng đọc spoiler trước nhé.', 'published', '2026-10-31 18:21:05', '2026-10-31 18:21:05'),
(86, 25, 33, 85, 'Chuẩn, mình bị bất ngờ hai lần liền.', 'published', '2026-10-31 20:49:05', '2026-10-31 20:49:05'),
(87, 26, 21, NULL, 'Chơi xong thấy muốn dọn lại phòng mình luôn.', 'published', '2026-11-02 11:44:05', '2026-11-02 11:44:05'),
(88, 26, 41, NULL, 'No words, but I still teared up near the end.', 'published', '2026-11-02 19:26:05', '2026-11-02 19:26:05'),
(89, 27, 36, NULL, 'Nên ưu tiên đặt núi cạnh nhau sớm để tăng máu, đỡ chết vòng đầu.', 'published', '2026-11-01 14:39:05', '2026-11-01 14:39:05'),
(90, 27, 22, 89, 'Thêm mẹo: rút lui khi gần tới trùm để giữ đủ tài nguyên.', 'published', '2026-11-01 19:11:05', '2026-11-01 19:11:05'),
(91, 28, 27, NULL, 'Câu cá thì chill mà đêm xuống thì sợ thật sự.', 'published', '2026-10-31 08:35:05', '2026-10-31 08:35:05'),
(92, 29, 20, NULL, 'Game cũ mà vẫn hay. Mẹo: luôn nâng khiên trước tiên.', 'published', '2026-11-02 11:24:05', '2026-11-02 11:24:05'),
(93, 29, 47, 92, 'And never ignore the door upgrades against boarders.', 'published', '2026-11-02 17:48:05', '2026-11-02 17:48:05'),
(94, 30, 26, NULL, 'Ai mới chơi nên cài mod hiện thông tin đồ ăn, đỡ chết đói vô lý.', 'published', '2026-11-01 04:45:05', '2026-11-01 04:45:05'),
(95, 31, 32, NULL, 'Mới mua hôm qua, thức tới 3 giờ sáng. Không biết nên vui hay buồn.', 'published', '2026-11-02 17:36:05', '2026-11-02 17:36:05'),
(96, 31, 35, 95, 'Mình cũng vậy, \"một ván nữa thôi\" mãi không dừng.', 'published', '2026-11-02 19:38:05', '2026-11-02 19:38:05'),
(97, 32, 52, NULL, 'Losing a level 6 hero to a heart attack is a special kind of pain.', 'published', '2026-10-30 22:13:05', '2026-10-30 22:13:05'),
(98, 33, 24, NULL, 'Chơi hai người với em trai, cãi nhau suốt nhưng vui.', 'published', '2026-11-02 02:09:05', '2026-11-02 02:09:05'),
(99, 34, 30, NULL, 'Thuộc địa đầu tiên của mình sụp vì một con sóc nổi điên. Game hay.', 'published', '2026-11-01 07:47:05', '2026-11-01 07:47:05'),
(100, 34, 26, 99, 'Thử thêm mod quản lý công việc, đỡ phải chỉnh tay nhiều.', 'published', '2026-11-01 15:03:05', '2026-11-01 15:03:05'),
(101, 35, 19, NULL, 'Nhớ lật bàn mà nấp, lần đầu chơi mình quên tính năng này.', 'published', '2026-10-31 10:16:05', '2026-10-31 10:16:05'),
(102, 36, 29, NULL, 'Nhạc của game này nghe lại vẫn nổi da gà.', 'published', '2026-11-01 21:19:05', '2026-11-01 21:19:05'),
(103, 36, 40, 102, 'Megalovania is still on my playlist.', 'published', '2026-11-02 02:46:05', '2026-11-02 02:46:05'),
(104, 37, 30, NULL, 'Cảnh báo: game này ăn mất cuối tuần của bạn.', 'published', '2026-11-02 19:13:05', '2026-11-02 19:13:05'),
(105, 37, 20, NULL, 'Chơi co-op với bạn, một người lo dầu, một người lo mạch. Rất vui.', 'published', '2026-10-30 21:27:05', '2026-10-30 21:27:05'),
(106, 38, 17, NULL, 'Mô phỏng nhiệt độ chi tiết thật, phải học cách cách nhiệt các phòng.', 'published', '2026-10-30 21:00:05', '2026-10-30 21:00:05'),
(107, 39, 31, NULL, 'Nhạc synthwave cực hợp với nhịp chém. Cốt truyện cũng lạ.', 'published', '2026-10-30 20:39:05', '2026-10-30 20:39:05'),
(108, 40, 25, NULL, 'Hội thoại viết rất đời, nhất là đoạn nói chuyện với Bea.', 'published', '2026-10-31 02:24:05', '2026-10-31 02:24:05'),
(109, 41, 23, NULL, 'Ý tưởng sổ tay hướng dẫn trong game quá hay, nhìn như sách thật.', 'published', '2026-11-01 14:31:05', '2026-11-01 14:31:05'),
(110, 42, 28, NULL, 'Mỗi lượt như một câu đố cờ vua nhỏ. Rất đáng tiền.', 'published', '2026-11-02 02:43:05', '2026-11-02 02:43:05'),
(111, 43, 33, NULL, 'Mình phải lấy giấy bút ghi chép như thám tử thật.', 'published', '2026-11-02 17:04:05', '2026-11-02 17:04:05'),
(112, 43, 39, 111, 'Same here, the accents of the crew are big clues.', 'published', '2026-11-03 02:56:05', '2026-11-03 02:56:05'),
(113, 44, 17, NULL, 'Khó phát điên, nhưng khi nghĩ ra lời giải thì sướng cực.', 'published', '2026-11-02 05:39:05', '2026-11-02 05:39:05'),
(114, 45, 34, NULL, 'Hy vọng có bản Linux. Mình chơi qua Proton thì vẫn ổn.', 'published', '2026-10-31 08:47:05', '2026-10-31 08:47:05'),
(115, 46, 21, NULL, 'Chuẩn bị khăn giấy, mỗi lần tiễn một linh hồn đều buồn.', 'published', '2026-10-31 16:23:05', '2026-10-31 16:23:05'),
(116, 47, 20, NULL, 'Tuổi thơ của mình. Giờ còn có chơi mạng, vui hơn ngày xưa.', 'published', '2026-10-31 02:08:05', '2026-10-31 02:08:05'),
(117, 47, 34, 116, 'Bản mã nguồn mở chạy trên Linux cũng rất ổn.', 'published', '2026-10-31 11:55:05', '2026-10-31 11:55:05'),
(118, 48, 38, NULL, 'Rủ cả nhóm chơi miễn phí, sống được tới ngày 12 thì toang.', 'published', '2026-11-02 03:31:05', '2026-11-02 03:31:05'),
(119, 49, 24, NULL, 'Miễn phí mà nội dung nhiều, máy yếu chạy vẫn mượt.', 'published', '2026-11-01 13:08:05', '2026-11-01 13:08:05'),
(120, 50, 36, NULL, 'Đào đất làm hào chặn xe tăng là tính năng mình thích nhất.', 'published', '2026-11-01 08:01:05', '2026-11-01 08:01:05'),
(121, 51, 38, NULL, 'Game LAN huyền thoại của phòng máy trường mình.', 'published', '2026-11-02 04:45:05', '2026-11-02 04:45:05'),
(122, 52, 34, NULL, 'Có sẵn trong kho phần mềm Linux, cài cái là chơi.', 'published', '2026-11-01 03:44:05', '2026-11-01 03:44:05'),
(123, 53, 33, NULL, 'Ngắn thôi nhưng chơi xong cứ lâng lâng.', 'published', '2026-10-30 20:48:05', '2026-10-30 20:48:05'),
(124, 54, 35, NULL, 'Battle royale dễ thương nhất mình từng chơi.', 'published', '2026-11-02 11:18:05', '2026-11-02 11:18:05'),
(125, 78, 172, NULL, 'Ai biết bản này chơi được trên máy cấu hình 8GB RAM không?', 'published', '2026-11-01 13:00:00', '2026-11-01 13:00:00'),
(126, 78, 171, 125, 'Chơi thoải mái bạn ạ, máy mình 8GB vẫn ổn ở mức đồ họa trung bình.', 'published', '2026-11-01 14:00:00', '2026-11-01 14:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `bo_suu_tap`
--

CREATE TABLE `bo_suu_tap` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `nguoi_dung_so_huu_id` bigint(20) UNSIGNED NOT NULL,
  `tieu_de` varchar(180) NOT NULL,
  `duong_dan_rut_gon` varchar(200) NOT NULL,
  `mo_ta` mediumtext DEFAULT NULL,
  `pham_vi_hien_thi` enum('public','unlisted','private') NOT NULL DEFAULT 'public',
  `bo_cuc` enum('grid','list') NOT NULL DEFAULT 'grid',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bo_suu_tap`
--

INSERT INTO `bo_suu_tap` (`ma`, `nguoi_dung_so_huu_id`, `tieu_de`, `duong_dan_rut_gon`, `mo_ta`, `pham_vi_hien_thi`, `bo_cuc`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(3, 17, 'Game đáng học hỏi khi tự làm game', 'game-dang-hoc-hoi-khi-tu-lam-game', 'Những trò chơi có cơ chế rõ ràng, dễ quan sát và có cộng đồng làm mod. Mình hay mở lại để xem cách họ thiết kế vòng lặp chơi.', 'public', 'grid', '2026-09-10 01:27:00', '2026-09-10 01:27:00'),
(4, 18, 'Pixel art đẹp nhất mình từng chơi', 'pixel-art-dep-nhat-minh-tung-choi', 'Danh sách theo cảm nhận cá nhân về đồ họa điểm ảnh.', 'public', 'grid', '2026-09-17 15:17:00', '2026-09-17 15:17:00'),
(5, 19, 'Chơi cùng bạn bè cuối tuần', 'choi-cung-ban-be-cuoi-tuan', 'Những game dễ rủ bạn vào chơi chung, phần lớn miễn phí.', 'public', 'list', '2026-08-31 03:56:00', '2026-08-31 03:56:00'),
(6, 20, 'Chiến thuật thời gian thực', 'chien-thuat-thoi-gian-thuc', 'Quản lý tài nguyên, xây căn cứ và điều quân cùng lúc.', 'public', 'grid', '2026-10-10 02:10:00', '2026-10-10 02:10:00'),
(7, 21, 'Thư giãn sau giờ làm', 'thu-gian-sau-gio-lam', 'Không thua, không vội, chỉ cần ngồi xuống và chơi.', 'public', 'grid', '2026-09-13 03:51:00', '2026-09-13 03:51:00'),
(8, 22, 'Xây dựng và quản lý', 'xay-dung-va-quan-ly', 'Từ tuyến tàu hỏa đến nhà máy và thuộc địa ngoài không gian.', 'public', 'list', '2026-09-07 10:33:00', '2026-09-07 10:33:00'),
(9, 23, 'Phong cách vẽ tay', 'phong-cach-ve-tay', 'Những game có hình ảnh như tranh minh họa.', 'public', 'grid', '2026-08-28 08:46:00', '2026-08-28 08:46:00'),
(10, 24, 'Bắn súng tốc độ cao', 'ban-sung-toc-do-cao', 'Phản xạ nhanh, mỗi trận vài phút.', 'public', 'grid', '2026-10-07 13:05:00', '2026-10-07 13:05:00'),
(11, 25, 'Game có cốt truyện hay', 'game-co-cot-truyen-hay', 'Mình chọn theo tiêu chí: chơi xong vẫn còn nghĩ về câu chuyện.', 'public', 'list', '2026-09-01 01:56:00', '2026-09-01 01:56:00'),
(12, 26, 'Hỗ trợ mod tốt', 'ho-tro-mod-tot', 'Cộng đồng mod lớn, công cụ chính thức hoặc mã nguồn mở.', 'public', 'grid', '2026-09-28 01:08:00', '2026-09-28 01:08:00'),
(13, 27, 'Ấm cúng', 'am-cung', 'Màu sắc dịu, nhạc nhẹ, chơi trước khi ngủ.', 'public', 'grid', '2026-09-17 03:45:00', '2026-09-17 03:45:00'),
(14, 28, 'Theo lượt, suy nghĩ kỹ rồi mới đi', 'theo-luot-suy-nghi-ky-roi-moi-di', 'Chiến thuật theo lượt, từ bản đồ ô lục giác đến bàn cờ 8x8.', 'public', 'list', '2026-09-18 02:55:00', '2026-09-18 02:55:00'),
(15, 29, 'Nhạc nền đáng nghe', 'nhac-nen-dang-nghe', 'Những bản nhạc game mình nghe cả khi không chơi.', 'public', 'grid', '2026-08-30 03:12:00', '2026-08-30 03:12:00'),
(16, 30, 'Tự động hóa', 'tu-dong-hoa', 'Băng chuyền, dây chuyền và tối ưu hóa.', 'public', 'grid', '2026-10-01 06:46:00', '2026-10-01 06:46:00'),
(17, 31, 'Hoài cổ', 'hoai-co', 'Game mã nguồn mở có lịch sử lâu đời, nhiều cái bắt đầu từ thập niên 1990 và 2000.', 'public', 'list', '2026-09-09 08:07:00', '2026-09-09 08:07:00'),
(18, 32, 'Dành cho speedrun', 'danh-cho-speedrun', 'Điều khiển chính xác và có cộng đồng speedrun sôi nổi.', 'public', 'grid', '2026-08-29 12:04:00', '2026-08-29 12:04:00'),
(19, 33, 'Khiến mình rơi nước mắt', 'khien-minh-roi-nuoc-mat', 'Không spoil, chỉ cần biết là nên chuẩn bị khăn giấy.', 'unlisted', 'list', '2026-09-12 08:33:00', '2026-09-12 08:33:00'),
(20, 34, 'Mã nguồn mở, có bản Linux chính thức', 'ma-nguon-mo-co-ban-linux-chinh-thuc', 'Tất cả đều miễn phí và có bản dựng cho Linux từ chính dự án.', 'public', 'list', '2026-08-29 04:34:00', '2026-08-29 04:34:00'),
(21, 35, 'Mỗi lần chơi 15 phút', 'moi-lan-choi-15-phut', 'Dành cho giờ nghỉ trưa.', 'public', 'grid', '2026-10-04 12:55:00', '2026-10-04 12:55:00'),
(22, 36, 'Đế chế và văn minh', 'de-che-va-van-minh', 'Từ thời đồ đá đến kỷ nguyên không gian.', 'public', 'grid', '2026-09-05 05:04:00', '2026-09-05 05:04:00'),
(23, 37, 'Thế giới 3D đơn giản mà cuốn', 'the-gioi-3d-don-gian-ma-cuon', 'Đồ họa ít đa giác nhưng rất có hồn.', 'public', 'grid', '2026-09-24 01:30:00', '2026-09-24 01:30:00'),
(24, 38, 'Danh sách LAN party', 'danh-sach-lan-party', 'Chuẩn bị cho buổi LAN tiếp theo của nhóm.', 'unlisted', 'list', '2026-08-27 01:18:00', '2026-08-27 01:18:00'),
(25, 39, 'Roguelike tuyển chọn', 'roguelike-tuyen-chon', 'Mỗi lần chơi một khác, thua cũng thấy vui.', 'public', 'grid', '2026-10-05 15:02:00', '2026-10-05 15:02:00'),
(26, 40, 'Boss khó nhớ đời', 'boss-kho-nho-doi', 'Những trận đấu trùm làm mình phải thử lại hàng chục lần.', 'public', 'grid', '2026-10-03 03:03:00', '2026-10-03 03:03:00'),
(27, 41, 'Giải đố', 'giai-do', 'Câu đố logic, suy luận và khám phá.', 'public', 'list', '2026-10-12 11:10:00', '2026-10-12 11:10:00'),
(28, 42, 'Miễn phí mà chất lượng', 'mien-phi-ma-chat-luong', 'Không tốn đồng nào vẫn chơi được hàng trăm giờ.', 'public', 'grid', '2026-09-12 07:20:00', '2026-09-12 07:20:00'),
(29, 43, 'Muốn chơi', 'muon-choi', 'Danh sách riêng của mình.', 'private', 'list', '2026-09-24 13:42:00', '2026-09-24 13:42:00'),
(30, 44, 'Sinh tồn', 'sinh-ton', 'Đói, lạnh, đêm tối và quái vật.', 'public', 'grid', '2026-08-28 15:16:00', '2026-08-28 15:16:00'),
(31, 45, 'Biển cả và hòn đảo', 'bien-ca-va-hon-dao', 'Những game có biển, thuyền hoặc một hòn đảo để khám phá.', 'public', 'grid', '2026-10-12 12:24:00', '2026-10-12 12:24:00'),
(32, 46, 'Không khí u tối', 'khong-khi-u-toi', 'Chơi vào đêm khuya, tắt đèn càng tốt.', 'public', 'list', '2026-09-19 13:04:00', '2026-09-19 13:04:00'),
(33, 47, 'Ngoài không gian', 'ngoai-khong-gian', 'Phi thuyền, hành tinh và những chuyến đi xa.', 'public', 'grid', '2026-10-01 07:14:00', '2026-10-01 07:14:00');

-- --------------------------------------------------------

--
-- Table structure for table `cai_dat_nguoi_dung`
--

CREATE TABLE `cai_dat_nguoi_dung` (
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `pham_vi_hien_thi_ho_so` enum('public','private') NOT NULL DEFAULT 'public',
  `hien_thi_game_so_huu` tinyint(1) NOT NULL DEFAULT 1,
  `cho_phep_nhan_tin` tinyint(1) NOT NULL DEFAULT 1,
  `email_cap_nhat_san_pham` tinyint(1) NOT NULL DEFAULT 1,
  `email_cap_nhat_cong_dong` tinyint(1) NOT NULL DEFAULT 1,
  `ngon_ngu_uu_tien` varchar(10) NOT NULL DEFAULT 'vi',
  `tien_te_uu_tien` char(3) NOT NULL DEFAULT 'VND',
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cai_dat_nguoi_dung`
--

INSERT INTO `cai_dat_nguoi_dung` (`nguoi_dung_id`, `pham_vi_hien_thi_ho_so`, `hien_thi_game_so_huu`, `cho_phep_nhan_tin`, `email_cap_nhat_san_pham`, `email_cap_nhat_cong_dong`, `ngon_ngu_uu_tien`, `tien_te_uu_tien`, `ngay_cap_nhat`) VALUES
(5, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 07:45:31'),
(6, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 08:14:08'),
(7, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 08:14:08'),
(8, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 08:14:08'),
(9, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 08:23:04'),
(10, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 08:23:04'),
(11, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 08:23:04'),
(12, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 08:23:05'),
(13, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 08:23:05'),
(14, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 08:23:05'),
(15, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 08:23:05'),
(16, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 08:23:05'),
(17, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:48'),
(18, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:48'),
(19, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:48'),
(20, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:49'),
(21, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:49'),
(22, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:49'),
(23, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:49'),
(24, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:49'),
(25, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:49'),
(26, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:49'),
(27, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:49'),
(28, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:50'),
(29, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:50'),
(30, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:50'),
(31, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:50'),
(32, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:50'),
(33, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:50'),
(34, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:50'),
(35, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:50'),
(36, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:51'),
(37, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:51'),
(38, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:51'),
(39, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:51'),
(40, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:51'),
(41, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:51'),
(42, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:51'),
(43, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:51'),
(44, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:51'),
(45, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:52'),
(46, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:52'),
(47, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:52'),
(48, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:52'),
(49, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:52'),
(50, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:52'),
(51, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:52'),
(52, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-03 13:56:53'),
(53, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:17:29'),
(54, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:17:30'),
(55, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:17:30'),
(56, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:17:30'),
(57, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:17:30'),
(58, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:17:30'),
(59, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:17:30'),
(60, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:17:30'),
(61, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:17:30'),
(62, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:17:30'),
(63, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:05'),
(64, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:05'),
(65, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:05'),
(66, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:06'),
(67, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:06'),
(68, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:06'),
(69, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:06'),
(70, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:06'),
(71, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:06'),
(72, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:06'),
(73, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:06'),
(74, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:06'),
(75, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:06'),
(76, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:06'),
(77, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:06'),
(78, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:06'),
(79, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:06'),
(80, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:06'),
(81, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:07'),
(82, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:07'),
(83, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:07'),
(84, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:07'),
(85, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:07'),
(86, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:07'),
(87, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:07'),
(88, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:07'),
(89, 'public', 1, 1, 1, 1, 'vi', 'USD', '2026-11-04 01:50:07');

-- --------------------------------------------------------

--
-- Table structure for table `cai_dat_trang_tro_choi`
--

CREATE TABLE `cai_dat_trang_tro_choi` (
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `mau_nen` varchar(20) DEFAULT NULL,
  `mau_chu` varchar(20) DEFAULT NULL,
  `mau_lien_ket` varchar(20) DEFAULT NULL,
  `bo_cuc_trang` enum('default','wide','minimal') NOT NULL DEFAULT 'default',
  `bat_cong_dong` tinyint(1) NOT NULL DEFAULT 1,
  `hien_thi_nha_sang_tao` tinyint(1) NOT NULL DEFAULT 1,
  `css_tuy_chinh` mediumtext DEFAULT NULL,
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cai_dat_trang_tro_choi`
--

INSERT INTO `cai_dat_trang_tro_choi` (`tro_choi_id`, `mau_nen`, `mau_chu`, `mau_lien_ket`, `bo_cuc_trang`, `bat_cong_dong`, `hien_thi_nha_sang_tao`, `css_tuy_chinh`, `ngay_cap_nhat`) VALUES
(15, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(16, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(17, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(18, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(19, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(20, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(21, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(22, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(23, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(24, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(25, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(26, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(27, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(28, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(29, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(30, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(31, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(32, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(33, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(34, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(35, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(36, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(37, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(38, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(39, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(40, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(41, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(42, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(43, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42'),
(44, NULL, NULL, NULL, 'default', 1, 1, NULL, '2026-11-04 02:27:42');

-- --------------------------------------------------------

--
-- Table structure for table `chien_dich_giam_gia`
--

CREATE TABLE `chien_dich_giam_gia` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `nguoi_tao_id` bigint(20) UNSIGNED NOT NULL,
  `tieu_de` varchar(200) NOT NULL,
  `mo_ta` mediumtext DEFAULT NULL,
  `phan_tram_giam_gia` decimal(5,2) NOT NULL,
  `trang_thai` enum('draft','scheduled','active','ended','cancelled') NOT NULL DEFAULT 'draft',
  `ngay_bat_dau` datetime NOT NULL,
  `ngay_ket_thuc` datetime NOT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `chien_dich_giam_gia`
--

INSERT INTO `chien_dich_giam_gia` (`ma`, `nguoi_tao_id`, `tieu_de`, `mo_ta`, `phan_tram_giam_gia`, `trang_thai`, `ngay_bat_dau`, `ngay_ket_thuc`, `ngay_tao`) VALUES
(2, 6, 'Khuyến mãi mùa xuân 2025', 'Giảm giá đầu xuân cho các tựa indie nổi bật.', 30.00, 'ended', '2025-03-20 00:00:00', '2025-04-03 23:59:00', '2025-03-09 17:00:00'),
(3, 6, 'Lễ hội roguelike 2025', 'Một tuần dành cho thể loại roguelike và roguelite.', 40.00, 'ended', '2025-05-05 00:00:00', '2025-05-12 23:59:00', '2025-04-24 17:00:00'),
(4, 6, 'Hè rực rỡ 2025', 'Ưu đãi mùa hè cho các game dưới 10 USD.', 50.00, 'ended', '2025-06-26 00:00:00', '2025-07-10 23:59:00', '2025-06-15 17:00:00'),
(5, 6, 'Tuần lễ chiến thuật 2025', 'Chiến thuật theo lượt và mô phỏng.', 35.00, 'ended', '2025-08-11 00:00:00', '2025-08-18 23:59:00', '2025-07-31 17:00:00'),
(6, 6, 'Kể chuyện bằng game 2025', 'Những trò chơi đặt câu chuyện lên hàng đầu.', 40.00, 'ended', '2025-09-15 00:00:00', '2025-09-22 23:59:00', '2025-09-04 17:00:00'),
(7, 6, 'Tuần lễ Klei 2025', 'Ưu đãi cho hai tựa sinh tồn của Klei Entertainment.', 50.00, 'ended', '2025-10-06 00:00:00', '2025-10-13 23:59:00', '2025-09-25 17:00:00'),
(8, 6, 'Halloween 2025', 'Không khí u tối và bí ẩn cho mùa Halloween.', 40.00, 'ended', '2025-10-27 00:00:00', '2025-11-03 23:59:00', '2025-10-16 17:00:00'),
(9, 6, 'Black Friday 2025', 'Đợt giảm giá lớn nhất cuối năm 2025.', 50.00, 'ended', '2025-11-28 00:00:00', '2025-12-02 23:59:00', '2025-11-17 17:00:00'),
(10, 6, 'Giáng sinh 2025', 'Quà Giáng sinh cho người chơi.', 45.00, 'ended', '2025-12-19 00:00:00', '2026-01-02 23:59:00', '2025-12-08 17:00:00'),
(11, 6, 'Tuần lễ Subset và Lucas Pope', 'Bốn tựa game của hai studio nhỏ.', 40.00, 'ended', '2026-01-12 00:00:00', '2026-01-19 23:59:00', '2026-01-01 17:00:00'),
(12, 6, 'Tết Bính Ngọ 2026', 'Ưu đãi dịp Tết Nguyên đán 2026.', 40.00, 'ended', '2026-02-10 00:00:00', '2026-02-24 23:59:00', '2026-01-30 17:00:00'),
(13, 6, 'Tuần lễ giải đố 2026', 'Câu đố, suy luận và khám phá.', 30.00, 'ended', '2026-03-09 00:00:00', '2026-03-16 23:59:00', '2026-02-26 17:00:00'),
(14, 6, 'Mừng sinh nhật nền tảng', 'Một năm hoạt động của nền tảng.', 25.00, 'ended', '2026-04-01 00:00:00', '2026-04-07 23:59:00', '2026-03-21 17:00:00'),
(15, 6, 'Lễ 30/4 và 1/5', 'Ưu đãi kỳ nghỉ lễ.', 30.00, 'ended', '2026-04-28 00:00:00', '2026-05-04 23:59:00', '2026-04-17 17:00:00'),
(16, 6, 'Tuần lễ nhạc game', 'Những trò chơi có nhạc nền được yêu thích.', 35.00, 'ended', '2026-05-18 00:00:00', '2026-05-25 23:59:00', '2026-05-07 17:00:00'),
(17, 6, 'Ngày hội platformer', 'Nhảy, lướt và né đòn.', 35.00, 'ended', '2026-06-08 00:00:00', '2026-06-15 23:59:00', '2026-05-28 17:00:00'),
(18, 6, 'Hè 2026, đợt 1', 'Đợt đầu của chương trình hè.', 50.00, 'ended', '2026-06-25 00:00:00', '2026-07-09 23:59:00', '2026-06-14 17:00:00'),
(19, 6, 'Hè 2026, đợt 2', 'Đợt hai của chương trình hè.', 40.00, 'ended', '2026-07-10 00:00:00', '2026-07-24 23:59:00', '2026-06-29 17:00:00'),
(20, 6, 'Cuối tuần tự động hóa', 'Ba ngày cho người mê dây chuyền sản xuất.', 20.00, 'ended', '2026-07-31 00:00:00', '2026-08-03 23:59:00', '2026-07-20 17:00:00'),
(21, 6, 'Tựu trường 2026', 'Chuẩn bị năm học mới.', 30.00, 'ended', '2026-08-03 00:00:00', '2026-08-17 23:59:00', '2026-07-23 17:00:00'),
(22, 6, 'Mùa đông ấm áp', 'Đã hủy vì trùng lịch với chương trình Tết.', 30.00, 'cancelled', '2026-01-26 00:00:00', '2026-02-02 23:59:00', '2026-01-15 17:00:00'),
(23, 6, 'Khám phá không gian', 'Đã hủy, gộp vào chương trình hè.', 35.00, 'cancelled', '2025-07-21 00:00:00', '2025-07-28 23:59:00', '2025-07-10 17:00:00'),
(24, 6, 'Tuần lễ indie tháng 11', 'Ưu đãi cho ba tựa roguelike thẻ bài và hành động.', 25.00, 'active', '2026-11-04 00:00:00', '2026-11-11 23:59:00', '2026-10-24 17:00:00'),
(25, 6, 'Ưu đãi game thư giãn', 'Nhẹ nhàng, ấm áp, không áp lực.', 20.00, 'active', '2026-11-04 00:00:00', '2026-11-11 23:59:00', '2026-10-24 17:00:00'),
(26, 6, 'Tuần lễ hành động', 'Phản xạ nhanh và nhịp độ cao.', 30.00, 'active', '2026-11-04 00:00:00', '2026-11-11 23:59:00', '2026-10-24 17:00:00'),
(27, 6, 'Black Friday 2026', 'Đợt giảm giá lớn cuối tháng 11.', 50.00, 'scheduled', '2026-11-27 00:00:00', '2026-12-01 23:59:00', '2026-11-03 02:27:45'),
(28, 6, 'Giáng sinh 2026', 'Ưu đãi mùa lễ cuối năm.', 40.00, 'scheduled', '2026-12-18 00:00:00', '2027-01-02 23:59:00', '2026-11-03 02:27:45'),
(29, 6, 'Tết Đinh Mùi 2027', 'Ưu đãi dịp Tết Nguyên đán 2027.', 35.00, 'scheduled', '2027-02-01 00:00:00', '2027-02-14 23:59:00', '2026-11-03 02:27:45'),
(30, 6, 'Tuần lễ metroidvania', 'Bản nháp, chưa chốt danh sách.', 20.00, 'draft', '2027-03-01 00:00:00', '2027-03-08 23:59:00', '2026-11-03 02:27:45'),
(31, 6, 'Ưu đãi game giải đố', 'Bản nháp.', 25.00, 'draft', '2027-03-15 00:00:00', '2027-03-22 23:59:00', '2026-11-03 02:27:45');

-- --------------------------------------------------------

--
-- Table structure for table `chi_tiet_chi_tra`
--

CREATE TABLE `chi_tiet_chi_tra` (
  `dot_chi_tra_id` bigint(20) UNSIGNED NOT NULL,
  `so_ke_toan_id` bigint(20) UNSIGNED NOT NULL,
  `so_tien` decimal(12,2) NOT NULL
) ;

--
-- Dumping data for table `chi_tiet_chi_tra`
--

INSERT INTO `chi_tiet_chi_tra` (`dot_chi_tra_id`, `so_ke_toan_id`, `so_tien`) VALUES
(4, 28, 13.49),
(5, 26, 13.49),
(6, 19, 15.29),
(7, 25, 22.49),
(7, 31, 22.49),
(8, 15, 22.49),
(9, 13, 22.49),
(9, 39, 22.49),
(10, 10, 8.99),
(11, 7, 6.10),
(11, 40, 6.11),
(12, 29, 4.49),
(13, 16, 16.19),
(13, 22, 17.99),
(14, 14, 17.99),
(14, 20, 15.29),
(15, 41, 11.87),
(16, 33, 22.49),
(17, 12, 13.49),
(17, 17, 8.27),
(18, 35, 8.99),
(18, 37, 8.27),
(19, 21, 13.49),
(19, 38, 13.49),
(20, 27, 17.99),
(21, 36, 7.91),
(22, 34, 27.00),
(23, 23, 12.14),
(23, 32, 13.49),
(24, 24, 17.99),
(25, 11, 26.99),
(26, 18, 11.47),
(26, 30, 12.14),
(27, 8, 19.08),
(27, 9, 22.49),
(28, 42, 23.75),
(29, 44, 10.12),
(29, 47, 10.12),
(30, 55, 12.41),
(30, 61, 11.24),
(30, 89, 8.10),
(31, 58, 16.19),
(31, 90, 10.80),
(32, 25, 22.49),
(32, 31, 22.49),
(32, 52, 22.49),
(32, 78, 12.42),
(33, 57, 22.49),
(33, 79, 12.42),
(34, 50, 16.87),
(34, 80, 12.42),
(35, 63, 8.99),
(35, 65, 8.99),
(36, 54, 4.13),
(36, 70, 4.49),
(37, 68, 8.99),
(37, 75, 8.99),
(37, 84, 21.59),
(38, 43, 13.49),
(38, 48, 13.49),
(39, 41, 11.87),
(39, 53, 13.49),
(39, 82, 7.44),
(40, 76, 15.74),
(41, 46, 8.99),
(41, 73, 13.49),
(41, 83, 17.99),
(41, 93, 5.39),
(42, 67, 15.74),
(42, 72, 22.49),
(43, 74, 13.49),
(44, 59, 22.49),
(44, 69, 22.49),
(44, 92, 13.50),
(45, 62, 17.99),
(46, 45, 31.49),
(46, 56, 31.49),
(47, 60, 11.24),
(47, 64, 13.49),
(47, 81, 7.45),
(48, 71, 8.99),
(48, 85, 5.82),
(48, 91, 5.40),
(49, 66, 22.05),
(50, 49, 13.49),
(50, 86, 11.65),
(51, 51, 22.94),
(52, 87, 14.55),
(53, 77, 26.99),
(53, 88, 17.47);

-- --------------------------------------------------------

--
-- Table structure for table `chi_tiet_don_hang`
--

CREATE TABLE `chi_tiet_don_hang` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `don_hang_id` bigint(20) UNSIGNED NOT NULL,
  `loai_muc` enum('game','bundle') NOT NULL,
  `tro_choi_id` bigint(20) UNSIGNED DEFAULT NULL,
  `goi_game_id` bigint(20) UNSIGNED DEFAULT NULL,
  `nguoi_nhan_qua_id` bigint(20) UNSIGNED DEFAULT NULL,
  `trang_thai_qua` enum('not_gift','pending','claimed','cancelled') NOT NULL DEFAULT 'not_gift',
  `tieu_de_luc_mua` varchar(220) NOT NULL,
  `so_luong` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `don_gia` decimal(12,2) NOT NULL,
  `so_tien_giam` decimal(12,2) NOT NULL DEFAULT 0.00,
  `tien_thue` decimal(12,2) NOT NULL DEFAULT 0.00,
  `thanh_tien_dong` decimal(12,2) NOT NULL,
  `ma_tien_te` char(3) NOT NULL
) ;

--
-- Dumping data for table `chi_tiet_don_hang`
--

INSERT INTO `chi_tiet_don_hang` (`ma`, `don_hang_id`, `loai_muc`, `tro_choi_id`, `goi_game_id`, `nguoi_nhan_qua_id`, `trang_thai_qua`, `tieu_de_luc_mua`, `so_luong`, `don_gia`, `so_tien_giam`, `tien_thue`, `thanh_tien_dong`, `ma_tien_te`) VALUES
(4, 4, 'game', 16, NULL, NULL, 'not_gift', 'Hollow Knight', 1, 14.99, 0.00, 0.00, 14.99, 'USD'),
(5, 5, 'game', 22, NULL, NULL, 'not_gift', 'A Short Hike', 1, 7.99, 1.21, 0.00, 6.78, 'USD'),
(6, 5, 'game', 45, NULL, NULL, 'not_gift', 'Outer Wilds', 1, 24.99, 3.79, 0.00, 21.20, 'USD'),
(7, 6, 'game', 45, NULL, NULL, 'not_gift', 'Outer Wilds', 1, 24.99, 0.00, 0.00, 24.99, 'USD'),
(8, 6, 'game', 21, NULL, NULL, 'not_gift', 'Terraria', 1, 9.99, 0.00, 0.00, 9.99, 'USD'),
(9, 7, 'game', 41, NULL, NULL, 'not_gift', 'TUNIC', 1, 29.99, 0.00, 0.00, 29.99, 'USD'),
(10, 8, 'game', 42, NULL, NULL, 'not_gift', 'Into the Breach', 1, 14.99, 0.00, 0.00, 14.99, 'USD'),
(11, 8, 'game', 20, NULL, NULL, 'not_gift', 'Slay the Spire', 1, 24.99, 0.00, 0.00, 24.99, 'USD'),
(12, 8, 'game', 25, NULL, NULL, 'not_gift', 'Inscryption', 1, 19.99, 0.00, 0.00, 19.99, 'USD'),
(13, 9, 'game', 19, NULL, NULL, 'not_gift', 'Dead Cells', 1, 24.99, 0.00, 0.00, 24.99, 'USD'),
(14, 10, 'game', 43, NULL, NULL, 'not_gift', 'Return of the Obra Dinn', 1, 19.99, 2.00, 0.00, 17.99, 'USD'),
(15, 11, 'game', 29, NULL, NULL, 'not_gift', 'FTL: Faster Than Light', 1, 9.99, 0.80, 0.00, 9.19, 'USD'),
(16, 12, 'game', 44, NULL, NULL, 'not_gift', 'Baba Is You', 1, 14.99, 2.25, 0.00, 12.74, 'USD'),
(17, 12, 'game', 17, NULL, NULL, 'not_gift', 'Celeste', 1, 19.99, 3.00, 0.00, 16.99, 'USD'),
(18, 12, 'game', 25, NULL, NULL, 'not_gift', 'Inscryption', 1, 19.99, 3.00, 0.00, 16.99, 'USD'),
(19, 13, 'game', 31, NULL, NULL, 'not_gift', 'Balatro', 1, 14.99, 0.00, 0.00, 14.99, 'USD'),
(20, 14, 'game', 43, NULL, NULL, 'not_gift', 'Return of the Obra Dinn', 1, 19.99, 0.00, 0.00, 19.99, 'USD'),
(21, 15, 'game', 39, NULL, NULL, 'not_gift', 'Katana ZERO', 1, 14.99, 1.50, 0.00, 13.49, 'USD'),
(22, 16, 'game', 40, NULL, NULL, 'not_gift', 'Night in the Woods', 1, 19.99, 0.00, 0.00, 19.99, 'USD'),
(23, 17, 'game', 18, NULL, NULL, 'not_gift', 'Hades', 1, 24.99, 0.00, 0.00, 24.99, 'USD'),
(24, 18, 'game', 16, NULL, NULL, 'not_gift', 'Hollow Knight', 1, 14.99, 0.00, 0.00, 14.99, 'USD'),
(25, 19, 'game', 33, NULL, NULL, 'not_gift', 'Cuphead', 1, 19.99, 0.00, 0.00, 19.99, 'USD'),
(26, 19, 'game', 15, NULL, NULL, 'not_gift', 'Stardew Valley', 1, 14.99, 0.00, 0.00, 14.99, 'USD'),
(27, 19, 'game', 23, NULL, NULL, 'not_gift', 'Vampire Survivors', 1, 4.99, 0.00, 0.00, 4.99, 'USD'),
(28, 20, 'game', 44, NULL, NULL, 'not_gift', 'Baba Is You', 1, 14.99, 1.50, 0.00, 13.49, 'USD'),
(29, 21, 'game', 18, NULL, NULL, 'not_gift', 'Hades', 1, 24.99, 0.00, 0.00, 24.99, 'USD'),
(30, 21, 'game', 39, NULL, NULL, 'not_gift', 'Katana ZERO', 1, 14.99, 0.00, 0.00, 14.99, 'USD'),
(31, 22, 'game', 28, NULL, NULL, 'not_gift', 'DREDGE', 1, 24.99, 0.00, 0.00, 24.99, 'USD'),
(32, 23, 'game', 37, NULL, NULL, 'not_gift', 'Factorio', 1, 35.00, 5.00, 0.00, 30.00, 'USD'),
(33, 24, 'game', 30, NULL, NULL, 'not_gift', 'Don\'t Starve', 1, 9.99, 0.00, 0.00, 9.99, 'USD'),
(34, 25, 'game', 36, NULL, NULL, 'not_gift', 'UNDERTALE', 1, 9.99, 1.20, 0.00, 8.79, 'USD'),
(35, 26, 'game', 30, NULL, NULL, 'not_gift', 'Don\'t Starve', 1, 9.99, 0.80, 0.00, 9.19, 'USD'),
(36, 27, 'game', 31, NULL, NULL, 'not_gift', 'Balatro', 1, 14.99, 0.00, 0.00, 14.99, 'USD'),
(37, 27, 'game', 20, NULL, NULL, 'not_gift', 'Slay the Spire', 1, 24.99, 0.00, 0.00, 24.99, 'USD'),
(38, 28, 'game', 22, NULL, NULL, 'not_gift', 'A Short Hike', 1, 7.99, 1.20, 0.00, 6.79, 'USD'),
(39, 29, 'game', 27, NULL, NULL, 'not_gift', 'Loop Hero', 1, 14.99, 1.80, 0.00, 13.19, 'USD'),
(40, 29, 'game', 46, NULL, NULL, 'not_gift', 'Spiritfarer: Farewell Edition', 1, 29.99, 3.60, 0.00, 26.39, 'USD'),
(41, 30, 'game', 26, NULL, NULL, 'not_gift', 'Unpacking', 1, 19.99, 5.00, 0.00, 14.99, 'USD'),
(42, 30, 'game', 15, NULL, NULL, 'not_gift', 'Stardew Valley', 1, 14.99, 3.75, 0.00, 11.24, 'USD'),
(43, 31, 'game', 34, NULL, NULL, 'not_gift', 'RimWorld', 1, 34.99, 0.00, 0.00, 34.99, 'USD'),
(44, 32, 'game', 29, NULL, NULL, 'not_gift', 'FTL: Faster Than Light', 1, 9.99, 0.00, 0.00, 9.99, 'USD'),
(45, 33, 'game', 15, NULL, NULL, 'not_gift', 'Stardew Valley', 1, 14.99, 3.75, 0.00, 11.24, 'USD'),
(46, 33, 'game', 26, NULL, NULL, 'not_gift', 'Unpacking', 1, 19.99, 5.00, 0.00, 14.99, 'USD'),
(47, 34, 'game', 40, NULL, NULL, 'not_gift', 'Night in the Woods', 1, 19.99, 5.00, 0.00, 14.99, 'USD'),
(48, 34, 'game', 20, NULL, NULL, 'not_gift', 'Slay the Spire', 1, 24.99, 6.25, 0.00, 18.74, 'USD'),
(49, 35, 'game', 41, NULL, NULL, 'not_gift', 'TUNIC', 1, 29.99, 4.50, 0.00, 25.49, 'USD'),
(50, 36, 'game', 18, NULL, NULL, 'not_gift', 'Hades', 1, 24.99, 0.00, 0.00, 24.99, 'USD'),
(51, 36, 'game', 27, NULL, NULL, 'not_gift', 'Loop Hero', 1, 14.99, 0.00, 0.00, 14.99, 'USD'),
(52, 37, 'game', 23, NULL, NULL, 'not_gift', 'Vampire Survivors', 1, 4.99, 0.40, 0.00, 4.59, 'USD'),
(53, 37, 'game', 16, NULL, NULL, 'not_gift', 'Hollow Knight', 1, 14.99, 1.20, 0.00, 13.79, 'USD'),
(54, 38, 'game', 34, NULL, NULL, 'not_gift', 'RimWorld', 1, 34.99, 0.00, 0.00, 34.99, 'USD'),
(55, 38, 'game', 19, NULL, NULL, 'not_gift', 'Dead Cells', 1, 24.99, 0.00, 0.00, 24.99, 'USD'),
(56, 39, 'game', 17, NULL, NULL, 'not_gift', 'Celeste', 1, 19.99, 2.00, 0.00, 17.99, 'USD'),
(57, 40, 'game', 32, NULL, NULL, 'not_gift', 'Darkest Dungeon', 1, 24.99, 0.00, 0.00, 24.99, 'USD'),
(58, 41, 'game', 35, NULL, NULL, 'not_gift', 'Enter the Gungeon', 1, 14.99, 2.50, 0.00, 12.49, 'USD'),
(59, 41, 'game', 16, NULL, NULL, 'not_gift', 'Hollow Knight', 1, 14.99, 2.50, 0.00, 12.49, 'USD'),
(60, 42, 'game', 33, NULL, NULL, 'not_gift', 'Cuphead', 1, 19.99, 0.00, 0.00, 19.99, 'USD'),
(61, 42, 'game', 21, NULL, NULL, 'not_gift', 'Terraria', 1, 9.99, 0.00, 0.00, 9.99, 'USD'),
(62, 43, 'game', 35, NULL, NULL, 'not_gift', 'Enter the Gungeon', 1, 14.99, 0.00, 0.00, 14.99, 'USD'),
(63, 43, 'game', 21, NULL, NULL, 'not_gift', 'Terraria', 1, 9.99, 0.00, 0.00, 9.99, 'USD'),
(64, 44, 'game', 37, NULL, NULL, 'not_gift', 'Factorio', 1, 35.00, 10.50, 0.00, 24.50, 'USD'),
(65, 44, 'game', 38, NULL, NULL, 'not_gift', 'Oxygen Not Included', 1, 24.99, 7.50, 0.00, 17.49, 'USD'),
(66, 45, 'game', 24, NULL, NULL, 'not_gift', 'Papers, Please', 1, 9.99, 0.00, 0.00, 9.99, 'USD'),
(67, 45, 'game', 32, NULL, NULL, 'not_gift', 'Darkest Dungeon', 1, 24.99, 0.00, 0.00, 24.99, 'USD'),
(68, 46, 'game', 23, NULL, NULL, 'not_gift', 'Vampire Survivors', 1, 4.99, 0.00, 0.00, 4.99, 'USD'),
(69, 47, 'game', 36, NULL, NULL, 'not_gift', 'UNDERTALE', 1, 9.99, 0.00, 0.00, 9.99, 'USD'),
(70, 48, 'game', 38, NULL, NULL, 'not_gift', 'Oxygen Not Included', 1, 24.99, 0.00, 0.00, 24.99, 'USD'),
(71, 49, 'game', 42, NULL, NULL, 'not_gift', 'Into the Breach', 1, 14.99, 0.00, 0.00, 14.99, 'USD'),
(72, 50, 'game', 31, NULL, NULL, 'not_gift', 'Balatro', 1, 14.99, 0.00, 0.00, 14.99, 'USD'),
(73, 51, 'game', 24, NULL, NULL, 'not_gift', 'Papers, Please', 1, 9.99, 0.00, 0.00, 9.99, 'USD'),
(74, 52, 'game', 28, NULL, NULL, 'not_gift', 'DREDGE', 1, 24.99, 7.50, 0.00, 17.49, 'USD'),
(75, 53, 'game', 46, NULL, NULL, 'not_gift', 'Spiritfarer: Farewell Edition', 1, 29.99, 0.00, 0.00, 29.99, 'USD'),
(76, 54, 'bundle', NULL, 4, NULL, 'not_gift', 'Roguelike tuyển chọn', 1, 62.99, 5.04, 0.00, 57.95, 'USD'),
(77, 55, 'bundle', NULL, 8, NULL, 'not_gift', 'Trọn bộ Subset Games', 1, 19.99, 0.00, 0.00, 19.99, 'USD'),
(78, 56, 'bundle', NULL, 9, NULL, 'not_gift', 'Trọn bộ Lucas Pope', 1, 23.99, 0.00, 0.00, 23.99, 'USD'),
(79, 57, 'bundle', NULL, 13, NULL, 'not_gift', 'Câu chuyện đáng nhớ', 1, 54.99, 0.00, 0.00, 54.99, 'USD'),
(80, 58, 'bundle', NULL, 26, NULL, 'not_gift', 'Indie thập niên 2010', 1, 47.99, 0.00, 0.00, 47.99, 'USD'),
(81, 59, 'game', 24, NULL, NULL, 'not_gift', 'Papers, Please', 1, 9.99, 0.00, 0.00, 9.99, 'USD'),
(82, 60, 'game', 46, NULL, NULL, 'not_gift', 'Spiritfarer: Farewell Edition', 1, 29.99, 0.00, 0.00, 29.99, 'USD'),
(83, 61, 'game', 43, NULL, NULL, 'not_gift', 'Return of the Obra Dinn', 1, 19.99, 0.00, 0.00, 19.99, 'USD'),
(84, 62, 'game', 21, NULL, NULL, 'not_gift', 'Terraria', 1, 9.99, 1.20, 0.00, 8.79, 'USD'),
(85, 63, 'game', 30, NULL, NULL, 'not_gift', 'Don\'t Starve', 1, 9.99, 0.00, 0.00, 9.99, 'USD'),
(86, 64, 'game', 32, NULL, NULL, 'not_gift', 'Darkest Dungeon', 1, 24.99, 3.75, 0.00, 21.24, 'USD'),
(87, 65, 'game', 36, NULL, NULL, 'not_gift', 'UNDERTALE', 1, 9.99, 0.00, 0.00, 9.99, 'USD'),
(88, 66, 'game', 29, NULL, NULL, 'not_gift', 'FTL: Faster Than Light', 1, 9.99, 0.00, 0.00, 9.99, 'USD'),
(89, 67, 'game', 34, NULL, NULL, 'not_gift', 'RimWorld', 1, 34.99, 3.00, 0.00, 31.99, 'USD'),
(90, 68, 'game', 40, NULL, NULL, 'not_gift', 'Night in the Woods', 1, 19.99, 3.00, 0.00, 16.99, 'USD'),
(91, 69, 'game', 19, NULL, NULL, 'not_gift', 'Dead Cells', 1, 24.99, 0.00, 0.00, 24.99, 'USD'),
(92, 70, 'game', 37, NULL, NULL, 'not_gift', 'Factorio', 1, 35.00, 0.00, 0.00, 35.00, 'USD'),
(93, 71, 'game', 15, NULL, NULL, 'not_gift', 'Stardew Valley', 1, 14.99, 0.00, 0.00, 14.99, 'USD'),
(94, 72, 'game', 44, NULL, NULL, 'not_gift', 'Baba Is You', 1, 14.99, 1.50, 0.00, 13.49, 'USD'),
(95, 73, 'game', 24, NULL, NULL, 'not_gift', 'Papers, Please', 1, 9.99, 2.00, 0.00, 7.99, 'USD'),
(96, 74, 'game', 34, NULL, NULL, 'not_gift', 'RimWorld', 1, 34.99, 0.00, 0.00, 34.99, 'USD'),
(97, 75, 'game', 20, NULL, NULL, 'not_gift', 'Slay the Spire', 1, 24.99, 0.00, 0.00, 24.99, 'USD'),
(98, 76, 'game', 44, NULL, NULL, 'not_gift', 'Baba Is You', 1, 14.99, 0.00, 0.00, 14.99, 'USD'),
(99, 77, 'game', 38, NULL, NULL, 'not_gift', 'Oxygen Not Included', 1, 24.99, 0.00, 0.00, 24.99, 'USD'),
(100, 78, 'game', 27, NULL, NULL, 'not_gift', 'Loop Hero', 1, 14.99, 0.00, 0.00, 14.99, 'USD'),
(101, 79, 'game', 15, NULL, NULL, 'not_gift', 'Stardew Valley', 1, 14.99, 1.20, 0.00, 13.79, 'USD'),
(102, 80, 'game', 18, NULL, NULL, 'not_gift', 'Hades', 1, 24.99, 0.00, 0.00, 24.99, 'USD'),
(103, 81, 'game', 43, NULL, NULL, 'not_gift', 'Return of the Obra Dinn', 1, 19.99, 3.00, 0.00, 16.99, 'USD'),
(104, 82, 'game', 27, NULL, NULL, 'not_gift', 'Loop Hero', 1, 14.99, 2.25, 0.00, 12.74, 'USD'),
(105, 83, 'game', 15, NULL, NULL, 'not_gift', 'Stardew Valley', 1, 14.99, 0.00, 0.00, 14.99, 'USD'),
(106, 84, 'game', 38, NULL, NULL, 'not_gift', 'Oxygen Not Included', 1, 24.99, 0.00, 0.00, 24.99, 'USD'),
(107, 85, 'game', 34, NULL, NULL, 'not_gift', 'RimWorld', 1, 34.99, 0.00, 0.00, 34.99, 'USD'),
(108, 86, 'game', 32, NULL, NULL, 'not_gift', 'Darkest Dungeon', 1, 24.99, 2.00, 0.00, 22.99, 'USD'),
(109, 87, 'game', 29, NULL, NULL, 'not_gift', 'FTL: Faster Than Light', 1, 9.99, 0.00, 0.00, 9.99, 'USD'),
(110, 88, 'game', 20, NULL, NULL, 'not_gift', 'Slay the Spire', 1, 24.99, 0.00, 0.00, 24.99, 'USD'),
(111, 89, 'game', 37, NULL, NULL, 'not_gift', 'Factorio', 1, 35.00, 0.00, 0.00, 35.00, 'USD'),
(112, 90, 'game', 15, NULL, NULL, 'not_gift', 'Stardew Valley', 1, 14.99, 0.00, 0.00, 14.99, 'USD'),
(113, 91, 'game', 22, NULL, NULL, 'not_gift', 'A Short Hike', 1, 7.99, 0.00, 0.00, 7.99, 'USD'),
(114, 92, 'game', 15, NULL, NULL, 'not_gift', 'Stardew Valley', 1, 14.99, 1.20, 0.00, 13.79, 'USD'),
(115, 93, 'game', 46, NULL, NULL, 'not_gift', 'Spiritfarer: Farewell Edition', 1, 29.99, 0.00, 0.00, 29.99, 'USD'),
(116, 94, 'game', 45, NULL, NULL, 'not_gift', 'Outer Wilds', 1, 24.99, 2.00, 0.00, 22.99, 'USD');

-- --------------------------------------------------------

--
-- Table structure for table `chu_de_thao_luan`
--

CREATE TABLE `chu_de_thao_luan` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `dien_dan_id` bigint(20) UNSIGNED NOT NULL,
  `tac_gia_nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `tieu_de` varchar(220) NOT NULL,
  `noi_dung_mo_dau` mediumtext NOT NULL,
  `trang_thai` enum('published','hidden','removed') NOT NULL DEFAULT 'published',
  `da_ghim` tinyint(1) NOT NULL DEFAULT 0,
  `da_khoa` tinyint(1) NOT NULL DEFAULT 0,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chu_de_thao_luan`
--

INSERT INTO `chu_de_thao_luan` (`ma`, `dien_dan_id`, `tac_gia_nguoi_dung_id`, `tieu_de`, `noi_dung_mo_dau`, `trang_thai`, `da_ghim`, `da_khoa`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(6, 3, 31, 'Bạn bắt đầu chơi game từ máy nào?', 'Mình bắt đầu từ máy điện tử băng cắm ở nhà bà ngoại, sau đó là máy tính ở tiệm net. Còn mọi người?', 'published', 0, 0, '2026-08-10 10:38:26', '2026-08-13 22:50:26'),
(7, 3, 35, 'Gợi ý game nhẹ nhàng để chơi sau giờ làm', 'Mình cần vài game không căng thẳng, chơi 20 đến 30 phút là dừng được. Không cần đồ họa đẹp.', 'published', 0, 0, '2026-08-31 11:00:26', '2026-09-03 19:32:26'),
(8, 3, 38, 'Tổng kết LAN party cuối tuần: SuperTuxKart và Xonotic', 'Cuối tuần rồi nhóm mình 8 người làm LAN ở phòng trọ.\n\nSuperTuxKart chế độ đá bóng vui nhất, cười cả buổi. Xonotic thì hai bạn mới chơi bị hành quá nên chuyển sang Instagib cho công bằng.', 'published', 0, 0, '2026-10-13 09:18:26', '2026-10-17 07:45:26'),
(9, 3, 21, 'Nhạc nền game nào bạn nghe cả khi không chơi?', 'Có những bản nhạc nền mình bật khi làm việc luôn. Mọi người có playlist nhạc game không?', 'published', 0, 0, '2026-09-11 09:31:26', '2026-09-12 19:01:26'),
(10, 4, 7, 'Nội quy diễn đàn - vui lòng đọc trước khi đăng', '1. Tôn trọng người khác, không công kích cá nhân.\n2. Không đăng nội dung vi phạm bản quyền, không chia sẻ bản crack.\n3. Đăng đúng diễn đàn. Lỗi kỹ thuật vào Hỗ trợ kỹ thuật, dự án cá nhân vào Khoe dự án.\n4. Không quảng cáo, không spam liên kết.\n5. Thấy bài vi phạm, hãy dùng nút Báo cáo thay vì tranh cãi.\n\nBài vi phạm có thể bị ẩn và tài khoản có thể bị khóa tạm thời.', 'published', 1, 1, '2026-07-06 08:50:26', '2026-07-06 08:50:26'),
(11, 4, 7, 'Hướng dẫn báo cáo nội dung vi phạm', 'Ở mỗi bài viết, bình luận và đánh giá đều có nút Báo cáo. Chọn lý do và mô tả ngắn gọn. Điều hành viên sẽ xem xét trong hàng đợi kiểm duyệt.', 'published', 1, 0, '2026-07-06 08:49:26', '2026-07-07 17:49:26'),
(12, 5, 35, 'Không giải nén được file .tar.xz trên Windows', 'Mình tải bản Linux của một game về nhầm, file đuôi .tar.xz. Windows không mở được. Có cách nào không ạ?', 'published', 0, 0, '2026-09-02 18:32:26', '2026-09-04 05:57:26'),
(13, 5, 41, 'Xonotic stutters on a laptop with hybrid graphics', 'My laptop has integrated and dedicated graphics. Xonotic runs but stutters a lot. Any ideas?', 'published', 0, 0, '2026-08-25 01:14:26', '2026-08-27 04:39:26'),
(14, 5, 25, 'Nhận game miễn phí xong thì tải ở đâu?', 'Mình bấm nhận một game miễn phí rồi nhưng không biết file tải nằm ở đâu.', 'published', 0, 0, '2026-08-03 08:23:26', '2026-08-06 16:58:26'),
(15, 5, 22, 'OpenTTD báo thiếu bộ đồ họa gốc khi mở lần đầu', 'Mình dùng bản nén để chạy không cần cài, mở lên báo thiếu base graphics. Có ai gặp chưa?', 'published', 0, 0, '2026-09-23 07:37:26', '2026-09-25 03:36:26'),
(16, 5, 34, '[Mẹo] Flatpak hay tự giải nén: chọn cách nào để chạy game trên Linux', 'Một số lời khuyên cho bạn mới dùng Linux:\n\n- Flatpak tiện, cập nhật tự động, chạy được trên nhiều bản phân phối.\n- Bản nén tự giải nén thì gọn, nhưng tự lo cập nhật.\n- Gói trong kho của bản phân phối có thể cũ hơn bản mới nhất.\n\nCâu hỏi gì cứ để lại bên dưới.', 'published', 0, 0, '2026-08-25 22:49:26', '2026-08-28 07:05:26'),
(18, 6, 18, 'Tập vẽ tileset 16x16 mỗi ngày, ngày thứ 30', 'Tháng này mình tự thử thách mỗi ngày vẽ một ô tile. Hôm nay là bộ cỏ và đường đất nối nhau liền mạch. Bảng màu chỉ 16 màu.', 'published', 0, 0, '2026-08-06 05:18:26', '2026-08-08 08:56:26'),
(19, 6, 29, 'Mình sáng tác 5 bản chiptune cho game jam, ai cần thì dùng', 'Năm bản nhạc lặp, mỗi bản khoảng một phút. Mình để giấy phép CC BY 4.0, chỉ cần ghi tên là dùng được trong game của bạn, kể cả game bán.', 'published', 0, 0, '2026-07-27 13:05:26', '2026-07-29 01:39:26'),
(20, 6, 37, 'Xe kart low-poly đầu tiên, đang học Blender', 'Mình dựng một chiếc kart khoảng 800 tam giác, tô màu bằng bảng màu thay vì texture. Mọi người góp ý giúp mình phần bánh xe nhé.', 'published', 0, 0, '2026-10-23 12:21:26', '2026-10-25 15:51:26'),
(21, 6, 48, 'Devlog: my tiny farming roguelike, month 2', 'Month two: crops now grow between runs, and each run is one in-game season. The hardest part was balancing so that farming feels useful but not required.\n\nFeedback welcome!', 'published', 0, 0, '2026-09-02 11:03:26', '2026-09-04 03:22:26'),
(22, 7, 33, 'Biên kịch tìm nhóm làm visual novel ngắn', 'Mình có kịch bản một visual novel khoảng 30 phút đọc, chủ đề gia đình. Cần một bạn vẽ nhân vật và một bạn lập trình. Không có kinh phí, làm vì đam mê và chia đều nếu sau này bán.', 'published', 0, 0, '2026-07-19 00:29:26', '2026-07-21 14:57:26'),
(23, 7, 26, 'Tìm người cùng viết mod nông trại cho Luanti', 'Mod gồm cây trồng theo mùa, chuồng gà và chợ bán nông sản. Viết bằng Lua. Cần thêm một người làm texture 16x16.', 'published', 0, 0, '2026-09-25 10:19:26', '2026-09-26 22:58:26'),
(25, 7, 42, 'Looking for a pixel artist for a two-week jam', 'Next jam starts soon. I handle code and design, looking for an artist. Small scope, one screen puzzle game.', 'published', 0, 0, '2026-10-15 17:11:26', '2026-10-17 09:23:26'),
(27, 8, 43, 'Suggestion: English interface option', 'The site is great but some international users need a translator. An English UI option would help a lot.', 'published', 0, 0, '2026-09-23 20:32:26', '2026-09-25 13:59:26'),
(28, 8, 36, 'Thư viện nên có sắp xếp theo game mới nhận', 'Thư viện của mình bắt đầu nhiều game, nếu sắp xếp được theo ngày nhận hoặc theo tên thì dễ tìm hơn.', 'published', 0, 0, '2026-10-10 05:09:26', '2026-10-12 02:10:26'),
(29, 9, 20, 'Chiến thuật mở đầu với phe Sparta', 'Mình hay mở đầu thế này: dân làng chia đều gỗ và lương thực, lên nhà ở sớm để không bị chặn dân số, sau đó dồn đá cho trụ sở quân.\n\nMọi người mở đầu thế nào?', 'published', 0, 0, '2026-10-04 03:45:26', '2026-10-06 14:38:26'),
(32, 10, 32, 'Chia sẻ thời gian chạy time trial của bạn', 'Topic để mọi người khoe thời gian chạy time trial. Ghi rõ đường đua, kart và độ khó nhé. Mình đang cố cải thiện ở Black Forest.', 'published', 0, 0, '2026-10-20 19:06:26', '2026-10-23 01:34:26'),
(33, 10, 40, 'Favorite add-on karts and tracks?', 'The add-on menu has so many community karts. Which ones do you like?', 'published', 0, 0, '2026-09-05 02:09:26', '2026-09-07 03:08:26'),
(34, 11, 28, 'Heir to the Throne độ khó cao: kinh nghiệm giữ quân', 'Chiến dịch này rất dài, quân sống sót sẽ được mang sang màn sau nên mất một đơn vị lên cấp là đau.\n\nKinh nghiệm của mình: rút quân bị thương về làng hồi máu, không đuổi theo địch vào ban đêm nếu quân mình là phe lawful.', 'published', 0, 0, '2026-11-01 12:23:26', '2026-11-02 12:08:26'),
(35, 11, 49, 'Which faction for beginners in multiplayer?', 'Starting ladder games soon. Which default faction is the most forgiving for new players?', 'published', 0, 0, '2026-09-02 03:20:26', '2026-09-04 07:20:26'),
(36, 12, 21, 'Luanti với Minetest là một à?', 'Mình thấy nhiều hướng dẫn trên mạng ghi Minetest nhưng game ở đây tên Luanti. Có khác nhau không?', 'published', 0, 0, '2026-09-14 08:00:26', '2026-09-16 02:10:26'),
(37, 12, 26, 'Danh sách mod nên cài cho server bạn bè', 'Server nhỏ của mình đang chạy các mod này, đều tải từ ContentDB:\n\n- Mesecons để làm mạch điện\n- Mod đánh dấu khu vực để chống phá nhà\n- Một mod bản đồ nhỏ\n\nMọi người bổ sung thêm nhé.', 'published', 0, 0, '2026-10-22 11:07:26', '2026-10-24 12:21:26'),
(38, 13, 30, 'Chia sẻ sơ đồ dây chuyền sản xuất silicon', 'Mình làm một sơ đồ silicon gọn: than và cát vào hai bên, đầu ra một băng chuyền. Mọi người chia sẻ sơ đồ của mình đi.', 'published', 0, 0, '2026-10-21 05:46:26', '2026-10-22 21:27:26'),
(39, 13, 45, 'Erekir is hard, any tips?', 'Finished most of Serpulo and moved to Erekir. Everything works differently and I keep losing.', 'published', 0, 0, '2026-10-20 03:39:26', '2026-10-20 20:05:26'),
(40, 14, 22, 'Tín hiệu đường ray: dùng path signal thế nào cho đúng?', 'Câu hỏi muôn thuở. Nguyên tắc mình hay dùng:\n\n- Đường một chiều dài: dùng tín hiệu khối thường.\n- Các ngã rẽ, nhà ga có nhiều đường: dùng path signal để tàu tự tìm đường trống.\n\nAi có mẹo khác thì góp thêm.', 'published', 0, 0, '2026-09-12 20:52:26', '2026-09-15 22:43:26'),
(41, 14, 47, 'Show your biggest network', 'My current save has a mainline that crosses the whole map with four tracks. Describe your biggest network!', 'published', 0, 0, '2026-08-27 13:19:26', '2026-08-29 16:27:26'),
(42, 15, 24, 'Lộ trình tập strafe jump cho người mới', 'Mình đã tập được hai tuần, chia sẻ lộ trình:\n\n1. Tập trên bản đồ trống, chỉ nhảy liên tục giữ đà.\n2. Kết hợp xoay chuột đều tay với phím trái phải.\n3. Mới chơi với người thì đừng quá lo, cứ chơi để quen bản đồ.', 'published', 0, 0, '2026-07-25 12:26:26', '2026-07-27 06:53:26'),
(43, 15, 50, 'Instagib or normal mode for new players?', 'Some friends want to try Xonotic. Should I start them on Instagib or the normal weapon set?', 'published', 0, 0, '2026-09-01 19:19:26', '2026-09-02 05:49:26'),
(44, 16, 36, 'civ2civ3 hay classic: nên chọn ruleset nào?', 'Mình mới chơi Freeciv, thấy có nhiều ruleset. Người mới nên chọn cái nào?', 'published', 0, 0, '2026-07-28 12:18:26', '2026-07-30 08:58:26'),
(46, 3, 20, 'Tuần này mọi người đang chơi game gì?', 'Mở topic để mọi người chia sẻ game đang chơi trong tuần.\n\nMình vẫn đang cày 0 A.D., tối qua thua AI ba ván liền vì quên xây tường thành.', 'published', 0, 0, '2026-11-02 02:00:19', '2026-11-02 11:59:19'),
(47, 3, 39, 'Hello from Japan, first post here', 'Hi everyone! I found this site while searching for open-source games. I can read a little Vietnamese with a translator. Nice to meet you all.', 'published', 0, 0, '2026-11-02 23:00:19', '2026-11-03 03:35:19'),
(48, 6, 17, 'Platformer nhỏ làm bằng Godot sau 3 tháng, xin góp ý', 'Mình làm buổi tối sau giờ làm. Hiện có 6 màn, nhân vật nhảy hai lần và bám tường.\n\nVấn đề lớn nhất là cảm giác nhảy chưa đã. Mọi người thường chỉnh gì để nhảy cho sướng tay?', 'published', 0, 0, '2026-11-02 06:00:19', '2026-11-02 17:28:19'),
(49, 7, 38, 'Lập nhóm đua SuperTuxKart online tối thứ Sáu', 'Mỗi tối thứ Sáu 21 giờ, mình mở phòng đua online. Ai muốn tham gia thì để lại tên trong game.', 'published', 0, 0, '2026-11-02 12:00:19', '2026-11-02 20:46:19'),
(50, 8, 27, 'Đề xuất: lọc game theo thời lượng chơi', 'Mình hay tìm game ngắn chơi trong một buổi tối. Nếu có bộ lọc theo thời lượng như dưới 1 giờ, 1 đến 5 giờ thì tiện lắm.', 'published', 0, 0, '2026-11-01 16:00:19', '2026-11-02 13:39:19'),
(51, 9, 52, 'Petra AI on Hard is crushing me, any tips?', 'Every game the AI attacks around the same time and my army is never ready. What should I focus on?', 'published', 0, 0, '2026-11-02 18:00:19', '2026-11-02 23:09:19'),
(52, 10, 19, 'Mẹo drift để có nitro cho người mới', 'Khi vào cua, giữ nút drift đủ lâu thì kart sẽ được tăng tốc lúc nhả ra. Giữ càng lâu thì mức tăng tốc càng cao.\n\nMẹo: bắt đầu drift sớm một chút trước khi vào cua, đừng đợi đã ở giữa cua.', 'published', 0, 0, '2026-11-01 06:00:19', '2026-11-01 23:49:19'),
(53, 16, 46, 'Anyone up for a longturn game?', 'Thinking of starting a slow game: one turn per day, small map, friendly players. Who is interested?', 'published', 0, 0, '2026-11-03 02:00:19', '2026-11-03 04:09:19');

-- --------------------------------------------------------

--
-- Table structure for table `cuoc_thi_lam_game`
--

CREATE TABLE `cuoc_thi_lam_game` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `nguoi_tao_id` bigint(20) UNSIGNED NOT NULL,
  `tieu_de` varchar(200) NOT NULL,
  `duong_dan_rut_gon` varchar(220) NOT NULL,
  `mo_ta` mediumtext DEFAULT NULL,
  `the_le` mediumtext DEFAULT NULL,
  `ngay_bat_dau` datetime NOT NULL,
  `han_nop_bai` datetime NOT NULL,
  `ngay_bat_dau_binh_chon` datetime DEFAULT NULL,
  `ngay_ket_thuc_binh_chon` datetime DEFAULT NULL,
  `trang_thai` enum('draft','published','active','judging','completed','cancelled') NOT NULL DEFAULT 'draft',
  `bat_binh_chon` tinyint(1) NOT NULL DEFAULT 0,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cuoc_thi_lam_game`
--

INSERT INTO `cuoc_thi_lam_game` (`ma`, `nguoi_tao_id`, `tieu_de`, `duong_dan_rut_gon`, `mo_ta`, `the_le`, `ngay_bat_dau`, `han_nop_bai`, `ngay_bat_dau_binh_chon`, `ngay_ket_thuc_binh_chon`, `trang_thai`, `bat_binh_chon`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(2, 6, 'Game Jam 01/2025: Kết nối', 'game-jam-ket-noi', 'Cuộc thi minh họa với chủ đề \"Kết nối\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2025-01-10 09:00:00', '2025-01-13 09:00:00', '2025-01-13 09:00:00', '2025-01-20 09:00:00', 'completed', 1, '2024-12-20 02:00:00', '2024-12-20 02:00:00'),
(3, 6, 'Game Jam 02/2025: Thời gian', 'game-jam-thoi-gian', 'Cuộc thi minh họa với chủ đề \"Thời gian\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2025-02-09 09:00:00', '2025-02-12 09:00:00', '2025-02-12 09:00:00', '2025-02-19 09:00:00', 'completed', 1, '2025-01-19 02:00:00', '2025-01-19 02:00:00'),
(4, 6, 'Game Jam 03/2025: Thế giới thu nhỏ', 'game-jam-the-gioi-thu-nho', 'Cuộc thi minh họa với chủ đề \"Thế giới thu nhỏ\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2025-03-11 09:00:00', '2025-03-14 09:00:00', '2025-03-14 09:00:00', '2025-03-21 09:00:00', 'completed', 1, '2025-02-18 02:00:00', '2025-02-18 02:00:00'),
(5, 6, 'Game Jam 04/2025: Ánh sáng và bóng tối', 'game-jam-anh-sang-va-bong-toi', 'Cuộc thi minh họa với chủ đề \"Ánh sáng và bóng tối\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2025-04-10 09:00:00', '2025-04-13 09:00:00', '2025-04-13 09:00:00', '2025-04-20 09:00:00', 'completed', 1, '2025-03-20 02:00:00', '2025-03-20 02:00:00'),
(6, 6, 'Game Jam 05/2025: Lặp lại', 'game-jam-lap-lai', 'Cuộc thi minh họa với chủ đề \"Lặp lại\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2025-05-10 09:00:00', '2025-05-13 09:00:00', '2025-05-13 09:00:00', '2025-05-20 09:00:00', 'completed', 1, '2025-04-19 02:00:00', '2025-04-19 02:00:00'),
(7, 6, 'Game Jam 06/2025: Hai người chơi', 'game-jam-hai-nguoi-choi', 'Cuộc thi minh họa với chủ đề \"Hai người chơi\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2025-06-09 09:00:00', '2025-06-12 09:00:00', '2025-06-12 09:00:00', '2025-06-19 09:00:00', 'completed', 1, '2025-05-19 02:00:00', '2025-05-19 02:00:00'),
(8, 6, 'Game Jam 07/2025: Không dùng chữ', 'game-jam-khong-dung-chu', 'Cuộc thi minh họa với chủ đề \"Không dùng chữ\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2025-07-09 09:00:00', '2025-07-12 09:00:00', '2025-07-12 09:00:00', '2025-07-19 09:00:00', 'completed', 1, '2025-06-18 02:00:00', '2025-06-18 02:00:00'),
(9, 6, 'Game Jam 08/2025: Âm thanh dẫn đường', 'game-jam-am-thanh-dan-duong', 'Cuộc thi minh họa với chủ đề \"Âm thanh dẫn đường\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2025-08-08 09:00:00', '2025-08-11 09:00:00', '2025-08-11 09:00:00', '2025-08-18 09:00:00', 'completed', 1, '2025-07-18 02:00:00', '2025-07-18 02:00:00'),
(10, 6, 'Game Jam 09/2025: Biến đổi', 'game-jam-bien-doi', 'Cuộc thi minh họa với chủ đề \"Biến đổi\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2025-09-07 09:00:00', '2025-09-10 09:00:00', '2025-09-10 09:00:00', '2025-09-17 09:00:00', 'completed', 1, '2025-08-17 02:00:00', '2025-08-17 02:00:00'),
(11, 6, 'Game Jam 10/2025: Xây rồi phá', 'game-jam-xay-roi-pha', 'Cuộc thi minh họa với chủ đề \"Xây rồi phá\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2025-10-07 09:00:00', '2025-10-10 09:00:00', '2025-10-10 09:00:00', '2025-10-17 09:00:00', 'completed', 1, '2025-09-16 02:00:00', '2025-09-16 02:00:00'),
(12, 6, 'Game Jam 11/2025: Trọng lực', 'game-jam-trong-luc', 'Cuộc thi minh họa với chủ đề \"Trọng lực\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2025-11-06 09:00:00', '2025-11-09 09:00:00', '2025-11-09 09:00:00', '2025-11-16 09:00:00', 'completed', 1, '2025-10-16 02:00:00', '2025-10-16 02:00:00'),
(13, 6, 'Game Jam 12/2025: Ký ức', 'game-jam-ky-uc', 'Cuộc thi minh họa với chủ đề \"Ký ức\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2025-12-06 09:00:00', '2025-12-09 09:00:00', '2025-12-09 09:00:00', '2025-12-16 09:00:00', 'completed', 1, '2025-11-15 02:00:00', '2025-11-15 02:00:00'),
(14, 6, 'Game Jam 01/2026: Đường đua', 'game-jam-duong-dua', 'Cuộc thi minh họa với chủ đề \"Đường đua\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2026-01-05 09:00:00', '2026-01-08 09:00:00', '2026-01-08 09:00:00', '2026-01-15 09:00:00', 'completed', 1, '2025-12-15 02:00:00', '2025-12-15 02:00:00'),
(15, 6, 'Game Jam 02/2026: Bản đồ ô lục giác', 'game-jam-ban-do-o-luc-giac', 'Cuộc thi minh họa với chủ đề \"Bản đồ ô lục giác\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2026-02-04 09:00:00', '2026-02-07 09:00:00', '2026-02-07 09:00:00', '2026-02-14 09:00:00', 'completed', 1, '2026-01-14 02:00:00', '2026-01-14 02:00:00'),
(16, 6, 'Game Jam 03/2026: Không gian hẹp', 'game-jam-khong-gian-hep', 'Cuộc thi minh họa với chủ đề \"Không gian hẹp\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2026-03-06 09:00:00', '2026-03-09 09:00:00', '2026-03-09 09:00:00', '2026-03-16 09:00:00', 'completed', 1, '2026-02-13 02:00:00', '2026-02-13 02:00:00'),
(17, 6, 'Game Jam 04/2026: Tài nguyên khan hiếm', 'game-jam-tai-nguyen-khan-hiem', 'Cuộc thi minh họa với chủ đề \"Tài nguyên khan hiếm\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2026-04-05 09:00:00', '2026-04-08 09:00:00', '2026-04-08 09:00:00', '2026-04-15 09:00:00', 'completed', 1, '2026-03-15 02:00:00', '2026-03-15 02:00:00'),
(18, 6, 'Game Jam 05/2026: Hợp tác', 'game-jam-hop-tac', 'Cuộc thi minh họa với chủ đề \"Hợp tác\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2026-05-05 09:00:00', '2026-05-08 09:00:00', '2026-05-08 09:00:00', '2026-05-15 09:00:00', 'completed', 1, '2026-04-14 02:00:00', '2026-04-14 02:00:00'),
(19, 6, 'Game Jam 06/2026: Mở rộng', 'game-jam-mo-rong', 'Cuộc thi minh họa với chủ đề \"Mở rộng\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2026-06-04 09:00:00', '2026-06-07 09:00:00', '2026-06-07 09:00:00', '2026-06-14 09:00:00', 'completed', 1, '2026-05-14 02:00:00', '2026-05-14 02:00:00'),
(20, 6, 'Game Jam 07/2026: Bầu trời', 'game-jam-bau-troi', 'Cuộc thi minh họa với chủ đề \"Bầu trời\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2026-07-04 09:00:00', '2026-07-07 09:00:00', '2026-07-07 09:00:00', '2026-07-14 09:00:00', 'completed', 1, '2026-06-13 02:00:00', '2026-06-13 02:00:00'),
(21, 6, 'Game Jam 10/2026: Thành phố mọc lên', 'game-jam-thanh-pho-moc-len', 'Cuộc thi minh họa với chủ đề \"Thành phố mọc lên\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2026-10-29 09:27:42', '2026-11-01 09:27:42', '2026-11-01 09:27:42', '2026-11-10 09:27:42', 'active', 1, '2026-10-08 02:27:42', '2026-10-08 02:27:42'),
(22, 6, 'Game Jam 10/2026: Vũ trụ rộng lớn', 'game-jam-vu-tru-rong-lon', 'Cuộc thi minh họa với chủ đề \"Vũ trụ rộng lớn\". Các bài dự thi là trò chơi mã nguồn mở đã có sẵn, được nộp để minh họa tính năng cuộc thi; chúng không được làm trong thời gian diễn ra cuộc thi.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2026-10-28 09:27:42', '2026-10-31 09:27:42', '2026-10-31 09:27:42', '2026-11-09 09:27:42', 'active', 1, '2026-10-07 02:27:42', '2026-10-07 02:27:42'),
(23, 6, 'Game Jam 11/2026: Đi theo dòng chảy', 'game-jam-di-theo-dong-chay', 'Cuộc thi minh họa với chủ đề \"Đi theo dòng chảy\".', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2026-11-02 09:27:42', '2026-11-07 09:27:42', '2026-11-07 09:27:42', '2026-11-14 09:27:42', 'active', 1, '2026-10-12 02:27:42', '2026-10-12 02:27:42'),
(24, 6, 'Game Jam 11/2026: Một màn hình', 'game-jam-mot-man-hinh', 'Cuộc thi minh họa với chủ đề \"Một màn hình\".', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2026-11-02 09:27:42', '2026-11-10 09:27:42', '2026-11-10 09:27:42', '2026-11-17 09:27:42', 'active', 1, '2026-10-12 02:27:42', '2026-10-12 02:27:42'),
(25, 6, 'Game Jam 11/2026: Phía sau cánh cửa', 'game-jam-phia-sau-canh-cua', 'Cuộc thi minh họa với chủ đề \"Phía sau cánh cửa\".', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2026-11-02 09:27:42', '2026-11-13 09:27:42', '2026-11-13 09:27:42', '2026-11-20 09:27:42', 'active', 1, '2026-10-12 02:27:42', '2026-10-12 02:27:42'),
(26, 6, 'Game Jam 12/2026: Mùa đông', 'game-jam-mua-dong', 'Cuộc thi minh họa với chủ đề \"Mùa đông\".', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2026-12-05 09:00:00', '2026-12-08 09:00:00', '2026-12-08 09:00:00', '2026-12-15 09:00:00', 'published', 1, '2026-11-04 01:27:42', '2026-11-04 01:27:42'),
(27, 6, 'Game Jam 12/2026: Năm mới 2027', 'game-jam-nam-moi-2027', 'Cuộc thi minh họa với chủ đề \"Năm mới 2027\".', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2026-12-28 09:00:00', '2026-12-31 09:00:00', '2026-12-31 09:00:00', '2027-01-07 09:00:00', 'published', 1, '2026-11-04 01:27:42', '2026-11-04 01:27:42'),
(28, 6, 'Game Jam 02/2027: Mùa xuân', 'game-jam-mua-xuan', 'Cuộc thi minh họa với chủ đề \"Mùa xuân\".', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2027-02-05 09:00:00', '2027-02-08 09:00:00', '2027-02-08 09:00:00', '2027-02-15 09:00:00', 'published', 1, '2026-11-04 01:27:42', '2026-11-04 01:27:42'),
(29, 6, 'Game Jam 03/2027: Âm nhạc là luật chơi', 'game-jam-am-nhac-la-luat-choi', 'Cuộc thi minh họa với chủ đề \"Âm nhạc là luật chơi\".', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2027-03-12 09:00:00', '2027-03-15 09:00:00', '2027-03-15 09:00:00', '2027-03-22 09:00:00', 'draft', 1, '2026-11-04 01:27:42', '2026-11-04 01:27:42'),
(30, 6, 'Game Jam 04/2027: Đảo hoang', 'game-jam-dao-hoang', 'Cuộc thi minh họa với chủ đề \"Đảo hoang\".', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2027-04-09 09:00:00', '2027-04-12 09:00:00', '2027-04-12 09:00:00', '2027-04-19 09:00:00', 'draft', 1, '2026-11-04 01:27:42', '2026-11-04 01:27:42'),
(31, 6, 'Game Jam 09/2026: Tháng chín', 'game-jam-thang-chin', 'Cuộc thi minh họa với chủ đề \"Tháng chín\". Cuộc thi đã bị hủy trước ngày bắt đầu.', 'Làm một trò chơi bám chủ đề trong 72 giờ.\nĐược dùng tài nguyên có giấy phép tự do, ghi nguồn đầy đủ trong trang trò chơi.\nBài dự thi được chấm theo 5 tiêu chí: tổng thể, lối chơi, hình ảnh, âm thanh và bám chủ đề.', '2026-09-11 09:00:00', '2026-09-14 09:00:00', '2026-09-14 09:00:00', '2026-09-21 09:00:00', 'cancelled', 1, '2026-08-21 02:00:00', '2026-08-21 02:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `danh_gia`
--

CREATE TABLE `danh_gia` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `diem_danh_gia` tinyint(3) UNSIGNED NOT NULL,
  `tieu_de` varchar(200) DEFAULT NULL,
  `noi_dung_danh_gia` mediumtext DEFAULT NULL,
  `da_xac_minh_so_huu` tinyint(1) NOT NULL DEFAULT 0,
  `trang_thai` enum('published','hidden','removed') NOT NULL DEFAULT 'published',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

--
-- Dumping data for table `danh_gia`
--

INSERT INTO `danh_gia` (`ma`, `tro_choi_id`, `nguoi_dung_id`, `diem_danh_gia`, `tieu_de`, `noi_dung_danh_gia`, `da_xac_minh_so_huu`, `trang_thai`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(2, 3, 20, 5, 'Game chiến thuật cổ đại đáng chơi nhất', 'Nhiều phe phái, mỗi phe có lối chơi riêng. AI đủ sức thử thách. Chơi mạng vui.', 1, 'published', '2026-08-06 21:47:26', '2026-08-06 21:47:26'),
(3, 3, 52, 4, 'Great RTS, steep learning curve', 'Beautiful and deep. The AI on harder levels takes time to learn to beat.', 1, 'published', '2026-10-14 19:09:26', '2026-10-14 19:09:26'),
(4, 3, 43, 5, 'Historical and beautiful', 'Love the attention to historical detail.', 1, 'published', '2026-08-16 01:53:26', '2026-08-16 01:53:26'),
(5, 3, 31, 4, 'Hoài niệm mà vẫn hiện đại', 'Gợi nhớ game chiến thuật xưa, giao diện cần làm quen một chút.', 1, 'published', '2026-08-15 07:24:26', '2026-08-15 07:24:26'),
(6, 4, 19, 5, 'Đua xe vui nhất cho nhóm bạn', 'Nhiều chế độ chơi, chơi mạng ổn định, có add-on phong phú.', 1, 'published', '2026-09-25 12:58:26', '2026-09-25 12:58:26'),
(7, 4, 40, 5, 'Pure fun', 'Easy to learn, drifting gives it depth.', 1, 'published', '2026-09-30 20:48:26', '2026-09-30 20:48:26'),
(8, 4, 35, 4, 'Nhẹ nhàng, dễ chơi', 'Chế độ câu chuyện hay, mình chơi ở độ khó thấp vẫn vui.', 1, 'published', '2026-08-11 01:37:26', '2026-08-11 01:37:26'),
(9, 4, 32, 5, 'Time trial gây nghiện', 'Cải thiện từng giây trên mỗi đường đua là niềm vui riêng.', 1, 'published', '2026-10-22 22:11:26', '2026-10-22 22:11:26'),
(10, 4, 39, 4, 'Good for all ages', 'My whole family plays it.', 1, 'published', '2026-09-28 13:12:26', '2026-09-28 13:12:26'),
(11, 5, 28, 5, 'Chiến thuật lượt kinh điển', 'Chiến dịch dài và hay. Yếu tố may rủi khiến mỗi trận đều khác.', 1, 'published', '2026-10-23 23:42:26', '2026-10-23 23:42:26'),
(12, 5, 49, 5, 'Endless replayability', 'Campaigns, multiplayer and add-ons. Hard to run out of content.', 1, 'published', '2026-08-21 08:38:26', '2026-08-21 08:38:26'),
(13, 5, 46, 4, 'Deep but fair', 'The randomness can be frustrating, but planning around it is the point.', 1, 'published', '2026-10-07 01:48:26', '2026-10-07 01:48:26'),
(14, 6, 21, 5, 'Thế giới khối để thư giãn', 'Chế độ sáng tạo rất hợp để xả stress.', 1, 'published', '2026-10-22 20:17:26', '2026-10-22 20:17:26'),
(15, 6, 26, 5, 'Tuyệt vời cho người thích viết mod', 'API Lua dễ học, cộng đồng hỗ trợ tốt.', 1, 'published', '2026-08-28 08:04:26', '2026-08-28 08:04:26'),
(16, 6, 51, 4, 'Great engine, choose your game', 'Pick a game from ContentDB that fits you, the base is very flexible.', 1, 'published', '2026-09-06 05:52:26', '2026-09-06 05:52:26'),
(17, 6, 27, 4, 'Nhẹ máy, dễ chịu', 'Chạy tốt trên laptop cũ của mình.', 1, 'published', '2026-09-20 03:07:26', '2026-09-20 03:07:26'),
(18, 7, 30, 5, 'Dây chuyền và phòng thủ hoàn hảo', 'Kết hợp xây nhà máy và thủ thành rất khéo.', 1, 'published', '2026-09-12 21:08:26', '2026-09-12 21:08:26'),
(19, 7, 45, 5, 'Best factory tower defense', 'Long campaign, satisfying progression.', 1, 'published', '2026-09-21 18:37:26', '2026-09-21 18:37:26'),
(20, 7, 39, 4, 'Addictive', 'Hard to stop once your factory gets going.', 1, 'published', '2026-09-14 00:09:26', '2026-09-14 00:09:26'),
(21, 8, 22, 5, 'Mô phỏng giao thông đỉnh cao', 'Học tín hiệu đường ray mất thời gian nhưng rất đáng.', 1, 'published', '2026-10-03 21:11:26', '2026-10-03 21:11:26'),
(22, 8, 47, 5, 'Trains forever', 'Still the best transport game for me.', 1, 'published', '2026-10-15 20:11:26', '2026-10-15 20:11:26'),
(23, 8, 49, 4, 'Deep and relaxing', 'Can be complex, but you can play at your own pace.', 1, 'published', '2026-08-21 01:02:26', '2026-08-21 01:02:26'),
(24, 8, 41, 4, 'Great on Linux', 'Runs smoothly, lots of community content.', 1, 'published', '2026-09-17 20:02:26', '2026-09-17 20:02:26'),
(25, 9, 24, 5, 'Bắn súng tốc độ cao', 'Di chuyển là kỹ năng chính, rất đã khi đã quen.', 1, 'published', '2026-09-12 14:39:26', '2026-09-12 14:39:26'),
(26, 9, 50, 5, 'Classic arena shooter', 'Fast, skill-based and free.', 1, 'published', '2026-08-12 07:41:26', '2026-08-12 07:41:26'),
(27, 9, 38, 4, 'Chơi LAN rất vui', 'Người mới hơi khó theo kịp, chế độ Instagib giúp cân bằng.', 1, 'published', '2026-10-03 17:53:26', '2026-10-03 17:53:26'),
(28, 10, 36, 5, 'Một lượt nữa thôi', 'Chiến lược sâu, nhiều ruleset để thử.', 1, 'published', '2026-08-25 22:23:26', '2026-08-25 22:23:26'),
(29, 10, 46, 5, 'Longturn community is great', 'Slow multiplayer games are a unique experience.', 1, 'published', '2026-09-18 16:52:26', '2026-09-18 16:52:26'),
(30, 10, 49, 4, 'Solid 4X', 'Interface looks old but the depth is all there.', 1, 'published', '2026-10-14 05:28:26', '2026-10-14 05:28:26'),
(31, 15, 27, 5, 'Game thư giãn số một của mình', 'Trồng trọt, câu cá, làm quen dân làng, mỗi ngày trong game đều có việc vui để làm. Chơi lại năm nào cũng thấy hay.', 1, 'published', '2026-10-31 00:39:29', '2026-10-31 00:39:29'),
(32, 15, 48, 5, 'A masterpiece made by one person', 'Hard to believe one developer made all of this. Co-op is a great addition.', 1, 'published', '2026-11-02 17:07:29', '2026-11-02 17:07:29'),
(33, 15, 24, 4, 'Hay nhưng dễ nghiện', 'Định chơi 1 tiếng ai ngờ hết cả buổi tối. Phần hầm mỏ hơi lặp lại.', 1, 'published', '2026-10-31 13:10:29', '2026-10-31 13:10:29'),
(34, 16, 32, 5, 'Metroidvania hay nhất từng chơi', 'Thế giới rộng, trùm khó mà công bằng, nhạc nền tuyệt vời. Giá rẻ so với lượng nội dung.', 1, 'published', '2026-11-02 10:39:29', '2026-11-02 10:39:29'),
(35, 16, 39, 5, 'Beautiful and challenging', 'Hand-drawn art and the music create a world I did not want to leave.', 1, 'published', '2026-11-01 16:11:29', '2026-11-01 16:11:29'),
(36, 16, 35, 3, 'Khó với người mới', 'Đẹp nhưng nhiều lúc lạc đường, phải mua bản đồ mới biết đi đâu. Ai thích thử thách thì sẽ thích.', 1, 'published', '2026-11-01 03:03:29', '2026-11-01 03:03:29'),
(37, 17, 31, 5, 'Vừa khó vừa cảm động', 'Điều khiển cực chuẩn, chết là do mình. Câu chuyện về lo âu của Madeline viết rất tinh tế.', 1, 'published', '2026-10-31 13:48:29', '2026-10-31 13:48:29'),
(38, 17, 43, 5, 'Perfect platformer', 'Tight controls, great music and an assist mode that makes it accessible to everyone.', 1, 'published', '2026-11-01 23:25:29', '2026-11-01 23:25:29'),
(39, 18, 44, 5, 'Roguelike for people who hate roguelikes', 'Story progresses every run, voice acting is fantastic, combat is fast and readable.', 1, 'published', '2026-11-02 17:58:29', '2026-11-02 17:58:29'),
(40, 18, 22, 5, 'Không chán dù chơi trăm lần', 'Mỗi lượt chơi khác nhau nhờ phúc lành các vị thần. Lồng tiếng và hình ảnh đều rất đẹp.', 1, 'published', '2026-11-02 07:52:29', '2026-11-02 07:52:29'),
(41, 18, 36, 4, 'Rất hay nhưng hơi cay', 'Mấy lượt đầu khá khó, nhưng nâng cấp vĩnh viễn giúp tiến bộ dần. Đáng tiền.', 1, 'published', '2026-10-31 14:03:29', '2026-10-31 14:03:29'),
(42, 19, 47, 5, 'Addictive combat', 'Every run teaches you something. The weapon variety keeps it fresh for a long time.', 1, 'published', '2026-10-31 00:47:29', '2026-10-31 00:47:29'),
(43, 19, 30, 4, 'Hay, nhưng chết nhiều', 'Đánh rất đã tay. Không có điểm lưu nên mất một lượt dài thấy tiếc.', 1, 'published', '2026-11-01 04:57:29', '2026-11-01 04:57:29'),
(44, 20, 28, 5, 'Game bài chiến thuật đỉnh cao', 'Mỗi lượt chơi là một bài toán mới. Bốn nhân vật khác hẳn nhau, chơi mấy trăm giờ vẫn chưa chán.', 1, 'published', '2026-10-31 20:53:29', '2026-10-31 20:53:29'),
(45, 20, 51, 5, 'Defined a genre', 'Easy to learn, very hard to master. Ascension levels add a lot of depth.', 1, 'published', '2026-11-02 13:55:29', '2026-11-02 13:55:29'),
(46, 20, 25, 4, 'Hợp người thích suy nghĩ', 'Không cần phản xạ nhanh, chỉ cần tính toán. Có tiếng Việt là điểm cộng lớn.', 1, 'published', '2026-10-31 20:01:29', '2026-10-31 20:01:29'),
(47, 21, 19, 5, 'Chơi với bạn bè vui nhất', 'Đào, xây, đánh trùm cùng nhau. Nội dung khổng lồ mà giá lại rẻ.', 1, 'published', '2026-11-02 06:33:29', '2026-11-02 06:33:29'),
(48, 21, 50, 5, 'Still great after years', 'Free updates kept adding content. Hundreds of hours with friends.', 1, 'published', '2026-11-01 08:33:29', '2026-11-01 08:33:29'),
(49, 21, 34, 4, 'Chạy tốt trên Linux', 'Bản Linux ổn định. Đầu game hơi bỡ ngỡ, nên xem wiki khi cần chế tạo đồ.', 1, 'published', '2026-11-02 16:21:29', '2026-11-02 16:21:29'),
(50, 22, 21, 5, 'Ngắn mà đáng nhớ', 'Hai tiếng nhẹ nhàng, nhân vật dễ thương, cảm giác lượn trên núi rất thích.', 1, 'published', '2026-11-01 11:27:29', '2026-11-01 11:27:29'),
(51, 22, 49, 4, 'Short and sweet', 'A lovely little adventure. Wish it was a bit longer, but that is part of its charm.', 1, 'published', '2026-11-01 20:30:29', '2026-11-01 20:30:29'),
(52, 23, 35, 5, 'Rẻ mà chơi cả trăm giờ', 'Luật chơi đơn giản, càng về sau càng hỗn loạn và vui. Hợp chơi giải trí ngắn.', 1, 'published', '2026-10-31 12:44:29', '2026-10-31 12:44:29'),
(53, 23, 46, 4, 'Fun with friends', 'Local co-op is chaotic fun. Later stages can get visually overwhelming.', 1, 'published', '2026-11-02 05:00:29', '2026-11-02 05:00:29'),
(54, 23, 24, 3, 'Vui nhưng nhanh chán', 'Lúc đầu rất cuốn, sau khi mở gần hết thì thấy lặp lại.', 1, 'published', '2026-11-01 12:43:29', '2026-11-01 12:43:29'),
(55, 24, 33, 5, 'Kể chuyện qua giấy tờ', 'Không ngờ một game kiểm tra hộ chiếu lại khiến mình suy nghĩ nhiều về lựa chọn đạo đức đến vậy.', 1, 'published', '2026-11-01 17:18:29', '2026-11-01 17:18:29'),
(56, 24, 52, 5, 'Unique and memorable', 'Simple mechanics, heavy decisions. Multiple endings encourage replays.', 1, 'published', '2026-10-31 20:00:29', '2026-10-31 20:00:29'),
(57, 25, 28, 5, 'Game bài kinh dị độc đáo', 'Cơ chế hiến tế lá bài rất sáng tạo, không khí căng thẳng. Hai phần sau có thể gây tranh cãi nhưng vẫn đáng chơi.', 1, 'published', '2026-11-02 01:53:05', '2026-11-02 01:53:05'),
(58, 25, 43, 4, 'Brilliant first act', 'The cabin section is a masterpiece. Later acts are weaker but the ideas are bold.', 1, 'published', '2026-11-02 09:10:05', '2026-11-02 09:10:05'),
(59, 26, 27, 5, 'Nhẹ nhàng và ý nghĩa', 'Không lời thoại mà vẫn kể được cả một cuộc đời. Hợp để thư giãn buổi tối.', 1, 'published', '2026-11-02 16:33:05', '2026-11-02 16:33:05'),
(60, 26, 48, 4, 'Short but lovely', 'About four hours long. Every room tells a story.', 1, 'published', '2026-11-01 11:22:05', '2026-11-01 11:22:05'),
(61, 27, 36, 5, 'Ý tưởng lạ mà cuốn', 'Không điều khiển nhân vật nhưng vẫn phải suy nghĩ nhiều. Một ván ngắn, dễ chơi xen kẽ.', 1, 'published', '2026-11-02 10:04:05', '2026-11-02 10:04:05'),
(62, 27, 46, 4, 'Clever idea', 'The loop concept is fresh. Gets a bit grindy in the later chapters.', 1, 'published', '2026-11-01 09:26:05', '2026-11-01 09:26:05'),
(63, 28, 27, 4, 'Câu cá rùng rợn', 'Phần sắp xếp khoang hàng rất vui. Cốt truyện hơi ngắn nhưng không khí rất tốt.', 1, 'published', '2026-11-01 11:08:05', '2026-11-01 11:08:05'),
(64, 28, 49, 5, 'Cosy horror done right', 'Fishing loop is relaxing until night falls. Great atmosphere and upgrades.', 1, 'published', '2026-11-02 15:48:05', '2026-11-02 15:48:05'),
(65, 29, 20, 5, 'Roguelike kinh điển', 'Mười năm vẫn hay. Mỗi chuyến đi là một câu chuyện riêng.', 1, 'published', '2026-11-02 08:54:05', '2026-11-02 08:54:05'),
(66, 29, 47, 4, 'Hard but fair', 'The final boss is brutal. Still one of the best space games.', 1, 'published', '2026-11-01 13:07:05', '2026-11-01 13:07:05'),
(67, 30, 26, 4, 'Khó nhưng có mod giúp', 'Thế giới đẹp và lạ. Người mới nên tra wiki hoặc dùng mod hỗ trợ.', 1, 'published', '2026-10-31 05:47:05', '2026-10-31 05:47:05'),
(68, 30, 42, 4, 'Unique art style', 'Brutal survival with gorgeous hand-drawn visuals.', 1, 'published', '2026-11-01 22:21:05', '2026-11-01 22:21:05'),
(69, 31, 32, 5, 'Gây nghiện nhất năm', 'Luật poker ai cũng biết, nhưng Joker biến hóa vô tận. Giá rẻ mà chơi mãi không chán.', 1, 'published', '2026-11-02 04:01:05', '2026-11-02 04:01:05'),
(70, 31, 51, 5, 'One more run', 'Perfect pick up and play game. Great music too.', 1, 'published', '2026-11-02 10:35:05', '2026-11-02 10:35:05'),
(71, 31, 35, 4, 'Dễ học khó giỏi', 'Mấy mức cược cao rất khó, cần hiểu combo Joker.', 1, 'published', '2026-10-31 17:14:05', '2026-10-31 17:14:05'),
(72, 32, 52, 5, 'Stress is the real enemy', 'Managing hero stress makes every expedition tense. Narration is fantastic.', 1, 'published', '2026-11-01 13:30:05', '2026-11-01 13:30:05'),
(73, 32, 22, 4, 'Khó và tàn nhẫn', 'Mất anh hùng là chuyện thường. Ai thích thử thách sẽ mê.', 1, 'published', '2026-11-01 15:11:05', '2026-11-01 15:11:05'),
(74, 33, 24, 5, 'Đẹp như phim hoạt hình', 'Từng khung hình như vẽ tay thật. Trùm khó nhưng thắng rồi rất sướng.', 1, 'published', '2026-10-31 00:30:05', '2026-10-31 00:30:05'),
(75, 33, 50, 4, 'Gorgeous and tough', 'Co-op makes it easier and more fun.', 1, 'published', '2026-10-31 21:12:05', '2026-10-31 21:12:05'),
(76, 34, 30, 5, 'Máy tạo câu chuyện', 'Mỗi thuộc địa là một bộ phim. Mod làm game sống mãi.', 1, 'published', '2026-10-30 21:43:05', '2026-10-30 21:43:05'),
(77, 34, 26, 5, 'Hệ sinh thái mod tuyệt vời', 'Hàng nghìn mod trên Workshop. Bản gốc đã rất hay rồi.', 1, 'published', '2026-11-01 08:29:05', '2026-11-01 08:29:05'),
(78, 35, 19, 4, 'Bắn đã tay', 'Súng đa dạng, trùm sáng tạo. Hơi khó với người mới.', 1, 'published', '2026-10-31 05:50:05', '2026-10-31 05:50:05'),
(79, 35, 39, 5, 'Bullet hell heaven', 'Hundreds of guns, each with a funny twist.', 1, 'published', '2026-10-31 13:58:05', '2026-10-31 13:58:05'),
(80, 36, 29, 5, 'Nhạc và câu chuyện tuyệt vời', 'Game nhỏ mà để lại ấn tượng lớn. Nên chơi cả hai lối đi.', 1, 'published', '2026-11-02 13:16:05', '2026-11-02 13:16:05'),
(81, 36, 40, 5, 'Changed how I see RPGs', 'Choosing mercy feels meaningful. Characters are unforgettable.', 1, 'published', '2026-10-30 23:49:05', '2026-10-30 23:49:05'),
(82, 37, 30, 5, 'Game tự động hóa đỉnh nhất', 'Tối ưu hóa không bao giờ hết. Hiệu năng cực tốt dù nhà máy khổng lồ.', 1, 'published', '2026-10-31 05:53:05', '2026-10-31 05:53:05'),
(83, 37, 17, 5, 'Như lập trình nhưng vui hơn', 'Thiết kế dây chuyền giống viết code. Developer cực kỳ tâm huyết.', 1, 'published', '2026-11-01 22:06:05', '2026-11-01 22:06:05'),
(84, 38, 17, 4, 'Khó học nhưng sâu', 'Phải hiểu khí, nhiệt, chất lỏng. Khi làm chủ được thì rất thỏa mãn.', 1, 'published', '2026-11-02 05:28:05', '2026-11-02 05:28:05'),
(85, 38, 41, 4, 'Physics sandbox', 'Steep learning curve but very rewarding.', 1, 'published', '2026-11-02 00:58:05', '2026-11-02 00:58:05'),
(86, 39, 31, 5, 'Ngắn mà chất', 'Hành động nhanh, nhạc hay, cốt truyện bí ẩn. Chỉ tiếc hơi ngắn.', 1, 'published', '2026-11-02 03:00:05', '2026-11-02 03:00:05'),
(87, 39, 44, 4, 'Stylish', 'Great combat and soundtrack. Ending leaves you wanting more.', 1, 'published', '2026-11-02 19:33:05', '2026-11-02 19:33:05'),
(88, 40, 25, 5, 'Như đọc một cuốn tiểu thuyết', 'Nhân vật rất thật, câu chuyện về tuổi trẻ chạm tới mình.', 1, 'published', '2026-10-31 11:17:05', '2026-10-31 11:17:05'),
(89, 40, 48, 4, 'Slow but heartfelt', 'Pacing is slow at times, but the writing is wonderful.', 1, 'published', '2026-10-31 15:15:05', '2026-10-31 15:15:05'),
(90, 41, 23, 5, 'Bí mật khắp nơi', 'Hình ảnh đẹp, câu đố cuối game cực kỳ thông minh.', 1, 'published', '2026-11-01 09:51:05', '2026-11-01 09:51:05'),
(91, 41, 45, 4, 'Beautiful but hard', 'Combat can be tough, but discovering secrets is amazing.', 1, 'published', '2026-11-01 02:32:05', '2026-11-01 02:32:05'),
(92, 42, 28, 5, 'Chiến thuật hoàn hảo', 'Thông tin rõ ràng, mỗi lượt là một bài toán. Không có may rủi khó chịu.', 1, 'published', '2026-10-31 19:21:05', '2026-10-31 19:21:05'),
(93, 42, 20, 4, 'Ngắn gọn mà sâu', 'Một ván khoảng một tiếng. Rất hợp chơi ngắn.', 1, 'published', '2026-11-02 13:04:05', '2026-11-02 13:04:05'),
(94, 43, 33, 5, 'Trinh thám xuất sắc', 'Phải quan sát từng chi tiết. Cảm giác suy luận đúng là có một không hai.', 1, 'published', '2026-11-02 19:28:05', '2026-11-02 19:28:05'),
(95, 43, 39, 5, 'Pure deduction', 'No hand-holding. The art style is striking.', 1, 'published', '2026-11-01 23:27:05', '2026-11-01 23:27:05'),
(96, 44, 17, 5, 'Giải đố thiên tài', 'Đổi luật để thắng là ý tưởng rất hay. Có màn nghĩ cả ngày mới ra.', 1, 'published', '2026-11-01 20:26:05', '2026-11-01 20:26:05'),
(97, 44, 43, 4, 'Brain melting', 'Brilliant puzzles but some late levels are extremely hard.', 1, 'published', '2026-11-01 05:10:05', '2026-11-01 05:10:05'),
(98, 45, 34, 5, 'Trải nghiệm chỉ có một lần', 'Hãy chơi mà không đọc gì trước. Khám phá là phần thưởng duy nhất và cũng là tốt nhất.', 1, 'published', '2026-10-31 06:48:05', '2026-10-31 06:48:05'),
(99, 45, 49, 5, 'A masterpiece', 'The best exploration game I have played.', 1, 'published', '2026-11-02 15:20:05', '2026-11-02 15:20:05'),
(100, 46, 21, 5, 'Đẹp và buồn', 'Chăm sóc từng linh hồn rồi tiễn họ đi. Nhẹ nhàng mà sâu sắc.', 1, 'published', '2026-11-01 03:15:05', '2026-11-01 03:15:05'),
(101, 46, 46, 4, 'Cozy and emotional', 'Lots of management, beautiful art. Some tasks get repetitive.', 1, 'published', '2026-11-02 16:22:05', '2026-11-02 16:22:05'),
(102, 47, 20, 5, 'RTS cổ điển còn sống', 'Thiết kế xe tự do, chiến dịch dài. Cộng đồng vẫn cập nhật đều.', 0, 'published', '2026-10-31 03:07:05', '2026-10-31 03:07:05'),
(103, 47, 47, 4, 'Classic RTS, free', 'Great to see this game maintained as open source.', 0, 'published', '2026-11-01 12:03:05', '2026-11-01 12:03:05'),
(104, 48, 38, 4, 'Miễn phí, vui với bạn bè', 'Chơi một mình hơi nhanh chán, chơi nhóm thì rất vui.', 0, 'published', '2026-11-02 16:49:05', '2026-11-02 16:49:05'),
(105, 48, 42, 4, 'Simple fun', 'Free and fun for a few evenings with friends.', 0, 'published', '2026-11-01 08:45:05', '2026-11-01 08:45:05'),
(106, 49, 24, 4, 'Sinh tồn miễn phí đáng thử', 'Nhẹ máy, nhiều bản đồ. Máy chủ cộng đồng hơi lộn xộn.', 0, 'published', '2026-11-01 07:20:05', '2026-11-01 07:20:05'),
(107, 49, 50, 4, 'Lots of content for free', 'Workshop maps keep it fresh.', 0, 'published', '2026-11-02 18:22:05', '2026-11-02 18:22:05'),
(108, 50, 36, 5, 'RTS miễn phí chất lượng', 'Đơn vị đa dạng, vật lý đường đạn thật. Chiến dịch dài và hay.', 0, 'published', '2026-10-31 02:09:05', '2026-10-31 02:09:05'),
(109, 50, 51, 4, 'Deep strategy', 'Great community and fair, no pay to win.', 0, 'published', '2026-11-01 05:38:05', '2026-11-01 05:38:05'),
(110, 51, 38, 5, 'Nhẹ mà vui', 'Máy nào cũng chạy, chơi LAN cả lớp được.', 0, 'published', '2026-10-31 12:45:05', '2026-10-31 12:45:05'),
(111, 51, 46, 4, 'Fast and fun', 'Grappling hook movement is very satisfying.', 0, 'published', '2026-11-01 03:41:05', '2026-11-01 03:41:05'),
(112, 52, 34, 5, 'Tự do giữa các vì sao', 'Buôn bán, đánh nhau, mở rộng hạm đội. Miễn phí mà nội dung rất nhiều.', 0, 'published', '2026-11-02 13:21:05', '2026-11-02 13:21:05'),
(113, 52, 52, 4, 'Great free space sim', 'Reminds me of Escape Velocity. Plugins add even more.', 0, 'published', '2026-10-31 03:22:05', '2026-10-31 03:22:05'),
(114, 53, 33, 4, 'Hoài niệm thời chat máy tính', 'Ngắn nhưng chạm cảm xúc, đặc biệt với ai từng chat thời đó.', 0, 'published', '2026-11-01 02:35:05', '2026-11-01 02:35:05'),
(115, 53, 44, 4, 'Nostalgic', 'Short story with real choices. Free, so just try it.', 0, 'published', '2026-10-31 06:01:05', '2026-10-31 06:01:05'),
(116, 54, 35, 4, 'Dễ thương mà vẫn căng', 'Đồ họa đáng yêu, trận đấu nhanh. Vật phẩm trả phí chỉ trang trí.', 0, 'published', '2026-11-02 03:07:05', '2026-11-02 03:07:05'),
(117, 54, 40, 4, 'Cute battle royale', 'Fun with friends, no pay to win.', 0, 'published', '2026-11-02 00:41:05', '2026-11-02 00:41:05'),
(118, 78, 172, 5, 'Nhiều nguồn tải, không sợ link chết', 'Cảm ơn studio đã để nhiều mirror, lúc nào một nguồn hỏng thì chuyển nguồn khác vẫn chơi được.', 1, 'published', '2026-11-01 12:00:00', '2026-11-01 12:00:00'),
(119, 78, 173, 4, 'Chế độ khó mới hơn hẳn', 'Bản 1.1.0 khó hơn bản cũ một chút nhưng vẫn hợp lý, giao diện dễ hiểu.', 1, 'published', '2026-11-02 09:30:00', '2026-11-02 09:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `dien_dan`
--

CREATE TABLE `dien_dan` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `loai_dien_dan` enum('platform','game','jam') NOT NULL,
  `tro_choi_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cuoc_thi_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tieu_de` varchar(180) NOT NULL,
  `mo_ta` varchar(1000) DEFAULT NULL,
  `cong_khai` tinyint(1) NOT NULL DEFAULT 1,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `dien_dan`
--

INSERT INTO `dien_dan` (`ma`, `loai_dien_dan`, `tro_choi_id`, `cuoc_thi_id`, `tieu_de`, `mo_ta`, `cong_khai`, `ngay_tao`) VALUES
(3, 'platform', NULL, NULL, 'Quảng trường chung', 'Tán gẫu về game độc lập, chia sẻ game đang chơi, làm quen với mọi người.', 1, '2026-06-26 08:56:26'),
(4, 'platform', NULL, NULL, 'Thông báo và nội quy', 'Nội quy diễn đàn và hướng dẫn sử dụng cộng đồng.', 1, '2026-06-26 08:56:26'),
(5, 'platform', NULL, NULL, 'Hỗ trợ kỹ thuật', 'Lỗi cài đặt, tải game, cấu hình máy. Hãy ghi rõ hệ điều hành và phiên bản game.', 1, '2026-06-26 08:56:26'),
(6, 'platform', NULL, NULL, 'Khoe dự án', 'Nơi nhà phát triển chia sẻ bản dựng đang làm, ảnh chụp, nhạc và xin góp ý.', 1, '2026-06-26 08:56:26'),
(7, 'platform', NULL, NULL, 'Tìm đồng đội và cộng tác', 'Tìm người chơi cùng, lập nhóm làm game, tìm họa sĩ hoặc lập trình viên.', 1, '2026-06-26 08:56:26'),
(8, 'platform', NULL, NULL, 'Góp ý cho nền tảng', 'Đề xuất tính năng và báo lỗi giao diện của trang web.', 1, '2026-06-26 08:56:26'),
(9, 'game', 3, NULL, 'Thảo luận về 0 A.D.', 'Chiến thuật, phe phái, chơi mạng và mod cho 0 A.D.', 1, '2026-06-26 08:56:26'),
(10, 'game', 4, NULL, 'Thảo luận về SuperTuxKart', 'Mẹo đua, đường đua yêu thích, add-on và lịch đua online.', 1, '2026-06-26 08:56:26'),
(11, 'game', 5, NULL, 'Thảo luận về The Battle for Wesnoth', 'Chiến dịch, phe phái, chơi mạng và add-on.', 1, '2026-06-26 08:56:26'),
(12, 'game', 6, NULL, 'Thảo luận về Luanti', 'Game, mod, server và công trình xây dựng.', 1, '2026-06-26 08:56:26'),
(13, 'game', 7, NULL, 'Thảo luận về Mindustry', 'Sơ đồ dây chuyền, phòng thủ và bản đồ.', 1, '2026-06-26 08:56:26'),
(14, 'game', 8, NULL, 'Thảo luận về OpenTTD', 'Mạng lưới đường sắt, tín hiệu, NewGRF và chơi mạng.', 1, '2026-06-26 08:56:26'),
(15, 'game', 9, NULL, 'Thảo luận về Xonotic', 'Kỹ năng di chuyển, vũ khí, chế độ chơi và server.', 1, '2026-06-26 08:56:26'),
(16, 'game', 10, NULL, 'Thảo luận về Freeciv', 'Ruleset, chiến lược và các ván chơi nhiều người.', 1, '2026-06-26 08:56:26');

-- --------------------------------------------------------

--
-- Table structure for table `don_hang`
--

CREATE TABLE `don_hang` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `ma_don_hang` varchar(40) NOT NULL,
  `nguoi_mua_id` bigint(20) UNSIGNED NOT NULL,
  `trang_thai` enum('pending','paid','partially_refunded','refunded','cancelled','failed') NOT NULL DEFAULT 'pending',
  `ma_tien_te` char(3) NOT NULL,
  `tong_tien_hang` decimal(12,2) NOT NULL DEFAULT 0.00,
  `tong_tien_giam` decimal(12,2) NOT NULL DEFAULT 0.00,
  `tong_tien_thue` decimal(12,2) NOT NULL DEFAULT 0.00,
  `tong_thanh_toan` decimal(12,2) NOT NULL DEFAULT 0.00,
  `quoc_gia_thanh_toan` char(2) DEFAULT NULL,
  `ngay_dat_hang` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_thanh_toan` datetime DEFAULT NULL
) ;

--
-- Dumping data for table `don_hang`
--

INSERT INTO `don_hang` (`ma`, `ma_don_hang`, `nguoi_mua_id`, `trang_thai`, `ma_tien_te`, `tong_tien_hang`, `tong_tien_giam`, `tong_tien_thue`, `tong_thanh_toan`, `quoc_gia_thanh_toan`, `ngay_dat_hang`, `ngay_thanh_toan`) VALUES
(4, 'TEST-A54C2F1F9195', 5, 'paid', 'USD', 14.99, 0.00, 0.00, 14.99, NULL, '2026-11-04 01:23:23', '2026-11-04 08:23:23'),
(5, 'TEST-403198F4013F', 49, 'paid', 'USD', 32.98, 5.00, 0.00, 27.98, NULL, '2026-08-22 02:12:00', '2026-08-22 09:12:00'),
(6, 'TEST-15232AE15FF0', 34, 'paid', 'USD', 34.98, 0.00, 0.00, 34.98, NULL, '2026-08-22 03:52:00', '2026-08-22 10:52:00'),
(7, 'TEST-701CB4EE8A82', 45, 'paid', 'USD', 29.99, 0.00, 0.00, 29.99, NULL, '2026-08-26 05:16:00', '2026-08-26 12:16:00'),
(8, 'TEST-B26A39353045', 28, 'paid', 'USD', 59.97, 0.00, 0.00, 59.97, NULL, '2026-08-26 06:02:00', '2026-08-26 13:02:00'),
(9, 'TEST-DC19DA6D4D9D', 47, 'paid', 'USD', 24.99, 0.00, 0.00, 24.99, NULL, '2026-08-28 02:40:00', '2026-08-28 09:40:00'),
(10, 'TEST-8074F934A4F0', 33, 'paid', 'USD', 19.99, 2.00, 0.00, 17.99, NULL, '2026-08-28 11:05:00', '2026-08-28 18:05:00'),
(11, 'TEST-4F546AB2C9A9', 20, 'paid', 'USD', 9.99, 0.80, 0.00, 9.19, NULL, '2026-08-30 02:31:00', '2026-08-30 09:31:00'),
(12, 'TEST-20B38E0A0473', 43, 'paid', 'USD', 54.97, 8.25, 0.00, 46.72, NULL, '2026-08-30 11:22:00', '2026-08-30 18:22:00'),
(13, 'TEST-9C7570C765E3', 35, 'paid', 'USD', 14.99, 0.00, 0.00, 14.99, NULL, '2026-09-02 04:32:00', '2026-09-02 11:32:00'),
(14, 'TEST-C3C0D494A91A', 39, 'paid', 'USD', 19.99, 0.00, 0.00, 19.99, NULL, '2026-09-02 14:22:00', '2026-09-02 21:22:00'),
(15, 'TEST-163F6BAAC51A', 31, 'paid', 'USD', 14.99, 1.50, 0.00, 13.49, NULL, '2026-09-04 15:56:00', '2026-09-04 22:56:00'),
(16, 'TEST-CCF9C331AE14', 48, 'paid', 'USD', 19.99, 0.00, 0.00, 19.99, NULL, '2026-09-05 02:21:00', '2026-09-05 09:21:00'),
(17, 'TEST-EA2CBF5845DE', 22, 'paid', 'USD', 24.99, 0.00, 0.00, 24.99, NULL, '2026-09-05 02:52:00', '2026-09-05 09:52:00'),
(18, 'TEST-E08DE79BC6F7', 32, 'paid', 'USD', 14.99, 0.00, 0.00, 14.99, NULL, '2026-09-05 04:21:00', '2026-09-05 11:21:00'),
(19, 'TEST-3FA49BFF81FA', 24, 'paid', 'USD', 39.97, 0.00, 0.00, 39.97, NULL, '2026-09-05 13:24:00', '2026-09-05 20:24:00'),
(20, 'TEST-3CA49F1B03EE', 17, 'paid', 'USD', 14.99, 1.50, 0.00, 13.49, NULL, '2026-09-06 15:06:00', '2026-09-06 22:06:00'),
(21, 'TEST-79C3CF0F7559', 44, 'paid', 'USD', 39.98, 0.00, 0.00, 39.98, NULL, '2026-09-12 14:39:00', '2026-09-12 21:39:00'),
(22, 'TEST-BC6A8E4F486A', 27, 'paid', 'USD', 24.99, 0.00, 0.00, 24.99, NULL, '2026-09-13 01:49:00', '2026-09-13 08:49:00'),
(23, 'TEST-442DDF7BFA30', 30, 'paid', 'USD', 35.00, 5.00, 0.00, 30.00, NULL, '2026-09-16 07:15:00', '2026-09-16 14:15:00'),
(24, 'TEST-AE13B6F2C406', 26, 'paid', 'USD', 9.99, 0.00, 0.00, 9.99, NULL, '2026-09-16 08:11:00', '2026-09-16 15:11:00'),
(25, 'TEST-588B35767C4E', 40, 'paid', 'USD', 9.99, 1.20, 0.00, 8.79, NULL, '2026-09-16 08:20:00', '2026-09-16 15:20:00'),
(26, 'TEST-7D60B4A05564', 42, 'paid', 'USD', 9.99, 0.80, 0.00, 9.19, NULL, '2026-09-16 12:05:00', '2026-09-16 19:05:00'),
(27, 'TEST-2869D75CA107', 51, 'paid', 'USD', 39.98, 0.00, 0.00, 39.98, NULL, '2026-09-18 05:14:00', '2026-09-18 12:14:00'),
(28, 'TEST-6DAB542321DA', 21, 'paid', 'USD', 7.99, 1.20, 0.00, 6.79, NULL, '2026-09-20 07:55:00', '2026-09-20 14:55:00'),
(29, 'TEST-69E6A5569D14', 46, 'paid', 'USD', 44.98, 5.40, 0.00, 39.58, NULL, '2026-09-20 14:45:00', '2026-09-20 21:45:00'),
(30, 'TEST-FAAFFFEEB2BB', 48, 'paid', 'USD', 34.98, 8.75, 0.00, 26.23, NULL, '2026-10-08 02:04:00', '2026-10-08 09:04:00'),
(31, 'TEST-C55FAA61A370', 26, 'paid', 'USD', 34.99, 0.00, 0.00, 34.99, NULL, '2026-10-08 05:54:00', '2026-10-08 12:54:00'),
(32, 'TEST-340F097E72B6', 47, 'paid', 'USD', 9.99, 0.00, 0.00, 9.99, NULL, '2026-10-09 01:15:00', '2026-10-09 08:15:00'),
(33, 'TEST-B5232FC04BBA', 27, 'paid', 'USD', 34.98, 8.75, 0.00, 26.23, NULL, '2026-10-09 07:31:00', '2026-10-09 14:31:00'),
(34, 'TEST-4E0D9165ACBF', 25, 'paid', 'USD', 44.98, 11.25, 0.00, 33.73, NULL, '2026-10-10 12:47:00', '2026-10-10 19:47:00'),
(35, 'TEST-7E441CD6CCE3', 23, 'paid', 'USD', 29.99, 4.50, 0.00, 25.49, NULL, '2026-10-11 02:05:00', '2026-10-11 09:05:00'),
(36, 'TEST-45897287751E', 36, 'paid', 'USD', 39.98, 0.00, 0.00, 39.98, NULL, '2026-10-12 01:56:00', '2026-10-12 08:56:00'),
(37, 'TEST-DC610403FDA6', 35, 'paid', 'USD', 19.98, 1.60, 0.00, 18.38, NULL, '2026-10-12 07:30:00', '2026-10-12 14:30:00'),
(38, 'TEST-26DF54D188C7', 30, 'paid', 'USD', 59.98, 0.00, 0.00, 59.98, NULL, '2026-10-13 01:01:00', '2026-10-13 08:01:00'),
(39, 'TEST-D715B9A9DA00', 31, 'paid', 'USD', 19.99, 2.00, 0.00, 17.99, NULL, '2026-10-13 13:22:00', '2026-10-13 20:22:00'),
(40, 'TEST-0BAB76750B1C', 22, 'paid', 'USD', 24.99, 0.00, 0.00, 24.99, NULL, '2026-10-13 15:45:00', '2026-10-13 22:45:00'),
(41, 'TEST-74357BBA15CE', 39, 'paid', 'USD', 29.98, 5.00, 0.00, 24.98, NULL, '2026-10-13 15:52:00', '2026-10-13 22:52:00'),
(42, 'TEST-278120D86101', 50, 'paid', 'USD', 29.98, 0.00, 0.00, 29.98, NULL, '2026-10-14 12:09:00', '2026-10-14 19:09:00'),
(43, 'TEST-34DED12AD869', 19, 'paid', 'USD', 24.98, 0.00, 0.00, 24.98, NULL, '2026-10-14 14:42:00', '2026-10-14 21:42:00'),
(44, 'TEST-B0518C969421', 17, 'paid', 'USD', 59.99, 18.00, 0.00, 41.99, NULL, '2026-10-15 02:52:00', '2026-10-15 09:52:00'),
(45, 'TEST-47AA8C3A681B', 52, 'paid', 'USD', 34.98, 0.00, 0.00, 34.98, NULL, '2026-10-15 03:58:00', '2026-10-15 10:58:00'),
(46, 'TEST-A63FD2397BCF', 46, 'paid', 'USD', 4.99, 0.00, 0.00, 4.99, NULL, '2026-10-15 07:41:00', '2026-10-15 14:41:00'),
(47, 'TEST-C735CB504251', 29, 'paid', 'USD', 9.99, 0.00, 0.00, 9.99, NULL, '2026-10-15 10:38:00', '2026-10-15 17:38:00'),
(48, 'TEST-9BC508FE2DCA', 41, 'paid', 'USD', 24.99, 0.00, 0.00, 24.99, NULL, '2026-10-16 15:03:00', '2026-10-16 22:03:00'),
(49, 'TEST-7AC203C0EB5B', 20, 'paid', 'USD', 14.99, 0.00, 0.00, 14.99, NULL, '2026-10-17 15:29:00', '2026-10-17 22:29:00'),
(50, 'TEST-D6F5BD5C0ACF', 32, 'paid', 'USD', 14.99, 0.00, 0.00, 14.99, NULL, '2026-10-18 04:28:00', '2026-10-18 11:28:00'),
(51, 'TEST-C32168DE1B2B', 33, 'paid', 'USD', 9.99, 0.00, 0.00, 9.99, NULL, '2026-10-18 11:35:00', '2026-10-18 18:35:00'),
(52, 'TEST-9C02F96F0E6E', 49, 'paid', 'USD', 24.99, 7.50, 0.00, 17.49, NULL, '2026-10-18 13:18:00', '2026-10-18 20:18:00'),
(53, 'TEST-D957B7AA3C83', 21, 'paid', 'USD', 29.99, 0.00, 0.00, 29.99, NULL, '2026-10-18 14:14:00', '2026-10-18 21:14:00'),
(54, 'TEST-22A645FC79DE', 18, 'paid', 'USD', 62.99, 5.04, 0.00, 57.95, NULL, '2026-10-17 11:50:00', '2026-10-17 18:50:00'),
(55, 'TEST-5B3B91B0AB2A', 26, 'paid', 'USD', 19.99, 0.00, 0.00, 19.99, NULL, '2026-10-16 03:15:00', '2026-10-16 10:15:00'),
(56, 'TEST-3A54B25CFD64', 30, 'paid', 'USD', 23.99, 0.00, 0.00, 23.99, NULL, '2026-10-15 04:50:00', '2026-10-15 11:50:00'),
(57, 'TEST-7A38CFEC0C34', 24, 'paid', 'USD', 54.99, 0.00, 0.00, 54.99, NULL, '2026-10-14 13:44:00', '2026-10-14 20:44:00'),
(58, 'TEST-D3B995A674F2', 27, 'paid', 'USD', 47.99, 0.00, 0.00, 47.99, NULL, '2026-10-13 11:47:00', '2026-10-13 18:47:00'),
(59, 'TEST-935F7BB7E2FA', 46, 'paid', 'USD', 9.99, 0.00, 0.00, 9.99, NULL, '2026-10-22 03:42:00', '2026-10-22 10:42:00'),
(60, 'TEST-81240C0ABA1A', 36, 'paid', 'USD', 29.99, 0.00, 0.00, 29.99, NULL, '2026-10-22 06:25:00', '2026-10-22 13:25:00'),
(61, 'TEST-E5B84A8D7D69', 27, 'refunded', 'USD', 19.99, 0.00, 0.00, 19.99, NULL, '2026-10-22 06:35:00', '2026-10-22 13:35:00'),
(62, 'TEST-E094ACD55D53', 25, 'refunded', 'USD', 9.99, 1.20, 0.00, 8.79, NULL, '2026-10-22 13:15:00', '2026-10-22 20:15:00'),
(63, 'TEST-545831BD7452', 33, 'paid', 'USD', 9.99, 0.00, 0.00, 9.99, NULL, '2026-10-22 15:05:00', '2026-10-22 22:05:00'),
(64, 'TEST-566871911BC1', 45, 'paid', 'USD', 24.99, 3.75, 0.00, 21.24, NULL, '2026-10-23 03:58:00', '2026-10-23 10:58:00'),
(65, 'TEST-AC432DB75900', 18, 'paid', 'USD', 9.99, 0.00, 0.00, 9.99, NULL, '2026-10-23 11:54:00', '2026-10-23 18:54:00'),
(66, 'TEST-1C630924FCA2', 48, 'refunded', 'USD', 9.99, 0.00, 0.00, 9.99, NULL, '2026-10-23 12:15:00', '2026-10-23 19:15:00'),
(67, 'TEST-17C0CA82206A', 32, 'refunded', 'USD', 34.99, 3.00, 0.00, 31.99, NULL, '2026-10-23 15:50:00', '2026-10-23 22:50:00'),
(68, 'TEST-4E48CF53E611', 19, 'paid', 'USD', 19.99, 3.00, 0.00, 16.99, NULL, '2026-10-24 02:51:00', '2026-10-24 09:51:00'),
(69, 'TEST-9E7F2F2CBD76', 20, 'paid', 'USD', 24.99, 0.00, 0.00, 24.99, NULL, '2026-10-24 08:25:00', '2026-10-24 15:25:00'),
(70, 'TEST-75325E4B5476', 44, 'paid', 'USD', 35.00, 0.00, 0.00, 35.00, NULL, '2026-10-24 12:45:00', '2026-10-24 19:45:00'),
(71, 'TEST-84A3240FEE79', 52, 'refunded', 'USD', 14.99, 0.00, 0.00, 14.99, NULL, '2026-10-24 14:00:00', '2026-10-24 21:00:00'),
(72, 'TEST-72A5820BFE86', 39, 'refunded', 'USD', 14.99, 1.50, 0.00, 13.49, NULL, '2026-10-25 01:55:00', '2026-10-25 08:55:00'),
(73, 'TEST-9B35C1594825', 38, 'paid', 'USD', 9.99, 2.00, 0.00, 7.99, NULL, '2026-10-26 01:23:00', '2026-10-26 08:23:00'),
(74, 'TEST-4D44B7171F33', 35, 'paid', 'USD', 34.99, 0.00, 0.00, 34.99, NULL, '2026-10-26 02:44:00', '2026-10-26 09:44:00'),
(75, 'TEST-2925E9816954', 23, 'paid', 'USD', 24.99, 0.00, 0.00, 24.99, NULL, '2026-10-26 06:32:00', '2026-10-26 13:32:00'),
(76, 'TEST-D1E206841E69', 26, 'refunded', 'USD', 14.99, 0.00, 0.00, 14.99, NULL, '2026-10-26 10:38:00', '2026-10-26 17:38:00'),
(77, 'TEST-6E95E2F92B0C', 40, 'refunded', 'USD', 24.99, 0.00, 0.00, 24.99, NULL, '2026-10-27 01:20:00', '2026-10-27 08:20:00'),
(78, 'TEST-379F8BC8930B', 21, 'paid', 'USD', 14.99, 0.00, 0.00, 14.99, NULL, '2026-10-27 05:40:00', '2026-10-27 12:40:00'),
(79, 'TEST-4B9F4A75C22E', 29, 'paid', 'USD', 14.99, 1.20, 0.00, 13.79, NULL, '2026-10-27 05:46:00', '2026-10-27 12:46:00'),
(80, 'TEST-9113E62B6B92', 49, 'paid', 'USD', 24.99, 0.00, 0.00, 24.99, NULL, '2026-10-27 07:11:00', '2026-10-27 14:11:00'),
(81, 'TEST-0C046C421DD9', 24, 'refunded', 'USD', 19.99, 3.00, 0.00, 16.99, NULL, '2026-10-28 02:58:00', '2026-10-28 09:58:00'),
(82, 'TEST-DA1E8BAFD4EA', 30, 'refunded', 'USD', 14.99, 2.25, 0.00, 12.74, NULL, '2026-10-28 03:24:00', '2026-10-28 10:24:00'),
(83, 'TEST-4C1E1D9A79E5', 41, 'paid', 'USD', 14.99, 0.00, 0.00, 14.99, NULL, '2026-10-28 03:29:00', '2026-10-28 10:29:00'),
(84, 'TEST-10B7A0274171', 22, 'paid', 'USD', 24.99, 0.00, 0.00, 24.99, NULL, '2026-10-28 05:47:00', '2026-10-28 12:47:00'),
(85, 'TEST-3B7934820A77', 47, 'paid', 'USD', 34.99, 0.00, 0.00, 34.99, NULL, '2026-10-28 07:15:00', '2026-10-28 14:15:00'),
(86, 'TEST-755869458CA7', 42, 'refunded', 'USD', 24.99, 2.00, 0.00, 22.99, NULL, '2026-10-29 02:07:00', '2026-10-29 09:07:00'),
(87, 'TEST-A9746BD2C93F', 51, 'refunded', 'USD', 9.99, 0.00, 0.00, 9.99, NULL, '2026-10-29 11:46:00', '2026-10-29 18:46:00'),
(88, 'TEST-CE6BB1FDB1FD', 34, 'paid', 'USD', 24.99, 0.00, 0.00, 24.99, NULL, '2026-10-29 13:22:00', '2026-10-29 20:22:00'),
(89, 'TEST-6F50FF8A9CC8', 31, 'paid', 'USD', 35.00, 0.00, 0.00, 35.00, NULL, '2026-10-30 02:51:00', '2026-10-30 09:51:00'),
(90, 'TEST-DEBE6C95D5F4', 17, 'paid', 'USD', 14.99, 0.00, 0.00, 14.99, NULL, '2026-10-30 12:04:00', '2026-10-30 19:04:00'),
(91, 'TEST-670C668C7015', 50, 'paid', 'USD', 7.99, 0.00, 0.00, 7.99, NULL, '2026-10-31 03:35:00', '2026-10-31 10:35:00'),
(92, 'TEST-7A0354B95C67', 28, 'paid', 'USD', 14.99, 1.20, 0.00, 13.79, NULL, '2026-10-31 12:31:00', '2026-10-31 19:31:00'),
(93, 'TEST-50DDC9114D8A', 37, 'paid', 'USD', 29.99, 0.00, 0.00, 29.99, NULL, '2026-11-01 07:10:00', '2026-11-01 14:10:00'),
(94, 'TEST-6085467203FE', 43, 'paid', 'USD', 24.99, 2.00, 0.00, 22.99, NULL, '2026-11-01 10:51:00', '2026-11-01 17:51:00');

-- --------------------------------------------------------

--
-- Table structure for table `dot_chi_tra`
--

CREATE TABLE `dot_chi_tra` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `tai_khoan_nhan_tien_id` bigint(20) UNSIGNED NOT NULL,
  `so_tien` decimal(12,2) NOT NULL,
  `ma_tien_te` char(3) NOT NULL,
  `trang_thai` enum('requested','processing','paid','failed','cancelled') NOT NULL DEFAULT 'requested',
  `ma_chi_tra_nha_cung_cap` varchar(190) DEFAULT NULL,
  `ngay_yeu_cau` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_xu_ly` datetime DEFAULT NULL,
  `ly_do_that_bai` varchar(1000) DEFAULT NULL
) ;

--
-- Dumping data for table `dot_chi_tra`
--

INSERT INTO `dot_chi_tra` (`ma`, `nguoi_dung_id`, `tai_khoan_nhan_tien_id`, `so_tien`, `ma_tien_te`, `trang_thai`, `ma_chi_tra_nha_cung_cap`, `ngay_yeu_cau`, `ngay_xu_ly`, `ly_do_that_bai`) VALUES
(4, 53, 3, 13.49, 'USD', 'paid', 'SANDBOX-PAYOUT-4CA271C632', '2026-10-05 06:09:34', '2026-10-07 13:09:34', NULL),
(5, 54, 4, 13.49, 'USD', 'paid', 'SANDBOX-PAYOUT-F55B2923BF', '2026-10-05 02:28:15', '2026-10-07 09:28:15', NULL),
(6, 55, 5, 15.29, 'USD', 'paid', 'SANDBOX-PAYOUT-8DD51260D0', '2026-10-05 09:50:01', '2026-10-07 16:50:01', NULL),
(7, 56, 6, 44.98, 'USD', 'failed', NULL, '2026-10-05 09:48:13', '2026-10-07 16:48:13', 'Ngân hàng từ chối: tên chủ tài khoản không khớp (tài khoản minh họa).'),
(8, 57, 7, 22.49, 'USD', 'paid', 'SANDBOX-PAYOUT-AE1377C61A', '2026-10-05 04:31:39', '2026-10-07 11:31:39', NULL),
(9, 58, 8, 44.98, 'USD', 'paid', 'SANDBOX-PAYOUT-2570E4A946', '2026-10-05 10:14:09', '2026-10-07 17:14:09', NULL),
(10, 59, 9, 8.99, 'USD', 'paid', 'SANDBOX-PAYOUT-CBA4E75E01', '2026-10-05 09:28:14', '2026-10-07 16:28:14', NULL),
(11, 60, 10, 12.21, 'USD', 'paid', 'SANDBOX-PAYOUT-8C751F0155', '2026-10-05 05:56:01', '2026-10-07 12:56:01', NULL),
(12, 61, 11, 4.49, 'USD', 'paid', 'SANDBOX-PAYOUT-CB2D292CC8', '2026-10-05 10:29:02', '2026-10-07 17:29:02', NULL),
(13, 62, 12, 34.18, 'USD', 'paid', 'SANDBOX-PAYOUT-DFD242E693', '2026-10-05 06:43:24', '2026-10-07 13:43:24', NULL),
(14, 63, 13, 33.28, 'USD', 'paid', 'SANDBOX-PAYOUT-46D8243CC2', '2026-10-05 10:39:01', '2026-10-07 17:39:01', NULL),
(15, 65, 15, 11.87, 'USD', 'failed', NULL, '2026-10-05 05:09:33', '2026-10-07 12:09:33', 'Ngân hàng từ chối: tên chủ tài khoản không khớp (tài khoản minh họa).'),
(16, 66, 16, 22.49, 'USD', 'paid', 'SANDBOX-PAYOUT-6E1D036C75', '2026-10-05 07:08:14', '2026-10-07 14:08:14', NULL),
(17, 67, 17, 21.76, 'USD', 'paid', 'SANDBOX-PAYOUT-E7467A047A', '2026-10-05 10:47:42', '2026-10-07 17:47:42', NULL),
(18, 68, 18, 17.26, 'USD', 'paid', 'SANDBOX-PAYOUT-3575C92939', '2026-10-05 05:16:58', '2026-10-07 12:16:58', NULL),
(19, 69, 19, 26.98, 'USD', 'paid', 'SANDBOX-PAYOUT-E5F61F80DD', '2026-10-05 08:26:32', '2026-10-07 15:26:32', NULL),
(20, 71, 21, 17.99, 'USD', 'paid', 'SANDBOX-PAYOUT-B989C10291', '2026-10-05 09:01:17', '2026-10-07 16:01:17', NULL),
(21, 74, 24, 7.91, 'USD', 'paid', 'SANDBOX-PAYOUT-E5FCA79269', '2026-10-05 02:44:44', '2026-10-07 09:44:44', NULL),
(22, 75, 25, 27.00, 'USD', 'paid', 'SANDBOX-PAYOUT-8A758783CC', '2026-10-05 03:32:19', '2026-10-07 10:32:19', NULL),
(23, 76, 26, 25.63, 'USD', 'paid', 'SANDBOX-PAYOUT-042CA5C8B3', '2026-10-05 02:43:05', '2026-10-07 09:43:05', NULL),
(24, 77, 27, 17.99, 'USD', 'paid', 'SANDBOX-PAYOUT-74A41AD274', '2026-10-05 10:44:21', '2026-10-07 17:44:21', NULL),
(25, 78, 28, 26.99, 'USD', 'paid', 'SANDBOX-PAYOUT-8A29F75BC1', '2026-10-05 06:25:59', '2026-10-07 13:25:59', NULL),
(26, 79, 29, 23.61, 'USD', 'paid', 'SANDBOX-PAYOUT-C1F42CE20C', '2026-10-05 10:01:27', '2026-10-07 17:01:27', NULL),
(27, 80, 30, 41.57, 'USD', 'paid', 'SANDBOX-PAYOUT-B1E0D7DEDD', '2026-10-05 10:43:44', '2026-10-07 17:43:44', NULL),
(28, 81, 31, 23.75, 'USD', 'paid', 'SANDBOX-PAYOUT-956CD16E3A', '2026-10-05 10:47:24', '2026-10-07 17:47:24', NULL),
(29, 53, 3, 20.24, 'USD', 'paid', 'SANDBOX-PAYOUT-487BCED3EB', '2026-11-03 04:30:19', '2026-11-03 17:30:19', NULL),
(30, 54, 4, 31.75, 'USD', 'processing', NULL, '2026-11-03 04:54:41', NULL, NULL),
(31, 55, 5, 26.99, 'USD', 'requested', NULL, '2026-11-03 10:06:11', NULL, NULL),
(32, 56, 6, 79.89, 'USD', 'requested', NULL, '2026-11-03 08:26:04', NULL, NULL),
(33, 57, 7, 34.91, 'USD', 'paid', 'SANDBOX-PAYOUT-E700F416F8', '2026-11-03 06:19:42', '2026-11-03 19:19:42', NULL),
(34, 58, 8, 29.29, 'USD', 'processing', NULL, '2026-11-03 07:06:40', NULL, NULL),
(35, 59, 9, 17.98, 'USD', 'requested', NULL, '2026-11-03 03:50:00', NULL, NULL),
(36, 61, 11, 8.62, 'USD', 'requested', NULL, '2026-11-03 04:05:33', NULL, NULL),
(37, 62, 12, 39.57, 'USD', 'paid', 'SANDBOX-PAYOUT-311E2B199B', '2026-11-03 09:55:59', '2026-11-03 22:55:59', NULL),
(38, 64, 14, 26.98, 'USD', 'processing', NULL, '2026-11-03 10:02:30', NULL, NULL),
(39, 65, 15, 32.80, 'USD', 'requested', NULL, '2026-11-03 02:40:23', NULL, NULL),
(40, 66, 16, 15.74, 'USD', 'requested', NULL, '2026-11-03 07:49:55', NULL, NULL),
(41, 67, 17, 45.86, 'USD', 'paid', 'SANDBOX-PAYOUT-66F8B2C511', '2026-11-03 04:34:57', '2026-11-03 17:34:57', NULL),
(42, 68, 18, 38.23, 'USD', 'processing', NULL, '2026-11-03 06:20:59', NULL, NULL),
(43, 69, 19, 13.49, 'USD', 'requested', NULL, '2026-11-03 10:18:48', NULL, NULL),
(44, 70, 20, 58.48, 'USD', 'requested', NULL, '2026-11-03 02:37:47', NULL, NULL),
(45, 71, 21, 17.99, 'USD', 'paid', 'SANDBOX-PAYOUT-73D49A1AFF', '2026-11-03 06:09:13', '2026-11-03 19:09:13', NULL),
(46, 72, 22, 62.98, 'USD', 'processing', NULL, '2026-11-03 05:08:23', NULL, NULL),
(47, 73, 23, 32.18, 'USD', 'requested', NULL, '2026-11-03 02:54:33', NULL, NULL),
(48, 74, 24, 20.21, 'USD', 'requested', NULL, '2026-11-03 09:56:41', NULL, NULL),
(49, 75, 25, 22.05, 'USD', 'paid', 'SANDBOX-PAYOUT-A2C216FDB0', '2026-11-03 06:59:49', '2026-11-03 19:59:49', NULL),
(50, 77, 27, 25.14, 'USD', 'processing', NULL, '2026-11-03 04:03:02', NULL, NULL),
(51, 78, 28, 22.94, 'USD', 'requested', NULL, '2026-11-03 07:31:19', NULL, NULL),
(52, 80, 30, 14.55, 'USD', 'requested', NULL, '2026-11-03 09:02:12', NULL, NULL),
(53, 81, 31, 44.46, 'USD', 'paid', 'SANDBOX-PAYOUT-F7464281DA', '2026-11-03 06:26:52', '2026-11-03 19:26:52', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `gio_hang`
--

CREATE TABLE `gio_hang` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `trang_thai` enum('active','checked_out','abandoned') NOT NULL DEFAULT 'active',
  `ma_tien_te` char(3) NOT NULL DEFAULT 'USD',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gio_hang`
--

INSERT INTO `gio_hang` (`ma`, `nguoi_dung_id`, `trang_thai`, `ma_tien_te`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(3, 5, 'checked_out', 'USD', '2026-11-03 07:34:04', '2026-11-04 01:23:23'),
(4, 6, 'active', 'USD', '2026-11-03 12:34:23', '2026-11-03 12:34:24'),
(5, 49, 'active', 'USD', '2026-08-22 02:12:00', '2026-11-04 02:27:45'),
(6, 34, 'checked_out', 'USD', '2026-08-22 03:52:00', '2026-10-29 13:22:00'),
(7, 45, 'active', 'USD', '2026-08-26 05:16:00', '2026-11-04 02:27:45'),
(8, 28, 'checked_out', 'USD', '2026-08-26 06:02:00', '2026-10-31 12:31:00'),
(9, 47, 'active', 'USD', '2026-08-28 02:40:00', '2026-11-04 02:27:45'),
(10, 33, 'checked_out', 'USD', '2026-08-28 11:05:00', '2026-10-22 15:05:00'),
(11, 20, 'checked_out', 'USD', '2026-08-30 02:31:00', '2026-10-24 08:25:00'),
(12, 43, 'active', 'USD', '2026-08-30 11:22:00', '2026-11-04 02:27:45'),
(13, 35, 'checked_out', 'USD', '2026-09-02 04:32:00', '2026-10-26 02:44:00'),
(14, 39, 'active', 'USD', '2026-09-02 14:22:00', '2026-11-04 02:27:45'),
(15, 31, 'checked_out', 'USD', '2026-09-04 15:56:00', '2026-10-30 02:51:00'),
(16, 48, 'active', 'USD', '2026-09-05 02:21:00', '2026-11-04 02:27:45'),
(17, 22, 'checked_out', 'USD', '2026-09-05 02:52:00', '2026-10-28 05:47:00'),
(18, 32, 'checked_out', 'USD', '2026-09-05 04:21:00', '2026-10-23 15:50:00'),
(19, 24, 'checked_out', 'USD', '2026-09-05 13:24:00', '2026-10-28 02:58:00'),
(20, 17, 'checked_out', 'USD', '2026-09-06 15:06:00', '2026-10-30 12:04:00'),
(21, 44, 'active', 'USD', '2026-09-12 14:39:00', '2026-11-04 02:27:45'),
(22, 27, 'checked_out', 'USD', '2026-09-13 01:49:00', '2026-10-22 06:35:00'),
(23, 30, 'checked_out', 'USD', '2026-09-16 07:15:00', '2026-10-28 03:24:00'),
(24, 26, 'checked_out', 'USD', '2026-09-16 08:11:00', '2026-10-26 10:38:00'),
(25, 40, 'active', 'USD', '2026-09-16 08:20:00', '2026-11-04 02:27:45'),
(26, 42, 'active', 'USD', '2026-09-16 12:05:00', '2026-11-04 02:27:45'),
(27, 51, 'checked_out', 'USD', '2026-09-18 05:14:00', '2026-10-29 11:46:00'),
(28, 21, 'checked_out', 'USD', '2026-09-20 07:55:00', '2026-10-27 05:40:00'),
(29, 46, 'active', 'USD', '2026-09-20 14:45:00', '2026-11-04 02:27:45'),
(30, 25, 'checked_out', 'USD', '2026-10-10 12:47:00', '2026-10-22 13:15:00'),
(31, 23, 'checked_out', 'USD', '2026-10-11 02:05:00', '2026-10-26 06:32:00'),
(32, 36, 'active', 'USD', '2026-10-12 01:56:00', '2026-11-04 02:27:45'),
(33, 50, 'active', 'USD', '2026-10-14 12:09:00', '2026-11-04 02:27:45'),
(34, 19, 'checked_out', 'USD', '2026-10-14 14:42:00', '2026-10-24 02:51:00'),
(35, 52, 'checked_out', 'USD', '2026-10-15 03:58:00', '2026-10-24 14:00:00'),
(36, 29, 'checked_out', 'USD', '2026-10-15 10:38:00', '2026-10-27 05:46:00'),
(37, 41, 'active', 'USD', '2026-10-16 15:03:00', '2026-11-04 02:27:45'),
(38, 18, 'checked_out', 'USD', '2026-10-17 11:50:00', '2026-10-23 11:54:00'),
(39, 38, 'active', 'USD', '2026-10-26 01:23:00', '2026-11-04 02:27:45'),
(40, 37, 'active', 'USD', '2026-11-01 07:10:00', '2026-11-04 02:27:45');

-- --------------------------------------------------------

--
-- Table structure for table `goi_game`
--

CREATE TABLE `goi_game` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `nguoi_tao_id` bigint(20) UNSIGNED NOT NULL,
  `tieu_de` varchar(200) NOT NULL,
  `duong_dan_rut_gon` varchar(220) NOT NULL,
  `mo_ta` mediumtext DEFAULT NULL,
  `loai_goi_game` enum('creator_created','platform_curated') NOT NULL DEFAULT 'creator_created',
  `gia` decimal(12,2) NOT NULL DEFAULT 0.00,
  `ma_tien_te` char(3) NOT NULL DEFAULT 'USD',
  `trang_thai` enum('draft','published','hidden','ended') NOT NULL DEFAULT 'draft',
  `ngay_bat_dau` datetime DEFAULT NULL,
  `ngay_ket_thuc` datetime DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

--
-- Dumping data for table `goi_game`
--

INSERT INTO `goi_game` (`ma`, `nguoi_tao_id`, `tieu_de`, `duong_dan_rut_gon`, `mo_ta`, `loai_goi_game`, `gia`, `ma_tien_te`, `trang_thai`, `ngay_bat_dau`, `ngay_ket_thuc`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(1, 6, 'Tuyển tập chiến thuật mã nguồn mở', 'tuyen-tap-chien-thuat-ma-nguon-mo', 'Năm trò chơi chiến thuật và mô phỏng miễn phí, mã nguồn mở do nền tảng tuyển chọn. Thêm gói vào thư viện để nhận cả năm trò chơi.', 'platform_curated', 0.00, 'USD', 'published', NULL, NULL, '2026-11-03 08:23:05', '2026-11-03 08:23:05'),
(4, 6, 'Roguelike tuyển chọn', 'roguelike-tuyen-chon', 'Gói 5 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 62.99, 'USD', 'published', '2026-08-01 00:00:00', NULL, '2026-07-24 17:00:00', '2026-07-24 17:00:00'),
(5, 6, 'Thẻ bài chiến thuật', 'the-bai-chien-thuat', 'Gói 3 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 41.99, 'USD', 'published', '2026-08-01 00:00:00', NULL, '2026-07-24 17:00:00', '2026-07-24 17:00:00'),
(6, 6, 'Đồng quê và phiêu lưu nhẹ nhàng', 'dong-que-va-phieu-luu-nhe-nhang', 'Gói 3 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 39.99, 'USD', 'published', '2026-08-01 00:00:00', NULL, '2026-07-24 17:00:00', '2026-07-24 17:00:00'),
(7, 6, 'Platformer thử thách', 'platformer-thu-thach', 'Gói 4 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 44.99, 'USD', 'published', '2026-08-01 00:00:00', NULL, '2026-07-24 17:00:00', '2026-07-24 17:00:00'),
(8, 6, 'Trọn bộ Subset Games', 'tron-bo-subset-games', 'Gói 2 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 19.99, 'USD', 'published', '2026-08-01 00:00:00', NULL, '2026-07-24 17:00:00', '2026-07-24 17:00:00'),
(9, 6, 'Trọn bộ Lucas Pope', 'tron-bo-lucas-pope', 'Gói 2 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 23.99, 'USD', 'published', '2026-08-01 00:00:00', NULL, '2026-07-24 17:00:00', '2026-07-24 17:00:00'),
(10, 6, 'Trọn bộ Klei', 'tron-bo-klei', 'Gói 2 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 25.99, 'USD', 'published', '2026-08-01 00:00:00', NULL, '2026-07-24 17:00:00', '2026-07-24 17:00:00'),
(11, 6, 'Xây dựng và tự động hóa', 'xay-dung-va-tu-dong-hoa', 'Gói 3 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 75.99, 'USD', 'published', '2026-08-01 00:00:00', NULL, '2026-07-24 17:00:00', '2026-07-24 17:00:00'),
(12, 6, 'Giải đố', 'giai-do', 'Gói 3 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 30.99, 'USD', 'published', '2026-08-15 00:00:00', NULL, '2026-08-07 17:00:00', '2026-08-07 17:00:00'),
(13, 6, 'Câu chuyện đáng nhớ', 'cau-chuyen-dang-nho', 'Gói 4 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 54.99, 'USD', 'published', '2026-08-15 00:00:00', NULL, '2026-08-07 17:00:00', '2026-08-07 17:00:00'),
(14, 6, 'Hành động tốc độ', 'hanh-dong-toc-do', 'Gói 4 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 47.99, 'USD', 'published', '2026-08-15 00:00:00', NULL, '2026-08-07 17:00:00', '2026-08-07 17:00:00'),
(15, 6, 'Sinh tồn', 'sinh-ton', 'Gói 3 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 40.99, 'USD', 'published', '2026-08-15 00:00:00', NULL, '2026-08-07 17:00:00', '2026-08-07 17:00:00'),
(16, 6, 'Khám phá vũ trụ', 'kham-pha-vu-tru', 'Gói 2 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 27.99, 'USD', 'published', '2026-09-01 00:00:00', NULL, '2026-08-24 17:00:00', '2026-08-24 17:00:00'),
(17, 6, 'Bóng tối và bí ẩn', 'bong-toi-va-bi-an', 'Gói 3 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 48.99, 'USD', 'published', '2026-09-01 00:00:00', '2026-12-31 23:59:00', '2026-08-24 17:00:00', '2026-08-24 17:00:00'),
(18, 6, 'Game nhỏ, ấn tượng lớn', 'game-nho-an-tuong-lon', 'Gói 4 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 31.99, 'USD', 'published', '2026-09-01 00:00:00', NULL, '2026-08-24 17:00:00', '2026-08-24 17:00:00'),
(19, 6, 'Dưới 10 USD', 'duoi-10-usd', 'Gói 7 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 37.99, 'USD', 'published', '2026-09-01 00:00:00', NULL, '2026-08-24 17:00:00', '2026-08-24 17:00:00'),
(20, 6, 'Phiêu lưu 2D', 'phieu-luu-2d', 'Gói 4 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 54.99, 'USD', 'published', '2026-09-15 00:00:00', NULL, '2026-09-07 17:00:00', '2026-09-07 17:00:00'),
(21, 6, 'Chiến thuật theo lượt', 'chien-thuat-theo-luot', 'Gói 3 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 44.99, 'USD', 'published', '2026-09-15 00:00:00', NULL, '2026-09-07 17:00:00', '2026-09-07 17:00:00'),
(22, 6, 'Miễn phí: chiến thuật mã nguồn mở', 'mien-phi-chien-thuat-ma-nguon-mo', 'Gói 5 trò chơi miễn phí do nền tảng tuyển chọn để bạn nhận một lần vào thư viện.', 'platform_curated', 0.00, 'USD', 'published', NULL, NULL, '2026-08-01 02:00:00', '2026-08-01 02:00:00'),
(23, 6, 'Miễn phí: đua xe và bắn súng mã nguồn mở', 'mien-phi-dua-xe-va-ban-sung-ma-nguon-mo', 'Gói 3 trò chơi miễn phí do nền tảng tuyển chọn để bạn nhận một lần vào thư viện.', 'platform_curated', 0.00, 'USD', 'published', NULL, NULL, '2026-08-01 02:00:00', '2026-08-01 02:00:00'),
(24, 6, 'Miễn phí: thế giới mở và không gian', 'mien-phi-the-gioi-mo-va-khong-gian', 'Gói 3 trò chơi miễn phí do nền tảng tuyển chọn để bạn nhận một lần vào thư viện.', 'platform_curated', 0.00, 'USD', 'published', NULL, NULL, '2026-08-01 02:00:00', '2026-08-01 02:00:00'),
(25, 6, 'Miễn phí: chơi cùng bạn bè', 'mien-phi-choi-cung-ban-be', 'Gói 3 trò chơi miễn phí do nền tảng tuyển chọn để bạn nhận một lần vào thư viện.', 'platform_curated', 0.00, 'USD', 'published', NULL, NULL, '2026-08-01 02:00:00', '2026-08-01 02:00:00'),
(26, 6, 'Indie thập niên 2010', 'indie-thap-nien-2010', 'Gói 5 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 47.99, 'USD', 'published', '2026-10-01 00:00:00', NULL, '2026-09-23 17:00:00', '2026-09-23 17:00:00'),
(27, 6, 'Indie thập niên 2020', 'indie-thap-nien-2020', 'Gói 5 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 74.99, 'USD', 'published', '2026-10-01 00:00:00', NULL, '2026-09-23 17:00:00', '2026-09-23 17:00:00'),
(28, 6, 'Thư giãn cuối tuần', 'thu-gian-cuoi-tuan', 'Gói 4 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 50.99, 'USD', 'published', '2026-10-01 00:00:00', '2026-11-30 23:59:00', '2026-09-23 17:00:00', '2026-09-23 17:00:00'),
(29, 6, 'Mùa hè 2026', 'mua-he-2026', 'Gói 4 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 40.99, 'USD', 'ended', '2026-06-20 00:00:00', '2026-07-10 23:59:00', '2026-06-12 17:00:00', '2026-06-12 17:00:00'),
(30, 6, 'Tết 2026', 'tet-2026', 'Gói 3 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 23.99, 'USD', 'ended', '2026-02-10 00:00:00', '2026-02-24 23:59:00', '2026-02-02 17:00:00', '2026-02-02 17:00:00'),
(31, 6, 'Cuối năm 2026', 'cuoi-nam-2026', 'Gói 3 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 65.99, 'USD', 'draft', '2026-12-26 00:00:00', '2027-01-05 23:59:00', '2026-12-18 17:00:00', '2026-12-18 17:00:00'),
(32, 6, 'Hành trình cảm xúc', 'hanh-trinh-cam-xuc', 'Gói 3 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 38.99, 'USD', 'hidden', NULL, NULL, '2026-08-01 02:00:00', '2026-08-01 02:00:00'),
(33, 6, 'Giáng sinh 2026', 'giang-sinh-2026', 'Gói 3 trò chơi do nền tảng tuyển chọn. Mua cả gói rẻ hơn mua lẻ từng trò chơi.', 'platform_curated', 35.99, 'USD', 'published', '2026-12-18 00:00:00', '2027-01-03 23:59:00', '2026-12-10 17:00:00', '2026-12-10 17:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `hanh_dong_kiem_duyet`
--

CREATE TABLE `hanh_dong_kiem_duyet` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `nguoi_kiem_duyet_id` bigint(20) UNSIGNED NOT NULL,
  `loai_doi_tuong` enum('user','game','review','game_comment','devlog','community_topic','community_post') NOT NULL,
  `doi_tuong_id` bigint(20) UNSIGNED NOT NULL,
  `loai_hanh_dong` enum('warning','hide','remove','suspend','restore','other') NOT NULL,
  `ly_do` text DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hanh_dong_kiem_duyet`
--

INSERT INTO `hanh_dong_kiem_duyet` (`ma`, `nguoi_kiem_duyet_id`, `loai_doi_tuong`, `doi_tuong_id`, `loai_hanh_dong`, `ly_do`, `ngay_tao`) VALUES
(1, 6, 'user', 7, 'suspend', 'Kiểm thử chức năng đình chỉ (tài khoản thử)', '2026-11-03 08:53:47'),
(2, 6, 'user', 7, 'restore', 'Kết thúc kiểm thử', '2026-11-03 08:53:48'),
(5, 6, 'user', 7, 'suspend', 'Kiểm thử phiên đang mở', '2026-11-03 08:54:04'),
(6, 6, 'user', 7, 'restore', 'Kết thúc kiểm thử', '2026-11-03 08:54:04'),
(9, 7, 'review', 51, 'warning', 'Đã nhắc nhở tác giả về quy định cộng đồng.', '2026-10-30 17:59:32'),
(10, 7, 'review', 51, 'other', 'Đã gửi thông báo nhắc nhở cho tác giả.', '2026-10-30 18:09:32'),
(11, 7, 'review', 87, 'warning', 'Đã nhắc nhở tác giả về quy định cộng đồng.', '2026-10-24 16:13:05'),
(12, 7, 'review', 87, 'other', 'Đã gửi thông báo nhắc nhở cho tác giả.', '2026-10-24 16:23:05'),
(13, 7, 'review', 14, 'warning', 'Đã nhắc nhở tác giả về quy định cộng đồng.', '2026-10-11 20:08:31'),
(14, 7, 'review', 14, 'other', 'Đã gửi thông báo nhắc nhở cho tác giả.', '2026-10-11 20:18:31'),
(15, 7, 'review', 114, 'warning', 'Đã nhắc nhở tác giả về quy định cộng đồng.', '2026-10-18 01:18:28'),
(16, 7, 'review', 114, 'other', 'Đã gửi thông báo nhắc nhở cho tác giả.', '2026-10-18 01:28:28'),
(17, 7, 'review', 102, 'warning', 'Đã nhắc nhở tác giả về quy định cộng đồng.', '2026-10-29 20:25:06'),
(18, 7, 'review', 102, 'other', 'Đã gửi thông báo nhắc nhở cho tác giả.', '2026-10-29 20:35:06'),
(19, 7, 'review', 46, 'warning', 'Đã nhắc nhở tác giả về quy định cộng đồng.', '2026-10-25 23:49:28'),
(20, 7, 'review', 13, 'warning', 'Đã nhắc nhở tác giả về quy định cộng đồng.', '2026-10-29 01:47:11'),
(21, 7, 'review', 93, 'warning', 'Đã nhắc nhở tác giả về quy định cộng đồng.', '2026-10-19 20:01:07'),
(22, 7, 'review', 38, 'warning', 'Đã nhắc nhở tác giả về quy định cộng đồng.', '2026-10-16 20:23:38'),
(23, 7, 'review', 10, 'warning', 'Đã nhắc nhở tác giả về quy định cộng đồng.', '2026-10-22 19:22:11'),
(24, 7, 'user', 40, 'other', 'Đã xem xét, không vi phạm quy định.', '2026-10-29 15:33:56'),
(25, 7, 'user', 23, 'other', 'Đã xem xét, không vi phạm quy định.', '2026-10-24 19:38:35'),
(26, 7, 'review', 67, 'other', 'Đã xem xét, không vi phạm quy định.', '2026-10-12 18:33:11'),
(27, 7, 'review', 79, 'other', 'Đã xem xét, không vi phạm quy định.', '2026-10-28 19:20:19'),
(28, 7, 'game_comment', 95, 'other', 'Đã xem xét, không vi phạm quy định.', '2026-10-19 16:06:27'),
(29, 7, 'game_comment', 53, 'other', 'Đã xem xét, không vi phạm quy định.', '2026-10-15 19:12:02'),
(30, 7, 'game_comment', 24, 'other', 'Đã xem xét, không vi phạm quy định.', '2026-10-13 23:30:18'),
(31, 7, 'game_comment', 89, 'other', 'Đã xem xét, không vi phạm quy định.', '2026-10-14 23:53:01'),
(32, 7, 'game_comment', 45, 'other', 'Đã xem xét, không vi phạm quy định.', '2026-10-26 23:01:00'),
(33, 7, 'game_comment', 110, 'other', 'Đã xem xét, không vi phạm quy định.', '2026-10-20 22:11:42'),
(34, 7, 'game_comment', 39, 'other', 'Đang xem xét, đã liên hệ người báo cáo để hỏi thêm.', '2026-10-25 18:50:59'),
(35, 7, 'game_comment', 97, 'other', 'Đang xem xét, đã liên hệ người báo cáo để hỏi thêm.', '2026-10-12 21:32:07'),
(36, 7, 'game_comment', 25, 'other', 'Đang xem xét, đã liên hệ người báo cáo để hỏi thêm.', '2026-10-29 15:57:02'),
(37, 7, 'game_comment', 79, 'other', 'Đang xem xét, đã liên hệ người báo cáo để hỏi thêm.', '2026-10-13 20:09:42'),
(38, 7, 'community_post', 187, 'other', 'Đang xem xét, đã liên hệ người báo cáo để hỏi thêm.', '2026-10-13 20:39:57');

-- --------------------------------------------------------

--
-- Table structure for table `hoan_tien`
--

CREATE TABLE `hoan_tien` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `thanh_toan_id` bigint(20) UNSIGNED NOT NULL,
  `chi_tiet_don_hang_id` bigint(20) UNSIGNED DEFAULT NULL,
  `nguoi_yeu_cau_id` bigint(20) UNSIGNED DEFAULT NULL,
  `so_tien` decimal(12,2) NOT NULL,
  `ma_tien_te` char(3) NOT NULL,
  `ly_do` text DEFAULT NULL,
  `trang_thai` enum('requested','approved','rejected','processing','completed','failed') NOT NULL DEFAULT 'requested',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_xu_ly` datetime DEFAULT NULL
) ;

--
-- Dumping data for table `hoan_tien`
--

INSERT INTO `hoan_tien` (`ma`, `thanh_toan_id`, `chi_tiet_don_hang_id`, `nguoi_yeu_cau_id`, `so_tien`, `ma_tien_te`, `ly_do`, `trang_thai`, `ngay_tao`, `ngay_xu_ly`) VALUES
(2, 59, 81, 46, 9.99, 'USD', 'Máy không đủ cấu hình để chạy mượt.', 'requested', '2026-10-23 05:39:58', NULL),
(3, 60, 82, 36, 29.99, 'USD', 'Máy không đủ cấu hình để chạy mượt.', 'requested', '2026-10-23 11:26:55', NULL),
(4, 61, 83, 27, 19.99, 'USD', 'Trò chơi không khởi động được trên máy, đã thử cài lại.', 'completed', '2026-10-23 11:51:49', '2026-10-24 18:51:49'),
(5, 62, 84, 25, 8.79, 'USD', 'Chơi thử thấy không hợp với mình.', 'completed', '2026-10-23 13:51:50', '2026-10-24 20:51:50'),
(6, 63, 85, 33, 9.99, 'USD', 'Bấm mua hai lần do mạng chậm, xin hoàn một lần.', 'rejected', '2026-10-23 16:58:46', '2026-10-24 23:58:46'),
(7, 64, 86, 45, 21.24, 'USD', 'Trò chơi không khởi động được trên máy, đã thử cài lại.', 'requested', '2026-10-24 08:43:56', NULL),
(8, 65, 87, 18, 9.99, 'USD', 'Trò chơi không khởi động được trên máy, đã thử cài lại.', 'requested', '2026-10-24 16:25:07', NULL),
(9, 66, 88, 48, 9.99, 'USD', 'Chơi thử thấy không hợp với mình.', 'completed', '2026-10-24 16:24:54', '2026-10-25 23:24:54'),
(10, 67, 89, 32, 31.99, 'USD', 'Bấm mua hai lần do mạng chậm, xin hoàn một lần.', 'completed', '2026-10-24 16:40:09', '2026-10-25 23:40:09'),
(11, 68, 90, 19, 16.99, 'USD', 'Bấm mua hai lần do mạng chậm, xin hoàn một lần.', 'rejected', '2026-10-25 06:10:48', '2026-10-26 13:10:48'),
(12, 69, 91, 20, 24.99, 'USD', 'Mua nhầm, mình đã có trò chơi này ở nơi khác.', 'requested', '2026-10-25 11:14:09', NULL),
(13, 70, 92, 44, 35.00, 'USD', 'Mua làm quà nhưng người nhận đã có.', 'requested', '2026-10-25 16:14:33', NULL),
(14, 71, 93, 52, 14.99, 'USD', 'Chơi thử thấy không hợp với mình.', 'completed', '2026-10-25 15:35:14', '2026-10-26 22:35:14'),
(15, 72, 94, 39, 13.49, 'USD', 'Máy không đủ cấu hình để chạy mượt.', 'completed', '2026-10-26 03:01:19', '2026-10-27 10:01:19'),
(16, 73, 95, 38, 7.99, 'USD', 'Trò chơi không khởi động được trên máy, đã thử cài lại.', 'rejected', '2026-10-27 04:10:03', '2026-10-28 11:10:03'),
(17, 74, 96, 35, 34.99, 'USD', 'Chơi thử thấy không hợp với mình.', 'requested', '2026-10-27 06:37:31', NULL),
(18, 75, 97, 23, 24.99, 'USD', 'Mua nhầm, mình đã có trò chơi này ở nơi khác.', 'requested', '2026-10-27 10:52:39', NULL),
(19, 76, 98, 26, 14.99, 'USD', 'Mua làm quà nhưng người nhận đã có.', 'completed', '2026-10-27 13:02:26', '2026-10-28 20:02:26'),
(20, 77, 99, 40, 24.99, 'USD', 'Mua nhầm, mình đã có trò chơi này ở nơi khác.', 'completed', '2026-10-28 04:07:34', '2026-10-29 11:07:34'),
(21, 78, 100, 21, 14.99, 'USD', 'Mua làm quà nhưng người nhận đã có.', 'rejected', '2026-10-28 09:55:53', '2026-10-29 16:55:53'),
(22, 79, 101, 29, 13.79, 'USD', 'Máy không đủ cấu hình để chạy mượt.', 'requested', '2026-10-28 08:56:58', NULL),
(23, 80, 102, 49, 24.99, 'USD', 'Bấm mua hai lần do mạng chậm, xin hoàn một lần.', 'requested', '2026-10-28 11:03:25', NULL),
(24, 81, 103, 24, 16.99, 'USD', 'Trò chơi không khởi động được trên máy, đã thử cài lại.', 'completed', '2026-10-29 04:59:28', '2026-10-30 11:59:28'),
(25, 82, 104, 30, 12.74, 'USD', 'Chơi thử thấy không hợp với mình.', 'completed', '2026-10-29 03:38:49', '2026-10-30 10:38:49'),
(26, 83, 105, 41, 14.99, 'USD', 'Bấm mua hai lần do mạng chậm, xin hoàn một lần.', 'rejected', '2026-10-29 08:48:34', '2026-10-30 15:48:34'),
(27, 84, 106, 22, 24.99, 'USD', 'Trò chơi không khởi động được trên máy, đã thử cài lại.', 'requested', '2026-10-29 08:50:24', NULL),
(28, 85, 107, 47, 34.99, 'USD', 'Mua làm quà nhưng người nhận đã có.', 'requested', '2026-10-29 08:55:07', NULL),
(29, 86, 108, 42, 22.99, 'USD', 'Máy không đủ cấu hình để chạy mượt.', 'completed', '2026-10-30 02:44:29', '2026-10-31 09:44:29'),
(30, 87, 109, 51, 9.99, 'USD', 'Trò chơi không khởi động được trên máy, đã thử cài lại.', 'completed', '2026-10-30 13:03:39', '2026-10-31 20:03:39'),
(31, 88, 110, 34, 24.99, 'USD', 'Máy không đủ cấu hình để chạy mượt.', 'rejected', '2026-10-30 17:40:05', '2026-11-01 00:40:05');

-- --------------------------------------------------------

--
-- Table structure for table `luot_dung_ma_giam_gia`
--

CREATE TABLE `luot_dung_ma_giam_gia` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `ma_giam_gia_id` bigint(20) UNSIGNED NOT NULL,
  `don_hang_id` bigint(20) UNSIGNED NOT NULL,
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `so_tien_giam` decimal(12,2) NOT NULL,
  `ngay_su_dung` timestamp NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `luot_dung_ma_giam_gia`
--

INSERT INTO `luot_dung_ma_giam_gia` (`ma`, `ma_giam_gia_id`, `don_hang_id`, `nguoi_dung_id`, `so_tien_giam`, `ngay_su_dung`) VALUES
(1, 9, 5, 49, 5.00, '2026-08-22 02:12:00'),
(2, 6, 10, 33, 2.00, '2026-08-28 11:05:00'),
(3, 10, 11, 20, 0.80, '2026-08-30 02:31:00'),
(4, 5, 12, 43, 8.25, '2026-08-30 11:22:00'),
(5, 4, 15, 31, 1.50, '2026-09-04 15:56:00'),
(6, 4, 20, 17, 1.50, '2026-09-06 15:06:00'),
(7, 9, 23, 30, 5.00, '2026-09-16 07:15:00'),
(8, 8, 25, 40, 1.20, '2026-09-16 08:20:00'),
(9, 10, 26, 42, 0.80, '2026-09-16 12:05:00'),
(10, 5, 28, 21, 1.20, '2026-09-20 07:55:00'),
(11, 8, 29, 46, 5.40, '2026-09-20 14:45:00'),
(12, 12, 30, 48, 8.75, '2026-10-08 02:04:00'),
(13, 12, 33, 27, 8.75, '2026-10-09 07:31:00'),
(14, 12, 34, 25, 11.25, '2026-10-10 12:47:00'),
(15, 5, 35, 23, 4.50, '2026-10-11 02:05:00'),
(16, 10, 37, 35, 1.60, '2026-10-12 07:30:00'),
(17, 4, 39, 31, 2.00, '2026-10-13 13:22:00'),
(18, 9, 41, 39, 5.00, '2026-10-13 15:52:00'),
(19, 13, 44, 17, 18.00, '2026-10-15 02:52:00'),
(20, 13, 52, 49, 7.50, '2026-10-18 13:18:00'),
(21, 10, 54, 18, 5.04, '2026-10-17 11:50:00'),
(22, 8, 62, 25, 1.20, '2026-10-22 13:15:00'),
(23, 5, 64, 45, 3.75, '2026-10-23 03:58:00'),
(24, 11, 67, 32, 3.00, '2026-10-23 15:50:00'),
(25, 5, 68, 19, 3.00, '2026-10-24 02:51:00'),
(26, 4, 72, 39, 1.50, '2026-10-25 01:55:00'),
(27, 7, 73, 38, 2.00, '2026-10-26 01:23:00'),
(28, 10, 79, 29, 1.20, '2026-10-27 05:46:00'),
(29, 5, 81, 24, 3.00, '2026-10-28 02:58:00'),
(30, 5, 82, 30, 2.25, '2026-10-28 03:24:00'),
(31, 10, 86, 42, 2.00, '2026-10-29 02:07:00'),
(32, 10, 92, 28, 1.20, '2026-10-31 12:31:00'),
(33, 10, 94, 43, 2.00, '2026-11-01 10:51:00');

-- --------------------------------------------------------

--
-- Table structure for table `ma_giam_gia`
--

CREATE TABLE `ma_giam_gia` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `nguoi_tao_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ma_uu_dai` varchar(80) NOT NULL,
  `loai_giam_gia` enum('percent','fixed_amount') NOT NULL,
  `gia_tri_giam_gia` decimal(12,2) NOT NULL,
  `ma_tien_te` char(3) DEFAULT NULL,
  `so_luot_dung_toi_da` int(10) UNSIGNED DEFAULT NULL,
  `so_luot_da_dung` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `ngay_bat_dau` datetime DEFAULT NULL,
  `ngay_ket_thuc` datetime DEFAULT NULL,
  `dang_hoat_dong` tinyint(1) NOT NULL DEFAULT 1,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `ma_giam_gia`
--

INSERT INTO `ma_giam_gia` (`ma`, `nguoi_tao_id`, `ma_uu_dai`, `loai_giam_gia`, `gia_tri_giam_gia`, `ma_tien_te`, `so_luot_dung_toi_da`, `so_luot_da_dung`, `ngay_bat_dau`, `ngay_ket_thuc`, `dang_hoat_dong`, `ngay_tao`) VALUES
(4, 6, 'CHAOMUNG10', 'percent', 10.00, NULL, NULL, 4, '2026-07-01 00:00:00', NULL, 1, '2026-06-27 17:00:00'),
(5, 6, 'INDIE15', 'percent', 15.00, NULL, 200, 7, '2026-07-01 00:00:00', '2026-12-31 23:59:00', 1, '2026-06-27 17:00:00'),
(6, 6, 'GIAM2USD', 'fixed_amount', 2.00, 'USD', NULL, 1, '2026-07-01 00:00:00', NULL, 1, '2026-06-27 17:00:00'),
(7, 6, 'HOCSINH20', 'percent', 20.00, NULL, 100, 1, '2026-07-01 00:00:00', '2027-06-30 23:59:00', 1, '2026-06-27 17:00:00'),
(8, 6, 'CUOITUAN12', 'percent', 12.00, NULL, NULL, 3, '2026-07-01 00:00:00', NULL, 1, '2026-06-27 17:00:00'),
(9, 6, 'GIAM5USD', 'fixed_amount', 5.00, 'USD', 50, 3, '2026-07-01 00:00:00', '2026-12-31 23:59:00', 1, '2026-06-27 17:00:00'),
(10, 6, 'BANBE8', 'percent', 8.00, NULL, NULL, 8, '2026-07-01 00:00:00', NULL, 1, '2026-06-27 17:00:00'),
(11, 6, 'THU3USD', 'fixed_amount', 3.00, 'USD', 100, 1, '2026-07-01 00:00:00', '2027-03-31 23:59:00', 1, '2026-06-27 17:00:00'),
(12, 6, 'CHOPNHOANG25', 'percent', 25.00, NULL, 3, 3, '2026-10-01 00:00:00', '2026-12-31 23:59:00', 1, '2026-09-27 17:00:00'),
(13, 6, 'FLASH30', 'percent', 30.00, NULL, 2, 2, '2026-10-15 00:00:00', '2026-11-30 23:59:00', 1, '2026-10-11 17:00:00'),
(14, 6, 'NAMHOC10', 'percent', 10.00, NULL, NULL, 0, '2026-09-01 00:00:00', '2027-05-31 23:59:00', 1, '2026-08-28 17:00:00'),
(15, 6, 'TRAINGHIEM5', 'percent', 5.00, NULL, NULL, 0, '2026-10-01 00:00:00', NULL, 1, '2026-09-27 17:00:00'),
(16, 6, 'GAMETHU7', 'percent', 7.00, NULL, 500, 0, '2026-10-01 00:00:00', '2027-01-31 23:59:00', 1, '2026-09-27 17:00:00'),
(17, 6, 'QUAYLAI15', 'percent', 15.00, NULL, 300, 0, '2026-10-20 00:00:00', '2026-12-31 23:59:00', 1, '2026-10-16 17:00:00'),
(18, 6, 'GIAM1USD', 'fixed_amount', 1.00, 'USD', NULL, 0, '2026-10-01 00:00:00', NULL, 1, '2026-09-27 17:00:00'),
(19, 6, 'DONGDOI12', 'percent', 12.00, NULL, 150, 0, '2026-10-01 00:00:00', '2026-12-15 23:59:00', 1, '2026-09-27 17:00:00'),
(20, 6, 'MUAGOI10', 'percent', 10.00, NULL, NULL, 0, '2026-10-01 00:00:00', NULL, 1, '2026-09-27 17:00:00'),
(21, 6, 'HE2026', 'percent', 20.00, NULL, NULL, 0, '2026-06-20 00:00:00', '2026-07-20 23:59:00', 1, '2026-06-16 17:00:00'),
(22, 6, 'TET2026', 'percent', 25.00, NULL, NULL, 0, '2026-02-10 00:00:00', '2026-02-24 23:59:00', 1, '2026-02-06 17:00:00'),
(23, 6, 'BLACKFRIDAY2025', 'percent', 30.00, NULL, NULL, 0, '2025-11-28 00:00:00', '2025-12-02 23:59:00', 1, '2025-11-24 17:00:00'),
(24, 6, 'GIANGSINH2025', 'percent', 20.00, NULL, NULL, 0, '2025-12-19 00:00:00', '2026-01-02 23:59:00', 1, '2025-12-15 17:00:00'),
(25, 6, 'KHAIGIANG2026', 'percent', 15.00, NULL, NULL, 0, '2026-08-15 00:00:00', '2026-09-15 23:59:00', 1, '2026-08-11 17:00:00'),
(26, 6, 'SINHNHAT20', 'percent', 20.00, NULL, NULL, 0, '2026-04-01 00:00:00', '2026-04-07 23:59:00', 1, '2026-03-28 17:00:00'),
(27, 6, 'WEEKEND15', 'percent', 15.00, NULL, NULL, 0, '2026-09-05 00:00:00', '2026-09-07 23:59:00', 1, '2026-09-01 17:00:00'),
(28, 6, 'BLACKFRIDAY2026', 'percent', 30.00, NULL, NULL, 0, '2026-11-27 00:00:00', '2026-12-01 23:59:00', 1, '2026-11-23 17:00:00'),
(29, 6, 'GIANGSINH2026', 'percent', 20.00, NULL, NULL, 0, '2026-12-18 00:00:00', '2027-01-02 23:59:00', 1, '2026-12-14 17:00:00'),
(30, 6, 'NAMMOI2027', 'percent', 15.00, NULL, NULL, 0, '2027-01-01 00:00:00', '2027-01-07 23:59:00', 1, '2026-12-28 17:00:00'),
(31, 6, 'THUNGHIEM50', 'percent', 50.00, NULL, 10, 0, '2026-07-01 00:00:00', NULL, 0, '2026-06-27 17:00:00'),
(32, 6, 'NOIBO20', 'percent', 20.00, NULL, NULL, 0, NULL, NULL, 0, '2026-07-01 02:00:00'),
(33, 6, 'LOI2025', 'fixed_amount', 10.00, 'USD', 5, 0, '2025-10-01 00:00:00', '2025-12-31 23:59:00', 0, '2025-09-27 17:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `ma_truy_cap_tro_choi`
--

CREATE TABLE `ma_truy_cap_tro_choi` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `nguoi_tao_ma_id` bigint(20) UNSIGNED NOT NULL,
  `ma_bam` char(64) NOT NULL,
  `trang_thai` enum('available','claimed','revoked','expired') NOT NULL DEFAULT 'available',
  `nguoi_nhan_ma_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ngay_nhan_ma` datetime DEFAULT NULL,
  `ngay_het_han` datetime DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ma_truy_cap_tro_choi`
--

INSERT INTO `ma_truy_cap_tro_choi` (`ma`, `tro_choi_id`, `nguoi_tao_ma_id`, `ma_bam`, `trang_thai`, `nguoi_nhan_ma_id`, `ngay_nhan_ma`, `ngay_het_han`, `ngay_tao`) VALUES
(5, 15, 53, '7b4af218b626c780830b90a18f1e4bd82dfa12bc3c0a897318e7069f7c2b7203', 'available', NULL, NULL, '2027-01-03 09:27:42', '2026-10-12 02:27:42'),
(6, 16, 54, 'af60b3de0a328375bf0316ea95ac547616f046ae9766406114cb09c7a9eda43c', 'expired', NULL, NULL, '2026-10-31 09:27:42', '2026-10-28 02:27:42'),
(7, 17, 55, 'e6f51744c2b5f93f9c6c9a7efe8f2c50804cd74975ded69c16896473a97e1844', 'available', NULL, NULL, NULL, '2026-10-30 02:27:42'),
(8, 18, 56, '7d85a8da4a4a95477713ab082adf939059618b28d715d0aef04a8272680db596', 'available', NULL, NULL, '2027-01-03 09:27:42', '2026-10-25 02:27:42'),
(9, 19, 57, '37f2eb087c1a95c4ef7e8d0115b06742d54b0fad34b26e7d68a5cc9cf7bf1b7f', 'available', NULL, NULL, NULL, '2026-10-08 02:27:42'),
(10, 20, 58, '33cc7ba850fb5df2a1d84e2559cd8ef80843a21f2ad16c4c535c223b7b53c323', 'revoked', NULL, NULL, NULL, '2026-09-27 02:27:42'),
(11, 21, 59, '2ecd6cb52a6b302dbdfc5903bd225131fab29793e22e5d129531b81e405eef99', 'available', NULL, NULL, '2027-01-03 09:27:42', '2026-10-21 02:27:42'),
(12, 22, 60, '52c47f54a4d129e82d9ea95031ef4ff669f7ac5df23f15ffdcf36deca61ee685', 'available', NULL, NULL, NULL, '2026-09-29 02:27:42'),
(13, 23, 61, '3b1600089019c1c260554012cb55b7e0f8cca3425ef4a4442b37df607f35a233', 'available', NULL, NULL, NULL, '2026-10-04 02:27:42'),
(14, 24, 62, '0286893a8d5d2fc7dce0429f403241eb1bd82f0ccea7195937558e47de473a71', 'expired', NULL, NULL, '2026-10-27 09:27:42', '2026-10-24 02:27:42'),
(15, 25, 63, 'ef15190088aeb0efffda3129c5d6dd121badd1e29f5c8596680c401a93534f6c', 'available', NULL, NULL, NULL, '2026-10-29 02:27:42'),
(16, 26, 64, '3cedf766bf18e62c98b6d5175811be39b08a6a76857e0a78212f516855cecd08', 'available', NULL, NULL, NULL, '2026-10-02 02:27:42'),
(17, 27, 65, 'fd780bc6256e6527d001a754f6ba1c23a1e1f95daf38133aa116dd6046942447', 'available', NULL, NULL, '2027-01-03 09:27:42', '2026-10-09 02:27:42'),
(18, 28, 66, '296790c20d4b761ebfdeb43e2baa04556d5740ebc1b0126ef28f3648253fb4dc', 'revoked', NULL, NULL, NULL, '2026-10-24 02:27:42'),
(19, 29, 67, '85db9ddc869963547fb440778cf8426bdcd8bc76bb800cd704dea0e44470341b', 'available', NULL, NULL, NULL, '2026-10-09 02:27:42'),
(20, 30, 68, '68c3021b1bd920ccaddda56a871535d046687e60cc51b17089ccc43a8c52cbec', 'available', NULL, NULL, '2027-01-03 09:27:42', '2026-10-22 02:27:42'),
(21, 31, 69, '9c13a2ecc1bbfa3053d975542da349cb76d74c221c9e3a6edeab02dccd9ea0f7', 'available', NULL, NULL, NULL, '2026-10-14 02:27:42'),
(22, 32, 70, 'd0a585c81a43be2a453efa0b2fbdf23f882378a6983d939c0db820e36f4e1253', 'expired', NULL, NULL, '2026-10-31 09:27:42', '2026-10-28 02:27:42'),
(23, 33, 71, 'e31b21d8203c70a72c24281d578b42ce21b2af13ab2c4a4fea8db415c1a4c69a', 'available', NULL, NULL, '2027-01-03 09:27:42', '2026-10-22 02:27:42'),
(24, 34, 72, '5a9f7f893900c245d2fbe3482a9217841cb125e6f010df51f0b957a0a4bba209', 'available', NULL, NULL, NULL, '2026-10-20 02:27:42'),
(25, 35, 73, '43ffef7c68e45960b81a0581071bc6117a09aea0e26a30d2f5f3f2690b728929', 'available', NULL, NULL, NULL, '2026-10-02 02:27:42'),
(26, 36, 74, 'a4e5431f2a14c47d0007954f3d1c5b114fd81b5d6f8e04c728e77f0ca99d63fd', 'revoked', NULL, NULL, '2027-01-03 09:27:42', '2026-10-26 02:27:42'),
(27, 37, 75, '3405a8e7b96747e1bcd418cf99da7d3c2ff9f353ca0172e98d948eadb0e9aa5a', 'available', NULL, NULL, NULL, '2026-10-12 02:27:42'),
(28, 38, 68, '2c3d647f2852676efe58d84d4c45afe47dac6f09fcaa0ada578fea01082eacfc', 'available', NULL, NULL, NULL, '2026-10-28 02:27:42'),
(29, 39, 76, 'aafb7bd9999588bc216063a6d5919764d9c21ed1e89f9cd5c284940c713b4ab5', 'available', NULL, NULL, '2027-01-03 09:27:42', '2026-10-03 02:27:42'),
(30, 40, 77, '7609b4fd44bef3a742d48e01b00f68a1fe7ca9239c1703e25c930cf0186fa89c', 'expired', NULL, NULL, '2026-10-26 09:27:42', '2026-10-23 02:27:42'),
(31, 41, 78, '6caef83e84adf900e794d87c2daeec7250393170997d0fcad783e05807bb51a9', 'available', NULL, NULL, NULL, '2026-09-28 02:27:42'),
(32, 42, 67, '7660d2d2cfaf6e85a5cda722fd8d9a7cd6be9142dd7d9c0b6ed4f55d508b0cf5', 'available', NULL, NULL, '2027-01-03 09:27:42', '2026-09-27 02:27:42'),
(33, 43, 62, '37ae3d793adcd7b405479930c87d599572f226a5e2657780e829de162f72ce53', 'available', NULL, NULL, NULL, '2026-10-28 02:27:42'),
(34, 44, 79, '51d62e73ece56848e449d0cdfee94182a306e03320a04836fbfc4fe7be07bd48', 'revoked', NULL, NULL, NULL, '2026-09-27 02:27:42');

-- --------------------------------------------------------

--
-- Table structure for table `ma_xac_nhan_dat_lai_mat_khau`
--

CREATE TABLE `ma_xac_nhan_dat_lai_mat_khau` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(254) NOT NULL,
  `ma_bam` varchar(255) NOT NULL,
  `so_lan_thu` int(11) NOT NULL DEFAULT 0,
  `da_su_dung` tinyint(1) NOT NULL DEFAULT 0,
  `ngay_het_han` datetime NOT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `media_tro_choi`
--

CREATE TABLE `media_tro_choi` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `loai_media` enum('cover','thumbnail','screenshot','trailer','external_link','other') NOT NULL,
  `url_media` varchar(1500) NOT NULL,
  `chu_thich` varchar(300) DEFAULT NULL,
  `van_ban_thay_the` varchar(300) DEFAULT NULL,
  `thu_tu_sap_xep` int(11) NOT NULL DEFAULT 0,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `media_tro_choi`
--

INSERT INTO `media_tro_choi` (`ma`, `tro_choi_id`, `loai_media`, `url_media`, `chu_thich`, `van_ban_thay_the`, `thu_tu_sap_xep`, `ngay_tao`) VALUES
(2, 3, 'screenshot', '/public/uploads/seed/0ad-spartans.webp', 'Ảnh: Wildfire Games · CC BY-SA 3.0 · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:0_A.D._alpha_25_-_playing_as_Spartans.jpg', 'Thành phố Sparta với đầy đủ công trình trong 0 A.D.', 0, '2026-11-03 08:23:05'),
(3, 3, 'screenshot', '/public/uploads/seed/0ad-romans.webp', 'Ảnh: Wildfire Games · CC BY-SA 3.0 · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:0ad-alpha23.jpg', 'Quân La Mã giao chiến trong 0 A.D.', 1, '2026-11-03 08:23:05'),
(4, 3, 'screenshot', '/public/uploads/seed/0ad-cycladic.webp', 'Ảnh: Ludovic Celle · CC BY-SA 3.0 · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:0_A.D._Cycladic_Archipelago.jpg', 'Bản đồ quần đảo Cyclades trong 0 A.D.', 2, '2026-11-03 08:23:05'),
(5, 3, 'external_link', 'https://play0ad.com/', 'Trang chủ chính thức', NULL, 100, '2026-11-03 08:23:05'),
(6, 4, 'screenshot', '/public/uploads/seed/stk-splitscreen.webp', 'Ảnh: QwertyChouskie · CC BY-SA 4.0 · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:Split-screen_4-player_multiplayer_in_SuperTuxKart_(2017,_0.9.3).png', 'Bốn người chơi đua chia màn hình trong SuperTuxKart', 0, '2026-11-03 08:23:05'),
(7, 4, 'screenshot', '/public/uploads/seed/stk-karts.webp', 'Ảnh: QwertyChouskie · CC BY-SA 4.0 · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:SuperTuxKart_kart_selection_screen_2018.png', 'Màn hình chọn nhân vật và xe kart của SuperTuxKart', 1, '2026-11-03 08:23:05'),
(8, 4, 'screenshot', '/public/uploads/seed/stk-story.webp', 'Ảnh: QwertyChouskie · CC BY-SA 4.0 · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:SuperTuxKart_-_Gnu_and_Nolok_in_Story_Mode.png', 'Cảnh cốt truyện với Gnu và Nolok trong SuperTuxKart', 2, '2026-11-03 08:23:05'),
(9, 4, 'external_link', 'https://supertuxkart.net/', 'Trang chủ chính thức', NULL, 100, '2026-11-03 08:23:05'),
(10, 5, 'screenshot', '/public/uploads/seed/wesnoth-battle.webp', 'Ảnh: wesnoth.org · GPL · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:Wesnoth1.8-6.jpg', 'Trận đánh trên bản đồ lục giác trong The Battle for Wesnoth', 0, '2026-11-03 08:23:05'),
(11, 5, 'screenshot', '/public/uploads/seed/wesnoth-title.webp', 'Ảnh: The Battle for Wesnoth developer team · GPL · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:The_Battle_for_Wesnoth_1.16.2_title_screen.png', 'Màn hình chính của The Battle for Wesnoth', 1, '2026-11-03 08:23:05'),
(12, 5, 'screenshot', '/public/uploads/seed/wesnoth-editor.webp', 'Ảnh: Battle for Wesnoth development team · GPL · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:Wesnoth-1.6-2.jpg', 'Trình chỉnh sửa bản đồ của The Battle for Wesnoth', 2, '2026-11-03 08:23:05'),
(13, 5, 'external_link', 'https://www.wesnoth.org/', 'Trang chủ chính thức', NULL, 100, '2026-11-03 08:23:05'),
(14, 6, 'screenshot', '/public/uploads/seed/luanti-voxelibre.webp', 'Ảnh: Antimundo · GPLv3 · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:Luanti-5.12-voxelibre-world.png', 'Cánh đồng xanh trong Luanti với trò chơi VoxeLibre', 0, '2026-11-03 08:23:05'),
(15, 6, 'screenshot', '/public/uploads/seed/luanti-caves.webp', 'Ảnh: SoylentCow · CC BY-SA 4.0 · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:Minetest-5.3.0-caverealms-mod.jpg', 'Hang pha lê sinh tự động trong Minetest 5.3', 1, '2026-11-03 08:23:05'),
(16, 6, 'screenshot', '/public/uploads/seed/luanti-snow.webp', 'Ảnh: SoylentCow · CC BY-SA 4.0 · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:Minetest-5.3.0-snow-ice-biomes.jpg', 'Rừng tuyết và đồng băng trong Minetest 5.3', 2, '2026-11-03 08:23:05'),
(17, 6, 'screenshot', '/public/uploads/seed/luanti-biomes.webp', 'Ảnh: SoylentCow · CC BY-SA 4.0 · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:Minetest-5.3.0-dry-green-jungle-biomes.jpg', 'Đồng cỏ khô, đồng cỏ xanh và rừng rậm trong Minetest 5.3', 3, '2026-11-03 08:23:05'),
(18, 6, 'external_link', 'https://www.luanti.org/', 'Trang chủ chính thức', NULL, 100, '2026-11-03 08:23:05'),
(19, 7, 'screenshot', '/public/uploads/seed/mindustry-base.webp', 'Ảnh: Mvrt CZ · GPLv3 · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:Sn%C3%ADmek_obrazovky_(15).png', 'Căn cứ với hệ thống băng chuyền phức tạp trong Mindustry', 0, '2026-11-03 08:23:05'),
(20, 7, 'screenshot', '/public/uploads/seed/mindustry-pvp.webp', 'Ảnh: JPxG · GPLv3 · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:Mindyscreenshot2.png', 'Trận PvP trên bản đồ lục giác trong Mindustry', 1, '2026-11-03 08:23:05'),
(21, 7, 'screenshot', '/public/uploads/seed/mindustry-serpulo.webp', 'Ảnh: Mindustry · GPL · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:The_Serpulo_Planet_-_Mindustry.jpg', 'Hành tinh Serpulo trong chiến dịch Mindustry', 2, '2026-11-03 08:23:05'),
(22, 7, 'external_link', 'https://mindustrygame.github.io/', 'Trang chủ chính thức', NULL, 100, '2026-11-03 08:23:05'),
(23, 8, 'screenshot', '/public/uploads/seed/openttd-title.webp', 'Ảnh: theki (trò chơi: OpenTTD, đồ họa OpenGFX) · GPLv2 · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:OpenTTD-15.3-en.png', 'Màn hình chính của OpenTTD 15.3 với bản đồ đường sắt và sông', 0, '2026-11-03 08:23:05'),
(24, 8, 'external_link', 'https://www.openttd.org/', 'Trang chủ chính thức', NULL, 100, '2026-11-03 08:23:05'),
(25, 9, 'screenshot', '/public/uploads/seed/xonotic-rocket.webp', 'Ảnh: Xonotic developers · GPL · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:Xonotic_0.8.2_rocket.jpg', 'Bắn tên lửa trên bản đồ đấu trường trong Xonotic 0.8.2', 0, '2026-11-03 08:23:05'),
(26, 9, 'screenshot', '/public/uploads/seed/xonotic-menu.webp', 'Ảnh: Team Xonotic · GPLv2 · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:Screenshot_of_Xonotic_main_menu.jpg', 'Menu chính của Xonotic 0.8.2', 1, '2026-11-03 08:23:05'),
(27, 9, 'external_link', 'https://xonotic.org/', 'Trang chủ chính thức', NULL, 100, '2026-11-03 08:23:05'),
(28, 10, 'screenshot', '/public/uploads/seed/freeciv-map.webp', 'Ảnh: Rp22 · GPL · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:Bigshot.png', 'Bản đồ thế giới với các thành phố trong Freeciv', 0, '2026-11-03 08:23:05'),
(29, 10, 'screenshot', '/public/uploads/seed/freeciv-21.webp', 'Ảnh: Himasaram · GPL · Wikimedia Commons (đã thu nhỏ) · https://commons.wikimedia.org/wiki/File:Freeciv2_1-beta1-zh.png', 'Giao diện Freeciv 2.1 bản tiếng Trung giản thể', 1, '2026-11-03 08:23:05'),
(30, 10, 'external_link', 'https://www.freeciv.org/', 'Trang chủ chính thức', NULL, 100, '2026-11-03 08:23:05'),
(33, 15, 'screenshot', '/public/uploads/seed/stardew-valley-1.webp', '© ConcernedApe · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/413150/', 'Nông trại với nhà kho, chuồng gà, ngôi nhà và ruộng cây trồng trong Stardew Valley', 0, '2026-11-04 01:17:30'),
(34, 15, 'screenshot', '/public/uploads/seed/stardew-valley-2.webp', '© ConcernedApe · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/413150/', 'Lễ hội trên đảo với bàn tiệc và lời thoại của thị trưởng trong Stardew Valley', 1, '2026-11-04 01:17:30'),
(35, 15, 'screenshot', '/public/uploads/seed/stardew-valley-3.webp', '© ConcernedApe · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/413150/', 'Đường ray xe mỏ trong hầm mỏ của Stardew Valley', 2, '2026-11-04 01:17:30'),
(36, 15, 'screenshot', '/public/uploads/seed/stardew-valley-4.webp', '© ConcernedApe · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/413150/', 'Nông trại về đêm trong cơn giông bão ở Stardew Valley', 3, '2026-11-04 01:17:30'),
(37, 15, 'external_link', 'https://store.steampowered.com/app/413150/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:17:30'),
(38, 15, 'external_link', 'http://www.stardewvalley.net', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:17:30'),
(39, 16, 'screenshot', '/public/uploads/seed/hollow-knight-1.webp', '© Team Cherry · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/367520/', 'Hiệp sĩ đứng trên cây cầu giữa vùng Greenpath xanh rêu trong Hollow Knight', 0, '2026-11-04 01:17:30'),
(40, 16, 'screenshot', '/public/uploads/seed/hollow-knight-2.webp', '© Team Cherry · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/367520/', 'Trận chiến với trùm trong một đại sảnh của Hollow Knight', 1, '2026-11-04 01:17:30'),
(41, 16, 'screenshot', '/public/uploads/seed/hollow-knight-3.webp', '© Team Cherry · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/367520/', 'Sân khấu đỏ của Grimm trong Hollow Knight', 2, '2026-11-04 01:17:30'),
(42, 16, 'screenshot', '/public/uploads/seed/hollow-knight-4.webp', '© Team Cherry · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/367520/', 'Màn hình bản đồ Hallownest trong Hollow Knight', 3, '2026-11-04 01:17:30'),
(43, 16, 'external_link', 'https://store.steampowered.com/app/367520/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:17:30'),
(44, 16, 'external_link', 'http://hollowknight.com', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:17:30'),
(45, 17, 'screenshot', '/public/uploads/seed/celeste-1.webp', '© Maddy Makes Games Inc., Extremely OK Games, Ltd. · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/504230/', 'Madeline leo núi giữa những đám mây hồng trong Celeste', 0, '2026-11-04 01:17:30'),
(46, 17, 'screenshot', '/public/uploads/seed/celeste-2.webp', '© Maddy Makes Games Inc., Extremely OK Games, Ltd. · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/504230/', 'Căn nhà gỗ về đêm và đoạn hội thoại trong Celeste', 1, '2026-11-04 01:17:30'),
(47, 17, 'screenshot', '/public/uploads/seed/celeste-3.webp', '© Maddy Makes Games Inc., Extremely OK Games, Ltd. · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/504230/', 'Màn chơi ban đêm với gai nhọn và dầm thép trong Celeste', 2, '2026-11-04 01:17:30'),
(48, 17, 'screenshot', '/public/uploads/seed/celeste-4.webp', '© Maddy Makes Games Inc., Extremely OK Games, Ltd. · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/504230/', 'Hang động đỏ với nhiều trái tim và bức tượng lớn trong Celeste', 3, '2026-11-04 01:17:30'),
(49, 17, 'external_link', 'https://store.steampowered.com/app/504230/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:17:30'),
(50, 17, 'external_link', 'http://www.celestegame.com', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:17:30'),
(51, 18, 'screenshot', '/public/uploads/seed/hades-1.webp', '© Supergiant Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1145360/', 'Zagreus chiến đấu trong các căn phòng ánh xanh của Tartarus trong Hades', 0, '2026-11-04 01:17:30'),
(52, 18, 'screenshot', '/public/uploads/seed/hades-2.webp', '© Supergiant Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1145360/', 'Zagreus trò chuyện với thần Hades bên bàn làm việc trong Hades', 1, '2026-11-04 01:17:30'),
(53, 18, 'screenshot', '/public/uploads/seed/hades-3.webp', '© Supergiant Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1145360/', 'Các vụ nổ giữa vùng Asphodel rực lửa trong Hades', 2, '2026-11-04 01:17:30'),
(54, 18, 'screenshot', '/public/uploads/seed/hades-4.webp', '© Supergiant Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1145360/', 'Đại sảnh Nhà của Hades', 3, '2026-11-04 01:17:30'),
(55, 18, 'external_link', 'https://store.steampowered.com/app/1145360/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:17:30'),
(56, 18, 'external_link', 'http://www.supergiantgames.com', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:17:30'),
(57, 19, 'screenshot', '/public/uploads/seed/dead-cells-1.webp', '© Motion Twin · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/588650/', 'Trận đánh trùm trên cây cầu dưới trăng tròn trong Dead Cells', 0, '2026-11-04 01:17:30'),
(58, 19, 'screenshot', '/public/uploads/seed/dead-cells-2.webp', '© Motion Twin · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/588650/', 'Đòn chém kiếm trong hang động tím của Dead Cells', 1, '2026-11-04 01:17:30'),
(59, 19, 'screenshot', '/public/uploads/seed/dead-cells-3.webp', '© Motion Twin · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/588650/', 'Cống ngầm độc xanh với cung thủ và xác sống trong Dead Cells', 2, '2026-11-04 01:17:30'),
(60, 19, 'screenshot', '/public/uploads/seed/dead-cells-4.webp', '© Motion Twin · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/588650/', 'Tàn tích trong rừng và móc xích trong Dead Cells', 3, '2026-11-04 01:17:30'),
(61, 19, 'external_link', 'https://store.steampowered.com/app/588650/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:17:30'),
(62, 19, 'external_link', 'https://dead-cells.com/', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:17:30'),
(63, 20, 'screenshot', '/public/uploads/seed/slay-the-spire-1.webp', '© Mega Crit · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/646570/', 'Nhân vật Defect dùng lá bài Zap gọi sét trong Slay the Spire', 0, '2026-11-04 01:17:30'),
(64, 20, 'screenshot', '/public/uploads/seed/slay-the-spire-2.webp', '© Mega Crit · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/646570/', 'Nhân vật Silent chiến đấu với sinh vật rắn trong Slay the Spire', 1, '2026-11-04 01:17:30'),
(65, 20, 'screenshot', '/public/uploads/seed/slay-the-spire-3.webp', '© Mega Crit · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/646570/', 'Sự kiện Hội đồng Bóng ma trong Slay the Spire', 2, '2026-11-04 01:17:30'),
(66, 20, 'screenshot', '/public/uploads/seed/slay-the-spire-4.webp', '© Mega Crit · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/646570/', 'Thư viện bài đỏ trong Slay the Spire', 3, '2026-11-04 01:17:30'),
(67, 20, 'external_link', 'https://store.steampowered.com/app/646570/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:17:30'),
(68, 20, 'external_link', 'https://www.megacrit.com/', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:17:30'),
(69, 21, 'screenshot', '/public/uploads/seed/terraria-1.webp', '© Re-Logic · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/105600/', 'Những ngôi nhà gỗ có NPC trên mặt đất trong Terraria', 0, '2026-11-04 01:17:30'),
(70, 21, 'screenshot', '/public/uploads/seed/terraria-2.webp', '© Re-Logic · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/105600/', 'Trùm Wall of Flesh dưới Địa ngục trong Terraria', 1, '2026-11-04 01:17:30'),
(71, 21, 'screenshot', '/public/uploads/seed/terraria-3.webp', '© Re-Logic · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/105600/', 'Câu cá trên đảo trời giữa cơn mưa trong Terraria', 2, '2026-11-04 01:17:30'),
(72, 21, 'screenshot', '/public/uploads/seed/terraria-4.webp', '© Re-Logic · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/105600/', 'Quần thể nấm phát sáng dưới lòng đất trong Terraria', 3, '2026-11-04 01:17:30'),
(73, 21, 'external_link', 'https://store.steampowered.com/app/105600/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:17:30'),
(74, 21, 'external_link', 'http://www.terraria.org/', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:17:30'),
(75, 22, 'screenshot', '/public/uploads/seed/a-short-hike-1.webp', '© adamgryu · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1055540/', 'Lửa trại và căn nhà gỗ giữa mùa thu trong A Short Hike', 0, '2026-11-04 01:17:30'),
(76, 22, 'screenshot', '/public/uploads/seed/a-short-hike-2.webp', '© adamgryu · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1055540/', 'Lượn qua thác nước trong A Short Hike', 1, '2026-11-04 01:17:30'),
(77, 22, 'screenshot', '/public/uploads/seed/a-short-hike-3.webp', '© adamgryu · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1055540/', 'Bãi biển có ô dù và câu cá trên hồ trong A Short Hike', 2, '2026-11-04 01:17:30'),
(78, 22, 'screenshot', '/public/uploads/seed/a-short-hike-4.webp', '© adamgryu · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1055540/', 'Căn nhà gỗ phủ tuyết và lời chào trong A Short Hike', 3, '2026-11-04 01:17:30'),
(79, 22, 'external_link', 'https://store.steampowered.com/app/1055540/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:17:30'),
(80, 22, 'external_link', 'http://www.ashorthike.com', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:17:30'),
(81, 23, 'screenshot', '/public/uploads/seed/vampire-survivors-1.webp', '© poncle · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1794680/', 'Đàn dơi trong khu rừng và các nhát roi trong Vampire Survivors', 0, '2026-11-04 01:17:30'),
(82, 23, 'screenshot', '/public/uploads/seed/vampire-survivors-2.webp', '© poncle · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1794680/', 'Thư viện đầy bộ xương trong Vampire Survivors', 1, '2026-11-04 01:17:30'),
(83, 23, 'screenshot', '/public/uploads/seed/vampire-survivors-3.webp', '© poncle · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1794680/', 'Rất nhiều tia đạn trên màn hình trong Vampire Survivors', 2, '2026-11-04 01:17:30'),
(84, 23, 'screenshot', '/public/uploads/seed/vampire-survivors-4.webp', '© poncle · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1794680/', 'Rương báu được mở trong Vampire Survivors', 3, '2026-11-04 01:17:30'),
(85, 23, 'external_link', 'https://store.steampowered.com/app/1794680/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:17:30'),
(86, 24, 'screenshot', '/public/uploads/seed/papers-please-1.webp', '© Lucas Pope · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/239030/', 'Bàn làm việc với giấy phép nhập cảnh, thị thực và hộ chiếu trong Papers, Please', 0, '2026-11-04 01:17:30'),
(87, 24, 'screenshot', '/public/uploads/seed/papers-please-2.webp', '© Lucas Pope · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/239030/', 'Sổ quy định của Bộ và bản tin trong Papers, Please', 1, '2026-11-04 01:17:30'),
(88, 24, 'screenshot', '/public/uploads/seed/papers-please-3.webp', '© Lucas Pope · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/239030/', 'Tờ báo The Truth of Arstotzka trong Papers, Please', 2, '2026-11-04 01:17:30'),
(89, 24, 'screenshot', '/public/uploads/seed/papers-please-4.webp', '© Lucas Pope · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/239030/', 'Màn hình tiêu đề của Papers, Please', 3, '2026-11-04 01:17:30'),
(90, 24, 'external_link', 'https://store.steampowered.com/app/239030/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:17:30'),
(91, 24, 'external_link', 'http://papersplea.se', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:17:30'),
(92, 25, 'screenshot', '/public/uploads/seed/inscryption-1.webp', '© Daniel Mullins Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1092790/', 'Bàn chơi bài với các lá Squirrel, Turkey Vulture và Opossum trong Inscryption', 0, '2026-11-04 01:50:07'),
(93, 25, 'screenshot', '/public/uploads/seed/inscryption-2.webp', '© Daniel Mullins Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1092790/', 'Bản đồ rừng thông dẫn tới vùng đầm lầy trong Inscryption', 1, '2026-11-04 01:50:07'),
(94, 25, 'screenshot', '/public/uploads/seed/inscryption-3.webp', '© Daniel Mullins Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1092790/', 'Kẻ đối diện đeo mặt nạ gỗ đòi lấy da thú trong Inscryption', 2, '2026-11-04 01:50:07'),
(95, 25, 'screenshot', '/public/uploads/seed/inscryption-4.webp', '© Daniel Mullins Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1092790/', 'Cánh cửa gỗ của căn chòi dưới ánh nến trong Inscryption', 3, '2026-11-04 01:50:07'),
(96, 25, 'external_link', 'https://store.steampowered.com/app/1092790/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(97, 25, 'external_link', 'https://www.inscryption-game.com', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(98, 26, 'screenshot', '/public/uploads/seed/unpacking-1.webp', '© Witch Beam · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1135690/', 'Phòng ngủ với bàn máy tính cũ và các thùng đồ chưa mở trong Unpacking', 0, '2026-11-04 01:50:07'),
(99, 26, 'screenshot', '/public/uploads/seed/unpacking-2.webp', '© Witch Beam · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1135690/', 'Phòng trẻ em có giường tầng và gấu bông hồng trong Unpacking', 1, '2026-11-04 01:50:07'),
(100, 26, 'screenshot', '/public/uploads/seed/unpacking-3.webp', '© Witch Beam · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1135690/', 'Phòng tắm với bồn tắm, bồn rửa và thùng đồ trong Unpacking', 2, '2026-11-04 01:50:07'),
(101, 26, 'screenshot', '/public/uploads/seed/unpacking-4.webp', '© Witch Beam · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1135690/', 'Phòng khách có tivi, sofa xanh và ma-nơ-canh váy cam trong Unpacking', 3, '2026-11-04 01:50:07'),
(102, 26, 'external_link', 'https://store.steampowered.com/app/1135690/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(103, 26, 'external_link', 'https://www.unpackinggame.com/', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(104, 27, 'screenshot', '/public/uploads/seed/loop-hero-1.webp', '© Four Quarters · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1282730/', 'Vòng đường đi qua làng, nghĩa địa và rừng trong Loop Hero', 0, '2026-11-04 01:50:07'),
(105, 27, 'screenshot', '/public/uploads/seed/loop-hero-2.webp', '© Four Quarters · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1282730/', 'Màn hình xây dựng trại với các công trình trong Loop Hero', 1, '2026-11-04 01:50:07'),
(106, 27, 'screenshot', '/public/uploads/seed/loop-hero-3.webp', '© Four Quarters · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1282730/', 'Trận chiến giữa người hùng và bộ xương trong Loop Hero', 2, '2026-11-04 01:50:07'),
(107, 27, 'screenshot', '/public/uploads/seed/loop-hero-4.webp', '© Four Quarters · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1282730/', 'Bảng chọn đặc điểm mới cho chuyến đi trong Loop Hero', 3, '2026-11-04 01:50:07'),
(108, 27, 'external_link', 'https://store.steampowered.com/app/1282730/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(109, 27, 'external_link', 'http://loophero.com', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(110, 28, 'screenshot', '/public/uploads/seed/dredge-1.webp', '© Black Salt Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1562430/', 'Thuyền đánh cá cạnh ngọn hải đăng lúc hoàng hôn trong DREDGE', 0, '2026-11-04 01:50:07'),
(111, 28, 'screenshot', '/public/uploads/seed/dredge-2.webp', '© Black Salt Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1562430/', 'Thuyền nhỏ câu cá ở vùng nước động với khoang chứa hàng trong DREDGE', 1, '2026-11-04 01:50:07'),
(112, 28, 'screenshot', '/public/uploads/seed/dredge-3.webp', '© Black Salt Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1562430/', 'Thuyền đi giữa rừng ngập mặn trong DREDGE', 2, '2026-11-04 01:50:07'),
(113, 28, 'screenshot', '/public/uploads/seed/dredge-4.webp', '© Black Salt Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1562430/', 'Thợ đóng thuyền và màn hình nâng cấp trong DREDGE', 3, '2026-11-04 01:50:07'),
(114, 28, 'external_link', 'https://store.steampowered.com/app/1562430/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(115, 28, 'external_link', 'https://www.dredge.game/', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(116, 29, 'screenshot', '/public/uploads/seed/ftl-faster-than-light-1.webp', '© Subset Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/212680/', 'Phi thuyền Kestrel bị kẻ địch đột nhập trong FTL: Faster Than Light', 0, '2026-11-04 01:50:07'),
(117, 29, 'screenshot', '/public/uploads/seed/ftl-faster-than-light-2.webp', '© Subset Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/212680/', 'Giao tranh giữa hai phi thuyền trong FTL: Faster Than Light', 1, '2026-11-04 01:50:07'),
(118, 29, 'screenshot', '/public/uploads/seed/ftl-faster-than-light-3.webp', '© Subset Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/212680/', 'Sự kiện cầu cứu từ thuộc địa khai mỏ trong FTL: Faster Than Light', 2, '2026-11-04 01:50:07'),
(119, 29, 'screenshot', '/public/uploads/seed/ftl-faster-than-light-4.webp', '© Subset Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/212680/', 'Phi thuyền bị hư hại nặng giữa trận chiến trong FTL: Faster Than Light', 3, '2026-11-04 01:50:07'),
(120, 29, 'external_link', 'https://store.steampowered.com/app/212680/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(121, 29, 'external_link', 'https://subsetgames.com/ftl.html', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(122, 30, 'screenshot', '/public/uploads/seed/dont-starve-1.webp', '© Klei Entertainment · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/219740/', 'Căn cứ có tường đá, lều và nồi nấu trong Don\'t Starve', 0, '2026-11-04 01:50:07'),
(123, 30, 'screenshot', '/public/uploads/seed/dont-starve-2.webp', '© Klei Entertainment · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/219740/', 'Wilson gặp sinh vật lạ trong rừng thông của Don\'t Starve', 1, '2026-11-04 01:50:07'),
(124, 30, 'screenshot', '/public/uploads/seed/dont-starve-3.webp', '© Klei Entertainment · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/219740/', 'Wilson cầm rìu đối mặt với nhện khổng lồ trong Don\'t Starve', 2, '2026-11-04 01:50:07'),
(125, 30, 'screenshot', '/public/uploads/seed/dont-starve-4.webp', '© Klei Entertainment · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/219740/', 'Wilson thổi tù và giữa đàn beefalo trong Don\'t Starve', 3, '2026-11-04 01:50:07'),
(126, 30, 'external_link', 'https://store.steampowered.com/app/219740/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(127, 30, 'external_link', 'https://www.dontstarvegame.com', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(128, 31, 'screenshot', '/public/uploads/seed/balatro-1.webp', '© LocalThunk · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/2379780/', 'Đánh tay Two Pair ở vòng Big Blind trong Balatro', 0, '2026-11-04 01:50:07'),
(129, 31, 'screenshot', '/public/uploads/seed/balatro-2.webp', '© LocalThunk · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/2379780/', 'Lá Tarot Justice cùng tay bài trên nền tím trong Balatro', 1, '2026-11-04 01:50:07'),
(130, 31, 'screenshot', '/public/uploads/seed/balatro-3.webp', '© LocalThunk · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/2379780/', 'Combo nhân điểm lớn ở vòng trùm The Eye trong Balatro', 2, '2026-11-04 01:50:07'),
(131, 31, 'screenshot', '/public/uploads/seed/balatro-4.webp', '© LocalThunk · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/2379780/', 'Bộ sưu tập các lá Joker trong Balatro', 3, '2026-11-04 01:50:07'),
(132, 31, 'external_link', 'https://store.steampowered.com/app/2379780/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(133, 31, 'external_link', 'https://www.playbalatro.com/', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(134, 32, 'screenshot', '/public/uploads/seed/darkest-dungeon-1.webp', '© Red Hook Studios · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/262060/', 'Đội bốn anh hùng đối đầu bộ xương trong hầm ngục Darkest Dungeon', 0, '2026-11-04 01:50:07'),
(135, 32, 'screenshot', '/public/uploads/seed/darkest-dungeon-2.webp', '© Red Hook Studios · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/262060/', 'Đội anh hùng trước các xác ướp trong Darkest Dungeon', 1, '2026-11-04 01:50:07'),
(136, 32, 'screenshot', '/public/uploads/seed/darkest-dungeon-3.webp', '© Red Hook Studios · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/262060/', 'Bảng thông tin nhân vật Jester ở điền trang trong Darkest Dungeon', 2, '2026-11-04 01:50:07'),
(137, 32, 'screenshot', '/public/uploads/seed/darkest-dungeon-4.webp', '© Red Hook Studios · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/262060/', 'Trận chiến với quái vật biển trong Darkest Dungeon', 3, '2026-11-04 01:50:07'),
(138, 32, 'external_link', 'https://store.steampowered.com/app/262060/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(139, 32, 'external_link', 'http://www.darkestdungeon.com', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(140, 33, 'screenshot', '/public/uploads/seed/cuphead-1.webp', '© Studio MDHR Entertainment Inc. · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/268910/', 'Cuphead và Mugman chạy trên thân cây trong rừng của Cuphead', 0, '2026-11-04 01:50:07'),
(141, 33, 'screenshot', '/public/uploads/seed/cuphead-2.webp', '© Studio MDHR Entertainment Inc. · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/268910/', 'Trận đánh trùm hề Beppi ở khu vui chơi trong Cuphead', 1, '2026-11-04 01:50:07'),
(142, 33, 'screenshot', '/public/uploads/seed/cuphead-3.webp', '© Studio MDHR Entertainment Inc. · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/268910/', 'Cuphead bay máy bay giữa các xe đụng trong Cuphead', 2, '2026-11-04 01:50:07'),
(143, 33, 'screenshot', '/public/uploads/seed/cuphead-4.webp', '© Studio MDHR Entertainment Inc. · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/268910/', 'Trận đánh trùm cột totem trên sa mạc trong Cuphead', 3, '2026-11-04 01:50:07'),
(144, 33, 'external_link', 'https://store.steampowered.com/app/268910/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(145, 33, 'external_link', 'http://www.cupheadgame.com', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(146, 34, 'screenshot', '/public/uploads/seed/rimworld-1.webp', '© Ludeon Studios · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/294100/', 'Thuộc địa đông người với bảng thông tin nhân vật trong RimWorld', 0, '2026-11-04 01:50:07'),
(147, 34, 'screenshot', '/public/uploads/seed/rimworld-2.webp', '© Ludeon Studios · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/294100/', 'Thuộc địa giữa vùng băng tuyết trong RimWorld', 1, '2026-11-04 01:50:07'),
(148, 34, 'screenshot', '/public/uploads/seed/rimworld-3.webp', '© Ludeon Studios · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/294100/', 'Căn cứ trong rừng rậm nhiệt đới trong RimWorld', 2, '2026-11-04 01:50:07'),
(149, 34, 'screenshot', '/public/uploads/seed/rimworld-4.webp', '© Ludeon Studios · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/294100/', 'Màn hình tạo nhân vật trên nền hành tinh trong RimWorld', 3, '2026-11-04 01:50:07'),
(150, 34, 'external_link', 'https://store.steampowered.com/app/294100/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(151, 34, 'external_link', 'https://ludeon.com', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(152, 35, 'screenshot', '/public/uploads/seed/enter-the-gungeon-1.webp', '© Dodge Roll · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/311690/', 'Trận đánh trùm đỏ với pháo hoa đạn trong Enter the Gungeon', 0, '2026-11-04 01:50:07'),
(153, 35, 'screenshot', '/public/uploads/seed/enter-the-gungeon-2.webp', '© Dodge Roll · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/311690/', 'Làn đạn hình ngôi sao trong phòng hầm ngục của Enter the Gungeon', 1, '2026-11-04 01:50:07'),
(154, 35, 'screenshot', '/public/uploads/seed/enter-the-gungeon-3.webp', '© Dodge Roll · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/311690/', 'Trùm hình viên đạn bắn tia laser xanh trong Enter the Gungeon', 2, '2026-11-04 01:50:07'),
(155, 35, 'screenshot', '/public/uploads/seed/enter-the-gungeon-4.webp', '© Dodge Roll · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/311690/', 'Phòng hầm ngục với nhiều tia laser đỏ trong Enter the Gungeon', 3, '2026-11-04 01:50:07'),
(156, 35, 'external_link', 'https://store.steampowered.com/app/311690/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(157, 35, 'external_link', 'http://www.enterthegungeon.com', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(158, 36, 'screenshot', '/public/uploads/seed/undertale-1.webp', '© tobyfox · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/391540/', 'Đoạn mở đầu kể về cuộc chiến giữa loài người và quái vật trong UNDERTALE', 0, '2026-11-04 01:50:07'),
(159, 36, 'screenshot', '/public/uploads/seed/undertale-2.webp', '© tobyfox · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/391540/', 'Nhân vật nằm trên thảm hoa vàng dưới hang sâu trong UNDERTALE', 1, '2026-11-04 01:50:07'),
(160, 36, 'screenshot', '/public/uploads/seed/undertale-3.webp', '© tobyfox · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/391540/', 'Trận đấu với Froggit và Whimsun cùng các nút FIGHT, ACT, ITEM, MERCY trong UNDERTALE', 2, '2026-11-04 01:50:07'),
(161, 36, 'screenshot', '/public/uploads/seed/undertale-4.webp', '© tobyfox · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/391540/', 'Nhân vật đứng trên đống lá đỏ trong tàn tích tím của UNDERTALE', 3, '2026-11-04 01:50:07'),
(162, 36, 'external_link', 'https://store.steampowered.com/app/391540/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(163, 36, 'external_link', 'http://undertale.com', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(164, 37, 'screenshot', '/public/uploads/seed/factorio-1.webp', '© Wube Software LTD. · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/427520/', 'Xác tàu bốc cháy trên sa mạc ở đầu game Factorio', 0, '2026-11-04 01:50:07'),
(165, 37, 'screenshot', '/public/uploads/seed/factorio-2.webp', '© Wube Software LTD. · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/427520/', 'Khu nhà máy với đường ống và băng chuyền trong Factorio', 1, '2026-11-04 01:50:07'),
(166, 37, 'screenshot', '/public/uploads/seed/factorio-3.webp', '© Wube Software LTD. · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/427520/', 'Tháp phòng thủ trước tổ sinh vật bản địa về đêm trong Factorio', 2, '2026-11-04 01:50:07'),
(167, 37, 'screenshot', '/public/uploads/seed/factorio-4.webp', '© Wube Software LTD. · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/427520/', 'Dây chuyền sản xuất quy mô lớn nhìn từ trên cao trong Factorio', 3, '2026-11-04 01:50:07'),
(168, 37, 'external_link', 'https://store.steampowered.com/app/427520/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(169, 37, 'external_link', 'https://www.factorio.com', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(170, 38, 'screenshot', '/public/uploads/seed/oxygen-not-included-1.webp', '© Klei Entertainment · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/457140/', 'Thuộc địa nhiều tầng bên trong tiểu hành tinh của Oxygen Not Included', 0, '2026-11-04 01:50:07'),
(171, 38, 'screenshot', '/public/uploads/seed/oxygen-not-included-2.webp', '© Klei Entertainment · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/457140/', 'Tên lửa chuẩn bị phóng trong Oxygen Not Included', 1, '2026-11-04 01:50:07'),
(172, 38, 'screenshot', '/public/uploads/seed/oxygen-not-included-3.webp', '© Klei Entertainment · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/457140/', 'Duplicant mặc đồ du hành trong hang khí xanh của Oxygen Not Included', 2, '2026-11-04 01:50:07'),
(173, 38, 'screenshot', '/public/uploads/seed/oxygen-not-included-4.webp', '© Klei Entertainment · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/457140/', 'Các Duplicant nhảy múa trong phòng giải trí của Oxygen Not Included', 3, '2026-11-04 01:50:07'),
(174, 38, 'external_link', 'https://store.steampowered.com/app/457140/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(175, 38, 'external_link', 'https://www.kleientertainment.com/games/oxygen-not-included', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(176, 39, 'screenshot', '/public/uploads/seed/katana-zero-1.webp', '© Askiisoft · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/460950/', 'Phòng khách sang trọng với lò sưởi trong Katana ZERO', 0, '2026-11-04 01:50:07'),
(177, 39, 'screenshot', '/public/uploads/seed/katana-zero-2.webp', '© Askiisoft · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/460950/', 'Trận đấu trong khoang tàu hỏa của Katana ZERO', 1, '2026-11-04 01:50:07'),
(178, 39, 'screenshot', '/public/uploads/seed/katana-zero-3.webp', '© Askiisoft · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/460950/', 'Nhát chém lướt qua hành lang neon trong Katana ZERO', 2, '2026-11-04 01:50:07'),
(179, 39, 'screenshot', '/public/uploads/seed/katana-zero-4.webp', '© Askiisoft · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/460950/', 'Hộp đêm với đèn laser xanh trong Katana ZERO', 3, '2026-11-04 01:50:07'),
(180, 39, 'external_link', 'https://store.steampowered.com/app/460950/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(181, 39, 'external_link', 'http://www.katanazero.com/', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(182, 40, 'screenshot', '/public/uploads/seed/night-in-the-woods-1.webp', '© Infinite Fall · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/481510/', 'Phố mùa thu với lá vàng và nhà gạch trong Night in the Woods', 0, '2026-11-04 01:50:07'),
(183, 40, 'screenshot', '/public/uploads/seed/night-in-the-woods-2.webp', '© Infinite Fall · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/481510/', 'Nhóm bạn đứng trong rừng về đêm trong Night in the Woods', 1, '2026-11-04 01:50:07'),
(184, 40, 'screenshot', '/public/uploads/seed/night-in-the-woods-3.webp', '© Infinite Fall · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/481510/', 'Mae và bạn bè trước cửa hàng Miller\'s trong Night in the Woods', 2, '2026-11-04 01:50:07'),
(185, 40, 'screenshot', '/public/uploads/seed/night-in-the-woods-4.webp', '© Infinite Fall · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/481510/', 'Mae đứng trên mái nhà trong Night in the Woods', 3, '2026-11-04 01:50:07'),
(186, 40, 'external_link', 'https://store.steampowered.com/app/481510/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(187, 40, 'external_link', 'http://nightinthewoods.com', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(188, 41, 'screenshot', '/public/uploads/seed/tunic-1.webp', '© TUNIC Team · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/553420/', 'Chú cáo trên vách đá bên bờ biển trong TUNIC', 0, '2026-11-04 01:50:07'),
(189, 41, 'screenshot', '/public/uploads/seed/tunic-2.webp', '© TUNIC Team · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/553420/', 'Chú cáo chiến đấu với quái chất nhầy xanh trong TUNIC', 1, '2026-11-04 01:50:07'),
(190, 41, 'screenshot', '/public/uploads/seed/tunic-3.webp', '© TUNIC Team · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/553420/', 'Trận đấu với kẻ địch pha lê trên cây cầu trong TUNIC', 2, '2026-11-04 01:50:07'),
(191, 41, 'screenshot', '/public/uploads/seed/tunic-4.webp', '© TUNIC Team · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/553420/', 'Hòn đảo bay giữa trời mây trong TUNIC', 3, '2026-11-04 01:50:07'),
(192, 41, 'external_link', 'https://store.steampowered.com/app/553420/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(193, 41, 'external_link', 'https://www.tunicgame.com/', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(194, 42, 'screenshot', '/public/uploads/seed/into-the-breach-1.webp', '© Subset Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/590380/', 'Bản đồ chiến thuật với robot và quái Vek trong Into the Breach', 0, '2026-11-04 01:50:07'),
(195, 42, 'screenshot', '/public/uploads/seed/into-the-breach-2.webp', '© Subset Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/590380/', 'Màn hình chọn đội robot trong Into the Breach', 1, '2026-11-04 01:50:07'),
(196, 42, 'screenshot', '/public/uploads/seed/into-the-breach-3.webp', '© Subset Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/590380/', 'Giới thiệu nhiệm vụ ở Rust District trong Into the Breach', 2, '2026-11-04 01:50:07'),
(197, 42, 'screenshot', '/public/uploads/seed/into-the-breach-4.webp', '© Subset Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/590380/', 'Robot bảo vệ công trình giữa nhiều quái vật trong Into the Breach', 3, '2026-11-04 01:50:07'),
(198, 42, 'external_link', 'https://store.steampowered.com/app/590380/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(199, 43, 'screenshot', '/public/uploads/seed/return-of-the-obra-dinn-1.webp', '© Lucas Pope · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/653530/', 'Thông báo tàu Obra Dinn mất tích năm 1803 trong Return of the Obra Dinn', 0, '2026-11-04 01:50:07'),
(200, 43, 'screenshot', '/public/uploads/seed/return-of-the-obra-dinn-2.webp', '© Lucas Pope · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/653530/', 'Chiếc đồng hồ bỏ túi trước một bộ xương trên boong tàu trong Return of the Obra Dinn', 1, '2026-11-04 01:50:07'),
(201, 43, 'screenshot', '/public/uploads/seed/return-of-the-obra-dinn-3.webp', '© Lucas Pope · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/653530/', 'Cuốn sổ ghi chép mở trong Return of the Obra Dinn', 2, '2026-11-04 01:50:07');
INSERT INTO `media_tro_choi` (`ma`, `tro_choi_id`, `loai_media`, `url_media`, `chu_thich`, `van_ban_thay_the`, `thu_tu_sap_xep`, `ngay_tao`) VALUES
(202, 43, 'screenshot', '/public/uploads/seed/return-of-the-obra-dinn-4.webp', '© Lucas Pope · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/653530/', 'Khoang tàu với rương và chuồng gỗ trong Return of the Obra Dinn', 3, '2026-11-04 01:50:07'),
(203, 43, 'external_link', 'https://store.steampowered.com/app/653530/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(204, 43, 'external_link', 'https://obradinn.com', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(205, 44, 'screenshot', '/public/uploads/seed/baba-is-you-1.webp', '© Hempuli Oy · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/736260/', 'Màn chơi có luật BABA IS YOU và FLAG IS WIN trong Baba Is You', 0, '2026-11-04 01:50:07'),
(206, 44, 'screenshot', '/public/uploads/seed/baba-is-you-2.webp', '© Hempuli Oy · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/736260/', 'Màn chơi với chìa khóa và cửa đỏ trong Baba Is You', 1, '2026-11-04 01:50:07'),
(207, 44, 'screenshot', '/public/uploads/seed/baba-is-you-3.webp', '© Hempuli Oy · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/736260/', 'Màn chơi với các khối chữ KEY IS và cửa trong Baba Is You', 2, '2026-11-04 01:50:07'),
(208, 44, 'screenshot', '/public/uploads/seed/baba-is-you-4.webp', '© Hempuli Oy · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/736260/', 'Màn chơi có hàng rào và cỏ dại trong Baba Is You', 3, '2026-11-04 01:50:07'),
(209, 44, 'external_link', 'https://store.steampowered.com/app/736260/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(210, 44, 'external_link', 'https://www.hempuli.com/Baba/', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(211, 45, 'screenshot', '/public/uploads/seed/outer-wilds-1.webp', '© Mobius Digital · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/753640/', 'Đài quan sát và rừng thông trên hành tinh quê nhà trong Outer Wilds', 0, '2026-11-04 01:50:07'),
(212, 45, 'screenshot', '/public/uploads/seed/outer-wilds-2.webp', '© Mobius Digital · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/753640/', 'Bảng dịch chữ cổ trước bức tường khắc trong Outer Wilds', 1, '2026-11-04 01:50:07'),
(213, 45, 'screenshot', '/public/uploads/seed/outer-wilds-3.webp', '© Mobius Digital · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/753640/', 'Cá câu khổng lồ trong màn sương của Outer Wilds', 2, '2026-11-04 01:50:07'),
(214, 45, 'screenshot', '/public/uploads/seed/outer-wilds-4.webp', '© Mobius Digital · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/753640/', 'Buồng lái phi thuyền gỗ trong Outer Wilds', 3, '2026-11-04 01:50:07'),
(215, 45, 'external_link', 'https://store.steampowered.com/app/753640/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(216, 46, 'screenshot', '/public/uploads/seed/spiritfarer-1.webp', '© Thunder Lotus · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/972660/', 'Bữa tối dưới đèn lồng cùng các linh hồn trong Spiritfarer', 0, '2026-11-04 01:50:07'),
(217, 46, 'screenshot', '/public/uploads/seed/spiritfarer-2.webp', '© Thunder Lotus · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/972660/', 'Chế độ xây dựng con thuyền nhiều tầng trong Spiritfarer', 1, '2026-11-04 01:50:07'),
(218, 46, 'screenshot', '/public/uploads/seed/spiritfarer-3.webp', '© Thunder Lotus · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/972660/', 'Stella cùng hành khách trên thuyền giữa biển đỏ trong Spiritfarer', 2, '2026-11-04 01:50:07'),
(219, 46, 'screenshot', '/public/uploads/seed/spiritfarer-4.webp', '© Thunder Lotus · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/972660/', 'Bản đồ biển với các hòn đảo trong Spiritfarer', 3, '2026-11-04 01:50:07'),
(220, 46, 'external_link', 'https://store.steampowered.com/app/972660/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(221, 46, 'external_link', 'https://thunderlotusgames.com/spiritfarer', 'Trang chủ chính thức', NULL, 101, '2026-11-04 01:50:07'),
(222, 47, 'screenshot', '/public/uploads/seed/warzone-2100-1.webp', '© Pumpkin Studios, Underdone Gaming, Warzone 2100 Project · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1241950/', 'Xe tăng chiến đấu cạnh căn cứ trong Warzone 2100', 0, '2026-11-04 01:50:07'),
(223, 47, 'screenshot', '/public/uploads/seed/warzone-2100-2.webp', '© Pumpkin Studios, Underdone Gaming, Warzone 2100 Project · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1241950/', 'Đoàn quân di chuyển trên địa hình đồi núi trong Warzone 2100', 1, '2026-11-04 01:50:07'),
(224, 47, 'screenshot', '/public/uploads/seed/warzone-2100-3.webp', '© Pumpkin Studios, Underdone Gaming, Warzone 2100 Project · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1241950/', 'Giao tranh giữa hai đội xe trong Warzone 2100', 2, '2026-11-04 01:50:07'),
(225, 47, 'screenshot', '/public/uploads/seed/warzone-2100-4.webp', '© Pumpkin Studios, Underdone Gaming, Warzone 2100 Project · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1241950/', 'Màn hình thiết kế xe cạnh căn cứ trong Warzone 2100', 3, '2026-11-04 01:50:07'),
(226, 47, 'external_link', 'https://wz2100.net', 'Trang chủ chính thức', NULL, 100, '2026-11-04 01:50:07'),
(227, 47, 'external_link', 'https://store.steampowered.com/app/1241950/', 'Trang Steam chính thức', NULL, 101, '2026-11-04 01:50:07'),
(228, 47, 'external_link', 'https://github.com/Warzone2100/warzone2100', 'Mã nguồn', NULL, 102, '2026-11-04 01:50:07'),
(229, 48, 'screenshot', '/public/uploads/seed/muck-1.webp', '© Dani · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1625450/', 'Trận đánh với rồng xanh khạc lửa trong Muck', 0, '2026-11-04 01:50:07'),
(230, 48, 'screenshot', '/public/uploads/seed/muck-2.webp', '© Dani · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1625450/', 'Người chơi chiến đấu với bò và quái trên đồng cỏ trong Muck', 1, '2026-11-04 01:50:07'),
(231, 48, 'screenshot', '/public/uploads/seed/muck-3.webp', '© Dani · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1625450/', 'Kiếm chém quái vật giữa đồng cỏ vàng trong Muck', 2, '2026-11-04 01:50:07'),
(232, 48, 'screenshot', '/public/uploads/seed/muck-4.webp', '© Dani · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/1625450/', 'Cột sáng xanh giữa khu rừng low-poly trong Muck', 3, '2026-11-04 01:50:07'),
(233, 48, 'external_link', 'https://store.steampowered.com/app/1625450/', 'Trang Steam chính thức', NULL, 100, '2026-11-04 01:50:07'),
(234, 49, 'screenshot', '/public/uploads/seed/unturned-1.webp', '© Smartly Dressed Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/304930/', 'Đấu súng dưới mái hiên trạm xăng trong Unturned', 0, '2026-11-04 01:50:07'),
(235, 49, 'screenshot', '/public/uploads/seed/unturned-2.webp', '© Smartly Dressed Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/304930/', 'Ba người chơi bên bàn gỗ với con cá lớn trong Unturned', 1, '2026-11-04 01:50:07'),
(236, 49, 'screenshot', '/public/uploads/seed/unturned-3.webp', '© Smartly Dressed Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/304930/', 'Quán ăn sàn caro với quầy bar trong Unturned', 2, '2026-11-04 01:50:07'),
(237, 49, 'screenshot', '/public/uploads/seed/unturned-4.webp', '© Smartly Dressed Games · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/304930/', 'Hang động tối với nấm phát sáng trong Unturned', 3, '2026-11-04 01:50:07'),
(238, 49, 'external_link', 'https://smartlydressedgames.com/unturned/', 'Trang chủ chính thức', NULL, 100, '2026-11-04 01:50:07'),
(239, 49, 'external_link', 'https://store.steampowered.com/app/304930/', 'Trang Steam chính thức', NULL, 101, '2026-11-04 01:50:07'),
(240, 50, 'screenshot', '/public/uploads/seed/zero-k-1.webp', '© Zero-K Team · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/334920/', 'Căn cứ và đội quân trên sa mạc trong Zero-K', 0, '2026-11-04 01:50:07'),
(241, 50, 'screenshot', '/public/uploads/seed/zero-k-2.webp', '© Zero-K Team · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/334920/', 'Tia laser bắn xuống bờ biển trong Zero-K', 1, '2026-11-04 01:50:07'),
(242, 50, 'screenshot', '/public/uploads/seed/zero-k-3.webp', '© Zero-K Team · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/334920/', 'Bản đồ chiến dịch giữa thiên hà trong Zero-K', 2, '2026-11-04 01:50:07'),
(243, 50, 'screenshot', '/public/uploads/seed/zero-k-4.webp', '© Zero-K Team · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/334920/', 'Trận chiến trên địa hình dung nham trong Zero-K', 3, '2026-11-04 01:50:07'),
(244, 50, 'external_link', 'https://zero-k.info', 'Trang chủ chính thức', NULL, 100, '2026-11-04 01:50:07'),
(245, 50, 'external_link', 'https://store.steampowered.com/app/334920/', 'Trang Steam chính thức', NULL, 101, '2026-11-04 01:50:07'),
(246, 50, 'external_link', 'https://github.com/ZeroK-RTS/Zero-K', 'Mã nguồn', NULL, 102, '2026-11-04 01:50:07'),
(247, 51, 'screenshot', '/public/uploads/seed/teeworlds-1.webp', '© Teeworlds Team · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/380840/', 'Người chơi bắn nhau trên các mỏm đất giữa trời xanh trong Teeworlds', 0, '2026-11-04 01:50:07'),
(248, 51, 'screenshot', '/public/uploads/seed/teeworlds-2.webp', '© Teeworlds Team · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/380840/', 'Trận đấu trên bản đồ sa mạc đỏ trong Teeworlds', 1, '2026-11-04 01:50:07'),
(249, 51, 'screenshot', '/public/uploads/seed/teeworlds-3.webp', '© Teeworlds Team · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/380840/', 'Người chơi dùng móc kéo đu qua bãi gai trong Teeworlds', 2, '2026-11-04 01:50:07'),
(250, 51, 'screenshot', '/public/uploads/seed/teeworlds-4.webp', '© Teeworlds Team · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/380840/', 'Trận đấu trong hang tối có tượng đá trong Teeworlds', 3, '2026-11-04 01:50:07'),
(251, 51, 'external_link', 'https://www.teeworlds.com/', 'Trang chủ chính thức', NULL, 100, '2026-11-04 01:50:07'),
(252, 51, 'external_link', 'https://store.steampowered.com/app/380840/', 'Trang Steam chính thức', NULL, 101, '2026-11-04 01:50:07'),
(253, 51, 'external_link', 'https://github.com/teeworlds/teeworlds', 'Mã nguồn', NULL, 102, '2026-11-04 01:50:07'),
(254, 52, 'screenshot', '/public/uploads/seed/endless-sky-1.webp', '© Michael Zahniser · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/404410/', 'Phi thuyền bay gần hành tinh trong Endless Sky', 0, '2026-11-04 01:50:07'),
(255, 52, 'screenshot', '/public/uploads/seed/endless-sky-2.webp', '© Michael Zahniser · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/404410/', 'Giao tranh giữa các phi thuyền trong Endless Sky', 1, '2026-11-04 01:50:07'),
(256, 52, 'screenshot', '/public/uploads/seed/endless-sky-3.webp', '© Michael Zahniser · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/404410/', 'Xưởng đóng tàu với nhiều mẫu phi thuyền trong Endless Sky', 2, '2026-11-04 01:50:07'),
(257, 52, 'screenshot', '/public/uploads/seed/endless-sky-4.webp', '© Michael Zahniser · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/404410/', 'Cửa hàng trang bị vũ khí và động cơ trong Endless Sky', 3, '2026-11-04 01:50:07'),
(258, 52, 'external_link', 'https://endless-sky.github.io/', 'Trang chủ chính thức', NULL, 100, '2026-11-04 01:50:07'),
(259, 52, 'external_link', 'https://store.steampowered.com/app/404410/', 'Trang Steam chính thức', NULL, 101, '2026-11-04 01:50:07'),
(260, 52, 'external_link', 'https://github.com/endless-sky/endless-sky', 'Mã nguồn', NULL, 102, '2026-11-04 01:50:07'),
(261, 53, 'screenshot', '/public/uploads/seed/emily-is-away-1.webp', '© Kyle Seeley · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/417860/', 'Cửa sổ đăng nhập ứng dụng chat trong Emily is Away', 0, '2026-11-04 01:50:07'),
(262, 53, 'screenshot', '/public/uploads/seed/emily-is-away-2.webp', '© Kyle Seeley · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/417860/', 'Khung chat với ba lựa chọn câu chào trong Emily is Away', 1, '2026-11-04 01:50:07'),
(263, 53, 'screenshot', '/public/uploads/seed/emily-is-away-3.webp', '© Kyle Seeley · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/417860/', 'Đoạn hội thoại về bài hát yêu thích trong Emily is Away', 2, '2026-11-04 01:50:07'),
(264, 53, 'screenshot', '/public/uploads/seed/emily-is-away-4.webp', '© Kyle Seeley · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/417860/', 'Hồ sơ cá nhân của Emily trong Emily is Away', 3, '2026-11-04 01:50:07'),
(265, 53, 'external_link', 'http://emilyisaway.com/', 'Trang chủ chính thức', NULL, 100, '2026-11-04 01:50:07'),
(266, 53, 'external_link', 'https://store.steampowered.com/app/417860/', 'Trang Steam chính thức', NULL, 101, '2026-11-04 01:50:07'),
(267, 54, 'screenshot', '/public/uploads/seed/super-animal-royale-1.webp', '© Pixile · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/843380/', 'Con đại bàng chở người chơi bay qua đảo trong Super Animal Royale', 0, '2026-11-04 01:50:07'),
(268, 54, 'screenshot', '/public/uploads/seed/super-animal-royale-2.webp', '© Pixile · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/843380/', 'Trận đấu giữa khu rừng tuyết trong Super Animal Royale', 1, '2026-11-04 01:50:07'),
(269, 54, 'screenshot', '/public/uploads/seed/super-animal-royale-3.webp', '© Pixile · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/843380/', 'Đấu súng trên quảng trường sa mạc trong Super Animal Royale', 2, '2026-11-04 01:50:07'),
(270, 54, 'screenshot', '/public/uploads/seed/super-animal-royale-4.webp', '© Pixile · Ảnh chụp màn hình chính thức trên Steam, dùng cho mục đích học tập phi thương mại (đã thu nhỏ) · https://store.steampowered.com/app/843380/', 'Trận đấu bên hồ khí độc tím trong Super Animal Royale', 3, '2026-11-04 01:50:07'),
(271, 54, 'external_link', 'https://animalroyale.com', 'Trang chủ chính thức', NULL, 100, '2026-11-04 01:50:07'),
(272, 54, 'external_link', 'https://store.steampowered.com/app/843380/', 'Trang Steam chính thức', NULL, 101, '2026-11-04 01:50:07'),
(273, 78, 'cover', '/public/uploads/seed/tinh-hoa-duong-son.svg', 'Ảnh minh hoạ dự án mẫu', 'Tinh Hoa Đường Sơn', 0, '2026-11-01 08:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `muc_gio_hang`
--

CREATE TABLE `muc_gio_hang` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `gio_hang_id` bigint(20) UNSIGNED NOT NULL,
  `loai_muc` enum('game','bundle') NOT NULL,
  `tro_choi_id` bigint(20) UNSIGNED DEFAULT NULL,
  `goi_game_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ngay_them` timestamp NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `muc_gio_hang`
--

INSERT INTO `muc_gio_hang` (`ma`, `gio_hang_id`, `loai_muc`, `tro_choi_id`, `goi_game_id`, `ngay_them`) VALUES
(125, 32, 'game', 41, NULL, '2026-11-04 02:27:45'),
(126, 32, 'game', 17, NULL, '2026-11-04 02:27:45'),
(127, 40, 'game', 16, NULL, '2026-11-04 02:27:45'),
(128, 40, 'game', 21, NULL, '2026-11-04 02:27:45'),
(129, 39, 'game', 23, NULL, '2026-11-04 02:27:45'),
(130, 39, 'game', 27, NULL, '2026-11-04 02:27:45'),
(131, 14, 'game', 21, NULL, '2026-11-04 02:27:45'),
(132, 14, 'game', 40, NULL, '2026-11-04 02:27:45'),
(133, 25, 'game', 32, NULL, '2026-11-04 02:27:45'),
(134, 25, 'game', 42, NULL, '2026-11-04 02:27:45'),
(135, 37, 'game', 31, NULL, '2026-11-04 02:27:45'),
(136, 37, 'game', 30, NULL, '2026-11-04 02:27:45'),
(137, 26, 'game', 17, NULL, '2026-11-04 02:27:45'),
(138, 26, 'game', 18, NULL, '2026-11-04 02:27:45'),
(139, 12, 'game', 34, NULL, '2026-11-04 02:27:45'),
(140, 12, 'game', 23, NULL, '2026-11-04 02:27:45'),
(141, 21, 'game', 34, NULL, '2026-11-04 02:27:45'),
(142, 21, 'game', 22, NULL, '2026-11-04 02:27:45'),
(143, 7, 'game', 30, NULL, '2026-11-04 02:27:45'),
(144, 7, 'game', 39, NULL, '2026-11-04 02:27:45'),
(145, 29, 'game', 37, NULL, '2026-11-04 02:27:45'),
(146, 29, 'game', 25, NULL, '2026-11-04 02:27:45'),
(147, 9, 'game', 32, NULL, '2026-11-04 02:27:45'),
(148, 9, 'game', 22, NULL, '2026-11-04 02:27:45'),
(149, 16, 'game', 30, NULL, '2026-11-04 02:27:45'),
(150, 16, 'game', 19, NULL, '2026-11-04 02:27:45'),
(151, 5, 'game', 35, NULL, '2026-11-04 02:27:45'),
(152, 5, 'game', 20, NULL, '2026-11-04 02:27:45'),
(153, 33, 'game', 37, NULL, '2026-11-04 02:27:45'),
(154, 33, 'game', 40, NULL, '2026-11-04 02:27:45');

-- --------------------------------------------------------

--
-- Table structure for table `nen_tang`
--

CREATE TABLE `nen_tang` (
  `ma` smallint(5) UNSIGNED NOT NULL,
  `ma_nen_tang` varchar(40) NOT NULL,
  `ten_nen_tang` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nen_tang`
--

INSERT INTO `nen_tang` (`ma`, `ma_nen_tang`, `ten_nen_tang`) VALUES
(1, 'windows', 'Windows'),
(2, 'linux', 'Linux'),
(3, 'macos', 'macOS'),
(4, 'android', 'Android'),
(5, 'ios', 'iOS'),
(6, 'browser', 'Trình duyệt web'),
(7, 'web3d', 'WebGL / WebGPU'),
(8, 'other', 'Khác');

-- --------------------------------------------------------

--
-- Table structure for table `nguoi_dung`
--

CREATE TABLE `nguoi_dung` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `ten_dang_nhap` varchar(50) NOT NULL,
  `email` varchar(254) NOT NULL,
  `mat_khau_da_bam` varchar(255) NOT NULL,
  `ten_hien_thi` varchar(100) NOT NULL,
  `gioi_thieu` text DEFAULT NULL,
  `url_anh_dai_dien` varchar(1000) DEFAULT NULL,
  `url_anh_bia` varchar(1000) DEFAULT NULL,
  `url_website` varchar(500) DEFAULT NULL,
  `ma_quoc_gia` char(2) DEFAULT NULL,
  `ngay_xac_minh_email` datetime DEFAULT NULL,
  `trang_thai` enum('active','suspended','deleted') NOT NULL DEFAULT 'active',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nguoi_dung`
--

INSERT INTO `nguoi_dung` (`ma`, `ten_dang_nhap`, `email`, `mat_khau_da_bam`, `ten_hien_thi`, `gioi_thieu`, `url_anh_dai_dien`, `url_anh_bia`, `url_website`, `ma_quoc_gia`, `ngay_xac_minh_email`, `trang_thai`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(5, 'player_test', 'player_test@test.local', '$2y$10$l1423CoEOV9J5p/prLJZXe6ruaN.SZUilHDrVzzeEG34wWtIifbEi', 'Người chơi thử (tài khoản kiểm thử)', 'Tài khoản kiểm thử tự động.\nDòng hai <script>alert(1)</script>', '/public/uploads/avatars/fbc9fb2b72a5112b1a5a958ebdbdc2e4.png', NULL, 'https://example.com/thu-nghiem', 'VN', NULL, 'active', '2026-11-03 07:34:03', '2026-11-03 07:45:04'),
(6, 'admin_test', 'admin_test@test.local', '$2y$10$eA4KMcQFWQRsTY5Ab3qKVupQTbcOP4QOz0sbywiEYf4YDRVY03gVW', 'Quản trị viên (tài khoản thử)', 'Tài khoản thử nghiệm dùng để kiểm tra khu vực quản trị. Không phải người thật.', NULL, NULL, NULL, NULL, '2026-11-03 15:14:08', 'active', '2026-11-03 08:14:08', '2026-11-03 08:14:08'),
(7, 'mod_test', 'mod_test@test.local', '$2y$10$5V0AuNHt7/brjJ8JWbpSyOLL09aMlNMcLUoWKPgVttb2E.7YluPaS', 'Điều hành viên (tài khoản thử)', 'Tài khoản thử nghiệm dùng để kiểm tra luồng kiểm duyệt. Không phải người thật.', NULL, NULL, NULL, NULL, '2026-11-03 15:14:08', 'active', '2026-11-03 08:14:08', '2026-11-03 08:54:04'),
(8, 'dev_test', 'dev_test@test.local', '$2y$10$oe4SH7KUJEHTTroJHBtQiOlzMZT1JDHzewySowNE3CXmNbZ9aMqXi', 'Nhà phát triển (tài khoản thử)', 'Tài khoản thử nghiệm dùng để kiểm tra khu vực nhà phát triển. Không phải người thật.', NULL, NULL, NULL, NULL, '2026-11-03 15:14:08', 'active', '2026-11-03 08:14:08', '2026-11-03 08:14:08'),
(9, 'mau_wildfire', 'mau_wildfire@test.local', '$2y$10$0YVk2g4.9ftcBD2rZmdbEuJsVrtF3.XvKQ5jPs8Kdn3k01lwwOUY2', 'Wildfire Games (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu dự án mã nguồn mở “0 A.D.”. Tài khoản này không do nhóm phát triển thật quản lý. Tải bản chính thức tại trang chủ của dự án.', NULL, NULL, 'https://play0ad.com/', NULL, '2026-11-03 15:23:04', 'active', '2026-11-03 08:23:04', '2026-11-03 08:37:46'),
(10, 'mau_stk', 'mau_stk@test.local', '$2y$10$8ydK3xj9QD5MycTIo5L/9ucjtZ5b7utk.9wr5H6Wal90SF6HC4YTK', 'Nhóm SuperTuxKart (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu dự án mã nguồn mở “SuperTuxKart”. Tài khoản này không do nhóm phát triển thật quản lý. Tải bản chính thức tại trang chủ của dự án.', NULL, NULL, 'https://supertuxkart.net/', NULL, '2026-11-03 15:23:04', 'active', '2026-11-03 08:23:04', '2026-11-03 08:37:46'),
(11, 'mau_wesnoth', 'mau_wesnoth@test.local', '$2y$10$R4VAwp.Xq/QJOTi5gViRo.4YLr9nFHmFhwIJgVjPhTFXowXTkMK6.', 'Nhóm Battle for Wesnoth (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu dự án mã nguồn mở “The Battle for Wesnoth”. Tài khoản này không do nhóm phát triển thật quản lý. Tải bản chính thức tại trang chủ của dự án.', NULL, NULL, 'https://www.wesnoth.org/', NULL, '2026-11-03 15:23:04', 'active', '2026-11-03 08:23:04', '2026-11-03 08:37:46'),
(12, 'mau_luanti', 'mau_luanti@test.local', '$2y$10$BfzDq8YSGEHDXzbKDa42aOgR7gaq4Nc9svmx75FNCppoYcwWDdm1.', 'Nhóm Luanti (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu dự án mã nguồn mở “Luanti”. Tài khoản này không do nhóm phát triển thật quản lý. Tải bản chính thức tại trang chủ của dự án.', NULL, NULL, 'https://www.luanti.org/', NULL, '2026-11-03 15:23:05', 'active', '2026-11-03 08:23:05', '2026-11-03 08:37:46'),
(13, 'mau_mindustry', 'mau_mindustry@test.local', '$2y$10$.c/IAA0L5acTcfNjZ44V0eTmeq3292askeVEQk/mL8OsD1UiPvrby', 'Dự án Mindustry (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu dự án mã nguồn mở “Mindustry”. Tài khoản này không do nhóm phát triển thật quản lý. Tải bản chính thức tại trang chủ của dự án.', NULL, NULL, 'https://mindustrygame.github.io/', NULL, '2026-11-03 15:23:05', 'active', '2026-11-03 08:23:05', '2026-11-03 08:37:46'),
(14, 'mau_openttd', 'mau_openttd@test.local', '$2y$10$X3H7CRBCBSA1u/ML4qjww.GoqKOh0eDV./pRPA9MpabnZ8QcmvAha', 'Nhóm OpenTTD (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu dự án mã nguồn mở “OpenTTD”. Tài khoản này không do nhóm phát triển thật quản lý. Tải bản chính thức tại trang chủ của dự án.', NULL, NULL, 'https://www.openttd.org/', NULL, '2026-11-03 15:23:05', 'active', '2026-11-03 08:23:05', '2026-11-03 08:37:46'),
(15, 'mau_xonotic', 'mau_xonotic@test.local', '$2y$10$dHzXKC3.PLYBMc/ujfPw6eyTdvYiuUIhuIA58rAblIY2/yrWxJCM2', 'Team Xonotic (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu dự án mã nguồn mở “Xonotic”. Tài khoản này không do nhóm phát triển thật quản lý. Tải bản chính thức tại trang chủ của dự án.', NULL, NULL, 'https://xonotic.org/', NULL, '2026-11-03 15:23:05', 'active', '2026-11-03 08:23:05', '2026-11-03 08:37:46'),
(16, 'mau_freeciv', 'mau_freeciv@test.local', '$2y$10$Rw69FR40lHP7Oz/VO/A3OOvVIpxM94n9nHB6sboCHpy4VcNMAIsne', 'Dự án Freeciv (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu dự án mã nguồn mở “Freeciv”. Tài khoản này không do nhóm phát triển thật quản lý. Tải bản chính thức tại trang chủ của dự án.', NULL, NULL, 'https://www.freeciv.org/', NULL, '2026-11-03 15:23:05', 'active', '2026-11-03 08:23:05', '2026-11-03 08:37:46'),
(17, 'minhkhoa_dev', 'minhkhoa_dev@cong-dong.seed.local', '$2y$10$k1q//kwLzqjtnDcYR92.U.JXrp8ZSIkpA.WEWFn3l09zqz67ZzMTK', 'Minh Khoa', 'Lập trình viên Godot nghiệp dư. Đang làm một game platformer nhỏ vào buổi tối.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/41aedd3c8ba1b2d6b173daa886fc12cd.png', NULL, NULL, 'VN', '2026-04-27 03:08:46', 'active', '2026-04-26 20:08:46', '2026-04-26 20:08:46'),
(18, 'lananh_pixel', 'lananh_pixel@cong-dong.seed.local', '$2y$10$4pEKiaKQCBkU1n/0i4G2o.EWAsPzZ1z2x9DcnDGz13yYrV2iKM49y', 'Lan Anh Pixel', 'Vẽ pixel art mỗi ngày. Thích tileset 16x16 và bảng màu ít màu.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/9b98c5a22e3482e65a7031925c9ddba7.png', NULL, NULL, 'VN', '2025-11-22 13:25:35', 'active', '2025-11-22 06:25:35', '2025-11-22 06:25:35'),
(19, 'tuan_kart', 'tuan_kart@cong-dong.seed.local', '$2y$10$rxI/PTzX6MiWbzml90DEXeoMYxZ33jEpj.j8QuyVp/x3kTrDhAGwi', 'Tuấn Kart', 'Fan cứng SuperTuxKart. Tối thứ Sáu thường online đua với nhóm.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/6b73b85b6f1ab23cf388d0d38b457a91.png', NULL, NULL, 'VN', '2026-05-26 08:17:33', 'active', '2026-05-26 01:17:33', '2026-05-26 01:17:33'),
(20, 'hoangnam_rts', 'hoangnam_rts@cong-dong.seed.local', '$2y$10$wMQSP5k8hMgLOYNY1yiO/usdiuS5wflyCzxPO64XiFhwkfr2l2qTu', 'Hoàng Nam', 'Mê game chiến thuật thời gian thực. 0 A.D. là game ruột.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/4027f2fdacaa592574ba8cc99ee499f5.png', NULL, NULL, 'VN', '2025-11-01 18:50:17', 'active', '2025-11-01 11:50:17', '2025-11-01 11:50:17'),
(21, 'thuhuong_chill', 'thuhuong_chill@cong-dong.seed.local', '$2y$10$3usxl7Cv7anFaZmWOOULT.9NnyQRwASHKgmA9SgXoUAD8DhMPXmkS', 'Thu Hương', 'Chơi game để thư giãn sau giờ làm. Thích thế giới mở và xây dựng.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/0241d023f23d3b0066d4853c21cb8185.png', NULL, NULL, 'VN', '2026-02-10 20:11:53', 'active', '2026-02-10 13:11:53', '2026-02-10 13:11:53'),
(22, 'quocbao_ttd', 'quocbao_ttd@cong-dong.seed.local', '$2y$10$9hHuLw91.0vSmAcO2DhVYu5RmGn5aBCygT3beeJn18Kmib9aAozhi', 'Quốc Bảo', 'Kỹ sư cầu đường ngoài đời, kỹ sư đường sắt trong OpenTTD.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/77d11276e87985f44c54d16188c19b0e.png', NULL, NULL, 'VN', '2026-03-20 02:11:35', 'active', '2026-03-19 19:11:35', '2026-03-19 19:11:35'),
(23, 'ngocmai_draws', 'ngocmai_draws@cong-dong.seed.local', '$2y$10$8m3Kc2jbSmZFirCrDVbXWuOvD1.GamXhrgoET1JfUXvrhwut.xAim', 'Ngọc Mai', 'Họa sĩ minh họa tự do, đang học làm game cùng bạn.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/d1835576d2efe056a8427cbd3622ddbd.png', NULL, NULL, 'VN', '2026-01-05 22:02:50', 'active', '2026-01-05 15:02:50', '2026-01-05 15:02:50'),
(24, 'ducanh_fps', 'ducanh_fps@cong-dong.seed.local', '$2y$10$7Gx2qB7pJyYXhsZmpjsBy.lP82upN/k9auvv476nn2lIqs0zU5Re.', 'Đức Anh', 'Chơi bắn súng góc nhìn thứ nhất. Đang tập strafe jump trong Xonotic.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/0134ee078c1ddf2805fc4aaddb3c0567.png', NULL, NULL, 'VN', '2026-02-12 00:20:38', 'active', '2026-02-11 17:20:38', '2026-02-11 17:20:38'),
(25, 'haiyen_reads', 'haiyen_reads@cong-dong.seed.local', '$2y$10$1Rh8Xo4vQ9kOfCY2cOqF8e3r/.dtiyBJwhuaIXseT34OYRH9HUPeG', 'Hải Yến', 'Thích game có cốt truyện hay. Mới tập chơi game trên PC.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/237d8b4bd184e74c3b0914b7ed1f26af.png', NULL, NULL, 'VN', '2025-12-13 13:58:25', 'active', '2025-12-13 06:58:25', '2025-12-13 06:58:25'),
(26, 'vietdung_mods', 'vietdung_mods@cong-dong.seed.local', '$2y$10$yV.X88fnbsB6Nlq4gZwm2u9/h1EcFWIJlETzHEPc.wzTgE0JnIpYq', 'Việt Dũng', 'Viết mod Lua cho Luanti. Chủ một server nhỏ cho nhóm bạn.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/81e331798f4915390cc96612d02f03c6.png', NULL, NULL, 'VN', '2025-11-25 05:09:27', 'active', '2025-11-24 22:09:27', '2025-11-24 22:09:27'),
(27, 'khanhlinh_cozy', 'khanhlinh_cozy@cong-dong.seed.local', '$2y$10$0fmQh6vgYaV8reIyWxnZZO98nB5v/kCNo6e0BEaIenpgzH1UldFFG', 'Khánh Linh', 'Game ấm cúng, nhạc nhẹ, một tách trà. Vậy là đủ.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/dc9fc566269785d4cacd0449938407db.png', NULL, NULL, 'VN', '2025-12-06 16:26:45', 'active', '2025-12-06 09:26:45', '2025-12-06 09:26:45'),
(28, 'trungkien_hex', 'trungkien_hex@cong-dong.seed.local', '$2y$10$LmWudLZez8iv5XdbA2v95.1VmDFWUuuKvTqLNGRtUDgMgDCIygb52', 'Trung Kiên', 'Đã phá đảo nhiều chiến dịch của Wesnoth. Vẫn thua vì xui.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/5ea34aacd6fc323597897a6195b92841.png', NULL, NULL, 'VN', '2026-02-19 14:39:13', 'active', '2026-02-19 07:39:13', '2026-02-19 07:39:13'),
(29, 'baongoc_music', 'baongoc_music@cong-dong.seed.local', '$2y$10$2PxBYu2HeOfDscBMtvLxa.C8aOuASnZA.sTaLl/Bg4KLM7WL9Dpvu', 'Bảo Ngọc', 'Sáng tác nhạc chiptune và nhạc nền cho game độc lập.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/b31a056fc3921708de7e1712a3af986c.png', NULL, NULL, 'VN', '2026-05-27 08:57:24', 'active', '2026-05-27 01:57:24', '2026-05-27 01:57:24'),
(30, 'phuc_factory', 'phuc_factory@cong-dong.seed.local', '$2y$10$qNu9StXMKdY9Jwg.ywmHHezTUbMJh90h2K4uOw9sFHQEQjPC/x1ke', 'Phúc Nhà Máy', 'Tối ưu băng chuyền là niềm vui. Mindustry, và mọi thứ có dây chuyền.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/0fa8374f49229dfdf1f4b0b393def5ca.png', NULL, NULL, 'VN', '2025-11-11 01:04:42', 'active', '2025-11-10 18:04:42', '2025-11-10 18:04:42'),
(31, 'thanhtam_retro', 'thanhtam_retro@cong-dong.seed.local', '$2y$10$PU9M9Fqmvl3H.lR4PHglguDuRQvBvaZbGkI4hSk1XneuPo.Tg03Tu', 'Thanh Tâm', 'Sưu tầm máy chơi game cũ. Hoài niệm thời băng đĩa.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/cb4c0e709e1484af455c7f2b03e9f5ea.png', NULL, NULL, 'VN', '2025-12-29 03:00:33', 'active', '2025-12-28 20:00:33', '2025-12-28 20:00:33'),
(32, 'giahuy_speed', 'giahuy_speed@cong-dong.seed.local', '$2y$10$9tLuusprbWGNMHo.qKzsP.n1b0RjZP6phKLZAjYx.qb0nMl/gJ3Pi', 'Gia Huy', 'Chạy time trial và đếm từng phần trăm giây.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/d8ebd1ea92022c20e6b7e2a354ed61e3.png', NULL, NULL, 'VN', '2026-01-15 04:07:02', 'active', '2026-01-14 21:07:02', '2026-01-14 21:07:02'),
(33, 'myduyen_story', 'myduyen_story@cong-dong.seed.local', '$2y$10$qwAZxOq1peUtqfdLsGEvM.O28MPcZUeisQRsaAWabB2kPIb7wTpLC', 'Mỹ Duyên', 'Viết truyện ngắn, đang tập viết kịch bản cho visual novel.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/f111ea632258c7db547ecbdd7e47f9b1.png', NULL, NULL, 'VN', '2026-03-30 02:47:11', 'active', '2026-03-29 19:47:11', '2026-03-29 19:47:11'),
(34, 'longnguyen_linux', 'longnguyen_linux@cong-dong.seed.local', '$2y$10$FDdH3fDOwCt7Rp4PY3kxteTp03e6DP/R7Ete3cSGnDWZztTm1ztPG', 'Long Nguyễn', 'Dùng Linux hằng ngày. Hay trả lời câu hỏi kỹ thuật.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/d30de1c7e0c5a313db6912fb34f17b01.png', NULL, NULL, 'VN', '2026-06-01 01:42:37', 'active', '2026-05-31 18:42:37', '2026-05-31 18:42:37'),
(35, 'anhthu_casual', 'anhthu_casual@cong-dong.seed.local', '$2y$10$Gvylox0.mIRUOoIDdheCau5aPmW0X2Ixe8N7EgV1MEtdxT0Bfhc0u', 'Anh Thư', 'Chơi game cho vui, không tryhard.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/8f61052f615b7a2e665962199dff1151.png', NULL, NULL, 'VN', '2026-06-05 18:06:26', 'active', '2026-06-05 11:06:26', '2026-06-05 11:06:26'),
(36, 'hoaibao_civ', 'hoaibao_civ@cong-dong.seed.local', '$2y$10$2TTcoXEfPksN0w.Ax/OPb.c4wa9Lo7mtqROTiGKlhJhYP.SWaTKs6', 'Hoài Bảo', 'Một lượt nữa thôi... Freeciv và các game 4X.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/eefcf00fc08a6414d07f47f92eb3156b.png', NULL, NULL, 'VN', '2026-03-13 00:46:21', 'active', '2026-03-12 17:46:21', '2026-03-12 17:46:21'),
(37, 'quynh_lowpoly', 'quynh_lowpoly@cong-dong.seed.local', '$2y$10$p6wX3LEFQjQPBOXWZTs/a.G3FvWto0g4wA6FccFKf9HkpSHwDOAAS', 'Quỳnh Lowpoly', 'Đang học Blender, dựng mô hình low-poly.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/306bf861ff487967b1534f02fd803278.png', NULL, NULL, 'VN', '2026-01-07 08:39:59', 'active', '2026-01-07 01:39:59', '2026-01-07 01:39:59'),
(38, 'tienphat_lan', 'tienphat_lan@cong-dong.seed.local', '$2y$10$ZHmMzBGyPcmapwi9ml6tzur/26YAW7c6nelhNMQ5aZcGnf309MRFC', 'Tiến Phát', 'Tổ chức LAN party cho nhóm bạn đại học mỗi tháng.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/1bd7a01c144163aab6d2fbdcb1119acd.png', NULL, NULL, 'VN', '2025-11-23 22:37:06', 'active', '2025-11-23 15:37:06', '2025-11-23 15:37:06'),
(39, 'kaito_jp', 'kaito_jp@cong-dong.seed.local', '$2y$10$fQUBDr9GaL6PF1/gI9Czue5BA4MKfnnsBaZEAJpThdhglFz6B6d7a', 'Kaito', 'Indie game lover from Osaka. Learning Vietnamese slowly.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/3634085d6f047dcd6f06b8eb2b257f3a.png', NULL, NULL, 'JP', '2026-01-12 22:47:33', 'active', '2026-01-12 15:47:33', '2026-01-12 15:47:33'),
(40, 'yuna_kr', 'yuna_kr@cong-dong.seed.local', '$2y$10$y9faj45ETEpQHc8fO1FlfuS.mHwHh8zkBzXavqnzFO6IuRcfpcLQG', 'Yuna', 'Kart racing and cozy games. Hello from Seoul!\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/62188b99e08b64b90eb07c0e217bc4c0.png', NULL, NULL, 'KR', '2026-03-05 05:04:33', 'active', '2026-03-04 22:04:33', '2026-03-04 22:04:33'),
(41, 'lena_berlin', 'lena_berlin@cong-dong.seed.local', '$2y$10$PXLCx9yxsRIW3ywl6mZUT.x3/YGrnozU9oSU1GC8qFjE26Hje536e', 'Lena', 'Linux laptop, too many open-source games installed.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/1554490b852b467413c56772b44936c7.png', NULL, NULL, 'DE', '2025-12-05 10:12:46', 'active', '2025-12-05 03:12:46', '2025-12-05 03:12:46'),
(42, 'mateo_br', 'mateo_br@cong-dong.seed.local', '$2y$10$JLMhFSaanRkHER.tG9uv2OL1Mp7uT/Xy4JWkuMW0k01oLrK4to992', 'Mateo', 'Game jam addict. Makes small games in two weeks or less.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/810017eaa5c43f0af2c839d1442f870d.png', NULL, NULL, 'BR', '2025-10-02 12:33:30', 'active', '2025-10-02 05:33:30', '2025-10-02 05:33:30'),
(43, 'sophie_fr', 'sophie_fr@cong-dong.seed.local', '$2y$10$MYrF19OxZeQd8JqOgg9OtOwtASOpkdVFRtMMDzMZ0V11N5EUSrXFS', 'Sophie', 'UX designer by day, strategy gamer by night.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/25a9b3bb35a9b87375fb5f5d0fb2ea85.png', NULL, NULL, 'FR', '2026-02-18 05:52:15', 'active', '2026-02-17 22:52:15', '2026-02-17 22:52:15'),
(44, 'ari_ph', 'ari_ph@cong-dong.seed.local', '$2y$10$eycyTDMgI32TTTiNm484W.zI3/4hpwkCUj10ZE0rDeLWXarPPMZE.', 'Ari', 'Casual player, big fan of soundtracks.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/ae95ee92ed74ce60dafa9cfe648182ed.png', NULL, NULL, 'PH', '2025-10-07 01:56:03', 'active', '2025-10-06 18:56:03', '2025-10-06 18:56:03'),
(45, 'nattapong_th', 'nattapong_th@cong-dong.seed.local', '$2y$10$jfqYohkLTL9Gf0btKSR5q.3RDksB.1npPrDRf.X50EuZRFgaOHZeq', 'Nattapong', 'Factory games and tower defense. Always one more conveyor.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/beb9d8c004dbd7ef0359cdee80bcc734.png', NULL, NULL, 'TH', '2025-12-31 03:29:45', 'active', '2025-12-30 20:29:45', '2025-12-30 20:29:45'),
(46, 'dewi_id', 'dewi_id@cong-dong.seed.local', '$2y$10$dzVSbCaVwmMYtMkQfUDfdut/x0X7txZZUlQtgWjK6ztGqD.KdXiPW', 'Dewi', 'Turn-based strategy fan. Freeciv longturn veteran.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/ebadd27428d9f3bbe25c1ce00a34c28e.png', NULL, NULL, 'ID', '2026-05-06 20:21:28', 'active', '2026-05-06 13:21:28', '2026-05-06 13:21:28'),
(47, 'tomasz_pl', 'tomasz_pl@cong-dong.seed.local', '$2y$10$2p/1RrZRDkv7FAHk/HY8eu3totWwK2OhvgZ2pvrJK.2zkfnCLiYha', 'Tomasz', 'Trains. Mostly trains.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/3a25d1f48e3ffcc308ac91aa5e8bb5b6.png', NULL, NULL, 'PL', '2026-02-26 01:32:06', 'active', '2026-02-25 18:32:06', '2026-02-25 18:32:06'),
(48, 'emma_us', 'emma_us@cong-dong.seed.local', '$2y$10$x.C4yTOfl.CS/2vP/DbBNezSTbmQ1ecr4sNWmpvn7t2cv8wk3HktK', 'Emma', 'Solo dev working on a tiny farming roguelike.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/1af0088adea9cc3f2fc96b1caab74fee.png', NULL, NULL, 'US', '2026-03-13 14:03:07', 'active', '2026-03-13 07:03:07', '2026-03-13 07:03:07'),
(49, 'oliver_uk', 'oliver_uk@cong-dong.seed.local', '$2y$10$oJa3488847J68jJFHJZNDOUoXrAQYH//9tvWltgSl1uKpBz9tbUgW', 'Oliver', 'Hex grids, dice rolls and long campaigns.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/228ce548be8002e190d9eb30af83d48a.png', NULL, NULL, 'GB', '2026-05-14 15:33:32', 'active', '2026-05-14 08:33:32', '2026-05-14 08:33:32'),
(50, 'carlos_mx', 'carlos_mx@cong-dong.seed.local', '$2y$10$hjZpZkNOxi68SM9vQJ.1.uMr.mP4M5JJE1vzub4sr4dAeOthAQfES', 'Carlos', 'Arena shooters since forever.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/2cfeda496c907d51f9837f097715761a.png', NULL, NULL, 'MX', '2025-10-20 17:29:04', 'active', '2025-10-20 10:29:04', '2025-10-20 10:29:04'),
(51, 'nina_se', 'nina_se@cong-dong.seed.local', '$2y$10$ZQ03D5bAdc9iKnpR8bwPA.e0GdGorVPN7coMvOJRSvTxBBYf0lU2W', 'Nina', 'Voxel builder. Castles, bridges, the occasional disaster.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/c6519d199ff5883b63b19ce5e1bf7828.png', NULL, NULL, 'SE', '2025-10-13 22:43:59', 'active', '2025-10-13 15:43:59', '2025-10-13 15:43:59'),
(52, 'raj_in', 'raj_in@cong-dong.seed.local', '$2y$10$UUew62DnjjkvwwLMhpfb6O/Z97HkP6kT4WVhHx32ONp98wUMOc1aW', 'Raj', 'RTS player, slowly getting better against the AI.\n(Hồ sơ cộng đồng mẫu)', '/public/uploads/avatars/bcb8e722cff204aebd73d88936e85eca.png', NULL, NULL, 'IN', '2026-04-18 13:56:19', 'active', '2026-04-18 06:56:19', '2026-04-18 06:56:19'),
(53, 'mau_concernedape', 'mau_concernedape@test.local', '$2y$10$SZd.8vXROjXE55uf3bHIVO8qIUuFEcS4icj8ayCJN12ek3Oyw8vhq', 'ConcernedApe (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Stardew Valley” trong một dự án học tập. Tài khoản này không do ConcernedApe quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'http://www.stardewvalley.net', NULL, '2026-11-04 02:17:29', 'active', '2026-11-03 19:17:29', '2026-11-03 19:17:29'),
(54, 'mau_teamcherry', 'mau_teamcherry@test.local', '$2y$10$WwNGJ8RYosxfzaOXN2hGjOZvQtIvDPCE/J2gaHdXqk.nM8tEREvES', 'Team Cherry (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Hollow Knight” trong một dự án học tập. Tài khoản này không do Team Cherry quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'http://hollowknight.com', NULL, '2026-11-04 02:17:29', 'active', '2026-11-03 19:17:29', '2026-11-03 19:17:29'),
(55, 'mau_maddymakesgames', 'mau_maddymakesgames@test.local', '$2y$10$CQb0.nBEFd5O4OhAkskRzuJBlo4AW00qMb9gWRTflKn8nn67yIsdW', 'Maddy Makes Games (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Celeste” trong một dự án học tập. Tài khoản này không do Maddy Makes Games quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'http://www.celestegame.com', NULL, '2026-11-04 02:17:30', 'active', '2026-11-03 19:17:30', '2026-11-03 19:17:30'),
(56, 'mau_supergiant', 'mau_supergiant@test.local', '$2y$10$ci5LitcdjwU3YMxfx8L4aOiRlZB6FOTtkwvoFu36ujNgN4VihKt4q', 'Supergiant Games (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Hades” trong một dự án học tập. Tài khoản này không do Supergiant Games quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'http://www.supergiantgames.com', NULL, '2026-11-04 02:17:30', 'active', '2026-11-03 19:17:30', '2026-11-03 19:17:30'),
(57, 'mau_motiontwin', 'mau_motiontwin@test.local', '$2y$10$3PLgq/AfRNpblOvVfu1w/.e8UHivcQEwIBzsMHyKdSHmBMOdpRv2u', 'Motion Twin (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Dead Cells” trong một dự án học tập. Tài khoản này không do Motion Twin quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'https://dead-cells.com/', NULL, '2026-11-04 02:17:30', 'active', '2026-11-03 19:17:30', '2026-11-03 19:17:30'),
(58, 'mau_megacrit', 'mau_megacrit@test.local', '$2y$10$blYy1O1J08.M/lTY66ePle7wUXF4nIe2WrPRiIkZr0sTowCMyxwhK', 'Mega Crit (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Slay the Spire” trong một dự án học tập. Tài khoản này không do Mega Crit quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'https://www.megacrit.com/', NULL, '2026-11-04 02:17:30', 'active', '2026-11-03 19:17:30', '2026-11-03 19:17:30'),
(59, 'mau_relogic', 'mau_relogic@test.local', '$2y$10$TaL2U89TvF3ZDeZflBzuWeOrTYaGgMU1iKHauUDfuPywkup3d5D5q', 'Re-Logic (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Terraria” trong một dự án học tập. Tài khoản này không do Re-Logic quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'http://www.terraria.org/', NULL, '2026-11-04 02:17:30', 'active', '2026-11-03 19:17:30', '2026-11-03 19:17:30'),
(60, 'mau_adamgryu', 'mau_adamgryu@test.local', '$2y$10$5tR5b/Rrh0KSWQTlCZYz0OYgjBfIQ48BJU9nXX8AzoG/Yp8m92J7y', 'adamgryu (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “A Short Hike” trong một dự án học tập. Tài khoản này không do adamgryu quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'http://www.ashorthike.com', NULL, '2026-11-04 02:17:30', 'active', '2026-11-03 19:17:30', '2026-11-03 19:17:30'),
(61, 'mau_poncle', 'mau_poncle@test.local', '$2y$10$CGruEJT5YKcTuiGDkaZhTOf577DTrXvvp4c0H/veQBqPfkjSORlW2', 'poncle (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Vampire Survivors” trong một dự án học tập. Tài khoản này không do poncle quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, NULL, NULL, '2026-11-04 02:17:30', 'active', '2026-11-03 19:17:30', '2026-11-03 19:17:30'),
(62, 'mau_lucaspope', 'mau_lucaspope@test.local', '$2y$10$TDtD/CQMeYlrSOk.btl93uHsaZSyscKcwCf2zzWA.SQGVWgPoZiv.', 'Lucas Pope (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu các trò chơi “Papers, Please”, “Return of the Obra Dinn” trong một dự án học tập. Tài khoản này không do Lucas Pope quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'http://papersplea.se', NULL, '2026-11-04 02:17:30', 'active', '2026-11-03 19:17:30', '2026-11-04 01:54:01'),
(63, 'mau_danielmullins', 'mau_danielmullins@test.local', '$2y$10$IqPYmErQVQ5pzLR9Jc7u0./aDYIjLXiBrCVbIXlNULF4/uIeIDtW2', 'Daniel Mullins Games (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Inscryption” trong một dự án học tập. Tài khoản này không do Daniel Mullins Games quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'https://www.inscryption-game.com', NULL, '2026-11-04 02:50:05', 'active', '2026-11-03 19:50:05', '2026-11-03 19:50:05'),
(64, 'mau_witchbeam', 'mau_witchbeam@test.local', '$2y$10$Ld/XymgJIy/IHvnremuKDetc3aXtGnX0hib1nHLFxSir9mf8cW2HS', 'Witch Beam (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Unpacking” trong một dự án học tập. Tài khoản này không do Witch Beam quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'https://www.unpackinggame.com/', NULL, '2026-11-04 02:50:05', 'active', '2026-11-03 19:50:05', '2026-11-03 19:50:05'),
(65, 'mau_fourquarters', 'mau_fourquarters@test.local', '$2y$10$3dH89OlOYP25b6Yel8oZ/eOECsB4ny1oH8aueyUe8N/Nxgh1bJU3q', 'Four Quarters (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Loop Hero” trong một dự án học tập. Tài khoản này không do Four Quarters quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'http://loophero.com', NULL, '2026-11-04 02:50:05', 'active', '2026-11-03 19:50:05', '2026-11-03 19:50:05'),
(66, 'mau_blacksalt', 'mau_blacksalt@test.local', '$2y$10$mAse5RML6Br9ZtLv/a3s9OWb6biDXi40zxq0ulAiolxfq37PgIdOC', 'Black Salt Games (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “DREDGE” trong một dự án học tập. Tài khoản này không do Black Salt Games quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'https://www.dredge.game/', NULL, '2026-11-04 02:50:05', 'active', '2026-11-03 19:50:05', '2026-11-03 19:50:05'),
(67, 'mau_subsetgames', 'mau_subsetgames@test.local', '$2y$10$We4TTMSOBYs6N2wldog3QuR8lM9/srcmI4nhiyelxtK6PbBnu6A4m', 'Subset Games (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu các trò chơi “FTL: Faster Than Light”, “Into the Breach” trong một dự án học tập. Tài khoản này không do Subset Games quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'https://subsetgames.com', NULL, '2026-11-04 02:50:06', 'active', '2026-11-03 19:50:06', '2026-11-03 19:50:06'),
(68, 'mau_klei', 'mau_klei@test.local', '$2y$10$yuwfP.6gveOt3N4POYWixOzibcA1IbKBZjA/cq.iNMUftpcut3dGy', 'Klei Entertainment (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu các trò chơi “Don\'t Starve”, “Oxygen Not Included” trong một dự án học tập. Tài khoản này không do Klei Entertainment quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'https://www.kleientertainment.com', NULL, '2026-11-04 02:50:06', 'active', '2026-11-03 19:50:06', '2026-11-03 19:50:06'),
(69, 'mau_localthunk', 'mau_localthunk@test.local', '$2y$10$0okQTcv7tjK25VF7xhu/rOHWdCkPFZ6VtRsLonU1JMeYVkKpH/sBu', 'LocalThunk (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Balatro” trong một dự án học tập. Tài khoản này không do LocalThunk quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'https://www.playbalatro.com/', NULL, '2026-11-04 02:50:06', 'active', '2026-11-03 19:50:06', '2026-11-03 19:50:06'),
(70, 'mau_redhook', 'mau_redhook@test.local', '$2y$10$027axJMCRToFean1gllsme1YKYocjLCewHNfmQ0o.VArR7iHO.KAi', 'Red Hook Studios (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Darkest Dungeon” trong một dự án học tập. Tài khoản này không do Red Hook Studios quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'http://www.darkestdungeon.com', NULL, '2026-11-04 02:50:06', 'active', '2026-11-03 19:50:06', '2026-11-03 19:50:06'),
(71, 'mau_studiomdhr', 'mau_studiomdhr@test.local', '$2y$10$mtliACRPQqLGM425ZlD9eO3ebS5MzpzqNdpV1kovRGwnUFUWdumMS', 'Studio MDHR (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Cuphead” trong một dự án học tập. Tài khoản này không do Studio MDHR quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'http://www.cupheadgame.com', NULL, '2026-11-04 02:50:06', 'active', '2026-11-03 19:50:06', '2026-11-03 19:50:06'),
(72, 'mau_ludeon', 'mau_ludeon@test.local', '$2y$10$j7V2Ve9ZN12DMR3/mYZbSOUYCv7UWDUtKo8Qk3jQasc03FhdEo3Di', 'Ludeon Studios (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “RimWorld” trong một dự án học tập. Tài khoản này không do Ludeon Studios quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'https://ludeon.com', NULL, '2026-11-04 02:50:06', 'active', '2026-11-03 19:50:06', '2026-11-03 19:50:06'),
(73, 'mau_dodgeroll', 'mau_dodgeroll@test.local', '$2y$10$TLCs4jPszPYYe.VIL8EuUeRWVGejLp10PBU0YFM0up.FbzFYZE.1W', 'Dodge Roll (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Enter the Gungeon” trong một dự án học tập. Tài khoản này không do Dodge Roll quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'http://www.enterthegungeon.com', NULL, '2026-11-04 02:50:06', 'active', '2026-11-03 19:50:06', '2026-11-03 19:50:06'),
(74, 'mau_tobyfox', 'mau_tobyfox@test.local', '$2y$10$c.reaqCcdK.mY/xlvmReYe/US6NyA1RczNIIMLXrfmvuioLaEEJwy', 'tobyfox (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “UNDERTALE” trong một dự án học tập. Tài khoản này không do tobyfox quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'http://undertale.com', NULL, '2026-11-04 02:50:06', 'active', '2026-11-03 19:50:06', '2026-11-03 19:50:06'),
(75, 'mau_wube', 'mau_wube@test.local', '$2y$10$sLd1W9.s2nXSRbUjQLxGH.M26dTGVQPplrjZRiWIJYlNrI6s7GDOu', 'Wube Software (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Factorio” trong một dự án học tập. Tài khoản này không do Wube Software quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'https://www.factorio.com', NULL, '2026-11-04 02:50:06', 'active', '2026-11-03 19:50:06', '2026-11-03 19:50:06'),
(76, 'mau_askiisoft', 'mau_askiisoft@test.local', '$2y$10$VXfUA75QUPJB0vULzYNsdedT8n3uvKOABgJCP41jSbz9hi8s9tYu2', 'Askiisoft (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Katana ZERO” trong một dự án học tập. Tài khoản này không do Askiisoft quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'http://www.katanazero.com/', NULL, '2026-11-04 02:50:06', 'active', '2026-11-03 19:50:06', '2026-11-03 19:50:06'),
(77, 'mau_infinitefall', 'mau_infinitefall@test.local', '$2y$10$DpXTSA3H3Nh3vaH2Ak74UuNgHmgvmJ1W0s4wAMZEhkuTMQ2WRp09S', 'Infinite Fall (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Night in the Woods” trong một dự án học tập. Tài khoản này không do Infinite Fall quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'http://nightinthewoods.com', NULL, '2026-11-04 02:50:06', 'active', '2026-11-03 19:50:06', '2026-11-03 19:50:06'),
(78, 'mau_tunicteam', 'mau_tunicteam@test.local', '$2y$10$8FFaZ4HX5Ay/W5f9ad0CMufpeWV.UzQ8VQsUmQrfNAtkJjyyMAAPK', 'TUNIC Team (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “TUNIC” trong một dự án học tập. Tài khoản này không do TUNIC Team quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'https://www.tunicgame.com/', NULL, '2026-11-04 02:50:06', 'active', '2026-11-03 19:50:06', '2026-11-03 19:50:06'),
(79, 'mau_hempuli', 'mau_hempuli@test.local', '$2y$10$MofsPaT4Tu10Ci8LhBkxY.U223pc81AYSpzzu2ZOYz8OxedpO8QQe', 'Hempuli Oy (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Baba Is You” trong một dự án học tập. Tài khoản này không do Hempuli Oy quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'https://www.hempuli.com/Baba/', NULL, '2026-11-04 02:50:06', 'active', '2026-11-03 19:50:06', '2026-11-03 19:50:06'),
(80, 'mau_mobiusdigital', 'mau_mobiusdigital@test.local', '$2y$10$N0TW2YXRebuWYu3UNRIK4.Loh0S/DHU2/XG/jF9nnSaKlzMEYCXe6', 'Mobius Digital (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Outer Wilds” trong một dự án học tập. Tài khoản này không do Mobius Digital quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, NULL, NULL, '2026-11-04 02:50:06', 'active', '2026-11-03 19:50:06', '2026-11-03 19:50:06'),
(81, 'mau_thunderlotus', 'mau_thunderlotus@test.local', '$2y$10$qQvu5sQ46uk96U2gO3j4mOBIuaUBYzEYm/NMxc1rvg.IpGobx/UX2', 'Thunder Lotus (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Spiritfarer: Farewell Edition” trong một dự án học tập. Tài khoản này không do Thunder Lotus quản lý và nền tảng không liên kết với họ. Hãy mua bản chính thức trên Steam.', NULL, NULL, 'https://thunderlotusgames.com', NULL, '2026-11-04 02:50:06', 'active', '2026-11-03 19:50:06', '2026-11-03 19:50:06'),
(82, 'mau_wz2100', 'mau_wz2100@test.local', '$2y$10$Z1pPD/W9nd1AzSKjAt8a8eIyCWKUlaT.uI44f3E8ugKnQGMGe1SS6', 'Warzone 2100 Project (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Warzone 2100” trong một dự án học tập. Tài khoản này không do Warzone 2100 Project quản lý và nền tảng không liên kết với họ. Hãy tải bản chính thức từ trang của nhà phát triển.', NULL, NULL, 'https://wz2100.net', NULL, '2026-11-04 02:50:07', 'active', '2026-11-03 19:50:07', '2026-11-03 19:50:07'),
(83, 'mau_dani', 'mau_dani@test.local', '$2y$10$DIYWF4z9utOWb42/M/qnDuxCXyI.peRPDlbzbE6S3eA9R0vTRzlW6', 'Dani (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Muck” trong một dự án học tập. Tài khoản này không do Dani quản lý và nền tảng không liên kết với họ. Hãy tải bản chính thức từ trang của nhà phát triển.', NULL, NULL, NULL, NULL, '2026-11-04 02:50:07', 'active', '2026-11-03 19:50:07', '2026-11-03 19:50:07'),
(84, 'mau_smartlydressed', 'mau_smartlydressed@test.local', '$2y$10$VsN8YKYIkVPkTvOuvFVti.piO8hTBWDgKzL1rbiCbT928PexX6NJO', 'Smartly Dressed Games (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Unturned” trong một dự án học tập. Tài khoản này không do Smartly Dressed Games quản lý và nền tảng không liên kết với họ. Hãy tải bản chính thức từ trang của nhà phát triển.', NULL, NULL, 'https://smartlydressedgames.com', NULL, '2026-11-04 02:50:07', 'active', '2026-11-03 19:50:07', '2026-11-03 19:50:07'),
(85, 'mau_zerok', 'mau_zerok@test.local', '$2y$10$zA4zO3pagZtRIU6IBTWvxebq0QubXM0AmRV69o3e2dRNYnJtjGrJG', 'Zero-K Team (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Zero-K” trong một dự án học tập. Tài khoản này không do Zero-K Team quản lý và nền tảng không liên kết với họ. Hãy tải bản chính thức từ trang của nhà phát triển.', NULL, NULL, 'https://zero-k.info', NULL, '2026-11-04 02:50:07', 'active', '2026-11-03 19:50:07', '2026-11-03 19:50:07'),
(86, 'mau_teeworlds', 'mau_teeworlds@test.local', '$2y$10$W6jDsz62aXUffTioEHmn/e8Q1K3PNmAy1bwCCDK3y8l6nz/jW83qu', 'Teeworlds Team (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Teeworlds” trong một dự án học tập. Tài khoản này không do Teeworlds Team quản lý và nền tảng không liên kết với họ. Hãy tải bản chính thức từ trang của nhà phát triển.', NULL, NULL, 'https://www.teeworlds.com/', NULL, '2026-11-04 02:50:07', 'active', '2026-11-03 19:50:07', '2026-11-03 19:50:07'),
(87, 'mau_endlesssky', 'mau_endlesssky@test.local', '$2y$10$lm7Gn7Qaxb//vTn.FWYiEe6TPr22N6dbU4WVY/0y3Jyyiwxh/ISh2', 'Endless Sky (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Endless Sky” trong một dự án học tập. Tài khoản này không do Endless Sky quản lý và nền tảng không liên kết với họ. Hãy tải bản chính thức từ trang của nhà phát triển.', NULL, NULL, 'https://endless-sky.github.io/', NULL, '2026-11-04 02:50:07', 'active', '2026-11-03 19:50:07', '2026-11-03 19:50:07'),
(88, 'mau_kyleseeley', 'mau_kyleseeley@test.local', '$2y$10$vfROBwd7u0BQLN4rb5wa1eFknfwE8bnaJWyRt4vpGK.Su7bJNYRV.', 'Kyle Seeley (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Emily is Away” trong một dự án học tập. Tài khoản này không do Kyle Seeley quản lý và nền tảng không liên kết với họ. Hãy tải bản chính thức từ trang của nhà phát triển.', NULL, NULL, 'http://emilyisaway.com/', NULL, '2026-11-04 02:50:07', 'active', '2026-11-03 19:50:07', '2026-11-03 19:50:07'),
(89, 'mau_pixile', 'mau_pixile@test.local', '$2y$10$ZV3NR/dLUnkPSzyVUSo6XeCtzZdC8MrI2CNY6I3n1PpgAdm4uP/5.', 'Pixile (hồ sơ mẫu)', 'Hồ sơ mẫu do nền tảng tạo để giới thiệu trò chơi “Super Animal Royale” trong một dự án học tập. Tài khoản này không do Pixile quản lý và nền tảng không liên kết với họ. Hãy tải bản chính thức từ trang của nhà phát triển.', NULL, NULL, 'https://animalroyale.com', NULL, '2026-11-04 02:50:07', 'active', '2026-11-03 19:50:07', '2026-11-03 19:50:07'),
(171, 'demo_dev', 'demo_dev@mau.local', '$2y$10$zrl4i6Rh/s0K5qP0iQ5rT.YpmoJuwqd4zAuhovC.8S284KbxDH4E6', 'Minh Khang Studio', 'Nhà phát triển mẫu. Dùng để minh hoạ luồng duyệt link tải về.', NULL, NULL, 'https://example.com/demo-dev', 'VN', '2026-11-01 09:00:00', 'active', '2026-11-01 08:30:00', '2026-11-01 08:30:00'),
(172, 'demo_player', 'demo_player@mau.local', '$2y$10$5JoX//NRSRGiL9RrHpPubOpNv.RW5lV6igM53BKrdvAxRmsx0j6Y6', 'Bảo An', 'Người chơi mẫu. Đã sở hữu game nên thấy toàn bộ link tải về.', NULL, NULL, NULL, 'VN', '2026-11-01 09:05:00', 'active', '2026-11-01 08:35:00', '2026-11-01 08:35:00'),
(173, 'demo_mirror', 'demo_mirror@mau.local', '$2y$10$ZNeffyQNuXxO53Z3fdSzbuJXWB/7ar7zRvNW3BT3O3MCpcIyioFdi', 'Chí Dũng', 'Người chơi mẫu. Một nguồn tải của anh đang chờ nhà phát triển duyệt.', NULL, NULL, NULL, 'VN', '2026-11-01 09:07:00', 'active', '2026-11-01 08:40:00', '2026-11-01 08:40:00');

-- --------------------------------------------------------

--
-- Table structure for table `nguoi_dung_vai_tro`
--

CREATE TABLE `nguoi_dung_vai_tro` (
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `vai_tro_id` smallint(5) UNSIGNED NOT NULL,
  `ngay_phan_vai` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nguoi_dung_vai_tro`
--

INSERT INTO `nguoi_dung_vai_tro` (`nguoi_dung_id`, `vai_tro_id`, `ngay_phan_vai`) VALUES
(5, 1, '2026-11-03 12:27:03'),
(6, 1, '2026-11-03 08:14:08'),
(6, 4, '2026-11-03 08:14:08'),
(7, 1, '2026-11-03 08:14:08'),
(7, 3, '2026-11-03 08:14:08'),
(8, 1, '2026-11-03 08:53:46'),
(8, 2, '2026-11-03 08:53:46'),
(9, 1, '2026-11-03 08:23:04'),
(9, 2, '2026-11-03 08:23:04'),
(10, 1, '2026-11-03 08:23:04'),
(10, 2, '2026-11-03 08:23:04'),
(11, 1, '2026-11-03 08:23:05'),
(11, 2, '2026-11-03 08:23:05'),
(12, 1, '2026-11-03 08:23:05'),
(12, 2, '2026-11-03 08:23:05'),
(13, 1, '2026-11-03 08:23:05'),
(13, 2, '2026-11-03 08:23:05'),
(14, 1, '2026-11-03 08:23:05'),
(14, 2, '2026-11-03 08:23:05'),
(15, 1, '2026-11-03 08:23:05'),
(15, 2, '2026-11-03 08:23:05'),
(16, 1, '2026-11-03 08:23:05'),
(16, 2, '2026-11-03 08:23:05'),
(17, 1, '2026-11-03 13:56:48'),
(17, 2, '2026-11-03 13:56:48'),
(18, 1, '2026-11-03 13:56:48'),
(18, 2, '2026-11-03 13:56:48'),
(19, 1, '2026-11-03 13:56:48'),
(20, 1, '2026-11-03 13:56:49'),
(21, 1, '2026-11-03 13:56:49'),
(22, 1, '2026-11-03 13:56:49'),
(23, 1, '2026-11-03 13:56:49'),
(23, 2, '2026-11-03 13:56:49'),
(24, 1, '2026-11-03 13:56:49'),
(25, 1, '2026-11-03 13:56:49'),
(26, 1, '2026-11-03 13:56:49'),
(26, 2, '2026-11-03 13:56:49'),
(27, 1, '2026-11-03 13:56:49'),
(28, 1, '2026-11-03 13:56:50'),
(29, 1, '2026-11-03 13:56:50'),
(29, 2, '2026-11-03 13:56:50'),
(30, 1, '2026-11-03 13:56:50'),
(31, 1, '2026-11-03 13:56:50'),
(32, 1, '2026-11-03 13:56:50'),
(33, 1, '2026-11-03 13:56:50'),
(34, 1, '2026-11-03 13:56:50'),
(35, 1, '2026-11-03 13:56:50'),
(36, 1, '2026-11-03 13:56:51'),
(37, 1, '2026-11-03 13:56:51'),
(37, 2, '2026-11-03 13:56:51'),
(38, 1, '2026-11-03 13:56:51'),
(39, 1, '2026-11-03 13:56:51'),
(40, 1, '2026-11-03 13:56:51'),
(41, 1, '2026-11-03 13:56:51'),
(42, 1, '2026-11-03 13:56:51'),
(42, 2, '2026-11-03 13:56:51'),
(43, 1, '2026-11-03 13:56:51'),
(44, 1, '2026-11-03 13:56:51'),
(45, 1, '2026-11-03 13:56:52'),
(46, 1, '2026-11-03 13:56:52'),
(47, 1, '2026-11-03 13:56:52'),
(48, 1, '2026-11-03 13:56:52'),
(48, 2, '2026-11-03 13:56:52'),
(49, 1, '2026-11-03 13:56:52'),
(50, 1, '2026-11-03 13:56:52'),
(51, 1, '2026-11-03 13:56:52'),
(52, 1, '2026-11-03 13:56:53'),
(53, 1, '2026-11-04 01:17:29'),
(53, 2, '2026-11-04 01:17:29'),
(54, 1, '2026-11-04 01:17:30'),
(54, 2, '2026-11-04 01:17:30'),
(55, 1, '2026-11-04 01:17:30'),
(55, 2, '2026-11-04 01:17:30'),
(56, 1, '2026-11-04 01:17:30'),
(56, 2, '2026-11-04 01:17:30'),
(57, 1, '2026-11-04 01:17:30'),
(57, 2, '2026-11-04 01:17:30'),
(58, 1, '2026-11-04 01:17:30'),
(58, 2, '2026-11-04 01:17:30'),
(59, 1, '2026-11-04 01:17:30'),
(59, 2, '2026-11-04 01:17:30'),
(60, 1, '2026-11-04 01:17:30'),
(60, 2, '2026-11-04 01:17:30'),
(61, 1, '2026-11-04 01:17:30'),
(61, 2, '2026-11-04 01:17:30'),
(62, 1, '2026-11-04 01:17:30'),
(62, 2, '2026-11-04 01:17:30'),
(63, 1, '2026-11-04 01:50:05'),
(63, 2, '2026-11-04 01:50:05'),
(64, 1, '2026-11-04 01:50:05'),
(64, 2, '2026-11-04 01:50:05'),
(65, 1, '2026-11-04 01:50:05'),
(65, 2, '2026-11-04 01:50:05'),
(66, 1, '2026-11-04 01:50:06'),
(66, 2, '2026-11-04 01:50:06'),
(67, 1, '2026-11-04 01:50:06'),
(67, 2, '2026-11-04 01:50:06'),
(68, 1, '2026-11-04 01:50:06'),
(68, 2, '2026-11-04 01:50:06'),
(69, 1, '2026-11-04 01:50:06'),
(69, 2, '2026-11-04 01:50:06'),
(70, 1, '2026-11-04 01:50:06'),
(70, 2, '2026-11-04 01:50:06'),
(71, 1, '2026-11-04 01:50:06'),
(71, 2, '2026-11-04 01:50:06'),
(72, 1, '2026-11-04 01:50:06'),
(72, 2, '2026-11-04 01:50:06'),
(73, 1, '2026-11-04 01:50:06'),
(73, 2, '2026-11-04 01:50:06'),
(74, 1, '2026-11-04 01:50:06'),
(74, 2, '2026-11-04 01:50:06'),
(75, 1, '2026-11-04 01:50:06'),
(75, 2, '2026-11-04 01:50:06'),
(76, 1, '2026-11-04 01:50:06'),
(76, 2, '2026-11-04 01:50:06'),
(77, 1, '2026-11-04 01:50:06'),
(77, 2, '2026-11-04 01:50:06'),
(78, 1, '2026-11-04 01:50:06'),
(78, 2, '2026-11-04 01:50:06'),
(79, 1, '2026-11-04 01:50:06'),
(79, 2, '2026-11-04 01:50:06'),
(80, 1, '2026-11-04 01:50:06'),
(80, 2, '2026-11-04 01:50:06'),
(81, 1, '2026-11-04 01:50:07'),
(81, 2, '2026-11-04 01:50:07'),
(82, 1, '2026-11-04 01:50:07'),
(82, 2, '2026-11-04 01:50:07'),
(83, 1, '2026-11-04 01:50:07'),
(83, 2, '2026-11-04 01:50:07'),
(84, 1, '2026-11-04 01:50:07'),
(84, 2, '2026-11-04 01:50:07'),
(85, 1, '2026-11-04 01:50:07'),
(85, 2, '2026-11-04 01:50:07'),
(86, 1, '2026-11-04 01:50:07'),
(86, 2, '2026-11-04 01:50:07'),
(87, 1, '2026-11-04 01:50:07'),
(87, 2, '2026-11-04 01:50:07'),
(88, 1, '2026-11-04 01:50:07'),
(88, 2, '2026-11-04 01:50:07'),
(89, 1, '2026-11-04 01:50:07'),
(89, 2, '2026-11-04 01:50:07'),
(171, 2, '2026-11-01 08:30:00'),
(172, 1, '2026-11-01 08:35:00'),
(173, 1, '2026-11-01 08:40:00');

-- --------------------------------------------------------

--
-- Table structure for table `nhan`
--

CREATE TABLE `nhan` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `ten` varchar(80) NOT NULL,
  `duong_dan_rut_gon` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nhan`
--

INSERT INTO `nhan` (`ma`, `ten`, `duong_dan_rut_gon`) VALUES
(1, 'Mã nguồn mở', 'ma-nguon-mo'),
(2, 'Nhiều người chơi', 'nhieu-nguoi-choi'),
(3, 'Chơi đơn', 'choi-don'),
(4, 'Theo lượt', 'theo-luot'),
(5, 'Thời gian thực', 'thoi-gian-thuc'),
(6, 'Đua xe', 'dua-xe'),
(7, 'Thế giới mở', 'the-gioi-mo'),
(8, 'Xây dựng', 'xay-dung'),
(9, 'Lịch sử', 'lich-su'),
(10, 'Giả tưởng', 'gia-tuong'),
(11, 'Bắn súng', 'ban-sung'),
(12, 'Chia màn hình', 'chia-man-hinh'),
(13, 'Hỗ trợ mod', 'ho-tro-mod'),
(14, 'Kinh doanh', 'kinh-doanh'),
(15, 'Thủ thành', 'thu-thanh'),
(18, 'Roguelike', 'roguelike'),
(19, 'Metroidvania', 'metroidvania'),
(20, 'Xây dựng bộ bài', 'xay-dung-bo-bai'),
(21, 'Thư giãn', 'thu-gian'),
(22, 'Pixel art', 'pixel-art'),
(23, 'Sinh tồn', 'sinh-ton'),
(24, 'Khoa học viễn tưởng', 'khoa-hoc-vien-tuong'),
(25, 'Giàu cốt truyện', 'cot-truyen');

-- --------------------------------------------------------

--
-- Table structure for table `nhat_ky_he_thong`
--

CREATE TABLE `nhat_ky_he_thong` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `nguoi_dung_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ma_hanh_dong` varchar(100) NOT NULL,
  `loai_thuc_the` varchar(80) DEFAULT NULL,
  `thuc_the_id` bigint(20) UNSIGNED DEFAULT NULL,
  `dia_chi_ip` varchar(45) DEFAULT NULL,
  `trinh_duyet_nguoi_dung` varchar(500) DEFAULT NULL,
  `du_lieu_bo_sung` text DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nhat_ky_he_thong`
--

INSERT INTO `nhat_ky_he_thong` (`ma`, `nguoi_dung_id`, `ma_hanh_dong`, `loai_thuc_the`, `thuc_the_id`, `dia_chi_ip`, `trinh_duyet_nguoi_dung`, `du_lieu_bo_sung`, `ngay_tao`) VALUES
(1, 5, 'register', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 07:34:03'),
(2, 5, 'order_paid', 'don_hang', 3, '::1', 'curl/8.21.0', NULL, '2026-11-03 07:34:04'),
(3, 5, 'refund_request', 'hoan_tien', 1, '::1', 'curl/8.21.0', NULL, '2026-11-03 07:34:43'),
(4, 5, 'logout', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 07:34:43'),
(5, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 07:44:45'),
(6, 5, 'profile_update', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 07:44:46'),
(7, 5, 'profile_update', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 07:44:46'),
(8, 5, 'password_change_fail', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 07:44:46'),
(9, 5, 'settings_update', 'cai_dat_nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 07:44:47'),
(10, 5, 'key_redeem_fail', 'ma_truy_cap_tro_choi', NULL, '::1', 'curl/8.21.0', NULL, '2026-11-03 07:44:47'),
(11, 5, 'profile_update', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 07:45:04'),
(12, 5, 'settings_update', 'cai_dat_nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 07:45:31'),
(13, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 07:58:46'),
(14, 5, 'collection_create', 'bo_suu_tap', 1, '::1', 'curl/8.21.0', NULL, '2026-11-03 07:58:46'),
(15, 5, 'collection_update', 'bo_suu_tap', 1, '::1', 'curl/8.21.0', NULL, '2026-11-03 07:58:47'),
(16, 5, 'collection_create', 'bo_suu_tap', 2, '::1', 'curl/8.21.0', NULL, '2026-11-03 07:58:47'),
(17, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 08:06:04'),
(18, 5, 'topic_create', 'chu_de_thao_luan', 3, '::1', 'curl/8.21.0', NULL, '2026-11-03 08:06:05'),
(19, 5, 'post_edit', 'bai_viet_thao_luan', 4, '::1', 'curl/8.21.0', NULL, '2026-11-03 08:06:06'),
(20, 5, 'topic_edit', 'chu_de_thao_luan', 3, '::1', 'curl/8.21.0', NULL, '2026-11-03 08:06:06'),
(21, 5, 'post_delete', 'bai_viet_thao_luan', 4, '::1', 'curl/8.21.0', NULL, '2026-11-03 08:06:07'),
(22, 5, 'topic_remove', 'chu_de_thao_luan', 3, '::1', 'curl/8.21.0', NULL, '2026-11-03 08:06:08'),
(23, 5, 'post_delete', 'bai_viet_thao_luan', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 08:06:28'),
(24, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 08:14:46'),
(25, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-03 08:14:47'),
(26, 6, 'jam_create', 'cuoc_thi_lam_game', 1, '::1', 'curl/8.21.0', NULL, '2026-11-03 08:14:48'),
(27, 6, 'jam_member_set', 'cuoc_thi_lam_game', 1, '::1', 'curl/8.21.0', '{\"user\":7,\"role\":\"judge\"}', '2026-11-03 08:14:48'),
(28, 6, 'jam_member_remove', 'cuoc_thi_lam_game', 1, '::1', 'curl/8.21.0', '{\"user\":7}', '2026-11-03 08:14:49'),
(29, 6, 'jam_update', 'cuoc_thi_lam_game', 1, '::1', 'curl/8.21.0', '{\"trang_thai\":\"published\"}', '2026-11-03 08:14:49'),
(30, 6, 'login', 'nguoi_dung', 6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 08:41:13'),
(31, 6, 'login', 'nguoi_dung', 6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 08:49:49'),
(32, 6, 'login', 'nguoi_dung', 6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 08:51:13'),
(33, 6, 'login', 'nguoi_dung', 6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 08:52:25'),
(34, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-03 08:53:31'),
(35, 6, 'user_roles', 'nguoi_dung', 8, '::1', 'curl/8.21.0', '{\"truoc\":[\"player\",\"developer\"],\"sau\":[\"player\",\"developer\",\"moderator\"]}', '2026-11-03 08:53:46'),
(36, 6, 'user_roles', 'nguoi_dung', 8, '::1', 'curl/8.21.0', '{\"truoc\":[\"player\",\"developer\",\"moderator\"],\"sau\":[\"player\",\"developer\"]}', '2026-11-03 08:53:46'),
(37, 6, 'user_status', 'nguoi_dung', 7, '::1', 'curl/8.21.0', '{\"trang_thai\":\"suspended\"}', '2026-11-03 08:53:47'),
(38, NULL, 'login_blocked', 'nguoi_dung', 7, '::1', 'curl/8.21.0', '{\"status\":\"suspended\"}', '2026-11-03 08:53:47'),
(39, 6, 'user_status', 'nguoi_dung', 7, '::1', 'curl/8.21.0', '{\"trang_thai\":\"active\"}', '2026-11-03 08:53:48'),
(40, 7, 'login', 'nguoi_dung', 7, '::1', 'curl/8.21.0', NULL, '2026-11-03 08:53:48'),
(41, 6, 'ownership_grant', 'tro_choi', 3, '::1', 'curl/8.21.0', '{\"nguoi_dung_id\":8}', '2026-11-03 08:53:49'),
(42, 7, 'game_status', 'tro_choi', 11, '::1', 'curl/8.21.0', '{\"truoc\":\"published\",\"sau\":\"under_review\"}', '2026-11-03 08:54:02'),
(43, 7, 'game_status', 'tro_choi', 11, '::1', 'curl/8.21.0', '{\"truoc\":\"under_review\",\"sau\":\"published\"}', '2026-11-03 08:54:03'),
(44, 6, 'user_status', 'nguoi_dung', 7, '::1', 'curl/8.21.0', '{\"trang_thai\":\"suspended\"}', '2026-11-03 08:54:04'),
(45, 6, 'user_status', 'nguoi_dung', 7, '::1', 'curl/8.21.0', '{\"trang_thai\":\"active\"}', '2026-11-03 08:54:04'),
(46, 7, 'login', 'nguoi_dung', 7, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 08:55:06'),
(47, 6, 'login', 'nguoi_dung', 6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 08:55:42'),
(48, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 11:30:31'),
(49, 7, 'login', 'nguoi_dung', 7, '::1', 'curl/8.21.0', NULL, '2026-11-03 11:30:31'),
(50, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-03 11:30:32'),
(51, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 11:30:48'),
(52, 7, 'login', 'nguoi_dung', 7, '::1', 'curl/8.21.0', NULL, '2026-11-03 11:30:48'),
(53, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-03 11:30:49'),
(54, 6, 'login', 'nguoi_dung', 6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 11:31:07'),
(55, 6, 'report_investigate', 'bao_cao_noi_dung', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 11:31:50'),
(56, 6, 'content_status', 'nhat_ky_phat_trien', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"truoc\":\"published\",\"sau\":\"hidden\",\"ly_do\":\"[KIỂM THỬ] Ẩn tạm để kiểm tra luồng xử lý báo cáo\"}', '2026-11-03 11:31:51'),
(57, 6, 'report_resolved', 'bao_cao_noi_dung', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"xu_ly\":\"hidden\"}', '2026-11-03 11:31:51'),
(58, 6, 'report_resolved', 'bao_cao_noi_dung', 2, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"xu_ly\":\"hidden\"}', '2026-11-03 11:31:51'),
(59, 6, 'report_resolved', 'bao_cao_noi_dung', 4, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"xu_ly\":null}', '2026-11-03 11:32:09'),
(60, 6, 'content_status', 'nhat_ky_phat_trien', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"truoc\":\"hidden\",\"sau\":\"published\",\"ly_do\":\"\"}', '2026-11-03 11:32:11'),
(61, 6, 'report_rejected', 'bao_cao_noi_dung', 3, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"xu_ly\":null}', '2026-11-03 11:32:21'),
(62, 6, 'refund_completed', 'hoan_tien', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"ghi_chu\":\"[KIỂM THỬ] Duyệt hoàn tiền đơn thử nghiệm\"}', '2026-11-03 11:37:58'),
(63, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-03 11:38:51'),
(64, 7, 'login', 'nguoi_dung', 7, '::1', 'curl/8.21.0', NULL, '2026-11-03 11:38:52'),
(65, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 11:38:53'),
(66, 8, 'login', 'nguoi_dung', 8, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 11:49:17'),
(67, 8, 'payout_account_added', 'tai_khoan_nhan_tien_nguoi_dung', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"nha_cung_cap\":\"bank_transfer\"}', '2026-11-03 11:49:35'),
(68, 8, 'payout_account_added', 'tai_khoan_nhan_tien_nguoi_dung', 2, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"nha_cung_cap\":\"paypal\"}', '2026-11-03 11:49:36'),
(69, 8, 'payout_account_default', 'tai_khoan_nhan_tien_nguoi_dung', 2, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 11:49:37'),
(70, 8, 'login', 'nguoi_dung', 8, '::1', 'curl/8.21.0', NULL, '2026-11-03 11:49:52'),
(71, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-03 11:49:54'),
(72, 6, 'payout_account_active', 'tai_khoan_nhan_tien_nguoi_dung', 1, '::1', 'curl/8.21.0', NULL, '2026-11-03 11:49:54'),
(73, 8, 'game_created', 'tro_choi', 14, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 12:06:15'),
(74, 8, 'game_updated', 'tro_choi', 14, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"truoc\":\"draft\",\"sau\":\"published\"}', '2026-11-03 12:06:44'),
(75, 8, 'game_updated', 'tro_choi', 14, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"truoc\":\"published\",\"sau\":\"unlisted\"}', '2026-11-03 12:06:44'),
(76, 8, 'game_updated', 'tro_choi', 14, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 12:07:05'),
(77, 8, 'game_updated', 'tro_choi', 14, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 12:07:32'),
(78, 8, 'media_added', 'media_tro_choi', 31, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"tro_choi_id\":14,\"loai\":\"cover\"}', '2026-11-03 12:08:51'),
(79, 8, 'media_added', 'media_tro_choi', 32, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"tro_choi_id\":14,\"loai\":\"trailer\"}', '2026-11-03 12:10:27'),
(80, 8, 'media_updated', 'media_tro_choi', 32, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 12:10:42'),
(81, 8, 'media_deleted', 'media_tro_choi', 32, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"tro_choi_id\":14,\"loai\":\"trailer\"}', '2026-11-03 12:10:43'),
(82, 8, 'media_deleted', 'media_tro_choi', 31, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"tro_choi_id\":14,\"loai\":\"cover\"}', '2026-11-03 12:10:46'),
(83, 8, 'game_authors', 'tro_choi', 14, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"tac_gia\":{\"8\":70.5,\"10\":29.5},\"go\":[]}', '2026-11-03 12:11:40'),
(84, 8, 'game_authors', 'tro_choi', 14, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"tac_gia\":{\"8\":100},\"go\":[10]}', '2026-11-03 12:11:49'),
(85, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:12:50'),
(86, 6, 'user_roles', 'nguoi_dung', 5, '::1', 'curl/8.21.0', '{\"truoc\":[\"player\"],\"sau\":[\"player\",\"developer\"]}', '2026-11-03 12:12:50'),
(87, 8, 'game_authors', 'tro_choi', 14, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"tac_gia\":{\"8\":100,\"5\":0},\"go\":[]}', '2026-11-03 12:13:00'),
(88, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:13:04'),
(89, 8, 'release_added', 'phien_ban_phat_hanh', 3, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"tro_choi_id\":14,\"phien_ban\":\"0.1.0\"}', '2026-11-03 12:13:50'),
(90, 8, 'release_added', 'phien_ban_phat_hanh', 4, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"tro_choi_id\":14,\"phien_ban\":\"0.1.0\"}', '2026-11-03 12:13:55'),
(91, 8, 'release_added', 'phien_ban_phat_hanh', 5, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"tro_choi_id\":14,\"phien_ban\":\"1.0.0\"}', '2026-11-03 12:13:57'),
(92, 8, 'release_updated', 'phien_ban_phat_hanh', 5, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 12:13:59'),
(93, 8, 'release_updated', 'phien_ban_phat_hanh', 5, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 12:14:03'),
(94, 8, 'release_deleted', 'phien_ban_phat_hanh', 5, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"tro_choi_id\":14,\"phien_ban\":\"0.1.1\",\"kenh\":\"alpha\"}', '2026-11-03 12:14:04'),
(95, 8, 'devlog_created', 'nhat_ky_phat_trien', 3, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"trang_thai\":\"draft\"}', '2026-11-03 12:15:21'),
(96, 8, 'devlog_updated', 'nhat_ky_phat_trien', 3, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"truoc\":\"draft\",\"sau\":\"published\"}', '2026-11-03 12:15:33'),
(97, 8, 'devlog_created', 'nhat_ky_phat_trien', 4, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"trang_thai\":\"draft\"}', '2026-11-03 12:15:35'),
(98, 8, 'game_page_saved', 'tro_choi', 14, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"mau_nen\":\"#1a1a2e\",\"mau_chu\":\"#f5f5f5\",\"mau_lien_ket\":\"#ffd166\",\"bo_cuc_trang\":\"wide\",\"bat_cong_dong\":1,\"hien_thi_nha_sang_tao\":0}', '2026-11-03 12:22:51'),
(99, 8, 'keys_generated', 'tro_choi', 14, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"so_luong\":3,\"het_han\":\"2026-12-31 23:59:59\"}', '2026-11-03 12:23:24'),
(100, 8, 'key_revoked', 'ma_truy_cap_tro_choi', 3, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 12:23:24'),
(101, 8, 'keys_generated', 'tro_choi', 14, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"so_luong\":1,\"het_han\":null}', '2026-11-03 12:24:16'),
(102, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:24:28'),
(103, 6, 'key_redeem_fail', 'ma_truy_cap_tro_choi', NULL, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:24:29'),
(104, 6, 'key_redeem', 'ma_truy_cap_tro_choi', 4, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:24:29'),
(105, 6, 'key_redeem_fail', 'ma_truy_cap_tro_choi', NULL, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:24:39'),
(106, 8, 'game_authors', 'tro_choi', 14, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"tac_gia\":{\"8\":100},\"go\":[5]}', '2026-11-03 12:26:55'),
(107, 6, 'user_roles', 'nguoi_dung', 5, '::1', 'curl/8.21.0', '{\"truoc\":[\"player\",\"developer\"],\"sau\":[\"player\"]}', '2026-11-03 12:27:03'),
(108, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:27:15'),
(109, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:27:23'),
(110, 8, 'coupon.create', 'ma_giam_gia', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"code\":\"DULIEUTHU-DEV10\"}', '2026-11-03 12:32:20'),
(111, 8, 'coupon.create', 'ma_giam_gia', 2, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"code\":\"DULIEUTHU-DEV2USD\"}', '2026-11-03 12:32:28'),
(112, 8, 'coupon.disable', 'ma_giam_gia', 2, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"code\":\"DULIEUTHU-DEV2USD\"}', '2026-11-03 12:32:28'),
(113, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:33:39'),
(114, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:33:40'),
(115, 7, 'login', 'nguoi_dung', 7, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:33:40'),
(116, 6, 'coupon.enable', 'ma_giam_gia', 2, '::1', 'curl/8.21.0', '{\"code\":\"DULIEUTHU-DEV2USD\"}', '2026-11-03 12:33:42'),
(117, 6, 'coupon.create', 'ma_giam_gia', 3, '::1', 'curl/8.21.0', '{\"code\":\"DULIEUTHU-ADMIN15\"}', '2026-11-03 12:33:42'),
(118, 8, 'login', 'nguoi_dung', 8, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:33:55'),
(119, 8, 'coupon.disable', 'ma_giam_gia', 1, '::1', 'curl/8.21.0', '{\"code\":\"DULIEUTHU-DEV10\"}', '2026-11-03 12:34:36'),
(120, 8, 'coupon.enable', 'ma_giam_gia', 1, '::1', 'curl/8.21.0', '{\"code\":\"DULIEUTHU-DEV10\"}', '2026-11-03 12:34:37'),
(121, 6, 'login', 'nguoi_dung', 6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 12:39:44'),
(122, 6, 'campaign.create', 'chien_dich_giam_gia', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"status\":\"active\",\"games\":[11]}', '2026-11-03 12:39:45'),
(123, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:40:41'),
(124, 6, 'campaign.update', 'chien_dich_giam_gia', 1, '::1', 'curl/8.21.0', '{\"status\":\"cancelled\",\"games\":[11]}', '2026-11-03 12:40:41'),
(125, 6, 'campaign.update', 'chien_dich_giam_gia', 1, '::1', 'curl/8.21.0', '{\"status\":\"scheduled\",\"games\":[11]}', '2026-11-03 12:40:42'),
(126, 6, 'campaign.update', 'chien_dich_giam_gia', 1, '::1', 'curl/8.21.0', '{\"status\":\"active\",\"games\":[11,14]}', '2026-11-03 12:40:44'),
(127, 6, 'login', 'nguoi_dung', 6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 12:40:57'),
(128, 6, 'login', 'nguoi_dung', 6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 12:43:37'),
(129, 6, 'login', 'nguoi_dung', 6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 12:49:01'),
(130, 6, 'taxonomy.create', 'nhan', 17, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"ten\":\"[DỮ LIỆU THỬ] Thẻ kiểm thử\",\"duong_dan_rut_gon\":\"du-lieu-thu-the-kiem-thu\"}', '2026-11-03 12:49:03'),
(131, 6, 'taxonomy.update', 'nhan', 17, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"before\":{\"ten\":\"[DỮ LIỆU THỬ] Thẻ kiểm thử\",\"duong_dan_rut_gon\":\"du-lieu-thu-the-kiem-thu\"},\"after\":{\"ten\":\"[DỮ LIỆU THỬ] Thẻ kiểm thử đã sửa\",\"duong_dan_rut_gon\":\"du-lieu-thu-the-kiem-thu\"}}', '2026-11-03 12:49:05'),
(132, 6, 'login', 'nguoi_dung', 6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 12:49:30'),
(133, 6, 'login', 'nguoi_dung', 6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 12:49:52'),
(134, 6, 'taxonomy.delete', 'nhan', 17, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"name\":\"[DỮ LIỆU THỬ] Thẻ kiểm thử đã sửa\",\"key\":\"du-lieu-thu-the-kiem-thu\"}', '2026-11-03 12:49:53'),
(135, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:50:04'),
(136, 7, 'login', 'nguoi_dung', 7, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:50:04'),
(137, 8, 'login', 'nguoi_dung', 8, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:50:05'),
(138, 8, 'bundle.create', 'goi_game', 3, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"status\":\"draft\",\"price\":4.5,\"games\":[12,11]}', '2026-11-03 12:53:48'),
(139, 8, 'bundle.update', 'goi_game', 3, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"status\":\"draft\",\"price\":4.5,\"games\":[12,11]}', '2026-11-03 12:53:49'),
(140, 8, 'bundle.update', 'goi_game', 3, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"status\":\"hidden\",\"price\":4.5,\"games\":[12,11]}', '2026-11-03 12:54:08'),
(141, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:55:29'),
(142, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:55:29'),
(143, 7, 'login', 'nguoi_dung', 7, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:55:29'),
(144, 8, 'login', 'nguoi_dung', 8, '::1', 'curl/8.21.0', NULL, '2026-11-03 12:55:30'),
(145, 6, 'login', 'nguoi_dung', 6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 12:55:50'),
(146, 6, 'login', 'nguoi_dung', 6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 12:56:18'),
(147, 6, 'login', 'nguoi_dung', 6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 12:59:10'),
(148, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 13:16:12'),
(149, 8, 'login', 'nguoi_dung', 8, '::1', 'curl/8.21.0', NULL, '2026-11-03 13:16:13'),
(150, 7, 'login', 'nguoi_dung', 7, '::1', 'curl/8.21.0', NULL, '2026-11-03 13:16:13'),
(151, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-03 13:16:13'),
(152, 8, 'jam_submit', 'bai_du_thi', 1, '::1', 'curl/8.21.0', '{\"jam\":1,\"game\":11}', '2026-11-03 13:18:22'),
(153, 8, 'jam_submit', 'bai_du_thi', 2, '::1', 'curl/8.21.0', '{\"jam\":1,\"game\":14}', '2026-11-03 13:18:22'),
(154, 8, 'jam_withdraw', 'bai_du_thi', 2, '::1', 'curl/8.21.0', NULL, '2026-11-03 13:18:24'),
(155, 8, 'jam_submit', 'bai_du_thi', 2, '::1', 'curl/8.21.0', '{\"jam\":1,\"game\":14}', '2026-11-03 13:18:24'),
(156, 6, 'jam_update', 'cuoc_thi_lam_game', 1, '::1', 'curl/8.21.0', '{\"trang_thai\":\"published\"}', '2026-11-03 13:19:08'),
(157, 5, 'jam_vote', 'bai_du_thi', 1, '::1', 'curl/8.21.0', NULL, '2026-11-03 13:19:10'),
(158, 5, 'jam_vote', 'bai_du_thi', 1, '::1', 'curl/8.21.0', NULL, '2026-11-03 13:19:10'),
(159, 7, 'jam_vote', 'bai_du_thi', 2, '::1', 'curl/8.21.0', NULL, '2026-11-03 13:19:14'),
(160, 6, 'jam_member_set', 'cuoc_thi_lam_game', 1, '::1', 'curl/8.21.0', '{\"user\":7,\"role\":\"judge\"}', '2026-11-03 13:19:16'),
(161, 6, 'jam_member_remove', 'cuoc_thi_lam_game', 1, '::1', 'curl/8.21.0', '{\"user\":7}', '2026-11-03 13:19:19'),
(162, 6, 'jam_entry_disqualified', 'bai_du_thi', 2, '::1', 'curl/8.21.0', '{\"reason\":\"[DỮ LIỆU THỬ] Kiểm thử loại bài\"}', '2026-11-03 13:19:20'),
(163, 6, 'jam_entry_submitted', 'bai_du_thi', 2, '::1', 'curl/8.21.0', '{\"reason\":\"\"}', '2026-11-03 13:19:22'),
(164, 6, 'jam_update', 'cuoc_thi_lam_game', 1, '::1', 'curl/8.21.0', '{\"trang_thai\":\"published\"}', '2026-11-03 13:19:23'),
(165, 5, 'login', 'nguoi_dung', 5, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 13:20:53'),
(166, 5, 'login', 'nguoi_dung', 5, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 13:22:57'),
(167, 8, 'login', 'nguoi_dung', 8, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 13:23:51'),
(168, 7, 'login', 'nguoi_dung', 7, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 13:25:09'),
(169, 6, 'login', 'nguoi_dung', 6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 13:25:58'),
(170, 6, 'login', 'nguoi_dung', 6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 13:27:47'),
(171, 8, 'login', 'nguoi_dung', 8, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 13:28:34'),
(172, 8, 'login', 'nguoi_dung', 8, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 13:29:38'),
(173, 8, 'jam_withdraw', 'bai_du_thi', 2, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-03 13:29:39'),
(174, 8, 'jam_submit', 'bai_du_thi', 2, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '{\"jam\":1,\"game\":14}', '2026-11-03 13:29:40'),
(175, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-03 13:57:39'),
(176, 8, 'login', 'nguoi_dung', 8, '::1', 'curl/8.21.0', NULL, '2026-11-03 13:57:39'),
(177, 7, 'login', 'nguoi_dung', 7, '::1', 'curl/8.21.0', NULL, '2026-11-03 13:57:39'),
(178, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-03 13:57:39'),
(179, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-04 01:06:17'),
(180, 8, 'login', 'nguoi_dung', 8, '::1', 'curl/8.21.0', NULL, '2026-11-04 01:06:17'),
(181, 7, 'login', 'nguoi_dung', 7, '::1', 'curl/8.21.0', NULL, '2026-11-04 01:06:18'),
(182, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-04 01:06:18'),
(183, 5, 'login', 'nguoi_dung', 5, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-04 01:22:59'),
(184, 5, 'login', 'nguoi_dung', 5, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-04 01:23:23'),
(185, 5, 'order_paid', 'don_hang', 4, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-04 01:23:23'),
(186, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-04 01:25:01'),
(187, 8, 'login', 'nguoi_dung', 8, '::1', 'curl/8.21.0', NULL, '2026-11-04 01:25:01'),
(188, 7, 'login', 'nguoi_dung', 7, '::1', 'curl/8.21.0', NULL, '2026-11-04 01:25:02'),
(189, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-04 01:25:02'),
(190, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-04 01:54:13'),
(191, 8, 'login', 'nguoi_dung', 8, '::1', 'curl/8.21.0', NULL, '2026-11-04 01:54:14'),
(192, 7, 'login', 'nguoi_dung', 7, '::1', 'curl/8.21.0', NULL, '2026-11-04 01:54:14'),
(193, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-04 01:54:14'),
(194, 5, 'login', 'nguoi_dung', 5, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-04 01:55:52'),
(195, 5, 'game_claim', 'tro_choi', 50, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-04 01:55:52'),
(196, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-04 02:29:08'),
(197, 8, 'login', 'nguoi_dung', 8, '::1', 'curl/8.21.0', NULL, '2026-11-04 02:29:08'),
(198, 7, 'login', 'nguoi_dung', 7, '::1', 'curl/8.21.0', NULL, '2026-11-04 02:29:08'),
(199, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-04 02:29:09'),
(200, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-04 02:29:20'),
(201, 8, 'login', 'nguoi_dung', 8, '::1', 'curl/8.21.0', NULL, '2026-11-04 02:29:21'),
(202, 7, 'login', 'nguoi_dung', 7, '::1', 'curl/8.21.0', NULL, '2026-11-04 02:29:21'),
(203, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-04 02:29:21'),
(204, 6, 'login', 'nguoi_dung', 6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', NULL, '2026-11-04 02:31:01'),
(205, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-04 02:42:51'),
(206, 8, 'login', 'nguoi_dung', 8, '::1', 'curl/8.21.0', NULL, '2026-11-04 02:42:51'),
(207, 7, 'login', 'nguoi_dung', 7, '::1', 'curl/8.21.0', NULL, '2026-11-04 02:42:51'),
(208, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-04 02:42:52'),
(209, 5, 'login', 'nguoi_dung', 5, '::1', 'curl/8.21.0', NULL, '2026-11-04 02:44:15'),
(210, 8, 'login', 'nguoi_dung', 8, '::1', 'curl/8.21.0', NULL, '2026-11-04 02:44:16'),
(211, 7, 'login', 'nguoi_dung', 7, '::1', 'curl/8.21.0', NULL, '2026-11-04 02:44:16'),
(212, 6, 'login', 'nguoi_dung', 6, '::1', 'curl/8.21.0', NULL, '2026-11-04 02:44:16');

-- --------------------------------------------------------

--
-- Table structure for table `nhat_ky_phat_trien`
--

CREATE TABLE `nhat_ky_phat_trien` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `tac_gia_nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `tieu_de` varchar(200) NOT NULL,
  `duong_dan_rut_gon` varchar(220) NOT NULL,
  `noi_dung` mediumtext NOT NULL,
  `trang_thai` enum('draft','published','hidden') NOT NULL DEFAULT 'draft',
  `ngay_cong_bo` datetime DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nhat_ky_phat_trien`
--

INSERT INTO `nhat_ky_phat_trien` (`ma`, `tro_choi_id`, `tac_gia_nguoi_dung_id`, `tieu_de`, `duong_dan_rut_gon`, `noi_dung`, `trang_thai`, `ngay_cong_bo`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(5, 15, 53, 'Bản cập nhật 1.5: Đảo Gừng và chơi chung chia màn hình', 'ban-cap-nhat-1-5', 'Bản cập nhật 1.5 của Stardew Valley phát hành trên PC ngày 21/12/2020.\nĐiểm chính: khu vực mới Đảo Gừng (Ginger Island) và chế độ chơi chung chia màn hình trên cùng một máy.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/413150', 'published', '2026-09-05 09:00:00', '2026-09-05 02:00:00', '2026-09-05 02:00:00'),
(6, 15, 53, 'Bản cập nhật 1.6 phát hành trên PC', 'ban-cap-nhat-1-6', 'Bản cập nhật 1.6 phát hành trên PC ngày 19/3/2024, bổ sung thêm nội dung mới như lễ hội và một kiểu nông trại mới (Meadowlands).\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/413150', 'published', '2026-09-20 09:00:00', '2026-09-20 02:00:00', '2026-09-20 02:00:00'),
(7, 15, 53, 'Haunted Chocolatier: dự án tiếp theo của ConcernedApe', 'haunted-chocolatier', 'Tháng 10/2021, ConcernedApe công bố Haunted Chocolatier, trò chơi tiếp theo sau Stardew Valley. Tại thời điểm công bố, trò chơi chưa có ngày phát hành.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://www.hauntedchocolatier.net', 'published', '2026-10-12 09:00:00', '2026-10-12 02:00:00', '2026-10-12 02:00:00'),
(8, 21, 59, 'Journey\'s End (1.4) phát hành', 'journeys-end', 'Terraria 1.4 \"Journey\'s End\" phát hành ngày 16/5/2020, bổ sung chế độ Journey dành cho người chơi muốn tùy chỉnh độ khó và sáng tạo.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/105600', 'published', '2026-09-08 10:00:00', '2026-09-08 03:00:00', '2026-09-08 03:00:00'),
(9, 21, 59, 'Labor of Love (1.4.4) phát hành', 'labor-of-love', 'Terraria 1.4.4 \"Labor of Love\" phát hành ngày 28/9/2022, tập trung vào cải thiện trải nghiệm và bổ sung nội dung nhỏ.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/105600', 'published', '2026-10-01 10:00:00', '2026-10-01 03:00:00', '2026-10-01 03:00:00'),
(10, 16, 54, 'Godmaster: bản mở rộng miễn phí cuối cùng', 'godmaster', 'Bản mở rộng miễn phí Godmaster của Hollow Knight phát hành ngày 23/8/2018, bổ sung các thử thách đấu trùm liên tiếp (Pantheon) và trùm mới.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/367520', 'published', '2026-09-10 08:00:00', '2026-09-10 01:00:00', '2026-09-10 01:00:00'),
(11, 16, 54, 'Hollow Knight: Silksong đã phát hành', 'silksong-phat-hanh', 'Hollow Knight: Silksong, phần tiếp theo với nhân vật chính Hornet, phát hành ngày 4/9/2025. Silksong là sản phẩm riêng, không thuộc trang này.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/app/1030300', 'published', '2026-10-05 08:00:00', '2026-10-05 01:00:00', '2026-10-05 01:00:00'),
(12, 17, 55, 'Chương 9 \\\"Farewell\\\" phát hành miễn phí', 'farewell', 'Chương bổ sung Farewell của Celeste phát hành miễn phí ngày 9/9/2019, với nhiều màn chơi mới và kết thúc câu chuyện của Madeline.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/504230', 'published', '2026-09-12 08:30:00', '2026-09-12 01:30:00', '2026-09-12 01:30:00'),
(13, 18, 56, 'Hades rời giai đoạn truy cập sớm', 'hades-1-0', 'Hades phát hành bản 1.0 ngày 17/9/2020, sau giai đoạn truy cập sớm, hoàn thiện câu chuyện của Zagreus.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/1145360', 'published', '2026-09-14 11:00:00', '2026-09-14 04:00:00', '2026-09-14 04:00:00'),
(14, 18, 56, 'Hades II mở truy cập sớm', 'hades-ii-truy-cap-som', 'Hades II mở truy cập sớm ngày 6/5/2024, với nhân vật chính Melinoë. Hades II là sản phẩm riêng, không thuộc trang này.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/app/1145350', 'published', '2026-10-08 11:00:00', '2026-10-08 04:00:00', '2026-10-08 04:00:00'),
(15, 19, 57, 'Return to Castlevania', 'return-to-castlevania', 'Bản mở rộng Return to Castlevania của Dead Cells phát hành ngày 6/3/2023, bổ sung khu vực và nhân vật từ loạt Castlevania như Richter, Alucard và Dracula.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/588650', 'published', '2026-09-16 09:30:00', '2026-09-16 02:30:00', '2026-09-16 02:30:00'),
(16, 20, 58, 'Mega Crit công bố Slay the Spire 2', 'cong-bo-slay-the-spire-2', 'Tháng 4/2024, Mega Crit công bố Slay the Spire 2, phần tiếp theo của trò chơi roguelike thẻ bài này.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://www.megacrit.com', 'published', '2026-09-18 10:00:00', '2026-09-18 03:00:00', '2026-09-18 03:00:00'),
(17, 23, 61, 'Bản 1.0 phát hành', 'ban-1-0', 'Vampire Survivors rời truy cập sớm và phát hành bản 1.0 ngày 20/10/2022.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/1794680', 'published', '2026-09-22 09:00:00', '2026-09-22 02:00:00', '2026-09-22 02:00:00'),
(18, 23, 61, 'Bản mở rộng Emergency Meeting', 'emergency-meeting', 'Tháng 12/2023, poncle phát hành bản mở rộng Emergency Meeting, hợp tác với Among Us.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/1794680', 'published', '2026-10-15 09:00:00', '2026-10-15 02:00:00', '2026-10-15 02:00:00'),
(19, 31, 69, 'Balatro chính thức phát hành', 'phat-hanh', 'Balatro, trò chơi roguelike dựa trên bài poker của LocalThunk, phát hành ngày 20/2/2024.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/2379780', 'published', '2026-09-24 10:00:00', '2026-09-24 03:00:00', '2026-09-24 03:00:00'),
(20, 37, 75, 'Factorio 1.0', 'factorio-1-0', 'Factorio rời truy cập sớm và phát hành bản 1.0 ngày 14/8/2020.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/427520', 'published', '2026-09-03 08:00:00', '2026-09-03 01:00:00', '2026-09-03 01:00:00'),
(21, 37, 75, 'Factorio 2.0 và bản mở rộng Space Age', 'factorio-2-0-space-age', 'Ngày 21/10/2024, Wube phát hành bản cập nhật 2.0 cùng bản mở rộng Space Age, đưa nhà máy lên các hành tinh khác.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://factorio.com', 'published', '2026-10-20 08:00:00', '2026-10-20 01:00:00', '2026-10-20 01:00:00'),
(22, 34, 72, 'RimWorld 1.0', 'rimworld-1-0', 'RimWorld phát hành bản 1.0 ngày 17/10/2018, sau nhiều năm truy cập sớm.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/294100', 'published', '2026-09-06 12:00:00', '2026-09-06 05:00:00', '2026-09-06 05:00:00'),
(23, 34, 72, 'Bản mở rộng Biotech', 'biotech', 'Bản mở rộng Biotech phát hành ngày 21/10/2022, bổ sung hệ thống gia đình, trẻ em và máy móc cơ giới.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/294100', 'published', '2026-09-28 12:00:00', '2026-09-28 05:00:00', '2026-09-28 05:00:00'),
(24, 34, 72, 'Bản mở rộng Anomaly', 'anomaly', 'Bản mở rộng Anomaly phát hành ngày 11/4/2024, với nội dung kinh dị và các thực thể bí ẩn.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/294100', 'published', '2026-10-18 12:00:00', '2026-10-18 05:00:00', '2026-10-18 05:00:00'),
(25, 33, 71, 'The Delicious Last Course', 'the-delicious-last-course', 'Bản mở rộng The Delicious Last Course của Cuphead phát hành ngày 30/6/2022, với nhân vật Ms. Chalice và các trùm mới.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/268910', 'published', '2026-09-26 14:00:00', '2026-09-26 07:00:00', '2026-09-26 07:00:00'),
(26, 29, 67, 'FTL: Advanced Edition', 'advanced-edition', 'FTL: Advanced Edition là bản cập nhật miễn phí phát hành ngày 3/4/2014, bổ sung tàu, sự kiện và hệ thống mới.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/212680', 'published', '2026-09-30 09:00:00', '2026-09-30 02:00:00', '2026-09-30 02:00:00'),
(27, 42, 67, 'Into the Breach: Advanced Edition', 'advanced-edition', 'Into the Breach: Advanced Edition là bản cập nhật miễn phí phát hành ngày 19/7/2022, bổ sung đội cơ giới, kẻ địch và sự kiện mới.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/590380', 'published', '2026-10-03 09:00:00', '2026-10-03 02:00:00', '2026-10-03 02:00:00'),
(28, 45, 80, 'Echoes of the Eye', 'echoes-of-the-eye', 'Bản mở rộng Echoes of the Eye của Outer Wilds phát hành ngày 28/9/2021, mở ra một khu vực bí ẩn mới.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/753640', 'published', '2026-10-06 10:00:00', '2026-10-06 03:00:00', '2026-10-06 03:00:00'),
(29, 32, 70, 'Darkest Dungeon II phát hành bản 1.0', 'darkest-dungeon-ii-1-0', 'Darkest Dungeon II, phần tiếp theo của Red Hook Studios, phát hành bản 1.0 ngày 8/5/2023. Darkest Dungeon II là sản phẩm riêng, không thuộc trang này.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://www.redhook.ca', 'published', '2026-10-09 10:00:00', '2026-10-09 03:00:00', '2026-10-09 03:00:00'),
(30, 36, 74, 'Deltarune Chương 3 và 4', 'deltarune-chuong-3-4', 'Ngày 4/6/2025, Toby Fox phát hành Chương 3 và Chương 4 của Deltarune. Deltarune là sản phẩm riêng, không thuộc trang này.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://deltarune.com', 'published', '2026-10-11 10:00:00', '2026-10-11 03:00:00', '2026-10-11 03:00:00'),
(31, 38, 68, 'Oxygen Not Included rời truy cập sớm', 'ban-1-0', 'Oxygen Not Included phát hành bản 1.0 ngày 30/7/2019.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/457140', 'published', '2026-10-13 09:00:00', '2026-10-13 02:00:00', '2026-10-13 02:00:00'),
(32, 30, 68, 'Don\'t Starve Together thành sản phẩm độc lập', 'dont-starve-together', 'Tháng 4/2016, Don\'t Starve Together trở thành sản phẩm độc lập trên Steam. Don\'t Starve Together không thuộc trang này.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/app/322330', 'published', '2026-10-16 09:00:00', '2026-10-16 02:00:00', '2026-10-16 02:00:00'),
(33, 25, 63, 'Kaycee\'s Mod', 'kaycees-mod', 'Năm 2022, Daniel Mullins Games phát hành bản cập nhật miễn phí Kaycee\'s Mod, thêm chế độ chơi lại kiểu roguelike cho Inscryption.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://store.steampowered.com/news/app/1092790', 'published', '2026-10-19 09:00:00', '2026-10-19 02:00:00', '2026-10-19 02:00:00'),
(34, 6, 12, 'Minetest đổi tên thành Luanti', 'doi-ten-luanti', 'Tháng 10/2024, dự án Minetest đổi tên thành Luanti để phân biệt engine với các trò chơi chạy trên nó.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://www.luanti.org', 'published', '2026-09-02 08:00:00', '2026-09-02 01:00:00', '2026-09-02 01:00:00'),
(35, 4, 10, 'SuperTuxKart 1.0 và chơi trực tuyến', 'supertuxkart-1-0', 'Tháng 4/2019, SuperTuxKart phát hành bản 1.0, có chế độ chơi trực tuyến.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://supertuxkart.net', 'published', '2026-09-04 08:00:00', '2026-09-04 01:00:00', '2026-09-04 01:00:00'),
(36, 8, 14, 'OpenTTD có mặt trên Steam', 'openttd-tren-steam', 'Từ ngày 1/4/2021, OpenTTD có mặt miễn phí trên Steam.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://www.openttd.org', 'published', '2026-09-09 08:00:00', '2026-09-09 01:00:00', '2026-09-09 01:00:00'),
(37, 47, 82, 'Mã nguồn mở từ năm 2004', 'ma-nguon-mo-2004', 'Tháng 12/2004, mã nguồn Warzone 2100 được phát hành theo giấy phép GPL, mở đường cho dự án cộng đồng tiếp tục phát triển trò chơi đến nay.\n\nTóm tắt từ thông báo chính thức. Nội dung do nền tảng tóm tắt lại bằng tiếng Việt, không phải bài viết gốc của nhà phát triển.\n\nNguồn: https://wz2100.net', 'published', '2026-09-11 08:00:00', '2026-09-11 01:00:00', '2026-09-11 01:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `phien_ban_phat_hanh`
--

CREATE TABLE `phien_ban_phat_hanh` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `ten_phien_ban` varchar(60) NOT NULL,
  `kenh_phat_hanh` enum('stable','beta','alpha','preview') NOT NULL DEFAULT 'stable',
  `ghi_chu_phat_hanh` mediumtext DEFAULT NULL,
  `cong_khai` tinyint(1) NOT NULL DEFAULT 1,
  `ngay_phat_hanh` datetime DEFAULT NULL,
  `nguoi_tao_id` bigint(20) UNSIGNED NOT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `phien_ban_phat_hanh`
--

INSERT INTO `phien_ban_phat_hanh` (`ma`, `tro_choi_id`, `ten_phien_ban`, `kenh_phat_hanh`, `ghi_chu_phat_hanh`, `cong_khai`, `ngay_phat_hanh`, `nguoi_tao_id`, `ngay_tao`) VALUES
(6, 3, 'Alpha 26 “Zhuangzi”', 'stable', 'Bản alpha thứ 26 của 0 A.D., đặt tên theo triết gia Trang Tử (Zhuangzi).\nNguồn: https://github.com/0ad/0ad/releases/tag/A26', 1, '2022-09-24 16:30:27', 9, '2022-09-24 09:30:27'),
(7, 3, 'Alpha 27 “Agni”', 'stable', 'Bản alpha thứ 27 và là bản alpha cuối cùng. Điểm mới: bộ dựng hình Vulkan, lưu ván chơi nhiều người, trang mẹo chơi, làm lại hải chiến, cờ hiệu cho người xem, các bản đồ ngẫu nhiên mới Foothills, Migration và Coast Range.\nNguồn: https://gitea.wildfiregames.com/0ad/0ad/releases/tag/a27', 1, '2025-01-30 10:57:21', 9, '2025-01-30 03:57:21'),
(8, 3, 'Alpha 27.1', 'stable', 'Bản vá đầu tiên cho Alpha 27: sửa lỗi hiệu năng nghiêm trọng trên một số máy cũ và tăng tốc tính mã băm mô phỏng (liên quan đến hiện tượng giật khi chơi mạng).\nNguồn: https://gitea.wildfiregames.com/0ad/0ad/releases/tag/a27.1', 1, '2025-07-14 14:47:59', 9, '2025-07-14 07:47:59'),
(9, 3, 'Release 28 “Boiorix”', 'stable', 'Đặt tên theo vua Boiorix của người German. Điểm mới: phe người German, dân thường có giới tính nam và nữ, hiển thị trực tiếp phông chữ CJK (không cần mod riêng), thêm tùy chọn thiết lập ván chơi, cho phép viết mod bằng module JavaScript.\nNguồn: https://gitea.wildfiregames.com/0ad/0ad/releases/tag/v0.28.0', 1, '2026-02-15 18:46:25', 9, '2026-02-15 11:46:25'),
(10, 4, '1.3', 'stable', 'Bản phát hành ổn định SuperTuxKart 1.3, có gói cho Linux, Windows (gồm cả Windows ARM 64-bit) và mã nguồn.\nNguồn: https://github.com/supertuxkart/stk-code/releases/tag/1.3', 1, '2021-09-28 09:52:05', 10, '2021-09-28 02:52:05'),
(11, 4, '1.4', 'stable', 'Bản phát hành ổn định SuperTuxKart 1.4, có gói cho Linux, Windows và mã nguồn.\nNguồn: https://github.com/supertuxkart/stk-code/releases/tag/1.4', 1, '2022-10-31 19:32:12', 10, '2022-10-31 12:32:12'),
(12, 4, '1.5', 'stable', 'Bản phát hành ổn định SuperTuxKart 1.5, sau các bản thử 1.5-beta1, 1.5-rc1 và 1.5-rc2. Có gói cho Linux, Windows và mã nguồn.\nNguồn: https://github.com/supertuxkart/stk-code/releases/tag/1.5', 1, '2025-10-20 18:48:01', 10, '2025-10-20 11:48:01'),
(13, 5, '1.18.6', 'stable', 'Bản bảo trì của nhánh ổn định 1.18. Ngày lấy theo thẻ phiên bản trong kho mã.\nNguồn: https://github.com/wesnoth/wesnoth/blob/1.18.6/changelog.md', 1, '2025-12-22 04:34:31', 11, '2025-12-21 21:34:31'),
(14, 5, '1.18.7', 'stable', 'Bản bảo trì của nhánh ổn định 1.18. Ngày lấy theo thẻ phiên bản trong kho mã.\nNguồn: https://github.com/wesnoth/wesnoth/blob/1.18.7/changelog.md', 1, '2026-04-06 04:18:34', 11, '2026-04-05 21:18:34'),
(15, 5, '1.18.8', 'stable', 'Bản bảo trì của nhánh ổn định 1.18. Ngày lấy theo thẻ phiên bản trong kho mã.\nNguồn: https://github.com/wesnoth/wesnoth/blob/1.18.8/changelog.md', 1, '2026-08-18 17:07:28', 11, '2026-08-18 10:07:28'),
(16, 5, '1.19.29', 'beta', 'Bản thuộc nhánh phát triển 1.19 (chuẩn bị cho bản ổn định kế tiếp), dành cho người muốn thử tính năng mới. Ngày lấy theo thẻ phiên bản trong kho mã.\nNguồn: https://github.com/wesnoth/wesnoth/blob/1.19.29/changelog.md', 1, '2026-10-21 04:48:47', 11, '2026-10-20 21:48:47'),
(17, 6, '5.16.1', 'stable', 'Bản sửa lỗi cho 5.16.0.\nNguồn: https://github.com/luanti-org/luanti/releases/tag/5.16.1', 1, '2026-05-10 18:34:21', 12, '2026-05-10 11:34:21'),
(18, 6, '5.17.0', 'stable', 'Bản này sửa các lỗ hổng bảo mật nghiêm trọng ở cả máy khách và máy chủ; nhóm phát triển khuyên mọi người cập nhật ngay.\nNguồn: https://github.com/luanti-org/luanti/releases/tag/5.17.0', 1, '2026-08-20 19:45:51', 12, '2026-08-20 12:45:51'),
(19, 6, '5.18.0', 'stable', 'Bản phát hành mới nhất, sau bản thử 5.18.0-rc1. Danh sách thay đổi đầy đủ có trên trang tài liệu Luanti.\nNguồn: https://github.com/luanti-org/luanti/releases/tag/5.18.0', 1, '2026-10-29 21:09:02', 12, '2026-10-29 14:09:02'),
(20, 7, 'v8 Build 158.1', 'stable', 'Sửa lỗi nhân đôi vật phẩm khi tải lại bản lưu có kho chứa, sửa lỗi crash do bệ hạ cánh điều khiển bằng logic, hiển thị lại máu khi điều khiển đơn vị mang khiên.\nNguồn: https://github.com/Anuken/Mindustry/releases/tag/v158.1', 1, '2026-05-25 02:13:24', 13, '2026-05-24 19:13:24'),
(21, 7, 'v8 Build 159.7', 'stable', 'Sửa băng chuyền không hiện trong bản xem trước sơ đồ, trình duyệt tệp Android xuất sai phần mở rộng, trình sửa logic chạy chậm trên điện thoại.\nNguồn: https://github.com/Anuken/Mindustry/releases/tag/v159.7', 1, '2026-07-19 23:41:43', 13, '2026-07-19 16:41:43'),
(22, 7, 'v8 Build 160', 'stable', 'Thêm hệ thống cho plugin máy chủ hiển thị giao diện tùy chỉnh trên máy khách, cho máy chủ gửi texture động, thêm nút khôi phục mod bị tắt tự động và chọn phiên bản khi cài lại mod.\nNguồn: https://github.com/Anuken/Mindustry/releases/tag/v160', 1, '2026-09-11 03:19:12', 13, '2026-09-10 20:19:12'),
(23, 7, 'v8 Build 160.7', 'stable', 'Sửa lỗi đổi lệnh và tư thế đơn vị không hoạt động trên máy chủ, sửa hiệu ứng vỡ khiên lặp lại khi trúng tháp Parallax.\nNguồn: https://github.com/Anuken/Mindustry/releases/tag/v160.7', 1, '2026-10-08 02:20:39', 13, '2026-10-07 19:20:39'),
(24, 8, '15.2', 'stable', 'Bản sửa lỗi: khắc phục nhiều lỗi crash (xây trạm xe buýt trên đường một chiều không chủ, bộ tạo tên thị trấn tiếng Séc, con trỏ OpenGL) và lỗi khí cầu rơi không chặn đường băng.\nNguồn: https://github.com/OpenTTD/OpenTTD/releases/tag/15.2', 1, '2026-02-18 22:13:04', 14, '2026-02-18 15:13:04'),
(25, 8, '15.3', 'stable', 'Bản sửa lỗi: khắc phục mất đồng bộ khi chơi mạng do tàu đâm nhau, lệnh có điều kiện yêu cầu độ tin cậy trên 100%, cải thiện hiển thị thanh công cụ với bộ đồ họa không mặc định.\nNguồn: https://github.com/OpenTTD/OpenTTD/releases/tag/15.3', 1, '2026-04-04 21:56:48', 14, '2026-04-04 14:56:48'),
(26, 8, '16.0-RC1', 'beta', 'Bản ứng viên phát hành đầu tiên của 16.0: cập nhật phông chữ TTF của OpenTTD lên v0.9 và sửa nhiều lỗi về tàu hỏa, nhà ga và đường bộ.\nNguồn: https://github.com/OpenTTD/OpenTTD/releases/tag/16.0-RC1', 1, '2026-10-31 21:58:31', 14, '2026-10-31 14:58:31'),
(27, 9, '0.8.5', 'stable', 'Bản phát hành ổn định Xonotic 0.8.5, công bố ngày 30/06/2022.\nNguồn: https://xonotic.org/posts/2022/xonotic-0-8-5-release/', 1, '2022-06-30 14:00:00', 15, '2022-06-30 07:00:00'),
(28, 9, '0.8.6', 'stable', 'Bản phát hành ổn định Xonotic 0.8.6, công bố ngày 20/06/2023.\nNguồn: https://xonotic.org/posts/2023/xonotic-0-8-6-release/', 1, '2023-06-20 14:00:00', 15, '2023-06-20 07:00:00'),
(29, 10, '3.2.4', 'stable', 'Bản bảo trì của nhánh ổn định 3.2. Ngày lấy theo thẻ R3_2_4 trong kho mã.\nNguồn: https://github.com/freeciv/freeciv/blob/R3_2_4/NEWS-3.2', 1, '2026-03-20 23:35:48', 16, '2026-03-20 16:35:48'),
(30, 10, '3.2.5', 'stable', 'Bản bảo trì của nhánh ổn định 3.2. Ngày lấy theo thẻ R3_2_5 trong kho mã.\nNguồn: https://github.com/freeciv/freeciv/blob/R3_2_5/NEWS-3.2', 1, '2026-07-09 23:10:17', 16, '2026-07-09 16:10:17'),
(31, 10, '3.2.6', 'stable', 'Bản bảo trì của nhánh ổn định 3.2. Ngày lấy theo thẻ R3_2_6 trong kho mã.\nNguồn: https://github.com/freeciv/freeciv/blob/R3_2_6/NEWS-3.2', 1, '2026-09-03 23:05:48', 16, '2026-09-03 16:05:48'),
(32, 15, '1.6', 'stable', 'Bản cập nhật được thông báo trên Steam với tiêu đề “Stardew Valley 1.6 Update Available now!”. Nền tảng này không phân phối bản cập nhật; thông tin chỉ để tham khảo.\nNguồn: https://store.steampowered.com/news/app/413150/view/7309977427453935016', 1, '2024-03-19 19:50:00', 53, '2024-03-19 12:50:00'),
(33, 15, '1.6.14', 'stable', 'Bản cập nhật được thông báo trên Steam với tiêu đề “1.6.14 Update”. Nền tảng này không phân phối bản cập nhật; thông tin chỉ để tham khảo.\nNguồn: https://store.steampowered.com/news/app/413150/view/6148070194801749418', 1, '2024-11-12 09:07:00', 53, '2024-11-12 02:07:00'),
(34, 15, '1.6.15', 'stable', 'Bản cập nhật được thông báo trên Steam với tiêu đề “Stardew Valley 1.6.15 Patch now available”. Nền tảng này không phân phối bản cập nhật; thông tin chỉ để tham khảo.\nNguồn: https://store.steampowered.com/news/app/413150/view/1786573930663336', 1, '2024-12-20 19:14:00', 53, '2024-12-20 12:14:00'),
(35, 16, '1.5.78.11833', 'stable', 'Bản cập nhật được thông báo trên Steam với tiêu đề “Update notes for v1.5.78.11833”. Nền tảng này không phân phối bản cập nhật; thông tin chỉ để tham khảo.\nNguồn: https://store.steampowered.com/news/app/367520/view/4103335143104482015', 1, '2021-10-21 07:35:00', 54, '2021-10-21 00:35:00'),
(36, 16, '1.5.12459', 'stable', 'Bản cập nhật được thông báo trên Steam với tiêu đề “Patch Version 1.5.12459 Now Live”. Nền tảng này không phân phối bản cập nhật; thông tin chỉ để tham khảo.\nNguồn: https://store.steampowered.com/news/app/367520/view/1823825466498013', 1, '2026-02-06 00:28:00', 54, '2026-02-05 17:28:00'),
(37, 16, '1.5.12620', 'stable', 'Bản cập nhật được thông báo trên Steam với tiêu đề “Patch Version 1.5.12620 Now Live”. Nền tảng này không phân phối bản cập nhật; thông tin chỉ để tham khảo.\nNguồn: https://store.steampowered.com/news/app/367520/view/1828441623103525', 1, '2026-03-27 05:25:00', 54, '2026-03-26 22:25:00'),
(38, 17, '1.4.0.0', 'stable', 'Bản cập nhật được thông báo trên Steam với tiêu đề “V1.4.0.0 Changelog”. Nền tảng này không phân phối bản cập nhật; thông tin chỉ để tham khảo.\nNguồn: https://store.steampowered.com/news/app/504230/view/4026755437314204797', 1, '2021-03-30 01:53:00', 55, '2021-03-29 18:53:00'),
(39, 18, 'Post-Launch Patch 02/2022', 'stable', 'Bản cập nhật được thông báo trên Steam với tiêu đề “Post-Launch Patch - February 2022”. Nền tảng này không phân phối bản cập nhật; thông tin chỉ để tham khảo.\nNguồn: https://store.steampowered.com/news/app/1145360/view/6154735015633625518', 1, '2022-02-15 23:05:00', 56, '2022-02-15 16:05:00'),
(40, 19, 'Update 35', 'stable', 'Bản cập nhật được thông báo trên Steam với tiêu đề “Update 35: The End is Near is now live!”. Nền tảng này không phân phối bản cập nhật; thông tin chỉ để tham khảo.\nNguồn: https://store.steampowered.com/news/app/588650/view/6909171012609189849', 1, '2024-08-19 08:16:00', 57, '2024-08-19 01:16:00'),
(41, 20, '2.3', 'stable', 'Bản cập nhật được thông báo trên Steam với tiêu đề “Patch V2.3: Steam Deck Support”. Nền tảng này không phân phối bản cập nhật; thông tin chỉ để tham khảo.\nNguồn: https://store.steampowered.com/news/app/646570/view/4246335832520442321', 1, '2022-02-27 23:22:00', 58, '2022-02-27 16:22:00'),
(42, 20, '2.3.4', 'stable', 'Bản cập nhật được thông báo trên Steam với tiêu đề “V2.3.4: Crash on launch fix for Non-English PC users”. Nền tảng này không phân phối bản cập nhật; thông tin chỉ để tham khảo.\nNguồn: https://store.steampowered.com/news/app/646570/view/5623338145767116262', 1, '2022-12-20 01:59:00', 58, '2022-12-19 18:59:00'),
(43, 21, '1.4.5', 'stable', 'Bản cập nhật được thông báo trên Steam với tiêu đề “Terraria 1.4.5: Bigger & Boulder - Available Now!”. Nền tảng này không phân phối bản cập nhật; thông tin chỉ để tham khảo.\nNguồn: https://store.steampowered.com/news/app/105600/view/1822556746169234', 1, '2026-01-27 16:16:00', 59, '2026-01-27 09:16:00'),
(44, 21, '1.4.5.7', 'stable', 'Bản cập nhật được thông báo trên Steam với tiêu đề “Terraria 1.4.5.7 - Out Now for PC! (Console/Mobile Soon)”. Nền tảng này không phân phối bản cập nhật; thông tin chỉ để tham khảo.\nNguồn: https://store.steampowered.com/news/app/105600/view/1841579228663704', 1, '2026-08-19 22:45:00', 59, '2026-08-19 15:45:00'),
(45, 22, '1.7', 'stable', 'Bản cập nhật được thông báo trên Steam với tiêu đề “Version 1.7 - Frequently Asked Features”. Nền tảng này không phân phối bản cập nhật; thông tin chỉ để tham khảo.\nNguồn: https://store.steampowered.com/news/app/1055540/view/3444639924509011007', 1, '2020-06-29 18:36:00', 60, '2020-06-29 11:36:00'),
(46, 23, '1.15', 'stable', 'Bản cập nhật được thông báo trên Steam với tiêu đề “Update 1.15 - list of fixes”. Nền tảng này không phân phối bản cập nhật; thông tin chỉ để tham khảo.\nNguồn: https://store.steampowered.com/news/app/1794680/view/1834602721194650', 1, '2026-06-06 21:56:00', 61, '2026-06-06 14:56:00'),
(47, 23, '1.16.111', 'stable', 'Bản cập nhật được thông báo trên Steam với tiêu đề “1.16.111 : hotfixes - Next patch preview - Ode to Castlevania Soundtrack”. Nền tảng này không phân phối bản cập nhật; thông tin chỉ để tham khảo.\nNguồn: https://store.steampowered.com/news/app/1794680/view/1846651706681529', 1, '2026-10-16 15:41:00', 61, '2026-10-16 08:41:00'),
(48, 24, '1.4.9', 'stable', 'Bản cập nhật được thông báo trên Steam với tiêu đề “Version 1.4.9 - Engine Update”. Nền tảng này không phân phối bản cập nhật; thông tin chỉ để tham khảo.\nNguồn: https://store.steampowered.com/news/app/239030/view/5070528176579566533', 1, '2023-03-07 09:00:00', 62, '2023-03-07 02:00:00'),
(49, 24, '1.4.11', 'stable', 'Bản cập nhật được thông báo trên Steam với tiêu đề “Update 1.4.11”. Nền tảng này không phân phối bản cập nhật; thông tin chỉ để tham khảo.\nNguồn: https://store.steampowered.com/news/app/239030/view/5125698536871369649', 1, '2023-03-21 09:16:00', 62, '2023-03-21 02:16:00'),
(60, 78, '1.0.0', 'stable', 'Bản phát hành đầu tiên.', 1, '2026-09-05 10:00:00', 171, '2026-11-01 08:30:00'),
(61, 78, '1.1.0', 'stable', 'Bản cập nhật thêm chế độ khó.', 1, '2026-10-28 10:00:00', 171, '2026-11-01 08:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `quyen_so_huu_tro_choi`
--

CREATE TABLE `quyen_so_huu_tro_choi` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `chi_tiet_don_hang_id` bigint(20) UNSIGNED DEFAULT NULL,
  `loai_nhan_quyen` enum('purchase','bundle','gift','free_claim','access_key','admin_grant') NOT NULL,
  `trang_thai` enum('active','revoked','refunded') NOT NULL DEFAULT 'active',
  `ngay_nhan_quyen` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_thu_hoi` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quyen_so_huu_tro_choi`
--

INSERT INTO `quyen_so_huu_tro_choi` (`ma`, `nguoi_dung_id`, `tro_choi_id`, `chi_tiet_don_hang_id`, `loai_nhan_quyen`, `trang_thai`, `ngay_nhan_quyen`, `ngay_thu_hoi`) VALUES
(4, 8, 3, NULL, 'admin_grant', 'active', '2026-11-03 08:53:49', NULL),
(6, 20, 3, NULL, 'free_claim', 'active', '2026-06-20 08:56:26', NULL),
(7, 52, 3, NULL, 'free_claim', 'active', '2026-06-21 08:56:26', NULL),
(8, 43, 3, NULL, 'free_claim', 'active', '2026-07-09 08:56:26', NULL),
(9, 31, 3, NULL, 'free_claim', 'active', '2026-06-26 08:56:26', NULL),
(10, 35, 3, NULL, 'free_claim', 'active', '2026-07-08 08:56:26', NULL),
(11, 48, 3, NULL, 'free_claim', 'active', '2026-07-08 08:56:26', NULL),
(12, 42, 3, NULL, 'free_claim', 'active', '2026-06-23 08:56:26', NULL),
(13, 36, 3, NULL, 'free_claim', 'active', '2026-06-27 08:56:26', NULL),
(14, 19, 4, NULL, 'free_claim', 'active', '2026-06-19 08:56:26', NULL),
(15, 40, 4, NULL, 'free_claim', 'active', '2026-07-15 08:56:26', NULL),
(16, 35, 4, NULL, 'free_claim', 'active', '2026-06-16 08:56:26', NULL),
(17, 32, 4, NULL, 'free_claim', 'active', '2026-06-23 08:56:26', NULL),
(18, 39, 4, NULL, 'free_claim', 'active', '2026-06-24 08:56:26', NULL),
(19, 37, 4, NULL, 'free_claim', 'active', '2026-07-21 08:56:26', NULL),
(20, 46, 4, NULL, 'free_claim', 'active', '2026-06-17 08:56:26', NULL),
(21, 43, 4, NULL, 'free_claim', 'active', '2026-07-18 08:56:26', NULL),
(22, 31, 4, NULL, 'free_claim', 'active', '2026-06-18 08:56:26', NULL),
(23, 27, 4, NULL, 'free_claim', 'active', '2026-07-13 08:56:26', NULL),
(24, 28, 5, NULL, 'free_claim', 'active', '2026-06-26 08:56:26', NULL),
(25, 49, 5, NULL, 'free_claim', 'active', '2026-06-27 08:56:26', NULL),
(26, 46, 5, NULL, 'free_claim', 'active', '2026-06-22 08:56:26', NULL),
(27, 36, 5, NULL, 'free_claim', 'active', '2026-07-08 08:56:26', NULL),
(28, 52, 5, NULL, 'free_claim', 'active', '2026-06-18 08:56:26', NULL),
(29, 34, 5, NULL, 'free_claim', 'active', '2026-07-05 08:56:26', NULL),
(30, 22, 5, NULL, 'free_claim', 'active', '2026-07-05 08:56:26', NULL),
(31, 21, 6, NULL, 'free_claim', 'active', '2026-06-16 08:56:26', NULL),
(32, 26, 6, NULL, 'free_claim', 'active', '2026-06-17 08:56:26', NULL),
(33, 51, 6, NULL, 'free_claim', 'active', '2026-07-12 08:56:26', NULL),
(34, 27, 6, NULL, 'free_claim', 'active', '2026-07-13 08:56:26', NULL),
(35, 41, 6, NULL, 'free_claim', 'active', '2026-07-07 08:56:26', NULL),
(36, 47, 6, NULL, 'free_claim', 'active', '2026-07-17 08:56:26', NULL),
(37, 19, 6, NULL, 'free_claim', 'active', '2026-06-26 08:56:26', NULL),
(38, 31, 6, NULL, 'free_claim', 'active', '2026-07-12 08:56:26', NULL),
(39, 33, 6, NULL, 'free_claim', 'active', '2026-07-26 08:56:26', NULL),
(40, 30, 7, NULL, 'free_claim', 'active', '2026-06-21 08:56:26', NULL),
(41, 45, 7, NULL, 'free_claim', 'active', '2026-06-20 08:56:26', NULL),
(42, 39, 7, NULL, 'free_claim', 'active', '2026-07-05 08:56:26', NULL),
(43, 34, 7, NULL, 'free_claim', 'active', '2026-07-21 08:56:26', NULL),
(44, 29, 7, NULL, 'free_claim', 'active', '2026-07-09 08:56:26', NULL),
(45, 51, 7, NULL, 'free_claim', 'active', '2026-07-02 08:56:26', NULL),
(46, 42, 7, NULL, 'free_claim', 'active', '2026-06-22 08:56:26', NULL),
(47, 23, 7, NULL, 'free_claim', 'active', '2026-06-23 08:56:26', NULL),
(48, 26, 7, NULL, 'free_claim', 'active', '2026-07-22 08:56:26', NULL),
(49, 17, 7, NULL, 'free_claim', 'active', '2026-06-20 08:56:26', NULL),
(50, 22, 8, NULL, 'free_claim', 'active', '2026-06-16 08:56:26', NULL),
(51, 47, 8, NULL, 'free_claim', 'active', '2026-06-25 08:56:26', NULL),
(52, 49, 8, NULL, 'free_claim', 'active', '2026-07-13 08:56:26', NULL),
(53, 41, 8, NULL, 'free_claim', 'active', '2026-07-18 08:56:26', NULL),
(54, 20, 8, NULL, 'free_claim', 'active', '2026-07-07 08:56:26', NULL),
(55, 24, 8, NULL, 'free_claim', 'active', '2026-07-11 08:56:26', NULL),
(56, 21, 8, NULL, 'free_claim', 'active', '2026-07-16 08:56:26', NULL),
(57, 33, 8, NULL, 'free_claim', 'active', '2026-06-27 08:56:26', NULL),
(58, 34, 8, NULL, 'free_claim', 'active', '2026-07-14 08:56:26', NULL),
(59, 18, 8, NULL, 'free_claim', 'active', '2026-07-20 08:56:26', NULL),
(60, 29, 8, NULL, 'free_claim', 'active', '2026-07-17 08:56:26', NULL),
(61, 24, 9, NULL, 'free_claim', 'active', '2026-07-11 08:56:26', NULL),
(62, 50, 9, NULL, 'free_claim', 'active', '2026-07-16 08:56:26', NULL),
(63, 38, 9, NULL, 'free_claim', 'active', '2026-07-07 08:56:26', NULL),
(64, 36, 9, NULL, 'free_claim', 'active', '2026-07-03 08:56:26', NULL),
(65, 19, 9, NULL, 'free_claim', 'active', '2026-07-02 08:56:26', NULL),
(66, 52, 9, NULL, 'free_claim', 'active', '2026-06-17 08:56:26', NULL),
(67, 36, 10, NULL, 'free_claim', 'active', '2026-07-02 08:56:26', NULL),
(68, 46, 10, NULL, 'free_claim', 'active', '2026-06-22 08:56:26', NULL),
(69, 49, 10, NULL, 'free_claim', 'active', '2026-07-24 08:56:26', NULL),
(70, 41, 10, NULL, 'free_claim', 'active', '2026-06-17 08:56:26', NULL),
(71, 24, 10, NULL, 'free_claim', 'active', '2026-07-01 08:56:26', NULL),
(72, 18, 10, NULL, 'free_claim', 'active', '2026-06-17 08:56:26', NULL),
(341, 5, 16, 4, 'purchase', 'active', '2026-11-04 01:23:23', NULL),
(342, 5, 50, NULL, 'free_claim', 'active', '2026-11-04 01:55:52', NULL),
(343, 49, 22, 5, 'purchase', 'active', '2026-08-22 02:12:00', NULL),
(344, 49, 45, 6, 'purchase', 'active', '2026-08-22 02:12:00', NULL),
(345, 34, 45, 7, 'purchase', 'active', '2026-08-22 03:52:00', NULL),
(346, 34, 21, 8, 'purchase', 'active', '2026-08-22 03:52:00', NULL),
(347, 45, 41, 9, 'purchase', 'active', '2026-08-26 05:16:00', NULL),
(348, 28, 42, 10, 'purchase', 'active', '2026-08-26 06:02:00', NULL),
(349, 28, 20, 11, 'purchase', 'active', '2026-08-26 06:02:00', NULL),
(350, 28, 25, 12, 'purchase', 'active', '2026-08-26 06:02:00', NULL),
(351, 47, 19, 13, 'purchase', 'active', '2026-08-28 02:40:00', NULL),
(352, 33, 43, 14, 'purchase', 'active', '2026-08-28 11:05:00', NULL),
(353, 20, 29, 15, 'purchase', 'active', '2026-08-30 02:31:00', NULL),
(354, 43, 44, 16, 'purchase', 'active', '2026-08-30 11:22:00', NULL),
(355, 43, 17, 17, 'purchase', 'active', '2026-08-30 11:22:00', NULL),
(356, 43, 25, 18, 'purchase', 'active', '2026-08-30 11:22:00', NULL),
(357, 35, 31, 19, 'purchase', 'active', '2026-09-02 04:32:00', NULL),
(358, 39, 43, 20, 'purchase', 'active', '2026-09-02 14:22:00', NULL),
(359, 31, 39, 21, 'purchase', 'active', '2026-09-04 15:56:00', NULL),
(360, 48, 40, 22, 'purchase', 'active', '2026-09-05 02:21:00', NULL),
(361, 22, 18, 23, 'purchase', 'active', '2026-09-05 02:52:00', NULL),
(362, 32, 16, 24, 'purchase', 'active', '2026-09-05 04:21:00', NULL),
(363, 24, 33, 25, 'purchase', 'active', '2026-09-05 13:24:00', NULL),
(364, 24, 15, 26, 'purchase', 'active', '2026-09-05 13:24:00', NULL),
(365, 24, 23, 27, 'purchase', 'active', '2026-09-05 13:24:00', NULL),
(366, 17, 44, 28, 'purchase', 'active', '2026-09-06 15:06:00', NULL),
(367, 44, 18, 29, 'purchase', 'active', '2026-09-12 14:39:00', NULL),
(368, 44, 39, 30, 'purchase', 'active', '2026-09-12 14:39:00', NULL),
(369, 27, 28, 31, 'purchase', 'active', '2026-09-13 01:49:00', NULL),
(370, 30, 37, 32, 'purchase', 'active', '2026-09-16 07:15:00', NULL),
(371, 26, 30, 33, 'purchase', 'active', '2026-09-16 08:11:00', NULL),
(372, 40, 36, 34, 'purchase', 'active', '2026-09-16 08:20:00', NULL),
(373, 42, 30, 35, 'purchase', 'active', '2026-09-16 12:05:00', NULL),
(374, 51, 31, 36, 'purchase', 'active', '2026-09-18 05:14:00', NULL),
(375, 51, 20, 37, 'purchase', 'active', '2026-09-18 05:14:00', NULL),
(376, 21, 22, 38, 'purchase', 'active', '2026-09-20 07:55:00', NULL),
(377, 46, 27, 39, 'purchase', 'active', '2026-09-20 14:45:00', NULL),
(378, 46, 46, 40, 'purchase', 'active', '2026-09-20 14:45:00', NULL),
(379, 48, 26, 41, 'purchase', 'active', '2026-10-08 02:04:00', NULL),
(380, 48, 15, 42, 'purchase', 'active', '2026-10-08 02:04:00', NULL),
(381, 26, 34, 43, 'purchase', 'active', '2026-10-08 05:54:00', NULL),
(382, 47, 29, 44, 'purchase', 'active', '2026-10-09 01:15:00', NULL),
(383, 27, 15, 45, 'purchase', 'active', '2026-10-09 07:31:00', NULL),
(384, 27, 26, 46, 'purchase', 'active', '2026-10-09 07:31:00', NULL),
(385, 25, 40, 47, 'purchase', 'active', '2026-10-10 12:47:00', NULL),
(386, 25, 20, 48, 'purchase', 'active', '2026-10-10 12:47:00', NULL),
(387, 23, 41, 49, 'purchase', 'active', '2026-10-11 02:05:00', NULL),
(388, 36, 18, 50, 'purchase', 'active', '2026-10-12 01:56:00', NULL),
(389, 36, 27, 51, 'purchase', 'active', '2026-10-12 01:56:00', NULL),
(390, 35, 23, 52, 'purchase', 'active', '2026-10-12 07:30:00', NULL),
(391, 35, 16, 53, 'purchase', 'active', '2026-10-12 07:30:00', NULL),
(392, 30, 34, 54, 'purchase', 'active', '2026-10-13 01:01:00', NULL),
(393, 30, 19, 55, 'purchase', 'active', '2026-10-13 01:01:00', NULL),
(394, 31, 17, 56, 'purchase', 'active', '2026-10-13 13:22:00', NULL),
(395, 22, 32, 57, 'purchase', 'active', '2026-10-13 15:45:00', NULL),
(396, 39, 35, 58, 'purchase', 'active', '2026-10-13 15:52:00', NULL),
(397, 39, 16, 59, 'purchase', 'active', '2026-10-13 15:52:00', NULL),
(398, 50, 33, 60, 'purchase', 'active', '2026-10-14 12:09:00', NULL),
(399, 50, 21, 61, 'purchase', 'active', '2026-10-14 12:09:00', NULL),
(400, 19, 35, 62, 'purchase', 'active', '2026-10-14 14:42:00', NULL),
(401, 19, 21, 63, 'purchase', 'active', '2026-10-14 14:42:00', NULL),
(402, 17, 37, 64, 'purchase', 'active', '2026-10-15 02:52:00', NULL),
(403, 17, 38, 65, 'purchase', 'active', '2026-10-15 02:52:00', NULL),
(404, 52, 24, 66, 'purchase', 'active', '2026-10-15 03:58:00', NULL),
(405, 52, 32, 67, 'purchase', 'active', '2026-10-15 03:58:00', NULL),
(406, 46, 23, 68, 'purchase', 'active', '2026-10-15 07:41:00', NULL),
(407, 29, 36, 69, 'purchase', 'active', '2026-10-15 10:38:00', NULL),
(408, 41, 38, 70, 'purchase', 'active', '2026-10-16 15:03:00', NULL),
(409, 20, 42, 71, 'purchase', 'active', '2026-10-17 15:29:00', NULL),
(410, 32, 31, 72, 'purchase', 'active', '2026-10-18 04:28:00', NULL),
(411, 33, 24, 73, 'purchase', 'active', '2026-10-18 11:35:00', NULL),
(412, 49, 28, 74, 'purchase', 'active', '2026-10-18 13:18:00', NULL),
(413, 21, 46, 75, 'purchase', 'active', '2026-10-18 14:14:00', NULL),
(414, 18, 18, 76, 'bundle', 'active', '2026-10-17 11:50:00', NULL),
(415, 18, 19, 76, 'bundle', 'active', '2026-10-17 11:50:00', NULL),
(416, 18, 20, 76, 'bundle', 'active', '2026-10-17 11:50:00', NULL),
(417, 18, 35, 76, 'bundle', 'active', '2026-10-17 11:50:00', NULL),
(418, 18, 27, 76, 'bundle', 'active', '2026-10-17 11:50:00', NULL),
(419, 26, 29, 77, 'bundle', 'active', '2026-10-16 03:15:00', NULL),
(420, 26, 42, 77, 'bundle', 'active', '2026-10-16 03:15:00', NULL),
(421, 30, 24, 78, 'bundle', 'active', '2026-10-15 04:50:00', NULL),
(422, 30, 43, 78, 'bundle', 'active', '2026-10-15 04:50:00', NULL),
(423, 24, 36, 79, 'bundle', 'active', '2026-10-14 13:44:00', NULL),
(424, 24, 40, 79, 'bundle', 'active', '2026-10-14 13:44:00', NULL),
(425, 24, 45, 79, 'bundle', 'active', '2026-10-14 13:44:00', NULL),
(426, 24, 46, 79, 'bundle', 'active', '2026-10-14 13:44:00', NULL),
(427, 27, 16, 80, 'bundle', 'active', '2026-10-13 11:47:00', NULL),
(428, 27, 17, 80, 'bundle', 'active', '2026-10-13 11:47:00', NULL),
(429, 27, 36, 80, 'bundle', 'active', '2026-10-13 11:47:00', NULL),
(430, 27, 32, 80, 'bundle', 'active', '2026-10-13 11:47:00', NULL),
(431, 27, 29, 80, 'bundle', 'active', '2026-10-13 11:47:00', NULL),
(432, 46, 24, 81, 'purchase', 'active', '2026-10-22 03:42:00', NULL),
(433, 36, 46, 82, 'purchase', 'active', '2026-10-22 06:25:00', NULL),
(434, 27, 43, 83, 'purchase', 'refunded', '2026-10-22 06:35:00', '2026-10-24 18:51:49'),
(435, 25, 21, 84, 'purchase', 'refunded', '2026-10-22 13:15:00', '2026-10-24 20:51:50'),
(436, 33, 30, 85, 'purchase', 'active', '2026-10-22 15:05:00', NULL),
(437, 45, 32, 86, 'purchase', 'active', '2026-10-23 03:58:00', NULL),
(438, 18, 36, 87, 'purchase', 'active', '2026-10-23 11:54:00', NULL),
(439, 48, 29, 88, 'purchase', 'refunded', '2026-10-23 12:15:00', '2026-10-25 23:24:54'),
(440, 32, 34, 89, 'purchase', 'refunded', '2026-10-23 15:50:00', '2026-10-25 23:40:09'),
(441, 19, 40, 90, 'purchase', 'active', '2026-10-24 02:51:00', NULL),
(442, 20, 19, 91, 'purchase', 'active', '2026-10-24 08:25:00', NULL),
(443, 44, 37, 92, 'purchase', 'active', '2026-10-24 12:45:00', NULL),
(444, 52, 15, 93, 'purchase', 'refunded', '2026-10-24 14:00:00', '2026-10-26 22:35:14'),
(445, 39, 44, 94, 'purchase', 'refunded', '2026-10-25 01:55:00', '2026-10-27 10:01:19'),
(446, 38, 24, 95, 'purchase', 'active', '2026-10-26 01:23:00', NULL),
(447, 35, 34, 96, 'purchase', 'active', '2026-10-26 02:44:00', NULL),
(448, 23, 20, 97, 'purchase', 'active', '2026-10-26 06:32:00', NULL),
(449, 26, 44, 98, 'purchase', 'refunded', '2026-10-26 10:38:00', '2026-10-28 20:02:26'),
(450, 40, 38, 99, 'purchase', 'refunded', '2026-10-27 01:20:00', '2026-10-29 11:07:34'),
(451, 21, 27, 100, 'purchase', 'active', '2026-10-27 05:40:00', NULL),
(452, 29, 15, 101, 'purchase', 'active', '2026-10-27 05:46:00', NULL),
(453, 49, 18, 102, 'purchase', 'active', '2026-10-27 07:11:00', NULL),
(454, 24, 43, 103, 'purchase', 'refunded', '2026-10-28 02:58:00', '2026-10-30 11:59:28'),
(455, 30, 27, 104, 'purchase', 'refunded', '2026-10-28 03:24:00', '2026-10-30 10:38:49'),
(456, 41, 15, 105, 'purchase', 'active', '2026-10-28 03:29:00', NULL),
(457, 22, 38, 106, 'purchase', 'active', '2026-10-28 05:47:00', NULL),
(458, 47, 34, 107, 'purchase', 'active', '2026-10-28 07:15:00', NULL),
(459, 42, 32, 108, 'purchase', 'refunded', '2026-10-29 02:07:00', '2026-10-31 09:44:29'),
(460, 51, 29, 109, 'purchase', 'refunded', '2026-10-29 11:46:00', '2026-10-31 20:03:39'),
(461, 34, 20, 110, 'purchase', 'active', '2026-10-29 13:22:00', NULL),
(462, 31, 37, 111, 'purchase', 'active', '2026-10-30 02:51:00', NULL),
(463, 17, 15, 112, 'purchase', 'active', '2026-10-30 12:04:00', NULL),
(464, 50, 22, 113, 'purchase', 'active', '2026-10-31 03:35:00', NULL),
(465, 28, 15, 114, 'purchase', 'active', '2026-10-31 12:31:00', NULL),
(466, 37, 46, 115, 'purchase', 'active', '2026-11-01 07:10:00', NULL),
(467, 43, 45, 116, 'purchase', 'active', '2026-11-01 10:51:00', NULL),
(502, 172, 78, NULL, 'purchase', 'active', '2026-11-01 11:00:00', NULL),
(503, 173, 78, NULL, 'free_claim', 'active', '2026-11-01 11:05:00', NULL),
(504, 171, 78, NULL, 'admin_grant', 'active', '2026-11-01 11:10:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `so_ke_toan_tac_gia`
--

CREATE TABLE `so_ke_toan_tac_gia` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `chi_tiet_don_hang_id` bigint(20) UNSIGNED NOT NULL,
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `phan_tram_huong_doanh_thu` decimal(5,2) NOT NULL,
  `doanh_thu_truoc_phi` decimal(12,2) NOT NULL,
  `phi_nen_tang` decimal(12,2) NOT NULL DEFAULT 0.00,
  `thue_da_khau_tru` decimal(12,2) NOT NULL DEFAULT 0.00,
  `so_tien_thuc_nhan` decimal(12,2) NOT NULL,
  `ma_tien_te` char(3) NOT NULL,
  `trang_thai` enum('pending','available','held','paid','reversed') NOT NULL DEFAULT 'pending',
  `ngay_co_the_chi_tra` datetime DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `so_ke_toan_tac_gia`
--

INSERT INTO `so_ke_toan_tac_gia` (`ma`, `chi_tiet_don_hang_id`, `nguoi_dung_id`, `phan_tram_huong_doanh_thu`, `doanh_thu_truoc_phi`, `phi_nen_tang`, `thue_da_khau_tru`, `so_tien_thuc_nhan`, `ma_tien_te`, `trang_thai`, `ngay_co_the_chi_tra`, `ngay_tao`) VALUES
(6, 4, 54, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'pending', '2026-11-18 08:23:23', '2026-11-04 01:23:23'),
(7, 5, 60, 100.00, 6.78, 0.68, 0.00, 6.10, 'USD', 'paid', '2026-09-05 09:12:00', '2026-08-22 02:12:00'),
(8, 6, 80, 100.00, 21.20, 2.12, 0.00, 19.08, 'USD', 'paid', '2026-09-05 09:12:00', '2026-08-22 02:12:00'),
(9, 7, 80, 100.00, 24.99, 2.50, 0.00, 22.49, 'USD', 'paid', '2026-09-05 10:52:00', '2026-08-22 03:52:00'),
(10, 8, 59, 100.00, 9.99, 1.00, 0.00, 8.99, 'USD', 'paid', '2026-09-05 10:52:00', '2026-08-22 03:52:00'),
(11, 9, 78, 100.00, 29.99, 3.00, 0.00, 26.99, 'USD', 'paid', '2026-09-09 12:16:00', '2026-08-26 05:16:00'),
(12, 10, 67, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'paid', '2026-09-09 13:02:00', '2026-08-26 06:02:00'),
(13, 11, 58, 100.00, 24.99, 2.50, 0.00, 22.49, 'USD', 'paid', '2026-09-09 13:02:00', '2026-08-26 06:02:00'),
(14, 12, 63, 100.00, 19.99, 2.00, 0.00, 17.99, 'USD', 'paid', '2026-09-09 13:02:00', '2026-08-26 06:02:00'),
(15, 13, 57, 100.00, 24.99, 2.50, 0.00, 22.49, 'USD', 'paid', '2026-09-11 09:40:00', '2026-08-28 02:40:00'),
(16, 14, 62, 100.00, 17.99, 1.80, 0.00, 16.19, 'USD', 'paid', '2026-09-11 18:05:00', '2026-08-28 11:05:00'),
(17, 15, 67, 100.00, 9.19, 0.92, 0.00, 8.27, 'USD', 'paid', '2026-09-13 09:31:00', '2026-08-30 02:31:00'),
(18, 16, 79, 100.00, 12.74, 1.27, 0.00, 11.47, 'USD', 'paid', '2026-09-13 18:22:00', '2026-08-30 11:22:00'),
(19, 17, 55, 100.00, 16.99, 1.70, 0.00, 15.29, 'USD', 'paid', '2026-09-13 18:22:00', '2026-08-30 11:22:00'),
(20, 18, 63, 100.00, 16.99, 1.70, 0.00, 15.29, 'USD', 'paid', '2026-09-13 18:22:00', '2026-08-30 11:22:00'),
(21, 19, 69, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'paid', '2026-09-16 11:32:00', '2026-09-02 04:32:00'),
(22, 20, 62, 100.00, 19.99, 2.00, 0.00, 17.99, 'USD', 'paid', '2026-09-16 21:22:00', '2026-09-02 14:22:00'),
(23, 21, 76, 100.00, 13.49, 1.35, 0.00, 12.14, 'USD', 'paid', '2026-09-18 22:56:00', '2026-09-04 15:56:00'),
(24, 22, 77, 100.00, 19.99, 2.00, 0.00, 17.99, 'USD', 'paid', '2026-09-19 09:21:00', '2026-09-05 02:21:00'),
(25, 23, 56, 100.00, 24.99, 2.50, 0.00, 22.49, 'USD', 'held', '2026-09-19 09:52:00', '2026-09-05 02:52:00'),
(26, 24, 54, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'paid', '2026-09-19 11:21:00', '2026-09-05 04:21:00'),
(27, 25, 71, 100.00, 19.99, 2.00, 0.00, 17.99, 'USD', 'paid', '2026-09-19 20:24:00', '2026-09-05 13:24:00'),
(28, 26, 53, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'paid', '2026-09-19 20:24:00', '2026-09-05 13:24:00'),
(29, 27, 61, 100.00, 4.99, 0.50, 0.00, 4.49, 'USD', 'paid', '2026-09-19 20:24:00', '2026-09-05 13:24:00'),
(30, 28, 79, 100.00, 13.49, 1.35, 0.00, 12.14, 'USD', 'paid', '2026-09-20 22:06:00', '2026-09-06 15:06:00'),
(31, 29, 56, 100.00, 24.99, 2.50, 0.00, 22.49, 'USD', 'held', '2026-09-26 21:39:00', '2026-09-12 14:39:00'),
(32, 30, 76, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'paid', '2026-09-26 21:39:00', '2026-09-12 14:39:00'),
(33, 31, 66, 100.00, 24.99, 2.50, 0.00, 22.49, 'USD', 'paid', '2026-09-27 08:49:00', '2026-09-13 01:49:00'),
(34, 32, 75, 100.00, 30.00, 3.00, 0.00, 27.00, 'USD', 'paid', '2026-09-30 14:15:00', '2026-09-16 07:15:00'),
(35, 33, 68, 100.00, 9.99, 1.00, 0.00, 8.99, 'USD', 'paid', '2026-09-30 15:11:00', '2026-09-16 08:11:00'),
(36, 34, 74, 100.00, 8.79, 0.88, 0.00, 7.91, 'USD', 'paid', '2026-09-30 15:20:00', '2026-09-16 08:20:00'),
(37, 35, 68, 100.00, 9.19, 0.92, 0.00, 8.27, 'USD', 'paid', '2026-09-30 19:05:00', '2026-09-16 12:05:00'),
(38, 36, 69, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'paid', '2026-10-02 12:14:00', '2026-09-18 05:14:00'),
(39, 37, 58, 100.00, 24.99, 2.50, 0.00, 22.49, 'USD', 'paid', '2026-10-02 12:14:00', '2026-09-18 05:14:00'),
(40, 38, 60, 100.00, 6.79, 0.68, 0.00, 6.11, 'USD', 'paid', '2026-10-04 14:55:00', '2026-09-20 07:55:00'),
(41, 39, 65, 100.00, 13.19, 1.32, 0.00, 11.87, 'USD', 'held', '2026-10-04 21:45:00', '2026-09-20 14:45:00'),
(42, 40, 81, 100.00, 26.39, 2.64, 0.00, 23.75, 'USD', 'paid', '2026-10-04 21:45:00', '2026-09-20 14:45:00'),
(43, 41, 64, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'held', '2026-10-22 09:04:00', '2026-10-08 02:04:00'),
(44, 42, 53, 100.00, 11.24, 1.12, 0.00, 10.12, 'USD', 'paid', '2026-10-22 09:04:00', '2026-10-08 02:04:00'),
(45, 43, 72, 100.00, 34.99, 3.50, 0.00, 31.49, 'USD', 'held', '2026-10-22 12:54:00', '2026-10-08 05:54:00'),
(46, 44, 67, 100.00, 9.99, 1.00, 0.00, 8.99, 'USD', 'paid', '2026-10-23 08:15:00', '2026-10-09 01:15:00'),
(47, 45, 53, 100.00, 11.24, 1.12, 0.00, 10.12, 'USD', 'paid', '2026-10-23 14:31:00', '2026-10-09 07:31:00'),
(48, 46, 64, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'held', '2026-10-23 14:31:00', '2026-10-09 07:31:00'),
(49, 47, 77, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'held', '2026-10-24 19:47:00', '2026-10-10 12:47:00'),
(50, 48, 58, 100.00, 18.74, 1.87, 0.00, 16.87, 'USD', 'held', '2026-10-24 19:47:00', '2026-10-10 12:47:00'),
(51, 49, 78, 100.00, 25.49, 2.55, 0.00, 22.94, 'USD', 'held', '2026-10-25 09:05:00', '2026-10-11 02:05:00'),
(52, 50, 56, 100.00, 24.99, 2.50, 0.00, 22.49, 'USD', 'held', '2026-10-26 08:56:00', '2026-10-12 01:56:00'),
(53, 51, 65, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'held', '2026-10-26 08:56:00', '2026-10-12 01:56:00'),
(54, 52, 61, 100.00, 4.59, 0.46, 0.00, 4.13, 'USD', 'held', '2026-10-26 14:30:00', '2026-10-12 07:30:00'),
(55, 53, 54, 100.00, 13.79, 1.38, 0.00, 12.41, 'USD', 'held', '2026-10-26 14:30:00', '2026-10-12 07:30:00'),
(56, 54, 72, 100.00, 34.99, 3.50, 0.00, 31.49, 'USD', 'held', '2026-10-27 08:01:00', '2026-10-13 01:01:00'),
(57, 55, 57, 100.00, 24.99, 2.50, 0.00, 22.49, 'USD', 'paid', '2026-10-27 08:01:00', '2026-10-13 01:01:00'),
(58, 56, 55, 100.00, 17.99, 1.80, 0.00, 16.19, 'USD', 'held', '2026-10-27 20:22:00', '2026-10-13 13:22:00'),
(59, 57, 70, 100.00, 24.99, 2.50, 0.00, 22.49, 'USD', 'held', '2026-10-27 22:45:00', '2026-10-13 15:45:00'),
(60, 58, 73, 100.00, 12.49, 1.25, 0.00, 11.24, 'USD', 'held', '2026-10-27 22:52:00', '2026-10-13 15:52:00'),
(61, 59, 54, 100.00, 12.49, 1.25, 0.00, 11.24, 'USD', 'held', '2026-10-27 22:52:00', '2026-10-13 15:52:00'),
(62, 60, 71, 100.00, 19.99, 2.00, 0.00, 17.99, 'USD', 'paid', '2026-10-28 19:09:00', '2026-10-14 12:09:00'),
(63, 61, 59, 100.00, 9.99, 1.00, 0.00, 8.99, 'USD', 'held', '2026-10-28 19:09:00', '2026-10-14 12:09:00'),
(64, 62, 73, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'held', '2026-10-28 21:42:00', '2026-10-14 14:42:00'),
(65, 63, 59, 100.00, 9.99, 1.00, 0.00, 8.99, 'USD', 'held', '2026-10-28 21:42:00', '2026-10-14 14:42:00'),
(66, 64, 75, 100.00, 24.50, 2.45, 0.00, 22.05, 'USD', 'paid', '2026-10-29 09:52:00', '2026-10-15 02:52:00'),
(67, 65, 68, 100.00, 17.49, 1.75, 0.00, 15.74, 'USD', 'held', '2026-10-29 09:52:00', '2026-10-15 02:52:00'),
(68, 66, 62, 100.00, 9.99, 1.00, 0.00, 8.99, 'USD', 'paid', '2026-10-29 10:58:00', '2026-10-15 03:58:00'),
(69, 67, 70, 100.00, 24.99, 2.50, 0.00, 22.49, 'USD', 'held', '2026-10-29 10:58:00', '2026-10-15 03:58:00'),
(70, 68, 61, 100.00, 4.99, 0.50, 0.00, 4.49, 'USD', 'held', '2026-10-29 14:41:00', '2026-10-15 07:41:00'),
(71, 69, 74, 100.00, 9.99, 1.00, 0.00, 8.99, 'USD', 'held', '2026-10-29 17:38:00', '2026-10-15 10:38:00'),
(72, 70, 68, 100.00, 24.99, 2.50, 0.00, 22.49, 'USD', 'held', '2026-10-30 22:03:00', '2026-10-16 15:03:00'),
(73, 71, 67, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'paid', '2026-10-31 22:29:00', '2026-10-17 15:29:00'),
(74, 72, 69, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'held', '2026-11-01 11:28:00', '2026-10-18 04:28:00'),
(75, 73, 62, 100.00, 9.99, 1.00, 0.00, 8.99, 'USD', 'paid', '2026-11-01 18:35:00', '2026-10-18 11:35:00'),
(76, 74, 66, 100.00, 17.49, 1.75, 0.00, 15.74, 'USD', 'held', '2026-11-01 20:18:00', '2026-10-18 13:18:00'),
(77, 75, 81, 100.00, 29.99, 3.00, 0.00, 26.99, 'USD', 'paid', '2026-11-01 21:14:00', '2026-10-18 14:14:00'),
(78, 76, 56, 100.00, 13.80, 1.38, 0.00, 12.42, 'USD', 'held', '2026-10-31 18:50:00', '2026-10-17 11:50:00'),
(79, 76, 57, 100.00, 13.80, 1.38, 0.00, 12.42, 'USD', 'paid', '2026-10-31 18:50:00', '2026-10-17 11:50:00'),
(80, 76, 58, 100.00, 13.80, 1.38, 0.00, 12.42, 'USD', 'held', '2026-10-31 18:50:00', '2026-10-17 11:50:00'),
(81, 76, 73, 100.00, 8.28, 0.83, 0.00, 7.45, 'USD', 'held', '2026-10-31 18:50:00', '2026-10-17 11:50:00'),
(82, 76, 65, 100.00, 8.27, 0.83, 0.00, 7.44, 'USD', 'held', '2026-10-31 18:50:00', '2026-10-17 11:50:00'),
(83, 77, 67, 100.00, 19.99, 2.00, 0.00, 17.99, 'USD', 'paid', '2026-10-30 10:15:00', '2026-10-16 03:15:00'),
(84, 78, 62, 100.00, 23.99, 2.40, 0.00, 21.59, 'USD', 'paid', '2026-10-29 11:50:00', '2026-10-15 04:50:00'),
(85, 79, 74, 100.00, 6.47, 0.65, 0.00, 5.82, 'USD', 'held', '2026-10-28 20:44:00', '2026-10-14 13:44:00'),
(86, 79, 77, 100.00, 12.94, 1.29, 0.00, 11.65, 'USD', 'held', '2026-10-28 20:44:00', '2026-10-14 13:44:00'),
(87, 79, 80, 100.00, 16.17, 1.62, 0.00, 14.55, 'USD', 'held', '2026-10-28 20:44:00', '2026-10-14 13:44:00'),
(88, 79, 81, 100.00, 19.41, 1.94, 0.00, 17.47, 'USD', 'paid', '2026-10-28 20:44:00', '2026-10-14 13:44:00'),
(89, 80, 54, 100.00, 9.00, 0.90, 0.00, 8.10, 'USD', 'held', '2026-10-27 18:47:00', '2026-10-13 11:47:00'),
(90, 80, 55, 100.00, 12.00, 1.20, 0.00, 10.80, 'USD', 'held', '2026-10-27 18:47:00', '2026-10-13 11:47:00'),
(91, 80, 74, 100.00, 6.00, 0.60, 0.00, 5.40, 'USD', 'held', '2026-10-27 18:47:00', '2026-10-13 11:47:00'),
(92, 80, 70, 100.00, 15.00, 1.50, 0.00, 13.50, 'USD', 'held', '2026-10-27 18:47:00', '2026-10-13 11:47:00'),
(93, 80, 67, 100.00, 5.99, 0.60, 0.00, 5.39, 'USD', 'paid', '2026-10-27 18:47:00', '2026-10-13 11:47:00'),
(94, 81, 62, 100.00, 9.99, 1.00, 0.00, 8.99, 'USD', 'pending', '2026-11-05 10:42:00', '2026-10-22 03:42:00'),
(95, 82, 81, 100.00, 29.99, 3.00, 0.00, 26.99, 'USD', 'pending', '2026-11-05 13:25:00', '2026-10-22 06:25:00'),
(96, 83, 62, 100.00, 19.99, 2.00, 0.00, 17.99, 'USD', 'reversed', '2026-11-05 13:35:00', '2026-10-22 06:35:00'),
(97, 84, 59, 100.00, 8.79, 0.88, 0.00, 7.91, 'USD', 'reversed', '2026-11-05 20:15:00', '2026-10-22 13:15:00'),
(98, 85, 68, 100.00, 9.99, 1.00, 0.00, 8.99, 'USD', 'pending', '2026-11-05 22:05:00', '2026-10-22 15:05:00'),
(99, 86, 70, 100.00, 21.24, 2.12, 0.00, 19.12, 'USD', 'pending', '2026-11-06 10:58:00', '2026-10-23 03:58:00'),
(100, 87, 74, 100.00, 9.99, 1.00, 0.00, 8.99, 'USD', 'pending', '2026-11-06 18:54:00', '2026-10-23 11:54:00'),
(101, 88, 67, 100.00, 9.99, 1.00, 0.00, 8.99, 'USD', 'reversed', '2026-11-06 19:15:00', '2026-10-23 12:15:00'),
(102, 89, 72, 100.00, 31.99, 3.20, 0.00, 28.79, 'USD', 'reversed', '2026-11-06 22:50:00', '2026-10-23 15:50:00'),
(103, 90, 77, 100.00, 16.99, 1.70, 0.00, 15.29, 'USD', 'pending', '2026-11-07 09:51:00', '2026-10-24 02:51:00'),
(104, 91, 57, 100.00, 24.99, 2.50, 0.00, 22.49, 'USD', 'pending', '2026-11-07 15:25:00', '2026-10-24 08:25:00'),
(105, 92, 75, 100.00, 35.00, 3.50, 0.00, 31.50, 'USD', 'pending', '2026-11-07 19:45:00', '2026-10-24 12:45:00'),
(106, 93, 53, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'reversed', '2026-11-07 21:00:00', '2026-10-24 14:00:00'),
(107, 94, 79, 100.00, 13.49, 1.35, 0.00, 12.14, 'USD', 'reversed', '2026-11-08 08:55:00', '2026-10-25 01:55:00'),
(108, 95, 62, 100.00, 7.99, 0.80, 0.00, 7.19, 'USD', 'pending', '2026-11-09 08:23:00', '2026-10-26 01:23:00'),
(109, 96, 72, 100.00, 34.99, 3.50, 0.00, 31.49, 'USD', 'pending', '2026-11-09 09:44:00', '2026-10-26 02:44:00'),
(110, 97, 58, 100.00, 24.99, 2.50, 0.00, 22.49, 'USD', 'pending', '2026-11-09 13:32:00', '2026-10-26 06:32:00'),
(111, 98, 79, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'reversed', '2026-11-09 17:38:00', '2026-10-26 10:38:00'),
(112, 99, 68, 100.00, 24.99, 2.50, 0.00, 22.49, 'USD', 'reversed', '2026-11-10 08:20:00', '2026-10-27 01:20:00'),
(113, 100, 65, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'pending', '2026-11-10 12:40:00', '2026-10-27 05:40:00'),
(114, 101, 53, 100.00, 13.79, 1.38, 0.00, 12.41, 'USD', 'pending', '2026-11-10 12:46:00', '2026-10-27 05:46:00'),
(115, 102, 56, 100.00, 24.99, 2.50, 0.00, 22.49, 'USD', 'pending', '2026-11-10 14:11:00', '2026-10-27 07:11:00'),
(116, 103, 62, 100.00, 16.99, 1.70, 0.00, 15.29, 'USD', 'reversed', '2026-11-11 09:58:00', '2026-10-28 02:58:00'),
(117, 104, 65, 100.00, 12.74, 1.27, 0.00, 11.47, 'USD', 'reversed', '2026-11-11 10:24:00', '2026-10-28 03:24:00'),
(118, 105, 53, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'pending', '2026-11-11 10:29:00', '2026-10-28 03:29:00'),
(119, 106, 68, 100.00, 24.99, 2.50, 0.00, 22.49, 'USD', 'pending', '2026-11-11 12:47:00', '2026-10-28 05:47:00'),
(120, 107, 72, 100.00, 34.99, 3.50, 0.00, 31.49, 'USD', 'pending', '2026-11-11 14:15:00', '2026-10-28 07:15:00'),
(121, 108, 70, 100.00, 22.99, 2.30, 0.00, 20.69, 'USD', 'reversed', '2026-11-12 09:07:00', '2026-10-29 02:07:00'),
(122, 109, 67, 100.00, 9.99, 1.00, 0.00, 8.99, 'USD', 'reversed', '2026-11-12 18:46:00', '2026-10-29 11:46:00'),
(123, 110, 58, 100.00, 24.99, 2.50, 0.00, 22.49, 'USD', 'pending', '2026-11-12 20:22:00', '2026-10-29 13:22:00'),
(124, 111, 75, 100.00, 35.00, 3.50, 0.00, 31.50, 'USD', 'pending', '2026-11-13 09:51:00', '2026-10-30 02:51:00'),
(125, 112, 53, 100.00, 14.99, 1.50, 0.00, 13.49, 'USD', 'pending', '2026-11-13 19:04:00', '2026-10-30 12:04:00'),
(126, 113, 60, 100.00, 7.99, 0.80, 0.00, 7.19, 'USD', 'pending', '2026-11-14 10:35:00', '2026-10-31 03:35:00'),
(127, 114, 53, 100.00, 13.79, 1.38, 0.00, 12.41, 'USD', 'pending', '2026-11-14 19:31:00', '2026-10-31 12:31:00'),
(128, 115, 81, 100.00, 29.99, 3.00, 0.00, 26.99, 'USD', 'pending', '2026-11-15 14:10:00', '2026-11-01 07:10:00'),
(129, 116, 80, 100.00, 22.99, 2.30, 0.00, 20.69, 'USD', 'pending', '2026-11-15 17:51:00', '2026-11-01 10:51:00');

-- --------------------------------------------------------

--
-- Table structure for table `tac_gia_tro_choi`
--

CREATE TABLE `tac_gia_tro_choi` (
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `phan_tram_huong_doanh_thu` decimal(5,2) NOT NULL,
  `thu_tu_hien_thi` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `ngay_them` timestamp NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `tac_gia_tro_choi`
--

INSERT INTO `tac_gia_tro_choi` (`tro_choi_id`, `nguoi_dung_id`, `phan_tram_huong_doanh_thu`, `thu_tu_hien_thi`, `ngay_them`) VALUES
(3, 9, 100.00, 0, '2026-11-03 08:23:05'),
(4, 10, 100.00, 0, '2026-11-03 08:23:05'),
(5, 11, 100.00, 0, '2026-11-03 08:23:05'),
(6, 12, 100.00, 0, '2026-11-03 08:23:05'),
(7, 13, 100.00, 0, '2026-11-03 08:23:05'),
(8, 14, 100.00, 0, '2026-11-03 08:23:05'),
(9, 15, 100.00, 0, '2026-11-03 08:23:05'),
(10, 16, 100.00, 0, '2026-11-03 08:23:05'),
(15, 53, 100.00, 0, '2026-11-04 01:17:30'),
(16, 54, 100.00, 0, '2026-11-04 01:17:30'),
(17, 55, 100.00, 0, '2026-11-04 01:17:30'),
(18, 56, 100.00, 0, '2026-11-04 01:17:30'),
(19, 57, 100.00, 0, '2026-11-04 01:17:30'),
(20, 58, 100.00, 0, '2026-11-04 01:17:30'),
(21, 59, 100.00, 0, '2026-11-04 01:17:30'),
(22, 60, 100.00, 0, '2026-11-04 01:17:30'),
(23, 61, 100.00, 0, '2026-11-04 01:17:30'),
(24, 62, 100.00, 0, '2026-11-04 01:17:30'),
(25, 63, 100.00, 0, '2026-11-04 01:50:07'),
(26, 64, 100.00, 0, '2026-11-04 01:50:07'),
(27, 65, 100.00, 0, '2026-11-04 01:50:07'),
(28, 66, 100.00, 0, '2026-11-04 01:50:07'),
(29, 67, 100.00, 0, '2026-11-04 01:50:07'),
(30, 68, 100.00, 0, '2026-11-04 01:50:07'),
(31, 69, 100.00, 0, '2026-11-04 01:50:07'),
(32, 70, 100.00, 0, '2026-11-04 01:50:07'),
(33, 71, 100.00, 0, '2026-11-04 01:50:07'),
(34, 72, 100.00, 0, '2026-11-04 01:50:07'),
(35, 73, 100.00, 0, '2026-11-04 01:50:07'),
(36, 74, 100.00, 0, '2026-11-04 01:50:07'),
(37, 75, 100.00, 0, '2026-11-04 01:50:07'),
(38, 68, 100.00, 0, '2026-11-04 01:50:07'),
(39, 76, 100.00, 0, '2026-11-04 01:50:07'),
(40, 77, 100.00, 0, '2026-11-04 01:50:07'),
(41, 78, 100.00, 0, '2026-11-04 01:50:07'),
(42, 67, 100.00, 0, '2026-11-04 01:50:07'),
(43, 62, 100.00, 0, '2026-11-04 01:50:07'),
(44, 79, 100.00, 0, '2026-11-04 01:50:07'),
(45, 80, 100.00, 0, '2026-11-04 01:50:07'),
(46, 81, 100.00, 0, '2026-11-04 01:50:07'),
(47, 82, 100.00, 0, '2026-11-04 01:50:07'),
(48, 83, 100.00, 0, '2026-11-04 01:50:07'),
(49, 84, 100.00, 0, '2026-11-04 01:50:07'),
(50, 85, 100.00, 0, '2026-11-04 01:50:07'),
(51, 86, 100.00, 0, '2026-11-04 01:50:07'),
(52, 87, 100.00, 0, '2026-11-04 01:50:07'),
(53, 88, 100.00, 0, '2026-11-04 01:50:07'),
(54, 89, 100.00, 0, '2026-11-04 01:50:07'),
(78, 171, 100.00, 0, '2026-11-01 08:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `tai_khoan_nhan_tien_nguoi_dung`
--

CREATE TABLE `tai_khoan_nhan_tien_nguoi_dung` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `nha_cung_cap` varchar(80) NOT NULL,
  `ma_tai_khoan_ben_ngoai` varchar(255) NOT NULL,
  `ten_tai_khoan` varchar(120) DEFAULT NULL,
  `ma_tien_te` char(3) NOT NULL,
  `mac_dinh` tinyint(1) NOT NULL DEFAULT 0,
  `trang_thai` enum('pending_verification','active','disabled') NOT NULL DEFAULT 'pending_verification',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tai_khoan_nhan_tien_nguoi_dung`
--

INSERT INTO `tai_khoan_nhan_tien_nguoi_dung` (`ma`, `nguoi_dung_id`, `nha_cung_cap`, `ma_tai_khoan_ben_ngoai`, `ten_tai_khoan`, `ma_tien_te`, `mac_dinh`, `trang_thai`, `ngay_tao`) VALUES
(1, 8, 'bank_transfer', '0000111122223333', '[KIỂM THỬ] Nhà phát triển thử', 'USD', 0, 'active', '2026-11-03 11:49:35'),
(2, 8, 'paypal', 'dev_test@example.test', '[KIỂM THỬ] Nhà phát triển thử', 'USD', 1, 'pending_verification', '2026-11-03 11:49:36'),
(3, 53, 'bank_transfer', 'MAU-053-0000-4903', '[MẪU] Tài khoản minh họa của ConcernedApe', 'USD', 1, 'active', '2026-08-03 02:27:42'),
(4, 54, 'bank_transfer', 'MAU-054-0000-7322', '[MẪU] Tài khoản minh họa của Team Cherry', 'USD', 1, 'active', '2026-08-07 02:27:42'),
(5, 55, 'bank_transfer', 'MAU-055-0000-3266', '[MẪU] Tài khoản minh họa của Maddy Makes Games', 'USD', 1, 'active', '2026-08-03 02:27:42'),
(6, 56, 'bank_transfer', 'MAU-056-0000-2226', '[MẪU] Tài khoản minh họa của Supergiant Games', 'USD', 1, 'active', '2026-08-01 02:27:42'),
(7, 57, 'bank_transfer', 'MAU-057-0000-7264', '[MẪU] Tài khoản minh họa của Motion Twin', 'USD', 1, 'active', '2026-08-08 02:27:42'),
(8, 58, 'bank_transfer', 'MAU-058-0000-1540', '[MẪU] Tài khoản minh họa của Mega Crit', 'USD', 1, 'active', '2026-08-08 02:27:42'),
(9, 59, 'bank_transfer', 'MAU-059-0000-5743', '[MẪU] Tài khoản minh họa của Re-Logic', 'USD', 1, 'active', '2026-08-08 02:27:42'),
(10, 60, 'bank_transfer', 'MAU-060-0000-8007', '[MẪU] Tài khoản minh họa của adamgryu', 'USD', 1, 'active', '2026-08-11 02:27:42'),
(11, 61, 'bank_transfer', 'MAU-061-0000-8252', '[MẪU] Tài khoản minh họa của poncle', 'USD', 1, 'active', '2026-08-03 02:27:42'),
(12, 62, 'bank_transfer', 'MAU-062-0000-8695', '[MẪU] Tài khoản minh họa của Lucas Pope', 'USD', 1, 'active', '2026-08-02 02:27:42'),
(13, 63, 'bank_transfer', 'MAU-063-0000-1562', '[MẪU] Tài khoản minh họa của Daniel Mullins Games', 'USD', 1, 'active', '2026-08-05 02:27:42'),
(14, 64, 'bank_transfer', 'MAU-064-0000-3516', '[MẪU] Tài khoản minh họa của Witch Beam', 'USD', 1, 'active', '2026-08-06 02:27:42'),
(15, 65, 'bank_transfer', 'MAU-065-0000-3853', '[MẪU] Tài khoản minh họa của Four Quarters', 'USD', 1, 'active', '2026-08-11 02:27:42'),
(16, 66, 'bank_transfer', 'MAU-066-0000-8481', '[MẪU] Tài khoản minh họa của Black Salt Games', 'USD', 1, 'active', '2026-08-06 02:27:42'),
(17, 67, 'bank_transfer', 'MAU-067-0000-1146', '[MẪU] Tài khoản minh họa của Subset Games', 'USD', 1, 'active', '2026-08-06 02:27:42'),
(18, 68, 'bank_transfer', 'MAU-068-0000-6233', '[MẪU] Tài khoản minh họa của Klei Entertainment', 'USD', 1, 'active', '2026-08-06 02:27:42'),
(19, 69, 'bank_transfer', 'MAU-069-0000-9077', '[MẪU] Tài khoản minh họa của LocalThunk', 'USD', 1, 'active', '2026-08-03 02:27:42'),
(20, 70, 'bank_transfer', 'MAU-070-0000-8526', '[MẪU] Tài khoản minh họa của Red Hook Studios', 'USD', 1, 'active', '2026-08-05 02:27:42'),
(21, 71, 'bank_transfer', 'MAU-071-0000-4744', '[MẪU] Tài khoản minh họa của Studio MDHR', 'USD', 1, 'active', '2026-08-02 02:27:42'),
(22, 72, 'bank_transfer', 'MAU-072-0000-3574', '[MẪU] Tài khoản minh họa của Ludeon Studios', 'USD', 1, 'active', '2026-08-08 02:27:42'),
(23, 73, 'bank_transfer', 'MAU-073-0000-2471', '[MẪU] Tài khoản minh họa của Dodge Roll', 'USD', 1, 'active', '2026-08-03 02:27:42'),
(24, 74, 'bank_transfer', 'MAU-074-0000-7536', '[MẪU] Tài khoản minh họa của tobyfox', 'USD', 1, 'active', '2026-08-07 02:27:42'),
(25, 75, 'bank_transfer', 'MAU-075-0000-9247', '[MẪU] Tài khoản minh họa của Wube Software', 'USD', 1, 'active', '2026-08-11 02:27:42'),
(26, 76, 'bank_transfer', 'MAU-076-0000-1987', '[MẪU] Tài khoản minh họa của Askiisoft', 'USD', 1, 'active', '2026-08-11 02:27:42'),
(27, 77, 'bank_transfer', 'MAU-077-0000-5738', '[MẪU] Tài khoản minh họa của Infinite Fall', 'USD', 1, 'active', '2026-08-10 02:27:42'),
(28, 78, 'bank_transfer', 'MAU-078-0000-9835', '[MẪU] Tài khoản minh họa của TUNIC Team', 'USD', 1, 'active', '2026-08-08 02:27:42'),
(29, 79, 'bank_transfer', 'MAU-079-0000-5441', '[MẪU] Tài khoản minh họa của Hempuli Oy', 'USD', 1, 'active', '2026-08-01 02:27:42'),
(30, 80, 'bank_transfer', 'MAU-080-0000-5757', '[MẪU] Tài khoản minh họa của Mobius Digital', 'USD', 1, 'active', '2026-08-10 02:27:42'),
(31, 81, 'bank_transfer', 'MAU-081-0000-8220', '[MẪU] Tài khoản minh họa của Thunder Lotus', 'USD', 1, 'active', '2026-08-02 02:27:42'),
(32, 9, 'paypal', 'MAU-PAYPAL-009', '[MẪU] Tài khoản PayPal minh họa, chờ xác minh', 'USD', 1, 'pending_verification', '2026-10-29 02:27:42'),
(33, 10, 'paypal', 'MAU-PAYPAL-010', '[MẪU] Tài khoản PayPal minh họa, chờ xác minh', 'USD', 1, 'pending_verification', '2026-11-02 02:27:42'),
(34, 11, 'paypal', 'MAU-PAYPAL-011', '[MẪU] Tài khoản PayPal minh họa, chờ xác minh', 'USD', 1, 'pending_verification', '2026-11-01 02:27:42');

-- --------------------------------------------------------

--
-- Table structure for table `thanh_toan`
--

CREATE TABLE `thanh_toan` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `don_hang_id` bigint(20) UNSIGNED NOT NULL,
  `nha_cung_cap` varchar(60) NOT NULL,
  `ma_giao_dich_nha_cung_cap` varchar(190) DEFAULT NULL,
  `so_tien` decimal(12,2) NOT NULL,
  `ma_tien_te` char(3) NOT NULL,
  `trang_thai` enum('initiated','pending','succeeded','failed','cancelled') NOT NULL DEFAULT 'initiated',
  `ma_phan_hoi_nha_cung_cap` varchar(100) DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_thanh_toan` datetime DEFAULT NULL
) ;

--
-- Dumping data for table `thanh_toan`
--

INSERT INTO `thanh_toan` (`ma`, `don_hang_id`, `nha_cung_cap`, `ma_giao_dich_nha_cung_cap`, `so_tien`, `ma_tien_te`, `trang_thai`, `ma_phan_hoi_nha_cung_cap`, `ngay_tao`, `ngay_thanh_toan`) VALUES
(4, 4, 'sandbox', 'SANDBOX-4D3D256E3AFB32D1', 14.99, 'USD', 'succeeded', 'sandbox_approved', '2026-11-04 01:23:23', '2026-11-04 08:23:23'),
(5, 5, 'sandbox', 'SANDBOX-62CA2977F0CA5D42', 27.98, 'USD', 'succeeded', 'sandbox_approved', '2026-08-22 02:12:00', '2026-08-22 09:12:00'),
(6, 6, 'sandbox', 'SANDBOX-514E8E4C9FEEA0E1', 34.98, 'USD', 'succeeded', 'sandbox_approved', '2026-08-22 03:52:00', '2026-08-22 10:52:00'),
(7, 7, 'sandbox', 'SANDBOX-3E0F4AA9B973EFE3', 29.99, 'USD', 'succeeded', 'sandbox_approved', '2026-08-26 05:16:00', '2026-08-26 12:16:00'),
(8, 8, 'sandbox', 'SANDBOX-A0373E17020C27F4', 59.97, 'USD', 'succeeded', 'sandbox_approved', '2026-08-26 06:02:00', '2026-08-26 13:02:00'),
(9, 9, 'sandbox', 'SANDBOX-D237B35C0FAEDB2E', 24.99, 'USD', 'succeeded', 'sandbox_approved', '2026-08-28 02:40:00', '2026-08-28 09:40:00'),
(10, 10, 'sandbox', 'SANDBOX-90DE5330BC11C019', 17.99, 'USD', 'succeeded', 'sandbox_approved', '2026-08-28 11:05:00', '2026-08-28 18:05:00'),
(11, 11, 'sandbox', 'SANDBOX-8B275D877AC41AAA', 9.19, 'USD', 'succeeded', 'sandbox_approved', '2026-08-30 02:31:00', '2026-08-30 09:31:00'),
(12, 12, 'sandbox', 'SANDBOX-FC6D55DAFA7DDE5B', 46.72, 'USD', 'succeeded', 'sandbox_approved', '2026-08-30 11:22:00', '2026-08-30 18:22:00'),
(13, 13, 'sandbox', 'SANDBOX-5D908FB56EEF351F', 14.99, 'USD', 'succeeded', 'sandbox_approved', '2026-09-02 04:32:00', '2026-09-02 11:32:00'),
(14, 14, 'sandbox', 'SANDBOX-06B20503AA17F700', 19.99, 'USD', 'succeeded', 'sandbox_approved', '2026-09-02 14:22:00', '2026-09-02 21:22:00'),
(15, 15, 'sandbox', 'SANDBOX-B806C2541830783C', 13.49, 'USD', 'succeeded', 'sandbox_approved', '2026-09-04 15:56:00', '2026-09-04 22:56:00'),
(16, 16, 'sandbox', 'SANDBOX-A7A31D8E82F20262', 19.99, 'USD', 'succeeded', 'sandbox_approved', '2026-09-05 02:21:00', '2026-09-05 09:21:00'),
(17, 17, 'sandbox', 'SANDBOX-7896E6ED384BC8CF', 24.99, 'USD', 'succeeded', 'sandbox_approved', '2026-09-05 02:52:00', '2026-09-05 09:52:00'),
(18, 18, 'sandbox', 'SANDBOX-25C6B6CFC580D2F5', 14.99, 'USD', 'succeeded', 'sandbox_approved', '2026-09-05 04:21:00', '2026-09-05 11:21:00'),
(19, 19, 'sandbox', 'SANDBOX-35266540F33BEAD6', 39.97, 'USD', 'succeeded', 'sandbox_approved', '2026-09-05 13:24:00', '2026-09-05 20:24:00'),
(20, 20, 'sandbox', 'SANDBOX-A132F34D477103CA', 13.49, 'USD', 'succeeded', 'sandbox_approved', '2026-09-06 15:06:00', '2026-09-06 22:06:00'),
(21, 21, 'sandbox', 'SANDBOX-5720821D5F1610EA', 39.98, 'USD', 'succeeded', 'sandbox_approved', '2026-09-12 14:39:00', '2026-09-12 21:39:00'),
(22, 22, 'sandbox', 'SANDBOX-14502FD74C260804', 24.99, 'USD', 'succeeded', 'sandbox_approved', '2026-09-13 01:49:00', '2026-09-13 08:49:00'),
(23, 23, 'sandbox', 'SANDBOX-D2EEEBD30E7BE3DF', 30.00, 'USD', 'succeeded', 'sandbox_approved', '2026-09-16 07:15:00', '2026-09-16 14:15:00'),
(24, 24, 'sandbox', 'SANDBOX-A5259B4D861C4B0B', 9.99, 'USD', 'succeeded', 'sandbox_approved', '2026-09-16 08:11:00', '2026-09-16 15:11:00'),
(25, 25, 'sandbox', 'SANDBOX-A25361572CB6F0CE', 8.79, 'USD', 'succeeded', 'sandbox_approved', '2026-09-16 08:20:00', '2026-09-16 15:20:00'),
(26, 26, 'sandbox', 'SANDBOX-299D4B3F928026F8', 9.19, 'USD', 'succeeded', 'sandbox_approved', '2026-09-16 12:05:00', '2026-09-16 19:05:00'),
(27, 27, 'sandbox', 'SANDBOX-CCCE467C48455C7C', 39.98, 'USD', 'succeeded', 'sandbox_approved', '2026-09-18 05:14:00', '2026-09-18 12:14:00'),
(28, 28, 'sandbox', 'SANDBOX-3A03A65EB34F50A1', 6.79, 'USD', 'succeeded', 'sandbox_approved', '2026-09-20 07:55:00', '2026-09-20 14:55:00'),
(29, 29, 'sandbox', 'SANDBOX-3C9475DDC8AE805E', 39.58, 'USD', 'succeeded', 'sandbox_approved', '2026-09-20 14:45:00', '2026-09-20 21:45:00'),
(30, 30, 'sandbox', 'SANDBOX-E05C5A2B9FCC2D33', 26.23, 'USD', 'succeeded', 'sandbox_approved', '2026-10-08 02:04:00', '2026-10-08 09:04:00'),
(31, 31, 'sandbox', 'SANDBOX-09DB74A6717B0978', 34.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-08 05:54:00', '2026-10-08 12:54:00'),
(32, 32, 'sandbox', 'SANDBOX-9EF297DC43475BE3', 9.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-09 01:15:00', '2026-10-09 08:15:00'),
(33, 33, 'sandbox', 'SANDBOX-A19D6BC0975C16CD', 26.23, 'USD', 'succeeded', 'sandbox_approved', '2026-10-09 07:31:00', '2026-10-09 14:31:00'),
(34, 34, 'sandbox', 'SANDBOX-7FD0FC4AA8A02666', 33.73, 'USD', 'succeeded', 'sandbox_approved', '2026-10-10 12:47:00', '2026-10-10 19:47:00'),
(35, 35, 'sandbox', 'SANDBOX-E74DAD9C11EA3D0F', 25.49, 'USD', 'succeeded', 'sandbox_approved', '2026-10-11 02:05:00', '2026-10-11 09:05:00'),
(36, 36, 'sandbox', 'SANDBOX-ED58A0F09D549F42', 39.98, 'USD', 'succeeded', 'sandbox_approved', '2026-10-12 01:56:00', '2026-10-12 08:56:00'),
(37, 37, 'sandbox', 'SANDBOX-C3C65E9B82C601AC', 18.38, 'USD', 'succeeded', 'sandbox_approved', '2026-10-12 07:30:00', '2026-10-12 14:30:00'),
(38, 38, 'sandbox', 'SANDBOX-06178C6ED16AEDCB', 59.98, 'USD', 'succeeded', 'sandbox_approved', '2026-10-13 01:01:00', '2026-10-13 08:01:00'),
(39, 39, 'sandbox', 'SANDBOX-5921AFB9CB9FB94E', 17.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-13 13:22:00', '2026-10-13 20:22:00'),
(40, 40, 'sandbox', 'SANDBOX-19F4C5CEFFA7A245', 24.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-13 15:45:00', '2026-10-13 22:45:00'),
(41, 41, 'sandbox', 'SANDBOX-2D7D20F30379C06B', 24.98, 'USD', 'succeeded', 'sandbox_approved', '2026-10-13 15:52:00', '2026-10-13 22:52:00'),
(42, 42, 'sandbox', 'SANDBOX-0E2E6377E3FD0E4D', 29.98, 'USD', 'succeeded', 'sandbox_approved', '2026-10-14 12:09:00', '2026-10-14 19:09:00'),
(43, 43, 'sandbox', 'SANDBOX-AE97F7F9CCAB8415', 24.98, 'USD', 'succeeded', 'sandbox_approved', '2026-10-14 14:42:00', '2026-10-14 21:42:00'),
(44, 44, 'sandbox', 'SANDBOX-BB60E73B4B478692', 41.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-15 02:52:00', '2026-10-15 09:52:00'),
(45, 45, 'sandbox', 'SANDBOX-7DD83D3EA034E1AC', 34.98, 'USD', 'succeeded', 'sandbox_approved', '2026-10-15 03:58:00', '2026-10-15 10:58:00'),
(46, 46, 'sandbox', 'SANDBOX-E092C35D004F23C3', 4.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-15 07:41:00', '2026-10-15 14:41:00'),
(47, 47, 'sandbox', 'SANDBOX-B89D0B6AD607C41E', 9.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-15 10:38:00', '2026-10-15 17:38:00'),
(48, 48, 'sandbox', 'SANDBOX-E9448E337BFE1E56', 24.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-16 15:03:00', '2026-10-16 22:03:00'),
(49, 49, 'sandbox', 'SANDBOX-C00C20C987869B19', 14.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-17 15:29:00', '2026-10-17 22:29:00'),
(50, 50, 'sandbox', 'SANDBOX-0AC4C74CA1EDE363', 14.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-18 04:28:00', '2026-10-18 11:28:00'),
(51, 51, 'sandbox', 'SANDBOX-11685F3EB43AF78B', 9.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-18 11:35:00', '2026-10-18 18:35:00'),
(52, 52, 'sandbox', 'SANDBOX-BEC829BA7F982CE5', 17.49, 'USD', 'succeeded', 'sandbox_approved', '2026-10-18 13:18:00', '2026-10-18 20:18:00'),
(53, 53, 'sandbox', 'SANDBOX-463D4AF3C69A7B54', 29.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-18 14:14:00', '2026-10-18 21:14:00'),
(54, 54, 'sandbox', 'SANDBOX-5263EC9F15A858E9', 57.95, 'USD', 'succeeded', 'sandbox_approved', '2026-10-17 11:50:00', '2026-10-17 18:50:00'),
(55, 55, 'sandbox', 'SANDBOX-B05E90B14964280B', 19.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-16 03:15:00', '2026-10-16 10:15:00'),
(56, 56, 'sandbox', 'SANDBOX-693C47EAC63A4C95', 23.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-15 04:50:00', '2026-10-15 11:50:00'),
(57, 57, 'sandbox', 'SANDBOX-6F06C5CE2931016E', 54.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-14 13:44:00', '2026-10-14 20:44:00'),
(58, 58, 'sandbox', 'SANDBOX-79D01E4462DF8E32', 47.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-13 11:47:00', '2026-10-13 18:47:00'),
(59, 59, 'sandbox', 'SANDBOX-1194DD566646C3B1', 9.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-22 03:42:00', '2026-10-22 10:42:00'),
(60, 60, 'sandbox', 'SANDBOX-C1FF8B5FD08BFA27', 29.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-22 06:25:00', '2026-10-22 13:25:00'),
(61, 61, 'sandbox', 'SANDBOX-BC54C31C99FC872B', 19.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-22 06:35:00', '2026-10-22 13:35:00'),
(62, 62, 'sandbox', 'SANDBOX-79057F36320E2FFF', 8.79, 'USD', 'succeeded', 'sandbox_approved', '2026-10-22 13:15:00', '2026-10-22 20:15:00'),
(63, 63, 'sandbox', 'SANDBOX-DCE97728330F5E54', 9.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-22 15:05:00', '2026-10-22 22:05:00'),
(64, 64, 'sandbox', 'SANDBOX-95C70B38F8275C0C', 21.24, 'USD', 'succeeded', 'sandbox_approved', '2026-10-23 03:58:00', '2026-10-23 10:58:00'),
(65, 65, 'sandbox', 'SANDBOX-BF0F98602A4EAC2A', 9.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-23 11:54:00', '2026-10-23 18:54:00'),
(66, 66, 'sandbox', 'SANDBOX-71486A492BB19578', 9.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-23 12:15:00', '2026-10-23 19:15:00'),
(67, 67, 'sandbox', 'SANDBOX-727F929980632B94', 31.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-23 15:50:00', '2026-10-23 22:50:00'),
(68, 68, 'sandbox', 'SANDBOX-DC0E90F0FEA7F76D', 16.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-24 02:51:00', '2026-10-24 09:51:00'),
(69, 69, 'sandbox', 'SANDBOX-7C896F7DC27D013F', 24.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-24 08:25:00', '2026-10-24 15:25:00'),
(70, 70, 'sandbox', 'SANDBOX-990CEF743EF7A8F1', 35.00, 'USD', 'succeeded', 'sandbox_approved', '2026-10-24 12:45:00', '2026-10-24 19:45:00'),
(71, 71, 'sandbox', 'SANDBOX-EFDFCE4FB0BC0F1F', 14.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-24 14:00:00', '2026-10-24 21:00:00'),
(72, 72, 'sandbox', 'SANDBOX-F566E48526C56ABA', 13.49, 'USD', 'succeeded', 'sandbox_approved', '2026-10-25 01:55:00', '2026-10-25 08:55:00'),
(73, 73, 'sandbox', 'SANDBOX-7AF00789D01EE64A', 7.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-26 01:23:00', '2026-10-26 08:23:00'),
(74, 74, 'sandbox', 'SANDBOX-60A362554E0A2153', 34.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-26 02:44:00', '2026-10-26 09:44:00'),
(75, 75, 'sandbox', 'SANDBOX-6753A71352DD07C8', 24.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-26 06:32:00', '2026-10-26 13:32:00'),
(76, 76, 'sandbox', 'SANDBOX-2056A8E9688B622E', 14.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-26 10:38:00', '2026-10-26 17:38:00'),
(77, 77, 'sandbox', 'SANDBOX-FE394C1CCEC6FBF8', 24.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-27 01:20:00', '2026-10-27 08:20:00'),
(78, 78, 'sandbox', 'SANDBOX-9D88757A1EADB64E', 14.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-27 05:40:00', '2026-10-27 12:40:00'),
(79, 79, 'sandbox', 'SANDBOX-C0FD005E3A57B91E', 13.79, 'USD', 'succeeded', 'sandbox_approved', '2026-10-27 05:46:00', '2026-10-27 12:46:00'),
(80, 80, 'sandbox', 'SANDBOX-A0E49D3C9CBD0EC9', 24.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-27 07:11:00', '2026-10-27 14:11:00'),
(81, 81, 'sandbox', 'SANDBOX-94547348802A1650', 16.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-28 02:58:00', '2026-10-28 09:58:00'),
(82, 82, 'sandbox', 'SANDBOX-CF922347B8A65FEF', 12.74, 'USD', 'succeeded', 'sandbox_approved', '2026-10-28 03:24:00', '2026-10-28 10:24:00'),
(83, 83, 'sandbox', 'SANDBOX-3C88C1CE9B6C9851', 14.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-28 03:29:00', '2026-10-28 10:29:00'),
(84, 84, 'sandbox', 'SANDBOX-848B8EA466A0D75A', 24.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-28 05:47:00', '2026-10-28 12:47:00'),
(85, 85, 'sandbox', 'SANDBOX-DA17C03A2C3CFE7A', 34.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-28 07:15:00', '2026-10-28 14:15:00'),
(86, 86, 'sandbox', 'SANDBOX-9CB23632C85B7879', 22.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-29 02:07:00', '2026-10-29 09:07:00'),
(87, 87, 'sandbox', 'SANDBOX-F470CCC816BF39A8', 9.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-29 11:46:00', '2026-10-29 18:46:00'),
(88, 88, 'sandbox', 'SANDBOX-56B854EDCD279773', 24.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-29 13:22:00', '2026-10-29 20:22:00'),
(89, 89, 'sandbox', 'SANDBOX-FFB3F1D74D4ECCEA', 35.00, 'USD', 'succeeded', 'sandbox_approved', '2026-10-30 02:51:00', '2026-10-30 09:51:00'),
(90, 90, 'sandbox', 'SANDBOX-4C14F16C8647F13D', 14.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-30 12:04:00', '2026-10-30 19:04:00'),
(91, 91, 'sandbox', 'SANDBOX-79CADD2F782D635E', 7.99, 'USD', 'succeeded', 'sandbox_approved', '2026-10-31 03:35:00', '2026-10-31 10:35:00'),
(92, 92, 'sandbox', 'SANDBOX-1FDF5695EC0659CD', 13.79, 'USD', 'succeeded', 'sandbox_approved', '2026-10-31 12:31:00', '2026-10-31 19:31:00'),
(93, 93, 'sandbox', 'SANDBOX-C77AA203260630A5', 29.99, 'USD', 'succeeded', 'sandbox_approved', '2026-11-01 07:10:00', '2026-11-01 14:10:00'),
(94, 94, 'sandbox', 'SANDBOX-E7F5289CA632C74C', 22.99, 'USD', 'succeeded', 'sandbox_approved', '2026-11-01 10:51:00', '2026-11-01 17:51:00');

-- --------------------------------------------------------

--
-- Table structure for table `thanh_vien_cuoc_thi`
--

CREATE TABLE `thanh_vien_cuoc_thi` (
  `cuoc_thi_id` bigint(20) UNSIGNED NOT NULL,
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `vai_tro_thanh_vien` enum('host','admin','judge','moderator') NOT NULL DEFAULT 'moderator',
  `ngay_tham_gia` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `thanh_vien_cuoc_thi`
--

INSERT INTO `thanh_vien_cuoc_thi` (`cuoc_thi_id`, `nguoi_dung_id`, `vai_tro_thanh_vien`, `ngay_tham_gia`) VALUES
(2, 6, 'host', '2024-12-20 02:00:00'),
(2, 7, 'judge', '2024-12-20 02:00:00'),
(3, 6, 'host', '2025-01-19 02:00:00'),
(3, 7, 'judge', '2025-01-19 02:00:00'),
(4, 6, 'host', '2025-02-18 02:00:00'),
(4, 7, 'judge', '2025-02-18 02:00:00'),
(5, 6, 'host', '2025-03-20 02:00:00'),
(5, 7, 'judge', '2025-03-20 02:00:00'),
(6, 6, 'host', '2025-04-19 02:00:00'),
(6, 7, 'judge', '2025-04-19 02:00:00'),
(7, 6, 'host', '2025-05-19 02:00:00'),
(7, 7, 'judge', '2025-05-19 02:00:00'),
(8, 6, 'host', '2025-06-18 02:00:00'),
(8, 7, 'judge', '2025-06-18 02:00:00'),
(9, 6, 'host', '2025-07-18 02:00:00'),
(9, 7, 'judge', '2025-07-18 02:00:00'),
(10, 6, 'host', '2025-08-17 02:00:00'),
(10, 7, 'judge', '2025-08-17 02:00:00'),
(11, 6, 'host', '2025-09-16 02:00:00'),
(11, 7, 'judge', '2025-09-16 02:00:00'),
(12, 6, 'host', '2025-10-16 02:00:00'),
(12, 7, 'judge', '2025-10-16 02:00:00'),
(13, 6, 'host', '2025-11-15 02:00:00'),
(13, 7, 'judge', '2025-11-15 02:00:00'),
(14, 6, 'host', '2025-12-15 02:00:00'),
(14, 7, 'judge', '2025-12-15 02:00:00'),
(15, 6, 'host', '2026-01-14 02:00:00'),
(15, 7, 'judge', '2026-01-14 02:00:00'),
(16, 6, 'host', '2026-02-13 02:00:00'),
(16, 7, 'judge', '2026-02-13 02:00:00'),
(17, 6, 'host', '2026-03-15 02:00:00'),
(17, 7, 'judge', '2026-03-15 02:00:00'),
(18, 6, 'host', '2026-04-14 02:00:00'),
(18, 7, 'judge', '2026-04-14 02:00:00'),
(19, 6, 'host', '2026-05-14 02:00:00'),
(19, 7, 'judge', '2026-05-14 02:00:00'),
(20, 6, 'host', '2026-06-13 02:00:00'),
(20, 7, 'judge', '2026-06-13 02:00:00'),
(21, 6, 'host', '2026-10-08 02:27:42'),
(22, 6, 'host', '2026-10-07 02:27:42'),
(23, 6, 'host', '2026-10-12 02:27:42'),
(24, 6, 'host', '2026-10-12 02:27:42'),
(25, 6, 'host', '2026-10-12 02:27:42'),
(26, 6, 'host', '2026-11-04 01:27:42'),
(27, 6, 'host', '2026-11-04 01:27:42'),
(28, 6, 'host', '2026-11-04 01:27:42'),
(29, 6, 'host', '2026-11-04 01:27:42'),
(30, 6, 'host', '2026-11-04 01:27:42'),
(31, 6, 'host', '2026-08-21 02:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `theo_doi_nguoi_dung`
--

CREATE TABLE `theo_doi_nguoi_dung` (
  `nguoi_theo_doi_id` bigint(20) UNSIGNED NOT NULL,
  `nguoi_duoc_theo_doi_id` bigint(20) UNSIGNED NOT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `theo_doi_nguoi_dung`
--

INSERT INTO `theo_doi_nguoi_dung` (`nguoi_theo_doi_id`, `nguoi_duoc_theo_doi_id`, `ngay_tao`) VALUES
(17, 12, '2026-07-31 08:56:26'),
(17, 16, '2026-07-10 08:56:26'),
(17, 21, '2026-07-16 08:56:26'),
(17, 26, '2026-08-12 08:56:26'),
(17, 33, '2026-07-15 08:56:26'),
(17, 40, '2026-09-12 08:56:26'),
(17, 50, '2026-08-17 08:56:26'),
(18, 14, '2026-08-15 08:56:26'),
(18, 21, '2026-07-09 08:56:26'),
(18, 26, '2026-09-19 08:56:26'),
(18, 28, '2026-09-18 08:56:26'),
(18, 40, '2026-09-14 08:56:26'),
(18, 47, '2026-07-17 08:56:26'),
(18, 51, '2026-08-22 08:56:26'),
(19, 11, '2026-09-09 08:56:26'),
(19, 20, '2026-09-26 08:56:26'),
(19, 25, '2026-07-27 08:56:26'),
(19, 34, '2026-10-02 08:56:26'),
(19, 46, '2026-10-02 08:56:26'),
(19, 48, '2026-10-17 08:56:26'),
(20, 9, '2026-10-05 08:56:26'),
(20, 17, '2026-09-25 08:56:26'),
(20, 18, '2026-07-07 08:56:26'),
(20, 19, '2026-10-08 08:56:26'),
(20, 29, '2026-09-06 08:56:26'),
(20, 30, '2026-11-02 07:56:26'),
(20, 33, '2026-08-20 08:56:26'),
(20, 39, '2026-08-05 08:56:26'),
(20, 51, '2026-07-11 08:56:26'),
(21, 15, '2026-11-01 07:56:26'),
(21, 16, '2026-10-30 07:56:26'),
(21, 17, '2026-07-12 08:56:26'),
(21, 19, '2026-10-16 08:56:26'),
(21, 23, '2026-09-25 08:56:26'),
(21, 31, '2026-08-08 08:56:26'),
(21, 32, '2026-10-16 08:56:26'),
(21, 36, '2026-09-27 08:56:26'),
(21, 47, '2026-09-18 08:56:26'),
(22, 10, '2026-07-15 08:56:26'),
(22, 16, '2026-08-06 08:56:26'),
(22, 18, '2026-10-20 08:56:26'),
(22, 25, '2026-07-25 08:56:26'),
(22, 30, '2026-10-15 08:56:26'),
(22, 31, '2026-09-06 08:56:26'),
(22, 35, '2026-09-17 08:56:26'),
(22, 37, '2026-09-13 08:56:26'),
(22, 46, '2026-09-23 08:56:26'),
(22, 51, '2026-07-08 08:56:26'),
(23, 9, '2026-07-23 08:56:26'),
(23, 17, '2026-08-23 08:56:26'),
(23, 18, '2026-10-12 08:56:26'),
(23, 27, '2026-09-15 08:56:26'),
(23, 33, '2026-09-14 08:56:26'),
(24, 20, '2026-10-05 08:56:26'),
(24, 28, '2026-07-10 08:56:26'),
(24, 34, '2026-07-26 08:56:26'),
(24, 37, '2026-10-19 08:56:26'),
(24, 40, '2026-07-15 08:56:26'),
(24, 42, '2026-10-11 08:56:26'),
(25, 10, '2026-07-15 08:56:26'),
(25, 11, '2026-07-26 08:56:26'),
(25, 21, '2026-08-02 08:56:26'),
(25, 22, '2026-09-30 08:56:26'),
(25, 24, '2026-10-18 08:56:26'),
(25, 29, '2026-09-04 08:56:26'),
(25, 31, '2026-10-31 07:56:26'),
(25, 33, '2026-09-05 08:56:26'),
(25, 48, '2026-07-18 08:56:26'),
(25, 49, '2026-10-11 08:56:26'),
(26, 17, '2026-08-13 08:56:26'),
(26, 23, '2026-10-26 07:56:26'),
(26, 40, '2026-09-18 08:56:26'),
(26, 48, '2026-07-18 08:56:26'),
(27, 17, '2026-07-16 08:56:26'),
(27, 19, '2026-09-15 08:56:26'),
(27, 26, '2026-07-10 08:56:26'),
(27, 45, '2026-08-12 08:56:26'),
(28, 16, '2026-08-08 08:56:26'),
(28, 17, '2026-10-13 08:56:26'),
(28, 20, '2026-09-03 08:56:26'),
(28, 22, '2026-10-03 08:56:26'),
(28, 25, '2026-09-15 08:56:26'),
(28, 26, '2026-07-24 08:56:26'),
(28, 38, '2026-10-19 08:56:26'),
(28, 41, '2026-10-07 08:56:26'),
(28, 44, '2026-09-03 08:56:26'),
(29, 24, '2026-07-28 08:56:26'),
(29, 25, '2026-08-17 08:56:26'),
(29, 35, '2026-08-11 08:56:26'),
(29, 38, '2026-08-28 08:56:26'),
(29, 47, '2026-07-20 08:56:26'),
(30, 16, '2026-08-20 08:56:26'),
(30, 19, '2026-09-21 08:56:26'),
(30, 24, '2026-10-02 08:56:26'),
(30, 29, '2026-08-14 08:56:26'),
(30, 34, '2026-08-11 08:56:26'),
(30, 37, '2026-07-14 08:56:26'),
(30, 49, '2026-08-19 08:56:26'),
(31, 9, '2026-10-19 08:56:26'),
(31, 23, '2026-08-27 08:56:26'),
(31, 27, '2026-07-06 08:56:26'),
(31, 28, '2026-07-18 08:56:26'),
(31, 29, '2026-10-17 08:56:26'),
(31, 41, '2026-09-21 08:56:26'),
(31, 43, '2026-10-11 08:56:26'),
(31, 44, '2026-11-01 07:56:26'),
(31, 47, '2026-07-20 08:56:26'),
(32, 12, '2026-08-18 08:56:26'),
(32, 13, '2026-08-12 08:56:26'),
(32, 22, '2026-07-13 08:56:26'),
(32, 40, '2026-08-03 08:56:26'),
(32, 44, '2026-09-15 08:56:26'),
(32, 47, '2026-08-04 08:56:26'),
(32, 48, '2026-10-01 08:56:26'),
(32, 51, '2026-10-25 07:56:26'),
(33, 21, '2026-07-20 08:56:26'),
(33, 24, '2026-07-22 08:56:26'),
(33, 26, '2026-08-01 08:56:26'),
(33, 27, '2026-11-01 07:56:26'),
(33, 38, '2026-09-24 08:56:26'),
(33, 44, '2026-08-20 08:56:26'),
(33, 51, '2026-08-09 08:56:26'),
(34, 13, '2026-10-26 07:56:26'),
(34, 20, '2026-07-13 08:56:26'),
(34, 21, '2026-09-06 08:56:26'),
(34, 33, '2026-09-01 08:56:26'),
(34, 38, '2026-10-30 07:56:26'),
(34, 40, '2026-09-04 08:56:26'),
(34, 42, '2026-09-10 08:56:26'),
(34, 46, '2026-10-27 07:56:26'),
(34, 52, '2026-07-20 08:56:26'),
(35, 17, '2026-09-13 08:56:26'),
(35, 21, '2026-08-20 08:56:26'),
(35, 24, '2026-08-17 08:56:26'),
(35, 26, '2026-10-01 08:56:26'),
(35, 31, '2026-07-26 08:56:26'),
(35, 34, '2026-07-07 08:56:26'),
(35, 42, '2026-09-16 08:56:26'),
(35, 48, '2026-09-20 08:56:26'),
(36, 14, '2026-08-21 08:56:26'),
(36, 15, '2026-09-23 08:56:26'),
(36, 20, '2026-09-05 08:56:26'),
(36, 41, '2026-10-14 08:56:26'),
(37, 12, '2026-10-09 08:56:26'),
(37, 16, '2026-09-10 08:56:26'),
(37, 19, '2026-09-24 08:56:26'),
(37, 26, '2026-10-25 07:56:26'),
(38, 31, '2026-08-24 08:56:26'),
(38, 39, '2026-10-27 07:56:26'),
(38, 44, '2026-08-21 08:56:26'),
(38, 47, '2026-09-18 08:56:26'),
(39, 16, '2026-09-03 08:56:26'),
(39, 28, '2026-07-09 08:56:26'),
(39, 35, '2026-10-01 08:56:26'),
(39, 46, '2026-08-29 08:56:26'),
(39, 48, '2026-10-24 08:56:26'),
(40, 9, '2026-07-08 08:56:26'),
(40, 18, '2026-08-22 08:56:26'),
(40, 20, '2026-09-09 08:56:26'),
(40, 26, '2026-08-01 08:56:26'),
(40, 32, '2026-10-31 07:56:26'),
(40, 33, '2026-10-28 07:56:26'),
(40, 45, '2026-07-19 08:56:26'),
(40, 46, '2026-09-10 08:56:26'),
(40, 49, '2026-09-27 08:56:26'),
(41, 12, '2026-08-25 08:56:26'),
(41, 15, '2026-09-15 08:56:26'),
(41, 22, '2026-08-19 08:56:26'),
(41, 23, '2026-07-31 08:56:26'),
(41, 28, '2026-10-26 07:56:26'),
(41, 30, '2026-10-27 07:56:26'),
(41, 36, '2026-07-09 08:56:26'),
(41, 49, '2026-08-10 08:56:26'),
(42, 22, '2026-10-30 07:56:26'),
(42, 25, '2026-08-05 08:56:26'),
(42, 29, '2026-10-02 08:56:26'),
(42, 49, '2026-08-07 08:56:26'),
(43, 13, '2026-08-20 08:56:26'),
(43, 27, '2026-09-06 08:56:26'),
(43, 32, '2026-09-26 08:56:26'),
(43, 39, '2026-08-22 08:56:26'),
(43, 40, '2026-08-30 08:56:26'),
(43, 41, '2026-07-11 08:56:26'),
(43, 42, '2026-07-24 08:56:26'),
(44, 14, '2026-09-12 08:56:26'),
(44, 15, '2026-08-29 08:56:26'),
(44, 28, '2026-08-03 08:56:26'),
(44, 38, '2026-07-25 08:56:26'),
(44, 43, '2026-08-17 08:56:26'),
(44, 51, '2026-08-11 08:56:26'),
(45, 19, '2026-07-19 08:56:26'),
(45, 28, '2026-07-16 08:56:26'),
(45, 44, '2026-09-20 08:56:26'),
(46, 10, '2026-08-07 08:56:26'),
(46, 15, '2026-09-04 08:56:26'),
(46, 47, '2026-08-21 08:56:26'),
(46, 51, '2026-07-30 08:56:26'),
(47, 11, '2026-10-03 08:56:26'),
(47, 15, '2026-10-23 08:56:26'),
(47, 21, '2026-09-18 08:56:26'),
(47, 24, '2026-09-30 08:56:26'),
(47, 25, '2026-09-29 08:56:26'),
(47, 33, '2026-10-27 07:56:26'),
(47, 36, '2026-08-11 08:56:26'),
(47, 42, '2026-10-08 08:56:26'),
(47, 48, '2026-09-02 08:56:26'),
(47, 50, '2026-08-17 08:56:26'),
(48, 17, '2026-10-16 08:56:26'),
(48, 37, '2026-07-10 08:56:26'),
(48, 50, '2026-07-11 08:56:26'),
(49, 19, '2026-07-31 08:56:26'),
(49, 22, '2026-09-29 08:56:26'),
(49, 24, '2026-09-14 08:56:26'),
(49, 38, '2026-10-23 08:56:26'),
(49, 45, '2026-09-26 08:56:26'),
(49, 51, '2026-10-25 07:56:26'),
(50, 15, '2026-07-16 08:56:26'),
(50, 16, '2026-10-09 08:56:26'),
(50, 19, '2026-10-06 08:56:26'),
(50, 26, '2026-08-21 08:56:26'),
(50, 30, '2026-08-27 08:56:26'),
(50, 31, '2026-08-30 08:56:26'),
(50, 33, '2026-07-29 08:56:26'),
(50, 38, '2026-10-25 07:56:26'),
(50, 41, '2026-07-20 08:56:26'),
(50, 44, '2026-09-25 08:56:26'),
(51, 17, '2026-08-11 08:56:26'),
(51, 26, '2026-09-21 08:56:26'),
(51, 29, '2026-10-07 08:56:26'),
(51, 31, '2026-09-16 08:56:26'),
(51, 37, '2026-09-04 08:56:26'),
(51, 41, '2026-09-12 08:56:26'),
(51, 52, '2026-10-30 07:56:26'),
(52, 13, '2026-08-18 08:56:26'),
(52, 16, '2026-10-15 08:56:26'),
(52, 19, '2026-07-07 08:56:26'),
(52, 27, '2026-10-20 08:56:26'),
(52, 33, '2026-08-29 08:56:26'),
(52, 36, '2026-09-03 08:56:26'),
(52, 44, '2026-10-25 07:56:26');

-- --------------------------------------------------------

--
-- Table structure for table `theo_doi_tro_choi`
--

CREATE TABLE `theo_doi_tro_choi` (
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `thong_bao_cap_nhat` tinyint(1) NOT NULL DEFAULT 1,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `theo_doi_tro_choi`
--

INSERT INTO `theo_doi_tro_choi` (`nguoi_dung_id`, `tro_choi_id`, `thong_bao_cap_nhat`, `ngay_tao`) VALUES
(5, 16, 1, '2026-11-04 01:25:22'),
(18, 18, 1, '2026-11-01 19:17:29'),
(18, 23, 1, '2026-11-01 19:17:29'),
(18, 43, 1, '2026-10-30 19:50:05'),
(18, 47, 1, '2026-10-31 19:50:05'),
(19, 9, 1, '2026-09-11 08:56:26'),
(19, 20, 1, '2026-11-02 19:17:29'),
(20, 15, 1, '2026-10-31 19:17:29'),
(20, 16, 1, '2026-11-01 19:17:29'),
(20, 22, 1, '2026-11-01 19:17:29'),
(20, 30, 1, '2026-11-02 19:50:05'),
(20, 46, 1, '2026-11-01 19:50:05'),
(20, 53, 1, '2026-11-02 19:50:05'),
(21, 6, 1, '2026-10-28 07:56:26'),
(21, 8, 1, '2026-10-21 08:56:26'),
(21, 18, 1, '2026-11-01 19:17:29'),
(21, 22, 1, '2026-11-01 19:17:29'),
(22, 8, 1, '2026-10-10 08:56:26'),
(23, 7, 1, '2026-09-06 08:56:26'),
(23, 18, 1, '2026-10-30 19:17:29'),
(23, 19, 1, '2026-11-02 19:17:29'),
(23, 54, 1, '2026-10-30 19:50:05'),
(24, 8, 1, '2026-08-09 08:56:26'),
(24, 9, 1, '2026-11-02 07:56:26'),
(24, 10, 1, '2026-08-30 08:56:26'),
(24, 16, 1, '2026-11-02 19:17:29'),
(24, 24, 1, '2026-11-01 19:17:29'),
(24, 51, 1, '2026-10-30 19:50:05'),
(26, 6, 1, '2026-09-19 08:56:26'),
(26, 19, 1, '2026-10-30 19:17:29'),
(26, 20, 1, '2026-10-31 19:17:29'),
(26, 41, 1, '2026-11-02 19:50:05'),
(26, 47, 1, '2026-10-30 19:50:05'),
(26, 48, 1, '2026-10-30 19:50:05'),
(27, 6, 1, '2026-08-12 08:56:26'),
(27, 21, 1, '2026-10-30 19:17:29'),
(28, 5, 1, '2026-10-11 08:56:26'),
(28, 20, 1, '2026-10-31 19:17:29'),
(28, 23, 1, '2026-10-31 19:17:29'),
(29, 7, 1, '2026-09-25 08:56:26'),
(29, 8, 1, '2026-08-22 08:56:26'),
(29, 34, 1, '2026-11-01 19:50:05'),
(30, 7, 1, '2026-08-15 08:56:26'),
(30, 21, 1, '2026-10-30 19:17:29'),
(30, 26, 1, '2026-11-01 19:50:05'),
(30, 44, 1, '2026-11-02 19:50:05'),
(31, 3, 1, '2026-10-05 08:56:26'),
(31, 6, 1, '2026-08-04 08:56:26'),
(31, 36, 1, '2026-11-02 19:50:05'),
(32, 4, 1, '2026-09-16 08:56:26'),
(32, 16, 1, '2026-11-01 19:17:29'),
(32, 25, 1, '2026-10-31 19:50:05'),
(33, 8, 1, '2026-10-03 08:56:26'),
(33, 21, 1, '2026-11-02 19:17:29'),
(34, 7, 1, '2026-09-19 08:56:26'),
(35, 3, 1, '2026-07-31 08:56:26'),
(35, 4, 1, '2026-09-19 08:56:26'),
(35, 21, 1, '2026-10-30 19:17:29'),
(35, 30, 1, '2026-10-31 19:50:05'),
(35, 34, 1, '2026-10-31 19:50:05'),
(36, 3, 1, '2026-10-27 07:56:26'),
(36, 10, 1, '2026-09-16 08:56:26'),
(36, 18, 1, '2026-11-02 19:17:29'),
(36, 52, 1, '2026-10-31 19:50:05'),
(37, 18, 1, '2026-11-02 19:17:29'),
(37, 28, 1, '2026-10-31 19:50:05'),
(37, 43, 1, '2026-10-31 19:50:05'),
(38, 9, 1, '2026-10-16 08:56:26'),
(38, 53, 1, '2026-10-30 19:50:05'),
(39, 7, 1, '2026-10-28 07:56:26'),
(39, 28, 1, '2026-11-01 19:50:05'),
(40, 22, 1, '2026-11-02 19:17:29'),
(41, 6, 1, '2026-10-09 08:56:26'),
(41, 10, 1, '2026-09-07 08:56:26'),
(41, 18, 1, '2026-10-30 19:17:29'),
(42, 7, 1, '2026-07-30 08:56:26'),
(42, 18, 1, '2026-10-31 19:17:29'),
(42, 24, 1, '2026-10-30 19:17:29'),
(42, 43, 1, '2026-11-01 19:50:05'),
(43, 3, 1, '2026-09-13 08:56:26'),
(43, 4, 1, '2026-09-10 08:56:26'),
(44, 15, 1, '2026-11-02 19:17:29'),
(44, 23, 1, '2026-10-30 19:17:29'),
(44, 40, 1, '2026-10-31 19:50:05'),
(45, 7, 1, '2026-11-01 07:56:26'),
(46, 5, 1, '2026-11-01 07:56:26'),
(46, 10, 1, '2026-08-29 08:56:26'),
(47, 6, 1, '2026-10-29 07:56:26'),
(48, 3, 1, '2026-10-26 07:56:26'),
(48, 20, 1, '2026-10-31 19:17:29'),
(49, 5, 1, '2026-09-08 08:56:26'),
(49, 8, 1, '2026-08-29 08:56:26'),
(49, 10, 1, '2026-07-30 08:56:26'),
(49, 26, 1, '2026-11-01 19:50:05'),
(50, 16, 1, '2026-11-01 19:17:29'),
(50, 23, 1, '2026-11-02 19:17:29'),
(50, 36, 1, '2026-11-02 19:50:05'),
(50, 47, 1, '2026-10-31 19:50:05'),
(51, 6, 1, '2026-07-26 08:56:26'),
(51, 7, 1, '2026-08-20 08:56:26'),
(51, 19, 1, '2026-10-30 19:17:29'),
(51, 46, 1, '2026-10-31 19:50:05'),
(51, 49, 1, '2026-11-01 19:50:05'),
(52, 5, 1, '2026-09-10 08:56:26'),
(52, 9, 1, '2026-08-18 08:56:26'),
(52, 27, 1, '2026-10-31 19:50:05'),
(52, 33, 1, '2026-11-01 19:50:05');

-- --------------------------------------------------------

--
-- Table structure for table `the_loai`
--

CREATE TABLE `the_loai` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `ten` varchar(100) NOT NULL,
  `duong_dan_rut_gon` varchar(120) NOT NULL,
  `mo_ta` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `the_loai`
--

INSERT INTO `the_loai` (`ma`, `ten`, `duong_dan_rut_gon`, `mo_ta`) VALUES
(1, 'Hành động', 'action', 'Game hành động'),
(2, 'Phiêu lưu', 'adventure', 'Game phiêu lưu'),
(3, 'Nhập vai', 'role-playing', 'Game nhập vai'),
(4, 'Kinh dị', 'horror', 'Game kinh dị'),
(5, 'Giải đố', 'puzzle', 'Game giải đố'),
(6, 'Chiến thuật', 'strategy', 'Game chiến thuật'),
(7, 'Mô phỏng', 'simulation', 'Game mô phỏng'),
(8, 'Đi cảnh', 'platformer', 'Game đi cảnh'),
(9, 'Tiểu thuyết tương tác', 'visual-novel', 'Tiểu thuyết tương tác'),
(10, 'Khác', 'other', 'Thể loại khác');

-- --------------------------------------------------------

--
-- Table structure for table `thong_bao`
--

CREATE TABLE `thong_bao` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `loai_thong_bao` varchar(60) NOT NULL,
  `tieu_de` varchar(200) NOT NULL,
  `noi_dung_thong_bao` text DEFAULT NULL,
  `url_dich` varchar(1000) DEFAULT NULL,
  `da_doc` tinyint(1) NOT NULL DEFAULT 0,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_doc` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `thong_bao`
--

INSERT INTO `thong_bao` (`ma`, `nguoi_dung_id`, `loai_thong_bao`, `tieu_de`, `noi_dung_thong_bao`, `url_dich`, `da_doc`, `ngay_tao`, `ngay_doc`) VALUES
(7, 8, 'ownership_grant', 'Bạn được cấp quyền sở hữu 0 A.D.', 'Trò chơi đã có trong thư viện của bạn.', '/library', 0, '2026-11-03 08:53:49', NULL),
(13, 6, 'report', 'Báo cáo mới: Người dùng', 'Lý do: Quấy rối, xúc phạm', '/admin/reports/3', 0, '2026-11-03 11:30:50', NULL),
(14, 7, 'report', 'Báo cáo mới: Người dùng', 'Lý do: Quấy rối, xúc phạm', '/admin/reports/3', 0, '2026-11-03 11:30:50', NULL),
(18, 5, 'report_result', 'Báo cáo của bạn đã được xử lý', 'Cảm ơn bạn. Điều hành viên đã xử lý nội dung bạn báo cáo.', '/notifications', 0, '2026-11-03 11:31:51', NULL),
(19, 7, 'report_result', 'Báo cáo của bạn đã được xử lý', 'Cảm ơn bạn. Điều hành viên đã xử lý nội dung bạn báo cáo.', '/notifications', 0, '2026-11-03 11:31:51', NULL),
(20, 5, 'report_result', 'Báo cáo của bạn đã được xử lý', 'Cảm ơn bạn. Điều hành viên đã xử lý nội dung bạn báo cáo.', '/notifications', 0, '2026-11-03 11:32:10', NULL),
(22, 5, 'report_result', 'Báo cáo của bạn đã được xem xét', 'Điều hành viên không thấy nội dung vi phạm quy định nên không xử lý thêm.', '/notifications', 0, '2026-11-03 11:32:21', NULL),
(24, 6, 'payout', 'Tài khoản nhận tiền mới cần xác minh', 'Nhà phát triển (tài khoản thử) đã thêm Chuyển khoản ngân hàng.', '/admin/payouts#accounts', 0, '2026-11-03 11:49:35', NULL),
(25, 6, 'payout', 'Tài khoản nhận tiền mới cần xác minh', 'Nhà phát triển (tài khoản thử) đã thêm PayPal.', '/admin/payouts#accounts', 0, '2026-11-03 11:49:36', NULL),
(26, 8, 'payout', 'Tài khoản nhận tiền đã được xác minh', 'bank_transfer · [KIỂM THỬ] Nhà phát triển thử', '/dev/payouts', 0, '2026-11-03 11:49:54', NULL),
(41, 5, 'order_paid', 'Đơn hàng TEST-A54C2F1F9195 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-A54C2F1F9195', 0, '2026-11-04 01:23:23', NULL),
(42, 54, 'sale', 'Bạn có lượt bán mới', 'Hollow Knight', '/dev/sales', 0, '2026-11-04 01:23:23', NULL),
(43, 49, 'order_paid', 'Đơn hàng TEST-403198F4013F đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-403198F4013F', 0, '2026-08-22 02:12:00', NULL),
(44, 60, 'sale', 'Bạn có lượt bán mới', 'A Short Hike', '/dev/sales', 0, '2026-08-22 02:12:00', NULL),
(45, 80, 'sale', 'Bạn có lượt bán mới', 'Outer Wilds', '/dev/sales', 0, '2026-08-22 02:12:00', NULL),
(46, 34, 'order_paid', 'Đơn hàng TEST-15232AE15FF0 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-15232AE15FF0', 0, '2026-08-22 03:52:00', NULL),
(47, 80, 'sale', 'Bạn có lượt bán mới', 'Outer Wilds', '/dev/sales', 0, '2026-08-22 03:52:00', NULL),
(48, 59, 'sale', 'Bạn có lượt bán mới', 'Terraria', '/dev/sales', 0, '2026-08-22 03:52:00', NULL),
(49, 45, 'order_paid', 'Đơn hàng TEST-701CB4EE8A82 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-701CB4EE8A82', 0, '2026-08-26 05:16:00', NULL),
(50, 78, 'sale', 'Bạn có lượt bán mới', 'TUNIC', '/dev/sales', 0, '2026-08-26 05:16:00', NULL),
(51, 28, 'order_paid', 'Đơn hàng TEST-B26A39353045 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-B26A39353045', 0, '2026-08-26 06:02:00', NULL),
(52, 67, 'sale', 'Bạn có lượt bán mới', 'Into the Breach', '/dev/sales', 0, '2026-08-26 06:02:00', NULL),
(53, 58, 'sale', 'Bạn có lượt bán mới', 'Slay the Spire', '/dev/sales', 0, '2026-08-26 06:02:00', NULL),
(54, 63, 'sale', 'Bạn có lượt bán mới', 'Inscryption', '/dev/sales', 0, '2026-08-26 06:02:00', NULL),
(55, 47, 'order_paid', 'Đơn hàng TEST-DC19DA6D4D9D đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-DC19DA6D4D9D', 0, '2026-08-28 02:40:00', NULL),
(56, 57, 'sale', 'Bạn có lượt bán mới', 'Dead Cells', '/dev/sales', 0, '2026-08-28 02:40:00', NULL),
(57, 33, 'order_paid', 'Đơn hàng TEST-8074F934A4F0 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-8074F934A4F0', 0, '2026-08-28 11:05:00', NULL),
(58, 62, 'sale', 'Bạn có lượt bán mới', 'Return of the Obra Dinn', '/dev/sales', 0, '2026-08-28 11:05:00', NULL),
(59, 20, 'order_paid', 'Đơn hàng TEST-4F546AB2C9A9 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-4F546AB2C9A9', 0, '2026-08-30 02:31:00', NULL),
(60, 67, 'sale', 'Bạn có lượt bán mới', 'FTL: Faster Than Light', '/dev/sales', 0, '2026-08-30 02:31:00', NULL),
(61, 43, 'order_paid', 'Đơn hàng TEST-20B38E0A0473 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-20B38E0A0473', 0, '2026-08-30 11:22:00', NULL),
(62, 79, 'sale', 'Bạn có lượt bán mới', 'Baba Is You', '/dev/sales', 0, '2026-08-30 11:22:00', NULL),
(63, 55, 'sale', 'Bạn có lượt bán mới', 'Celeste', '/dev/sales', 0, '2026-08-30 11:22:00', NULL),
(64, 63, 'sale', 'Bạn có lượt bán mới', 'Inscryption', '/dev/sales', 0, '2026-08-30 11:22:00', NULL),
(65, 35, 'order_paid', 'Đơn hàng TEST-9C7570C765E3 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-9C7570C765E3', 0, '2026-09-02 04:32:00', NULL),
(66, 69, 'sale', 'Bạn có lượt bán mới', 'Balatro', '/dev/sales', 0, '2026-09-02 04:32:00', NULL),
(67, 39, 'order_paid', 'Đơn hàng TEST-C3C0D494A91A đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-C3C0D494A91A', 0, '2026-09-02 14:22:00', NULL),
(68, 62, 'sale', 'Bạn có lượt bán mới', 'Return of the Obra Dinn', '/dev/sales', 0, '2026-09-02 14:22:00', NULL),
(69, 31, 'order_paid', 'Đơn hàng TEST-163F6BAAC51A đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-163F6BAAC51A', 0, '2026-09-04 15:56:00', NULL),
(70, 76, 'sale', 'Bạn có lượt bán mới', 'Katana ZERO', '/dev/sales', 0, '2026-09-04 15:56:00', NULL),
(71, 48, 'order_paid', 'Đơn hàng TEST-CCF9C331AE14 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-CCF9C331AE14', 0, '2026-09-05 02:21:00', NULL),
(72, 77, 'sale', 'Bạn có lượt bán mới', 'Night in the Woods', '/dev/sales', 0, '2026-09-05 02:21:00', NULL),
(73, 22, 'order_paid', 'Đơn hàng TEST-EA2CBF5845DE đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-EA2CBF5845DE', 0, '2026-09-05 02:52:00', NULL),
(74, 56, 'sale', 'Bạn có lượt bán mới', 'Hades', '/dev/sales', 0, '2026-09-05 02:52:00', NULL),
(75, 32, 'order_paid', 'Đơn hàng TEST-E08DE79BC6F7 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-E08DE79BC6F7', 0, '2026-09-05 04:21:00', NULL),
(76, 54, 'sale', 'Bạn có lượt bán mới', 'Hollow Knight', '/dev/sales', 0, '2026-09-05 04:21:00', NULL),
(77, 24, 'order_paid', 'Đơn hàng TEST-3FA49BFF81FA đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-3FA49BFF81FA', 0, '2026-09-05 13:24:00', NULL),
(78, 71, 'sale', 'Bạn có lượt bán mới', 'Cuphead', '/dev/sales', 0, '2026-09-05 13:24:00', NULL),
(79, 53, 'sale', 'Bạn có lượt bán mới', 'Stardew Valley', '/dev/sales', 0, '2026-09-05 13:24:00', NULL),
(80, 61, 'sale', 'Bạn có lượt bán mới', 'Vampire Survivors', '/dev/sales', 0, '2026-09-05 13:24:00', NULL),
(81, 17, 'order_paid', 'Đơn hàng TEST-3CA49F1B03EE đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-3CA49F1B03EE', 0, '2026-09-06 15:06:00', NULL),
(82, 79, 'sale', 'Bạn có lượt bán mới', 'Baba Is You', '/dev/sales', 0, '2026-09-06 15:06:00', NULL),
(83, 44, 'order_paid', 'Đơn hàng TEST-79C3CF0F7559 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-79C3CF0F7559', 0, '2026-09-12 14:39:00', NULL),
(84, 56, 'sale', 'Bạn có lượt bán mới', 'Hades', '/dev/sales', 0, '2026-09-12 14:39:00', NULL),
(85, 76, 'sale', 'Bạn có lượt bán mới', 'Katana ZERO', '/dev/sales', 0, '2026-09-12 14:39:00', NULL),
(86, 27, 'order_paid', 'Đơn hàng TEST-BC6A8E4F486A đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-BC6A8E4F486A', 0, '2026-09-13 01:49:00', NULL),
(87, 66, 'sale', 'Bạn có lượt bán mới', 'DREDGE', '/dev/sales', 0, '2026-09-13 01:49:00', NULL),
(88, 30, 'order_paid', 'Đơn hàng TEST-442DDF7BFA30 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-442DDF7BFA30', 0, '2026-09-16 07:15:00', NULL),
(89, 75, 'sale', 'Bạn có lượt bán mới', 'Factorio', '/dev/sales', 0, '2026-09-16 07:15:00', NULL),
(90, 26, 'order_paid', 'Đơn hàng TEST-AE13B6F2C406 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-AE13B6F2C406', 0, '2026-09-16 08:11:00', NULL),
(91, 68, 'sale', 'Bạn có lượt bán mới', 'Don\'t Starve', '/dev/sales', 0, '2026-09-16 08:11:00', NULL),
(92, 40, 'order_paid', 'Đơn hàng TEST-588B35767C4E đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-588B35767C4E', 0, '2026-09-16 08:20:00', NULL),
(93, 74, 'sale', 'Bạn có lượt bán mới', 'UNDERTALE', '/dev/sales', 0, '2026-09-16 08:20:00', NULL),
(94, 42, 'order_paid', 'Đơn hàng TEST-7D60B4A05564 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-7D60B4A05564', 0, '2026-09-16 12:05:00', NULL),
(95, 68, 'sale', 'Bạn có lượt bán mới', 'Don\'t Starve', '/dev/sales', 0, '2026-09-16 12:05:00', NULL),
(96, 51, 'order_paid', 'Đơn hàng TEST-2869D75CA107 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-2869D75CA107', 0, '2026-09-18 05:14:00', NULL),
(97, 69, 'sale', 'Bạn có lượt bán mới', 'Balatro', '/dev/sales', 0, '2026-09-18 05:14:00', NULL),
(98, 58, 'sale', 'Bạn có lượt bán mới', 'Slay the Spire', '/dev/sales', 0, '2026-09-18 05:14:00', NULL),
(99, 21, 'order_paid', 'Đơn hàng TEST-6DAB542321DA đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-6DAB542321DA', 0, '2026-09-20 07:55:00', NULL),
(100, 60, 'sale', 'Bạn có lượt bán mới', 'A Short Hike', '/dev/sales', 0, '2026-09-20 07:55:00', NULL),
(101, 46, 'order_paid', 'Đơn hàng TEST-69E6A5569D14 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-69E6A5569D14', 0, '2026-09-20 14:45:00', NULL),
(102, 65, 'sale', 'Bạn có lượt bán mới', 'Loop Hero', '/dev/sales', 0, '2026-09-20 14:45:00', NULL),
(103, 81, 'sale', 'Bạn có lượt bán mới', 'Spiritfarer: Farewell Edition', '/dev/sales', 0, '2026-09-20 14:45:00', NULL),
(104, 53, 'payout', 'Đợt chi trả $13.49: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 06:09:34', NULL),
(105, 54, 'payout', 'Đợt chi trả $13.49: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 02:28:15', NULL),
(106, 55, 'payout', 'Đợt chi trả $15.29: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 09:50:01', NULL),
(107, 56, 'payout', 'Đợt chi trả $44.98: Thất bại', 'Ngân hàng từ chối: tên chủ tài khoản không khớp (tài khoản minh họa).', '/dev/payouts', 0, '2026-10-07 09:48:13', NULL),
(108, 57, 'payout', 'Đợt chi trả $22.49: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 04:31:39', NULL),
(109, 58, 'payout', 'Đợt chi trả $44.98: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 10:14:09', NULL),
(110, 59, 'payout', 'Đợt chi trả $8.99: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 09:28:14', NULL),
(111, 60, 'payout', 'Đợt chi trả $12.21: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 05:56:01', NULL),
(112, 61, 'payout', 'Đợt chi trả $4.49: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 10:29:02', NULL),
(113, 62, 'payout', 'Đợt chi trả $34.18: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 06:43:24', NULL),
(114, 63, 'payout', 'Đợt chi trả $33.28: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 10:39:01', NULL),
(115, 65, 'payout', 'Đợt chi trả $11.87: Thất bại', 'Ngân hàng từ chối: tên chủ tài khoản không khớp (tài khoản minh họa).', '/dev/payouts', 0, '2026-10-07 05:09:33', NULL),
(116, 66, 'payout', 'Đợt chi trả $22.49: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 07:08:14', NULL),
(117, 67, 'payout', 'Đợt chi trả $21.76: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 10:47:42', NULL),
(118, 68, 'payout', 'Đợt chi trả $17.26: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 05:16:58', NULL),
(119, 69, 'payout', 'Đợt chi trả $26.98: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 08:26:32', NULL),
(120, 71, 'payout', 'Đợt chi trả $17.99: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 09:01:17', NULL),
(121, 74, 'payout', 'Đợt chi trả $7.91: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 02:44:44', NULL),
(122, 75, 'payout', 'Đợt chi trả $27.00: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 03:32:19', NULL),
(123, 76, 'payout', 'Đợt chi trả $25.63: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 02:43:05', NULL),
(124, 77, 'payout', 'Đợt chi trả $17.99: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 10:44:21', NULL),
(125, 78, 'payout', 'Đợt chi trả $26.99: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 06:25:59', NULL),
(126, 79, 'payout', 'Đợt chi trả $23.61: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 10:01:27', NULL),
(127, 80, 'payout', 'Đợt chi trả $41.57: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 10:43:44', NULL),
(128, 81, 'payout', 'Đợt chi trả $23.75: Đã chi trả', '', '/dev/payouts', 0, '2026-10-07 10:47:24', NULL),
(129, 48, 'order_paid', 'Đơn hàng TEST-FAAFFFEEB2BB đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-FAAFFFEEB2BB', 0, '2026-10-08 02:04:00', NULL),
(130, 64, 'sale', 'Bạn có lượt bán mới', 'Unpacking', '/dev/sales', 0, '2026-10-08 02:04:00', NULL),
(131, 53, 'sale', 'Bạn có lượt bán mới', 'Stardew Valley', '/dev/sales', 0, '2026-10-08 02:04:00', NULL),
(132, 26, 'order_paid', 'Đơn hàng TEST-C55FAA61A370 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-C55FAA61A370', 0, '2026-10-08 05:54:00', NULL),
(133, 72, 'sale', 'Bạn có lượt bán mới', 'RimWorld', '/dev/sales', 0, '2026-10-08 05:54:00', NULL),
(134, 47, 'order_paid', 'Đơn hàng TEST-340F097E72B6 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-340F097E72B6', 0, '2026-10-09 01:15:00', NULL),
(135, 67, 'sale', 'Bạn có lượt bán mới', 'FTL: Faster Than Light', '/dev/sales', 0, '2026-10-09 01:15:00', NULL),
(136, 27, 'order_paid', 'Đơn hàng TEST-B5232FC04BBA đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-B5232FC04BBA', 0, '2026-10-09 07:31:00', NULL),
(137, 53, 'sale', 'Bạn có lượt bán mới', 'Stardew Valley', '/dev/sales', 0, '2026-10-09 07:31:00', NULL),
(138, 64, 'sale', 'Bạn có lượt bán mới', 'Unpacking', '/dev/sales', 0, '2026-10-09 07:31:00', NULL),
(139, 25, 'order_paid', 'Đơn hàng TEST-4E0D9165ACBF đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-4E0D9165ACBF', 0, '2026-10-10 12:47:00', NULL),
(140, 77, 'sale', 'Bạn có lượt bán mới', 'Night in the Woods', '/dev/sales', 0, '2026-10-10 12:47:00', NULL),
(141, 58, 'sale', 'Bạn có lượt bán mới', 'Slay the Spire', '/dev/sales', 0, '2026-10-10 12:47:00', NULL),
(142, 23, 'order_paid', 'Đơn hàng TEST-7E441CD6CCE3 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-7E441CD6CCE3', 0, '2026-10-11 02:05:00', NULL),
(143, 78, 'sale', 'Bạn có lượt bán mới', 'TUNIC', '/dev/sales', 0, '2026-10-11 02:05:00', NULL),
(144, 36, 'order_paid', 'Đơn hàng TEST-45897287751E đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-45897287751E', 0, '2026-10-12 01:56:00', NULL),
(145, 56, 'sale', 'Bạn có lượt bán mới', 'Hades', '/dev/sales', 0, '2026-10-12 01:56:00', NULL),
(146, 65, 'sale', 'Bạn có lượt bán mới', 'Loop Hero', '/dev/sales', 0, '2026-10-12 01:56:00', NULL),
(147, 35, 'order_paid', 'Đơn hàng TEST-DC610403FDA6 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-DC610403FDA6', 0, '2026-10-12 07:30:00', NULL),
(148, 61, 'sale', 'Bạn có lượt bán mới', 'Vampire Survivors', '/dev/sales', 0, '2026-10-12 07:30:00', NULL),
(149, 54, 'sale', 'Bạn có lượt bán mới', 'Hollow Knight', '/dev/sales', 0, '2026-10-12 07:30:00', NULL),
(150, 30, 'order_paid', 'Đơn hàng TEST-26DF54D188C7 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-26DF54D188C7', 0, '2026-10-13 01:01:00', NULL),
(151, 72, 'sale', 'Bạn có lượt bán mới', 'RimWorld', '/dev/sales', 0, '2026-10-13 01:01:00', NULL),
(152, 57, 'sale', 'Bạn có lượt bán mới', 'Dead Cells', '/dev/sales', 0, '2026-10-13 01:01:00', NULL),
(153, 31, 'order_paid', 'Đơn hàng TEST-D715B9A9DA00 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-D715B9A9DA00', 0, '2026-10-13 13:22:00', NULL),
(154, 55, 'sale', 'Bạn có lượt bán mới', 'Celeste', '/dev/sales', 0, '2026-10-13 13:22:00', NULL),
(155, 22, 'order_paid', 'Đơn hàng TEST-0BAB76750B1C đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-0BAB76750B1C', 0, '2026-10-13 15:45:00', NULL),
(156, 70, 'sale', 'Bạn có lượt bán mới', 'Darkest Dungeon', '/dev/sales', 0, '2026-10-13 15:45:00', NULL),
(157, 39, 'order_paid', 'Đơn hàng TEST-74357BBA15CE đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-74357BBA15CE', 0, '2026-10-13 15:52:00', NULL),
(158, 73, 'sale', 'Bạn có lượt bán mới', 'Enter the Gungeon', '/dev/sales', 0, '2026-10-13 15:52:00', NULL),
(159, 54, 'sale', 'Bạn có lượt bán mới', 'Hollow Knight', '/dev/sales', 0, '2026-10-13 15:52:00', NULL),
(160, 50, 'order_paid', 'Đơn hàng TEST-278120D86101 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-278120D86101', 0, '2026-10-14 12:09:00', NULL),
(161, 71, 'sale', 'Bạn có lượt bán mới', 'Cuphead', '/dev/sales', 0, '2026-10-14 12:09:00', NULL),
(162, 59, 'sale', 'Bạn có lượt bán mới', 'Terraria', '/dev/sales', 0, '2026-10-14 12:09:00', NULL),
(163, 19, 'order_paid', 'Đơn hàng TEST-34DED12AD869 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-34DED12AD869', 0, '2026-10-14 14:42:00', NULL),
(164, 73, 'sale', 'Bạn có lượt bán mới', 'Enter the Gungeon', '/dev/sales', 0, '2026-10-14 14:42:00', NULL),
(165, 59, 'sale', 'Bạn có lượt bán mới', 'Terraria', '/dev/sales', 0, '2026-10-14 14:42:00', NULL),
(166, 17, 'order_paid', 'Đơn hàng TEST-B0518C969421 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-B0518C969421', 0, '2026-10-15 02:52:00', NULL),
(167, 75, 'sale', 'Bạn có lượt bán mới', 'Factorio', '/dev/sales', 0, '2026-10-15 02:52:00', NULL),
(168, 68, 'sale', 'Bạn có lượt bán mới', 'Oxygen Not Included', '/dev/sales', 0, '2026-10-15 02:52:00', NULL),
(169, 52, 'order_paid', 'Đơn hàng TEST-47AA8C3A681B đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-47AA8C3A681B', 0, '2026-10-15 03:58:00', NULL),
(170, 62, 'sale', 'Bạn có lượt bán mới', 'Papers, Please', '/dev/sales', 0, '2026-10-15 03:58:00', NULL),
(171, 70, 'sale', 'Bạn có lượt bán mới', 'Darkest Dungeon', '/dev/sales', 0, '2026-10-15 03:58:00', NULL),
(172, 46, 'order_paid', 'Đơn hàng TEST-A63FD2397BCF đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-A63FD2397BCF', 0, '2026-10-15 07:41:00', NULL),
(173, 61, 'sale', 'Bạn có lượt bán mới', 'Vampire Survivors', '/dev/sales', 0, '2026-10-15 07:41:00', NULL),
(174, 29, 'order_paid', 'Đơn hàng TEST-C735CB504251 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-C735CB504251', 0, '2026-10-15 10:38:00', NULL),
(175, 74, 'sale', 'Bạn có lượt bán mới', 'UNDERTALE', '/dev/sales', 0, '2026-10-15 10:38:00', NULL),
(176, 41, 'order_paid', 'Đơn hàng TEST-9BC508FE2DCA đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-9BC508FE2DCA', 0, '2026-10-16 15:03:00', NULL),
(177, 68, 'sale', 'Bạn có lượt bán mới', 'Oxygen Not Included', '/dev/sales', 0, '2026-10-16 15:03:00', NULL),
(178, 20, 'order_paid', 'Đơn hàng TEST-7AC203C0EB5B đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-7AC203C0EB5B', 0, '2026-10-17 15:29:00', NULL),
(179, 67, 'sale', 'Bạn có lượt bán mới', 'Into the Breach', '/dev/sales', 0, '2026-10-17 15:29:00', NULL),
(180, 32, 'order_paid', 'Đơn hàng TEST-D6F5BD5C0ACF đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-D6F5BD5C0ACF', 0, '2026-10-18 04:28:00', NULL),
(181, 69, 'sale', 'Bạn có lượt bán mới', 'Balatro', '/dev/sales', 0, '2026-10-18 04:28:00', NULL),
(182, 33, 'order_paid', 'Đơn hàng TEST-C32168DE1B2B đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-C32168DE1B2B', 0, '2026-10-18 11:35:00', NULL),
(183, 62, 'sale', 'Bạn có lượt bán mới', 'Papers, Please', '/dev/sales', 0, '2026-10-18 11:35:00', NULL),
(184, 49, 'order_paid', 'Đơn hàng TEST-9C02F96F0E6E đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-9C02F96F0E6E', 0, '2026-10-18 13:18:00', NULL),
(185, 66, 'sale', 'Bạn có lượt bán mới', 'DREDGE', '/dev/sales', 0, '2026-10-18 13:18:00', NULL),
(186, 21, 'order_paid', 'Đơn hàng TEST-D957B7AA3C83 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-D957B7AA3C83', 0, '2026-10-18 14:14:00', NULL),
(187, 81, 'sale', 'Bạn có lượt bán mới', 'Spiritfarer: Farewell Edition', '/dev/sales', 0, '2026-10-18 14:14:00', NULL),
(188, 18, 'order_paid', 'Đơn hàng TEST-22A645FC79DE đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-22A645FC79DE', 0, '2026-10-17 11:50:00', NULL),
(189, 56, 'sale', 'Bạn có lượt bán mới', 'Roguelike tuyển chọn', '/dev/sales', 0, '2026-10-17 11:50:00', NULL),
(190, 57, 'sale', 'Bạn có lượt bán mới', 'Roguelike tuyển chọn', '/dev/sales', 0, '2026-10-17 11:50:00', NULL),
(191, 58, 'sale', 'Bạn có lượt bán mới', 'Roguelike tuyển chọn', '/dev/sales', 0, '2026-10-17 11:50:00', NULL),
(192, 73, 'sale', 'Bạn có lượt bán mới', 'Roguelike tuyển chọn', '/dev/sales', 0, '2026-10-17 11:50:00', NULL),
(193, 65, 'sale', 'Bạn có lượt bán mới', 'Roguelike tuyển chọn', '/dev/sales', 0, '2026-10-17 11:50:00', NULL),
(194, 26, 'order_paid', 'Đơn hàng TEST-5B3B91B0AB2A đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-5B3B91B0AB2A', 0, '2026-10-16 03:15:00', NULL),
(195, 67, 'sale', 'Bạn có lượt bán mới', 'Trọn bộ Subset Games', '/dev/sales', 0, '2026-10-16 03:15:00', NULL),
(196, 30, 'order_paid', 'Đơn hàng TEST-3A54B25CFD64 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-3A54B25CFD64', 0, '2026-10-15 04:50:00', NULL),
(197, 62, 'sale', 'Bạn có lượt bán mới', 'Trọn bộ Lucas Pope', '/dev/sales', 0, '2026-10-15 04:50:00', NULL),
(198, 24, 'order_paid', 'Đơn hàng TEST-7A38CFEC0C34 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-7A38CFEC0C34', 0, '2026-10-14 13:44:00', NULL),
(199, 74, 'sale', 'Bạn có lượt bán mới', 'Câu chuyện đáng nhớ', '/dev/sales', 0, '2026-10-14 13:44:00', NULL),
(200, 77, 'sale', 'Bạn có lượt bán mới', 'Câu chuyện đáng nhớ', '/dev/sales', 0, '2026-10-14 13:44:00', NULL),
(201, 80, 'sale', 'Bạn có lượt bán mới', 'Câu chuyện đáng nhớ', '/dev/sales', 0, '2026-10-14 13:44:00', NULL),
(202, 81, 'sale', 'Bạn có lượt bán mới', 'Câu chuyện đáng nhớ', '/dev/sales', 0, '2026-10-14 13:44:00', NULL),
(203, 27, 'order_paid', 'Đơn hàng TEST-D3B995A674F2 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-D3B995A674F2', 0, '2026-10-13 11:47:00', NULL),
(204, 54, 'sale', 'Bạn có lượt bán mới', 'Indie thập niên 2010', '/dev/sales', 0, '2026-10-13 11:47:00', NULL),
(205, 55, 'sale', 'Bạn có lượt bán mới', 'Indie thập niên 2010', '/dev/sales', 0, '2026-10-13 11:47:00', NULL),
(206, 74, 'sale', 'Bạn có lượt bán mới', 'Indie thập niên 2010', '/dev/sales', 0, '2026-10-13 11:47:00', NULL),
(207, 70, 'sale', 'Bạn có lượt bán mới', 'Indie thập niên 2010', '/dev/sales', 0, '2026-10-13 11:47:00', NULL),
(208, 67, 'sale', 'Bạn có lượt bán mới', 'Indie thập niên 2010', '/dev/sales', 0, '2026-10-13 11:47:00', NULL),
(209, 53, 'payout', 'Đợt chi trả $20.24: Đã chi trả', '', '/dev/payouts', 0, '2026-11-03 10:30:19', NULL),
(210, 57, 'payout', 'Đợt chi trả $34.91: Đã chi trả', '', '/dev/payouts', 0, '2026-11-03 12:19:42', NULL),
(211, 62, 'payout', 'Đợt chi trả $39.57: Đã chi trả', '', '/dev/payouts', 0, '2026-11-03 15:55:59', NULL),
(212, 67, 'payout', 'Đợt chi trả $45.86: Đã chi trả', '', '/dev/payouts', 0, '2026-11-03 10:34:57', NULL),
(213, 71, 'payout', 'Đợt chi trả $17.99: Đã chi trả', '', '/dev/payouts', 0, '2026-11-03 12:09:13', NULL),
(214, 75, 'payout', 'Đợt chi trả $22.05: Đã chi trả', '', '/dev/payouts', 0, '2026-11-03 12:59:49', NULL),
(215, 81, 'payout', 'Đợt chi trả $44.46: Đã chi trả', '', '/dev/payouts', 0, '2026-11-03 12:26:52', NULL),
(216, 46, 'order_paid', 'Đơn hàng TEST-935F7BB7E2FA đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-935F7BB7E2FA', 0, '2026-10-22 03:42:00', NULL),
(217, 62, 'sale', 'Bạn có lượt bán mới', 'Papers, Please', '/dev/sales', 0, '2026-10-22 03:42:00', NULL),
(218, 36, 'order_paid', 'Đơn hàng TEST-81240C0ABA1A đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-81240C0ABA1A', 0, '2026-10-22 06:25:00', NULL),
(219, 81, 'sale', 'Bạn có lượt bán mới', 'Spiritfarer: Farewell Edition', '/dev/sales', 0, '2026-10-22 06:25:00', NULL),
(220, 27, 'order_paid', 'Đơn hàng TEST-E5B84A8D7D69 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-E5B84A8D7D69', 0, '2026-10-22 06:35:00', NULL),
(221, 62, 'sale', 'Bạn có lượt bán mới', 'Return of the Obra Dinn', '/dev/sales', 0, '2026-10-22 06:35:00', NULL),
(222, 25, 'order_paid', 'Đơn hàng TEST-E094ACD55D53 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-E094ACD55D53', 0, '2026-10-22 13:15:00', NULL),
(223, 59, 'sale', 'Bạn có lượt bán mới', 'Terraria', '/dev/sales', 0, '2026-10-22 13:15:00', NULL),
(224, 33, 'order_paid', 'Đơn hàng TEST-545831BD7452 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-545831BD7452', 0, '2026-10-22 15:05:00', NULL),
(225, 68, 'sale', 'Bạn có lượt bán mới', 'Don\'t Starve', '/dev/sales', 0, '2026-10-22 15:05:00', NULL),
(226, 45, 'order_paid', 'Đơn hàng TEST-566871911BC1 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-566871911BC1', 0, '2026-10-23 03:58:00', NULL),
(227, 70, 'sale', 'Bạn có lượt bán mới', 'Darkest Dungeon', '/dev/sales', 0, '2026-10-23 03:58:00', NULL),
(228, 18, 'order_paid', 'Đơn hàng TEST-AC432DB75900 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-AC432DB75900', 0, '2026-10-23 11:54:00', NULL),
(229, 74, 'sale', 'Bạn có lượt bán mới', 'UNDERTALE', '/dev/sales', 0, '2026-10-23 11:54:00', NULL),
(230, 48, 'order_paid', 'Đơn hàng TEST-1C630924FCA2 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-1C630924FCA2', 0, '2026-10-23 12:15:00', NULL),
(231, 67, 'sale', 'Bạn có lượt bán mới', 'FTL: Faster Than Light', '/dev/sales', 0, '2026-10-23 12:15:00', NULL),
(232, 32, 'order_paid', 'Đơn hàng TEST-17C0CA82206A đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-17C0CA82206A', 0, '2026-10-23 15:50:00', NULL),
(233, 72, 'sale', 'Bạn có lượt bán mới', 'RimWorld', '/dev/sales', 0, '2026-10-23 15:50:00', NULL),
(234, 19, 'order_paid', 'Đơn hàng TEST-4E48CF53E611 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-4E48CF53E611', 0, '2026-10-24 02:51:00', NULL),
(235, 77, 'sale', 'Bạn có lượt bán mới', 'Night in the Woods', '/dev/sales', 0, '2026-10-24 02:51:00', NULL),
(236, 20, 'order_paid', 'Đơn hàng TEST-9E7F2F2CBD76 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-9E7F2F2CBD76', 0, '2026-10-24 08:25:00', NULL),
(237, 57, 'sale', 'Bạn có lượt bán mới', 'Dead Cells', '/dev/sales', 0, '2026-10-24 08:25:00', NULL),
(238, 44, 'order_paid', 'Đơn hàng TEST-75325E4B5476 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-75325E4B5476', 0, '2026-10-24 12:45:00', NULL),
(239, 75, 'sale', 'Bạn có lượt bán mới', 'Factorio', '/dev/sales', 0, '2026-10-24 12:45:00', NULL),
(240, 52, 'order_paid', 'Đơn hàng TEST-84A3240FEE79 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-84A3240FEE79', 0, '2026-10-24 14:00:00', NULL),
(241, 53, 'sale', 'Bạn có lượt bán mới', 'Stardew Valley', '/dev/sales', 0, '2026-10-24 14:00:00', NULL),
(242, 39, 'order_paid', 'Đơn hàng TEST-72A5820BFE86 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-72A5820BFE86', 0, '2026-10-25 01:55:00', NULL),
(243, 79, 'sale', 'Bạn có lượt bán mới', 'Baba Is You', '/dev/sales', 0, '2026-10-25 01:55:00', NULL),
(244, 38, 'order_paid', 'Đơn hàng TEST-9B35C1594825 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-9B35C1594825', 0, '2026-10-26 01:23:00', NULL),
(245, 62, 'sale', 'Bạn có lượt bán mới', 'Papers, Please', '/dev/sales', 0, '2026-10-26 01:23:00', NULL),
(246, 35, 'order_paid', 'Đơn hàng TEST-4D44B7171F33 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-4D44B7171F33', 0, '2026-10-26 02:44:00', NULL),
(247, 72, 'sale', 'Bạn có lượt bán mới', 'RimWorld', '/dev/sales', 0, '2026-10-26 02:44:00', NULL),
(248, 23, 'order_paid', 'Đơn hàng TEST-2925E9816954 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-2925E9816954', 0, '2026-10-26 06:32:00', NULL),
(249, 58, 'sale', 'Bạn có lượt bán mới', 'Slay the Spire', '/dev/sales', 0, '2026-10-26 06:32:00', NULL),
(250, 26, 'order_paid', 'Đơn hàng TEST-D1E206841E69 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-D1E206841E69', 0, '2026-10-26 10:38:00', NULL),
(251, 79, 'sale', 'Bạn có lượt bán mới', 'Baba Is You', '/dev/sales', 0, '2026-10-26 10:38:00', NULL),
(252, 40, 'order_paid', 'Đơn hàng TEST-6E95E2F92B0C đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-6E95E2F92B0C', 0, '2026-10-27 01:20:00', NULL),
(253, 68, 'sale', 'Bạn có lượt bán mới', 'Oxygen Not Included', '/dev/sales', 0, '2026-10-27 01:20:00', NULL),
(254, 21, 'order_paid', 'Đơn hàng TEST-379F8BC8930B đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-379F8BC8930B', 0, '2026-10-27 05:40:00', NULL),
(255, 65, 'sale', 'Bạn có lượt bán mới', 'Loop Hero', '/dev/sales', 0, '2026-10-27 05:40:00', NULL),
(256, 29, 'order_paid', 'Đơn hàng TEST-4B9F4A75C22E đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-4B9F4A75C22E', 0, '2026-10-27 05:46:00', NULL),
(257, 53, 'sale', 'Bạn có lượt bán mới', 'Stardew Valley', '/dev/sales', 0, '2026-10-27 05:46:00', NULL),
(258, 49, 'order_paid', 'Đơn hàng TEST-9113E62B6B92 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-9113E62B6B92', 0, '2026-10-27 07:11:00', NULL),
(259, 56, 'sale', 'Bạn có lượt bán mới', 'Hades', '/dev/sales', 0, '2026-10-27 07:11:00', NULL),
(260, 24, 'order_paid', 'Đơn hàng TEST-0C046C421DD9 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-0C046C421DD9', 0, '2026-10-28 02:58:00', NULL),
(261, 62, 'sale', 'Bạn có lượt bán mới', 'Return of the Obra Dinn', '/dev/sales', 0, '2026-10-28 02:58:00', NULL),
(262, 30, 'order_paid', 'Đơn hàng TEST-DA1E8BAFD4EA đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-DA1E8BAFD4EA', 0, '2026-10-28 03:24:00', NULL),
(263, 65, 'sale', 'Bạn có lượt bán mới', 'Loop Hero', '/dev/sales', 0, '2026-10-28 03:24:00', NULL),
(264, 41, 'order_paid', 'Đơn hàng TEST-4C1E1D9A79E5 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-4C1E1D9A79E5', 0, '2026-10-28 03:29:00', NULL),
(265, 53, 'sale', 'Bạn có lượt bán mới', 'Stardew Valley', '/dev/sales', 0, '2026-10-28 03:29:00', NULL),
(266, 22, 'order_paid', 'Đơn hàng TEST-10B7A0274171 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-10B7A0274171', 0, '2026-10-28 05:47:00', NULL),
(267, 68, 'sale', 'Bạn có lượt bán mới', 'Oxygen Not Included', '/dev/sales', 0, '2026-10-28 05:47:00', NULL),
(268, 47, 'order_paid', 'Đơn hàng TEST-3B7934820A77 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-3B7934820A77', 0, '2026-10-28 07:15:00', NULL),
(269, 72, 'sale', 'Bạn có lượt bán mới', 'RimWorld', '/dev/sales', 0, '2026-10-28 07:15:00', NULL),
(270, 42, 'order_paid', 'Đơn hàng TEST-755869458CA7 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-755869458CA7', 0, '2026-10-29 02:07:00', NULL),
(271, 70, 'sale', 'Bạn có lượt bán mới', 'Darkest Dungeon', '/dev/sales', 0, '2026-10-29 02:07:00', NULL),
(272, 51, 'order_paid', 'Đơn hàng TEST-A9746BD2C93F đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-A9746BD2C93F', 0, '2026-10-29 11:46:00', NULL),
(273, 67, 'sale', 'Bạn có lượt bán mới', 'FTL: Faster Than Light', '/dev/sales', 0, '2026-10-29 11:46:00', NULL),
(274, 34, 'order_paid', 'Đơn hàng TEST-CE6BB1FDB1FD đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-CE6BB1FDB1FD', 0, '2026-10-29 13:22:00', NULL),
(275, 58, 'sale', 'Bạn có lượt bán mới', 'Slay the Spire', '/dev/sales', 0, '2026-10-29 13:22:00', NULL),
(276, 31, 'order_paid', 'Đơn hàng TEST-6F50FF8A9CC8 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-6F50FF8A9CC8', 0, '2026-10-30 02:51:00', NULL),
(277, 75, 'sale', 'Bạn có lượt bán mới', 'Factorio', '/dev/sales', 0, '2026-10-30 02:51:00', NULL),
(278, 17, 'order_paid', 'Đơn hàng TEST-DEBE6C95D5F4 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-DEBE6C95D5F4', 0, '2026-10-30 12:04:00', NULL),
(279, 53, 'sale', 'Bạn có lượt bán mới', 'Stardew Valley', '/dev/sales', 0, '2026-10-30 12:04:00', NULL),
(280, 50, 'order_paid', 'Đơn hàng TEST-670C668C7015 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-670C668C7015', 0, '2026-10-31 03:35:00', NULL),
(281, 60, 'sale', 'Bạn có lượt bán mới', 'A Short Hike', '/dev/sales', 0, '2026-10-31 03:35:00', NULL),
(282, 28, 'order_paid', 'Đơn hàng TEST-7A0354B95C67 đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-7A0354B95C67', 0, '2026-10-31 12:31:00', NULL),
(283, 53, 'sale', 'Bạn có lượt bán mới', 'Stardew Valley', '/dev/sales', 0, '2026-10-31 12:31:00', NULL),
(284, 37, 'order_paid', 'Đơn hàng TEST-50DDC9114D8A đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-50DDC9114D8A', 0, '2026-11-01 07:10:00', NULL),
(285, 81, 'sale', 'Bạn có lượt bán mới', 'Spiritfarer: Farewell Edition', '/dev/sales', 0, '2026-11-01 07:10:00', NULL),
(286, 43, 'order_paid', 'Đơn hàng TEST-6085467203FE đã thanh toán (thử nghiệm)', 'Các trò chơi đã được thêm vào thư viện của bạn.', '/orders/TEST-6085467203FE', 0, '2026-11-01 10:51:00', NULL),
(287, 80, 'sale', 'Bạn có lượt bán mới', 'Outer Wilds', '/dev/sales', 0, '2026-11-01 10:51:00', NULL),
(288, 27, 'refund', 'Yêu cầu hoàn tiền đã được chấp nhận', 'Đã hoàn $19.99 cho \"Return of the Obra Dinn\". Quyền sở hữu mục này đã bị thu hồi.', '/orders/TEST-E5B84A8D7D69', 0, '2026-10-24 11:51:49', NULL),
(289, 25, 'refund', 'Yêu cầu hoàn tiền đã được chấp nhận', 'Đã hoàn $8.79 cho \"Terraria\". Quyền sở hữu mục này đã bị thu hồi.', '/orders/TEST-E094ACD55D53', 0, '2026-10-24 13:51:50', NULL),
(290, 33, 'refund', 'Yêu cầu hoàn tiền bị từ chối', 'Lý do: Lý do không thuộc chính sách hoàn tiền: trò chơi hoạt động bình thường trên cấu hình đã khai báo.', '/orders/TEST-545831BD7452', 0, '2026-10-24 16:58:46', NULL),
(291, 48, 'refund', 'Yêu cầu hoàn tiền đã được chấp nhận', 'Đã hoàn $9.99 cho \"FTL: Faster Than Light\". Quyền sở hữu mục này đã bị thu hồi.', '/orders/TEST-1C630924FCA2', 0, '2026-10-25 16:24:54', NULL),
(292, 32, 'refund', 'Yêu cầu hoàn tiền đã được chấp nhận', 'Đã hoàn $31.99 cho \"RimWorld\". Quyền sở hữu mục này đã bị thu hồi.', '/orders/TEST-17C0CA82206A', 0, '2026-10-25 16:40:09', NULL),
(293, 19, 'refund', 'Yêu cầu hoàn tiền bị từ chối', 'Lý do: Lý do không thuộc chính sách hoàn tiền: trò chơi hoạt động bình thường trên cấu hình đã khai báo.', '/orders/TEST-4E48CF53E611', 0, '2026-10-26 06:10:48', NULL),
(294, 52, 'refund', 'Yêu cầu hoàn tiền đã được chấp nhận', 'Đã hoàn $14.99 cho \"Stardew Valley\". Quyền sở hữu mục này đã bị thu hồi.', '/orders/TEST-84A3240FEE79', 0, '2026-10-26 15:35:14', NULL),
(295, 39, 'refund', 'Yêu cầu hoàn tiền đã được chấp nhận', 'Đã hoàn $13.49 cho \"Baba Is You\". Quyền sở hữu mục này đã bị thu hồi.', '/orders/TEST-72A5820BFE86', 0, '2026-10-27 03:01:19', NULL),
(296, 38, 'refund', 'Yêu cầu hoàn tiền bị từ chối', 'Lý do: Lý do không thuộc chính sách hoàn tiền: trò chơi hoạt động bình thường trên cấu hình đã khai báo.', '/orders/TEST-9B35C1594825', 0, '2026-10-28 04:10:03', NULL),
(297, 26, 'refund', 'Yêu cầu hoàn tiền đã được chấp nhận', 'Đã hoàn $14.99 cho \"Baba Is You\". Quyền sở hữu mục này đã bị thu hồi.', '/orders/TEST-D1E206841E69', 0, '2026-10-28 13:02:26', NULL),
(298, 40, 'refund', 'Yêu cầu hoàn tiền đã được chấp nhận', 'Đã hoàn $24.99 cho \"Oxygen Not Included\". Quyền sở hữu mục này đã bị thu hồi.', '/orders/TEST-6E95E2F92B0C', 0, '2026-10-29 04:07:34', NULL),
(299, 21, 'refund', 'Yêu cầu hoàn tiền bị từ chối', 'Lý do: Lý do không thuộc chính sách hoàn tiền: trò chơi hoạt động bình thường trên cấu hình đã khai báo.', '/orders/TEST-379F8BC8930B', 0, '2026-10-29 09:55:53', NULL),
(300, 24, 'refund', 'Yêu cầu hoàn tiền đã được chấp nhận', 'Đã hoàn $16.99 cho \"Return of the Obra Dinn\". Quyền sở hữu mục này đã bị thu hồi.', '/orders/TEST-0C046C421DD9', 0, '2026-10-30 04:59:28', NULL),
(301, 30, 'refund', 'Yêu cầu hoàn tiền đã được chấp nhận', 'Đã hoàn $12.74 cho \"Loop Hero\". Quyền sở hữu mục này đã bị thu hồi.', '/orders/TEST-DA1E8BAFD4EA', 0, '2026-10-30 03:38:49', NULL),
(302, 41, 'refund', 'Yêu cầu hoàn tiền bị từ chối', 'Lý do: Lý do không thuộc chính sách hoàn tiền: trò chơi hoạt động bình thường trên cấu hình đã khai báo.', '/orders/TEST-4C1E1D9A79E5', 0, '2026-10-30 08:48:34', NULL),
(303, 42, 'refund', 'Yêu cầu hoàn tiền đã được chấp nhận', 'Đã hoàn $22.99 cho \"Darkest Dungeon\". Quyền sở hữu mục này đã bị thu hồi.', '/orders/TEST-755869458CA7', 0, '2026-10-31 02:44:29', NULL),
(304, 51, 'refund', 'Yêu cầu hoàn tiền đã được chấp nhận', 'Đã hoàn $9.99 cho \"FTL: Faster Than Light\". Quyền sở hữu mục này đã bị thu hồi.', '/orders/TEST-A9746BD2C93F', 0, '2026-10-31 13:03:39', NULL),
(305, 34, 'refund', 'Yêu cầu hoàn tiền bị từ chối', 'Lý do: Lý do không thuộc chính sách hoàn tiền: trò chơi hoạt động bình thường trên cấu hình đã khai báo.', '/orders/TEST-CE6BB1FDB1FD', 0, '2026-10-31 17:40:05', NULL),
(337, 173, 'download_link', 'Liên kết tải về của bạn không được duyệt', 'Lý do: Link trả về lỗi 404, không tải được. Vui lòng gửi lại link khác.', '/games/du-mau-nhieu-link-tai-ve/downloads', 0, '2026-10-27 09:12:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `thong_ke_tro_choi_hang_ngay`
--

CREATE TABLE `thong_ke_tro_choi_hang_ngay` (
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `ngay_thong_ke` date NOT NULL,
  `luot_xem_trang` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `luot_nhan_tai_xuong` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `so_luot_mua` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `doanh_thu_gop` decimal(14,2) NOT NULL DEFAULT 0.00,
  `luot_them_yeu_thich` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `so_luong_binh_luan` bigint(20) UNSIGNED NOT NULL DEFAULT 0
) ;

--
-- Dumping data for table `thong_ke_tro_choi_hang_ngay`
--

INSERT INTO `thong_ke_tro_choi_hang_ngay` (`tro_choi_id`, `ngay_thong_ke`, `luot_xem_trang`, `luot_nhan_tai_xuong`, `so_luot_mua`, `doanh_thu_gop`, `luot_them_yeu_thich`, `so_luong_binh_luan`) VALUES
(3, '2026-11-03', 10, 0, 0, 0.00, 0, 0),
(3, '2026-11-04', 33, 0, 0, 0.00, 0, 0),
(4, '2026-11-03', 10, 0, 0, 0.00, 0, 0),
(4, '2026-11-04', 30, 0, 0, 0.00, 0, 0),
(5, '2026-11-03', 1, 0, 0, 0.00, 0, 0),
(5, '2026-11-04', 16, 0, 0, 0.00, 0, 0),
(10, '2026-11-03', 1, 0, 0, 0.00, 0, 0),
(15, '2026-09-05', 0, 0, 1, 14.99, 0, 0),
(15, '2026-10-08', 0, 0, 1, 11.24, 0, 0),
(15, '2026-10-09', 0, 0, 1, 11.24, 0, 0),
(15, '2026-10-24', 0, 0, 1, 14.99, 0, 0),
(15, '2026-10-27', 0, 0, 1, 13.79, 0, 0),
(15, '2026-10-28', 0, 0, 1, 14.99, 0, 0),
(15, '2026-10-30', 0, 0, 1, 14.99, 0, 0),
(15, '2026-10-31', 0, 0, 1, 13.79, 0, 0),
(15, '2026-11-04', 28, 0, 0, 0.00, 0, 0),
(16, '2026-09-05', 0, 0, 1, 14.99, 0, 0),
(16, '2026-10-12', 0, 0, 1, 13.79, 0, 0),
(16, '2026-10-13', 0, 0, 2, 21.49, 0, 0),
(16, '2026-11-04', 31, 0, 1, 14.99, 0, 0),
(17, '2026-08-30', 0, 0, 1, 16.99, 0, 0),
(17, '2026-10-13', 0, 0, 2, 29.99, 0, 0),
(17, '2026-11-04', 1, 0, 0, 0.00, 0, 0),
(18, '2026-09-05', 0, 0, 1, 24.99, 0, 0),
(18, '2026-09-12', 0, 0, 1, 24.99, 0, 0),
(18, '2026-10-12', 0, 0, 1, 24.99, 0, 0),
(18, '2026-10-17', 0, 0, 1, 13.80, 0, 0),
(18, '2026-10-27', 0, 0, 1, 24.99, 0, 0),
(18, '2026-11-04', 1, 0, 0, 0.00, 0, 0),
(19, '2026-08-28', 0, 0, 1, 24.99, 0, 0),
(19, '2026-10-13', 0, 0, 1, 24.99, 0, 0),
(19, '2026-10-17', 0, 0, 1, 13.80, 0, 0),
(19, '2026-10-24', 0, 0, 1, 24.99, 0, 0),
(19, '2026-11-04', 1, 0, 0, 0.00, 0, 0),
(20, '2026-08-26', 0, 0, 1, 24.99, 0, 0),
(20, '2026-09-18', 0, 0, 1, 24.99, 0, 0),
(20, '2026-10-10', 0, 0, 1, 18.74, 0, 0),
(20, '2026-10-17', 0, 0, 1, 13.80, 0, 0),
(20, '2026-10-26', 0, 0, 1, 24.99, 0, 0),
(20, '2026-10-29', 0, 0, 1, 24.99, 0, 0),
(20, '2026-11-04', 1, 0, 0, 0.00, 0, 0),
(21, '2026-08-22', 0, 0, 1, 9.99, 0, 0),
(21, '2026-10-14', 0, 0, 2, 19.98, 0, 0),
(21, '2026-10-22', 0, 0, 1, 8.79, 0, 0),
(21, '2026-11-04', 2, 0, 0, 0.00, 0, 0),
(22, '2026-08-22', 0, 0, 1, 6.78, 0, 0),
(22, '2026-09-20', 0, 0, 1, 6.79, 0, 0),
(22, '2026-10-31', 0, 0, 1, 7.99, 0, 0),
(22, '2026-11-04', 1, 0, 0, 0.00, 0, 0),
(23, '2026-09-05', 0, 0, 1, 4.99, 0, 0),
(23, '2026-10-12', 0, 0, 1, 4.59, 0, 0),
(23, '2026-10-15', 0, 0, 1, 4.99, 0, 0),
(23, '2026-11-04', 1, 0, 0, 0.00, 0, 0),
(24, '2026-10-15', 0, 0, 2, 17.98, 0, 0),
(24, '2026-10-18', 0, 0, 1, 9.99, 0, 0),
(24, '2026-10-22', 0, 0, 1, 9.99, 0, 0),
(24, '2026-10-26', 0, 0, 1, 7.99, 0, 0),
(24, '2026-11-04', 2, 0, 0, 0.00, 0, 0),
(25, '2026-08-26', 0, 0, 1, 19.99, 0, 0),
(25, '2026-08-30', 0, 0, 1, 16.99, 0, 0),
(26, '2026-10-08', 0, 0, 1, 14.99, 0, 0),
(26, '2026-10-09', 0, 0, 1, 14.99, 0, 0),
(27, '2026-09-20', 0, 0, 1, 13.19, 0, 0),
(27, '2026-10-12', 0, 0, 1, 14.99, 0, 0),
(27, '2026-10-17', 0, 0, 1, 8.27, 0, 0),
(27, '2026-10-27', 0, 0, 1, 14.99, 0, 0),
(27, '2026-10-28', 0, 0, 1, 12.74, 0, 0),
(28, '2026-09-13', 0, 0, 1, 24.99, 0, 0),
(28, '2026-10-18', 0, 0, 1, 17.49, 0, 0),
(29, '2026-08-30', 0, 0, 1, 9.19, 0, 0),
(29, '2026-10-09', 0, 0, 1, 9.99, 0, 0),
(29, '2026-10-13', 0, 0, 1, 5.99, 0, 0),
(29, '2026-10-16', 0, 0, 1, 7.99, 0, 0),
(29, '2026-10-23', 0, 0, 1, 9.99, 0, 0),
(29, '2026-10-29', 0, 0, 1, 9.99, 0, 0),
(30, '2026-09-16', 0, 0, 2, 19.18, 0, 0),
(30, '2026-10-22', 0, 0, 1, 9.99, 0, 0),
(31, '2026-09-02', 0, 0, 1, 14.99, 0, 0),
(31, '2026-09-18', 0, 0, 1, 14.99, 0, 0),
(31, '2026-10-18', 0, 0, 1, 14.99, 0, 0),
(31, '2026-11-04', 21, 0, 0, 0.00, 0, 0),
(32, '2026-10-13', 0, 0, 2, 39.99, 0, 0),
(32, '2026-10-15', 0, 0, 1, 24.99, 0, 0),
(32, '2026-10-23', 0, 0, 1, 21.24, 0, 0),
(32, '2026-10-29', 0, 0, 1, 22.99, 0, 0),
(33, '2026-09-05', 0, 0, 1, 19.99, 0, 0),
(33, '2026-10-14', 0, 0, 1, 19.99, 0, 0),
(34, '2026-10-08', 0, 0, 1, 34.99, 0, 0),
(34, '2026-10-13', 0, 0, 1, 34.99, 0, 0),
(34, '2026-10-23', 0, 0, 1, 31.99, 0, 0),
(34, '2026-10-26', 0, 0, 1, 34.99, 0, 0),
(34, '2026-10-28', 0, 0, 1, 34.99, 0, 0),
(35, '2026-10-13', 0, 0, 1, 12.49, 0, 0),
(35, '2026-10-14', 0, 0, 1, 14.99, 0, 0),
(35, '2026-10-17', 0, 0, 1, 8.28, 0, 0),
(36, '2026-09-16', 0, 0, 1, 8.79, 0, 0),
(36, '2026-10-13', 0, 0, 1, 6.00, 0, 0),
(36, '2026-10-14', 0, 0, 1, 6.47, 0, 0),
(36, '2026-10-15', 0, 0, 1, 9.99, 0, 0),
(36, '2026-10-23', 0, 0, 1, 9.99, 0, 0),
(37, '2026-09-16', 0, 0, 1, 30.00, 0, 0),
(37, '2026-10-15', 0, 0, 1, 24.50, 0, 0),
(37, '2026-10-24', 0, 0, 1, 35.00, 0, 0),
(37, '2026-10-30', 0, 0, 1, 35.00, 0, 0),
(38, '2026-10-15', 0, 0, 1, 17.49, 0, 0),
(38, '2026-10-16', 0, 0, 1, 24.99, 0, 0),
(38, '2026-10-27', 0, 0, 1, 24.99, 0, 0),
(38, '2026-10-28', 0, 0, 1, 24.99, 0, 0),
(39, '2026-09-04', 0, 0, 1, 13.49, 0, 0),
(39, '2026-09-12', 0, 0, 1, 14.99, 0, 0),
(40, '2026-09-05', 0, 0, 1, 19.99, 0, 0),
(40, '2026-10-10', 0, 0, 1, 14.99, 0, 0),
(40, '2026-10-14', 0, 0, 1, 12.94, 0, 0),
(40, '2026-10-24', 0, 0, 1, 16.99, 0, 0),
(41, '2026-08-26', 0, 0, 1, 29.99, 0, 0),
(41, '2026-10-11', 0, 0, 1, 25.49, 0, 0),
(42, '2026-08-26', 0, 0, 1, 14.99, 0, 0),
(42, '2026-10-16', 0, 0, 1, 12.00, 0, 0),
(42, '2026-10-17', 0, 0, 1, 14.99, 0, 0),
(43, '2026-08-28', 0, 0, 1, 17.99, 0, 0),
(43, '2026-09-02', 0, 0, 1, 19.99, 0, 0),
(43, '2026-10-15', 0, 0, 1, 16.00, 0, 0),
(43, '2026-10-22', 0, 0, 1, 19.99, 0, 0),
(43, '2026-10-28', 0, 0, 1, 16.99, 0, 0),
(43, '2026-11-04', 22, 0, 0, 0.00, 0, 0),
(44, '2026-08-30', 0, 0, 1, 12.74, 0, 0),
(44, '2026-09-06', 0, 0, 1, 13.49, 0, 0),
(44, '2026-10-25', 0, 0, 1, 13.49, 0, 0),
(44, '2026-10-26', 0, 0, 1, 14.99, 0, 0),
(45, '2026-08-22', 0, 0, 2, 46.19, 0, 0),
(45, '2026-10-14', 0, 0, 1, 16.17, 0, 0),
(45, '2026-11-01', 0, 0, 1, 22.99, 0, 0),
(46, '2026-09-20', 0, 0, 1, 26.39, 0, 0),
(46, '2026-10-14', 0, 0, 1, 19.41, 0, 0),
(46, '2026-10-18', 0, 0, 1, 29.99, 0, 0),
(46, '2026-10-22', 0, 0, 1, 29.99, 0, 0),
(46, '2026-11-01', 0, 0, 1, 29.99, 0, 0),
(48, '2026-11-04', 20, 0, 0, 0.00, 0, 0),
(50, '2026-11-04', 21, 1, 0, 0.00, 0, 0),
(78, '2026-10-30', 42, 11, 1, 4.99, 2, 1),
(78, '2026-10-31', 55, 18, 2, 9.98, 3, 0),
(78, '2026-11-01', 71, 24, 3, 14.97, 5, 2),
(78, '2026-11-02', 64, 19, 2, 9.98, 4, 1),
(78, '2026-11-03', 83, 31, 4, 19.96, 7, 3);

-- --------------------------------------------------------

--
-- Table structure for table `tro_choi`
--

CREATE TABLE `tro_choi` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `nguoi_tao_id` bigint(20) UNSIGNED NOT NULL,
  `tieu_de` varchar(200) NOT NULL,
  `duong_dan_rut_gon` varchar(220) NOT NULL,
  `mo_ta_ngan` varchar(500) DEFAULT NULL,
  `mo_ta` mediumtext DEFAULT NULL,
  `loai_du_an` enum('game','asset','tool','soundtrack','comic','book','physical','other') NOT NULL DEFAULT 'game',
  `trang_thai` enum('draft','published','unlisted','hidden','under_review','suspended') NOT NULL DEFAULT 'draft',
  `trang_thai_phat_hanh` enum('prototype','in_development','early_access','released','cancelled') NOT NULL DEFAULT 'in_development',
  `mo_hinh_gia` enum('free','paid','pay_what_you_want','donation') NOT NULL DEFAULT 'free',
  `gia_toi_thieu` decimal(12,2) NOT NULL DEFAULT 0.00,
  `gia_de_xuat` decimal(12,2) DEFAULT NULL,
  `ma_tien_te` char(3) NOT NULL DEFAULT 'USD',
  `phan_loai_do_tuoi` varchar(40) DEFAULT NULL,
  `ten_giay_phep` varchar(120) DEFAULT NULL,
  `url_choi_ngoai` varchar(1000) DEFAULT NULL,
  `cho_phep_binh_luan` tinyint(1) NOT NULL DEFAULT 1,
  `cho_phep_danh_gia` tinyint(1) NOT NULL DEFAULT 1,
  `ngay_cong_bo` datetime DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

--
-- Dumping data for table `tro_choi`
--

INSERT INTO `tro_choi` (`ma`, `nguoi_tao_id`, `tieu_de`, `duong_dan_rut_gon`, `mo_ta_ngan`, `mo_ta`, `loai_du_an`, `trang_thai`, `trang_thai_phat_hanh`, `mo_hinh_gia`, `gia_toi_thieu`, `gia_de_xuat`, `ma_tien_te`, `phan_loai_do_tuoi`, `ten_giay_phep`, `url_choi_ngoai`, `cho_phep_binh_luan`, `cho_phep_danh_gia`, `ngay_cong_bo`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(3, 9, '0 A.D.', '0-a-d', 'Chiến thuật thời gian thực lấy bối cảnh các nền văn minh cổ đại: xây thành, khai thác tài nguyên và chỉ huy quân đội.', '0 A.D. là trò chơi chiến thuật thời gian thực (RTS) lịch sử, miễn phí và mã nguồn mở, do Wildfire Games — một nhóm tình nguyện viên trên khắp thế giới — phát triển.\n\nNgười chơi chọn một nền văn minh cổ đại, xây dựng thành phố, thu thập lương thực, gỗ, đá và kim loại, rồi huấn luyện quân đội để phòng thủ hoặc chinh phục đối thủ. Có thể chơi đơn với máy hoặc chơi nhiều người qua mạng.\n\nTrò chơi vẫn đang được phát triển tích cực. Mã nguồn phát hành theo GPL, phần đồ họa theo CC BY-SA.', 'game', 'published', 'in_development', 'free', 0.00, NULL, 'USD', NULL, 'GPL-2.0-or-later (mã nguồn), CC BY-SA 3.0 (đồ họa)', 'https://play0ad.com/', 1, 1, '2026-11-03 09:23:05', '2026-11-03 08:23:05', '2026-11-03 08:23:05'),
(4, 10, 'SuperTuxKart', 'supertuxkart', 'Đua xe kart 3D với các linh vật của phần mềm tự do, hỗ trợ chia màn hình và chơi trực tuyến.', 'SuperTuxKart là trò chơi đua xe kart 3D miễn phí và mã nguồn mở. Người chơi điều khiển Tux và các linh vật quen thuộc của cộng đồng phần mềm tự do trên nhiều đường đua khác nhau.\n\nTrò chơi có chế độ đua thường, đua tính giờ, đấu trường, bóng đá và chế độ cốt truyện. Có thể chơi chia màn hình trên một máy hoặc đua trực tuyến.\n\nMã nguồn phát hành theo giấy phép GPLv3.', 'game', 'published', 'released', 'free', 0.00, NULL, 'USD', NULL, 'GPL-3.0-or-later', 'https://supertuxkart.net/', 1, 1, '2026-11-03 09:23:05', '2026-11-03 08:23:05', '2026-11-03 08:23:05'),
(5, 11, 'The Battle for Wesnoth', 'the-battle-for-wesnoth', 'Chiến thuật theo lượt trên bản đồ lục giác, bối cảnh giả tưởng với nhiều chiến dịch chơi đơn và chế độ nhiều người.', 'The Battle for Wesnoth là trò chơi chiến thuật theo lượt với chủ đề giả tưởng, miễn phí và mã nguồn mở. Người chơi chỉ huy quân đội trên bản đồ ô lục giác, tuyển mộ đơn vị và giúp các đơn vị lên cấp qua từng trận.\n\nTrò chơi có nhiều chiến dịch chơi đơn, chế độ nhiều người chơi, trình chỉnh sửa bản đồ và kho nội dung do cộng đồng đóng góp.\n\nMã nguồn phát hành theo giấy phép GPL.', 'game', 'published', 'released', 'free', 0.00, NULL, 'USD', NULL, 'GPL-2.0-or-later', 'https://www.wesnoth.org/', 1, 1, '2026-11-03 09:23:05', '2026-11-03 08:23:05', '2026-11-03 08:23:05'),
(6, 12, 'Luanti', 'luanti', 'Nền tảng trò chơi voxel mã nguồn mở (trước đây là Minetest): khám phá, xây dựng và cài thêm trò chơi từ kho nội dung.', 'Luanti (trước đây có tên Minetest) là engine và nền tảng trò chơi voxel miễn phí, mã nguồn mở. Người chơi khám phá thế giới khối được sinh tự động, khai thác và xây dựng.\n\nĐiểm mạnh của Luanti là khả năng mở rộng: người dùng cài thêm trò chơi, bản mod và gói giao diện ngay trong trình duyệt nội dung tích hợp. Hỗ trợ chơi đơn và máy chủ nhiều người chơi.\n\nCác ảnh chụp có ghi \"Minetest\" được chụp trước khi dự án đổi tên.', 'game', 'published', 'released', 'free', 0.00, NULL, 'USD', NULL, 'LGPL-2.1-or-later (mã nguồn), CC BY-SA 3.0 (nội dung)', 'https://www.luanti.org/', 1, 1, '2026-11-03 09:23:05', '2026-11-03 08:23:05', '2026-11-03 08:23:05'),
(7, 13, 'Mindustry', 'mindustry', 'Xây dây chuyền khai thác và băng chuyền, phòng thủ căn cứ trước các đợt tấn công liên tiếp.', 'Mindustry là trò chơi mã nguồn mở kết hợp xây dựng nhà máy với thủ thành, do Anuke phát triển. Người chơi khai thác tài nguyên, dựng băng chuyền và nhà máy chế tạo, rồi dùng sản phẩm để xây tháp phòng thủ và đơn vị chiến đấu.\n\nTrò chơi có chế độ chiến dịch trên nhiều hành tinh, chế độ tự do, PvP và máy chủ nhiều người chơi.\n\nMã nguồn phát hành theo giấy phép GPLv3.', 'game', 'published', 'released', 'free', 0.00, NULL, 'USD', NULL, 'GPL-3.0', 'https://mindustrygame.github.io/', 1, 1, '2026-11-03 09:23:05', '2026-11-03 08:23:05', '2026-11-03 08:23:05'),
(8, 14, 'OpenTTD', 'openttd', 'Mô phỏng kinh doanh vận tải: xây mạng lưới đường sắt, đường bộ, đường thủy và hàng không để kết nối thành phố.', 'OpenTTD là trò chơi mô phỏng kinh doanh vận tải miễn phí, mã nguồn mở, ban đầu được xây dựng dựa trên Transport Tycoon Deluxe. Người chơi lập công ty, xây tuyến đường sắt, đường bộ, cảng biển và sân bay để chở hành khách và hàng hóa kiếm lợi nhuận.\n\nTrò chơi hỗ trợ chơi nhiều người, AI đối thủ và kho nội dung bổ sung trực tuyến. Bộ đồ họa mặc định OpenGFX cũng là nội dung tự do.\n\nMã nguồn phát hành theo giấy phép GPLv2.', 'game', 'published', 'released', 'free', 0.00, NULL, 'USD', NULL, 'GPL-2.0', 'https://www.openttd.org/', 1, 1, '2026-11-03 09:23:05', '2026-11-03 08:23:05', '2026-11-03 08:23:05'),
(9, 15, 'Xonotic', 'xonotic', 'Bắn súng góc nhìn thứ nhất phong cách đấu trường, nhịp độ nhanh, nhiều chế độ chơi trực tuyến.', 'Xonotic là trò chơi bắn súng góc nhìn thứ nhất phong cách đấu trường, miễn phí và mã nguồn mở, chú trọng tốc độ và kỹ năng di chuyển.\n\nTrò chơi có nhiều chế độ như deathmatch, đấu đội và cướp cờ, cùng các bản đồ và vũ khí đa dạng. Có thể chơi trực tuyến hoặc với bot.\n\nMã nguồn phát hành theo giấy phép GPL.', 'game', 'published', 'released', 'free', 0.00, NULL, 'USD', NULL, 'GPL-3.0-or-later', 'https://xonotic.org/', 1, 1, '2026-11-03 09:23:05', '2026-11-03 08:23:05', '2026-11-03 08:23:05'),
(10, 16, 'Freeciv', 'freeciv', 'Chiến thuật 4X theo lượt: dẫn dắt một nền văn minh từ thời đồ đá đến thời đại không gian.', 'Freeciv là trò chơi chiến thuật theo lượt kiểu 4X (khám phá, mở rộng, khai thác, tiêu diệt), miễn phí và mã nguồn mở, lấy cảm hứng từ dòng Civilization.\n\nNgười chơi lập thành phố, nghiên cứu công nghệ, ngoại giao và chiến tranh để đưa nền văn minh của mình vượt qua các thời đại. Hỗ trợ chơi đơn với AI và chơi nhiều người.\n\nMã nguồn phát hành theo giấy phép GPL.', 'game', 'published', 'released', 'free', 0.00, NULL, 'USD', NULL, 'GPL-2.0-or-later', 'https://www.freeciv.org/', 1, 1, '2026-11-03 09:23:05', '2026-11-03 08:23:05', '2026-11-03 08:23:05'),
(15, 53, 'Stardew Valley', 'stardew-valley', 'Nhận lại nông trại cũ của ông, trồng trọt, chăn nuôi, đi câu, đào mỏ và làm quen với cư dân thị trấn Pelican.', 'Bạn rời công việc văn phòng để về tiếp quản mảnh đất bỏ hoang mà ông để lại ở Stardew Valley. Với vài dụng cụ cũ và ít tiền vốn, bạn dọn đất, trồng cây theo mùa, nuôi gà, bò, và dần mở rộng nông trại theo ý mình.\n\nNgoài làm nông còn có câu cá, khám phá hầm mỏ đầy quái vật, chế tạo đồ, tham gia lễ hội và kết bạn với hơn hai mươi cư dân, thậm chí tiến tới hôn nhân. Thị trấn Pelican đang bị tập đoàn Joja lấn át; bạn có thể khôi phục Trung tâm cộng đồng để vực dậy nơi này.\n\nHỗ trợ chơi hợp tác trực tuyến từ 1 đến 8 người.\n\nNhà phát triển: ConcernedApe. Nhà phát hành: ConcernedApe. Phát hành trên Steam ngày 26/02/2016.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 14.99, NULL, 'USD', NULL, 'Bản quyền thương mại © ConcernedApe', NULL, 1, 1, '2026-09-24 03:17:29', '2026-11-04 01:17:30', '2026-11-04 01:17:30'),
(16, 54, 'Hollow Knight', 'hollow-knight', 'Phiêu lưu hành động 2D vẽ tay trong vương quốc côn trùng đổ nát Hallownest, với hệ thống bản đồ rộng lớn và trùm khó.', 'Bắt đầu từ thị trấn nhỏ Dirtmouth, bạn đi xuống vương quốc côn trùng đã sụp đổ Hallownest: những hang động phủ rêu, thành phố chìm trong mưa và các vùng đất bị một căn bệnh bí ẩn nuốt chửng.\n\nTrò chơi theo lối metroidvania: thu thập năng lực mới để mở đường, ghép bùa để thay đổi lối đánh, tự vẽ bản đồ và đối đầu hơn ba mươi trùm. Đồ họa vẽ tay và nhạc nền giàu cảm xúc tạo nên không khí u buồn đặc trưng.\n\nCác bản mở rộng miễn phí Hidden Dreams, The Grimm Troupe, Lifeblood và Godmaster đã được gộp sẵn vào trò chơi.\n\nNhà phát triển: Team Cherry. Nhà phát hành: Team Cherry. Phát hành trên Steam ngày 24/02/2017.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 14.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Team Cherry', NULL, 1, 1, '2026-09-28 03:17:29', '2026-11-04 01:17:30', '2026-11-04 01:17:30'),
(17, 55, 'Celeste', 'celeste', 'Giúp Madeline leo lên đỉnh núi Celeste qua hơn 700 màn chơi nhảy nền chính xác, kèm câu chuyện về lo âu và tự chấp nhận bản thân.', 'Madeline quyết tâm leo lên đỉnh núi Celeste. Trên đường đi, cô phải đối mặt với chính những nỗi sợ và sự tự nghi ngờ của mình.\n\nĐây là trò chơi nhảy nền đòi hỏi độ chính xác cao với hơn 700 màn hình, các màn B-side và nhiều bí mật ẩn giấu. Điều khiển nhạy, chết là quay lại ngay, và có chế độ hỗ trợ cho người muốn điều chỉnh độ khó. Nhạc nền của Lena Raine từng lọt vào chung kết hạng mục âm thanh tại IGF.\n\nTrò chơi đến từ nhóm tác giả của TowerFall.\n\nNhà phát triển: Maddy Makes Games Inc., Extremely OK Games, Ltd.. Nhà phát hành: Maddy Makes Games Inc.. Phát hành trên Steam ngày 25/01/2018.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 19.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Maddy Makes Games Inc., Extremely OK Games, Ltd.', NULL, 1, 1, '2026-10-02 03:17:29', '2026-11-04 01:17:30', '2026-11-04 01:17:30'),
(18, 56, 'Hades', 'hades', 'Roguelike hành động góc nhìn từ trên xuống: hoàng tử Zagreus chiến đấu để thoát khỏi Âm phủ với sức mạnh từ các vị thần Olympus.', 'Bạn vào vai Zagreus, hoàng tử bất tử của Âm phủ, tìm cách thoát khỏi vương quốc của cha mình là thần Hades. Mỗi lần thất bại, bạn trở về Nhà của Hades, gặp lại các nhân vật và câu chuyện tiếp tục mở ra.\n\nCác vị thần Olympus như Zeus, Athena, Poseidon ban cho bạn những phúc lành thay đổi lối đánh trong từng lượt chơi. Kết hợp vũ khí, phúc lành và nâng cấp vĩnh viễn để vượt qua Tartarus, Asphodel và những vùng sâu hơn.\n\nToàn bộ nhân vật đều được lồng tiếng. Trò chơi do đội ngũ làm Bastion, Transistor và Pyre phát triển.\n\nNhà phát triển: Supergiant Games. Nhà phát hành: Supergiant Games. Phát hành trên Steam ngày 17/09/2020.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 24.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Supergiant Games', NULL, 1, 1, '2026-10-06 03:17:29', '2026-11-04 01:17:30', '2026-11-04 01:17:30'),
(19, 57, 'Dead Cells', 'dead-cells', 'Roguelite kết hợp metroidvania: khám phá một hòn đảo luôn thay đổi, chiến đấu nhanh, chết là bắt đầu lại.', 'Bạn là một thí nghiệm giả kim thất bại, một khối tế bào có thể nhập vào xác chết để tiếp tục cuộc hành trình trên hòn đảo đang thay đổi không ngừng.\n\nDead Cells kết hợp khám phá kiểu metroidvania với cấu trúc roguelite: bản đồ thay đổi qua từng lần chơi, không có điểm lưu giữa chừng, và mỗi lần chết bạn mang về những nâng cấp cố định. Chiến đấu nhanh, nhiều loại vũ khí, kỹ năng và trùm đòi hỏi phản xạ tốt.\n\nNhà phát triển: Motion Twin. Nhà phát hành: Motion Twin. Phát hành trên Steam ngày 06/08/2018.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 24.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Motion Twin', NULL, 1, 1, '2026-10-10 03:17:29', '2026-11-04 01:17:30', '2026-11-04 01:17:30'),
(20, 58, 'Slay the Spire', 'slay-the-spire', 'Roguelike xây dựng bộ bài: chọn nhân vật, nhặt bài và cổ vật, leo lên đỉnh Tòa tháp qua những con đường khác nhau mỗi lần chơi.', 'Slay the Spire kết hợp lối chơi xây dựng bộ bài với cấu trúc roguelike. Bạn chọn một trong bốn nhân vật, mỗi nhân vật có bộ bài riêng, rồi leo lên Tòa tháp qua bản đồ được tạo ngẫu nhiên.\n\nTrên đường đi, bạn chọn thêm bài trong hơn 350 lá, thu thập cổ vật mạnh mẽ, gặp sự kiện bất ngờ và đối đầu quái vật, tinh anh và trùm. Mỗi trận đều là bài toán chiến thuật về năng lượng, phòng thủ và kết hợp bài.\n\nTrò chơi có hỗ trợ giao diện tiếng Việt.\n\nNhà phát triển: Mega Crit. Nhà phát hành: Mega Crit. Phát hành trên Steam ngày 23/01/2019.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 24.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Mega Crit', NULL, 1, 1, '2026-10-14 03:17:29', '2026-11-04 01:17:30', '2026-11-04 01:17:30'),
(21, 59, 'Terraria', 'terraria', 'Đào, chiến đấu, khám phá và xây dựng trong thế giới 2D được tạo ngẫu nhiên, từ mặt đất đến tận Địa ngục.', 'Mỗi thế giới Terraria được tạo ngẫu nhiên, với rừng, sa mạc, vùng tuyết, hang nấm phát sáng và những hòn đảo trên trời. Bạn đào tài nguyên, chế tạo vũ khí và áo giáp, xây nhà cho các NPC đến ở và chuẩn bị cho những trận đấu trùm ngày càng khó.\n\nCó thể chơi một mình hoặc cùng bạn bè. Trò chơi đã nhận nhiều bản cập nhật nội dung miễn phí kể từ khi ra mắt.\n\nNhà phát triển: Re-Logic. Nhà phát hành: Re-Logic. Phát hành trên Steam ngày 16/05/2011.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 9.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Re-Logic', NULL, 1, 1, '2026-10-18 03:17:29', '2026-11-04 01:17:30', '2026-11-04 01:17:30'),
(22, 60, 'A Short Hike', 'a-short-hike', 'Chuyến leo núi nhẹ nhàng tới đỉnh Hawk Peak: lượn, leo, câu cá và trò chuyện với những người bạn trong công viên.', 'Claire về nghỉ hè ở công viên Hawk Peak và cần lên đỉnh núi để có sóng điện thoại. Hành trình hoàn toàn do bạn quyết định: đi thẳng lên đỉnh, hoặc lang thang khám phá, đào kho báu, câu cá, chơi bóng chuyền bãi biển và giúp đỡ những người đi dạo khác.\n\nLông vũ vàng cho phép bạn leo vách đá và lượn xa hơn. Một trò chơi ngắn, thư giãn, với nhạc nền của Mark Sparling.\n\nNhà phát triển: adamgryu. Nhà phát hành: adamgryu. Phát hành trên Steam ngày 30/07/2019.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 7.99, NULL, 'USD', NULL, 'Bản quyền thương mại © adamgryu', NULL, 1, 1, '2026-10-22 03:17:29', '2026-11-04 01:17:30', '2026-11-04 01:17:30'),
(23, 61, 'Vampire Survivors', 'vampire-survivors', 'Sống sót trước hàng nghìn quái vật: vũ khí tự tấn công, bạn chỉ di chuyển, nhặt kinh nghiệm và chọn nâng cấp.', 'Vampire Survivors là trò chơi sinh tồn theo thời gian với yếu tố roguelite. Vũ khí tự động tấn công, việc của bạn là di chuyển giữa biển quái vật, nhặt đá kinh nghiệm và chọn nâng cấp sao cho đủ mạnh để trụ đến cuối màn.\n\nMỗi lượt chơi chỉ khoảng nửa giờ, có nhiều nhân vật, vũ khí tiến hóa, bản đồ và bí mật để mở khóa. Hỗ trợ chơi hợp tác tại chỗ tối đa 4 người.\n\nTrò chơi ra mắt trên itch.io ngày 31/03/2021, phát hành truy cập sớm trên Steam ngày 17/12/2021, bản 1.0 ngày 20/10/2022.\n\nNhà phát triển: poncle. Nhà phát hành: poncle. Phát hành trên Steam ngày 20/10/2022.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 4.99, NULL, 'USD', NULL, 'Bản quyền thương mại © poncle', NULL, 1, 1, '2026-10-26 02:17:29', '2026-11-04 01:17:30', '2026-11-04 01:17:30'),
(24, 62, 'Papers, Please', 'papers-please', 'Làm thanh tra xuất nhập cảnh ở trạm biên giới Grestin: kiểm tra giấy tờ, phát hiện gián điệp và cân nhắc giữa luật lệ với lương tâm.', 'Năm 1982, nước Arstotzka mở lại trạm biên giới Grestin sau chiến tranh với Kolechia. Bạn là thanh tra xuất nhập cảnh, mỗi ngày phải kiểm tra hộ chiếu, giấy phép và các quy định liên tục thay đổi để quyết định ai được nhập cảnh.\n\nKẻ buôn lậu, gián điệp và những người chạy trốn đều đi qua bàn của bạn. Lương ít ỏi phải nuôi cả gia đình, nên mỗi quyết định đều có cái giá của nó. Trò chơi có nhiều kết thúc tùy vào lựa chọn của bạn.\n\nNhà phát triển: Lucas Pope. Nhà phát hành: 3909. Phát hành trên Steam ngày 08/08/2013.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 9.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Lucas Pope', NULL, 1, 1, '2026-10-30 02:17:29', '2026-11-04 01:17:30', '2026-11-04 01:17:30'),
(25, 63, 'Inscryption', 'inscryption', 'Trò chơi bài roguelike u tối pha giải đố thoát phòng và kinh dị tâm lý, diễn ra trong căn chòi gỗ của một kẻ bí ẩn.', 'Bạn tỉnh dậy trong căn chòi gỗ tối, ngồi đối diện một kẻ chỉ lộ ra đôi mắt. Hắn bắt bạn chơi một ván bài: hiến tế lá này để triệu hồi lá khác, đi qua bản đồ rừng sâu và gom thêm lá bài mạnh hơn.\n\nGiữa các lượt, bạn có thể đứng dậy khám phá căn phòng, giải các câu đố ẩn để tìm lối thoát. Trò chơi còn nhiều bất ngờ về cốt truyện mà tốt nhất là tự trải nghiệm.\n\nNhà phát triển: Daniel Mullins Games. Nhà phát hành: Devolver Digital. Phát hành trên Steam ngày 19/10/2021.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 19.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Daniel Mullins Games', NULL, 1, 1, '2026-10-23 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(26, 64, 'Unpacking', 'unpacking', 'Giải đố thư giãn: mở từng thùng đồ, sắp xếp vào ngôi nhà mới và lần ra câu chuyện cuộc đời người chủ.', 'Unpacking kể chuyện mà không cần lời thoại. Mỗi màn là một lần chuyển nhà: bạn lấy từng món đồ ra khỏi thùng và đặt vào chỗ hợp lý trong phòng mới.\n\nQua những món đồ được mang theo hay bị bỏ lại, bạn dần hiểu cuộc sống của nhân vật qua nhiều năm. Đồ họa pixel chi tiết, âm thanh nhẹ nhàng và không giới hạn thời gian.\n\nNhà phát triển: Witch Beam. Nhà phát hành: Balor Games. Phát hành trên Steam ngày 01/11/2021.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 19.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Witch Beam', NULL, 1, 1, '2026-10-17 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(27, 65, 'Loop Hero', 'loop-hero', 'Người hùng tự đi vòng quanh một con đường; bạn đặt lá bài địa hình, quái và công trình để giúp anh mạnh lên.', 'Lich đã xóa sạch thế giới vào hư vô. Người hùng của bạn tự động đi theo một vòng lặp, chiến đấu với quái vật gặp trên đường. Việc của bạn là đặt các lá bài: núi, rừng, làng, nghĩa địa... để tạo tài nguyên và thử thách mới.\n\nSau mỗi chuyến đi, tài nguyên mang về dùng để xây dựng trại, mở khóa lớp nhân vật và lá bài mới. Đồ họa pixel gợi nhớ máy tính thập niên 80.\n\nNhà phát triển: Four Quarters. Nhà phát hành: Devolver Digital. Phát hành trên Steam ngày 04/03/2021.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 14.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Four Quarters', NULL, 1, 1, '2026-10-10 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(28, 66, 'DREDGE', 'dredge', 'Lái thuyền đánh cá khám phá quần đảo bí ẩn: câu cá, nâng cấp thuyền và tránh xa những gì ẩn dưới làn nước đêm.', 'Bạn là ngư dân mới đến quần đảo Marrows. Ban ngày bạn câu cá, bán hàng ở cảng, sắp xếp khoang chứa như trò ghép hình và nâng cấp thuyền để đi xa hơn.\n\nKhi đêm xuống, sương mù kéo đến và những sinh vật kỳ lạ xuất hiện. Một nhà sưu tập bí ẩn nhờ bạn trục vớt các món đồ dưới đáy biển, dẫn bạn vào câu chuyện đen tối của vùng biển này.\n\nNhà phát triển: Black Salt Games. Nhà phát hành: Team17. Phát hành trên Steam ngày 30/03/2023.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 24.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Black Salt Games', NULL, 1, 1, '2026-10-28 02:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(29, 67, 'FTL: Faster Than Light', 'ftl-faster-than-light', 'Chỉ huy phi thuyền và phi hành đoàn băng qua thiên hà ngẫu nhiên, mỗi chuyến đi là một lần sống còn.', 'Phi thuyền của bạn mang thông tin quan trọng cho Liên bang và phải chạy trước hạm đội nổi loạn. Bạn điều phối năng lượng cho khiên, vũ khí, động cơ, phân công thành viên sửa chữa, dập lửa và chống quân đột nhập.\n\nMỗi lần chơi là một thiên hà mới với các sự kiện ngẫu nhiên và lựa chọn khó. Chết là mất hết, nên mỗi quyết định đều đáng cân nhắc. Bản Advanced Edition miễn phí bổ sung thêm hệ thống, vũ khí và chủng tộc.\n\nNhà phát triển: Subset Games. Nhà phát hành: Subset Games. Phát hành trên Steam ngày 14/09/2012.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 9.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Subset Games', NULL, 1, 1, '2026-08-01 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(30, 68, 'Don\'t Starve', 'dont-starve', 'Sinh tồn khắc nghiệt trong thế giới hoang dã kỳ quái: kiếm ăn, chế tạo đồ và giữ tỉnh táo qua từng đêm.', 'Nhà khoa học Wilson bị kéo vào một thế giới lạ đầy sinh vật nguy hiểm. Bạn phải thu thập tài nguyên, chế tạo dụng cụ, đốt lửa qua đêm và giữ cho cả cơn đói lẫn sự tỉnh táo không cạn kiệt.\n\nThế giới được tạo ngẫu nhiên, đổi mùa và có nhiều nhân vật mở khóa với năng lực riêng. Phong cách vẽ tay mang màu sắc truyện cổ tích u tối.\n\nNhà phát triển: Klei Entertainment. Nhà phát hành: Klei Entertainment. Phát hành trên Steam ngày 23/04/2013.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 9.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Klei Entertainment', NULL, 1, 1, '2026-08-08 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(31, 69, 'Balatro', 'balatro', 'Roguelike xây dựng bộ bài dựa trên các tay bài poker, với những lá Joker tạo combo điểm số khổng lồ.', 'Mỗi vòng, bạn cần đạt đủ điểm bằng cách đánh các tay bài poker: đôi, thùng, sảnh... Tiền thưởng dùng để mua lá Joker thay đổi luật tính điểm, lá Tarot và hành tinh nâng cấp tay bài.\n\nChìa khóa là tìm ra sự kết hợp giữa các Joker để nhân điểm lên hàng triệu. Luật dễ hiểu nhưng chiều sâu chiến thuật rất lớn.\n\nNhà phát triển: LocalThunk. Nhà phát hành: Playstack. Phát hành trên Steam ngày 20/02/2024.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 14.99, NULL, 'USD', NULL, 'Bản quyền thương mại © LocalThunk', NULL, 1, 1, '2026-11-01 02:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(32, 70, 'Darkest Dungeon', 'darkest-dungeon', 'Nhập vai đánh theo lượt phong cách gothic, nơi các anh hùng không chỉ bị thương mà còn suy sụp tinh thần.', 'Bạn thừa kế một điền trang đã bị tổ tiên đánh thức thứ tà ác cổ xưa. Hãy tuyển mộ, huấn luyện và dẫn đội anh hùng vào các hầm ngục để tiêu diệt quái vật và giành lại vùng đất.\n\nNgoài máu, mỗi anh hùng còn có thanh căng thẳng. Khi quá tải, họ có thể hoảng loạn, ích kỷ hoặc bất ngờ trở nên kiên cường. Quản lý thị trấn, chữa bệnh và chấp nhận mất mát là một phần của trò chơi.\n\nNhà phát triển: Red Hook Studios. Nhà phát hành: Red Hook Studios. Phát hành trên Steam ngày 19/01/2016.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 24.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Red Hook Studios', NULL, 1, 1, '2026-09-05 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(33, 71, 'Cuphead', 'cuphead', 'Bắn súng chạy nhảy tập trung vào đánh trùm, với hoạt hình vẽ tay theo phong cách phim hoạt hình thập niên 1930.', 'Cuphead và Mugman thua bạc với Quỷ và phải đi thu nợ linh hồn khắp quần đảo Inkwell. Phần lớn trò chơi là các trận đánh trùm nhiều giai đoạn, xen kẽ vài màn chạy nhảy.\n\nToàn bộ hình ảnh được vẽ tay trên giấy, nền màu nước và nhạc jazz thu âm thật. Có thể chơi một mình hoặc hai người cùng màn hình.\n\nNhà phát triển: Studio MDHR Entertainment Inc.. Nhà phát hành: Studio MDHR Entertainment Inc.. Phát hành trên Steam ngày 29/09/2017.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 19.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Studio MDHR Entertainment Inc.', NULL, 1, 1, '2026-09-13 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(34, 72, 'RimWorld', 'rimworld', 'Mô phỏng thuộc địa khoa học viễn tưởng do một AI kể chuyện điều khiển, tạo ra những câu chuyện không bao giờ lặp lại.', 'Ba người sống sót sau vụ rơi tàu phải dựng thuộc địa trên một hành tinh xa xôi. Mỗi người có tính cách, kỹ năng, quá khứ và mối quan hệ riêng; họ có thể yêu nhau, cãi nhau hay suy sụp vì mất người thân.\n\nAI kể chuyện điều chỉnh sự kiện: cướp bóc, bệnh dịch, thời tiết khắc nghiệt hay thương nhân ghé thăm. Cộng đồng mod rất lớn giúp trò chơi gần như vô tận.\n\nNhà phát triển: Ludeon Studios. Nhà phát hành: Ludeon Studios. Phát hành trên Steam ngày 17/10/2018.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 34.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Ludeon Studios', NULL, 1, 1, '2026-08-26 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(35, 73, 'Enter the Gungeon', 'enter-the-gungeon', 'Bắn súng góc nhìn từ trên xuống kiểu bullet hell trong hầm ngục ngẫu nhiên, với hàng trăm khẩu súng kỳ quặc.', 'Một nhóm kẻ lạc loài xuống Gungeon để tìm khẩu súng có thể bắn chết quá khứ. Mỗi tầng hầm được tạo ngẫu nhiên, đầy quái vật hình viên đạn và trùm bắn đạn kín màn hình.\n\nBạn né bằng cú lộn người, lật bàn làm chỗ nấp và thu thập hàng trăm khẩu súng cùng vật phẩm. Có chế độ hai người chơi cùng máy.\n\nNhà phát triển: Dodge Roll. Nhà phát hành: Devolver Digital. Phát hành trên Steam ngày 05/04/2016.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 14.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Dodge Roll', NULL, 1, 1, '2026-09-01 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(36, 74, 'UNDERTALE', 'undertale', 'Nhập vai nơi bạn không cần giết ai: mỗi trận chiến có thể kết thúc bằng lòng tốt, và quái vật nhớ những gì bạn làm.', 'Một đứa trẻ rơi xuống Thế giới Ngầm, nơi quái vật bị phong ấn sau cuộc chiến với loài người. Trên đường tìm về nhà, bạn gặp đủ kiểu quái vật kỳ quặc và đáng yêu.\n\nMỗi trận đấu kết hợp né đạn và các lựa chọn hành động: bạn có thể đánh, trò chuyện, khen ngợi hay tha thứ. Lựa chọn của bạn thay đổi câu chuyện và cái kết.\n\nNhà phát triển: tobyfox. Nhà phát hành: tobyfox. Phát hành trên Steam ngày 15/09/2015.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 9.99, NULL, 'USD', NULL, 'Bản quyền thương mại © tobyfox', NULL, 1, 1, '2026-08-16 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(37, 75, 'Factorio', 'factorio', 'Xây dựng và tự động hóa nhà máy ngày càng phức tạp trên một hành tinh xa lạ, rồi bảo vệ nó khỏi sinh vật bản địa.', 'Sau khi rơi tàu xuống một hành tinh lạ, bạn bắt đầu bằng việc đào quặng bằng tay. Dần dần bạn đặt máy khai thác, băng chuyền, lò luyện và dây chuyền lắp ráp để tự động hóa mọi thứ, mục tiêu cuối cùng là phóng tên lửa.\n\nÔ nhiễm từ nhà máy thu hút sinh vật bản địa tấn công, nên bạn cần cả phòng thủ. Có chế độ nhiều người chơi hợp tác và cộng đồng mod rất phong phú.\n\nNhà phát triển: Wube Software LTD.. Nhà phát hành: Wube Software LTD.. Phát hành trên Steam ngày 14/08/2020.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 35.00, NULL, 'USD', NULL, 'Bản quyền thương mại © Wube Software LTD.', NULL, 1, 1, '2026-09-20 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(38, 68, 'Oxygen Not Included', 'oxygen-not-included', 'Mô phỏng thuộc địa trong lòng tiểu hành tinh: quản lý oxy, nhiệt độ, nước và áp suất để nhóm Duplicant sống sót.', 'Nhóm Duplicant thức dậy bên trong một tiểu hành tinh. Bạn đào hầm, xây phòng, sản xuất oxy và thức ăn, đồng thời cân bằng nhiệt, khí và chất lỏng theo mô phỏng vật lý khá chi tiết.\n\nKhi thuộc địa ổn định, bạn nghiên cứu công nghệ mới, xây hệ thống ống dẫn tự động và cuối cùng là tên lửa để khám phá không gian.\n\nNhà phát triển: Klei Entertainment. Nhà phát hành: Klei Entertainment. Phát hành trên Steam ngày 30/07/2019.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 24.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Klei Entertainment', NULL, 1, 1, '2026-09-07 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(39, 76, 'Katana ZERO', 'katana-zero', 'Hành động chạy nhảy neo-noir: một nhát chém là chết, làm chậm thời gian và lần lại quá khứ của sát thủ mất trí nhớ.', 'Bạn là sát thủ cầm kiếm nhận nhiệm vụ từ bác sĩ tâm lý của mình. Mỗi màn là một kế hoạch mà bạn hình dung trước khi thực hiện: một đòn của kẻ địch là đủ hạ gục bạn, và bạn cũng vậy.\n\nKhả năng làm chậm thời gian, chém bật đạn và lựa chọn trong hội thoại giúp câu chuyện rẽ hướng. Đồ họa pixel và nhạc synthwave tạo không khí điện ảnh.\n\nNhà phát triển: Askiisoft. Nhà phát hành: Devolver Digital. Phát hành trên Steam ngày 18/04/2019.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 14.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Askiisoft', NULL, 1, 1, '2026-09-25 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(40, 77, 'Night in the Woods', 'night-in-the-woods', 'Phiêu lưu giàu cốt truyện về Mae, cô mèo bỏ học về lại thị trấn mỏ đang lụi tàn và gặp lại bạn bè cũ.', 'Mae Borowski bỏ đại học và trở về Possum Springs, thị trấn khai mỏ nơi cô lớn lên. Mọi thứ đã thay đổi: bạn bè đã đi làm, cửa hàng đóng cửa, và có điều gì đó lạ đang xảy ra trong rừng.\n\nBạn dạo quanh thị trấn, trò chuyện với cư dân, chơi nhạc cùng ban nhạc và chọn dành thời gian cho ai mỗi ngày. Trò chơi nói về tuổi trẻ, sức khỏe tinh thần và những nơi bị bỏ lại.\n\nNhà phát triển: Infinite Fall. Nhà phát hành: Finji. Phát hành trên Steam ngày 21/02/2017.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 19.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Infinite Fall', NULL, 1, 1, '2026-08-20 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(41, 78, 'TUNIC', 'tunic', 'Phiêu lưu hành động góc nhìn isometric về chú cáo nhỏ trong thế giới đầy bí ẩn, dẫn đường bằng những trang sổ tay rơi rớt.', 'Một chú cáo nhỏ tỉnh dậy trên bờ biển của vùng đất lạ. Không có hướng dẫn rõ ràng: bạn nhặt từng trang sổ tay viết bằng ngôn ngữ bí ẩn để hiểu cách chơi và tìm ra bí mật của thế giới.\n\nChiến đấu đòi hỏi né đỡ chính xác, còn khám phá thưởng cho người tò mò bằng lối đi ẩn và câu đố sâu.\n\nNhà phát triển: TUNIC Team. Nhà phát hành: Finji. Phát hành trên Steam ngày 16/03/2022.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 29.99, NULL, 'USD', NULL, 'Bản quyền thương mại © TUNIC Team', NULL, 1, 1, '2026-10-13 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(42, 67, 'Into the Breach', 'into-the-breach', 'Chiến thuật theo lượt: điều khiển robot chiến đấu từ tương lai, thấy trước đòn của quái vật và tìm cách cứu thành phố.', 'Quái vật Vek trồi lên từ lòng đất. Bạn chỉ huy đội ba robot du hành thời gian để bảo vệ các thành phố trên những bản đồ nhỏ 8x8.\n\nMọi đòn tấn công của địch đều được báo trước, nên mỗi lượt là một câu đố: đẩy, chặn hay đổi hướng để không công trình nào bị phá. Thua thì gửi một phi công về dòng thời gian khác và thử lại.\n\nNhà phát triển: Subset Games. Nhà phát hành: Subset Games. Phát hành trên Steam ngày 27/02/2018.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 14.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Subset Games', NULL, 1, 1, '2026-10-01 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(43, 62, 'Return of the Obra Dinn', 'return-of-the-obra-dinn', 'Trinh thám hai tông màu: lên con tàu ma năm 1803 và suy luận số phận của cả 60 thủy thủ.', 'Năm 1803, tàu buôn Obra Dinn mất tích. Năm 1807, nó trôi về cảng mà không còn ai sống sót. Bạn là thanh tra bảo hiểm được cử lên tàu.\n\nVới chiếc đồng hồ bỏ túi có thể tái hiện khoảnh khắc chết của mỗi người, bạn quan sát chi tiết, đối chiếu sổ ghi chép và suy luận danh tính, nguyên nhân cái chết của từng thủy thủ. Đồ họa đơn sắc gợi nhớ máy tính thời đầu.\n\nNhà phát triển: Lucas Pope. Nhà phát hành: 3909. Phát hành trên Steam ngày 18/10/2018.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 19.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Lucas Pope', NULL, 1, 1, '2026-08-12 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(44, 79, 'Baba Is You', 'baba-is-you', 'Giải đố bằng cách đẩy các khối chữ để thay đổi chính luật chơi: BABA IS YOU, WALL IS STOP, FLAG IS WIN.', 'Trong mỗi màn, luật chơi được viết bằng những khối chữ nằm ngay trên bản đồ. Đẩy chúng để tạo câu mới: biến tường thành thứ đi xuyên được, biến chính bạn thành tảng đá, hay biến lá cờ thành chiến thắng.\n\nHơn 200 màn với ý tưởng ngày càng bất ngờ. Có trình tạo màn và thư viện màn chơi do cộng đồng chia sẻ.\n\nNhà phát triển: Hempuli Oy. Nhà phát hành: Hempuli Oy. Phát hành trên Steam ngày 13/03/2019.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 14.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Hempuli Oy', NULL, 1, 1, '2026-10-05 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(45, 80, 'Outer Wilds', 'outer-wilds', 'Khám phá thế giới mở trong một hệ mặt trời bị kẹt trong vòng lặp 22 phút trước khi mặt trời phát nổ.', 'Bạn là phi hành gia tân binh của chương trình không gian Outer Wilds Ventures. Mỗi 22 phút mặt trời lại phát nổ, và bạn thức dậy bên đống lửa trại như chưa có gì xảy ra.\n\nThứ duy nhất được giữ lại là hiểu biết. Bạn tự do bay tới các hành tinh, đọc dấu tích của một nền văn minh cổ và lần ra nguyên nhân của vòng lặp.\n\nNhà phát triển: Mobius Digital. Nhà phát hành: Annapurna Interactive. Phát hành trên Steam ngày 18/06/2020.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 24.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Mobius Digital', NULL, 1, 1, '2026-09-09 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(46, 81, 'Spiritfarer: Farewell Edition', 'spiritfarer', 'Quản lý thư giãn về cái chết: làm người chèo đò, xây thuyền, chăm sóc các linh hồn và tiễn họ sang thế giới bên kia.', 'Stella nhận vai trò người chèo đò đưa linh hồn qua thế giới bên kia. Bạn xây dựng và mở rộng con thuyền, trồng trọt, nấu ăn, câu cá và chăm sóc từng hành khách theo cách họ thích.\n\nKhi đã sẵn sàng, mỗi linh hồn sẽ nói lời tạm biệt. Bản Farewell Edition gồm trò chơi gốc và ba bản cập nhật nội dung lớn; có thể chơi hai người cùng máy.\n\nNhà phát triển: Thunder Lotus. Nhà phát hành: Thunder Lotus. Phát hành trên Steam ngày 18/08/2020.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Giao dịch trên nền tảng này chỉ chạy trong môi trường thử nghiệm (sandbox), không cấp bản quyền và không cung cấp tệp trò chơi thật. Hãy mua bản chính thức trên Steam để ủng hộ nhà phát triển.', 'game', 'published', 'released', 'paid', 29.99, NULL, 'USD', NULL, 'Bản quyền thương mại © Thunder Lotus', NULL, 1, 1, '2026-10-20 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(47, 82, 'Warzone 2100', 'warzone-2100', 'Chiến thuật thời gian thực hậu tận thế: tự thiết kế xe chiến đấu, nghiên cứu hơn 400 công nghệ và tái thiết thế giới.', 'Cuối thế kỷ 21, một loạt tấn công hạt nhân xóa sổ nền văn minh. Bạn chỉ huy lực lượng Project, đi qua ba chiến dịch để tái thiết thế giới và chống lại các phe đối địch.\n\nĐiểm đặc biệt là hệ thống thiết kế xe: ghép thân, động cơ di chuyển và vũ khí theo ý mình. Trò chơi gốc của Pumpkin Studios (1999) được công bố mã nguồn năm 2004 và cộng đồng vẫn phát triển tới nay, có chơi mạng và giao tranh với máy.\n\nNhà phát triển: Pumpkin Studios, Underdone Gaming, Warzone 2100 Project. Nhà phát hành: Underdone Gaming. Phát hành trên Steam ngày 18/02/2020.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Trò chơi này do nhà phát triển phát hành miễn phí; nút “Chơi / tải về” dẫn tới trang chính thức, nền tảng không lưu trữ hay phân phối lại tệp trò chơi.', 'game', 'published', 'released', 'free', 0.00, NULL, 'USD', NULL, 'GNU GPL phiên bản 2 trở lên (mã nguồn mở)', 'https://wz2100.net', 1, 1, '2026-07-27 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(48, 83, 'Muck', 'muck', 'Sinh tồn roguelike đồ họa low-poly: thu thập tài nguyên, chế tạo đồ, xây căn cứ và sống sót qua từng đêm cùng bạn bè.', 'Bạn tỉnh dậy trên một hòn đảo được tạo ngẫu nhiên. Ban ngày chặt cây, đào đá, săn bắt và chế tạo vũ khí; ban đêm quái vật kéo đến ngày một đông.\n\nMục tiêu là sống sót càng lâu càng tốt, tìm vật phẩm mạnh trong rương và đánh bại trùm. Hỗ trợ chơi hợp tác trực tuyến cùng bạn bè.\n\nNhà phát triển: Dani. Nhà phát hành: Dani. Phát hành trên Steam ngày 05/06/2021.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Trò chơi này do nhà phát triển phát hành miễn phí; nút “Chơi / tải về” dẫn tới trang chính thức, nền tảng không lưu trữ hay phân phối lại tệp trò chơi.', 'game', 'published', 'released', 'free', 0.00, NULL, 'USD', NULL, 'Miễn phí, bản quyền © Dani', 'https://store.steampowered.com/app/1625450/', 1, 1, '2026-10-15 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(49, 84, 'Unturned', 'unturned', 'Sinh tồn thế giới mở giữa đại dịch zombie, đồ họa khối vuông, chơi một mình hoặc trên máy chủ cùng nhiều người.', 'Là một trong số ít người chưa bị biến thành zombie, bạn lục lọi nhà cửa tìm đồ ăn, vũ khí và dụng cụ, rồi xây nơi trú ẩn để sống sót.\n\nTrò chơi có nhiều bản đồ chính thức, chế độ chơi mạng với máy chủ cộng đồng và Steam Workshop để tải bản đồ, vật phẩm do người chơi làm.\n\nNhà phát triển: Smartly Dressed Games. Nhà phát hành: Smartly Dressed Games. Phát hành trên Steam ngày 07/07/2017.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Trò chơi này do nhà phát triển phát hành miễn phí; nút “Chơi / tải về” dẫn tới trang chính thức, nền tảng không lưu trữ hay phân phối lại tệp trò chơi.', 'game', 'published', 'released', 'free', 0.00, NULL, 'USD', NULL, 'Miễn phí, bản quyền © Smartly Dressed Games', 'https://smartlydressedgames.com/unturned/', 1, 1, '2026-08-06 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(50, 85, 'Zero-K', 'zero-k', 'Chiến thuật thời gian thực quy mô lớn với hơn 100 loại đơn vị, địa hình biến dạng được và chiến dịch chơi đơn hoặc hợp tác.', 'Zero-K là trò chơi RTS miễn phí, mã nguồn mở, được cộng đồng phát triển và tinh chỉnh hơn một thập kỷ. Đơn vị có đường đạn mô phỏng vật lý, và bạn có thể đào hay đắp địa hình để tạo pháo đài.\n\nCó chiến dịch dài chơi đơn hoặc hợp tác, đấu 1 chọi 1 xếp hạng và những trận lớn tới 32 người trên hàng trăm bản đồ.\n\nNhà phát triển: Zero-K Team. Nhà phát hành: Zero-K Team. Phát hành trên Steam ngày 27/04/2018.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Trò chơi này do nhà phát triển phát hành miễn phí; nút “Chơi / tải về” dẫn tới trang chính thức, nền tảng không lưu trữ hay phân phối lại tệp trò chơi.', 'game', 'published', 'released', 'free', 0.00, NULL, 'USD', NULL, 'GNU GPL phiên bản 2 (mã nguồn mở)', 'https://zero-k.info', 1, 1, '2026-07-22 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(51, 86, 'Teeworlds', 'teeworlds', 'Bắn súng 2D trực tuyến tối đa 16 người, với móc kéo, nhiều chế độ chơi và trình tạo bản đồ.', 'Teeworlds là trò chơi bắn súng đối kháng 2D nhịp nhanh. Những nhân vật tròn nhỏ dùng móc kéo để đu qua bản đồ, nhặt súng và đấu các chế độ Deathmatch, Team Deathmatch và Capture The Flag.\n\nTrò chơi miễn phí, mã nguồn mở, có trình chỉnh sửa bản đồ và rất nhiều máy chủ do cộng đồng vận hành.\n\nNhà phát triển: Teeworlds Team. Nhà phát hành: Teeworlds Team. Phát hành trên Steam ngày 24/08/2015.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Trò chơi này do nhà phát triển phát hành miễn phí; nút “Chơi / tải về” dẫn tới trang chính thức, nền tảng không lưu trữ hay phân phối lại tệp trò chơi.', 'game', 'published', 'released', 'free', 0.00, NULL, 'USD', NULL, 'Mã nguồn theo giấy phép kiểu zlib, dữ liệu đồ họa theo CC BY-SA 3.0 (mã nguồn mở)', 'https://www.teeworlds.com/', 1, 1, '2026-07-17 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(52, 87, 'Endless Sky', 'endless-sky', 'Buôn bán và chiến đấu ngoài không gian 2D: bắt đầu với một tàu nhỏ, kiếm tiền và xây dựng hạm đội của riêng mình.', 'Lấy cảm hứng từ dòng game Escape Velocity, Endless Sky cho bạn tự do bay giữa các hệ sao: chở hàng, săn tiền thưởng, hộ tống hay cướp tàu. Tiền kiếm được dùng để mua tàu mới và lắp vũ khí, động cơ, khiên.\n\nCốt truyện chính đưa bạn vào cuộc nội chiến của loài người và gặp gỡ nhiều chủng tộc ngoài hành tinh. Trò chơi miễn phí, mã nguồn mở và hỗ trợ plugin.\n\nNhà phát triển: Michael Zahniser. Nhà phát hành: Michael Zahniser. Phát hành trên Steam ngày 30/10/2015.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Trò chơi này do nhà phát triển phát hành miễn phí; nút “Chơi / tải về” dẫn tới trang chính thức, nền tảng không lưu trữ hay phân phối lại tệp trò chơi.', 'game', 'published', 'released', 'free', 0.00, NULL, 'USD', NULL, 'GNU GPL phiên bản 3 (mã nguồn mở)', 'https://endless-sky.github.io/', 1, 1, '2026-07-12 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(53, 88, 'Emily is Away', 'emily-is-away', 'Câu chuyện tương tác qua khung chat kiểu máy tính đầu những năm 2000, theo dõi một tình bạn qua năm năm.', 'Trò chơi diễn ra hoàn toàn trong một ứng dụng nhắn tin giả lập phong cách đầu thập niên 2000. Bạn chọn tên hiển thị và trò chuyện với Emily qua năm năm học trung học và đại học.\n\nMỗi lựa chọn câu trả lời ảnh hưởng tới mối quan hệ. Trò chơi ngắn, chơi trong khoảng một giờ.\n\nNhà phát triển: Kyle Seeley. Nhà phát hành: Kyle Seeley. Phát hành trên Steam ngày 20/11/2015.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Trò chơi này do nhà phát triển phát hành miễn phí; nút “Chơi / tải về” dẫn tới trang chính thức, nền tảng không lưu trữ hay phân phối lại tệp trò chơi.', 'game', 'published', 'released', 'free', 0.00, NULL, 'USD', NULL, 'Miễn phí, bản quyền © Kyle Seeley', 'http://emilyisaway.com/', 1, 1, '2026-10-09 03:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(54, 89, 'Super Animal Royale', 'super-animal-royale', 'Battle royale 2D góc nhìn từ trên xuống cho 64 người chơi, nơi những con thú dễ thương đấu súng tới người cuối cùng.', '64 con thú nhảy dù xuống đảo, nhặt vũ khí, giáp và đấu tới khi chỉ còn một người. Có chế độ chơi đơn, đôi và đội bốn người.\n\nNgoài trận đấu còn có khu vực Super Animal World để câu cá, đua bóng hamster và làm nhiệm vụ. Trò chơi miễn phí; vật phẩm trả phí chỉ để trang trí.\n\nNhà phát triển: Pixile. Nhà phát hành: Pixile. Phát hành trên Steam ngày 26/08/2021.\n\nLưu ý: đây là trang giới thiệu trong một dự án học tập không công khai. Trò chơi này do nhà phát triển phát hành miễn phí; nút “Chơi / tải về” dẫn tới trang chính thức, nền tảng không lưu trữ hay phân phối lại tệp trò chơi.', 'game', 'published', 'released', 'free', 0.00, NULL, 'USD', NULL, 'Miễn phí, bản quyền © Pixile', 'https://animalroyale.com', 1, 1, '2026-10-25 02:50:05', '2026-11-04 01:50:07', '2026-11-04 01:50:07'),
(78, 171, 'Tinh Hoa Đường Sơn', 'du-mau-nhieu-link-tai-ve', 'Game mẫu dùng để minh hoạ tính năng nhiều link tải về.', 'Dự án demo của Minh Khang Studio. Trò chơi chạy thẳng trên trình duyệt, đồng thời mỗi phiên bản phát hành đều có nhiều nguồn tải từ Google Drive, OneDrive, Dropbox, MediaFire, MEGA... Người chơi đã sở hữu có thể chơi ngay trên web hoặc tải bản cài đặt.', 'game', 'published', 'released', 'paid', 4.99, NULL, 'USD', NULL, NULL, 'https://example.com/tinh-hoa-duong-son/choi', 1, 1, '2026-11-01 10:00:00', '2026-11-01 08:30:00', '2026-11-01 08:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `tro_choi_bo_suu_tap`
--

CREATE TABLE `tro_choi_bo_suu_tap` (
  `bo_suu_tap_id` bigint(20) UNSIGNED NOT NULL,
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `nguoi_them_id` bigint(20) UNSIGNED NOT NULL,
  `vi_tri` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `ghi_chu` varchar(500) DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tro_choi_bo_suu_tap`
--

INSERT INTO `tro_choi_bo_suu_tap` (`bo_suu_tap_id`, `tro_choi_id`, `nguoi_them_id`, `vi_tri`, `ghi_chu`, `ngay_tao`) VALUES
(3, 6, 17, 1, NULL, '2026-09-10 01:27:00'),
(3, 7, 17, 0, NULL, '2026-09-10 01:27:00'),
(3, 37, 17, 2, NULL, '2026-09-10 01:27:00'),
(3, 44, 17, 3, 'Luật chơi chính là các khối chữ, đáng xem để hiểu thiết kế giải đố.', '2026-09-10 01:27:00'),
(3, 52, 17, 4, NULL, '2026-09-10 01:27:00'),
(4, 15, 18, 0, NULL, '2026-09-17 15:17:00'),
(4, 17, 18, 1, NULL, '2026-09-17 15:17:00'),
(4, 19, 18, 2, NULL, '2026-09-17 15:17:00'),
(4, 21, 18, 5, NULL, '2026-09-17 15:17:00'),
(4, 22, 18, 4, NULL, '2026-09-17 15:17:00'),
(4, 39, 18, 3, NULL, '2026-09-17 15:17:00'),
(5, 4, 19, 0, 'Có chế độ chia màn hình và chơi trực tuyến.', '2026-08-31 03:56:00'),
(5, 9, 19, 1, NULL, '2026-08-31 03:56:00'),
(5, 49, 19, 4, NULL, '2026-08-31 03:56:00'),
(5, 51, 19, 2, NULL, '2026-08-31 03:56:00'),
(5, 54, 19, 3, NULL, '2026-08-31 03:56:00'),
(6, 3, 20, 0, NULL, '2026-10-10 02:10:00'),
(6, 7, 20, 3, NULL, '2026-10-10 02:10:00'),
(6, 47, 20, 1, NULL, '2026-10-10 02:10:00'),
(6, 50, 20, 2, NULL, '2026-10-10 02:10:00'),
(7, 15, 21, 0, NULL, '2026-09-13 03:51:00'),
(7, 22, 21, 1, NULL, '2026-09-13 03:51:00'),
(7, 26, 21, 2, NULL, '2026-09-13 03:51:00'),
(7, 40, 21, 4, NULL, '2026-09-13 03:51:00'),
(7, 46, 21, 3, NULL, '2026-09-13 03:51:00'),
(8, 6, 22, 5, NULL, '2026-09-07 10:33:00'),
(8, 7, 22, 4, NULL, '2026-09-07 10:33:00'),
(8, 8, 22, 0, 'Miễn phí, mã nguồn mở, chạy được cả trên máy yếu.', '2026-09-07 10:33:00'),
(8, 34, 22, 2, NULL, '2026-09-07 10:33:00'),
(8, 37, 22, 1, NULL, '2026-09-07 10:33:00'),
(8, 38, 22, 3, NULL, '2026-09-07 10:33:00'),
(9, 16, 23, 1, NULL, '2026-08-28 08:46:00'),
(9, 33, 23, 0, 'Hoạt hình vẽ tay theo phong cách thập niên 1930.', '2026-08-28 08:46:00'),
(9, 40, 23, 4, NULL, '2026-08-28 08:46:00'),
(9, 41, 23, 3, NULL, '2026-08-28 08:46:00'),
(9, 46, 23, 2, NULL, '2026-08-28 08:46:00'),
(10, 9, 24, 0, NULL, '2026-10-07 13:05:00'),
(10, 23, 24, 4, NULL, '2026-10-07 13:05:00'),
(10, 35, 24, 2, NULL, '2026-10-07 13:05:00'),
(10, 39, 24, 3, NULL, '2026-10-07 13:05:00'),
(10, 51, 24, 1, NULL, '2026-10-07 13:05:00'),
(11, 24, 25, 4, NULL, '2026-09-01 01:56:00'),
(11, 36, 25, 0, NULL, '2026-09-01 01:56:00'),
(11, 40, 25, 1, NULL, '2026-09-01 01:56:00'),
(11, 43, 25, 3, NULL, '2026-09-01 01:56:00'),
(11, 45, 25, 2, NULL, '2026-09-01 01:56:00'),
(11, 53, 25, 5, NULL, '2026-09-01 01:56:00'),
(12, 5, 26, 4, NULL, '2026-09-28 01:08:00'),
(12, 6, 26, 0, NULL, '2026-09-28 01:08:00'),
(12, 21, 26, 1, NULL, '2026-09-28 01:08:00'),
(12, 30, 26, 5, NULL, '2026-09-28 01:08:00'),
(12, 34, 26, 2, NULL, '2026-09-28 01:08:00'),
(12, 37, 26, 3, NULL, '2026-09-28 01:08:00'),
(13, 15, 27, 0, NULL, '2026-09-17 03:45:00'),
(13, 22, 27, 2, NULL, '2026-09-17 03:45:00'),
(13, 26, 27, 1, NULL, '2026-09-17 03:45:00'),
(13, 46, 27, 3, NULL, '2026-09-17 03:45:00'),
(14, 5, 28, 0, NULL, '2026-09-18 02:55:00'),
(14, 10, 28, 1, NULL, '2026-09-18 02:55:00'),
(14, 20, 28, 3, NULL, '2026-09-18 02:55:00'),
(14, 32, 28, 4, NULL, '2026-09-18 02:55:00'),
(14, 42, 28, 2, 'Mỗi lượt đều thấy trước đòn tấn công của đối phương.', '2026-09-18 02:55:00'),
(15, 16, 29, 3, NULL, '2026-08-30 03:12:00'),
(15, 17, 29, 0, NULL, '2026-08-30 03:12:00'),
(15, 18, 29, 1, NULL, '2026-08-30 03:12:00'),
(15, 33, 29, 4, NULL, '2026-08-30 03:12:00'),
(15, 36, 29, 2, NULL, '2026-08-30 03:12:00'),
(15, 45, 29, 5, NULL, '2026-08-30 03:12:00'),
(16, 7, 30, 1, NULL, '2026-10-01 06:46:00'),
(16, 8, 30, 4, NULL, '2026-10-01 06:46:00'),
(16, 34, 30, 3, NULL, '2026-10-01 06:46:00'),
(16, 37, 30, 0, NULL, '2026-10-01 06:46:00'),
(16, 38, 30, 2, NULL, '2026-10-01 06:46:00'),
(17, 5, 31, 3, NULL, '2026-09-09 08:07:00'),
(17, 8, 31, 0, NULL, '2026-09-09 08:07:00'),
(17, 10, 31, 1, NULL, '2026-09-09 08:07:00'),
(17, 47, 31, 4, NULL, '2026-09-09 08:07:00'),
(17, 51, 31, 2, NULL, '2026-09-09 08:07:00'),
(18, 16, 32, 1, NULL, '2026-08-29 12:04:00'),
(18, 17, 32, 0, NULL, '2026-08-29 12:04:00'),
(18, 19, 32, 4, NULL, '2026-08-29 12:04:00'),
(18, 33, 32, 3, NULL, '2026-08-29 12:04:00'),
(18, 39, 32, 2, NULL, '2026-08-29 12:04:00'),
(19, 36, 33, 2, NULL, '2026-09-12 08:33:00'),
(19, 40, 33, 1, NULL, '2026-09-12 08:33:00'),
(19, 45, 33, 4, NULL, '2026-09-12 08:33:00'),
(19, 46, 33, 0, NULL, '2026-09-12 08:33:00'),
(19, 53, 33, 3, NULL, '2026-09-12 08:33:00'),
(20, 3, 34, 0, NULL, '2026-08-29 04:34:00'),
(20, 4, 34, 1, NULL, '2026-08-29 04:34:00'),
(20, 5, 34, 2, NULL, '2026-08-29 04:34:00'),
(20, 6, 34, 3, NULL, '2026-08-29 04:34:00'),
(20, 7, 34, 4, NULL, '2026-08-29 04:34:00'),
(20, 8, 34, 5, NULL, '2026-08-29 04:34:00'),
(20, 9, 34, 6, NULL, '2026-08-29 04:34:00'),
(20, 10, 34, 7, NULL, '2026-08-29 04:34:00'),
(21, 20, 35, 2, NULL, '2026-10-04 12:55:00'),
(21, 22, 35, 4, NULL, '2026-10-04 12:55:00'),
(21, 23, 35, 0, NULL, '2026-10-04 12:55:00'),
(21, 31, 35, 1, NULL, '2026-10-04 12:55:00'),
(21, 44, 35, 3, NULL, '2026-10-04 12:55:00'),
(22, 3, 36, 1, NULL, '2026-09-05 05:04:00'),
(22, 5, 36, 2, NULL, '2026-09-05 05:04:00'),
(22, 10, 36, 0, NULL, '2026-09-05 05:04:00'),
(22, 34, 36, 3, NULL, '2026-09-05 05:04:00'),
(23, 4, 37, 0, NULL, '2026-09-24 01:30:00'),
(23, 6, 37, 1, NULL, '2026-09-24 01:30:00'),
(23, 22, 37, 3, NULL, '2026-09-24 01:30:00'),
(23, 41, 37, 2, NULL, '2026-09-24 01:30:00'),
(23, 48, 37, 4, NULL, '2026-09-24 01:30:00'),
(24, 3, 38, 4, NULL, '2026-08-27 01:18:00'),
(24, 4, 38, 0, NULL, '2026-08-27 01:18:00'),
(24, 8, 38, 3, NULL, '2026-08-27 01:18:00'),
(24, 9, 38, 1, 'Nhớ cài sẵn bản mới nhất trước buổi chơi.', '2026-08-27 01:18:00'),
(24, 51, 38, 2, NULL, '2026-08-27 01:18:00'),
(25, 18, 39, 0, NULL, '2026-10-05 15:02:00'),
(25, 19, 39, 1, NULL, '2026-10-05 15:02:00'),
(25, 20, 39, 2, NULL, '2026-10-05 15:02:00'),
(25, 27, 39, 5, NULL, '2026-10-05 15:02:00'),
(25, 35, 39, 3, NULL, '2026-10-05 15:02:00'),
(25, 42, 39, 4, NULL, '2026-10-05 15:02:00'),
(26, 16, 40, 0, NULL, '2026-10-03 03:03:00'),
(26, 18, 40, 2, NULL, '2026-10-03 03:03:00'),
(26, 19, 40, 3, NULL, '2026-10-03 03:03:00'),
(26, 33, 40, 1, NULL, '2026-10-03 03:03:00'),
(27, 24, 41, 2, NULL, '2026-10-12 11:10:00'),
(27, 25, 41, 4, NULL, '2026-10-12 11:10:00'),
(27, 43, 41, 1, NULL, '2026-10-12 11:10:00'),
(27, 44, 41, 0, NULL, '2026-10-12 11:10:00'),
(27, 45, 41, 3, NULL, '2026-10-12 11:10:00'),
(28, 7, 42, 5, NULL, '2026-09-12 07:20:00'),
(28, 47, 42, 0, NULL, '2026-09-12 07:20:00'),
(28, 49, 42, 1, NULL, '2026-09-12 07:20:00'),
(28, 50, 42, 2, NULL, '2026-09-12 07:20:00'),
(28, 52, 42, 3, NULL, '2026-09-12 07:20:00'),
(28, 54, 42, 4, NULL, '2026-09-12 07:20:00'),
(29, 28, 43, 3, NULL, '2026-09-24 13:42:00'),
(29, 41, 43, 0, NULL, '2026-09-24 13:42:00'),
(29, 45, 43, 1, NULL, '2026-09-24 13:42:00'),
(29, 46, 43, 2, NULL, '2026-09-24 13:42:00'),
(30, 21, 44, 4, NULL, '2026-08-28 15:16:00'),
(30, 30, 44, 0, NULL, '2026-08-28 15:16:00'),
(30, 34, 44, 1, NULL, '2026-08-28 15:16:00'),
(30, 38, 44, 2, NULL, '2026-08-28 15:16:00'),
(30, 49, 44, 3, NULL, '2026-08-28 15:16:00'),
(31, 15, 45, 3, 'Bản cập nhật 1.5 thêm Đảo Gừng.', '2026-10-12 12:24:00'),
(31, 22, 45, 2, NULL, '2026-10-12 12:24:00'),
(31, 28, 45, 0, NULL, '2026-10-12 12:24:00'),
(31, 46, 45, 1, NULL, '2026-10-12 12:24:00'),
(32, 16, 46, 4, NULL, '2026-09-19 13:04:00'),
(32, 25, 46, 3, NULL, '2026-09-19 13:04:00'),
(32, 28, 46, 0, NULL, '2026-09-19 13:04:00'),
(32, 32, 46, 1, NULL, '2026-09-19 13:04:00'),
(32, 43, 46, 2, NULL, '2026-09-19 13:04:00'),
(33, 29, 47, 1, NULL, '2026-10-01 07:14:00'),
(33, 45, 47, 2, NULL, '2026-10-01 07:14:00'),
(33, 52, 47, 0, NULL, '2026-10-01 07:14:00');

-- --------------------------------------------------------

--
-- Table structure for table `tro_choi_giam_gia`
--

CREATE TABLE `tro_choi_giam_gia` (
  `chien_dich_id` bigint(20) UNSIGNED NOT NULL,
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tro_choi_giam_gia`
--

INSERT INTO `tro_choi_giam_gia` (`chien_dich_id`, `tro_choi_id`) VALUES
(2, 15),
(2, 16),
(2, 17),
(2, 18),
(3, 19),
(3, 20),
(3, 27),
(3, 35),
(4, 21),
(4, 22),
(4, 23),
(4, 24),
(4, 29),
(4, 30),
(5, 20),
(5, 32),
(5, 34),
(5, 42),
(6, 36),
(6, 40),
(6, 45),
(6, 46),
(7, 30),
(7, 38),
(8, 25),
(8, 28),
(8, 32),
(8, 43),
(9, 15),
(9, 16),
(9, 17),
(9, 18),
(9, 19),
(9, 33),
(10, 26),
(10, 31),
(10, 36),
(10, 40),
(10, 46),
(11, 24),
(11, 29),
(11, 42),
(11, 43),
(12, 15),
(12, 21),
(12, 22),
(12, 30),
(12, 38),
(13, 24),
(13, 43),
(13, 44),
(13, 45),
(14, 35),
(14, 37),
(14, 39),
(14, 41),
(15, 16),
(15, 17),
(15, 23),
(15, 33),
(16, 17),
(16, 18),
(16, 36),
(16, 46),
(17, 16),
(17, 17),
(17, 33),
(17, 39),
(18, 19),
(18, 20),
(18, 27),
(18, 28),
(19, 29),
(19, 30),
(19, 31),
(19, 32),
(20, 34),
(20, 37),
(20, 38),
(21, 21),
(21, 22),
(21, 24),
(21, 44),
(22, 15),
(22, 22),
(22, 26),
(23, 29),
(23, 45),
(24, 20),
(24, 23),
(24, 31),
(25, 22),
(25, 26),
(25, 46),
(26, 19),
(26, 35),
(26, 39),
(27, 15),
(27, 16),
(27, 17),
(27, 18),
(27, 33),
(27, 40),
(28, 21),
(28, 24),
(28, 28),
(28, 29),
(28, 32),
(28, 36),
(29, 30),
(29, 38),
(29, 41),
(29, 43),
(29, 45),
(30, 16),
(30, 19),
(31, 24),
(31, 44);

-- --------------------------------------------------------

--
-- Table structure for table `tro_choi_goi_game`
--

CREATE TABLE `tro_choi_goi_game` (
  `goi_game_id` bigint(20) UNSIGNED NOT NULL,
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `vi_tri` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tro_choi_goi_game`
--

INSERT INTO `tro_choi_goi_game` (`goi_game_id`, `tro_choi_id`, `vi_tri`) VALUES
(1, 3, 0),
(1, 5, 1),
(1, 7, 3),
(1, 8, 4),
(1, 10, 2),
(4, 18, 0),
(4, 19, 1),
(4, 20, 2),
(4, 27, 4),
(4, 35, 3),
(5, 20, 0),
(5, 25, 1),
(5, 31, 2),
(6, 15, 0),
(6, 22, 1),
(6, 46, 2),
(7, 16, 0),
(7, 17, 1),
(7, 33, 2),
(7, 39, 3),
(8, 29, 0),
(8, 42, 1),
(9, 24, 0),
(9, 43, 1),
(10, 30, 0),
(10, 38, 1),
(11, 34, 1),
(11, 37, 0),
(11, 38, 2),
(12, 24, 2),
(12, 43, 1),
(12, 44, 0),
(13, 36, 0),
(13, 40, 1),
(13, 45, 2),
(13, 46, 3),
(14, 18, 0),
(14, 19, 1),
(14, 35, 3),
(14, 39, 2),
(15, 21, 1),
(15, 30, 0),
(15, 34, 2),
(16, 29, 1),
(16, 45, 0),
(17, 25, 2),
(17, 28, 0),
(17, 32, 1),
(18, 22, 0),
(18, 23, 1),
(18, 31, 3),
(18, 44, 2),
(19, 21, 0),
(19, 22, 1),
(19, 23, 2),
(19, 24, 3),
(19, 29, 4),
(19, 30, 5),
(19, 36, 6),
(20, 16, 0),
(20, 17, 3),
(20, 40, 1),
(20, 46, 2),
(21, 20, 1),
(21, 32, 2),
(21, 42, 0),
(22, 3, 0),
(22, 5, 1),
(22, 10, 2),
(22, 47, 3),
(22, 50, 4),
(23, 4, 0),
(23, 9, 1),
(23, 51, 2),
(24, 6, 0),
(24, 7, 2),
(24, 52, 1),
(25, 48, 0),
(25, 49, 1),
(25, 54, 2),
(26, 16, 0),
(26, 17, 1),
(26, 29, 4),
(26, 32, 3),
(26, 36, 2),
(27, 18, 0),
(27, 26, 4),
(27, 28, 2),
(27, 31, 1),
(27, 41, 3),
(28, 15, 0),
(28, 22, 1),
(28, 26, 2),
(28, 46, 3),
(29, 15, 0),
(29, 16, 1),
(29, 17, 2),
(29, 18, 3),
(30, 21, 0),
(30, 33, 1),
(30, 36, 2),
(31, 34, 1),
(31, 37, 0),
(31, 45, 2),
(32, 36, 2),
(32, 40, 0),
(32, 46, 1),
(33, 15, 0),
(33, 19, 2),
(33, 33, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tro_choi_nen_tang`
--

CREATE TABLE `tro_choi_nen_tang` (
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `nen_tang_id` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tro_choi_nen_tang`
--

INSERT INTO `tro_choi_nen_tang` (`tro_choi_id`, `nen_tang_id`) VALUES
(3, 1),
(3, 2),
(3, 3),
(4, 1),
(4, 2),
(4, 3),
(4, 4),
(5, 1),
(5, 2),
(5, 3),
(6, 1),
(6, 2),
(6, 3),
(6, 4),
(7, 1),
(7, 2),
(7, 3),
(7, 4),
(7, 5),
(8, 1),
(8, 2),
(8, 3),
(9, 1),
(9, 2),
(9, 3),
(10, 1),
(10, 2),
(10, 3),
(15, 1),
(15, 2),
(15, 3),
(16, 1),
(16, 2),
(16, 3),
(17, 1),
(17, 2),
(17, 3),
(18, 1),
(18, 3),
(19, 1),
(19, 2),
(19, 3),
(20, 1),
(20, 2),
(20, 3),
(21, 1),
(21, 2),
(21, 3),
(22, 1),
(22, 2),
(22, 3),
(23, 1),
(23, 3),
(24, 1),
(24, 2),
(24, 3),
(25, 1),
(25, 2),
(25, 3),
(26, 1),
(26, 2),
(26, 3),
(27, 1),
(27, 2),
(27, 3),
(28, 1),
(28, 3),
(29, 1),
(29, 2),
(29, 3),
(30, 1),
(30, 2),
(30, 3),
(31, 1),
(31, 3),
(32, 1),
(32, 2),
(32, 3),
(33, 1),
(33, 3),
(34, 1),
(34, 2),
(34, 3),
(35, 1),
(35, 2),
(36, 1),
(36, 2),
(36, 3),
(37, 1),
(37, 2),
(37, 3),
(38, 1),
(38, 2),
(38, 3),
(39, 1),
(39, 3),
(40, 1),
(40, 2),
(40, 3),
(41, 1),
(41, 3),
(42, 1),
(42, 2),
(42, 3),
(43, 1),
(43, 3),
(44, 1),
(44, 2),
(44, 3),
(45, 1),
(46, 1),
(46, 2),
(46, 3),
(47, 1),
(48, 1),
(48, 2),
(48, 3),
(49, 1),
(49, 2),
(49, 3),
(50, 1),
(50, 2),
(51, 1),
(51, 2),
(51, 3),
(52, 1),
(52, 2),
(52, 3),
(53, 1),
(53, 2),
(53, 3),
(54, 1),
(54, 3),
(78, 1),
(78, 2),
(78, 3),
(78, 6);

-- --------------------------------------------------------

--
-- Table structure for table `tro_choi_nhan`
--

CREATE TABLE `tro_choi_nhan` (
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `nhan_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tro_choi_nhan`
--

INSERT INTO `tro_choi_nhan` (`tro_choi_id`, `nhan_id`) VALUES
(3, 1),
(3, 2),
(3, 3),
(3, 5),
(3, 9),
(3, 13),
(4, 1),
(4, 2),
(4, 3),
(4, 6),
(4, 12),
(5, 1),
(5, 2),
(5, 3),
(5, 4),
(5, 10),
(5, 13),
(6, 1),
(6, 2),
(6, 3),
(6, 7),
(6, 8),
(6, 13),
(7, 1),
(7, 2),
(7, 3),
(7, 5),
(7, 8),
(7, 15),
(8, 1),
(8, 2),
(8, 3),
(8, 8),
(8, 13),
(8, 14),
(9, 1),
(9, 2),
(9, 11),
(10, 1),
(10, 2),
(10, 3),
(10, 4),
(10, 9),
(10, 13),
(15, 2),
(15, 3),
(15, 8),
(15, 21),
(15, 22),
(16, 3),
(16, 10),
(16, 19),
(17, 3),
(17, 22),
(18, 3),
(18, 10),
(18, 18),
(19, 3),
(19, 18),
(19, 19),
(19, 22),
(20, 3),
(20, 4),
(20, 18),
(20, 20),
(21, 2),
(21, 3),
(21, 7),
(21, 8),
(21, 22),
(22, 3),
(22, 7),
(22, 21),
(23, 2),
(23, 3),
(23, 18),
(23, 22),
(24, 3),
(24, 22),
(25, 3),
(25, 18),
(25, 20),
(25, 25),
(26, 3),
(26, 21),
(26, 22),
(26, 25),
(27, 3),
(27, 10),
(27, 18),
(27, 20),
(27, 22),
(28, 3),
(28, 7),
(28, 25),
(29, 3),
(29, 5),
(29, 18),
(29, 22),
(29, 24),
(30, 3),
(30, 7),
(30, 13),
(30, 23),
(31, 3),
(31, 18),
(31, 20),
(31, 22),
(32, 3),
(32, 4),
(32, 10),
(32, 18),
(33, 2),
(33, 3),
(33, 11),
(34, 3),
(34, 8),
(34, 13),
(34, 23),
(34, 24),
(35, 2),
(35, 3),
(35, 11),
(35, 18),
(35, 22),
(36, 3),
(36, 22),
(36, 25),
(37, 2),
(37, 3),
(37, 8),
(37, 13),
(37, 24),
(38, 3),
(38, 8),
(38, 23),
(38, 24),
(39, 3),
(39, 22),
(39, 25),
(40, 3),
(40, 25),
(41, 3),
(41, 10),
(42, 3),
(42, 4),
(42, 18),
(42, 22),
(42, 24),
(43, 3),
(43, 9),
(43, 25),
(44, 3),
(44, 22),
(45, 3),
(45, 7),
(45, 24),
(46, 2),
(46, 3),
(46, 21),
(46, 25),
(47, 1),
(47, 2),
(47, 3),
(47, 5),
(47, 24),
(48, 2),
(48, 3),
(48, 18),
(48, 23),
(49, 2),
(49, 7),
(49, 11),
(49, 13),
(49, 23),
(50, 1),
(50, 2),
(50, 3),
(50, 5),
(50, 24),
(51, 1),
(51, 2),
(51, 11),
(52, 1),
(52, 3),
(52, 7),
(52, 13),
(52, 24),
(53, 3),
(53, 25),
(54, 2),
(54, 11),
(78, 3),
(78, 7),
(78, 13);

-- --------------------------------------------------------

--
-- Table structure for table `tro_choi_the_loai`
--

CREATE TABLE `tro_choi_the_loai` (
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `the_loai_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tro_choi_the_loai`
--

INSERT INTO `tro_choi_the_loai` (`tro_choi_id`, `the_loai_id`) VALUES
(3, 6),
(4, 1),
(5, 3),
(5, 6),
(6, 2),
(6, 7),
(7, 6),
(8, 6),
(8, 7),
(9, 1),
(10, 6),
(15, 3),
(15, 7),
(16, 1),
(16, 2),
(16, 8),
(17, 2),
(17, 8),
(18, 1),
(18, 3),
(19, 1),
(19, 8),
(20, 6),
(21, 1),
(21, 2),
(22, 2),
(23, 1),
(24, 5),
(24, 7),
(25, 4),
(25, 5),
(25, 6),
(26, 5),
(26, 7),
(27, 3),
(27, 6),
(28, 2),
(28, 4),
(29, 6),
(29, 7),
(30, 2),
(30, 7),
(31, 6),
(32, 3),
(32, 4),
(32, 6),
(33, 1),
(33, 8),
(34, 6),
(34, 7),
(35, 1),
(36, 2),
(36, 3),
(37, 6),
(37, 7),
(38, 7),
(39, 1),
(39, 8),
(40, 2),
(41, 1),
(41, 2),
(42, 6),
(43, 2),
(43, 5),
(44, 5),
(45, 2),
(46, 2),
(46, 7),
(47, 6),
(48, 1),
(48, 2),
(49, 1),
(49, 2),
(50, 6),
(51, 1),
(52, 2),
(52, 7),
(53, 9),
(54, 1),
(78, 1),
(78, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tro_choi_yeu_thich`
--

CREATE TABLE `tro_choi_yeu_thich` (
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tro_choi_yeu_thich`
--

INSERT INTO `tro_choi_yeu_thich` (`nguoi_dung_id`, `tro_choi_id`, `ngay_tao`) VALUES
(17, 3, '2026-10-22 08:56:26'),
(17, 5, '2026-08-17 08:56:26'),
(18, 18, '2026-11-02 19:17:29'),
(18, 19, '2026-11-02 19:17:29'),
(18, 23, '2026-10-30 19:17:29'),
(18, 37, '2026-10-30 19:50:05'),
(18, 43, '2026-10-31 19:50:05'),
(18, 47, '2026-10-30 19:50:05'),
(19, 5, '2026-09-17 08:56:26'),
(19, 20, '2026-10-30 19:17:29'),
(19, 23, '2026-10-30 19:17:29'),
(19, 34, '2026-10-31 19:50:05'),
(19, 41, '2026-11-02 19:50:05'),
(20, 6, '2026-09-28 08:56:26'),
(20, 7, '2026-10-31 07:56:26'),
(20, 10, '2026-10-02 08:56:26'),
(20, 15, '2026-11-02 19:17:29'),
(20, 16, '2026-11-01 19:17:29'),
(20, 22, '2026-11-02 19:17:29'),
(20, 30, '2026-11-01 19:50:05'),
(20, 46, '2026-11-01 19:50:05'),
(20, 53, '2026-11-01 19:50:05'),
(21, 3, '2026-10-21 08:56:26'),
(21, 7, '2026-09-22 08:56:26'),
(21, 18, '2026-10-30 19:17:29'),
(21, 22, '2026-11-01 19:17:29'),
(21, 29, '2026-10-31 19:50:05'),
(21, 33, '2026-10-30 19:50:05'),
(22, 3, '2026-11-01 07:56:26'),
(22, 6, '2026-09-06 08:56:26'),
(22, 16, '2026-10-31 19:17:29'),
(22, 34, '2026-11-01 19:50:05'),
(23, 3, '2026-09-08 08:56:26'),
(23, 6, '2026-10-30 07:56:26'),
(23, 18, '2026-10-30 19:17:29'),
(23, 19, '2026-10-31 19:17:29'),
(23, 23, '2026-10-30 19:17:29'),
(23, 29, '2026-11-01 19:50:05'),
(23, 38, '2026-11-02 19:50:05'),
(23, 54, '2026-11-01 19:50:05'),
(24, 4, '2026-10-09 08:56:26'),
(24, 5, '2026-10-04 08:56:26'),
(24, 16, '2026-11-02 19:17:29'),
(24, 24, '2026-10-30 19:17:29'),
(24, 34, '2026-11-01 19:50:05'),
(24, 51, '2026-11-02 19:50:05'),
(25, 24, '2026-11-02 19:17:29'),
(25, 33, '2026-11-02 19:50:05'),
(26, 4, '2026-09-17 08:56:26'),
(26, 17, '2026-11-01 19:17:29'),
(26, 19, '2026-11-02 19:17:29'),
(26, 20, '2026-10-30 19:17:29'),
(26, 41, '2026-10-30 19:50:05'),
(26, 47, '2026-11-01 19:50:05'),
(26, 48, '2026-11-01 19:50:05'),
(27, 3, '2026-10-06 08:56:26'),
(27, 7, '2026-09-21 08:56:26'),
(27, 10, '2026-08-20 08:56:26'),
(27, 15, '2026-11-02 19:17:29'),
(27, 21, '2026-11-01 19:17:29'),
(27, 31, '2026-11-01 19:50:05'),
(27, 47, '2026-10-30 19:50:05'),
(28, 18, '2026-10-30 19:17:29'),
(28, 20, '2026-11-01 19:17:29'),
(28, 23, '2026-10-31 19:17:29'),
(28, 25, '2026-10-31 19:50:05'),
(28, 30, '2026-11-01 19:50:05'),
(28, 35, '2026-10-30 19:50:05'),
(29, 3, '2026-09-20 08:56:26'),
(29, 4, '2026-08-19 08:56:26'),
(29, 9, '2026-08-30 08:56:26'),
(29, 22, '2026-11-01 19:17:29'),
(29, 34, '2026-11-02 19:50:05'),
(30, 15, '2026-11-01 19:17:29'),
(30, 21, '2026-11-01 19:17:29'),
(30, 23, '2026-11-02 19:17:29'),
(30, 26, '2026-10-30 19:50:05'),
(30, 41, '2026-10-30 19:50:05'),
(30, 44, '2026-11-01 19:50:05'),
(31, 5, '2026-09-13 08:56:26'),
(31, 9, '2026-09-10 08:56:26'),
(31, 16, '2026-10-31 19:17:29'),
(31, 36, '2026-10-30 19:50:05'),
(32, 16, '2026-10-31 19:17:29'),
(32, 25, '2026-10-31 19:50:05'),
(33, 21, '2026-10-30 19:17:29'),
(33, 38, '2026-11-02 19:50:05'),
(34, 9, '2026-08-29 08:56:26'),
(34, 15, '2026-10-30 19:17:29'),
(34, 23, '2026-10-30 19:17:29'),
(34, 28, '2026-11-01 19:50:05'),
(34, 52, '2026-10-30 19:50:05'),
(35, 17, '2026-11-01 19:17:29'),
(35, 21, '2026-10-30 19:17:29'),
(35, 30, '2026-11-01 19:50:05'),
(35, 34, '2026-10-30 19:50:05'),
(36, 18, '2026-10-30 19:17:29'),
(36, 52, '2026-11-01 19:50:05'),
(37, 18, '2026-11-02 19:17:29'),
(37, 24, '2026-11-01 19:17:29'),
(37, 28, '2026-11-02 19:50:05'),
(37, 43, '2026-11-01 19:50:05'),
(38, 5, '2026-09-15 08:56:26'),
(38, 6, '2026-08-16 08:56:26'),
(38, 22, '2026-10-31 19:17:29'),
(38, 53, '2026-10-30 19:50:05'),
(39, 23, '2026-10-30 19:17:29'),
(39, 28, '2026-10-30 19:50:05'),
(40, 5, '2026-08-12 08:56:26'),
(40, 7, '2026-10-04 08:56:26'),
(40, 8, '2026-10-29 07:56:26'),
(40, 16, '2026-11-01 19:17:29'),
(40, 17, '2026-10-31 19:17:29'),
(40, 22, '2026-11-02 19:17:29'),
(40, 36, '2026-11-02 19:50:05'),
(40, 47, '2026-10-30 19:50:05'),
(40, 50, '2026-11-02 19:50:05'),
(41, 4, '2026-08-28 08:56:26'),
(41, 5, '2026-08-31 08:56:26'),
(41, 18, '2026-10-30 19:17:29'),
(41, 53, '2026-10-31 19:50:05'),
(42, 4, '2026-10-28 07:56:26'),
(42, 9, '2026-10-25 07:56:26'),
(42, 10, '2026-09-20 08:56:26'),
(42, 18, '2026-11-02 19:17:29'),
(42, 22, '2026-11-01 19:17:29'),
(42, 24, '2026-11-01 19:17:29'),
(42, 43, '2026-11-01 19:50:05'),
(42, 51, '2026-11-01 19:50:05'),
(42, 52, '2026-11-02 19:50:05'),
(43, 5, '2026-09-18 08:56:26'),
(43, 6, '2026-09-28 08:56:26'),
(43, 7, '2026-08-30 08:56:26'),
(44, 4, '2026-08-22 08:56:26'),
(44, 7, '2026-09-07 08:56:26'),
(44, 15, '2026-10-30 19:17:29'),
(44, 17, '2026-10-31 19:17:29'),
(44, 23, '2026-10-31 19:17:29'),
(44, 30, '2026-11-01 19:50:05'),
(44, 39, '2026-11-01 19:50:05'),
(44, 40, '2026-11-01 19:50:05'),
(45, 16, '2026-11-01 19:17:29'),
(45, 30, '2026-10-30 19:50:05'),
(46, 9, '2026-09-05 08:56:26'),
(47, 4, '2026-10-09 08:56:26'),
(47, 9, '2026-10-30 07:56:26'),
(48, 4, '2026-08-14 08:56:26'),
(48, 20, '2026-10-30 19:17:29'),
(48, 42, '2026-11-01 19:50:05'),
(49, 6, '2026-10-11 08:56:26'),
(49, 7, '2026-09-21 08:56:26'),
(49, 18, '2026-11-01 19:17:29'),
(49, 22, '2026-11-01 19:17:29'),
(49, 26, '2026-11-02 19:50:05'),
(49, 27, '2026-10-31 19:50:05'),
(50, 16, '2026-11-02 19:17:29'),
(50, 23, '2026-11-02 19:17:29'),
(50, 24, '2026-11-01 19:17:29'),
(50, 30, '2026-10-31 19:50:05'),
(50, 36, '2026-11-02 19:50:05'),
(50, 47, '2026-10-30 19:50:05'),
(51, 19, '2026-10-31 19:17:29'),
(51, 20, '2026-11-01 19:17:29'),
(51, 23, '2026-11-02 19:17:29'),
(51, 32, '2026-10-31 19:50:05'),
(51, 46, '2026-10-30 19:50:05'),
(51, 49, '2026-10-30 19:50:05'),
(52, 8, '2026-09-19 08:56:26'),
(52, 17, '2026-11-02 19:17:29'),
(52, 20, '2026-10-31 19:17:29'),
(52, 22, '2026-10-30 19:17:29'),
(52, 27, '2026-10-31 19:50:05'),
(52, 33, '2026-10-31 19:50:05'),
(52, 38, '2026-11-01 19:50:05');

-- --------------------------------------------------------

--
-- Table structure for table `tuong_tac_bai_viet`
--

CREATE TABLE `tuong_tac_bai_viet` (
  `bai_viet_id` bigint(20) UNSIGNED NOT NULL,
  `nguoi_dung_id` bigint(20) UNSIGNED NOT NULL,
  `phan_ung` enum('like','helpful','love','laugh') NOT NULL DEFAULT 'like',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tuong_tac_bai_viet`
--

INSERT INTO `tuong_tac_bai_viet` (`bai_viet_id`, `nguoi_dung_id`, `phan_ung`, `ngay_tao`) VALUES
(19, 19, 'helpful', '2026-08-11 14:40:26'),
(19, 30, 'like', '2026-08-11 17:02:26'),
(20, 28, 'helpful', '2026-08-12 04:12:26'),
(20, 42, 'love', '2026-08-12 07:25:26'),
(21, 26, 'like', '2026-08-12 07:20:26'),
(21, 29, 'like', '2026-08-12 11:07:26'),
(21, 31, 'like', '2026-08-12 05:34:26'),
(21, 33, 'helpful', '2026-08-12 08:29:26'),
(21, 34, 'like', '2026-08-12 03:43:26'),
(21, 40, 'helpful', '2026-08-12 08:49:26'),
(23, 22, 'helpful', '2026-08-13 13:25:26'),
(23, 26, 'helpful', '2026-08-13 20:42:26'),
(23, 33, 'like', '2026-08-13 15:34:26'),
(23, 44, 'helpful', '2026-08-13 14:09:26'),
(23, 46, 'like', '2026-08-13 15:23:26'),
(24, 30, 'love', '2026-08-14 06:02:26'),
(24, 37, 'helpful', '2026-08-14 00:58:26'),
(24, 38, 'love', '2026-08-14 01:36:26'),
(24, 43, 'like', '2026-08-14 08:04:26'),
(24, 50, 'love', '2026-08-14 06:42:26'),
(24, 52, 'laugh', '2026-08-14 04:03:26'),
(25, 20, 'like', '2026-09-01 16:02:26'),
(25, 23, 'like', '2026-09-01 10:35:26'),
(25, 28, 'like', '2026-09-01 09:40:26'),
(25, 50, 'love', '2026-09-01 14:24:26'),
(26, 23, 'like', '2026-09-01 21:02:26'),
(26, 45, 'love', '2026-09-01 20:42:26'),
(27, 28, 'like', '2026-09-02 21:03:26'),
(27, 29, 'like', '2026-09-02 18:48:26'),
(27, 30, 'like', '2026-09-02 14:23:26'),
(27, 39, 'like', '2026-09-02 20:35:26'),
(27, 52, 'helpful', '2026-09-02 15:39:26'),
(28, 25, 'like', '2026-09-03 14:55:26'),
(28, 29, 'like', '2026-09-03 16:12:26'),
(28, 35, 'like', '2026-09-03 13:52:26'),
(28, 51, 'love', '2026-09-03 10:48:26'),
(29, 21, 'helpful', '2026-09-04 04:54:26'),
(29, 22, 'love', '2026-09-04 05:06:26'),
(29, 28, 'like', '2026-09-03 22:31:26'),
(29, 41, 'laugh', '2026-09-04 01:08:26'),
(29, 43, 'like', '2026-09-04 02:16:26'),
(30, 40, 'like', '2026-10-14 06:48:26'),
(31, 30, 'love', '2026-10-15 04:23:26'),
(31, 38, 'love', '2026-10-14 23:53:26'),
(31, 44, 'like', '2026-10-15 01:06:26'),
(31, 49, 'like', '2026-10-15 02:13:26'),
(31, 51, 'laugh', '2026-10-15 08:14:26'),
(32, 17, 'love', '2026-10-15 12:20:26'),
(32, 28, 'like', '2026-10-15 19:28:26'),
(32, 34, 'like', '2026-10-15 13:19:26'),
(32, 48, 'like', '2026-10-15 18:20:26'),
(33, 18, 'like', '2026-10-16 20:14:26'),
(33, 32, 'love', '2026-10-16 22:16:26'),
(33, 47, 'laugh', '2026-10-16 18:52:26'),
(34, 20, 'helpful', '2026-10-17 15:18:26'),
(34, 29, 'love', '2026-10-17 15:59:26'),
(34, 36, 'helpful', '2026-10-17 13:56:26'),
(34, 45, 'laugh', '2026-10-17 14:01:26'),
(35, 41, 'like', '2026-09-11 21:33:26'),
(36, 30, 'like', '2026-09-12 20:16:26'),
(36, 44, 'like', '2026-09-12 21:01:26'),
(37, 29, 'helpful', '2026-09-12 20:12:26'),
(37, 32, 'like', '2026-09-13 03:11:26'),
(38, 21, 'like', '2026-09-12 23:36:26'),
(38, 23, 'like', '2026-09-13 04:33:26'),
(38, 25, 'like', '2026-09-13 03:03:26'),
(38, 26, 'like', '2026-09-12 22:49:26'),
(38, 27, 'helpful', '2026-09-12 23:31:26'),
(39, 23, 'love', '2026-07-07 20:01:26'),
(40, 22, 'like', '2026-07-07 21:56:26'),
(40, 31, 'helpful', '2026-07-08 02:18:26'),
(40, 35, 'like', '2026-07-08 01:52:26'),
(40, 40, 'like', '2026-07-08 03:34:26'),
(40, 51, 'helpful', '2026-07-07 21:49:26'),
(41, 18, 'helpful', '2026-09-03 15:42:26'),
(41, 27, 'laugh', '2026-09-03 14:44:26'),
(41, 41, 'like', '2026-09-03 21:55:26'),
(41, 44, 'love', '2026-09-03 20:09:26'),
(42, 36, 'love', '2026-09-03 15:52:26'),
(42, 41, 'like', '2026-09-03 14:08:26'),
(42, 44, 'like', '2026-09-03 19:10:26'),
(42, 45, 'like', '2026-09-03 20:48:26'),
(42, 49, 'like', '2026-09-03 17:33:26'),
(43, 24, 'helpful', '2026-09-04 11:44:26'),
(43, 49, 'laugh', '2026-09-04 11:47:26'),
(44, 18, 'like', '2026-08-25 09:13:26'),
(44, 39, 'like', '2026-08-25 10:14:26'),
(45, 31, 'like', '2026-08-25 15:29:26'),
(46, 23, 'love', '2026-08-26 03:32:26'),
(46, 26, 'laugh', '2026-08-26 03:07:26'),
(46, 35, 'like', '2026-08-26 00:19:26'),
(46, 50, 'like', '2026-08-26 00:52:26'),
(47, 29, 'helpful', '2026-08-27 06:54:26'),
(47, 33, 'love', '2026-08-27 06:51:26'),
(47, 34, 'like', '2026-08-27 07:03:26'),
(47, 39, 'like', '2026-08-27 08:07:26'),
(47, 43, 'like', '2026-08-27 13:37:26'),
(47, 47, 'love', '2026-08-27 12:23:26'),
(49, 28, 'like', '2026-08-05 14:39:26'),
(49, 41, 'like', '2026-08-05 21:43:26'),
(49, 46, 'love', '2026-08-05 20:18:26'),
(50, 17, 'like', '2026-08-06 20:27:26'),
(50, 26, 'laugh', '2026-08-06 19:43:26'),
(50, 28, 'helpful', '2026-08-06 18:43:26'),
(50, 40, 'helpful', '2026-08-06 17:22:26'),
(50, 47, 'love', '2026-08-07 02:06:26'),
(52, 38, 'love', '2026-09-24 23:33:26'),
(53, 31, 'like', '2026-09-25 06:29:26'),
(53, 45, 'like', '2026-09-25 11:02:26'),
(53, 50, 'laugh', '2026-09-25 07:08:26'),
(54, 18, 'like', '2026-08-26 15:55:26'),
(54, 23, 'love', '2026-08-26 17:31:26'),
(54, 39, 'like', '2026-08-26 14:17:26'),
(54, 48, 'like', '2026-08-26 15:45:26'),
(54, 51, 'like', '2026-08-26 15:29:26'),
(55, 20, 'laugh', '2026-08-27 05:27:26'),
(55, 25, 'laugh', '2026-08-27 08:54:26'),
(55, 50, 'love', '2026-08-27 06:28:26'),
(56, 36, 'like', '2026-08-28 07:51:26'),
(56, 40, 'like', '2026-08-28 14:45:26'),
(63, 18, 'helpful', '2026-08-07 11:22:26'),
(63, 20, 'like', '2026-08-07 05:33:26'),
(63, 26, 'like', '2026-08-07 08:27:26'),
(63, 44, 'helpful', '2026-08-07 06:47:26'),
(63, 46, 'like', '2026-08-07 08:36:26'),
(64, 29, 'love', '2026-08-07 22:38:26'),
(64, 33, 'love', '2026-08-07 21:39:26'),
(64, 38, 'laugh', '2026-08-07 16:04:26'),
(64, 49, 'like', '2026-08-07 16:23:26'),
(65, 21, 'love', '2026-08-08 13:37:26'),
(65, 25, 'like', '2026-08-08 07:04:26'),
(65, 30, 'laugh', '2026-08-08 07:30:26'),
(65, 35, 'like', '2026-08-08 11:43:26'),
(66, 24, 'helpful', '2026-08-08 16:47:26'),
(66, 31, 'like', '2026-08-08 14:34:26'),
(66, 51, 'like', '2026-08-08 16:53:26'),
(67, 22, 'laugh', '2026-07-28 13:32:26'),
(67, 46, 'like', '2026-07-28 12:35:26'),
(68, 19, 'helpful', '2026-07-28 22:55:26'),
(68, 29, 'like', '2026-07-28 22:18:26'),
(68, 33, 'like', '2026-07-28 21:00:26'),
(68, 36, 'helpful', '2026-07-28 21:41:26'),
(68, 48, 'laugh', '2026-07-28 22:35:26'),
(68, 51, 'helpful', '2026-07-28 18:36:26'),
(69, 23, 'like', '2026-07-29 05:28:26'),
(69, 25, 'like', '2026-07-29 05:05:26'),
(69, 27, 'like', '2026-07-29 00:24:26'),
(69, 45, 'laugh', '2026-07-29 02:28:26'),
(69, 49, 'like', '2026-07-28 23:24:26'),
(70, 23, 'like', '2026-07-29 05:20:26'),
(70, 51, 'like', '2026-07-29 04:21:26'),
(71, 40, 'love', '2026-10-23 19:52:26'),
(72, 19, 'like', '2026-10-24 16:41:26'),
(72, 21, 'like', '2026-10-24 20:46:26'),
(73, 43, 'like', '2026-10-26 00:43:26'),
(75, 43, 'like', '2026-09-02 21:16:26'),
(76, 30, 'helpful', '2026-09-03 16:14:26'),
(76, 31, 'love', '2026-09-03 11:05:26'),
(76, 44, 'helpful', '2026-09-03 11:47:26'),
(77, 35, 'helpful', '2026-09-04 06:45:26'),
(77, 43, 'like', '2026-09-04 04:01:26'),
(77, 46, 'like', '2026-09-04 06:26:26'),
(77, 47, 'laugh', '2026-09-04 06:28:26'),
(77, 50, 'helpful', '2026-09-04 03:43:26'),
(78, 26, 'like', '2026-07-20 08:19:26'),
(78, 44, 'like', '2026-07-20 11:54:26'),
(79, 20, 'love', '2026-07-21 00:24:26'),
(79, 26, 'love', '2026-07-21 00:47:26'),
(80, 21, 'love', '2026-07-21 14:43:26'),
(80, 32, 'like', '2026-07-21 16:16:26'),
(80, 35, 'love', '2026-07-21 09:55:26'),
(80, 36, 'like', '2026-07-21 15:00:26'),
(80, 40, 'helpful', '2026-07-21 17:15:26'),
(81, 17, 'love', '2026-07-21 23:53:26'),
(82, 27, 'like', '2026-09-26 00:14:26'),
(82, 38, 'helpful', '2026-09-26 06:54:26'),
(82, 52, 'love', '2026-09-26 04:39:26'),
(83, 18, 'like', '2026-09-26 14:58:26'),
(83, 22, 'love', '2026-09-26 14:52:26'),
(83, 31, 'like', '2026-09-26 12:01:26'),
(83, 35, 'like', '2026-09-26 10:45:26'),
(83, 42, 'love', '2026-09-26 11:58:26'),
(84, 22, 'helpful', '2026-09-26 23:05:26'),
(84, 25, 'love', '2026-09-27 02:38:26'),
(84, 29, 'love', '2026-09-27 05:01:26'),
(84, 30, 'helpful', '2026-09-27 08:25:26'),
(84, 38, 'like', '2026-09-27 02:30:26'),
(84, 46, 'love', '2026-09-27 01:37:26'),
(91, 20, 'helpful', '2026-10-16 07:53:26'),
(91, 24, 'love', '2026-10-16 01:45:26'),
(91, 35, 'love', '2026-10-16 04:36:26'),
(91, 37, 'helpful', '2026-10-16 04:33:26'),
(91, 38, 'helpful', '2026-10-16 07:25:26'),
(92, 19, 'laugh', '2026-10-16 16:42:26'),
(92, 33, 'helpful', '2026-10-16 18:05:26'),
(92, 38, 'like', '2026-10-16 18:27:26'),
(93, 37, 'love', '2026-10-17 16:19:26'),
(93, 48, 'helpful', '2026-10-17 12:08:26'),
(97, 17, 'like', '2026-09-24 14:40:26'),
(97, 25, 'helpful', '2026-09-24 18:01:26'),
(97, 27, 'like', '2026-09-24 12:03:26'),
(97, 29, 'love', '2026-09-24 17:19:26'),
(97, 42, 'like', '2026-09-24 14:22:26'),
(97, 49, 'like', '2026-09-24 19:13:26'),
(98, 23, 'like', '2026-09-25 19:06:26'),
(98, 30, 'helpful', '2026-09-25 19:51:26'),
(98, 34, 'like', '2026-09-25 19:47:26'),
(98, 40, 'like', '2026-09-25 23:55:26'),
(98, 42, 'helpful', '2026-09-25 14:36:26'),
(99, 40, 'love', '2026-10-11 04:42:26'),
(100, 26, 'like', '2026-10-12 02:47:26'),
(101, 25, 'love', '2026-10-04 21:28:26'),
(101, 26, 'helpful', '2026-10-05 00:33:26'),
(101, 46, 'like', '2026-10-04 17:35:26'),
(102, 23, 'like', '2026-10-05 07:35:26'),
(102, 29, 'helpful', '2026-10-05 06:50:26'),
(102, 32, 'love', '2026-10-05 10:10:26'),
(102, 42, 'like', '2026-10-05 05:54:26'),
(102, 47, 'helpful', '2026-10-05 11:40:26'),
(103, 27, 'like', '2026-10-05 19:25:26'),
(103, 32, 'like', '2026-10-05 19:28:26'),
(103, 40, 'like', '2026-10-05 14:40:26'),
(103, 42, 'helpful', '2026-10-05 18:34:26'),
(103, 49, 'helpful', '2026-10-05 12:41:26'),
(104, 32, 'helpful', '2026-10-06 19:48:26'),
(104, 35, 'like', '2026-10-06 22:59:26'),
(104, 42, 'like', '2026-10-06 22:25:26'),
(104, 45, 'like', '2026-10-06 17:00:26'),
(104, 48, 'like', '2026-10-06 23:12:26'),
(104, 52, 'like', '2026-10-06 21:27:26'),
(113, 43, 'like', '2026-10-22 01:16:26'),
(114, 19, 'like', '2026-10-22 21:41:26'),
(114, 29, 'like', '2026-10-22 22:00:26'),
(114, 31, 'love', '2026-10-22 15:42:26'),
(114, 33, 'helpful', '2026-10-22 19:24:26'),
(114, 42, 'like', '2026-10-22 17:49:26'),
(115, 24, 'like', '2026-10-23 03:44:26'),
(115, 29, 'like', '2026-10-23 09:23:26'),
(115, 37, 'laugh', '2026-10-23 04:15:26'),
(115, 45, 'love', '2026-10-23 07:38:26'),
(115, 51, 'helpful', '2026-10-23 07:53:26'),
(116, 49, 'like', '2026-09-06 03:15:26'),
(117, 18, 'like', '2026-09-07 03:27:26'),
(117, 42, 'love', '2026-09-07 09:11:26'),
(117, 47, 'laugh', '2026-09-07 07:01:26'),
(118, 25, 'like', '2026-11-01 19:02:26'),
(119, 20, 'laugh', '2026-11-01 22:59:26'),
(119, 26, 'laugh', '2026-11-02 00:23:26'),
(119, 39, 'helpful', '2026-11-02 01:24:26'),
(120, 25, 'like', '2026-11-02 09:17:26'),
(120, 49, 'like', '2026-11-02 09:06:26'),
(121, 35, 'like', '2026-11-02 16:50:26'),
(121, 43, 'like', '2026-11-02 18:39:26'),
(122, 39, 'like', '2026-09-03 07:28:26'),
(122, 48, 'love', '2026-09-03 09:31:26'),
(122, 51, 'helpful', '2026-09-03 12:12:26'),
(123, 20, 'like', '2026-09-03 20:38:26'),
(123, 21, 'love', '2026-09-03 21:48:26'),
(123, 23, 'helpful', '2026-09-03 21:19:26'),
(123, 28, 'like', '2026-09-03 22:06:26'),
(124, 19, 'helpful', '2026-09-04 15:59:26'),
(124, 23, 'like', '2026-09-04 10:36:26'),
(124, 27, 'like', '2026-09-04 07:32:26'),
(124, 29, 'like', '2026-09-04 14:47:26'),
(124, 41, 'helpful', '2026-09-04 16:58:26'),
(125, 19, 'like', '2026-09-15 03:01:26'),
(125, 21, 'like', '2026-09-15 09:28:26'),
(125, 30, 'helpful', '2026-09-15 06:50:26'),
(125, 40, 'love', '2026-09-15 11:36:26'),
(125, 46, 'helpful', '2026-09-15 07:12:26'),
(125, 50, 'love', '2026-09-15 10:30:26'),
(126, 29, 'love', '2026-09-16 07:43:26'),
(127, 19, 'like', '2026-09-16 07:39:26'),
(127, 24, 'love', '2026-09-16 04:43:26'),
(127, 28, 'love', '2026-09-16 06:48:26'),
(127, 29, 'laugh', '2026-09-16 02:28:26'),
(127, 35, 'like', '2026-09-16 03:31:26'),
(128, 17, 'laugh', '2026-10-23 07:08:26'),
(128, 32, 'like', '2026-10-23 10:19:26'),
(128, 34, 'helpful', '2026-10-23 05:41:26'),
(128, 50, 'like', '2026-10-23 03:44:26'),
(130, 22, 'love', '2026-10-24 21:03:26'),
(130, 23, 'love', '2026-10-24 13:17:26'),
(130, 34, 'like', '2026-10-24 15:20:26'),
(130, 49, 'love', '2026-10-24 19:01:26'),
(130, 50, 'like', '2026-10-24 20:40:26'),
(131, 29, 'like', '2026-10-22 17:43:26'),
(131, 40, 'like', '2026-10-22 11:21:26'),
(132, 44, 'like', '2026-10-23 00:44:26'),
(133, 20, 'like', '2026-10-23 03:11:26'),
(133, 23, 'like', '2026-10-23 05:10:26'),
(133, 31, 'like', '2026-10-23 04:24:26'),
(133, 50, 'like', '2026-10-23 00:48:26'),
(133, 51, 'laugh', '2026-10-23 00:28:26'),
(134, 34, 'love', '2026-10-20 16:30:26'),
(134, 41, 'like', '2026-10-20 15:31:26'),
(135, 43, 'love', '2026-10-21 04:00:26'),
(136, 18, 'like', '2026-09-14 08:17:26'),
(136, 39, 'like', '2026-09-13 23:41:26'),
(137, 20, 'like', '2026-09-14 11:56:26'),
(137, 38, 'laugh', '2026-09-14 11:21:26'),
(138, 17, 'helpful', '2026-09-15 08:31:26'),
(138, 19, 'like', '2026-09-15 11:36:26'),
(138, 24, 'like', '2026-09-15 06:36:26'),
(138, 31, 'love', '2026-09-15 08:34:26'),
(138, 44, 'like', '2026-09-15 03:54:26'),
(138, 52, 'like', '2026-09-15 09:32:26'),
(139, 21, 'love', '2026-09-16 04:37:26'),
(139, 35, 'like', '2026-09-16 04:59:26'),
(139, 36, 'helpful', '2026-09-16 02:50:26'),
(139, 40, 'like', '2026-09-16 02:48:26'),
(139, 48, 'love', '2026-09-16 05:15:26'),
(140, 38, 'like', '2026-08-28 13:41:26'),
(140, 40, 'love', '2026-08-28 18:16:26'),
(140, 43, 'helpful', '2026-08-28 16:45:26'),
(142, 22, 'helpful', '2026-07-26 04:10:26'),
(142, 37, 'love', '2026-07-26 09:44:26'),
(142, 39, 'like', '2026-07-26 05:27:26'),
(143, 18, 'like', '2026-07-26 23:07:26'),
(143, 39, 'love', '2026-07-26 21:50:26'),
(143, 41, 'helpful', '2026-07-26 20:24:26'),
(143, 42, 'like', '2026-07-26 20:16:26'),
(143, 49, 'like', '2026-07-26 15:24:26'),
(144, 18, 'like', '2026-07-27 11:48:26'),
(144, 23, 'like', '2026-07-27 13:08:26'),
(144, 37, 'helpful', '2026-07-27 16:49:26'),
(144, 41, 'love', '2026-07-27 14:59:26'),
(144, 42, 'like', '2026-07-27 13:36:26'),
(145, 47, 'love', '2026-09-01 21:54:26'),
(146, 27, 'like', '2026-09-02 09:08:26'),
(146, 28, 'like', '2026-09-02 08:22:26'),
(146, 31, 'love', '2026-09-02 11:49:26'),
(147, 20, 'love', '2026-07-28 23:02:26'),
(147, 45, 'like', '2026-07-28 21:48:26'),
(148, 24, 'like', '2026-07-29 20:48:26'),
(148, 25, 'laugh', '2026-07-29 14:41:26'),
(148, 35, 'like', '2026-07-29 20:19:26'),
(148, 45, 'like', '2026-07-29 19:48:26'),
(148, 47, 'helpful', '2026-07-29 13:58:26'),
(149, 30, 'like', '2026-07-30 17:54:26'),
(153, 20, 'like', '2026-11-02 11:52:19'),
(153, 23, 'like', '2026-11-02 09:24:19'),
(155, 23, 'helpful', '2026-11-02 13:04:19'),
(155, 25, 'love', '2026-11-02 08:37:19'),
(155, 35, 'love', '2026-11-02 07:14:19'),
(155, 38, 'helpful', '2026-11-02 09:08:19'),
(155, 41, 'like', '2026-11-02 10:30:19'),
(156, 29, 'like', '2026-11-02 14:07:19'),
(156, 33, 'like', '2026-11-02 07:51:19'),
(156, 35, 'laugh', '2026-11-02 15:19:19'),
(156, 38, 'love', '2026-11-02 12:19:19'),
(156, 51, 'like', '2026-11-02 09:40:19'),
(157, 18, 'like', '2026-11-02 08:19:19'),
(157, 20, 'like', '2026-11-02 15:34:19'),
(157, 22, 'like', '2026-11-02 09:55:19'),
(157, 28, 'like', '2026-11-02 11:07:19'),
(157, 48, 'like', '2026-11-02 07:15:19'),
(159, 17, 'like', '2026-11-02 10:23:19'),
(159, 20, 'like', '2026-11-02 18:37:19'),
(159, 24, 'helpful', '2026-11-02 15:32:19'),
(159, 33, 'like', '2026-11-02 10:43:19'),
(159, 43, 'love', '2026-11-02 14:59:19'),
(159, 48, 'love', '2026-11-02 11:16:19'),
(160, 20, 'helpful', '2026-11-02 21:34:19'),
(160, 31, 'helpful', '2026-11-02 18:50:19'),
(160, 34, 'laugh', '2026-11-02 12:18:19'),
(160, 35, 'helpful', '2026-11-02 18:46:19'),
(160, 43, 'helpful', '2026-11-02 16:49:19'),
(160, 51, 'love', '2026-11-02 21:36:19'),
(161, 30, 'like', '2026-11-03 06:59:19'),
(161, 36, 'like', '2026-11-03 01:39:19'),
(161, 39, 'love', '2026-11-03 00:27:19'),
(161, 51, 'like', '2026-11-03 02:20:19'),
(163, 21, 'like', '2026-11-03 07:59:19'),
(164, 29, 'love', '2026-11-03 07:59:19'),
(164, 37, 'helpful', '2026-11-03 07:59:19'),
(165, 17, 'like', '2026-11-03 07:59:19'),
(165, 23, 'like', '2026-11-03 04:04:19'),
(165, 38, 'like', '2026-11-03 07:59:19'),
(166, 19, 'like', '2026-11-02 08:28:19'),
(166, 33, 'love', '2026-11-02 08:09:19'),
(166, 42, 'like', '2026-11-02 11:42:19'),
(166, 44, 'helpful', '2026-11-02 11:27:19'),
(167, 28, 'helpful', '2026-11-02 11:26:19'),
(167, 29, 'like', '2026-11-02 13:05:19'),
(167, 46, 'helpful', '2026-11-02 15:02:19'),
(168, 40, 'like', '2026-11-02 13:47:19'),
(169, 24, 'like', '2026-11-02 15:15:19'),
(169, 28, 'like', '2026-11-02 21:47:19'),
(169, 32, 'helpful', '2026-11-02 21:49:19'),
(169, 36, 'love', '2026-11-02 18:11:19'),
(169, 38, 'like', '2026-11-02 18:22:19'),
(169, 51, 'like', '2026-11-02 14:53:19'),
(171, 20, 'helpful', '2026-11-02 23:20:19'),
(171, 25, 'love', '2026-11-02 23:58:19'),
(171, 31, 'like', '2026-11-02 17:45:19'),
(171, 45, 'like', '2026-11-03 00:25:19'),
(171, 47, 'love', '2026-11-02 22:12:19'),
(171, 48, 'laugh', '2026-11-02 18:11:19'),
(173, 20, 'like', '2026-11-02 15:33:19'),
(173, 50, 'like', '2026-11-02 21:04:19'),
(173, 51, 'helpful', '2026-11-02 22:43:19'),
(174, 37, 'like', '2026-11-02 15:14:19'),
(174, 38, 'love', '2026-11-02 20:16:19'),
(174, 46, 'like', '2026-11-02 21:43:19'),
(174, 51, 'like', '2026-11-02 21:59:19'),
(175, 18, 'like', '2026-11-02 22:54:19'),
(175, 27, 'like', '2026-11-03 00:33:19'),
(175, 37, 'love', '2026-11-02 22:49:19'),
(175, 42, 'love', '2026-11-02 23:26:19'),
(176, 19, 'helpful', '2026-11-03 03:45:19'),
(177, 29, 'love', '2026-11-03 03:27:19'),
(177, 50, 'like', '2026-11-03 05:57:19'),
(178, 17, 'laugh', '2026-11-02 04:55:19'),
(178, 29, 'helpful', '2026-11-02 06:56:19'),
(178, 36, 'like', '2026-11-02 03:14:19'),
(178, 43, 'helpful', '2026-11-02 06:28:19'),
(178, 48, 'like', '2026-11-02 06:02:19'),
(179, 17, 'like', '2026-11-02 15:04:19'),
(179, 18, 'helpful', '2026-11-02 12:13:19'),
(179, 22, 'helpful', '2026-11-02 19:32:19'),
(180, 25, 'laugh', '2026-11-02 23:38:19'),
(180, 27, 'laugh', '2026-11-02 22:35:19'),
(180, 29, 'like', '2026-11-02 18:42:19'),
(180, 32, 'helpful', '2026-11-02 13:59:19'),
(180, 44, 'like', '2026-11-02 18:02:19'),
(180, 48, 'like', '2026-11-02 17:32:19'),
(181, 18, 'love', '2026-11-02 22:21:19'),
(181, 19, 'like', '2026-11-02 23:40:19'),
(181, 24, 'helpful', '2026-11-03 03:33:19'),
(181, 32, 'like', '2026-11-03 00:31:19'),
(182, 18, 'like', '2026-11-02 20:36:19'),
(182, 40, 'helpful', '2026-11-03 01:10:19'),
(182, 46, 'like', '2026-11-02 22:30:19'),
(184, 24, 'laugh', '2026-11-03 07:59:19'),
(184, 27, 'like', '2026-11-02 23:48:19'),
(184, 28, 'like', '2026-11-03 07:41:19'),
(184, 43, 'love', '2026-11-03 00:51:19'),
(184, 47, 'like', '2026-11-03 01:59:19'),
(184, 52, 'like', '2026-11-03 02:48:19'),
(185, 23, 'like', '2026-11-01 10:16:19'),
(185, 32, 'helpful', '2026-11-01 11:44:19'),
(185, 39, 'love', '2026-11-01 12:47:19'),
(185, 44, 'helpful', '2026-11-01 12:05:19'),
(186, 18, 'like', '2026-11-01 11:32:19'),
(186, 42, 'love', '2026-11-01 13:06:19'),
(187, 30, 'like', '2026-11-01 18:25:19'),
(187, 34, 'like', '2026-11-01 21:14:19'),
(187, 49, 'helpful', '2026-11-01 14:56:19'),
(188, 23, 'like', '2026-11-02 04:34:19'),
(188, 26, 'like', '2026-11-02 04:42:19'),
(188, 33, 'like', '2026-11-02 09:26:19'),
(188, 48, 'laugh', '2026-11-02 06:34:19'),
(189, 30, 'like', '2026-11-03 07:59:19'),
(189, 39, 'laugh', '2026-11-03 05:22:19'),
(189, 43, 'helpful', '2026-11-03 06:00:19'),
(189, 45, 'laugh', '2026-11-03 07:23:19'),
(189, 47, 'like', '2026-11-03 07:59:19'),
(190, 18, 'like', '2026-11-03 07:59:19'),
(190, 23, 'like', '2026-11-03 06:02:19'),
(190, 34, 'like', '2026-11-03 07:59:19'),
(191, 36, 'like', '2026-11-03 04:50:19'),
(191, 38, 'like', '2026-11-03 07:59:19');

-- --------------------------------------------------------

--
-- Table structure for table `url_tai_tro_choi`
--

CREATE TABLE `url_tai_tro_choi` (
  `ma` bigint(20) UNSIGNED NOT NULL,
  `tro_choi_id` bigint(20) UNSIGNED NOT NULL,
  `phien_ban_id` bigint(20) UNSIGNED DEFAULT NULL,
  `nguoi_dong_gop_id` bigint(20) UNSIGNED DEFAULT NULL,
  `nha_cung_cap` enum('google_drive','onedrive','dropbox','mediafire','mega','wetransfer','github','sourceforge','itch_io','custom') NOT NULL DEFAULT 'custom',
  `ten_hien_thi` varchar(200) NOT NULL,
  `url_tai` varchar(1500) NOT NULL,
  `he_dieu_ke` enum('windows','macos','linux','android','any') NOT NULL DEFAULT 'any',
  `dung_luong` varchar(40) DEFAULT NULL,
  `ghi_chu` varchar(500) DEFAULT NULL,
  `trang_thai` enum('pending','active','rejected','hidden') NOT NULL DEFAULT 'active',
  `ly_do_tu_choi` varchar(500) DEFAULT NULL,
  `thu_tu_sap_xep` int(11) NOT NULL DEFAULT 0,
  `so_lan_tai` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `url_tai_tro_choi`
--

INSERT INTO `url_tai_tro_choi` (`ma`, `tro_choi_id`, `phien_ban_id`, `nguoi_dong_gop_id`, `nha_cung_cap`, `ten_hien_thi`, `url_tai`, `he_dieu_ke`, `dung_luong`, `ghi_chu`, `trang_thai`, `ly_do_tu_choi`, `thu_tu_sap_xep`, `so_lan_tai`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(1, 4, 11, NULL, 'google_drive', 'Bản Windows 1.4 — Google Drive', 'https://drive.google.com/file/d/1SuperTuxKart14Win/view', 'windows', '412 MB', 'Bản dành cho Windows 64-bit. Giải nén bằng 7-Zip.', 'active', NULL, 0, 1842, '2026-10-18 09:12:00', '2026-10-18 09:12:00'),
(2, 4, 11, NULL, 'onedrive', 'Mirror 2 — OneDrive', 'https://onedrive.live.com/?id=1SuperTuxKart14', 'any', '405 MB', 'Nguồn dự phòng, tốc độ ổn định hơn.', 'active', NULL, 1, 1136, '2026-10-18 09:20:00', '2026-10-18 09:20:00'),
(3, 4, 11, NULL, 'mediafire', 'Mirror 3 — MediaFire', 'https://www.mediafire.com/file/supertuxkart/super-tuxkart-1.4-win.zip', 'windows', '409 MB', NULL, 'active', NULL, 2, 742, '2026-10-19 14:05:00', '2026-10-19 14:05:00'),
(4, 4, 11, NULL, 'github', 'Bản mã nguồn — GitHub Releases', 'https://github.com/supertuxkart/supertuxkart/releases/tag/1.4', 'any', '92 MB', 'Bản build từ mã nguồn, cần cài đặt thủ công.', 'active', NULL, 3, 318, '2026-10-20 10:41:00', '2026-10-20 10:41:00'),
(5, 4, 12, NULL, 'mega', 'Mirror 4 — MEGA', 'https://mega.nz/file/supertuxkart14linux#key', 'linux', '398 MB', 'Bản Linux 64-bit.', 'active', NULL, 4, 254, '2026-10-21 08:33:00', '2026-10-21 08:33:00'),
(6, 4, 12, NULL, 'dropbox', 'Mirror 5 — Dropbox', 'https://www.dropbox.com/s/supertuxkart/1.5-game.zip?dl=1', 'any', '410 MB', NULL, 'active', NULL, 5, 187, '2026-10-22 16:47:00', '2026-10-22 16:47:00'),
(7, 5, 13, NULL, 'sourceforge', 'Wesnoth 1.18.6 — Windows', 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.18.6/', 'windows', '520 MB', 'Trình cài đặt chính thức.', 'active', NULL, 0, 964, '2026-10-12 11:20:00', '2026-10-12 11:20:00'),
(8, 5, 13, NULL, 'wetransfer', 'Mirror 2 — WeTransfer', 'https://wetransfer.com/downloads/1.18.6', 'any', '515 MB', 'Link dự phòng, có thể hết hạn.', 'active', NULL, 1, 433, '2026-10-13 09:02:00', '2026-10-13 09:02:00'),
(9, 6, 17, NULL, 'itch_io', 'Luanti 5.16.1 — Windows', 'https://luanti.itch.io/windows', 'windows', '118 MB', 'Bản cài đặt chính thức.', 'active', NULL, 0, 1320, '2026-10-08 07:55:00', '2026-10-08 07:55:00'),
(10, 6, 17, NULL, 'github', 'Mirror 2 — GitHub Releases', 'https://github.com/luanti-org/luanti/releases/tag/5.16.1', 'any', '112 MB', 'Bản portable cho Windows.', 'active', NULL, 1, 507, '2026-10-09 13:26:00', '2026-10-09 13:26:00'),
(11, 7, 20, NULL, 'google_drive', 'Mindustry 8 — Windows', 'https://drive.google.com/file/d/1MindustryBuild158/view', 'windows', '260 MB', 'Bản Java, cần cài JRE 17.', 'active', NULL, 0, 876, '2026-10-05 10:14:00', '2026-10-05 10:14:00'),
(12, 7, 21, NULL, 'onedrive', 'Mirror 2 — OneDrive', 'https://onedrive.live.com/?id=1MindustryBuild160', 'any', '258 MB', NULL, 'active', NULL, 1, 391, '2026-10-06 15:48:00', '2026-10-06 15:48:00'),
(13, 8, 24, NULL, 'mediafire', 'OpenTTD 15.2 — Windows', 'https://www.mediafire.com/file/openttd/openttd-15.2-win.zip', 'windows', '35 MB', NULL, 'active', NULL, 0, 612, '2026-09-28 08:40:00', '2026-09-28 08:40:00'),
(14, 15, NULL, NULL, 'google_drive', 'Stardew Valley — Windows', 'https://drive.google.com/file/d/1StardewValleyWin/view', 'windows', '1.2 GB', 'Bản chính thức của ConcernedApe.', 'active', NULL, 0, 2480, '2026-09-20 12:00:00', '2026-09-20 12:00:00'),
(15, 15, NULL, NULL, 'onedrive', 'Mirror 2 — OneDrive', 'https://onedrive.live.com/?id=1StardewValleyMac', 'macos', '1.3 GB', 'Bản macOS.', 'active', NULL, 1, 1105, '2026-09-21 09:25:00', '2026-09-21 09:25:00'),
(16, 16, NULL, NULL, 'mega', 'Hollow Knight — Windows', 'https://mega.nz/file/hollowknightwin#key', 'windows', '890 MB', 'Cần giải nén 7-Zip.', 'active', NULL, 0, 1733, '2026-09-14 17:32:00', '2026-09-14 17:32:00'),
(17, 17, NULL, NULL, 'google_drive', 'Celeste 1.4 — Windows', 'https://drive.google.com/file/d/1CelesteWin/view', 'windows', '310 MB', NULL, 'active', NULL, 0, 1520, '2026-09-10 11:11:00', '2026-09-10 11:11:00'),
(18, 18, NULL, NULL, 'dropbox', 'Hades — Windows', 'https://www.dropbox.com/s/hadesgame/hades-win.zip?dl=1', 'windows', '1.1 GB', 'Bản Early Access cũ.', 'active', NULL, 0, 987, '2026-09-06 14:44:00', '2026-09-06 14:44:00'),
(19, 19, NULL, NULL, 'mega', 'Dead Cells — Windows', 'https://mega.nz/file/deadcellswin#key', 'windows', '420 MB', 'Cần giải nén 7-Zip.', 'active', NULL, 0, 845, '2026-09-02 20:15:00', '2026-09-02 20:15:00'),
(20, 20, NULL, NULL, 'google_drive', 'Slay the Spire — Windows', 'https://drive.google.com/file/d/1SlayTheSpire/view', 'windows', '640 MB', NULL, 'active', NULL, 0, 1204, '2026-08-28 09:08:00', '2026-08-28 09:08:00'),
(21, 4, 11, 17, 'custom', 'Mirror 6 — Link dự phòng của người chơi', 'https://example.org/mirror/supertuxkart-1.4', 'any', '410 MB', 'Link gửi bởi người chơi, đang chờ nhà phát triển duyệt.', 'pending', NULL, 6, 0, '2026-10-23 08:30:00', '2026-10-23 08:30:00'),
(22, 5, 13, 5, 'custom', 'Mirror 3 — Link hỏng', 'https://example.net/broken-link', 'any', '515 MB', NULL, 'rejected', 'Link không tải được, đã hết hạn.', 1, 0, '2026-10-14 10:05:00', '2026-10-15 09:12:00'),
(23, 4, 12, NULL, 'custom', 'Bản Linux cũ — ẩn khỏi danh sách', 'https://example.com/supertuxkart-linux-old', 'linux', '390 MB', 'Đã lỗi thời.', 'hidden', NULL, 7, 0, '2026-08-02 09:00:00', '2026-08-10 09:00:00'),
(74, 78, 61, NULL, 'google_drive', 'Bản chính 1.1.0 — Google Drive', 'https://drive.google.com/file/d/1DemoTinhHoa110/view', 'windows', '1.2 GB', 'Nguồn chính thức. Giải nén bằng 7-Zip.', 'active', NULL, 0, 1842, '2026-10-18 09:12:00', '2026-10-18 09:12:00'),
(75, 78, 61, NULL, 'onedrive', 'Mirror 2 — OneDrive', 'https://onedrive.live.com/?id=1DemoTinhHoa110', 'any', '1.1 GB', 'Nguồn dự phòng, tốc độ tải ổn định hơn.', 'active', NULL, 1, 1136, '2026-10-18 09:20:00', '2026-10-18 09:20:00'),
(76, 78, 61, NULL, 'mediafire', 'Mirror 3 — MediaFire', 'https://www.mediafire.com/file/tinhhoaduongson/tinh-hoa-1.1.0-win.zip', 'windows', '1.15 GB', NULL, 'active', NULL, 2, 742, '2026-10-19 14:05:00', '2026-10-19 14:05:00'),
(77, 78, 61, NULL, 'mega', 'Mirror 4 — MEGA', 'https://mega.nz/file/demoTinhHoa110#key', 'any', '1.18 GB', 'Cần giải nén 7-Zip.', 'active', NULL, 3, 587, '2026-10-21 08:33:00', '2026-10-21 08:33:00'),
(78, 78, 61, NULL, 'dropbox', 'Mirror 5 — Dropbox', 'https://www.dropbox.com/s/demo/tinh-hoa-1.1.0.zip?dl=1', 'any', '1.13 GB', NULL, 'active', NULL, 4, 419, '2026-10-22 16:47:00', '2026-10-22 16:47:00'),
(79, 78, 61, NULL, 'github', 'Bản mã nguồn — GitHub Releases', 'https://github.com/demo-studio/tinh-hoa-duong-son/releases/tag/1.1.0', 'any', '86 MB', 'Bản build từ mã nguồn, người chơi tự cài đặt.', 'active', NULL, 5, 233, '2026-10-23 10:41:00', '2026-10-23 10:41:00'),
(80, 78, 60, NULL, 'sourceforge', 'Bản cũ 1.0.0 — SourceForge', 'https://sourceforge.net/projects/tinhhoaduongson/files/1.0.0/', 'windows', '980 MB', 'Phiên bản 1.0.0, dành cho máy cấu hình thấp.', 'active', NULL, 6, 318, '2026-10-24 08:15:00', '2026-10-24 08:15:00'),
(81, 78, 61, 173, 'custom', 'Mirror 6 — Link dự phòng của người chơi', 'https://example.org/mirror/tinh-hoa-1.1.0', 'any', '1.12 GB', 'Link gửi bởi người chơi, đang chờ nhà phát triển duyệt.', 'pending', NULL, 7, 0, '2026-10-25 08:30:00', '2026-10-25 08:30:00'),
(82, 78, 61, 173, 'custom', 'Mirror 7 — Link không tải được', 'https://example.net/broken-mirror', 'any', '1.12 GB', NULL, 'rejected', 'Link trả về lỗi 404, không tải được. Vui lòng gửi lại link khác.', 8, 0, '2026-10-26 10:05:00', '2026-10-27 09:12:00'),
(83, 78, 60, NULL, 'custom', 'Bản Linux cũ — đã ẩn', 'https://example.com/tinh-hoa-1.0.0-linux', 'linux', '950 MB', 'Đã lỗi thời, không còn dùng.', 'hidden', NULL, 9, 0, '2026-10-02 09:00:00', '2026-10-10 09:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `vai_tro`
--

CREATE TABLE `vai_tro` (
  `ma` smallint(5) UNSIGNED NOT NULL,
  `ma_vai_tro` varchar(40) NOT NULL,
  `ten_vai_tro` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vai_tro`
--

INSERT INTO `vai_tro` (`ma`, `ma_vai_tro`, `ten_vai_tro`) VALUES
(1, 'player', 'Người chơi'),
(2, 'developer', 'Nhà phát triển'),
(3, 'moderator', 'Điều hành viên'),
(4, 'admin', 'Quản trị viên');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bai_du_thi`
--
ALTER TABLE `bai_du_thi`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `uq_jam_game` (`cuoc_thi_id`,`tro_choi_id`),
  ADD KEY `tro_choi_id` (`tro_choi_id`),
  ADD KEY `nguoi_nop_id` (`nguoi_nop_id`);

--
-- Indexes for table `bai_viet_thao_luan`
--
ALTER TABLE `bai_viet_thao_luan`
  ADD PRIMARY KEY (`ma`),
  ADD KEY `tac_gia_nguoi_dung_id` (`tac_gia_nguoi_dung_id`),
  ADD KEY `idx_community_posts_topic_date` (`chu_de_id`,`ngay_tao`),
  ADD KEY `idx_community_posts_parent` (`bai_viet_cha_id`);

--
-- Indexes for table `bao_cao_noi_dung`
--
ALTER TABLE `bao_cao_noi_dung`
  ADD PRIMARY KEY (`ma`),
  ADD KEY `nguoi_bao_cao_id` (`nguoi_bao_cao_id`),
  ADD KEY `nguoi_duoc_phan_cong_id` (`nguoi_duoc_phan_cong_id`),
  ADD KEY `idx_reports_status_date` (`trang_thai`,`ngay_tao`),
  ADD KEY `idx_reports_target` (`loai_doi_tuong`,`doi_tuong_id`);

--
-- Indexes for table `binh_chon_bai_du_thi`
--
ALTER TABLE `binh_chon_bai_du_thi`
  ADD PRIMARY KEY (`bai_du_thi_id`,`nguoi_binh_chon_id`,`tieu_chi`),
  ADD KEY `nguoi_binh_chon_id` (`nguoi_binh_chon_id`);

--
-- Indexes for table `binh_chon_danh_gia`
--
ALTER TABLE `binh_chon_danh_gia`
  ADD PRIMARY KEY (`danh_gia_id`,`nguoi_dung_id`),
  ADD KEY `nguoi_dung_id` (`nguoi_dung_id`);

--
-- Indexes for table `binh_luan_nhat_ky`
--
ALTER TABLE `binh_luan_nhat_ky`
  ADD PRIMARY KEY (`ma`),
  ADD KEY `nguoi_dung_id` (`nguoi_dung_id`),
  ADD KEY `binh_luan_cha_id` (`binh_luan_cha_id`),
  ADD KEY `idx_devlog_comments_post` (`nhat_ky_phat_trien_id`,`ngay_tao`);

--
-- Indexes for table `binh_luan_tro_choi`
--
ALTER TABLE `binh_luan_tro_choi`
  ADD PRIMARY KEY (`ma`),
  ADD KEY `nguoi_dung_id` (`nguoi_dung_id`),
  ADD KEY `idx_game_comments_game_date` (`tro_choi_id`,`ngay_tao`),
  ADD KEY `idx_game_comments_parent` (`binh_luan_cha_id`);

--
-- Indexes for table `bo_suu_tap`
--
ALTER TABLE `bo_suu_tap`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `uq_collection_owner_slug` (`nguoi_dung_so_huu_id`,`duong_dan_rut_gon`);

--
-- Indexes for table `cai_dat_nguoi_dung`
--
ALTER TABLE `cai_dat_nguoi_dung`
  ADD PRIMARY KEY (`nguoi_dung_id`);

--
-- Indexes for table `cai_dat_trang_tro_choi`
--
ALTER TABLE `cai_dat_trang_tro_choi`
  ADD PRIMARY KEY (`tro_choi_id`);

--
-- Indexes for table `chien_dich_giam_gia`
--
ALTER TABLE `chien_dich_giam_gia`
  ADD PRIMARY KEY (`ma`),
  ADD KEY `nguoi_tao_id` (`nguoi_tao_id`),
  ADD KEY `idx_discount_campaign_dates` (`trang_thai`,`ngay_bat_dau`,`ngay_ket_thuc`);

--
-- Indexes for table `chi_tiet_chi_tra`
--
ALTER TABLE `chi_tiet_chi_tra`
  ADD PRIMARY KEY (`dot_chi_tra_id`,`so_ke_toan_id`),
  ADD KEY `so_ke_toan_id` (`so_ke_toan_id`);

--
-- Indexes for table `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  ADD PRIMARY KEY (`ma`),
  ADD KEY `nguoi_nhan_qua_id` (`nguoi_nhan_qua_id`),
  ADD KEY `idx_order_items_order` (`don_hang_id`),
  ADD KEY `idx_order_items_game` (`tro_choi_id`),
  ADD KEY `idx_order_items_bundle` (`goi_game_id`);

--
-- Indexes for table `chu_de_thao_luan`
--
ALTER TABLE `chu_de_thao_luan`
  ADD PRIMARY KEY (`ma`),
  ADD KEY `tac_gia_nguoi_dung_id` (`tac_gia_nguoi_dung_id`),
  ADD KEY `idx_community_topics_board` (`dien_dan_id`,`da_ghim`,`ngay_tao`);

--
-- Indexes for table `cuoc_thi_lam_game`
--
ALTER TABLE `cuoc_thi_lam_game`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `duong_dan_rut_gon` (`duong_dan_rut_gon`),
  ADD KEY `nguoi_tao_id` (`nguoi_tao_id`),
  ADD KEY `idx_jams_status_dates` (`trang_thai`,`ngay_bat_dau`,`han_nop_bai`);

--
-- Indexes for table `danh_gia`
--
ALTER TABLE `danh_gia`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `uq_reviews_user_game` (`nguoi_dung_id`,`tro_choi_id`),
  ADD KEY `idx_reviews_game_date` (`tro_choi_id`,`ngay_tao`);

--
-- Indexes for table `dien_dan`
--
ALTER TABLE `dien_dan`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `uq_board_game` (`tro_choi_id`),
  ADD UNIQUE KEY `uq_board_jam` (`cuoc_thi_id`);

--
-- Indexes for table `don_hang`
--
ALTER TABLE `don_hang`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `ma_don_hang` (`ma_don_hang`),
  ADD KEY `idx_orders_buyer_date` (`nguoi_mua_id`,`ngay_dat_hang`),
  ADD KEY `idx_orders_status_date` (`trang_thai`,`ngay_dat_hang`);

--
-- Indexes for table `dot_chi_tra`
--
ALTER TABLE `dot_chi_tra`
  ADD PRIMARY KEY (`ma`),
  ADD KEY `tai_khoan_nhan_tien_id` (`tai_khoan_nhan_tien_id`),
  ADD KEY `idx_payouts_user_status` (`nguoi_dung_id`,`trang_thai`,`ngay_yeu_cau`);

--
-- Indexes for table `gio_hang`
--
ALTER TABLE `gio_hang`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `uq_carts_user` (`nguoi_dung_id`);

--
-- Indexes for table `goi_game`
--
ALTER TABLE `goi_game`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `duong_dan_rut_gon` (`duong_dan_rut_gon`),
  ADD KEY `nguoi_tao_id` (`nguoi_tao_id`),
  ADD KEY `idx_bundles_status_dates` (`trang_thai`,`ngay_bat_dau`,`ngay_ket_thuc`);

--
-- Indexes for table `hanh_dong_kiem_duyet`
--
ALTER TABLE `hanh_dong_kiem_duyet`
  ADD PRIMARY KEY (`ma`),
  ADD KEY `idx_moderation_target` (`loai_doi_tuong`,`doi_tuong_id`),
  ADD KEY `idx_moderation_moderator_date` (`nguoi_kiem_duyet_id`,`ngay_tao`);

--
-- Indexes for table `hoan_tien`
--
ALTER TABLE `hoan_tien`
  ADD PRIMARY KEY (`ma`),
  ADD KEY `thanh_toan_id` (`thanh_toan_id`),
  ADD KEY `chi_tiet_don_hang_id` (`chi_tiet_don_hang_id`),
  ADD KEY `nguoi_yeu_cau_id` (`nguoi_yeu_cau_id`),
  ADD KEY `idx_refunds_status_date` (`trang_thai`,`ngay_tao`);

--
-- Indexes for table `luot_dung_ma_giam_gia`
--
ALTER TABLE `luot_dung_ma_giam_gia`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `uq_coupon_order` (`ma_giam_gia_id`,`don_hang_id`),
  ADD KEY `don_hang_id` (`don_hang_id`),
  ADD KEY `nguoi_dung_id` (`nguoi_dung_id`);

--
-- Indexes for table `ma_giam_gia`
--
ALTER TABLE `ma_giam_gia`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `ma_uu_dai` (`ma_uu_dai`),
  ADD KEY `idx_coupon_creator` (`nguoi_tao_id`);

--
-- Indexes for table `ma_truy_cap_tro_choi`
--
ALTER TABLE `ma_truy_cap_tro_choi`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `ma_bam` (`ma_bam`),
  ADD KEY `nguoi_tao_ma_id` (`nguoi_tao_ma_id`),
  ADD KEY `nguoi_nhan_ma_id` (`nguoi_nhan_ma_id`),
  ADD KEY `idx_access_keys_game_status` (`tro_choi_id`,`trang_thai`);

--
-- Indexes for table `ma_xac_nhan_dat_lai_mat_khau`
--
ALTER TABLE `ma_xac_nhan_dat_lai_mat_khau`
  ADD PRIMARY KEY (`ma`),
  ADD KEY `idx_reset_codes_user` (`nguoi_dung_id`,`da_su_dung`);

--
-- Indexes for table `media_tro_choi`
--
ALTER TABLE `media_tro_choi`
  ADD PRIMARY KEY (`ma`),
  ADD KEY `idx_game_media_order` (`tro_choi_id`,`loai_media`,`thu_tu_sap_xep`);

--
-- Indexes for table `muc_gio_hang`
--
ALTER TABLE `muc_gio_hang`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `uq_cart_game` (`gio_hang_id`,`tro_choi_id`),
  ADD UNIQUE KEY `uq_cart_bundle` (`gio_hang_id`,`goi_game_id`),
  ADD KEY `tro_choi_id` (`tro_choi_id`),
  ADD KEY `goi_game_id` (`goi_game_id`);

--
-- Indexes for table `nen_tang`
--
ALTER TABLE `nen_tang`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `ma_nen_tang` (`ma_nen_tang`);

--
-- Indexes for table `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `uq_users_username` (`ten_dang_nhap`),
  ADD UNIQUE KEY `uq_users_email` (`email`),
  ADD KEY `idx_users_status` (`trang_thai`);

--
-- Indexes for table `nguoi_dung_vai_tro`
--
ALTER TABLE `nguoi_dung_vai_tro`
  ADD PRIMARY KEY (`nguoi_dung_id`,`vai_tro_id`),
  ADD KEY `vai_tro_id` (`vai_tro_id`);

--
-- Indexes for table `nhan`
--
ALTER TABLE `nhan`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `uq_tags_name` (`ten`),
  ADD UNIQUE KEY `uq_tags_slug` (`duong_dan_rut_gon`);

--
-- Indexes for table `nhat_ky_he_thong`
--
ALTER TABLE `nhat_ky_he_thong`
  ADD PRIMARY KEY (`ma`),
  ADD KEY `idx_audit_user_date` (`nguoi_dung_id`,`ngay_tao`),
  ADD KEY `idx_audit_entity` (`loai_thuc_the`,`thuc_the_id`);

--
-- Indexes for table `nhat_ky_phat_trien`
--
ALTER TABLE `nhat_ky_phat_trien`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `uq_devlog_game_slug` (`tro_choi_id`,`duong_dan_rut_gon`),
  ADD KEY `tac_gia_nguoi_dung_id` (`tac_gia_nguoi_dung_id`),
  ADD KEY `idx_devlogs_game_published` (`tro_choi_id`,`trang_thai`,`ngay_cong_bo`);

--
-- Indexes for table `phien_ban_phat_hanh`
--
ALTER TABLE `phien_ban_phat_hanh`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `uq_game_release_version` (`tro_choi_id`,`ten_phien_ban`,`kenh_phat_hanh`),
  ADD KEY `nguoi_tao_id` (`nguoi_tao_id`),
  ADD KEY `idx_releases_game_date` (`tro_choi_id`,`ngay_phat_hanh`);

--
-- Indexes for table `quyen_so_huu_tro_choi`
--
ALTER TABLE `quyen_so_huu_tro_choi`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `uq_ownership_user_game` (`nguoi_dung_id`,`tro_choi_id`),
  ADD KEY `idx_ownership_game` (`tro_choi_id`),
  ADD KEY `idx_ownership_order_item` (`chi_tiet_don_hang_id`);

--
-- Indexes for table `so_ke_toan_tac_gia`
--
ALTER TABLE `so_ke_toan_tac_gia`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `uq_ledger_order_author` (`chi_tiet_don_hang_id`,`nguoi_dung_id`),
  ADD KEY `idx_creator_ledger_user_status` (`nguoi_dung_id`,`trang_thai`,`ngay_tao`);

--
-- Indexes for table `tac_gia_tro_choi`
--
ALTER TABLE `tac_gia_tro_choi`
  ADD PRIMARY KEY (`tro_choi_id`,`nguoi_dung_id`),
  ADD KEY `idx_game_authors_user` (`nguoi_dung_id`,`tro_choi_id`),
  ADD KEY `idx_game_authors_order` (`tro_choi_id`,`thu_tu_hien_thi`);

--
-- Indexes for table `tai_khoan_nhan_tien_nguoi_dung`
--
ALTER TABLE `tai_khoan_nhan_tien_nguoi_dung`
  ADD PRIMARY KEY (`ma`),
  ADD KEY `idx_payout_accounts_user` (`nguoi_dung_id`,`trang_thai`);

--
-- Indexes for table `thanh_toan`
--
ALTER TABLE `thanh_toan`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `uq_payment_provider_tx` (`nha_cung_cap`,`ma_giao_dich_nha_cung_cap`),
  ADD KEY `idx_payments_order_status` (`don_hang_id`,`trang_thai`);

--
-- Indexes for table `thanh_vien_cuoc_thi`
--
ALTER TABLE `thanh_vien_cuoc_thi`
  ADD PRIMARY KEY (`cuoc_thi_id`,`nguoi_dung_id`),
  ADD KEY `nguoi_dung_id` (`nguoi_dung_id`);

--
-- Indexes for table `theo_doi_nguoi_dung`
--
ALTER TABLE `theo_doi_nguoi_dung`
  ADD PRIMARY KEY (`nguoi_theo_doi_id`,`nguoi_duoc_theo_doi_id`),
  ADD KEY `nguoi_duoc_theo_doi_id` (`nguoi_duoc_theo_doi_id`);

--
-- Indexes for table `theo_doi_tro_choi`
--
ALTER TABLE `theo_doi_tro_choi`
  ADD PRIMARY KEY (`nguoi_dung_id`,`tro_choi_id`),
  ADD KEY `tro_choi_id` (`tro_choi_id`);

--
-- Indexes for table `the_loai`
--
ALTER TABLE `the_loai`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `uq_categories_name` (`ten`),
  ADD UNIQUE KEY `uq_categories_slug` (`duong_dan_rut_gon`);

--
-- Indexes for table `thong_bao`
--
ALTER TABLE `thong_bao`
  ADD PRIMARY KEY (`ma`),
  ADD KEY `idx_notifications_user_read` (`nguoi_dung_id`,`da_doc`,`ngay_tao`);

--
-- Indexes for table `thong_ke_tro_choi_hang_ngay`
--
ALTER TABLE `thong_ke_tro_choi_hang_ngay`
  ADD PRIMARY KEY (`tro_choi_id`,`ngay_thong_ke`);

--
-- Indexes for table `tro_choi`
--
ALTER TABLE `tro_choi`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `uq_games_slug` (`duong_dan_rut_gon`),
  ADD KEY `idx_games_creator_status` (`nguoi_tao_id`,`trang_thai`),
  ADD KEY `idx_games_status_published` (`trang_thai`,`ngay_cong_bo`),
  ADD KEY `idx_games_title` (`tieu_de`);

--
-- Indexes for table `tro_choi_bo_suu_tap`
--
ALTER TABLE `tro_choi_bo_suu_tap`
  ADD PRIMARY KEY (`bo_suu_tap_id`,`tro_choi_id`),
  ADD KEY `tro_choi_id` (`tro_choi_id`),
  ADD KEY `nguoi_them_id` (`nguoi_them_id`),
  ADD KEY `idx_collection_games_position` (`bo_suu_tap_id`,`vi_tri`);

--
-- Indexes for table `tro_choi_giam_gia`
--
ALTER TABLE `tro_choi_giam_gia`
  ADD PRIMARY KEY (`chien_dich_id`,`tro_choi_id`),
  ADD KEY `tro_choi_id` (`tro_choi_id`);

--
-- Indexes for table `tro_choi_goi_game`
--
ALTER TABLE `tro_choi_goi_game`
  ADD PRIMARY KEY (`goi_game_id`,`tro_choi_id`),
  ADD KEY `idx_bundle_games_game` (`tro_choi_id`);

--
-- Indexes for table `tro_choi_nen_tang`
--
ALTER TABLE `tro_choi_nen_tang`
  ADD PRIMARY KEY (`tro_choi_id`,`nen_tang_id`),
  ADD KEY `nen_tang_id` (`nen_tang_id`);

--
-- Indexes for table `tro_choi_nhan`
--
ALTER TABLE `tro_choi_nhan`
  ADD PRIMARY KEY (`tro_choi_id`,`nhan_id`),
  ADD KEY `nhan_id` (`nhan_id`);

--
-- Indexes for table `tro_choi_the_loai`
--
ALTER TABLE `tro_choi_the_loai`
  ADD PRIMARY KEY (`tro_choi_id`,`the_loai_id`),
  ADD KEY `the_loai_id` (`the_loai_id`);

--
-- Indexes for table `tro_choi_yeu_thich`
--
ALTER TABLE `tro_choi_yeu_thich`
  ADD PRIMARY KEY (`nguoi_dung_id`,`tro_choi_id`),
  ADD KEY `tro_choi_id` (`tro_choi_id`);

--
-- Indexes for table `tuong_tac_bai_viet`
--
ALTER TABLE `tuong_tac_bai_viet`
  ADD PRIMARY KEY (`bai_viet_id`,`nguoi_dung_id`,`phan_ung`),
  ADD KEY `nguoi_dung_id` (`nguoi_dung_id`);

--
-- Indexes for table `url_tai_tro_choi`
--
ALTER TABLE `url_tai_tro_choi`
  ADD PRIMARY KEY (`ma`),
  ADD KEY `idx_download_links_game` (`tro_choi_id`,`trang_thai`,`thu_tu_sap_xep`),
  ADD KEY `phien_ban_id` (`phien_ban_id`),
  ADD KEY `nguoi_dong_gop_id` (`nguoi_dong_gop_id`),
  ADD KEY `idx_link_contributor` (`nguoi_dong_gop_id`,`trang_thai`);

--
-- Indexes for table `vai_tro`
--
ALTER TABLE `vai_tro`
  ADD PRIMARY KEY (`ma`),
  ADD UNIQUE KEY `ma_vai_tro` (`ma_vai_tro`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bai_du_thi`
--
ALTER TABLE `bai_du_thi`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `bai_viet_thao_luan`
--
ALTER TABLE `bai_viet_thao_luan`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=192;

--
-- AUTO_INCREMENT for table `bao_cao_noi_dung`
--
ALTER TABLE `bao_cao_noi_dung`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `binh_luan_nhat_ky`
--
ALTER TABLE `binh_luan_nhat_ky`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `binh_luan_tro_choi`
--
ALTER TABLE `binh_luan_tro_choi`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT for table `bo_suu_tap`
--
ALTER TABLE `bo_suu_tap`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `chien_dich_giam_gia`
--
ALTER TABLE `chien_dich_giam_gia`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chu_de_thao_luan`
--
ALTER TABLE `chu_de_thao_luan`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `cuoc_thi_lam_game`
--
ALTER TABLE `cuoc_thi_lam_game`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `danh_gia`
--
ALTER TABLE `danh_gia`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dien_dan`
--
ALTER TABLE `dien_dan`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `don_hang`
--
ALTER TABLE `don_hang`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dot_chi_tra`
--
ALTER TABLE `dot_chi_tra`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gio_hang`
--
ALTER TABLE `gio_hang`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `goi_game`
--
ALTER TABLE `goi_game`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hanh_dong_kiem_duyet`
--
ALTER TABLE `hanh_dong_kiem_duyet`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `hoan_tien`
--
ALTER TABLE `hoan_tien`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `luot_dung_ma_giam_gia`
--
ALTER TABLE `luot_dung_ma_giam_gia`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ma_giam_gia`
--
ALTER TABLE `ma_giam_gia`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ma_truy_cap_tro_choi`
--
ALTER TABLE `ma_truy_cap_tro_choi`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `ma_xac_nhan_dat_lai_mat_khau`
--
ALTER TABLE `ma_xac_nhan_dat_lai_mat_khau`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `media_tro_choi`
--
ALTER TABLE `media_tro_choi`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=274;

--
-- AUTO_INCREMENT for table `muc_gio_hang`
--
ALTER TABLE `muc_gio_hang`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nen_tang`
--
ALTER TABLE `nen_tang`
  MODIFY `ma` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=174;

--
-- AUTO_INCREMENT for table `nhan`
--
ALTER TABLE `nhan`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `nhat_ky_he_thong`
--
ALTER TABLE `nhat_ky_he_thong`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=213;

--
-- AUTO_INCREMENT for table `nhat_ky_phat_trien`
--
ALTER TABLE `nhat_ky_phat_trien`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `phien_ban_phat_hanh`
--
ALTER TABLE `phien_ban_phat_hanh`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `quyen_so_huu_tro_choi`
--
ALTER TABLE `quyen_so_huu_tro_choi`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=505;

--
-- AUTO_INCREMENT for table `so_ke_toan_tac_gia`
--
ALTER TABLE `so_ke_toan_tac_gia`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tai_khoan_nhan_tien_nguoi_dung`
--
ALTER TABLE `tai_khoan_nhan_tien_nguoi_dung`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `thanh_toan`
--
ALTER TABLE `thanh_toan`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `the_loai`
--
ALTER TABLE `the_loai`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `thong_bao`
--
ALTER TABLE `thong_bao`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=338;

--
-- AUTO_INCREMENT for table `tro_choi`
--
ALTER TABLE `tro_choi`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `url_tai_tro_choi`
--
ALTER TABLE `url_tai_tro_choi`
  MODIFY `ma` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT for table `vai_tro`
--
ALTER TABLE `vai_tro`
  MODIFY `ma` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bai_du_thi`
--
ALTER TABLE `bai_du_thi`
  ADD CONSTRAINT `bai_du_thi_ibfk_1` FOREIGN KEY (`cuoc_thi_id`) REFERENCES `cuoc_thi_lam_game` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `bai_du_thi_ibfk_2` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `bai_du_thi_ibfk_3` FOREIGN KEY (`nguoi_nop_id`) REFERENCES `nguoi_dung` (`ma`);

--
-- Constraints for table `bai_viet_thao_luan`
--
ALTER TABLE `bai_viet_thao_luan`
  ADD CONSTRAINT `bai_viet_thao_luan_ibfk_1` FOREIGN KEY (`chu_de_id`) REFERENCES `chu_de_thao_luan` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `bai_viet_thao_luan_ibfk_2` FOREIGN KEY (`tac_gia_nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `bai_viet_thao_luan_ibfk_3` FOREIGN KEY (`bai_viet_cha_id`) REFERENCES `bai_viet_thao_luan` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `bao_cao_noi_dung`
--
ALTER TABLE `bao_cao_noi_dung`
  ADD CONSTRAINT `bao_cao_noi_dung_ibfk_1` FOREIGN KEY (`nguoi_bao_cao_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE SET NULL,
  ADD CONSTRAINT `bao_cao_noi_dung_ibfk_2` FOREIGN KEY (`nguoi_duoc_phan_cong_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE SET NULL;

--
-- Constraints for table `binh_chon_bai_du_thi`
--
ALTER TABLE `binh_chon_bai_du_thi`
  ADD CONSTRAINT `binh_chon_bai_du_thi_ibfk_1` FOREIGN KEY (`bai_du_thi_id`) REFERENCES `bai_du_thi` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `binh_chon_bai_du_thi_ibfk_2` FOREIGN KEY (`nguoi_binh_chon_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `binh_chon_danh_gia`
--
ALTER TABLE `binh_chon_danh_gia`
  ADD CONSTRAINT `binh_chon_danh_gia_ibfk_1` FOREIGN KEY (`danh_gia_id`) REFERENCES `danh_gia` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `binh_chon_danh_gia_ibfk_2` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `binh_luan_nhat_ky`
--
ALTER TABLE `binh_luan_nhat_ky`
  ADD CONSTRAINT `binh_luan_nhat_ky_ibfk_1` FOREIGN KEY (`nhat_ky_phat_trien_id`) REFERENCES `nhat_ky_phat_trien` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `binh_luan_nhat_ky_ibfk_2` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `binh_luan_nhat_ky_ibfk_3` FOREIGN KEY (`binh_luan_cha_id`) REFERENCES `binh_luan_nhat_ky` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `binh_luan_tro_choi`
--
ALTER TABLE `binh_luan_tro_choi`
  ADD CONSTRAINT `binh_luan_tro_choi_ibfk_1` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `binh_luan_tro_choi_ibfk_2` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `binh_luan_tro_choi_ibfk_3` FOREIGN KEY (`binh_luan_cha_id`) REFERENCES `binh_luan_tro_choi` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `bo_suu_tap`
--
ALTER TABLE `bo_suu_tap`
  ADD CONSTRAINT `bo_suu_tap_ibfk_1` FOREIGN KEY (`nguoi_dung_so_huu_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `cai_dat_nguoi_dung`
--
ALTER TABLE `cai_dat_nguoi_dung`
  ADD CONSTRAINT `cai_dat_nguoi_dung_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `cai_dat_trang_tro_choi`
--
ALTER TABLE `cai_dat_trang_tro_choi`
  ADD CONSTRAINT `cai_dat_trang_tro_choi_ibfk_1` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `chien_dich_giam_gia`
--
ALTER TABLE `chien_dich_giam_gia`
  ADD CONSTRAINT `chien_dich_giam_gia_ibfk_1` FOREIGN KEY (`nguoi_tao_id`) REFERENCES `nguoi_dung` (`ma`);

--
-- Constraints for table `chi_tiet_chi_tra`
--
ALTER TABLE `chi_tiet_chi_tra`
  ADD CONSTRAINT `chi_tiet_chi_tra_ibfk_1` FOREIGN KEY (`dot_chi_tra_id`) REFERENCES `dot_chi_tra` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `chi_tiet_chi_tra_ibfk_2` FOREIGN KEY (`so_ke_toan_id`) REFERENCES `so_ke_toan_tac_gia` (`ma`);

--
-- Constraints for table `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_1` FOREIGN KEY (`don_hang_id`) REFERENCES `don_hang` (`ma`),
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_2` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`),
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_3` FOREIGN KEY (`goi_game_id`) REFERENCES `goi_game` (`ma`),
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_4` FOREIGN KEY (`nguoi_nhan_qua_id`) REFERENCES `nguoi_dung` (`ma`);

--
-- Constraints for table `chu_de_thao_luan`
--
ALTER TABLE `chu_de_thao_luan`
  ADD CONSTRAINT `chu_de_thao_luan_ibfk_1` FOREIGN KEY (`dien_dan_id`) REFERENCES `dien_dan` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `chu_de_thao_luan_ibfk_2` FOREIGN KEY (`tac_gia_nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `cuoc_thi_lam_game`
--
ALTER TABLE `cuoc_thi_lam_game`
  ADD CONSTRAINT `cuoc_thi_lam_game_ibfk_1` FOREIGN KEY (`nguoi_tao_id`) REFERENCES `nguoi_dung` (`ma`);

--
-- Constraints for table `danh_gia`
--
ALTER TABLE `danh_gia`
  ADD CONSTRAINT `danh_gia_ibfk_1` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `danh_gia_ibfk_2` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `dien_dan`
--
ALTER TABLE `dien_dan`
  ADD CONSTRAINT `dien_dan_ibfk_1` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `dien_dan_ibfk_2` FOREIGN KEY (`cuoc_thi_id`) REFERENCES `cuoc_thi_lam_game` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `don_hang`
--
ALTER TABLE `don_hang`
  ADD CONSTRAINT `don_hang_ibfk_1` FOREIGN KEY (`nguoi_mua_id`) REFERENCES `nguoi_dung` (`ma`);

--
-- Constraints for table `dot_chi_tra`
--
ALTER TABLE `dot_chi_tra`
  ADD CONSTRAINT `dot_chi_tra_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`),
  ADD CONSTRAINT `dot_chi_tra_ibfk_2` FOREIGN KEY (`tai_khoan_nhan_tien_id`) REFERENCES `tai_khoan_nhan_tien_nguoi_dung` (`ma`);

--
-- Constraints for table `gio_hang`
--
ALTER TABLE `gio_hang`
  ADD CONSTRAINT `gio_hang_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `goi_game`
--
ALTER TABLE `goi_game`
  ADD CONSTRAINT `goi_game_ibfk_1` FOREIGN KEY (`nguoi_tao_id`) REFERENCES `nguoi_dung` (`ma`);

--
-- Constraints for table `hanh_dong_kiem_duyet`
--
ALTER TABLE `hanh_dong_kiem_duyet`
  ADD CONSTRAINT `hanh_dong_kiem_duyet_ibfk_1` FOREIGN KEY (`nguoi_kiem_duyet_id`) REFERENCES `nguoi_dung` (`ma`);

--
-- Constraints for table `hoan_tien`
--
ALTER TABLE `hoan_tien`
  ADD CONSTRAINT `hoan_tien_ibfk_1` FOREIGN KEY (`thanh_toan_id`) REFERENCES `thanh_toan` (`ma`),
  ADD CONSTRAINT `hoan_tien_ibfk_2` FOREIGN KEY (`chi_tiet_don_hang_id`) REFERENCES `chi_tiet_don_hang` (`ma`),
  ADD CONSTRAINT `hoan_tien_ibfk_3` FOREIGN KEY (`nguoi_yeu_cau_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE SET NULL;

--
-- Constraints for table `luot_dung_ma_giam_gia`
--
ALTER TABLE `luot_dung_ma_giam_gia`
  ADD CONSTRAINT `luot_dung_ma_giam_gia_ibfk_1` FOREIGN KEY (`ma_giam_gia_id`) REFERENCES `ma_giam_gia` (`ma`),
  ADD CONSTRAINT `luot_dung_ma_giam_gia_ibfk_2` FOREIGN KEY (`don_hang_id`) REFERENCES `don_hang` (`ma`),
  ADD CONSTRAINT `luot_dung_ma_giam_gia_ibfk_3` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`);

--
-- Constraints for table `ma_giam_gia`
--
ALTER TABLE `ma_giam_gia`
  ADD CONSTRAINT `ma_giam_gia_ibfk_1` FOREIGN KEY (`nguoi_tao_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE SET NULL;

--
-- Constraints for table `ma_truy_cap_tro_choi`
--
ALTER TABLE `ma_truy_cap_tro_choi`
  ADD CONSTRAINT `ma_truy_cap_tro_choi_ibfk_1` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `ma_truy_cap_tro_choi_ibfk_2` FOREIGN KEY (`nguoi_tao_ma_id`) REFERENCES `nguoi_dung` (`ma`),
  ADD CONSTRAINT `ma_truy_cap_tro_choi_ibfk_3` FOREIGN KEY (`nguoi_nhan_ma_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE SET NULL;

--
-- Constraints for table `ma_xac_nhan_dat_lai_mat_khau`
--
ALTER TABLE `ma_xac_nhan_dat_lai_mat_khau`
  ADD CONSTRAINT `ma_xac_nhan_dat_lai_mat_khau_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `media_tro_choi`
--
ALTER TABLE `media_tro_choi`
  ADD CONSTRAINT `media_tro_choi_ibfk_1` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `muc_gio_hang`
--
ALTER TABLE `muc_gio_hang`
  ADD CONSTRAINT `muc_gio_hang_ibfk_1` FOREIGN KEY (`gio_hang_id`) REFERENCES `gio_hang` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `muc_gio_hang_ibfk_2` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `muc_gio_hang_ibfk_3` FOREIGN KEY (`goi_game_id`) REFERENCES `goi_game` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `nguoi_dung_vai_tro`
--
ALTER TABLE `nguoi_dung_vai_tro`
  ADD CONSTRAINT `nguoi_dung_vai_tro_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `nguoi_dung_vai_tro_ibfk_2` FOREIGN KEY (`vai_tro_id`) REFERENCES `vai_tro` (`ma`);

--
-- Constraints for table `nhat_ky_he_thong`
--
ALTER TABLE `nhat_ky_he_thong`
  ADD CONSTRAINT `nhat_ky_he_thong_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE SET NULL;

--
-- Constraints for table `nhat_ky_phat_trien`
--
ALTER TABLE `nhat_ky_phat_trien`
  ADD CONSTRAINT `nhat_ky_phat_trien_ibfk_1` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `nhat_ky_phat_trien_ibfk_2` FOREIGN KEY (`tac_gia_nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`);

--
-- Constraints for table `phien_ban_phat_hanh`
--
ALTER TABLE `phien_ban_phat_hanh`
  ADD CONSTRAINT `phien_ban_phat_hanh_ibfk_1` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `phien_ban_phat_hanh_ibfk_2` FOREIGN KEY (`nguoi_tao_id`) REFERENCES `nguoi_dung` (`ma`);

--
-- Constraints for table `quyen_so_huu_tro_choi`
--
ALTER TABLE `quyen_so_huu_tro_choi`
  ADD CONSTRAINT `quyen_so_huu_tro_choi_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`),
  ADD CONSTRAINT `quyen_so_huu_tro_choi_ibfk_2` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`),
  ADD CONSTRAINT `quyen_so_huu_tro_choi_ibfk_3` FOREIGN KEY (`chi_tiet_don_hang_id`) REFERENCES `chi_tiet_don_hang` (`ma`) ON DELETE SET NULL;

--
-- Constraints for table `so_ke_toan_tac_gia`
--
ALTER TABLE `so_ke_toan_tac_gia`
  ADD CONSTRAINT `so_ke_toan_tac_gia_ibfk_1` FOREIGN KEY (`chi_tiet_don_hang_id`) REFERENCES `chi_tiet_don_hang` (`ma`),
  ADD CONSTRAINT `so_ke_toan_tac_gia_ibfk_2` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`);

--
-- Constraints for table `tac_gia_tro_choi`
--
ALTER TABLE `tac_gia_tro_choi`
  ADD CONSTRAINT `tac_gia_tro_choi_ibfk_1` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `tac_gia_tro_choi_ibfk_2` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`);

--
-- Constraints for table `tai_khoan_nhan_tien_nguoi_dung`
--
ALTER TABLE `tai_khoan_nhan_tien_nguoi_dung`
  ADD CONSTRAINT `tai_khoan_nhan_tien_nguoi_dung_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `thanh_toan`
--
ALTER TABLE `thanh_toan`
  ADD CONSTRAINT `thanh_toan_ibfk_1` FOREIGN KEY (`don_hang_id`) REFERENCES `don_hang` (`ma`);

--
-- Constraints for table `thanh_vien_cuoc_thi`
--
ALTER TABLE `thanh_vien_cuoc_thi`
  ADD CONSTRAINT `thanh_vien_cuoc_thi_ibfk_1` FOREIGN KEY (`cuoc_thi_id`) REFERENCES `cuoc_thi_lam_game` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `thanh_vien_cuoc_thi_ibfk_2` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `theo_doi_nguoi_dung`
--
ALTER TABLE `theo_doi_nguoi_dung`
  ADD CONSTRAINT `theo_doi_nguoi_dung_ibfk_1` FOREIGN KEY (`nguoi_theo_doi_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `theo_doi_nguoi_dung_ibfk_2` FOREIGN KEY (`nguoi_duoc_theo_doi_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `theo_doi_tro_choi`
--
ALTER TABLE `theo_doi_tro_choi`
  ADD CONSTRAINT `theo_doi_tro_choi_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `theo_doi_tro_choi_ibfk_2` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `thong_bao`
--
ALTER TABLE `thong_bao`
  ADD CONSTRAINT `thong_bao_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `thong_ke_tro_choi_hang_ngay`
--
ALTER TABLE `thong_ke_tro_choi_hang_ngay`
  ADD CONSTRAINT `thong_ke_tro_choi_hang_ngay_ibfk_1` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `tro_choi`
--
ALTER TABLE `tro_choi`
  ADD CONSTRAINT `tro_choi_ibfk_1` FOREIGN KEY (`nguoi_tao_id`) REFERENCES `nguoi_dung` (`ma`);

--
-- Constraints for table `tro_choi_bo_suu_tap`
--
ALTER TABLE `tro_choi_bo_suu_tap`
  ADD CONSTRAINT `tro_choi_bo_suu_tap_ibfk_1` FOREIGN KEY (`bo_suu_tap_id`) REFERENCES `bo_suu_tap` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `tro_choi_bo_suu_tap_ibfk_2` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `tro_choi_bo_suu_tap_ibfk_3` FOREIGN KEY (`nguoi_them_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `tro_choi_giam_gia`
--
ALTER TABLE `tro_choi_giam_gia`
  ADD CONSTRAINT `tro_choi_giam_gia_ibfk_1` FOREIGN KEY (`chien_dich_id`) REFERENCES `chien_dich_giam_gia` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `tro_choi_giam_gia_ibfk_2` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `tro_choi_goi_game`
--
ALTER TABLE `tro_choi_goi_game`
  ADD CONSTRAINT `tro_choi_goi_game_ibfk_1` FOREIGN KEY (`goi_game_id`) REFERENCES `goi_game` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `tro_choi_goi_game_ibfk_2` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`);

--
-- Constraints for table `tro_choi_nen_tang`
--
ALTER TABLE `tro_choi_nen_tang`
  ADD CONSTRAINT `tro_choi_nen_tang_ibfk_1` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `tro_choi_nen_tang_ibfk_2` FOREIGN KEY (`nen_tang_id`) REFERENCES `nen_tang` (`ma`);

--
-- Constraints for table `tro_choi_nhan`
--
ALTER TABLE `tro_choi_nhan`
  ADD CONSTRAINT `tro_choi_nhan_ibfk_1` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `tro_choi_nhan_ibfk_2` FOREIGN KEY (`nhan_id`) REFERENCES `nhan` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `tro_choi_the_loai`
--
ALTER TABLE `tro_choi_the_loai`
  ADD CONSTRAINT `tro_choi_the_loai_ibfk_1` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `tro_choi_the_loai_ibfk_2` FOREIGN KEY (`the_loai_id`) REFERENCES `the_loai` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `tro_choi_yeu_thich`
--
ALTER TABLE `tro_choi_yeu_thich`
  ADD CONSTRAINT `tro_choi_yeu_thich_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `tro_choi_yeu_thich_ibfk_2` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `tuong_tac_bai_viet`
--
ALTER TABLE `tuong_tac_bai_viet`
  ADD CONSTRAINT `tuong_tac_bai_viet_ibfk_1` FOREIGN KEY (`bai_viet_id`) REFERENCES `bai_viet_thao_luan` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `tuong_tac_bai_viet_ibfk_2` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE CASCADE;

--
-- Constraints for table `url_tai_tro_choi`
--
ALTER TABLE `url_tai_tro_choi`
  ADD CONSTRAINT `url_tai_tro_choi_ibfk_1` FOREIGN KEY (`tro_choi_id`) REFERENCES `tro_choi` (`ma`) ON DELETE CASCADE,
  ADD CONSTRAINT `url_tai_tro_choi_ibfk_2` FOREIGN KEY (`phien_ban_id`) REFERENCES `phien_ban_phat_hanh` (`ma`) ON DELETE SET NULL,
  ADD CONSTRAINT `url_tai_tro_choi_ibfk_3` FOREIGN KEY (`nguoi_dong_gop_id`) REFERENCES `nguoi_dung` (`ma`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
