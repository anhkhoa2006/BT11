<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Trang Quản Trị Admin</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <style>
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background-color: #f4f6f9;
        }
        .admin-wrapper {
            display: flex;
            flex: 1;
        }
        .sidebar {
            width: 250px;
            background-color: #1e293b;
            color: #fff;
            min-height: calc(100vh - 120px);
        }
        .sidebar a {
            color: #94a3b8;
            padding: 12px 20px;
            display: block;
            text-decoration: none;
            font-size: 0.95rem;
            transition: all 0.3s;
        }
        .sidebar a:hover, .sidebar a.active {
            color: #ffffff;
            background-color: #0f172a;
            border-left: 4px solid #0d6efd;
        }
        .content-area {
            flex: 1;
            padding: 25px;
        }
        .footer {
            background-color: #0f172a;
            color: #f8f9fa;
            padding: 15px 0;
            border-top: 2px solid #334155;
        }
        .footer-badge {
            background-color: #ffc107;
            color: #000;
            font-weight: bold;
            padding: 3px 8px;
            border-radius: 4px;
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>
    <!-- ADMIN TOP NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3 shadow-sm">
        <a class="navbar-brand fw-bold text-warning" href="${pageContext.request.contextPath}/admin/videos">
            <i class="fa-solid fa-gauge-high me-2"></i>ADMIN CONTROL PANEL
        </a>
        <div class="ms-auto d-flex align-items-center">
            <span class="text-light me-3">
                <i class="fa-solid fa-user-shield text-danger me-1"></i>
                Xin chào Admin, <strong>${sessionScope.account != null ? sessionScope.account.fullname : 'Trần Anh Khoa'}</strong>
            </span>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-info btn-sm me-2">
                <i class="fa-solid fa-globe me-1"></i> Xem trang User
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">
                <i class="fa-solid fa-arrow-right-from-bracket me-1"></i> Đăng xuất
            </a>
        </div>
    </nav>

    <!-- ADMIN BODY WITH SIDEBAR -->
    <div class="admin-wrapper">
        <aside class="sidebar">
            <div class="p-3 text-uppercase text-secondary fw-bold" style="font-size: 0.8rem; letter-spacing: 1px;">
                Quản lý hệ thống
            </div>
            <a href="${pageContext.request.contextPath}/admin/videos" class="active">
                <i class="fa-solid fa-video me-2"></i> Quản lý Videos (CRUD)
            </a>
            <a href="${pageContext.request.contextPath}/home">
                <i class="fa-solid fa-layer-group me-2"></i> Danh mục Category
            </a>
            <a href="${pageContext.request.contextPath}/home">
                <i class="fa-solid fa-house me-2"></i> Về Trang chủ User
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="text-danger">
                <i class="fa-solid fa-power-off me-2"></i> Đăng xuất
            </a>
        </aside>

        <section class="content-area">
            <sitemesh:write property='body'/>
        </section>
    </div>

    <!-- FOOTER: Họ tên, MSSV, Mã đề -->
    <footer class="footer text-center">
        <div class="container">
            <p class="mb-0">
                <strong>Họ tên:</strong> <span class="text-info fw-bold">Trần Anh Khoa</span> | 
                <strong>MSSV:</strong> <span class="text-warning fw-bold">24133031</span> | 
                <strong>Mã đề:</strong> <span class="footer-badge">3</span>
            </p>
        </div>
    </footer>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
