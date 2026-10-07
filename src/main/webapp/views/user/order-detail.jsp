<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Đơn Hàng #${order.orderId} - Mua Sắm Online</title>
    <style>
        .order-detail-card {
            border-radius: 12px;
            background-color: #fff;
            padding: 30px;
        }
        .step-progress {
            display: flex;
            justify-content: space-between;
            position: relative;
            margin-bottom: 30px;
        }
        .step-progress::before {
            content: '';
            position: absolute;
            top: 20px;
            left: 5%;
            right: 5%;
            height: 4px;
            background-color: #e9ecef;
            z-index: 1;
        }
        .step-item {
            position: relative;
            z-index: 2;
            text-align: center;
            flex: 1;
        }
        .step-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #e9ecef;
            color: #6c757d;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-bottom: 8px;
            border: 3px solid #fff;
            box-shadow: 0 0 0 2px #dee2e6;
        }
        .step-item.active .step-icon {
            background-color: #0d6efd;
            color: #fff;
            box-shadow: 0 0 0 2px #0d6efd;
        }
        .step-item.completed .step-icon {
            background-color: #198754;
            color: #fff;
            box-shadow: 0 0 0 2px #198754;
        }
        .step-title {
            font-size: 0.85rem;
            font-weight: 600;
            color: #495057;
        }
        .step-item.active .step-title {
            color: #0d6efd;
            font-weight: 700;
        }
        .item-img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
            border: 1px solid #dee2e6;
        }
    </style>
