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
import vn.hcmute.utils.EmailUtil_24133031;

@WebServlet(urlPatterns = {"/register"})
public class RegisterController_24133031 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IUserService_24133031 userService = new UserService_24133031();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");

        // Validate cơ bản
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()
                || email == null || email.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ các trường bắt buộc!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra xem username đã tồn tại chưa
        if (userService.findById(username) != null) {
            req.setAttribute("error", "Tên đăng nhập '" + username + "' đã tồn tại!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra xem email đã tồn tại chưa
        if (userService.findByEmail(email) != null) {
            req.setAttribute("error", "Email '" + email + "' đã được sử dụng!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        // Tạo đối tượng User tạm thời (Active = false chờ kích hoạt OTP)
        User_24133031 tempUser = new User_24133031();
        tempUser.setUsername(username.trim());
        tempUser.setPassword(password.trim());
        tempUser.setFullname(fullname != null ? fullname.trim() : username);
        tempUser.setEmail(email.trim());
        tempUser.setPhone(phone != null ? phone.trim() : "");
        tempUser.setAdmin(false);
        tempUser.setActive(false); // Chưa kích hoạt
        tempUser.setImages("https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150");

        // Sinh mã OTP 6 số
        String otp = EmailUtil_24133031.generateOTP();

        // Lưu vào Session
        HttpSession session = req.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("tempUser", tempUser);
        session.setAttribute("otpTime", System.currentTimeMillis());

        // Gửi mã OTP vào hộp thư Email của người dùng (chỉ gửi mail, không in ra console)
        String subject = "Mã xác thực OTP đăng ký tài khoản - Video Portal";
        String messageText = "Xin chào " + tempUser.getFullname() + ",\n\n"
                + "Mã OTP xác thực kích hoạt tài khoản của bạn là: " + otp + "\n"
                + "Mã này có hiệu lực trong vòng 5 phút.\n\n"
                + "Thí sinh: Trần Anh Khoa - MSSV: 24133031 - Mã đề: 3";
        
        boolean sent = EmailUtil_24133031.sendEmail(tempUser.getEmail(), subject, messageText);
        if (!sent) {
            req.setAttribute("error", "Không thể gửi email OTP đến địa chỉ này! Vui lòng kiểm tra lại email.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        // Chuyển sang trang nhập OTP
        session.setAttribute("message", "Mã OTP đã được gửi đến email " + tempUser.getEmail() + ". Vui lòng kiểm tra hộp thư để kích hoạt tài khoản.");
        resp.sendRedirect(req.getContextPath() + "/verify-otp");
    }
}
