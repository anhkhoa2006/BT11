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

@WebServlet(urlPatterns = {"/verify-otp"})
public class VerifyOtpController_24133031 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IUserService_24133031 userService = new UserService_24133031();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String enteredOtp = req.getParameter("otp");
        HttpSession session = req.getSession();
        String sessionOtp = (String) session.getAttribute("otp");
        User_24133031 tempUser = (User_24133031) session.getAttribute("tempUser");

        if (sessionOtp == null || tempUser == null) {
            req.setAttribute("error", "Phiên xác thực đã hết hạn! Vui lòng đăng ký lại.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (enteredOtp != null && enteredOtp.trim().equals(sessionOtp.trim())) {
            // Kích hoạt tài khoản thành công
            tempUser.setActive(true);
            userService.insert(tempUser);

            // Xóa session OTP
            session.removeAttribute("otp");
            session.removeAttribute("tempUser");
            session.removeAttribute("otpTime");

            session.setAttribute("successMsg", "Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay bây giờ.");
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            req.setAttribute("error", "Mã OTP không chính xác hoặc đã hết hạn! Vui lòng kiểm tra lại.");
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }
}
