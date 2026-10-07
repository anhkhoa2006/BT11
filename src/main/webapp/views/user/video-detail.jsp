<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${video.title} - Chi Tiết Video (Câu 3)</title>
    <style>
        .video-detail-box {
            background-color: #fff;
            border: 2px solid #333;
            border-radius: 4px;
            padding: 20px;
            max-width: 900px;
            margin: 0 auto;
        }
        .poster-container {
            width: 100%;
            max-width: 380px;
            height: 250px;
            background-color: #000;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #ccc;
            overflow: hidden;
        }
        .poster-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .info-container {
            font-size: 1.1rem;
            line-height: 1.9;
        }
        .info-container strong {
            color: #212529;
            min-width: 140px;
            display: inline-block;
        }
        .desc-box {
            margin-top: 20px;
            padding-top: 15px;
            border-top: 2px solid #333;
            font-size: 1.05rem;
            line-height: 1.7;
            color: #333;
        }
        .badge-stat {
            font-size: 1rem;
            padding: 6px 14px;
            border-radius: 20px;
        }
    </style>
</head>
<body>
    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-sm">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại Trang Chủ
        </a>
    </div>

    <!-- KHUNG CHI TIẾT VIDEO THEO ĐÚNG MẪU ĐỀ BÀI (CÂU 3) -->
    <div class="video-detail-box shadow">
        <div class="row align-items-center">
            <!-- CỘT BÊN TRÁI: [POSTER] -->
            <div class="col-md-5 mb-3 mb-md-0">
                <div class="poster-container shadow-sm">
                    <c:choose>
                        <c:when test="${not empty video.poster}">
                            <img src="${video.poster}" alt="${video.title}">
                        </c:when>
                        <c:otherwise>
                            <span class="text-white fw-bold fs-5">[poster]</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- CỘT BÊN PHẢI: THÔNG TIN CHI TIẾT -->
            <div class="col-md-7">
                <div class="info-container ps-md-3">
                    <div>
                        <strong>Tiêu đề:</strong> 
                        <span class="text-primary fw-bold">${video.title}</span>
                    </div>
                    <div>
                        <strong>Mã video:</strong> 
                        <code>${video.videoId}</code>
                    </div>
                    <div>
                        <strong>Category name:</strong> 
                        <span class="badge bg-secondary">${video.category.categoryname}</span>
                    </div>
                    <div>
                        <strong>View:</strong> 
                        <span class="text-success fw-bold">${video.views}</span>
                    </div>
                    <div class="mt-2 d-flex align-items-center gap-3">
                        <form action="${pageContext.request.contextPath}/video/detail" method="post" class="d-inline">
                            <input type="hidden" name="action" value="share">
                            <input type="hidden" name="videoId" value="${video.videoId}">
                            <button type="submit" class="btn btn-outline-primary btn-sm badge-stat">
                                <i class="fa-solid fa-share-nodes me-1"></i> Share(${video.shareCount})
                            </button>
                        </form>

                        <form action="${pageContext.request.contextPath}/video/detail" method="post" class="d-inline">
                            <input type="hidden" name="action" value="like">
                            <input type="hidden" name="videoId" value="${video.videoId}">
                            <button type="submit" class="btn btn-outline-danger btn-sm badge-stat">
                                <i class="fa-solid fa-heart me-1"></i> Like(${video.likeCount})
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- PHẦN DƯỚI: DESCRIPTION THEO ĐÚNG MẪU ĐỀ BÀI -->
        <div class="desc-box">
            <h6 class="fw-bold text-uppercase text-muted mb-2">Description / Mô tả chi tiết:</h6>
            <p class="mb-0">
                <c:choose>
                    <c:when test="${not empty video.description}">
                        ${video.description}
                    </c:when>
                    <c:otherwise>
                        Chưa có mô tả cho video này.
                    </c:otherwise>
                </c:choose>
            </p>
        </div>
    </div>
</body>
</html>
