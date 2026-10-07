<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Web Đề 03</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <style>
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background-color: #f8f9fa;
        }
        .main-content {
            flex: 1;
        }
        .navbar-brand {
            font-weight: 700;
            color: #0d6efd !important;
        }
        .footer {
            background-color: #212529;
            color: #f8f9fa;
            padding: 20px 0;
            margin-top: 40px;
        }
        .footer-info {
            font-size: 1.05rem;
            letter-spacing: 0.5px;
        }
        .footer-badge {
            background-color: #ffc107;
            color: #000;
            font-weight: bold;
            padding: 4px 10px;
            border-radius: 4px;
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>
    <!-- HEADER -->
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                    <i class="fa-solid fa-play-circle text-danger me-1"></i> VIDEO & SHOP PORTAL
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#userNavbar">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="userNavbar">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <!-- Menu Trang Chủ (Videos) -->
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/home">
                                <i class="fa-solid fa-house me-1"></i> Trang Chủ
                            </a>
                        </li>
                        <!-- Menu Sản phẩm / Cửa hàng -->
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/products">
                                <i class="fa-solid fa-store me-1"></i> Sản phẩm
                            </a>
                        </li>
                        <!-- Menu Lịch sử đơn hàng -->
                        <c:if test="${not empty sessionScope.account}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/my-orders">
                                    <i class="fa-solid fa-clock-rotate-left me-1"></i> Lịch sử đơn hàng
                                </a>
                            </li>
                        </c:if>
                        <!-- Menu Trang quản trị: ADMIN MỚI CÓ CHỨC NĂNG NÀY -->
                        <c:if test="${not empty sessionScope.account and sessionScope.account.admin}">
                            <li class="nav-item">
                                <a class="nav-link text-warning fw-bold" href="${pageContext.request.contextPath}/admin/videos">
                                    <i class="fa-solid fa-screwdriver-wrench me-1"></i> Trang quản trị
                                </a>
                            </li>
                        </c:if>
                    </ul>

                    <!-- Giỏ hàng và Tài khoản -->
                    <div class="d-flex align-items-center gap-2">
                        <!-- NÚT GIỎ HÀNG -->
                        <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-warning btn-sm position-relative me-2">
                            <i class="fa-solid fa-cart-shopping me-1"></i> Giỏ hàng
                            <span class="badge bg-danger rounded-pill ms-1">
                                ${sessionScope.cart != null ? sessionScope.cart.totalQuantity : 0}
                            </span>
                        </a>

                        <!-- Menu Đăng nhập / Tài khoản -->
                        <ul class="navbar-nav mb-0">
                            <c:choose>
                                <c:when test="${empty sessionScope.account}">
                                    <li class="nav-item">
                                        <a class="btn btn-outline-light btn-sm me-2" href="${pageContext.request.contextPath}/login">
                                            <i class="fa-solid fa-right-to-bracket me-1"></i> Đăng nhập
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/register">
                                            <i class="fa-solid fa-user-plus me-1"></i> Đăng ký
                                        </a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle text-light" href="#" role="button" data-bs-toggle="dropdown">
                                            <i class="fa-solid fa-circle-user me-1 text-info"></i> Xin chào, <strong>${sessionScope.account.fullname}</strong>
                                            <c:if test="${sessionScope.account.admin}">
                                                <span class="badge bg-danger ms-1">Admin</span>
                                            </c:if>
                                        </a>
                                        <ul class="dropdown-menu dropdown-menu-end shadow">
                                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/my-orders"><i class="fa-solid fa-clock-rotate-left me-2 text-primary"></i>Lịch sử đặt hàng</a></li>
                                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/cart"><i class="fa-solid fa-cart-shopping me-2 text-warning"></i>Giỏ hàng của tôi</a></li>
                                            <c:if test="${sessionScope.account.admin}">
                                                <li><hr class="dropdown-divider"></li>
                                                <li><a class="dropdown-item text-warning" href="${pageContext.request.contextPath}/admin/videos"><i class="fa-solid fa-gear me-2"></i>Quản trị hệ thống</a></li>
                                            </c:if>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-arrow-right-from-bracket me-2"></i>Đăng xuất</a></li>
                                        </ul>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
    </header>

    <!-- MAIN BODY -->
    <main class="main-content py-4">
        <div class="container">
            <sitemesh:write property='body'/>
        </div>
    </main>

    <!-- FOOTER: Họ tên, MSSV, Mã đề -->
    <footer class="footer">
        <div class="container text-center">
            <div class="row align-items-center">
                <div class="col-md-12 footer-info">
                    <p class="mb-1">
                        <strong>Họ tên:</strong> <span class="text-info fw-bold">Trần Anh Khoa</span> | 
                        <strong>MSSV:</strong> <span class="text-warning fw-bold">24133031</span> | 
                        <strong>Mã đề:</strong> <span class="footer-badge">3</span>
                    </p>
                    <small class="text-muted">Đề thi Quá trình – HK1 – Môn Lập Trình Web – Khoa CNTT HCMUTE</small>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
