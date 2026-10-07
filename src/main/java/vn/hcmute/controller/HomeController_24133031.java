package vn.hcmute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import vn.hcmute.entity.Category_24133031;
import vn.hcmute.entity.Video_24133031;
import vn.hcmute.service.CategoryService_24133031;
import vn.hcmute.service.ICategoryService_24133031;
import vn.hcmute.service.IVideoService_24133031;
import vn.hcmute.service.VideoService_24133031;

@WebServlet(urlPatterns = {"/home", ""})
public class HomeController_24133031 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ICategoryService_24133031 categoryService = new CategoryService_24133031();
    private final IVideoService_24133031 videoService = new VideoService_24133031();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        try {
            // Lấy danh sách chuyên mục
            List<Category_24133031> categories = categoryService.findAllActive();
            for (Category_24133031 cat : categories) {
                // Đếm số lượng video theo từng Category (Câu 5)
                long count = categoryService.countVideosByCategory(cat.getCategoryId());
                cat.setVideoCount(count);
            }
            req.setAttribute("categories", categories);

            // Mặc định chọn category đầu tiên nếu không truyền param
            int selectedCatId = categories.isEmpty() ? 0 : categories.get(0).getCategoryId();
            String catIdParam = req.getParameter("categoryId");
            if (catIdParam != null && !catIdParam.trim().isEmpty()) {
                try {
                    selectedCatId = Integer.parseInt(catIdParam);
                } catch (NumberFormatException ignored) {}
            }
            req.setAttribute("selectedCatId", selectedCatId);

            // Phân trang 3 video / trang cho Category được chọn (Câu 4)
            int page = 1;
            int pageSize = 3;
            String pageParam = req.getParameter("page");
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException ignored) {}
            }

            long totalVideos = videoService.countByCategory(selectedCatId);
            int totalPages = (int) Math.ceil((double) totalVideos / pageSize);
            if (totalPages == 0) totalPages = 1;

            List<Video_24133031> videos = videoService.findByCategory(selectedCatId, page, pageSize);
            for (Video_24133031 v : videos) {
                v.setLikeCount(videoService.countLikes(v.getVideoId()));
                v.setShareCount(videoService.countShares(v.getVideoId()));
            }

            req.setAttribute("videos", videos);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);

        } catch (Exception e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher("/views/user/home.jsp").forward(req, resp);
    }
}
