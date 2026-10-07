<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản Lý Videos (CRUD) - Phân Trang 6 Video/Trang</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="text-primary mb-0"><i class="fa-solid fa-video me-2"></i>QUẢN LÝ DỮ LIỆU BẢNG VIDEOS (CRUD)</h4>
        <span class="badge bg-dark fs-6">Phân trang: 6 video / 01 trang</span>
    </div>

    <!-- Thông báo kết quả -->
    <c:if test="${not empty adminMsg}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fa-solid fa-circle-check me-2"></i>${adminMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty adminError}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fa-solid fa-triangle-exclamation me-2"></i>${adminError}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- 1. FORM TẠO MỚI / CẬP NHẬT VIDEO -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-header bg-primary text-white py-2">
            <h6 class="mb-0">
                <i class="fa-solid ${isEdit ? 'fa-pen-to-square' : 'fa-plus-circle'} me-2"></i>
                ${isEdit ? 'Chỉnh Sửa Video [' : 'Thêm Mới Video'} ${isEdit ? video.videoId : ''} ${isEdit ? ']' : ''}
            </h6>
        </div>
        <div class="card-body p-3">
            <form action="${pageContext.request.contextPath}/admin/videos" method="post">
                <input type="hidden" name="action" value="${isEdit ? 'update' : 'create'}">
                
                <div class="row g-3">
                    <!-- VideoId -->
                    <div class="col-md-3">
                        <label class="form-label fw-bold">Mã Video (VideoId) <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="videoId" value="${video.videoId}" 
                               placeholder="VD: VID013" ${isEdit ? 'readonly' : 'required'}>
                    </div>

                    <!-- Title -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Tiêu đề Video (Title) <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="title" value="${video.title}" 
                               placeholder="Nhập tiêu đề video" required>
                    </div>

                    <!-- Category -->
                    <div class="col-md-3">
                        <label class="form-label fw-bold">Chuyên mục (Category)</label>
                        <select class="form-select" name="categoryId" required>
                            <c:forEach items="${categories}" var="cat">
                                <option value="${cat.categoryId}" ${video.category.categoryId == cat.categoryId ? 'selected' : ''}>
                                    ${cat.categoryname}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Poster URL -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Ảnh Poster (URL)</label>
                        <input type="text" class="form-control" name="poster" value="${video.poster}" 
                               placeholder="https://example.com/poster.jpg">
                    </div>

                    <!-- Views -->
                    <div class="col-md-3">
                        <label class="form-label fw-bold">Lượt xem (Views)</label>
                        <input type="number" class="form-control" name="views" value="${video != null ? video.views : 0}">
                    </div>

                    <!-- Active Status -->
                    <div class="col-md-3 d-flex align-items-center mt-4">
                        <div class="form-check form-switch fs-5">
                            <input class="form-check-input" type="checkbox" name="active" id="activeCheck" 
                                   ${video == null || video.active ? 'checked' : ''}>
                            <label class="form-check-label fs-6 fw-bold" for="activeCheck">Kích hoạt (Active)</label>
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="col-12">
                        <label class="form-label fw-bold">Mô tả (Description)</label>
                        <textarea class="form-control" name="description" rows="2" placeholder="Nhập mô tả chi tiết">${video.description}</textarea>
                    </div>
                </div>

                <!-- Action buttons -->
                <div class="mt-3">
                    <c:choose>
                        <c:when test="${isEdit}">
                            <button type="submit" class="btn btn-warning me-2">
                                <i class="fa-solid fa-floppy-disk me-1"></i> Lưu Cập Nhật
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/videos" class="btn btn-secondary">
                                <i class="fa-solid fa-xmark me-1"></i> Hủy Bỏ
                            </a>
                        </c:when>
                        <c:otherwise>
                            <button type="submit" class="btn btn-success me-2">
                                <i class="fa-solid fa-plus me-1"></i> Thêm Mới Video
                            </button>
                            <button type="reset" class="btn btn-outline-secondary">
                                <i class="fa-solid fa-rotate-left me-1"></i> Làm Mới Form
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </form>
        </div>
    </div>

    <!-- 2. BẢNG DANH SÁCH VIDEOS VỚI PHÂN TRANG 6 VIDEO / TRANG -->
    <div class="card shadow-sm border-0">
        <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center py-2">
            <h6 class="mb-0"><i class="fa-solid fa-list me-2"></i>Danh Sách Videos (Tổng cộng: ${totalVideos} video)</h6>
            <small class="text-light">Hiển thị tối đa 6 video trên mỗi trang</small>
        </div>
        <div class="card-body p-0 table-responsive">
            <table class="table table-hover table-striped align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th style="width: 100px;">Mã Video</th>
                        <th style="width: 100px;">Poster</th>
                        <th>Tiêu đề</th>
                        <th>Chuyên mục</th>
                        <th style="width: 90px;" class="text-center">Lượt xem</th>
                        <th style="width: 110px;" class="text-center">Trạng thái</th>
                        <th style="width: 150px;" class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${videoList}" var="item">
                        <tr>
                            <td><code>${item.videoId}</code></td>
                            <td>
                                <img src="${item.poster}" alt="${item.title}" class="rounded" 
                                     style="width: 70px; height: 45px; object-fit: cover;">
                            </td>
                            <td>
                                <strong class="text-dark">${item.title}</strong>
                                <br><small class="text-muted text-truncate d-inline-block" style="max-width: 350px;">${item.description}</small>
                            </td>
                            <td><span class="badge bg-info text-dark">${item.category.categoryname}</span></td>
                            <td class="text-center"><span class="badge bg-secondary">${item.views}</span></td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${item.active}">
                                        <span class="badge bg-success"><i class="fa-solid fa-check me-1"></i>Hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger"><i class="fa-solid fa-lock me-1"></i>Khóa</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/videos?action=edit&id=${item.videoId}&page=${currentPage}" 
                                   class="btn btn-sm btn-outline-warning me-1" title="Chỉnh sửa">
                                    <i class="fa-solid fa-pen-to-square"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/videos?action=delete&id=${item.videoId}" 
                                   class="btn btn-sm btn-outline-danger" 
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa video [${item.videoId}] không?');" title="Xóa">
                                    <i class="fa-solid fa-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty videoList}">
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">Chưa có dữ liệu video nào!</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- PHÂN TRANG 6 VIDEO / TRANG (CÂU 2) -->
        <c:if test="${totalPages > 1}">
            <div class="card-footer bg-white d-flex justify-content-between align-items-center py-2">
                <span class="small text-muted">Trang <strong>${currentPage}</strong> / ${totalPages}</span>
                <nav aria-label="Page navigation">
                    <ul class="pagination pagination-sm mb-0">
                        <!-- Nút Trang trước << -->
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/videos?page=${currentPage - 1}">&laquo;</a>
                        </li>

                        <!-- Các trang 1 2 3 ... -->
                        <c:forEach begin="1" end="${totalPages}" var="p">
                            <li class="page-item ${currentPage == p ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/videos?page=${p}">${p}</a>
                            </li>
                        </c:forEach>

                        <!-- Nút Trang sau >> -->
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/videos?page=${currentPage + 1}">&raquo;</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </c:if>
    </div>
</body>
</html>
