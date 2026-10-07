<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch Sử Đặt Hàng - Mua Sắm Online</title>
    <style>
        .status-tab {
            font-size: 0.95rem;
            font-weight: 600;
            padding: 10px 16px;
            border-radius: 8px;
            text-decoration: none;
            color: #495057;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            white-space: nowrap;
            transition: all 0.2s;
        }
        .status-tab:hover {
            background-color: #e2e6ea;
            color: #0d6efd;
        }
        .status-tab.active {
            background-color: #0d6efd;
            color: #fff;
            border-color: #0d6efd;
        }
        .status-tab.active .badge {
            background-color: #fff !important;
            color: #0d6efd !important;
        }
        .order-card {
            border-radius: 10px;
            background: #fff;
            border: 1px solid #e3e6e8;
            margin-bottom: 24px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        .order-card-header {
            background-color: #fcfcfd;
            border-bottom: 1px solid #eef0f2;
            padding: 14px 20px;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        .order-item-img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
            border: 1px solid #dee2e6;
        }
    </style>
</head>
<body>
    <!-- TIÊU ĐỀ TRANG -->
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-1">
                <i class="fa-solid fa-clock-rotate-left text-primary me-2"></i>Lịch Sử Đặt Hàng
            </h3>
            <p class="text-muted mb-0">Theo dõi trạng thái đơn hàng từ lúc đặt đến khi giao nhận thành công.</p>
        </div>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary btn-sm">
            <i class="fa-solid fa-cart-shopping me-1"></i> Mua sắm thêm
        </a>
    </div>

    <!-- FLASH MESSAGES -->
    <c:if test="${not empty sessionScope.orderSuccess}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-circle-check me-2"></i>${sessionScope.orderSuccess}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="orderSuccess" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.orderError}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-circle-xmark me-2"></i>${sessionScope.orderError}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="orderError" scope="session"/>
    </c:if>

    <!-- BỘ LỌC 8 TRẠNG THÁI THEO YÊU CẦU ĐỀ BÀI -->
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-body p-3">
            <div class="fw-bold text-secondary mb-2">
                <i class="fa-solid fa-filter me-1"></i> Lọc theo trạng thái đơn hàng:
            </div>
            <div class="d-flex flex-wrap gap-2">
                <!-- 1. TẤT CẢ -->
                <a href="${pageContext.request.contextPath}/my-orders?status=ALL" 
                   class="status-tab ${currentStatus == 'ALL' ? 'active' : ''}">
                    <i class="fa-solid fa-list-check"></i> Tất cả
                    <span class="badge bg-secondary">${statusCounts['ALL']}</span>
                </a>

                <!-- 2. ĐƠN HÀNG MỚI -->
                <a href="${pageContext.request.contextPath}/my-orders?status=NEW" 
                   class="status-tab ${currentStatus == 'NEW' ? 'active' : ''}">
                    <i class="fa-solid fa-sparkles text-primary"></i> Đơn hàng mới
                    <span class="badge bg-primary">${statusCounts['NEW']}</span>
                </a>

                <!-- 3. ĐÃ XÁC NHẬN -->
                <a href="${pageContext.request.contextPath}/my-orders?status=CONFIRMED" 
                   class="status-tab ${currentStatus == 'CONFIRMED' ? 'active' : ''}">
                    <i class="fa-solid fa-circle-check text-info"></i> Đã xác nhận
                    <span class="badge bg-info text-dark">${statusCounts['CONFIRMED']}</span>
                </a>

                <!-- 4. CHUẨN BỊ HÀNG -->
                <a href="${pageContext.request.contextPath}/my-orders?status=PREPARING" 
                   class="status-tab ${currentStatus == 'PREPARING' ? 'active' : ''}">
                    <i class="fa-solid fa-box-archive text-warning"></i> Chuẩn bị hàng
                    <span class="badge bg-warning text-dark">${statusCounts['PREPARING']}</span>
                </a>

                <!-- 5. VẬN CHUYỂN -->
                <a href="${pageContext.request.contextPath}/my-orders?status=SHIPPING" 
                   class="status-tab ${currentStatus == 'SHIPPING' ? 'active' : ''}">
                    <i class="fa-solid fa-truck-fast text-secondary"></i> Vận chuyển
                    <span class="badge bg-secondary">${statusCounts['SHIPPING']}</span>
                </a>

                <!-- 6. GIAO HÀNG -->
                <a href="${pageContext.request.contextPath}/my-orders?status=DELIVERING" 
                   class="status-tab ${currentStatus == 'DELIVERING' ? 'active' : ''}">
                    <i class="fa-solid fa-motorcycle text-primary"></i> Giao hàng
                    <span class="badge bg-primary">${statusCounts['DELIVERING']}</span>
                </a>

                <!-- 7. ĐÃ GIAO -->
                <a href="${pageContext.request.contextPath}/my-orders?status=DELIVERED" 
                   class="status-tab ${currentStatus == 'DELIVERED' ? 'active' : ''}">
                    <i class="fa-solid fa-clipboard-check text-success"></i> Đã giao
                    <span class="badge bg-success">${statusCounts['DELIVERED']}</span>
                </a>

                <!-- 8. ĐƠN HÀNG HỦY -->
                <a href="${pageContext.request.contextPath}/my-orders?status=CANCELLED" 
                   class="status-tab ${currentStatus == 'CANCELLED' ? 'active' : ''}">
                    <i class="fa-solid fa-ban text-danger"></i> Đơn hàng hủy
                    <span class="badge bg-danger">${statusCounts['CANCELLED']}</span>
                </a>

                <!-- 9. ĐƠN HÀNG HOÀN -->
                <a href="${pageContext.request.contextPath}/my-orders?status=RETURNED" 
                   class="status-tab ${currentStatus == 'RETURNED' ? 'active' : ''}">
                    <i class="fa-solid fa-rotate-left text-dark"></i> Đơn hàng hoàn
                    <span class="badge bg-dark">${statusCounts['RETURNED']}</span>
                </a>
            </div>
        </div>
    </div>

    <!-- DANH SÁCH CÁC ĐƠN HÀNG -->
    <c:choose>
        <c:when test="${not empty orders}">
            <c:forEach items="${orders}" var="ord">
                <div class="order-card">
                    <!-- HEADER ĐƠN HÀNG -->
                    <div class="order-card-header d-flex justify-content-between align-items-center flex-wrap gap-2">
                        <div class="d-flex align-items-center gap-3">
                            <span class="fw-bold fs-5 text-dark">Mã đơn: <span class="text-primary">#${ord.orderId}</span></span>
                            <span class="text-muted small">
                                <i class="fa-regular fa-calendar-days me-1"></i><fmt:formatDate value="${ord.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </span>
                            <span class="badge bg-light text-dark border">
                                <i class="fa-solid fa-money-bill-wave text-success me-1"></i>${ord.paymentMethod}
                            </span>
                        </div>
                        <div>
                            <span class="badge ${ord.statusBadgeClass} fs-6 px-3 py-2">
                                ${ord.statusText}
                            </span>
                        </div>
                    </div>

                    <!-- BODY ĐƠN HÀNG: CÁC SẢN PHẨM -->
                    <div class="p-3">
                        <c:forEach items="${ord.orderItems}" var="item">
                            <div class="d-flex align-items-center justify-content-between py-2 border-bottom">
                                <div class="d-flex align-items-center">
                                    <c:choose>
                                        <c:when test="${not empty item.product.images}">
                                            <img src="${item.product.images}" class="order-item-img me-3" alt="${item.product.productName}">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="order-item-img me-3 bg-light d-flex align-items-center justify-content-center">
                                                <i class="fa-solid fa-box text-secondary"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div>
                                        <h6 class="mb-0 fw-bold text-dark">${item.product.productName}</h6>
                                        <small class="text-muted">Đơn giá: <fmt:formatNumber value="${item.price}" pattern="#,###"/> đ x <strong>${item.quantity}</strong></small>
                                    </div>
                                </div>
                                <div class="text-end">
                                    <span class="fw-bold text-dark"><fmt:formatNumber value="${item.amount}" pattern="#,###"/> đ</span>
                                </div>
                            </div>
                        </c:forEach>

                        <!-- THÔNG TIN GIAO HÀNG & TỔNG TIỀN -->
                        <div class="row align-items-center mt-3 pt-2">
                            <div class="col-md-7 text-muted small">
                                <div><i class="fa-solid fa-user me-1 text-secondary"></i> Người nhận: <strong>${ord.fullname}</strong> (${ord.phone})</div>
                                <div><i class="fa-solid fa-location-dot me-1 text-secondary"></i> Giao tới: ${ord.address}</div>
                                <c:if test="${not empty ord.note}">
                                    <div><i class="fa-solid fa-note-sticky me-1 text-secondary"></i> Ghi chú: <em>${ord.note}</em></div>
                                </c:if>
                            </div>
                            <div class="col-md-5 text-md-end mt-2 mt-md-0">
                                <span class="text-secondary me-2">Tổng tiền:</span>
                                <span class="fs-4 fw-bold text-danger">
                                    <fmt:formatNumber value="${ord.totalAmount}" pattern="#,###"/> đ
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- FOOTER ĐƠN HÀNG: CÁC NÚT THAO TÁC -->
                    <div class="card-footer bg-white d-flex justify-content-end align-items-center gap-2 p-3">
                        <a href="${pageContext.request.contextPath}/order/detail?id=${ord.orderId}" class="btn btn-outline-secondary btn-sm">
                            <i class="fa-solid fa-eye me-1"></i> Chi tiết đơn hàng
                        </a>

                        <c:if test="${ord.cancellable}">
                            <a href="${pageContext.request.contextPath}/order/cancel?id=${ord.orderId}" 
                               class="btn btn-outline-danger btn-sm"
                               onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #${ord.orderId}?');">
                                <i class="fa-solid fa-xmark me-1"></i> Hủy đơn hàng
                            </a>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <!-- KHÔNG CÓ ĐƠN HÀNG -->
            <div class="card border-0 shadow-sm p-5 text-center my-4">
                <div class="py-4">
                    <i class="fa-solid fa-file-invoice fa-4x text-muted mb-3 opacity-50"></i>
                    <h5 class="fw-bold text-secondary">Không tìm thấy đơn hàng nào</h5>
                    <p class="text-muted">Không có đơn hàng nào trong trạng thái đã chọn.</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary btn-sm px-3">
                        <i class="fa-solid fa-bag-shopping me-1"></i> Khám phá sản phẩm
                    </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- BOX HƯỚNG DẪN TEST THAY ĐỔI TRẠNG THÁI TRONG DATABASE -->
    <div class="card bg-light border-0 shadow-sm p-4 mt-5">
        <h5 class="fw-bold text-dark mb-2">
            <i class="fa-solid fa-database text-info me-2"></i>Hướng dẫn thay đổi trạng thái trong CSDL (Database):
        </h5>
        <p class="text-secondary small mb-2">
            Theo yêu cầu bài tập, bạn có thể chạy câu lệnh SQL trực tiếp trong MySQL Workbench / phpMyAdmin / MySQL CLI để đổi trạng thái đơn hàng và tải lại trang này để quan sát:
        </p>
        <div class="bg-dark text-light p-3 rounded-3 small font-monospace">
            -- Đổi sang Đã xác nhận:<br>
            UPDATE orders SET status = 'CONFIRMED' WHERE order_id = &lt;Mã_đơn&gt;;<br><br>
            -- Đổi sang Chuẩn bị hàng:<br>
            UPDATE orders SET status = 'PREPARING' WHERE order_id = &lt;Mã_đơn&gt;;<br><br>
            -- Đổi sang Vận chuyển:<br>
            UPDATE orders SET status = 'SHIPPING' WHERE order_id = &lt;Mã_đơn&gt;;<br><br>
            -- Đổi sang Giao hàng:<br>
            UPDATE orders SET status = 'DELIVERING' WHERE order_id = &lt;Mã_đơn&gt;;<br><br>
            -- Đổi sang Đã giao:<br>
            UPDATE orders SET status = 'DELIVERED' WHERE order_id = &lt;Mã_đơn&gt;;<br><br>
            -- Đổi sang Đơn hàng hủy:<br>
            UPDATE orders SET status = 'CANCELLED' WHERE order_id = &lt;Mã_đơn&gt;;<br><br>
            -- Đổi sang Đơn hàng hoàn:<br>
            UPDATE orders SET status = 'RETURNED' WHERE order_id = &lt;Mã_đơn&gt;;
        </div>
    </div>
</body>
</html>
