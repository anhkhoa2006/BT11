<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bảng Điều Khiển Quản Trị</title>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-primary text-white py-3">
                        <h5 class="mb-0"><i class="fa-solid fa-gauge-high me-2"></i>Chào mừng đến với Hệ thống Quản trị</h5>
                    </div>
                    <div class="card-body p-4">
                        <div class="alert alert-info">
                            <strong>Thông tin dự thi:</strong>
                            <ul class="mb-0 mt-2">
                                <li>Họ và tên: <strong>Trần Anh Khoa</strong></li>
                                <li>MSSV: <strong>24133031</strong></li>
                                <li>Mã đề: <strong>3</strong></li>
                            </ul>
                        </div>
                        <a href="${pageContext.request.contextPath}/admin/videos" class="btn btn-primary">
                            <i class="fa-solid fa-video me-2"></i>Đi đến Quản lý Videos (CRUD Phân trang)
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
