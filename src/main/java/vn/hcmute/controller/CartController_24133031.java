package vn.hcmute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import vn.hcmute.entity.Product_24133031;
import vn.hcmute.model.Cart_24133031;
import vn.hcmute.service.IProductService_24133031;
import vn.hcmute.service.ProductService_24133031;

@WebServlet(urlPatterns = {"/cart", "/cart/add", "/cart/update", "/cart/delete", "/cart/clear"})
public class CartController_24133031 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IProductService_24133031 productService = new ProductService_24133031();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {
            case "/cart/add":
                handleAdd(req, resp);
                break;
            case "/cart/update":
                handleUpdate(req, resp);
                break;
            case "/cart/delete":
                handleDelete(req, resp);
                break;
            case "/cart/clear":
                handleClear(req, resp);
                break;
            case "/cart":
            default:
                showCart(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    private Cart_24133031 getCartFromSession(HttpSession session) {
        Cart_24133031 cart = (Cart_24133031) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart_24133031();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    private void showCart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Cart_24133031 cart = getCartFromSession(session);
        req.setAttribute("cart", cart);
        req.getRequestDispatcher("/views/user/cart.jsp").forward(req, resp);
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        String idParam = req.getParameter("productId");
        String qtyParam = req.getParameter("quantity");
        String redirect = req.getParameter("redirect");

        int quantity = 1;
        if (qtyParam != null && !qtyParam.trim().isEmpty()) {
            try {
                quantity = Integer.parseInt(qtyParam);
                if (quantity < 1) quantity = 1;
            } catch (NumberFormatException ignored) {}
        }

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int productId = Integer.parseInt(idParam);
                Product_24133031 product = productService.findById(productId);
                if (product != null) {
                    if (product.getQuantity() <= 0) {
                        session.setAttribute("cartError", "Sản phẩm '" + product.getProductName() + "' hiện đã hết hàng trong kho!");
                    } else {
                        Cart_24133031 cart = getCartFromSession(session);
                        boolean ok = cart.add(product, quantity);
                        if (ok) {
                            session.setAttribute("cartSuccess", "Đã thêm " + quantity + " x '" + product.getProductName() + "' vào giỏ hàng thành công!");
                        } else {
                            session.setAttribute("cartWarning", "Đã thêm tối đa " + product.getQuantity() + " sản phẩm (đạt giới hạn số lượng tồn kho).");
                        }
                    }
                } else {
                    session.setAttribute("cartError", "Không tìm thấy sản phẩm yêu cầu.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("cartError", "Đã xảy ra lỗi khi thêm vào giỏ hàng.");
            }
        }

        if (redirect != null && !redirect.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + redirect);
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        String idParam = req.getParameter("productId");
        String qtyParam = req.getParameter("quantity");
        String actionParam = req.getParameter("action"); // 'inc' or 'dec' or direct qty

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int productId = Integer.parseInt(idParam);
                Product_24133031 product = productService.findById(productId);
                Cart_24133031 cart = getCartFromSession(session);

                if (product != null) {
                    int newQty = 1;
                    if ("inc".equalsIgnoreCase(actionParam)) {
                        // Tăng 1
                        int currentQty = 0;
                        if (cart.getItems() != null) {
                            for (var item : cart.getItems()) {
                                if (item.getProduct().getProductId() == productId) {
                                    currentQty = item.getQuantity();
                                    break;
                                }
                            }
                        }
                        newQty = currentQty + 1;
                    } else if ("dec".equalsIgnoreCase(actionParam)) {
                        // Giảm 1
                        int currentQty = 1;
                        if (cart.getItems() != null) {
                            for (var item : cart.getItems()) {
                                if (item.getProduct().getProductId() == productId) {
                                    currentQty = item.getQuantity();
                                    break;
                                }
                            }
                        }
                        newQty = currentQty - 1;
                    } else if (qtyParam != null && !qtyParam.trim().isEmpty()) {
                        newQty = Integer.parseInt(qtyParam);
                    }

                    String msg = cart.update(productId, newQty, product.getQuantity());
                    if (msg != null) {
                        session.setAttribute("cartWarning", msg);
                    } else {
                        session.setAttribute("cartSuccess", "Đã cập nhật số lượng thành công!");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("cartError", "Lỗi cập nhật giỏ hàng: " + e.getMessage());
            }
        }

        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        String idParam = req.getParameter("productId");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int productId = Integer.parseInt(idParam);
                Cart_24133031 cart = getCartFromSession(session);
                cart.remove(productId);
                session.setAttribute("cartSuccess", "Đã xóa sản phẩm khỏi giỏ hàng.");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void handleClear(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        Cart_24133031 cart = getCartFromSession(session);
        cart.clear();
        session.setAttribute("cartSuccess", "Đã làm trống giỏ hàng.");
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
