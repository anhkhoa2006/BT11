<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Xác Thực Kích Hoạt OTP - Video Portal</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="card shadow-sm border-0 mt-4">
                <div class="card-header bg-success text-white text-center py-3">
                    <h4 class="mb-0"><i class="fa-solid fa-shield-halved me-2"></i>Xác Thực OTP</h4>
                    <small>Kích hoạt tài khoản người dùng</small>
                </div>
                <div class="card-body p-4">
                    <!-- Thông báo đã gửi email OTP -->
                    <c:if test="${not empty sessionScope.message}">
                        <div class="alert alert-info">
                            <i class="fa-solid fa-envelope me-1"></i>
                            ${sessionScope.message}
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-triangle-exclamation me-1"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
                        <div class="mb-3 text-center">
                            <label for="otp" class="form-label fw-bold">Nhập mã OTP (6 chữ số):</label>
                            <input type="text" class="form-control form-control-lg text-center fw-bold text-primary letter-spacing" 
                                   id="otp" name="otp" maxlength="6" placeholder="______" required autofocus
                                   style="letter-spacing: 6px; font-size: 1.8rem;">
                            <div class="form-text mt-2">Vui lòng kiểm tra hộp thư đến (hoặc thư rác/spam) của bạn để lấy mã OTP.</div>
                        </div>

                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-success btn-lg">
                                <i class="fa-solid fa-check-circle me-1"></i> Kích Hoạt Tài Khoản
                            </button>
                        </div>
                    </form>

                    <div class="text-center mt-3 pt-3 border-top">
                        <a href="${pageContext.request.contextPath}/register" class="text-muted text-decoration-none">
                            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại Đăng ký
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
