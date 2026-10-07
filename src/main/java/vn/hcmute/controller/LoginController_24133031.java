package vn.hcmute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import vn.hcmute.entity.User_24133031;
import vn.hcmute.service.IUserService_24133031;
import vn.hcmute.service.UserService_24133031;

@WebServlet(urlPatterns = {"/login"})
public class LoginController_24133031 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IUserService_24133031 userService = new UserService_24133031();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        // Lấy thông báo thành công (nếu có từ kích hoạt OTP)
        HttpSession session = req.getSession();
        String successMsg = (String) session.getAttribute("successMsg");
        if (successMsg != null) {
            req.setAttribute("successMsg", successMsg);
            session.removeAttribute("successMsg");
        }

        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        User_24133031 user = userService.login(username.trim(), password.trim());

        if (user != null) {
            // Kiểm tra trạng thái kích hoạt OTP
            if (!user.isActive()) {
                req.setAttribute("error", "Tài khoản chưa được kích hoạt OTP! Vui lòng kích hoạt trước khi đăng nhập.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                return;
            }

            // Lưu thông tin người dùng vào Session
            HttpSession session = req.getSession();
            session.setAttribute("account", user);

            // "Đăng nhập với vai trò admin thành công thì vào trang chủ của Admin, ngược lại thì quay lại trang đăng nhập."
            if (user.isAdmin()) {
                resp.sendRedirect(req.getContextPath() + "/admin/videos");
            } else {
                // Nếu là tài khoản user thường, chuyển về trang chủ User
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            req.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu! Vui lòng thử lại.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}
