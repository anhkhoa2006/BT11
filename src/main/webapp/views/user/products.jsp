<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Sản Phẩm - Mua Sắm Online</title>
    <style>
        .product-card {
            border: 1px solid #dee2e6;
            border-radius: 10px;
            overflow: hidden;
            background: #fff;
            transition: transform 0.2s, box-shadow 0.2s;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.12);
        }
        .product-img-wrapper {
            width: 100%;
            height: 200px;
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }
        .product-img-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .product-badge {
            position: absolute;
            top: 10px;
            right: 10px;
        }
        .product-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: #212529;
            text-decoration: none;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            height: 2.8rem;
        }
        .product-title:hover {
            color: #0d6efd;
        }
        .price-tag {
            font-size: 1.25rem;
            font-weight: 800;
            color: #dc3545;
        }
        .cat-tab {
            padding: 8px 18px;
            border-radius: 20px;
            text-decoration: none;
            font-weight: 600;
            background-color: #e9ecef;
            color: #495057;
            display: inline-block;
            transition: all 0.2s;
        }
        .cat-tab:hover, .cat-tab.active {
            background-color: #0d6efd;
            color: #fff;
        }
    </style>
</head>
<body>
    <!-- THÔNG BÁO FLASH MESSAGE -->
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

    <!-- BANNER TIÊU ĐỀ -->
    <div class="bg-primary text-white p-4 rounded-3 shadow-sm mb-4">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h2 class="fw-bold mb-1"><i class="fa-solid fa-store me-2"></i>Cửa Hàng Sản Phẩm & Khóa Học</h2>
                <p class="mb-0 text-white-50">Chọn lựa sản phẩm yêu thích, thêm vào giỏ hàng và thanh toán COD nhanh chóng!</p>
            </div>
            <div class="col-md-4 text-md-end mt-3 mt-md-0">
                <a href="${pageContext.request.contextPath}/cart" class="btn btn-warning fw-bold">
                    <i class="fa-solid fa-cart-shopping me-1"></i> Xem Giỏ Hàng (${sessionScope.cart != null ? sessionScope.cart.totalQuantity : 0})
                </a>
            </div>
        </div>
    </div>

    <!-- DANH MỤC SẢN PHẨM -->
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-body p-3">
            <span class="fw-bold text-secondary me-2"><i class="fa-solid fa-tags me-1"></i>Danh mục:</span>
            <div class="d-inline-flex flex-wrap gap-2">
                <a href="${pageContext.request.contextPath}/products" class="cat-tab ${selectedCatId == 0 ? 'active' : ''}">
                    Tất cả (${totalProducts})
                </a>
                <c:forEach items="${categories}" var="cat">
                    <a href="${pageContext.request.contextPath}/products?categoryId=${cat.categoryId}" 
                       class="cat-tab ${selectedCatId == cat.categoryId ? 'active' : ''}">
                        ${cat.categoryname}
                    </a>
                </c:forEach>
            </div>
        </div>
    </div>

    <!-- DANH SÁCH SẢN PHẨM -->
    <div class="row row-cols-1 row-cols-md-3 g-4 mb-4">
        <c:choose>
            <c:when test="${not empty products}">
                <c:forEach items="${products}" var="p">
                    <div class="col">
                        <div class="product-card shadow-sm">
                            <div class="product-img-wrapper">
                                <c:choose>
                                    <c:when test="${not empty p.images}">
                                        <img src="${p.images}" alt="${p.productName}">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa-solid fa-box-open fa-3x text-secondary"></i>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${p.quantity > 0}">
                                        <span class="badge bg-success product-badge shadow-sm">Còn ${p.quantity} SP</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger product-badge shadow-sm">Hết hàng</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="card-body p-3 d-flex flex-column">
                                <c:if test="${not empty p.category}">
                                    <span class="badge bg-light text-dark border align-self-start mb-2">${p.category.categoryname}</span>
                                </c:if>

                                <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="product-title mb-2">
                                    ${p.productName}
                                </a>

                                <div class="mt-auto">
                                    <div class="d-flex align-items-baseline justify-content-between mb-3">
                                        <span class="price-tag">
                                            <fmt:formatNumber value="${p.price}" pattern="#,###"/> đ
                                        </span>
                                        <small class="text-muted"><i class="fa-solid fa-boxes-stacked me-1"></i>Kho: <strong>${p.quantity}</strong></small>
                                    </div>

                                    <div class="d-flex gap-2">
                                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-outline-secondary btn-sm flex-fill">
                                            <i class="fa-solid fa-circle-info me-1"></i> Chi tiết
                                        </a>

                                        <c:choose>
                                            <c:when test="${p.quantity > 0}">
                                                <form action="${pageContext.request.contextPath}/cart/add" method="post" class="flex-fill d-inline">
                                                    <input type="hidden" name="productId" value="${p.productId}">
                                                    <input type="hidden" name="quantity" value="1">
                                                    <input type="hidden" name="redirect" value="/products">
                                                    <button type="submit" class="btn btn-primary btn-sm w-100 fw-bold">
                                                        <i class="fa-solid fa-cart-plus me-1"></i> Mua ngay
                                                    </button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-secondary btn-sm flex-fill" disabled>
                                                    <i class="fa-solid fa-ban me-1"></i> Tạm hết
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12 text-center py-5">
                    <i class="fa-solid fa-box-open fa-3x text-muted mb-2"></i>
                    <h5 class="text-muted">Chưa có sản phẩm nào trong danh mục này.</h5>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- PHÂN TRANG -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Product navigation" class="d-flex justify-content-center my-4">
            <ul class="pagination shadow-sm">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/products?categoryId=${selectedCatId}&page=${currentPage - 1}">&laquo;</a>
                </li>
                <c:forEach begin="1" end="${totalPages}" var="p">
                    <li class="page-item ${currentPage == p ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/products?categoryId=${selectedCatId}&page=${p}">${p}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/products?categoryId=${selectedCatId}&page=${currentPage + 1}">&raquo;</a>
                </li>
            </ul>
        </nav>
    </c:if>
</body>
</html>
