<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ Hàng Của Bạn - Mua Sắm</title>
    <style>
        .cart-img {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #dee2e6;
        }
        .qty-box {
            width: 130px;
        }
        .table > tbody > tr > td {
            vertical-align: middle;
        }
        .summary-card {
            border-radius: 12px;
            background-color: #fff;
        }
    </style>
</head>
<body>
    <div class="d-flex align-items-center justify-content-between mb-4">
        <h3 class="fw-bold text-dark mb-0">
            <i class="fa-solid fa-cart-shopping text-primary me-2"></i>Giỏ Hàng Của Bạn
        </h3>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary btn-sm">
            <i class="fa-solid fa-arrow-left me-1"></i> Tiếp tục mua hàng
        </a>
    </div>

    <!-- FLASH MESSAGES -->
    <c:if test="${not empty sessionScope.cartSuccess}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-circle-check me-2"></i>${sessionScope.cartSuccess}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="cartSuccess" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.cartWarning}">
        <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-triangle-exclamation me-2"></i>${sessionScope.cartWarning}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="cartWarning" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.cartError}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-circle-xmark me-2"></i>${sessionScope.cartError}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="cartError" scope="session"/>
    </c:if>

    <c:choose>
        <c:when test="${not empty cart and not cart.empty}">
            <div class="row g-4">
                <!-- DANH SÁCH SẢN PHẨM TRONG GIỎ HÀNG -->
                <div class="col-lg-8">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th scope="col" style="width: 45%;">Sản phẩm</th>
                                            <th scope="col" class="text-center" style="width: 18%;">Đơn giá</th>
                                            <th scope="col" class="text-center" style="width: 20%;">Số lượng</th>
                                            <th scope="col" class="text-end" style="width: 12%;">Thành tiền</th>
                                            <th scope="col" class="text-center" style="width: 5%;">Xóa</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${cart.items}" var="item">
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <c:choose>
                                                            <c:when test="${not empty item.product.images}">
                                                                <img src="${item.product.images}" class="cart-img me-3" alt="${item.product.productName}">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="cart-img me-3 bg-light d-flex align-items-center justify-content-center">
                                                                    <i class="fa-solid fa-box text-secondary"></i>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <div>
                                                            <a href="${pageContext.request.contextPath}/product/detail?id=${item.product.productId}" 
                                                               class="text-decoration-none fw-bold text-dark d-block">
                                                                ${item.product.productName}
                                                            </a>
                                                            <small class="text-muted">Kho: <strong>${item.product.quantity}</strong> | Mã: SP-${item.product.productId}</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="text-center fw-bold text-secondary">
                                                    <fmt:formatNumber value="${item.product.price}" pattern="#,###"/> đ
                                                </td>
                                                <td>
                                                    <!-- ĐIỀU CHỈNH SỐ LƯỢNG TRONG GIỚI HẠN TỒN KHO -->
                                                    <form action="${pageContext.request.contextPath}/cart/update" method="post" class="d-flex justify-content-center">
                                                        <input type="hidden" name="productId" value="${item.product.productId}">
                                                        <div class="input-group input-group-sm qty-box">
                                                            <a href="${pageContext.request.contextPath}/cart/update?productId=${item.product.productId}&action=dec" 
                                                               class="btn btn-outline-secondary ${item.quantity <= 1 ? 'disabled' : ''}">-</a>
                                                            <input type="number" name="quantity" class="form-control text-center fw-bold px-1" 
                                                                   value="${item.quantity}" min="1" max="${item.product.quantity}"
                                                                   onchange="this.form.submit()">
                                                            <a href="${pageContext.request.contextPath}/cart/update?productId=${item.product.productId}&action=inc" 
                                                               class="btn btn-outline-secondary ${item.quantity >= item.product.quantity ? 'disabled' : ''}">+</a>
                                                        </div>
                                                    </form>
                                                    <c:if test="${item.quantity >= item.product.quantity}">
                                                        <div class="text-center mt-1">
                                                            <small class="text-danger" style="font-size: 0.75rem;">(Đã đạt tối đa kho)</small>
                                                        </div>
                                                    </c:if>
                                                </td>
                                                <td class="text-end fw-bold text-danger">
                                                    <fmt:formatNumber value="${item.totalPrice}" pattern="#,###"/> đ
                                                </td>
                                                <td class="text-center">
                                                    <a href="${pageContext.request.contextPath}/cart/delete?productId=${item.product.productId}" 
                                                       class="btn btn-outline-danger btn-sm border-0" 
                                                       title="Xóa khỏi giỏ" 
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?');">
                                                        <i class="fa-solid fa-trash-can"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="card-footer bg-white d-flex justify-content-between p-3">
                            <a href="${pageContext.request.contextPath}/cart/clear" 
                               class="btn btn-outline-danger btn-sm" 
                               onclick="return confirm('Bạn có chắc chắn muốn xóa toàn bộ giỏ hàng?');">
                                <i class="fa-solid fa-trash me-1"></i> Xóa toàn bộ giỏ
                            </a>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary btn-sm">
                                <i class="fa-solid fa-cart-plus me-1"></i> Chọn thêm sản phẩm khác
                            </a>
                        </div>
                    </div>
                </div>

                <!-- TÓM TẮT ĐƠN HÀNG VÀ THANH TOÁN -->
                <div class="col-lg-4">
                    <div class="card summary-card shadow-sm border-0 p-3">
                        <h5 class="fw-bold text-dark border-bottom pb-3 mb-3">
                            <i class="fa-solid fa-receipt me-2 text-primary"></i>Tóm Tắt Đơn Hàng
                        </h5>

                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-secondary">Tổng số lượng sản phẩm:</span>
                            <span class="fw-bold text-dark">${cart.totalQuantity} món</span>
                        </div>

                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-secondary">Tạm tính:</span>
                            <span class="fw-bold text-dark"><fmt:formatNumber value="${cart.totalAmount}" pattern="#,###"/> đ</span>
                        </div>

                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-secondary">Phí vận chuyển:</span>
                            <span class="text-success fw-bold">Miễn phí (COD)</span>
                        </div>

                        <hr class="my-2">

                        <div class="d-flex justify-content-between align-items-center mb-4 pt-2">
                            <span class="fs-5 fw-bold text-dark">Tổng thanh toán:</span>
                            <span class="fs-4 fw-bold text-danger">
                                <fmt:formatNumber value="${cart.totalAmount}" pattern="#,###"/> đ
                            </span>
                        </div>

                        <a href="${pageContext.request.contextPath}/checkout" class="btn btn-success btn-lg w-100 fw-bold shadow-sm">
                            <i class="fa-solid fa-money-bill-wave me-2"></i> Tiến Hành Đặt Hàng (COD)
                        </a>

                        <div class="text-center mt-3">
                            <small class="text-muted"><i class="fa-solid fa-shield-halved me-1 text-success"></i>Thanh toán khi nhận hàng an toàn & tiện lợi</small>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <!-- GIỎ HÀNG TRỐNG -->
            <div class="card border-0 shadow-sm p-5 text-center my-4">
                <div class="py-4">
                    <i class="fa-solid fa-cart-shopping fa-5x text-muted mb-3 opacity-50"></i>
                    <h4 class="fw-bold text-secondary">Giỏ hàng của bạn đang trống!</h4>
                    <p class="text-muted mb-4">Hãy dạo qua cửa hàng để chọn cho mình những sản phẩm tuyệt vời nhé.</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary btn-lg px-4 fw-bold shadow-sm">
                        <i class="fa-solid fa-bag-shopping me-2"></i> Khám Phá Sản Phẩm Ngay
                    </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</body>
</html>
