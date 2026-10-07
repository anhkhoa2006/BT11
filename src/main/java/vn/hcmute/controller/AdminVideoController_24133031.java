package vn.hcmute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import vn.hcmute.entity.Category_24133031;
import vn.hcmute.entity.User_24133031;
import vn.hcmute.entity.Video_24133031;
import vn.hcmute.service.CategoryService_24133031;
import vn.hcmute.service.ICategoryService_24133031;
import vn.hcmute.service.IVideoService_24133031;
import vn.hcmute.service.VideoService_24133031;

@WebServlet(urlPatterns = {"/admin/videos"})
public class AdminVideoController_24133031 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IVideoService_24133031 videoService = new VideoService_24133031();
    private final ICategoryService_24133031 categoryService = new CategoryService_24133031();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        // Kiểm tra quyền Admin
        HttpSession session = req.getSession();
        User_24133031 account = (User_24133031) session.getAttribute("account");
        if (account == null || !account.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            // Xử lý Xóa video (Delete)
            if ("delete".equalsIgnoreCase(action)) {
                String id = req.getParameter("id");
                if (id != null && !id.trim().isEmpty()) {
                    videoService.delete(id.trim());
                    session.setAttribute("adminMsg", "Xóa video [" + id + "] thành công!");
                }
                resp.sendRedirect(req.getContextPath() + "/admin/videos");
                return;
            }

            // Xử lý lấy thông tin video để sửa (Update)
            if ("edit".equalsIgnoreCase(action)) {
                String id = req.getParameter("id");
                if (id != null && !id.trim().isEmpty()) {
                    Video_24133031 video = videoService.findById(id.trim());
                    req.setAttribute("video", video);
                    req.setAttribute("isEdit", true);
                }
            }

            // Lấy thông báo từ session nếu có
            String adminMsg = (String) session.getAttribute("adminMsg");
            if (adminMsg != null) {
                req.setAttribute("adminMsg", adminMsg);
                session.removeAttribute("adminMsg");
            }
            String adminError = (String) session.getAttribute("adminError");
            if (adminError != null) {
                req.setAttribute("adminError", adminError);
                session.removeAttribute("adminError");
            }

            // Phân trang 6 video trên 01 trang theo đúng yêu cầu đề bài
            int page = 1;
            int pageSize = 6;
            String pageParam = req.getParameter("page");
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException ignored) {}
            }

            long totalVideos = videoService.count();
            int totalPages = (int) Math.ceil((double) totalVideos / pageSize);
            if (totalPages == 0) totalPages = 1;
            if (page > totalPages) page = totalPages;

            List<Video_24133031> videoList = videoService.findAll(page, pageSize);
            List<Category_24133031> categories = categoryService.findAll();

            req.setAttribute("videoList", videoList);
            req.setAttribute("categories", categories);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalVideos", totalVideos);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("adminError", "Đã xảy ra lỗi: " + e.getMessage());
        }

        req.getRequestDispatcher("/views/admin/video-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        HttpSession session = req.getSession();
        User_24133031 account = (User_24133031) session.getAttribute("account");
        if (account == null || !account.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        String videoId = req.getParameter("videoId");
        String title = req.getParameter("title");
        String poster = req.getParameter("poster");
        String description = req.getParameter("description");
        String viewsStr = req.getParameter("views");
        String categoryIdStr = req.getParameter("categoryId");
        boolean active = req.getParameter("active") != null;

        try {
            if ("create".equalsIgnoreCase(action)) {
                // Thêm mới Video
                if (videoId == null || videoId.trim().isEmpty() || title == null || title.trim().isEmpty()) {
                    session.setAttribute("adminError", "Mã video và Tiêu đề không được để trống!");
                    resp.sendRedirect(req.getContextPath() + "/admin/videos");
                    return;
                }

                if (videoService.findById(videoId.trim()) != null) {
                    session.setAttribute("adminError", "Mã video [" + videoId + "] đã tồn tại!");
                    resp.sendRedirect(req.getContextPath() + "/admin/videos");
                    return;
                }

                int categoryId = Integer.parseInt(categoryIdStr);
                Category_24133031 category = categoryService.findById(categoryId);

                int views = 0;
                try {
                    views = Integer.parseInt(viewsStr);
                } catch (Exception ignored) {}

                Video_24133031 newVideo = new Video_24133031();
                newVideo.setVideoId(videoId.trim());
                newVideo.setTitle(title.trim());
                newVideo.setPoster(poster != null && !poster.trim().isEmpty() ? poster.trim() : "https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=400");
                newVideo.setDescription(description != null ? description.trim() : "");
                newVideo.setViews(views);
                newVideo.setActive(active);
                newVideo.setCategory(category);

                videoService.insert(newVideo);
                session.setAttribute("adminMsg", "Thêm mới video [" + videoId + "] thành công!");

            } else if ("update".equalsIgnoreCase(action)) {
                // Cập nhật Video
                if (videoId == null || videoId.trim().isEmpty()) {
                    session.setAttribute("adminError", "Không tìm thấy mã video cần cập nhật!");
                    resp.sendRedirect(req.getContextPath() + "/admin/videos");
                    return;
                }

                Video_24133031 existingVideo = videoService.findById(videoId.trim());
                if (existingVideo != null) {
                    existingVideo.setTitle(title != null ? title.trim() : existingVideo.getTitle());
                    if (poster != null && !poster.trim().isEmpty()) {
                        existingVideo.setPoster(poster.trim());
                    }
                    existingVideo.setDescription(description != null ? description.trim() : "");
                    try {
                        existingVideo.setViews(Integer.parseInt(viewsStr));
                    } catch (Exception ignored) {}
                    existingVideo.setActive(active);

                    int categoryId = Integer.parseInt(categoryIdStr);
                    Category_24133031 category = categoryService.findById(categoryId);
                    existingVideo.setCategory(category);

                    videoService.update(existingVideo);
                    session.setAttribute("adminMsg", "Cập nhật video [" + videoId + "] thành công!");
                } else {
                    session.setAttribute("adminError", "Không tìm thấy video có mã [" + videoId + "]!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("adminError", "Lỗi xử lý: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/videos");
    }
}
