package vn.hcmute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import vn.hcmute.entity.Order_24133031;
import vn.hcmute.entity.User_24133031;
import vn.hcmute.service.IOrderService_24133031;
import vn.hcmute.service.OrderService_24133031;

@WebServlet(urlPatterns = {"/my-orders", "/order/detail", "/order/cancel"})
public class OrderHistoryController_24133031 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IOrderService_24133031 orderService = new OrderService_24133031();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        HttpSession session = req.getSession();
        User_24133031 user = (User_24133031) session.getAttribute("account");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login?redirect=" + path);
            return;
        }

        switch (path) {
            case "/order/detail":
                showOrderDetail(req, resp, user);
                break;
            case "/order/cancel":
                handleCancelOrder(req, resp, user);
                break;
            case "/my-orders":
            default:
                showOrderHistory(req, resp, user);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    private void showOrderHistory(HttpServletRequest req, HttpServletResponse resp, User_24133031 user) throws ServletException, IOException {
        String status = req.getParameter("status");
        if (status == null || status.trim().isEmpty()) {
            status = "ALL";
        }
        status = status.trim().toUpperCase();

        try {
            // Lấy tất cả đơn hàng của user để tính số lượng theo từng tab trạng thái
            List<Order_24133031> allUserOrders = orderService.findByUsername(user.getUsername());
            Map<String, Integer> statusCounts = new HashMap<>();
            statusCounts.put("ALL", allUserOrders.size());
            statusCounts.put("NEW", 0);
            statusCounts.put("CONFIRMED", 0);
            statusCounts.put("PREPARING", 0);
            statusCounts.put("SHIPPING", 0);
            statusCounts.put("DELIVERING", 0);
            statusCounts.put("DELIVERED", 0);
            statusCounts.put("CANCELLED", 0);
            statusCounts.put("RETURNED", 0);

            for (Order_24133031 o : allUserOrders) {
                String s = o.getStatus() != null ? o.getStatus().trim().toUpperCase() : "";
                if (s.equals("NEW") || s.equals("ĐƠN HÀNG MỚI") || s.equals("DON HANG MOI")) {
                    statusCounts.put("NEW", statusCounts.get("NEW") + 1);
                } else if (s.equals("CONFIRMED") || s.equals("ĐÃ XÁC NHẬN") || s.equals("DA XAC NHAN")) {
                    statusCounts.put("CONFIRMED", statusCounts.get("CONFIRMED") + 1);
                } else if (s.equals("PREPARING") || s.equals("CHUẨN BỊ HÀNG") || s.equals("CHUAN BI HANG")) {
                    statusCounts.put("PREPARING", statusCounts.get("PREPARING") + 1);
                } else if (s.equals("SHIPPING") || s.equals("VẬN CHUYỂN") || s.equals("VAN CHUYEN")) {
                    statusCounts.put("SHIPPING", statusCounts.get("SHIPPING") + 1);
                } else if (s.equals("DELIVERING") || s.equals("GIAO HÀNG") || s.equals("GIAO HANG")) {
                    statusCounts.put("DELIVERING", statusCounts.get("DELIVERING") + 1);
                } else if (s.equals("DELIVERED") || s.equals("ĐÃ GIAO") || s.equals("DA GIAO")) {
                    statusCounts.put("DELIVERED", statusCounts.get("DELIVERED") + 1);
                } else if (s.equals("CANCELLED") || s.equals("CANCELED") || s.equals("ĐƠN HÀNG HỦY") || s.equals("DON HANG HUY") || s.equals("HỦY")) {
                    statusCounts.put("CANCELLED", statusCounts.get("CANCELLED") + 1);
                } else if (s.equals("RETURNED") || s.equals("ĐƠN HÀNG HOÀN") || s.equals("DON HANG HOAN") || s.equals("HOÀN HÀNG")) {
                    statusCounts.put("RETURNED", statusCounts.get("RETURNED") + 1);
                }
            }
            req.setAttribute("statusCounts", statusCounts);

            // Lấy danh sách đơn hàng đã lọc
            List<Order_24133031> filteredOrders = orderService.findByUsernameAndStatus(user.getUsername(), status);
            req.setAttribute("orders", filteredOrders);
            req.setAttribute("currentStatus", status);

        } catch (Exception e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher("/views/user/order-history.jsp").forward(req, resp);
    }

    private void showOrderDetail(HttpServletRequest req, HttpServletResponse resp, User_24133031 user) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/my-orders");
            return;
        }

        try {
            int orderId = Integer.parseInt(idParam);
            Order_24133031 order = orderService.findById(orderId);
            if (order == null || (!order.getUser().getUsername().equals(user.getUsername()) && !user.isAdmin())) {
                resp.sendRedirect(req.getContextPath() + "/my-orders");
                return;
            }

            req.setAttribute("order", order);
            req.getRequestDispatcher("/views/user/order-detail.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/my-orders");
        }
    }

    private void handleCancelOrder(HttpServletRequest req, HttpServletResponse resp, User_24133031 user) throws IOException {
        HttpSession session = req.getSession();
        String idParam = req.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int orderId = Integer.parseInt(idParam);
                boolean success = orderService.cancelOrder(orderId, user.getUsername());
                if (success) {
                    session.setAttribute("orderSuccess", "Đã hủy đơn hàng #" + orderId + " thành công!");
                } else {
                    session.setAttribute("orderError", "Không thể hủy đơn hàng này do đơn đã được xử lý hoặc không hợp lệ.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("orderError", "Lỗi: " + e.getMessage());
            }
        }
        resp.sendRedirect(req.getContextPath() + "/my-orders");
    }
}
