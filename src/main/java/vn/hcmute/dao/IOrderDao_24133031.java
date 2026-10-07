package vn.hcmute.dao;

import java.util.List;
import vn.hcmute.entity.Order_24133031;

public interface IOrderDao_24133031 {
    Order_24133031 findById(int orderId);
    List<Order_24133031> findAll();
    List<Order_24133031> findByUsername(String username);
    List<Order_24133031> findByUsernameAndStatus(String username, String status);
    void insert(Order_24133031 order);
    void update(Order_24133031 order);
    void updateStatus(int orderId, String newStatus);
}
