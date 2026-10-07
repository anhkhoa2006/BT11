<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt Hàng Thành Công - Mua Sắm Online</title>
    <style>
        .success-box {
            background: #fff;
            border-radius: 12px;
            padding: 40px;
            max-width: 750px;
            margin: 0 auto;
        }
        .success-icon {
            font-size: 5rem;
            color: #198754;
        }
    </style>
</head>
<body>
    <div class="success-box shadow text-center my-3">
        <i class="fa-solid fa-circle-check success-icon mb-3 animate__animated animate__bounceIn"></i>
        <h2 class="fw-bold text-success mb-2">Đặt Hàng Thành Công!</h2>
        <p class="text-muted fs-5 mb-4">Cảm ơn quý khách đã mua sắm. Đơn hàng của quý khách đã được tiếp nhận và chuyển đến bộ phận xử lý.</p>

        <c:if test="${not empty order}">
            <div class="card bg-light border-0 rounded-3 p-3 text-start mb-4">
                <div class="row g-2">
                    <div class="col-sm-6">
                        <strong>Mã đơn hàng:</strong> <span class="badge bg-primary fs-6">#${order.orderId}</span>
                    </div>
                    <div class="col-sm-6">
                        <strong>Ngày đặt:</strong> <span><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm:ss"/></span>
                    </div>
                    <div class="col-sm-6">
                        <strong>Phương thức thanh toán:</strong> <span class="badge bg-success">COD (Tiền mặt)</span>
                    </div>
                    <div class="col-sm-6">
                        <strong>Trạng thái:</strong> <span class="badge ${order.statusBadgeClass}">${order.statusText}</span>
                    </div>
                    <div class="col-12 mt-2">
                        <strong>Người nhận:</strong> <span>${order.fullname} - ${order.phone}</span>
                    </div>
                    <div class="col-12">
                        <strong>Địa chỉ giao hàng:</strong> <span>${order.address}</span>
                    </div>
                    <div class="col-12 mt-2 pt-2 border-top">
                        <strong>Tổng số tiền cần thanh toán:</strong> 
                        <span class="text-danger fw-bold fs-5"><fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/> đ</span>
                    </div>
                </div>
            </div>
        </c:if>

        <div class="d-flex justify-content-center gap-3 flex-wrap">
            <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-primary btn-lg fw-bold shadow-sm px-4">
                <i class="fa-solid fa-clock-rotate-left me-2"></i> Xem Lịch Sử Đơn Hàng
            </a>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary btn-lg px-4">
                <i class="fa-solid fa-cart-shopping me-2"></i> Tiếp Tục Mua Sắm
            </a>
        </div>
    </div>
</body>
</html>
