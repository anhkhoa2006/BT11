package vn.hcmute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import vn.hcmute.config.JPAConfig_24133031;
import vn.hcmute.entity.Favorite_24133031;
import vn.hcmute.entity.Share_24133031;
import vn.hcmute.entity.User_24133031;
import vn.hcmute.entity.Video_24133031;
import vn.hcmute.service.IVideoService_24133031;
import vn.hcmute.service.VideoService_24133031;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

@WebServlet(urlPatterns = {"/video/detail", "/video-detail"})
public class VideoDetailController_24133031 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IVideoService_24133031 videoService = new VideoService_24133031();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String videoId = req.getParameter("id");
        if (videoId == null || videoId.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        try {
            // Tăng số lượt xem (View count + 1)
            videoService.increaseViews(videoId.trim());

            // Lấy thông tin video
            Video_24133031 video = videoService.findById(videoId.trim());
            if (video == null) {
                resp.sendRedirect(req.getContextPath() + "/home");
                return;
            }

            // Đếm số lượng like và share thực tế từ CSDL
            long likeCount = videoService.countLikes(videoId.trim());
            long shareCount = videoService.countShares(videoId.trim());
            video.setLikeCount(likeCount);
            video.setShareCount(shareCount);

            req.setAttribute("video", video);

        } catch (Exception e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher("/views/user/video-detail.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        String videoId = req.getParameter("videoId");

        HttpSession session = req.getSession();
        User_24133031 account = (User_24133031) session.getAttribute("account");

        if (videoId != null && !videoId.trim().isEmpty()) {
            if ("like".equalsIgnoreCase(action)) {
                // Xử lý Thích Video
                if (account == null) {
                    resp.sendRedirect(req.getContextPath() + "/login");
                    return;
                }
                EntityManager em = JPAConfig_24133031.getEntityManager();
                EntityTransaction trans = em.getTransaction();
                try {
                    trans.begin();
                    Video_24133031 v = em.find(Video_24133031.class, videoId.trim());
                    User_24133031 u = em.find(User_24133031.class, account.getUsername());
                    Favorite_24133031 fav = new Favorite_24133031(new Date(), u, v);
                    em.persist(fav);
                    trans.commit();
                } catch (Exception e) {
                    if (trans.isActive()) trans.rollback();
                } finally {
                    em.close();
                }
            } else if ("share".equalsIgnoreCase(action)) {
                // Xử lý Chia Sẻ Video
                String email = req.getParameter("email");
                if (account == null) {
                    resp.sendRedirect(req.getContextPath() + "/login");
                    return;
                }
                EntityManager em = JPAConfig_24133031.getEntityManager();
                EntityTransaction trans = em.getTransaction();
                try {
                    trans.begin();
                    Video_24133031 v = em.find(Video_24133031.class, videoId.trim());
                    User_24133031 u = em.find(User_24133031.class, account.getUsername());
                    Share_24133031 share = new Share_24133031(email != null ? email : "friend@gmail.com", new Date(), u, v);
                    em.persist(share);
                    trans.commit();
                } catch (Exception e) {
                    if (trans.isActive()) trans.rollback();
                } finally {
                    em.close();
                }
            }
        }

        resp.sendRedirect(req.getContextPath() + "/video/detail?id=" + videoId);
    }
}
