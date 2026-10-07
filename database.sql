-- Script khởi tạo CSDL cho Đề 03 - Môn Lập Trình Web
-- Họ tên: Trần Anh Khoa - MSSV: 24133031 - Mã đề: 3

CREATE DATABASE IF NOT EXISTS `web_de03` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `web_de03`;

-- 1. Bảng Users
DROP TABLE IF EXISTS `Favorites`;
DROP TABLE IF EXISTS `Shares`;
DROP TABLE IF EXISTS `Videos`;
DROP TABLE IF EXISTS `Category`;
DROP TABLE IF EXISTS `Users`;

CREATE TABLE `Users` (
    `Username` VARCHAR(50) NOT NULL,
    `Password` VARCHAR(50) NOT NULL,
    `Phone` VARCHAR(15) NULL,
    `Fullname` VARCHAR(50) NULL,
    `Email` VARCHAR(150) NULL,
    `Admin` BIT NOT NULL DEFAULT 0,
    `Active` BIT NOT NULL DEFAULT 1,
    `Images` VARCHAR(500) NULL,
    PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Bảng Category
CREATE TABLE `Category` (
    `CategoryId` INT NOT NULL AUTO_INCREMENT,
    `Categoryname` VARCHAR(100) NOT NULL,
    `Categorycode` VARCHAR(100) NULL,
    `Images` VARCHAR(500) NULL,
    `Status` BIT NOT NULL DEFAULT 1,
    PRIMARY KEY (`CategoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Bảng Videos
CREATE TABLE `Videos` (
    `VideoId` VARCHAR(50) NOT NULL,
    `Title` VARCHAR(200) NOT NULL,
    `Poster` VARCHAR(500) NULL,
    `Views` INT DEFAULT 0,
    `Description` VARCHAR(500) NULL,
    `Active` BIT NOT NULL DEFAULT 1,
    `CategoryId` INT NOT NULL,
    PRIMARY KEY (`VideoId`),
    CONSTRAINT `FK_Videos_Category` FOREIGN KEY (`CategoryId`) REFERENCES `Category` (`CategoryId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Bảng Shares
CREATE TABLE `Shares` (
    `ShareId` INT NOT NULL AUTO_INCREMENT,
    `Emails` VARCHAR(50) NULL,
    `SharedDate` DATE NULL,
    `Username` VARCHAR(50) NOT NULL,
    `VideoId` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`ShareId`),
    CONSTRAINT `FK_Shares_Users` FOREIGN KEY (`Username`) REFERENCES `Users` (`Username`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_Shares_Videos` FOREIGN KEY (`VideoId`) REFERENCES `Videos` (`VideoId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Bảng Favorites
CREATE TABLE `Favorites` (
    `FavoriteId` INT NOT NULL AUTO_INCREMENT,
    `LikedDate` DATE NULL,
    `VideoId` VARCHAR(50) NOT NULL,
    `Username` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`FavoriteId`),
    CONSTRAINT `FK_Favorites_Users` FOREIGN KEY (`Username`) REFERENCES `Users` (`Username`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_Favorites_Videos` FOREIGN KEY (`VideoId`) REFERENCES `Videos` (`VideoId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dữ liệu mẫu
INSERT INTO `Users` (`Username`, `Password`, `Phone`, `Fullname`, `Email`, `Admin`, `Active`, `Images`) VALUES
('admin', '123456', '0912345678', 'Trần Anh Khoa (Admin)', 'admin@hcmute.edu.vn', 1, 1, 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150'),
('khoa24133031', '123456', '0987654321', 'Trần Anh Khoa', 'khoa.24133031@student.hcmute.edu.vn', 0, 1, 'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=150'),
('user01', '123456', '0901234567', 'Nguyễn Văn A', 'user01@gmail.com', 0, 1, 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150'),
('user02', '123456', '0907654321', 'Lê Thị B', 'user02@gmail.com', 0, 0, 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150');

INSERT INTO `Category` (`CategoryId`, `Categoryname`, `Categorycode`, `Images`, `Status`) VALUES
(1, 'Lập Trình Web Java', 'WEB_JAVA', 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300', 1),
(2, 'Trí Tuệ Nhân Tạo', 'AI_ML', 'https://images.unsplash.com/photo-1677442136019-21780efad99a?w=300', 1),
(3, 'Khoa Học Dữ Liệu', 'DATA_SCI', 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=300', 1);

INSERT INTO `Videos` (`VideoId`, `Title`, `Poster`, `Views`, `Description`, `Active`, `CategoryId`) VALUES
('VID001', 'Hướng dẫn xây dựng Servlet và JSP cơ bản', 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=400', 1250, 'Khóa học lập trình Servlet JSP từ đầu đến nâng cao cho sinh viên.', 1, 1),
('VID002', 'JPA và Hibernate kết nối CSDL MySQL', 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=400', 980, 'Tìm hiểu ánh xạ đối tượng ORM với Hibernate và JPA Specification.', 1, 1),
('VID003', 'Thiết lập SiteMesh 3 Decorator chuyên nghiệp', 'https://images.unsplash.com/photo-1507238691740-187a5b1d37b8?w=400', 820, 'Hướng dẫn tạo layout thống nhất cho User và Admin bằng SiteMesh.', 1, 1),
('VID004', 'Xác thực OTP qua Email và Session trong Servlet', 'https://images.unsplash.com/photo-1563986768609-322da13575f3?w=400', 1540, 'Bảo mật tài khoản với cơ chế kích hoạt OTP gửi qua email.', 1, 1),
('VID005', 'CRUD và Phân trang dữ liệu với JPA trong Servlet', 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=400', 670, 'Thực hiện phân trang và các thao tác thêm sửa xóa dữ liệu tối ưu.', 1, 1),
('VID006', 'Phân quyền Filter cho trang Quản trị Admin', 'https://images.unsplash.com/photo-1510511459019-5dda7724fd87?w=400', 430, 'Bảo vệ tài nguyên hệ thống bằng Servlet Filter phân quyền Admin.', 1, 1),
('VID007', 'Nhập môn Trí tuệ nhân tạo và Machine Learning', 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=400', 2100, 'Khám phá thế giới AI cùng các thuật toán học máy cơ bản.', 1, 2),
('VID008', 'Xây dựng mô hình phân loại hình ảnh với CNN', 'https://images.unsplash.com/photo-1507146426996-ef05306b995a?w=400', 1450, 'Thực hành mạng nơ-ron tích chập trong xử lý ảnh thị giác máy tính.', 1, 2),
('VID009', 'Xử lý ngôn ngữ tự nhiên và mô hình Transformer', 'https://images.unsplash.com/photo-1620712943543-bcc4688e7485?w=400', 1890, 'Tìm hiểu kiến trúc Transformer và các mô hình LLM hiện đại.', 1, 2),
('VID010', 'Phân tích dữ liệu lớn với Python và Pandas', 'https://images.unsplash.com/photo-1551836022-d5d88e9218df?w=400', 1120, 'Kỹ năng trích xuất, làm sạch và trực quan hóa dữ liệu kinh doanh.', 1, 3),
('VID011', 'Trực quan hóa dữ liệu trực quan bằng biểu đồ tương tác', 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=400', 890, 'Tạo biểu đồ và báo cáo chuyên sâu giúp ra quyết định tối ưu.', 1, 3),
('VID012', 'Xây dựng Data Pipeline tự động hóa', 'https://images.unsplash.com/photo-1504868584819-f8e8b4b6d7e3?w=400', 760, 'Quy trình thu thập và biến đổi dữ liệu tự động cho doanh nghiệp.', 1, 3);

-- Dữ liệu Shares
INSERT INTO `Shares` (`Emails`, `SharedDate`, `Username`, `VideoId`) VALUES
('friend1@gmail.com', '2026-09-20', 'khoa24133031', 'VID001'),
('friend2@gmail.com', '2026-09-21', 'user01', 'VID001'),
('friend3@gmail.com', '2026-09-21', 'admin', 'VID001'),
('colleague@work.com', '2026-09-22', 'khoa24133031', 'VID002'),
('team@hcmute.edu.vn', '2026-09-22', 'user01', 'VID002'),
('study_group@gmail.com', '2026-09-23', 'khoa24133031', 'VID007'),
('study_group2@gmail.com', '2026-09-23', 'admin', 'VID007');

-- Dữ liệu Favorites
INSERT INTO `Favorites` (`LikedDate`, `VideoId`, `Username`) VALUES
('2026-09-20', 'VID001', 'khoa24133031'),
('2026-09-21', 'VID001', 'user01'),
('2026-09-22', 'VID001', 'admin'),
('2026-09-21', 'VID002', 'khoa24133031'),
('2026-09-22', 'VID002', 'user01'),
('2026-09-22', 'VID003', 'khoa24133031'),
('2026-09-23', 'VID007', 'khoa24133031'),
('2026-09-23', 'VID007', 'admin'),
('2026-09-23', 'VID008', 'user01'),
('2026-09-23', 'VID010', 'khoa24133031');
