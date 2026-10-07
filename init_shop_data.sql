USE web_de03;

-- 1. Bảng sản phẩm
CREATE TABLE IF NOT EXISTS products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(200) NOT NULL,
    price DOUBLE NOT NULL,
    quantity INT NOT NULL DEFAULT 10,
    images VARCHAR(500),
    description TEXT,
    active BIT NOT NULL DEFAULT 1,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES category(CategoryId) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 2. Bảng đơn hàng
CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    fullname VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(500) NOT NULL,
    note VARCHAR(500),
    payment_method VARCHAR(50) NOT NULL DEFAULT 'COD',
    total_amount DOUBLE NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL DEFAULT 'NEW',
    FOREIGN KEY (username) REFERENCES users(Username) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 3. Bảng chi tiết đơn hàng
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    price DOUBLE NOT NULL,
    quantity INT NOT NULL,
    amount DOUBLE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Xóa dữ liệu mẫu cũ nếu có
DELETE FROM order_items;
DELETE FROM orders;
DELETE FROM products;

-- Nạp dữ liệu mẫu sản phẩm với tồn kho (quantity) cụ thể để test giới hạn giỏ hàng
INSERT INTO products (product_id, product_name, price, quantity, images, description, active, created_date, category_id) VALUES
(1, 'Giáo trình Lập trình Web với Jakarta Servlet & JSP (Bản in màu)', 180000, 15, 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=400', 'Tài liệu hướng dẫn toàn diện từ cơ bản đến nâng cao về kiến trúc MVC, Jakarta Servlet 6.0, JSP, JPA Hibernate và SiteMesh 3.', 1, NOW(), 1),
(2, 'Khóa học Spring Boot & Microservices Chuyên Nghiệp', 450000, 20, 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400', 'Khóa học video và tài liệu thực hành xây dựng hệ thống thương mại điện tử phân tán với Spring Boot 3 và MySQL.', 1, NOW(), 1),
(3, 'Sách Học Sâu & Trí Tuệ Nhân Tạo (Deep Learning with Python)', 250000, 8, 'https://images.unsplash.com/photo-1532012164546-f432f2e3777a?w=400', 'Sách chuyên sâu về Mạng nơ-ron nhân tạo, PyTorch, TensorFlow và ứng dụng Computer Vision.', 1, NOW(), 2),
(4, 'Bo mạch NVIDIA Jetson Nano Developer Kit (AI Edge)', 2890000, 5, 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=400', 'Bộ kit phần cứng nhúng mạnh mẽ dành cho việc triển khai mô hình học sâu và thị giác máy tính tại biên.', 1, NOW(), 2),
(5, 'Sách Phân Tích Dữ Liệu Lớn với Python & Pandas', 195000, 12, 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=400', 'Hướng dẫn kỹ năng làm sạch dữ liệu, trực quan hóa biểu đồ và thống kê suy diễn thực chiến.', 1, NOW(), 3),
(6, 'USB 128GB Chứa Trọn Bộ Source Code & Đề Thi Mẫu', 150000, 25, 'https://images.unsplash.com/photo-1628155930542-3c7a64e2c833?w=400', 'Bộ tài liệu, source code mẫu đề tài Lập trình Web và hệ quản trị CSDL được kiểm thử kỹ lưỡng.', 1, NOW(), 1),
(7, 'Chuột Gaming Không Dây Ergonomic Cao Cấp', 350000, 2, 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=400', 'Chuột công thái học cao cấp dành cho lập trình viên, chỉ còn 2 chiếc trong kho.', 1, NOW(), 1);

-- Nạp các đơn hàng mẫu phủ ĐẦY ĐỦ 8 TRẠNG THÁI cho tài khoản 'khoa24133031' và 'admin' để quan sát và test bộ lọc
-- 1. Đơn hàng mới (NEW)
INSERT INTO orders (order_id, username, fullname, phone, address, note, payment_method, total_amount, order_date, status) VALUES
(1001, 'khoa24133031', 'Trần Anh Khoa', '0987654321', '01 Võ Văn Ngân, TP. Thủ Đức, TP. Hồ Chí Minh', 'Giao trong giờ hành chính', 'COD', 180000, NOW() - INTERVAL 10 MINUTE, 'NEW');

INSERT INTO order_items (order_id, product_id, price, quantity, amount) VALUES
(1001, 1, 180000, 1, 180000);

-- 2. Đã xác nhận (CONFIRMED)
INSERT INTO orders (order_id, username, fullname, phone, address, note, payment_method, total_amount, order_date, status) VALUES
(1002, 'khoa24133031', 'Trần Anh Khoa', '0987654321', 'Ký túc xá khu B, ĐHQG TP.HCM', 'Gọi trước 15 phút', 'COD', 450000, NOW() - INTERVAL 2 HOUR, 'CONFIRMED');

INSERT INTO order_items (order_id, product_id, price, quantity, amount) VALUES
(1002, 2, 450000, 1, 450000);

-- 3. Chuẩn bị hàng (PREPARING)
INSERT INTO orders (order_id, username, fullname, phone, address, note, payment_method, total_amount, order_date, status) VALUES
(1003, 'khoa24133031', 'Trần Anh Khoa', '0987654321', '01 Võ Văn Ngân, TP. Thủ Đức', 'Đóng gói cẩn thận giúp mình', 'COD', 250000, NOW() - INTERVAL 5 HOUR, 'PREPARING');

INSERT INTO order_items (order_id, product_id, price, quantity, amount) VALUES
(1003, 3, 250000, 1, 250000);

-- 4. Vận chuyển (SHIPPING)
INSERT INTO orders (order_id, username, fullname, phone, address, note, payment_method, total_amount, order_date, status) VALUES
(1004, 'khoa24133031', 'Trần Anh Khoa', '0987654321', 'Trường ĐH Sư Phạm Kỹ Thuật TP.HCM', 'Giao tại cổng số 1', 'COD', 2890000, NOW() - INTERVAL 1 DAY, 'SHIPPING');

INSERT INTO order_items (order_id, product_id, price, quantity, amount) VALUES
(1004, 4, 2890000, 1, 2890000);

-- 5. Giao hàng (DELIVERING)
INSERT INTO orders (order_id, username, fullname, phone, address, note, payment_method, total_amount, order_date, status) VALUES
(1005, 'khoa24133031', 'Trần Anh Khoa', '0987654321', '01 Võ Văn Ngân, P. Linh Chiểu, Thủ Đức', 'Shipper đang liên hệ giao hàng', 'COD', 195000, NOW() - INTERVAL 18 HOUR, 'DELIVERING');

INSERT INTO order_items (order_id, product_id, price, quantity, amount) VALUES
(1005, 5, 195000, 1, 195000);

-- 6. Đã giao (DELIVERED)
INSERT INTO orders (order_id, username, fullname, phone, address, note, payment_method, total_amount, order_date, status) VALUES
(1006, 'khoa24133031', 'Trần Anh Khoa', '0987654321', '01 Võ Văn Ngân, TP. Thủ Đức', 'Đã nhận đủ và thanh toán COD', 'COD', 330000, NOW() - INTERVAL 3 DAY, 'DELIVERED');

INSERT INTO order_items (order_id, product_id, price, quantity, amount) VALUES
(1006, 1, 180000, 1, 180000),
(1006, 6, 150000, 1, 150000);

-- 7. Đơn hàng hủy (CANCELLED)
INSERT INTO orders (order_id, username, fullname, phone, address, note, payment_method, total_amount, order_date, status) VALUES
(1007, 'khoa24133031', 'Trần Anh Khoa', '0987654321', '01 Võ Văn Ngân, TP. Thủ Đức', 'Người dùng đổi ý không mua nữa', 'COD', 350000, NOW() - INTERVAL 4 DAY, 'CANCELLED');

INSERT INTO order_items (order_id, product_id, price, quantity, amount) VALUES
(1007, 7, 350000, 1, 350000);

-- 8. Đơn hàng hoàn (RETURNED)
INSERT INTO orders (order_id, username, fullname, phone, address, note, payment_method, total_amount, order_date, status) VALUES
(1008, 'khoa24133031', 'Trần Anh Khoa', '0987654321', '01 Võ Văn Ngân, TP. Thủ Đức', 'Không liên hệ được người nhận sau 3 lần gọi', 'COD', 250000, NOW() - INTERVAL 5 DAY, 'RETURNED');

INSERT INTO order_items (order_id, product_id, price, quantity, amount) VALUES
(1008, 3, 250000, 1, 250000);
