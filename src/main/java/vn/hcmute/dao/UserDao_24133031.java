package vn.hcmute.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import java.util.List;
import vn.hcmute.config.JPAConfig_24133031;
import vn.hcmute.entity.User_24133031;

public class UserDao_24133031 implements IUserDao_24133031 {

    @Override
    public User_24133031 findById(String username) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            return em.find(User_24133031.class, username);
        } finally {
            em.close();
        }
    }

    @Override
    public User_24133031 findByEmail(String email) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            TypedQuery<User_24133031> query = em.createQuery(
                "SELECT u FROM User_24133031 u WHERE u.email = :email", User_24133031.class);
            query.setParameter("email", email);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<User_24133031> findAll() {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            TypedQuery<User_24133031> query = em.createNamedQuery("User_24133031.findAll", User_24133031.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(User_24133031 user) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(user);
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
    public void update(User_24133031 user) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(user);
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
    public void delete(String username) throws Exception {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            User_24133031 user = em.find(User_24133031.class, username);
            if (user != null) {
                em.remove(user);
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
