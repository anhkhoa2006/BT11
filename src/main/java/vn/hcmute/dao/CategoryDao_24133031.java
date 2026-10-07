package vn.hcmute.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;
import vn.hcmute.config.JPAConfig_24133031;
import vn.hcmute.entity.Category_24133031;

public class CategoryDao_24133031 implements ICategoryDao_24133031 {

    @Override
    public Category_24133031 findById(int categoryId) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            return em.find(Category_24133031.class, categoryId);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Category_24133031> findAll() {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            TypedQuery<Category_24133031> query = em.createNamedQuery("Category_24133031.findAll", Category_24133031.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Category_24133031> findAllActive() {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            TypedQuery<Category_24133031> query = em.createQuery(
                "SELECT c FROM Category_24133031 c WHERE c.status = true", Category_24133031.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long countVideosByCategory(int categoryId) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(v) FROM Video_24133031 v WHERE v.category.categoryId = :categoryId AND v.active = true", 
                Long.class);
            query.setParameter("categoryId", categoryId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(Category_24133031 category) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(category);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Category_24133031 category) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(category);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int categoryId) throws Exception {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Category_24133031 category = em.find(Category_24133031.class, categoryId);
            if (category != null) {
                em.remove(category);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }
}
