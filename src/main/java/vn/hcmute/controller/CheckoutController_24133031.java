package vn.hcmute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import vn.hcmute.entity.Order_24133031;
import vn.hcmute.entity.User_24133031;
import vn.hcmute.model.Cart_24133031;
import vn.hcmute.service.IOrderService_24133031;
import vn.hcmute.service.OrderService_24133031;

@WebServlet(urlPatterns = {"/checkout", "/checkout/success"})
public class CheckoutController_24133031 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IOrderService_24133031 orderService = new OrderService_24133031();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/checkout/success".equals(path)) {
            showSuccess(req, resp);
        } else {
            showCheckoutForm(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User_24133031 user = (User_24133031) session.getAttribute("account");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login?redirect=/checkout");
            return;
        }

        Cart_24133031 cart = (Cart_24133031) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            session.setAttribute("cartWarning", "Giỏ hàng của bạn đang trống!");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String note = req.getParameter("note");
        String paymentMethod = req.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            paymentMethod = "COD";
        }

        try {
            Order_24133031 order = orderService.createOrderFromCart(
                user, cart, fullname, phone, address, note, paymentMethod
            );

            session.setAttribute("latestOrder", order);
            resp.sendRedirect(req.getContextPath() + "/checkout/success?orderId=" + order.getOrderId());
        } catch (IllegalArgumentException | IllegalStateException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.setAttribute("fullname", fullname);
            req.setAttribute("phone", phone);
            req.setAttribute("address", address);
            req.setAttribute("note", note);
            req.setAttribute("cart", cart);
            req.getRequestDispatcher("/views/user/checkout.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Đã xảy ra lỗi trong quá trình đặt hàng: " + e.getMessage());
            req.setAttribute("cart", cart);
            req.getRequestDispatcher("/views/user/checkout.jsp").forward(req, resp);
        }
    }

    private void showCheckoutForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User_24133031 user = (User_24133031) session.getAttribute("account");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login?redirect=/checkout");
            return;
        }

        Cart_24133031 cart = (Cart_24133031) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            session.setAttribute("cartWarning", "Giỏ hàng của bạn đang trống! Vui lòng chọn sản phẩm trước khi thanh toán.");
            resp.sendRedirect(req.getContextPath() + "/products");
            return;
        }

        // Điền thông tin mặc định từ tài khoản người dùng
        if (req.getAttribute("fullname") == null) {
            req.setAttribute("fullname", user.getFullname());
        }
        if (req.getAttribute("phone") == null) {
            req.setAttribute("phone", user.getPhone());
        }

        req.setAttribute("cart", cart);
        req.getRequestDispatcher("/views/user/checkout.jsp").forward(req, resp);
    }

    private void showSuccess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("orderId");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int orderId = Integer.parseInt(idParam);
                Order_24133031 order = orderService.findById(orderId);
                req.setAttribute("order", order);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        req.getRequestDispatcher("/views/user/checkout-success.jsp").forward(req, resp);
    }
}
