package vn.hcmute.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import vn.hcmute.config.JPAConfig_24133031;
import vn.hcmute.entity.Order_24133031;

public class OrderDao_24133031 implements IOrderDao_24133031 {

    @Override
    public Order_24133031 findById(int orderId) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            return em.find(Order_24133031.class, orderId);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Order_24133031> findAll() {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            TypedQuery<Order_24133031> query = em.createNamedQuery("Order_24133031.findAll", Order_24133031.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Order_24133031> findByUsername(String username) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            TypedQuery<Order_24133031> query = em.createQuery(
                "SELECT o FROM Order_24133031 o WHERE o.user.username = :username ORDER BY o.orderDate DESC", 
                Order_24133031.class);
            query.setParameter("username", username);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Order_24133031> findByUsernameAndStatus(String username, String status) {
        if (status == null || status.trim().isEmpty() || status.equalsIgnoreCase("ALL")) {
            return findByUsername(username);
        }

        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            List<String> validKeywords = mapStatusToKeywords(status);
            TypedQuery<Order_24133031> query = em.createQuery(
                "SELECT o FROM Order_24133031 o WHERE o.user.username = :username AND (UPPER(o.status) IN :keywords) ORDER BY o.orderDate DESC", 
                Order_24133031.class);
            query.setParameter("username", username);
            query.setParameter("keywords", validKeywords);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    private List<String> mapStatusToKeywords(String status) {
        String s = status.trim().toUpperCase();
        switch (s) {
            case "NEW":
            case "ĐƠN HÀNG MỚI":
            case "DON HANG MOI":
                return Arrays.asList("NEW", "ĐƠN HÀNG MỚI", "DON HANG MOI");
            case "CONFIRMED":
            case "ĐÃ XÁC NHẬN":
            case "DA XAC NHAN":
                return Arrays.asList("CONFIRMED", "ĐÃ XÁC NHẬN", "DA XAC NHAN");
            case "PREPARING":
            case "CHUẨN BỊ HÀNG":
            case "CHUAN BI HANG":
                return Arrays.asList("PREPARING", "CHUẨN BỊ HÀNG", "CHUAN BI HANG");
            case "SHIPPING":
            case "VẬN CHUYỂN":
            case "VAN CHUYEN":
                return Arrays.asList("SHIPPING", "VẬN CHUYỂN", "VAN CHUYEN");
            case "DELIVERING":
            case "GIAO HÀNG":
            case "GIAO HANG":
                return Arrays.asList("DELIVERING", "GIAO HÀNG", "GIAO HANG");
            case "DELIVERED":
            case "ĐÃ GIAO":
            case "DA GIAO":
                return Arrays.asList("DELIVERED", "ĐÃ GIAO", "DA GIAO");
            case "CANCELLED":
            case "CANCELED":
            case "ĐƠN HÀNG HỦY":
            case "DON HANG HUY":
            case "HỦY":
                return Arrays.asList("CANCELLED", "CANCELED", "ĐƠN HÀNG HỦY", "DON HANG HUY", "HỦY");
            case "RETURNED":
            case "ĐƠN HÀNG HOÀN":
            case "DON HANG HOAN":
            case "HOÀN HÀNG":
                return Arrays.asList("RETURNED", "ĐƠN HÀNG HOÀN", "DON HANG HOAN", "HOÀN HÀNG");
            default:
                List<String> list = new ArrayList<>();
                list.add(s);
                return list;
        }
    }

    @Override
    public void insert(Order_24133031 order) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(order);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Order_24133031 order) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(order);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void updateStatus(int orderId, String newStatus) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Order_24133031 order = em.find(Order_24133031.class, orderId);
            if (order != null) {
                order.setStatus(newStatus);
                em.merge(order);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
