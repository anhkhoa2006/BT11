<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${product.productName} - Chi Tiết Sản Phẩm</title>
    <style>
        .product-box {
            background-color: #fff;
            border-radius: 12px;
            padding: 30px;
        }
        .detail-img-container {
            width: 100%;
            height: 380px;
            border-radius: 8px;
            overflow: hidden;
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #e9ecef;
        }
        .detail-img-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .detail-price {
            font-size: 2rem;
            font-weight: 800;
            color: #dc3545;
        }
        .qty-input-group {
            max-width: 160px;
        }
    </style>
</head>
<body>
    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary btn-sm">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại Cửa hàng
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

    <div class="product-box shadow-sm mb-4">
        <div class="row g-4">
            <!-- CỘT ẢNH -->
            <div class="col-md-5">
                <div class="detail-img-container shadow-sm">
                    <c:choose>
                        <c:when test="${not empty product.images}">
                            <img src="${product.images}" alt="${product.productName}">
                        </c:when>
                        <c:otherwise>
                            <i class="fa-solid fa-box-open fa-5x text-secondary"></i>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- CỘT THÔNG TIN -->
            <div class="col-md-7">
                <c:if test="${not empty product.category}">
                    <span class="badge bg-primary mb-2">${product.category.categoryname}</span>
                </c:if>

                <h3 class="fw-bold text-dark mb-2">${product.productName}</h3>
                <p class="text-muted small mb-3">Mã sản phẩm: <code>SP-${product.productId}</code></p>

                <div class="detail-price mb-3">
                    <fmt:formatNumber value="${product.price}" pattern="#,###"/> đ
                </div>

                <div class="mb-3">
                    <span class="fw-bold me-2">Tình trạng kho:</span>
                    <c:choose>
                        <c:when test="${product.quantity > 0}">
                            <span class="badge bg-success-subtle text-success border border-success px-3 py-2">
                                <i class="fa-solid fa-circle-check me-1"></i> Còn ${product.quantity} sản phẩm trong kho
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-danger-subtle text-danger border border-danger px-3 py-2">
                                <i class="fa-solid fa-circle-xmark me-1"></i> Tạm hết hàng
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <hr class="my-4">

                <!-- FORM THÊM VÀO GIỎ VỚI GIỚI HẠN SỐ LƯỢNG -->
                <c:choose>
                    <c:when test="${product.quantity > 0}">
                        <form action="${pageContext.request.contextPath}/cart/add" method="post" class="mb-4">
                            <input type="hidden" name="productId" value="${product.productId}">
                            <input type="hidden" name="redirect" value="/product/detail?id=${product.productId}">

                            <div class="d-flex align-items-center gap-3 mb-3">
                                <label class="fw-bold text-secondary">Số lượng:</label>
                                <div class="input-group qty-input-group">
                                    <button class="btn btn-outline-secondary" type="button" onclick="adjustQty(-1)">-</button>
                                    <input type="number" id="qtyInput" name="quantity" class="form-control text-center fw-bold" 
                                           value="1" min="1" max="${product.quantity}" onchange="validateQty(this, ${product.quantity})">
                                    <button class="btn btn-outline-secondary" type="button" onclick="adjustQty(1, ${product.quantity})">+</button>
                                </div>
                                <small class="text-muted">(Tối đa ${product.quantity})</small>
                            </div>

                            <div class="d-flex gap-3">
                                <button type="submit" class="btn btn-primary btn-lg px-4 fw-bold">
                                    <i class="fa-solid fa-cart-plus me-2"></i> Thêm vào giỏ hàng
                                </button>
                                <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-primary btn-lg px-3">
                                    <i class="fa-solid fa-cart-shopping me-1"></i> Xem giỏ
                                </a>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-secondary">
                            <i class="fa-solid fa-circle-info me-2"></i>Sản phẩm hiện đang tạm hết hàng, quý khách vui lòng quay lại sau!
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- MÔ TẢ -->
                <div class="mt-4">
                    <h5 class="fw-bold text-dark border-bottom pb-2 mb-2">Mô tả sản phẩm:</h5>
                    <p class="text-secondary" style="white-space: pre-line;">
                        <c:choose>
                            <c:when test="${not empty product.description}">
                                ${product.description}
                            </c:when>
                            <c:otherwise>
                                Thông tin mô tả đang được cập nhật.
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- SẢN PHẨM LIÊN QUAN -->
    <c:if test="${not empty relatedProducts}">
        <div class="card border-0 shadow-sm p-4">
            <h5 class="fw-bold text-dark mb-3"><i class="fa-solid fa-layer-group me-2 text-primary"></i>Sản phẩm cùng danh mục</h5>
            <div class="row row-cols-1 row-cols-md-4 g-3">
                <c:forEach items="${relatedProducts}" var="rp">
                    <c:if test="${rp.productId != product.productId}">
                        <div class="col">
                            <div class="card h-100 border-0 shadow-sm p-2">
                                <a href="${pageContext.request.contextPath}/product/detail?id=${rp.productId}">
                                    <img src="${rp.images}" class="card-img-top rounded" alt="${rp.productName}" style="height: 140px; object-fit: cover;">
                                </a>
                                <div class="card-body p-2">
                                    <h6 class="card-title text-truncate mb-1">
                                        <a href="${pageContext.request.contextPath}/product/detail?id=${rp.productId}" class="text-decoration-none text-dark fw-bold">
                                            ${rp.productName}
                                        </a>
                                    </h6>
                                    <span class="text-danger fw-bold"><fmt:formatNumber value="${rp.price}" pattern="#,###"/> đ</span>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </c:if>

    <script>
        function adjustQty(amount, max) {
            const input = document.getElementById('qtyInput');
            let current = parseInt(input.value) || 1;
            let next = current + amount;
            if (next < 1) next = 1;
            if (max && next > max) next = max;
            input.value = next;
        }

        function validateQty(input, max) {
            let val = parseInt(input.value) || 1;
            if (val < 1) val = 1;
            if (val > max) {
                alert('Số lượng yêu cầu không được vượt quá số lượng tồn kho (' + max + ')!');
                val = max;
            }
            input.value = val;
        }
    </script>
</body>
</html>
