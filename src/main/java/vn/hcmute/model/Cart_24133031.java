package vn.hcmute.model;

import java.io.Serializable;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;
import vn.hcmute.entity.Product_24133031;

public class Cart_24133031 implements Serializable {
    private static final long serialVersionUID = 1L;

    // Sử dụng LinkedHashMap để duy trì thứ tự thêm vào giỏ hàng
    private Map<Integer, CartItem_24133031> items = new LinkedHashMap<>();

    public Cart_24133031() {
    }

    /**
     * Thêm sản phẩm vào giỏ hàng có kiểm tra giới hạn tồn kho
     * @return true nếu thêm thành công đúng số lượng, false nếu bị giới hạn bởi tồn kho
     */
    public synchronized boolean add(Product_24133031 product, int quantity) {
        if (product == null || quantity <= 0) {
            return false;
        }

        int maxStock = product.getQuantity();
        if (maxStock <= 0) {
            return false;
        }

        int pid = product.getProductId();
        if (items.containsKey(pid)) {
            CartItem_24133031 item = items.get(pid);
            int newQty = item.getQuantity() + quantity;
            if (newQty > maxStock) {
                item.setQuantity(maxStock);
                return false; // Đã đạt giới hạn tồn kho
            } else {
                item.setQuantity(newQty);
                return true;
            }
        } else {
            int actualQty = Math.min(quantity, maxStock);
            items.put(pid, new CartItem_24133031(product, actualQty));
            return actualQty == quantity;
        }
    }

    /**
     * Sửa / Thay đổi số lượng sản phẩm trong giới hạn tồn kho (tối thiểu 1, tối đa stock)
     * @return chuỗi thông báo kết quả hoặc null nếu hợp lệ
     */
    public synchronized String update(int productId, int quantity, int maxStock) {
        if (!items.containsKey(productId)) {
            return "Sản phẩm không có trong giỏ hàng!";
        }

        if (quantity <= 0) {
            items.remove(productId);
            return "Đã xóa sản phẩm khỏi giỏ hàng.";
        }

        if (maxStock <= 0) {
            items.remove(productId);
            return "Sản phẩm đã hết hàng trong kho!";
        }

        if (quantity > maxStock) {
            items.get(productId).setQuantity(maxStock);
            return "Số lượng yêu cầu vượt quá tồn kho (" + maxStock + "). Đã tự động điều chỉnh về " + maxStock + ".";
        }

        items.get(productId).setQuantity(quantity);
        return null;
    }

    /**
     * Xóa 1 sản phẩm khỏi giỏ
     */
    public synchronized void remove(int productId) {
        items.remove(productId);
    }

    /**
     * Xóa toàn bộ giỏ hàng
     */
    public synchronized void clear() {
        items.clear();
    }

    /**
     * Lấy danh sách item trong giỏ
     */
    public Collection<CartItem_24133031> getItems() {
        return items.values();
    }

    /**
     * Đếm tổng số lượng món hàng
     */
    public int getTotalQuantity() {
        int total = 0;
        for (CartItem_24133031 item : items.values()) {
            total += item.getQuantity();
        }
        return total;
    }

    /**
     * Đếm số loại sản phẩm khác nhau trong giỏ
     */
    public int getItemCount() {
        return items.size();
    }

    /**
     * Tính tổng thành tiền của cả giỏ
     */
    public double getTotalAmount() {
        double total = 0;
        for (CartItem_24133031 item : items.values()) {
            total += item.getTotalPrice();
        }
        return total;
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }
}