</head>
<body>
    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-outline-secondary btn-sm">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại Lịch Sử Đơn Hàng
        </a>
    </div>

    <div class="order-detail-card shadow-sm mb-4">
        <!-- HEADER -->
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 border-bottom pb-3 mb-4">
            <div>
                <h4 class="fw-bold text-dark mb-1">
                    Đơn Hàng <span class="text-primary">#${order.orderId}</span>
                </h4>
                <span class="text-muted small">
                    <i class="fa-regular fa-calendar-days me-1"></i> Đặt lúc: <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                </span>
            </div>
            <div class="d-flex align-items-center gap-2">
                <span class="badge ${order.statusBadgeClass} fs-6 px-3 py-2">
                    ${order.statusText}
                </span>
                <c:if test="${order.cancellable}">
                    <a href="${pageContext.request.contextPath}/order/cancel?id=${order.orderId}" 
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Bạn có chắc muốn hủy đơn hàng này?');">
                        <i class="fa-solid fa-ban me-1"></i> Hủy đơn
                    </a>
                </c:if>
            </div>
        </div>

        <!-- PROGRESS BAR / STEP TRACKER (Cho các đơn thông thường) -->
        <c:choose>
            <c:when test="${order.status != 'CANCELLED' && order.status != 'RETURNED' && order.status != 'ĐƠN HÀNG HỦY' && order.status != 'ĐƠN HÀNG HOÀN'}">
                <div class="step-progress my-4">
                    <div class="step-item ${order.status == 'NEW' ? 'active' : 'completed'}">
                        <div class="step-icon"><i class="fa-solid fa-file-lines"></i></div>
                        <div class="step-title">1. Đơn mới</div>
                    </div>
                    <div class="step-item ${order.status == 'CONFIRMED' ? 'active' : (order.status != 'NEW' ? 'completed' : '')}">
                        <div class="step-icon"><i class="fa-solid fa-check"></i></div>
                        <div class="step-title">2. Đã xác nhận</div>
                    </div>
                    <div class="step-item ${order.status == 'PREPARING' ? 'active' : (order.status != 'NEW' && order.status != 'CONFIRMED' ? 'completed' : '')}">
                        <div class="step-icon"><i class="fa-solid fa-box-open"></i></div>
                        <div class="step-title">3. Chuẩn bị hàng</div>
                    </div>
                    <div class="step-item ${order.status == 'SHIPPING' ? 'active' : (order.status != 'NEW' && order.status != 'CONFIRMED' && order.status != 'PREPARING' ? 'completed' : '')}">
                        <div class="step-icon"><i class="fa-solid fa-truck"></i></div>
                        <div class="step-title">4. Vận chuyển</div>
                    </div>
                    <div class="step-item ${order.status == 'DELIVERING' ? 'active' : (order.status == 'DELIVERED' ? 'completed' : '')}">
                        <div class="step-icon"><i class="fa-solid fa-person-biking"></i></div>
                        <div class="step-title">5. Giao hàng</div>
                    </div>
                    <div class="step-item ${order.status == 'DELIVERED' ? 'completed active' : ''}">
                        <div class="step-icon"><i class="fa-solid fa-handshake"></i></div>
                        <div class="step-title">6. Đã giao</div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert ${order.status == 'CANCELLED' || order.status == 'ĐƠN HÀNG HỦY' ? 'alert-danger' : 'alert-dark'} my-3">
                    <i class="fa-solid fa-circle-exclamation me-2"></i>
                    Đơn hàng này hiện đang ở trạng thái đặc biệt: <strong>${order.statusText}</strong>.
                </div>
            </c:otherwise>
        </c:choose>

        <!-- THÔNG TIN GIAO HÀNG & PHƯƠNG THỨC -->
        <div class="row g-3 mb-4">
            <div class="col-md-6">
                <div class="card bg-light border-0 p-3 h-100">
                    <h6 class="fw-bold text-dark mb-2"><i class="fa-solid fa-location-dot text-primary me-2"></i>Địa Chỉ Nhận Hàng</h6>
                    <p class="mb-1"><strong>${order.fullname}</strong></p>
                    <p class="mb-1 text-secondary"><i class="fa-solid fa-phone me-1"></i> ${order.phone}</p>
                    <p class="mb-1 text-secondary">${order.address}</p>
                    <c:if test="${not empty order.note}">
                        <p class="mb-0 text-muted small"><i class="fa-solid fa-note-sticky me-1"></i> Ghi chú: ${order.note}</p>
                    </c:if>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card bg-light border-0 p-3 h-100">
                    <h6 class="fw-bold text-dark mb-2"><i class="fa-solid fa-credit-card text-success me-2"></i>Hình Thức Thanh Toán</h6>
                    <p class="mb-1"><span class="badge bg-success fs-6">${order.paymentMethod}</span></p>
                    <p class="mb-1 text-secondary">Thanh toán bằng tiền mặt trực tiếp khi nhận kiện hàng.</p>
                    <p class="mb-0 text-muted small"><i class="fa-solid fa-shield-halved me-1 text-success"></i>Bảo vệ quyền lợi người mua 100%.</p>
                </div>
            </div>
        </div>

        <!-- BẢNG SẢN PHẨM -->
        <h6 class="fw-bold text-dark mb-3"><i class="fa-solid fa-boxes-stacked text-primary me-2"></i>Danh Sách Sản Phẩm</h6>
        <div class="table-responsive mb-4">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th style="width: 50%;">Sản phẩm</th>
                        <th class="text-center" style="width: 15%;">Đơn giá</th>
                        <th class="text-center" style="width: 15%;">Số lượng</th>
                        <th class="text-end" style="width: 20%;">Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${order.orderItems}" var="item">
                        <tr>
                            <td>
                                <div class="d-flex align-items-center">
                                    <c:choose>
                                        <c:when test="${not empty item.product.images}">
                                            <img src="${item.product.images}" class="item-img me-3" alt="${item.product.productName}">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="item-img me-3 bg-light d-flex align-items-center justify-content-center">
                                                <i class="fa-solid fa-box text-muted"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div>
                                        <a href="${pageContext.request.contextPath}/product/detail?id=${item.product.productId}" 
                                           class="text-decoration-none fw-bold text-dark">
                                            ${item.product.productName}
                                        </a>
                                        <small class="text-muted d-block">Mã SP: SP-${item.product.productId}</small>
                                    </div>
                                </div>
                            </td>
                            <td class="text-center"><fmt:formatNumber value="${item.price}" pattern="#,###"/> đ</td>
                            <td class="text-center fw-bold">x${item.quantity}</td>
                            <td class="text-end fw-bold text-dark"><fmt:formatNumber value="${item.amount}" pattern="#,###"/> đ</td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="3" class="text-end fw-bold">Tạm tính:</td>
                        <td class="text-end fw-bold"><fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/> đ</td>
                    </tr>
                    <tr>
                        <td colspan="3" class="text-end fw-bold text-secondary">Phí vận chuyển COD:</td>
                        <td class="text-end text-success fw-bold">0 đ (Miễn phí)</td>
                    </tr>
                    <tr class="table-light">
                        <td colspan="3" class="text-end fs-5 fw-bold text-dark">Tổng tiền thanh toán:</td>
                        <td class="text-end fs-5 fw-bold text-danger"><fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/> đ</td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
</body>
</html>
