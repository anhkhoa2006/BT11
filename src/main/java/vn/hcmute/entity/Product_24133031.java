package vn.hcmute.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "products")
@NamedQueries({
    @NamedQuery(name = "Product_24133031.findAll", query = "SELECT p FROM Product_24133031 p ORDER BY p.productId DESC")
})
public class Product_24133031 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private int productId;

    @Column(name = "product_name", length = 200, nullable = false)
    private String productName;

    @Column(name = "price", nullable = false)
    private double price;

    @Column(name = "quantity", nullable = false)
    private int quantity; // Số lượng tồn kho (Stock)

    @Column(name = "images", length = 500)
    private String images;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "active", nullable = false)
    private boolean active = true;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_date")
    private Date createdDate = new Date();

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "category_id", nullable = true)
    private Category_24133031 category;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<OrderItem_24133031> orderItems;

    public Product_24133031() {
    }

    public Product_24133031(int productId, String productName, double price, int quantity, String images, String description, boolean active, Category_24133031 category) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
        this.images = images;
        this.description = description;
        this.active = active;
        this.category = category;
        this.createdDate = new Date();
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Category_24133031 getCategory() {
        return category;
    }

    public void setCategory(Category_24133031 category) {
        this.category = category;
    }

    public List<OrderItem_24133031> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem_24133031> orderItems) {
        this.orderItems = orderItems;
    }
}
