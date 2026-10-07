package vn.hcmute.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "orders")
@NamedQueries({
    @NamedQuery(name = "Order_24133031.findAll", query = "SELECT o FROM Order_24133031 o ORDER BY o.orderDate DESC")
})
public class Order_24133031 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private int orderId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "username", nullable = false)
    private User_24133031 user;

    @Column(name = "fullname", length = 100, nullable = false)
    private String fullname;

    @Column(name = "phone", length = 20, nullable = false)
    private String phone;

    @Column(name = "address", length = 500, nullable = false)
    private String address;

    @Column(name = "note", length = 500)
    private String note;

    @Column(name = "payment_method", length = 50, nullable = false)
    private String paymentMethod = "COD"; // Thanh toán khi nhận hàng

    @Column(name = "total_amount", nullable = false)
    private double totalAmount;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "order_date", nullable = false)
    private Date orderDate = new Date();

    /**
     * 8 trạng thái:
     * NEW (Đơn hàng mới)
     * CONFIRMED (Đã xác nhận)
     * PREPARING (Chuẩn bị hàng)
     * SHIPPING (Vận chuyển)
     * DELIVERING (Giao hàng)
     * DELIVERED (Đã giao)
     * CANCELLED (Đơn hàng hủy)
     * RETURNED (Đơn hàng hoàn)
     */
    @Column(name = "status", length = 50, nullable = false)
    private String status = "NEW";

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
    private List<OrderItem_24133031> orderItems = new ArrayList<>();

    public Order_24133031() {
    }

    public Order_24133031(User_24133031 user, String fullname, String phone, String address, String note, String paymentMethod, double totalAmount, String status) {
        this.user = user;
        this.fullname = fullname;
        this.phone = phone;
        this.address = address;
        this.note = note;
        this.paymentMethod = paymentMethod;
        this.totalAmount = totalAmount;
        this.orderDate = new Date();
        this.status = status;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public User_24133031 getUser() {
        return user;
    }

    public void setUser(User_24133031 user) {
        this.user = user;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<OrderItem_24133031> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem_24133031> orderItems) {
        this.orderItems = orderItems;
    }

    /**
     * Tên tiếng Việt chuẩn cho giao diện
     */
    public String getStatusText() {
        if (status == null) return "Chưa xác định";
        String s = status.trim().toUpperCase();
        switch (s) {
            case "NEW":
            case "ĐƠN HÀNG MỚI":
            case "DON HANG MOI":
                return "Đơn hàng mới";
            case "CONFIRMED":
            case "ĐÃ XÁC NHẬN":
            case "DA XAC NHAN":
                return "Đã xác nhận";
            case "PREPARING":
            case "CHUẨN BỊ HÀNG":
            case "CHUAN BI HANG":
                return "Chuẩn bị hàng";
            case "SHIPPING":
            case "VẬN CHUYỂN":
            case "VAN CHUYEN":
                return "Vận chuyển";
            case "DELIVERING":
            case "GIAO HÀNG":
            case "GIAO HANG":
                return "Giao hàng";
            case "DELIVERED":
            case "ĐÃ GIAO":
            case "DA GIAO":
                return "Đã giao";
            case "CANCELLED":
            case "CANCELED":
            case "ĐƠN HÀNG HỦY":
            case "DON HANG HUY":
            case "HỦY":
                return "Đơn hàng hủy";
            case "RETURNED":
            case "ĐƠN HÀNG HOÀN":
            case "DON HANG HOAN":
            case "HOÀN HÀNG":
                return "Đơn hàng hoàn";
            default:
                return status;
        }
    }

    /**
     * Class badge màu sắc Bootstrap
     */
    public String getStatusBadgeClass() {
        if (status == null) return "bg-secondary";
        String s = status.trim().toUpperCase();
        switch (s) {
            case "NEW":
            case "ĐƠN HÀNG MỚI":
            case "DON HANG MOI":
                return "bg-primary";
            case "CONFIRMED":
            case "ĐÃ XÁC NHẬN":
            case "DA XAC NHAN":
                return "bg-info text-dark";
            case "PREPARING":
            case "CHUẨN BỊ HÀNG":
            case "CHUAN BI HANG":
                return "bg-warning text-dark";
            case "SHIPPING":
            case "VẬN CHUYỂN":
            case "VAN CHUYEN":
                return "bg-secondary";
            case "DELIVERING":
            case "GIAO HÀNG":
            case "GIAO HANG":
                return "bg-primary text-white";
            case "DELIVERED":
            case "ĐÃ GIAO":
            case "DA GIAO":
                return "bg-success";
            case "CANCELLED":
            case "CANCELED":
            case "ĐƠN HÀNG HỦY":
            case "DON HANG HUY":
            case "HỦY":
                return "bg-danger";
            case "RETURNED":
            case "ĐƠN HÀNG HOÀN":
            case "DON HANG HOAN":
            case "HOÀN HÀNG":
                return "bg-dark";
            default:
                return "bg-secondary";
        }
    }

    public boolean isCancellable() {
        if (status == null) return false;
        String s = status.trim().toUpperCase();
        return s.equals("NEW") || s.equals("ĐƠN HÀNG MỚI") || s.equals("DON HANG MOI");
    }
}
