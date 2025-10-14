<%@page import="java.util.*, model.Disease"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    List<Disease> list = (List<Disease>) request.getAttribute("list");
    String keyword = (String) request.getAttribute("keyword");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Tên Bệnh</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        :root {
            --bg: #eaf4f3;
            --card-radius: 12px;
            --shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        body {
            background-color: var(--bg) !important;
            font-family: Arial, sans-serif;
            padding-top: 60px;
        }
        .content {
            margin-left: 230px;
            /*margin-top: 20px;*/
            padding: 20px;
        }
        .card {
            border-radius: var(--card-radius);
            box-shadow: var(--shadow);
            border: 0;
        }
        /* ==== BẢNG CHUẨN HÓA DÙNG CHUNG ==== */
        .table-wrap {
            max-height: 520px;
            overflow: auto;
            border-radius: 8px;
        }
        .table thead th {
            position: sticky;
            top: 0;
            background: #f1f3f5;
            z-index: 2;
        }
        .table td, .table th {
            vertical-align: middle;
            text-align: center;
        }
        .action-buttons {
            display: inline-flex;
            gap: 8px;
            justify-content: center;
        }
        .toolbar .form-control {
            min-width: 280px;
        }
        .toolbar .btn {
            white-space: nowrap;
        }
        /* Giữ hàng gọn gàng khi mô tả dài */
        .cell-text {
            max-width: 520px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        /* Mobile tweak */
        @media (max-width: 768px) {
            .content { margin-left: 0; }
            .toolbar .form-control { min-width: 180px; }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/Include/header.jsp" />
    <jsp:include page="/WEB-INF/Include/sidebar.jsp" />

    <div class="content">
        <div class="card">
             <div class="card-header fw-bold d-flex justify-content-between align-items-center">
                Quản lý tên Bệnh
            </div>
            <div class="card-body">
                <!-- Thanh công cụ tìm kiếm + nút -->
                <form class="toolbar d-flex align-items-center gap-2 mb-3" action="manageDisease" method="get">
                    <input type="text" name="keyword" class="form-control"
                           placeholder="Tìm kiếm tên bệnh..."
                           value="<%= (keyword != null) ? keyword : "" %>">
                    <button type="submit" class="btn btn-outline-primary">🔍 Tìm</button>
                    <a href="manageDisease" class="btn btn-outline-secondary">✖ Reset</a>
                    <button type="button" class="btn btn-success" onclick="openAddModal()">➕ Thêm</button>
                </form>

                <!-- Bảng danh sách (đã chuẩn hoá) -->
<div class="table-responsive">
    <table class="table table-bordered table-hover mb-0">
        <thead class="table-secondary">
            <tr>
                <th style="width: 110px;">ID</th>
                <th style="width: 260px;">Tên bệnh</th>
                <th>Mô tả</th>
                <th style="width: 160px;">Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <% if (list != null && !list.isEmpty()) {
                for (Disease d : list) {
                    String nameEscaped = d.getDiseaseName() != null ? d.getDiseaseName().replace("'", "\\'") : "";
                    String descEscaped = (d.getDescription() != null) ? d.getDescription().replace("'", "\\'") : "";
            %>
            <tr>
                <td><%= d.getDiseaseId() %></td>
                <td class="cell-text" title="<%= d.getDiseaseName() %>"><%= d.getDiseaseName() %></td>
                <td class="cell-text" title="<%= d.getDescription() != null ? d.getDescription() : "" %>">
                    <%= d.getDescription() != null ? d.getDescription() : "" %>
                </td>
                <td>
                    <div class="action-buttons">
                        <button type="button" class="btn btn-warning btn-sm"
                                onclick="openEditModal('<%= d.getDiseaseId() %>', '<%= nameEscaped %>', '<%= descEscaped %>')">
                            ✏️ Sửa
                        </button>
                        <a href="manageDisease?action=delete&diseaseId=<%= d.getDiseaseId() %>"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Bạn có chắc muốn xóa bệnh này?');">
                            🗑 Xóa
                        </a>
                    </div>
                </td>
            </tr>
            <% }
            } else { %>
            <tr>
                <td colspan="4" class="text-center text-muted">Không có dữ liệu</td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

            </div>
        </div>
    </div>

    <!-- Modal Thêm / Sửa -->
    <div class="modal fade" id="diseaseModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="manageDisease" method="post" id="diseaseForm">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title" id="modalTitle">Thêm tên bệnh</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="action" id="action" value="add">
                        <input type="hidden" name="diseaseId" id="diseaseId">

                        <div class="mb-3">
                            <label class="form-label">Tên bệnh</label>
                            <input type="text" name="diseaseName" id="diseaseName" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea name="description" id="description" class="form-control" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-success">Lưu</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const diseaseModal = new bootstrap.Modal(document.getElementById('diseaseModal'));

        function openAddModal() {
            document.getElementById('modalTitle').innerText = "➕ Thêm tên bệnh";
            document.getElementById('action').value = "add";
            document.getElementById('diseaseForm').reset();
            document.getElementById('diseaseId').value = "";
            diseaseModal.show();
        }

        function openEditModal(id, name, desc) {
            document.getElementById('modalTitle').innerText = "✏️ Cập nhật bệnh";
            document.getElementById('action').value = "update";
            document.getElementById('diseaseId').value = id;
            document.getElementById('diseaseName').value = name;
            document.getElementById('description').value = desc;
            diseaseModal.show();
        }
    </script>
</body>
</html>
