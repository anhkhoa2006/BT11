package vn.hcmute.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;
import vn.hcmute.config.JPAConfig_24133031;
import vn.hcmute.entity.Product_24133031;

public class ProductDao_24133031 implements IProductDao_24133031 {

    @Override
    public Product_24133031 findById(int productId) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            return em.find(Product_24133031.class, productId);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product_24133031> findAll() {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            TypedQuery<Product_24133031> query = em.createNamedQuery("Product_24133031.findAll", Product_24133031.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product_24133031> findAllActive() {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            TypedQuery<Product_24133031> query = em.createQuery(
                "SELECT p FROM Product_24133031 p WHERE p.active = true ORDER BY p.productId DESC", Product_24133031.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product_24133031> findByCategory(int categoryId, int page, int pageSize) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            TypedQuery<Product_24133031> query;
            if (categoryId > 0) {
                query = em.createQuery(
                    "SELECT p FROM Product_24133031 p WHERE p.category.categoryId = :catId AND p.active = true ORDER BY p.productId DESC", 
                    Product_24133031.class);
                query.setParameter("catId", categoryId);
            } else {
                query = em.createQuery(
                    "SELECT p FROM Product_24133031 p WHERE p.active = true ORDER BY p.productId DESC", 
                    Product_24133031.class);
            }
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product_24133031> findAllPaging(int page, int pageSize) {
        return findByCategory(0, page, pageSize);
    }

    @Override
    public long countByCategory(int categoryId) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            TypedQuery<Long> query;
            if (categoryId > 0) {
                query = em.createQuery(
                    "SELECT COUNT(p) FROM Product_24133031 p WHERE p.category.categoryId = :catId AND p.active = true", 
                    Long.class);
                query.setParameter("catId", categoryId);
            } else {
                query = em.createQuery(
                    "SELECT COUNT(p) FROM Product_24133031 p WHERE p.active = true", 
                    Long.class);
            }
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public long countAll() {
        return countByCategory(0);
    }

    @Override
    public void insert(Product_24133031 product) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(product);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Product_24133031 product) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(product);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int productId) throws Exception {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Product_24133031 p = em.find(Product_24133031.class, productId);
            if (p != null) {
                em.remove(p);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void updateStock(int productId, int quantityChange) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Product_24133031 p = em.find(Product_24133031.class, productId);
            if (p != null) {
                int newStock = p.getQuantity() - quantityChange;
                if (newStock < 0) newStock = 0;
                p.setQuantity(newStock);
                em.merge(p);
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
