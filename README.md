# BÀI TẬP 11 - VIDEO & SHOP PORTAL (JAKARTA SERVLET, JSP, HIBERNATE JPA, SITEMESH 3)

- **Sinh viên:** Trần Anh Khoa
- **MSSV:** 24133031
- **Môn học:** Lập trình Web - HK1
- **Trường:** ĐH Sư Phạm Kỹ Thuật TP.HCM (HCMUTE)

---

## Các Chức Năng Đã Triển Khai (Vai Trò User):

### 1. Chức năng Giỏ hàng (Shopping Cart):
- Xem danh sách sản phẩm và chi tiết sản phẩm.
- Thêm sản phẩm vào giỏ hàng (`/cart/add`).
- Cập nhật số lượng sản phẩm trong giới hạn tồn kho (`/cart/update`).
- Xóa từng món (`/cart/delete`) hoặc xóa toàn bộ giỏ hàng (`/cart/clear`).
- Badge hiển thị realtime số lượng sản phẩm trên Navbar.

### 2. Chức năng Thanh toán đơn hàng bằng COD:
- Trang nhập thông tin người nhận, số điện thoại, địa chỉ nhận hàng (`/checkout`).
- Chọn phương thức thanh toán tiền mặt khi nhận hàng (COD).
- Tạo đơn hàng trong CSDL, trừ tồn kho sản phẩm, làm trống giỏ hàng và chuyển đến trang đặt hàng thành công (`/checkout/success`).

### 3. Chức năng Lịch sử đặt hàng lọc theo 8 trạng thái:
- Trang lịch sử đơn hàng (`/my-orders`) hỗ trợ bộ lọc 8 trạng thái chuẩn:
  1. **Đơn hàng mới** (`NEW`)
  2. **Đã xác nhận** (`CONFIRMED`)
  3. **Chuẩn bị hàng** (`PREPARING`)
  4. **Vận chuyển** (`SHIPPING`)
  5. **Giao hàng** (`DELIVERING`)
  6. **Đã giao** (`DELIVERED`)
  7. **Đơn hàng hủy** (`CANCELLED`)
  8. **Đơn hàng hoàn** (`RETURNED`)
- Xem chi tiết đơn hàng (`/order/detail`) với thanh tiến trình trực quan (Step Tracker).
- Hỗ trợ hủy đơn hàng khi đang ở trạng thái `NEW`.

---

## Cấu trúc CSDL & Dữ liệu mẫu:
- File SQL khởi tạo dữ liệu: `init_shop_data.sql`
