package vn.hcmute.model;

import java.io.Serializable;
import vn.hcmute.entity.Product_24133031;

public class CartItem_24133031 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Product_24133031 product;
    private int quantity;

    public CartItem_24133031() {
    }

    public CartItem_24133031(Product_24133031 product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    public Product_24133031 getProduct() {
        return product;
    }

    public void setProduct(Product_24133031 product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        if (product == null) return 0;
        return product.getPrice() * quantity;
    }
}
