package vn.hcmute.service;

import java.util.List;
import vn.hcmute.entity.Order_24133031;
import vn.hcmute.entity.User_24133031;
import vn.hcmute.model.Cart_24133031;

public interface IOrderService_24133031 {
    Order_24133031 findById(int orderId);
    List<Order_24133031> findAll();
    List<Order_24133031> findByUsername(String username);
    List<Order_24133031> findByUsernameAndStatus(String username, String status);
    Order_24133031 createOrderFromCart(User_24133031 user, Cart_24133031 cart, String fullname, String phone, String address, String note, String paymentMethod) throws Exception;
    boolean cancelOrder(int orderId, String username);
    void updateStatus(int orderId, String newStatus);
}
