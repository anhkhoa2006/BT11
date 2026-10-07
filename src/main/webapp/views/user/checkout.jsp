<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh Toán Đơn Hàng (COD) - Mua Sắm</title>
    <style>
        .checkout-box {
            background-color: #fff;
            border-radius: 12px;
        }
        .cod-option-card {
            border: 2px solid #0d6efd;
            background-color: #f0f7ff;
            border-radius: 8px;
            padding: 15px;
        }
        .mini-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 6px;
        }
    </style>
</head>
<body>
    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary btn-sm">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại Giỏ Hàng
        </a>
    </div>

    <!-- ERROR MESSAGE -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-circle-exclamation me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row g-4">
        <!-- FORM THÔNG TIN GIAO HÀNG & PHƯƠNG THỨC COD -->
        <div class="col-lg-7">
            <div class="card checkout-box shadow-sm border-0 p-4">
                <h4 class="fw-bold text-dark border-bottom pb-3 mb-4">
                    <i class="fa-solid fa-truck-ramp-box me-2 text-primary"></i>Thông Tin Giao Hàng & Thanh Toán
                </h4>

                <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">
                    <!-- HỌ TÊN -->
                    <div class="mb-3">
                        <label for="fullname" class="form-label fw-bold">Họ và tên người nhận <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="fullname" name="fullname" 
                               value="${fullname != null ? fullname : sessionScope.account.fullname}" 
                               placeholder="Ví dụ: Nguyễn Văn A" required>
                    </div>

                    <!-- SỐ ĐIỆN THOẠI -->
                    <div class="mb-3">
                        <label for="phone" class="form-label fw-bold">Số điện thoại nhận hàng <span class="text-danger">*</span></label>
                        <input type="tel" class="form-control" id="phone" name="phone" 
                               value="${phone != null ? phone : sessionScope.account.phone}" 
                               placeholder="Ví dụ: 0912345678" required>
                    </div>

                    <!-- ĐỊA CHỈ NHẬN HÀNG -->
                    <div class="mb-3">
                        <label for="address" class="form-label fw-bold">Địa chỉ nhận hàng chi tiết <span class="text-danger">*</span></label>
                        <textarea class="form-control" id="address" name="address" rows="3" 
                                  placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố..." required>${address}</textarea>
                    </div>

                    <!-- GHI CHÚ ĐƠN HÀNG -->
                    <div class="mb-4">
                        <label for="note" class="form-label fw-bold">Ghi chú giao hàng (nếu có)</label>
                        <textarea class="form-control" id="note" name="note" rows="2" 
                                  placeholder="Ví dụ: Giao hàng vào giờ hành chính, gọi trước khi đến...">${note}</textarea>
                    </div>

                    <!-- PHƯƠNG THỨC THANH TOÁN (COD) -->
                    <div class="mb-4">
                        <label class="form-label fw-bold text-dark"><i class="fa-solid fa-money-bill-wave text-success me-1"></i> Phương thức thanh toán:</label>
                        <div class="cod-option-card">
                            <div class="form-check d-flex align-items-center">
                                <input class="form-check-input me-3" type="radio" name="paymentMethod" id="codPayment" value="COD" checked>
                                <label class="form-check-label w-100" for="codPayment">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <strong class="text-primary fs-5">Thanh toán khi nhận hàng (COD)</strong>
                                            <p class="text-muted small mb-0 mt-1">Quý khách sẽ thanh toán tiền mặt trực tiếp cho nhân viên giao hàng khi nhận được kiện hàng.</p>
                                        </div>
                                        <span class="badge bg-success fs-6"><i class="fa-solid fa-hand-holding-dollar me-1"></i> Tiền mặt</span>
                                    </div>
                                </label>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-success btn-lg w-100 fw-bold shadow-sm py-3">
                        <i class="fa-solid fa-check-circle me-2"></i> Xác Nhận Đặt Hàng (COD)
                    </button>
                </form>
            </div>
        </div>

        <!-- TÓM TẮT ĐƠN HÀNG -->
        <div class="col-lg-5">
            <div class="card checkout-box shadow-sm border-0 p-4">
                <h5 class="fw-bold text-dark border-bottom pb-3 mb-3">
                    <i class="fa-solid fa-cart-arrow-down me-2 text-primary"></i>Kiện Hàng Của Bạn (${cart.totalQuantity} món)
                </h5>

                <div class="checkout-items mb-3" style="max-height: 320px; overflow-y: auto;">
                    <c:forEach items="${cart.items}" var="item">
                        <div class="d-flex align-items-center justify-content-between py-2 border-bottom">
                            <div class="d-flex align-items-center">
                                <c:choose>
                                    <c:when test="${not empty item.product.images}">
                                        <img src="${item.product.images}" class="mini-img me-2" alt="${item.product.productName}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="mini-img me-2 bg-light d-flex align-items-center justify-content-center">
                                            <i class="fa-solid fa-box text-muted"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div>
                                    <h6 class="mb-0 text-truncate" style="max-width: 170px;">${item.product.productName}</h6>
                                    <small class="text-muted">SL: <strong>x${item.quantity}</strong></small>
                                </div>
                            </div>
                            <span class="fw-bold text-dark">
                                <fmt:formatNumber value="${item.totalPrice}" pattern="#,###"/> đ
                            </span>
                        </div>
                    </c:forEach>
                </div>

                <div class="d-flex justify-content-between mb-2">
                    <span class="text-secondary">Tạm tính:</span>
                    <span class="fw-bold text-dark"><fmt:formatNumber value="${cart.totalAmount}" pattern="#,###"/> đ</span>
                </div>

                <div class="d-flex justify-content-between mb-2">
                    <span class="text-secondary">Phí vận chuyển COD:</span>
                    <span class="text-success fw-bold">0 đ (Miễn phí)</span>
                </div>

                <hr class="my-2">

                <div class="d-flex justify-content-between align-items-center pt-2">
                    <span class="fs-5 fw-bold text-dark">Tổng cộng:</span>
                    <span class="fs-4 fw-bold text-danger">
                        <fmt:formatNumber value="${cart.totalAmount}" pattern="#,###"/> đ
                    </span>
                </div>

                <div class="alert alert-info mt-4 mb-0 py-2">
                    <small><i class="fa-solid fa-circle-info me-1"></i>Đơn hàng sẽ được tạo với trạng thái ban đầu là <strong>Đơn hàng mới</strong>.</small>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
