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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        :root {
            --bg: #f5f9f8;
            --card-radius: 14px;
            --shadow: 0 4px 15px rgba(0,0,0,0.08);
        }
        body {
            background-color: var(--bg) !important;
            font-family: "Segoe UI", Arial, sans-serif;
            padding-top: 60px;
        }
        .content {
            margin-left: 230px;
            padding: 20px;
            animation: fadeIn 0.4s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .card {
            border-radius: var(--card-radius);
            box-shadow: var(--shadow);
            border: 0;
            background: #fff;
        }
        .card-header {
            background: #fff;
            color: #222;
            font-weight: 600;
            font-size: 1.1rem;
            padding: 12px 16px;
            border-bottom: 1px solid #eee;
        }
        /* Table */
        .table thead th {
            background: #f8f9fa;
            font-weight: 600;
            font-size: 0.95rem;
        }
        .table td, .table th {
            vertical-align: middle;
            text-align: center;
            font-size: 0.95rem;
            transition: background-color 0.25s ease;
        }
        .table-hover tbody tr:hover {
            background-color: #eef6ff;
        }
        .cell-text {
            max-width: 520px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        /* Toolbar nhỏ, nút nhỏ */
        .toolbar .form-control {
            min-width: 250px;
            border-radius: 30px;
            padding-left: 15px;
            font-size: 0.9rem;
            height: 36px;
            transition: box-shadow 0.2s ease;
        }
        .toolbar .form-control:focus {
            box-shadow: 0 0 0 0.2rem rgba(13,110,253,.25);
        }
        .toolbar .btn {
            border-radius: 20px;
            padding: 4px 10px;
            font-size: 0.85rem;
            display: inline-flex;
            align-items: center;
            gap: 4px;
            transition: transform 0.2s ease, background-color 0.2s ease;
        }
        .toolbar .btn:hover { transform: translateY(-1px); }
        .action-buttons .btn {
            padding: 2px 8px;
            font-size: 0.8rem;
        }
        /* Modal animation (zoom nhẹ) */
        .modal.fade .modal-dialog {
            transform: scale(0.9);
            opacity: 0;
            transition: all 0.25s ease;
        }
        .modal.fade.show .modal-dialog {
            transform: scale(1);
            opacity: 1;
        }
        .modal-content {
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .modal-header {
            background: #fff;
            border-bottom: 1px solid #eee;
            color: #222;
            font-weight: 600;
        }
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
            <div class="card-header">
                Quản lý tên Bệnh
            </div>
            <div class="card-body">
                <!-- Toolbar: tìm kiếm + nút nhỏ -->
                <form class="toolbar d-flex align-items-center gap-2 mb-3" action="manageDisease" method="get">
                    <input type="text" name="keyword" class="form-control"
                           placeholder="🔍 Tìm kiếm tên bệnh..."
                           value="<%= (keyword != null) ? keyword : "" %>">
                    <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i></button>
                    <a href="manageDisease" class="btn btn-outline-secondary"><i class="bi bi-x-lg"></i></a>
                    <button type="button" class="btn btn-success" onclick="openAddModal()"><i class="bi bi-plus-lg"></i></button>
                </form>

                <!-- Bảng danh sách -->
                <div class="table-responsive">
                    <table class="table table-bordered table-hover mb-0">
                        <thead class="table-secondary">
                            <tr>
                                <th style="width: 110px;">ID</th>
                                <th style="width: 260px;">Tên bệnh</th>
                                <th>Mô tả</th>
                                <th style="width: 140px;">Thao tác</th>
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
                                            ✏️
                                        </button>
                                        <a href="manageDisease?action=delete&diseaseId=<%= d.getDiseaseId() %>"
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Bạn có chắc muốn xóa bệnh này?');">
                                            🗑
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        <% } } else { %>
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
                    <div class="modal-header">
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
                        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-success btn-sm">Lưu</button>
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
