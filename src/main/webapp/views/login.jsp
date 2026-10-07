<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng Nhập - Video Portal</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="card shadow-sm border-0 mt-3">
                <div class="card-header bg-dark text-white text-center py-3">
                    <h4 class="mb-0"><i class="fa-solid fa-right-to-bracket me-2"></i>Đăng Nhập</h4>
                    <small>Đề thi Lập Trình Web - Trần Anh Khoa (24133031)</small>
                </div>
                <div class="card-body p-4">
                    <!-- Thông báo kích hoạt OTP thành công nếu có -->
                    <c:if test="${not empty successMsg}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-circle-check me-1"></i> ${successMsg}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Thông báo lỗi đăng nhập nếu có -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-triangle-exclamation me-1"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <!-- Username -->
                        <div class="mb-3">
                            <label for="username" class="form-label fw-bold">Tên đăng nhập</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                                <input type="text" class="form-control" id="username" name="username" placeholder="Tên đăng nhập" required autofocus>
                            </div>
                        </div>

                        <!-- Password -->
                        <div class="mb-3">
                            <label for="password" class="form-label fw-bold">Mật khẩu</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Mật khẩu" required>
                            </div>
                        </div>

                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="fa-solid fa-sign-in me-1"></i> Đăng Nhập
                            </button>
                        </div>
                    </form>

                    <!-- Gợi ý tài khoản để test nhanh -->
                    <div class="alert alert-secondary mt-4 mb-0 small">
                        <strong><i class="fa-solid fa-key me-1"></i>Tài khoản mẫu:</strong><br>
                        • <strong>Admin:</strong> <code>admin</code> / <code>123456</code> (Vào thẳng trang Admin)<br>
                        • <strong>User:</strong> <code>khoa24133031</code> / <code>123456</code> (Vào trang Home)
                    </div>

                    <div class="text-center mt-3 pt-3 border-top">
                        <span>Chưa có tài khoản? </span>
                        <a href="${pageContext.request.contextPath}/register" class="fw-bold text-decoration-none">Đăng ký ngay</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
