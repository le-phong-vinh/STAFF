<%@page import="java.util.*, model.Service"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    List<Service> list = (List<Service>) request.getAttribute("list");
    String keyword = (String) request.getAttribute("keyword");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Dịch Vụ</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        :root {
            --bg: #f5f9f8;
            --primary: #0d6efd;
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
            transition: background-color 0.25s ease;
        }
        .cell-text {
            max-width: 520px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        /* Form toolbar */
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
        .toolbar .btn:hover {
            transform: translateY(-1px);
        }
        .action-buttons .btn {
            padding: 2px 8px;
            font-size: 0.8rem;
        }
        /* Modal animation */
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
        .modal-header .modal-title i {
            margin-right: 6px;
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
                Quản lý Dịch vụ
            </div>
            <div class="card-body">
                <!-- Toolbar -->
                <form class="toolbar d-flex align-items-center gap-2 mb-3" action="manageService" method="get">
                    <input type="text" name="keyword" class="form-control"
                           placeholder="🔍 Tìm kiếm dịch vụ..."
                           value="<%= (keyword != null) ? keyword : "" %>">
                    <button class="btn btn-primary" type="submit"><i class="bi bi-search"></i></button>
                    <a href="manageService" class="btn btn-outline-secondary"><i class="bi bi-x-lg"></i></a>
                    <button type="button" class="btn btn-success" onclick="openAddModal()"><i class="bi bi-plus-lg"></i></button>
                </form>

                <!-- Table -->
                <div class="table-responsive">
                    <table class="table table-bordered table-hover mb-0">
                        <thead>
                            <tr>
                                <th style="width: 100px;">ID</th>
                                <th style="width: 240px;">Tên dịch vụ</th>
                                <th>Mô tả</th>
                                <th style="width: 160px;">Giá (VNĐ)</th>
                                <th style="width: 140px;">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (list != null && !list.isEmpty()) {
                                for (Service s : list) {
                                    String nameEscaped = s.getServiceName() != null ? s.getServiceName().replace("'", "\\'") : "";
                                    String descEscaped = (s.getDescription() != null) ? s.getDescription().replace("'", "\\'") : "";
                            %>
                            <tr>
                                <td><%= s.getServiceId() %></td>
                                <td class="cell-text" title="<%= s.getServiceName() %>"><%= s.getServiceName() %></td>
                                <td class="cell-text" title="<%= s.getDescription() != null ? s.getDescription() : "" %>">
                                    <%= s.getDescription() != null ? s.getDescription() : "" %>
                                </td>
                                <td><%= String.format("%,.0f", s.getPrice()) %></td>
                                <td>
                                    <div class="action-buttons">
                                        <button type="button" class="btn btn-warning btn-sm"
                                                onclick="openEditModal('<%= s.getServiceId() %>', '<%= nameEscaped %>', '<%= descEscaped %>', '<%= s.getPrice() %>')">
                                            ✏️
                                        </button>
                                        <a href="manageService?action=delete&serviceId=<%= s.getServiceId() %>"
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Bạn có chắc muốn xóa dịch vụ này?');">
                                            🗑
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <% }
                            } else { %>
                            <tr>
                                <td colspan="5" class="text-center text-muted">Không có dữ liệu</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Thêm/Sửa Dịch vụ -->
    <div class="modal fade" id="serviceModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="manageService" method="post" id="serviceForm">
                    <div class="modal-header">
                        <h5 class="modal-title"><i class="bi bi-gear-fill"></i><span id="modalTitle">Thêm dịch vụ</span></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="action" id="action" value="add">
                        <input type="hidden" name="serviceId" id="serviceId">

                        <div class="mb-3">
                            <label class="form-label">Tên dịch vụ</label>
                            <input type="text" name="serviceName" id="serviceName" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea name="description" id="description" class="form-control" rows="3"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Giá (VNĐ)</label>
                            <input type="number" name="price" id="price" step="0.01" class="form-control" required>
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
        const modal = new bootstrap.Modal(document.getElementById('serviceModal'));

        function openAddModal() {
            document.getElementById('modalTitle').innerText = "➕ Thêm dịch vụ";
            document.getElementById('action').value = "add";
            document.getElementById('serviceForm').reset();
            document.getElementById('serviceId').value = "";
            modal.show();
        }

        function openEditModal(id, name, desc, price) {
            document.getElementById('modalTitle').innerText = "✏️ Cập nhật dịch vụ";
            document.getElementById('action').value = "update";
            document.getElementById('serviceId').value = id;
            document.getElementById('serviceName').value = name;
            document.getElementById('description').value = desc;
            document.getElementById('price').value = price;
            modal.show();
        }
    </script>
</body>
</html>
