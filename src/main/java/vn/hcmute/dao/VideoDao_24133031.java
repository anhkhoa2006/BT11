package vn.hcmute.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;
import vn.hcmute.config.JPAConfig_24133031;
import vn.hcmute.entity.Video_24133031;

public class VideoDao_24133031 implements IVideoDao_24133031 {

    @Override
    public Video_24133031 findById(String videoId) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            return em.find(Video_24133031.class, videoId);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Video_24133031> findAll() {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            TypedQuery<Video_24133031> query = em.createNamedQuery("Video_24133031.findAll", Video_24133031.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Video_24133031> findAll(int page, int pageSize) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            TypedQuery<Video_24133031> query = em.createQuery(
                "SELECT v FROM Video_24133031 v ORDER BY v.videoId ASC", Video_24133031.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long count() {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(v) FROM Video_24133031 v", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Video_24133031> findByCategory(int categoryId, int page, int pageSize) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            TypedQuery<Video_24133031> query = em.createQuery(
                "SELECT v FROM Video_24133031 v WHERE v.category.categoryId = :categoryId AND v.active = true ORDER BY v.videoId ASC", 
                Video_24133031.class);
            query.setParameter("categoryId", categoryId);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long countByCategory(int categoryId) {
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
    public long countLikes(String videoId) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(f) FROM Favorite_24133031 f WHERE f.video.videoId = :videoId", Long.class);
            query.setParameter("videoId", videoId);
            return query.getSingleResult();
        } catch (Exception e) {
            return 0;
        } finally {
            em.close();
        }
    }

    @Override
    public long countShares(String videoId) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(s) FROM Share_24133031 s WHERE s.video.videoId = :videoId", Long.class);
            query.setParameter("videoId", videoId);
            return query.getSingleResult();
        } catch (Exception e) {
            return 0;
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(Video_24133031 video) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(video);
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
    public void update(Video_24133031 video) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(video);
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
    public void delete(String videoId) throws Exception {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Video_24133031 video = em.find(Video_24133031.class, videoId);
            if (video != null) {
                em.remove(video);
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

    @Override
    public void increaseViews(String videoId) {
        EntityManager em = JPAConfig_24133031.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Video_24133031 video = em.find(Video_24133031.class, videoId);
            if (video != null) {
                video.setViews(video.getViews() + 1);
                em.merge(video);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
        } finally {
            em.close();
        }
    }
}
