<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ - Video Portal (Câu 4 & Câu 5)</title>
    <style>
        .category-tab {
            font-size: 1.1rem;
            font-weight: 600;
            color: #495057;
            padding: 8px 16px;
            border-radius: 20px;
            text-decoration: none;
            background-color: #e9ecef;
            display: inline-block;
            transition: all 0.2s;
        }
        .category-tab:hover {
            background-color: #0d6efd;
            color: #fff;
        }
        .category-tab.active {
            background-color: #0d6efd;
            color: #fff;
        }
        .video-box {
            border: 2px solid #333;
            background-color: #fff;
            padding: 12px;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .video-poster-wrapper {
            width: 100%;
            height: 180px;
            background-color: #000;
            border: 1px solid #999;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 12px;
        }
        .video-poster-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .video-text-line {
            font-size: 0.95rem;
            margin-bottom: 4px;
            color: #212529;
            word-break: break-word;
        }
        .video-text-line strong {
            display: inline-block;
            min-width: 120px;
            color: #000;
        }
        .stat-btn-group {
            margin-top: auto;
            padding-top: 8px;
        }
    </style>
</head>
<body>
    <!-- CHỌN CATEGORY -->
    <div class="card shadow-sm mb-4 border-0">
        <div class="card-body p-3 bg-white">
            <span class="fw-bold me-2 text-secondary"><i class="fa-solid fa-list me-1"></i>Chọn danh mục:</span>
            <div class="d-inline-flex flex-wrap gap-2">
                <c:forEach items="${categories}" var="cat">
                    <a href="${pageContext.request.contextPath}/home?categoryId=${cat.categoryId}" 
                       class="category-tab ${selectedCatId == cat.categoryId ? 'active' : ''}">
                        ${cat.categoryname} (${cat.videoCount})
                    </a>
                </c:forEach>
            </div>
        </div>
    </div>

    <!-- TIÊU ĐỀ CATEGORY THEO MẪU CÂU 4 & CÂU 5: Category Name (20) -->
    <c:forEach items="${categories}" var="cat">
        <c:if test="${selectedCatId == cat.categoryId}">
            <div class="d-flex align-items-center justify-content-between border-bottom pb-2 mb-3">
                <h4 class="fw-bold text-dark mb-0">
                    <i class="fa-solid fa-folder-open text-warning me-2"></i>${cat.categoryname} (${cat.videoCount})
                </h4>
                <span class="badge bg-secondary">Phân trang 3 video / trang</span>
            </div>
        </c:if>
    </c:forEach>

    <!-- DANH SÁCH 3 VIDEO / DÒNG  -->
    <div class="row row-cols-1 row-cols-md-3 g-4 mb-4">
        <c:choose>
            <c:when test="${not empty videos}">
                <c:forEach items="${videos}" var="video">
                    <div class="col">
                        <div class="video-box shadow-sm">
                            <!-- [poster] -->
                            <div class="video-poster-wrapper">
                                <a href="${pageContext.request.contextPath}/video/detail?id=${video.videoId}" class="w-100 h-100">
                                    <c:choose>
                                        <c:when test="${not empty video.poster}">
                                            <img src="${video.poster}" alt="${video.title}">
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-white fw-bold">[poster]</span>
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                            </div>

                            <!-- Tiêu đề: -->
                            <div class="video-text-line">
                                <strong>Tiêu đề:</strong> 
                                <a href="${pageContext.request.contextPath}/video/detail?id=${video.videoId}" 
                                   class="text-decoration-none fw-bold text-primary">
                                    ${video.title}
                                </a>
                            </div>

                            <!-- Mã video: -->
                            <div class="video-text-line">
                                <strong>Mã video:</strong> <code>${video.videoId}</code>
                            </div>

                            <!-- Category name: -->
                            <div class="video-text-line">
                                <strong>Category name:</strong> <span>${video.category.categoryname}</span>
                            </div>

                            <!-- View: -->
                            <div class="video-text-line">
                                <strong>View:</strong> <span class="fw-bold text-success">${video.views}</span>
                            </div>

                            <!-- Share(10) & Like(10) -->
                            <div class="stat-btn-group d-flex gap-2">
                                <a href="${pageContext.request.contextPath}/video/detail?id=${video.videoId}" class="btn btn-outline-primary btn-sm flex-fill">
                                    <i class="fa-solid fa-share-nodes me-1"></i>Share(${video.shareCount})
                                </a>
                                <a href="${pageContext.request.contextPath}/video/detail?id=${video.videoId}" class="btn btn-outline-danger btn-sm flex-fill">
                                    <i class="fa-solid fa-heart me-1"></i>Like(${video.likeCount})
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12 text-center py-5">
                    <i class="fa-solid fa-film fa-3x text-muted mb-2"></i>
                    <h5 class="text-muted">Không có video nào trong danh mục này!</h5>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- THANH PHÂN TRANG 3 VIDEO / TRANG (CÂU 4): << 1 2 3 4 5 >> -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Page navigation" class="d-flex justify-content-center my-4">
            <ul class="pagination shadow-sm">
                <!-- Nút << -->
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link px-3" href="${pageContext.request.contextPath}/home?categoryId=${selectedCatId}&page=${currentPage - 1}" aria-label="Previous">
                        &laquo;
                    </a>
                </li>

                <!-- Danh sách trang 1 2 3 4 5 ... -->
                <c:forEach begin="1" end="${totalPages}" var="p">
                    <li class="page-item ${currentPage == p ? 'active' : ''}">
                        <a class="page-link px-3" href="${pageContext.request.contextPath}/home?categoryId=${selectedCatId}&page=${p}">${p}</a>
                    </li>
                </c:forEach>

                <!-- Nút >> -->
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link px-3" href="${pageContext.request.contextPath}/home?categoryId=${selectedCatId}&page=${currentPage + 1}" aria-label="Next">
                        &raquo;
                    </a>
                </li>
            </ul>
        </nav>
    </c:if>
</body>
</html>
