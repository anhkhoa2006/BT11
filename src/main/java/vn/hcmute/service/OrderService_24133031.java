package vn.hcmute.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import vn.hcmute.dao.IOrderDao_24133031;
import vn.hcmute.dao.IProductDao_24133031;
import vn.hcmute.dao.OrderDao_24133031;
import vn.hcmute.dao.ProductDao_24133031;
import vn.hcmute.entity.Order_24133031;
import vn.hcmute.entity.OrderItem_24133031;
import vn.hcmute.entity.Product_24133031;
import vn.hcmute.entity.User_24133031;
import vn.hcmute.model.CartItem_24133031;
import vn.hcmute.model.Cart_24133031;

public class OrderService_24133031 implements IOrderService_24133031 {
    private final IOrderDao_24133031 orderDao = new OrderDao_24133031();
    private final IProductDao_24133031 productDao = new ProductDao_24133031();

    @Override
    public Order_24133031 findById(int orderId) {
        return orderDao.findById(orderId);
    }

    @Override
    public List<Order_24133031> findAll() {
        return orderDao.findAll();
    }

    @Override
    public List<Order_24133031> findByUsername(String username) {
        return orderDao.findByUsername(username);
    }

    @Override
    public List<Order_24133031> findByUsernameAndStatus(String username, String status) {
        return orderDao.findByUsernameAndStatus(username, status);
    }

    @Override
    public Order_24133031 createOrderFromCart(User_24133031 user, Cart_24133031 cart, String fullname, String phone, String address, String note, String paymentMethod) throws Exception {
        if (user == null) {
            throw new IllegalArgumentException("Vui lòng đăng nhập để thanh toán đơn hàng.");
        }
        if (cart == null || cart.isEmpty()) {
            throw new IllegalArgumentException("Giỏ hàng của bạn đang trống. Vui lòng chọn sản phẩm trước khi thanh toán.");
        }
        if (fullname == null || fullname.trim().isEmpty()) {
            throw new IllegalArgumentException("Vui lòng nhập họ và tên người nhận hàng.");
        }
        if (phone == null || phone.trim().isEmpty()) {
            throw new IllegalArgumentException("Vui lòng nhập số điện thoại nhận hàng.");
        }
        if (address == null || address.trim().isEmpty()) {
            throw new IllegalArgumentException("Vui lòng nhập địa chỉ giao hàng.");
        }

        // Tạo đối tượng Đơn hàng
        Order_24133031 order = new Order_24133031();
        order.setUser(user);
        order.setFullname(fullname.trim());
        order.setPhone(phone.trim());
        order.setAddress(address.trim());
        order.setNote(note != null ? note.trim() : "");
        order.setPaymentMethod(paymentMethod != null && !paymentMethod.trim().isEmpty() ? paymentMethod.trim() : "COD");
        order.setTotalAmount(cart.getTotalAmount());
        order.setOrderDate(new Date());
        order.setStatus("NEW"); // Trạng thái mặc định ban đầu: Đơn hàng mới

        List<OrderItem_24133031> items = new ArrayList<>();
        for (CartItem_24133031 cItem : cart.getItems()) {
            Product_24133031 prod = productDao.findById(cItem.getProduct().getProductId());
            if (prod == null) {
                throw new IllegalStateException("Sản phẩm '" + cItem.getProduct().getProductName() + "' không còn tồn tại.");
            }
            if (prod.getQuantity() < cItem.getQuantity()) {
                throw new IllegalStateException("Sản phẩm '" + prod.getProductName() + "' chỉ còn " + prod.getQuantity() + " trong kho, không đủ số lượng đặt mua (" + cItem.getQuantity() + ").");
            }

            OrderItem_24133031 oItem = new OrderItem_24133031();
            oItem.setOrder(order);
            oItem.setProduct(prod);
            oItem.setPrice(prod.getPrice());
            oItem.setQuantity(cItem.getQuantity());
            oItem.setAmount(prod.getPrice() * cItem.getQuantity());
            items.add(oItem);

            // Trừ số lượng tồn kho của sản phẩm
            productDao.updateStock(prod.getProductId(), cItem.getQuantity());
        }
        order.setOrderItems(items);

        // Lưu đơn hàng vào CSDL
        orderDao.insert(order);

        // Xóa sạch giỏ hàng sau khi đặt thành công
        cart.clear();

        return order;
    }

    @Override
    public boolean cancelOrder(int orderId, String username) {
        Order_24133031 order = orderDao.findById(orderId);
        if (order != null && order.getUser().getUsername().equals(username)) {
            if (order.isCancellable()) {
                order.setStatus("CANCELLED");
                // Hoàn lại số lượng tồn kho cho sản phẩm
                if (order.getOrderItems() != null) {
                    for (OrderItem_24133031 item : order.getOrderItems()) {
                        if (item.getProduct() != null) {
                            productDao.updateStock(item.getProduct().getProductId(), -item.getQuantity());
                        }
                    }
                }
                orderDao.update(order);
                return true;
            }
        }
        return false;
    }

    @Override
    public void updateStatus(int orderId, String newStatus) {
        orderDao.updateStatus(orderId, newStatus);
    }
}
