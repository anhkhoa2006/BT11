package vn.hcmute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import vn.hcmute.entity.Category_24133031;
import vn.hcmute.entity.Product_24133031;
import vn.hcmute.service.CategoryService_24133031;
import vn.hcmute.service.ICategoryService_24133031;
import vn.hcmute.service.IProductService_24133031;
import vn.hcmute.service.ProductService_24133031;

@WebServlet(urlPatterns = {"/products", "/product/detail"})
public class ProductController_24133031 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IProductService_24133031 productService = new ProductService_24133031();
    private final ICategoryService_24133031 categoryService = new CategoryService_24133031();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/product/detail".equals(path)) {
            showDetail(req, resp);
        } else {
            showList(req, resp);
        }
    }

    private void showList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Category_24133031> categories = categoryService.findAllActive();
            for (Category_24133031 cat : categories) {
                cat.setVideoCount(productService.countByCategory(cat.getCategoryId()));
            }
            req.setAttribute("categories", categories);

            int selectedCatId = 0;
            String catIdParam = req.getParameter("categoryId");
            if (catIdParam != null && !catIdParam.trim().isEmpty()) {
                try {
                    selectedCatId = Integer.parseInt(catIdParam);
                } catch (NumberFormatException ignored) {}
            }
            req.setAttribute("selectedCatId", selectedCatId);

            int page = 1;
            int pageSize = 6;
            String pageParam = req.getParameter("page");
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException ignored) {}
            }

            long totalProducts = selectedCatId > 0 ? productService.countByCategory(selectedCatId) : productService.countAll();
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
            if (totalPages == 0) totalPages = 1;

            List<Product_24133031> products = productService.findByCategory(selectedCatId, page, pageSize);

            req.setAttribute("products", products);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalProducts", totalProducts);

        } catch (Exception e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher("/views/user/products.jsp").forward(req, resp);
    }

    private void showDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/products");
            return;
        }

        try {
            int productId = Integer.parseInt(idParam);
            Product_24133031 product = productService.findById(productId);
            if (product == null) {
                resp.sendRedirect(req.getContextPath() + "/products");
                return;
            }
            req.setAttribute("product", product);

            // Gợi ý các sản phẩm cùng danh mục
            if (product.getCategory() != null) {
                List<Product_24133031> relatedProducts = productService.findByCategory(product.getCategory().getCategoryId(), 1, 4);
                req.setAttribute("relatedProducts", relatedProducts);
            }

            req.getRequestDispatcher("/views/user/product-detail.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/products");
        }
    }
}
