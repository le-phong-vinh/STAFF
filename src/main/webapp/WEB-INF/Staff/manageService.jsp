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
        <style>
            body {
                background-color: #eaf4f3 !important;
                font-family: Arial, sans-serif;
                padding-top: 60px;
            }
            .content {
                margin-left: 230px;
                margin-top: 20px;
                padding: 20px;
            }
            .card {
                border-radius: 8px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            }
            .table td, .table th {
                vertical-align: middle;
                text-align: center;
            }
            .action-buttons {
                display: flex;
                gap: 6px;
                justify-content: center;
            }
            form.d-flex input[type="text"] {
                flex: 1;
            }
            form.d-flex button, form.d-flex a {
                white-space: nowrap;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/Include/header.jsp" />
        <jsp:include page="/WEB-INF/Include/sidebar.jsp" />
        <div class="content">
            <div class="card">
                <div class="card-body">
                    <!-- Tìm kiếm -->
                    <form class="d-flex mb-3" action="manageService" method="get">
                        <input type="text" name="keyword" class="form-control"
                               placeholder="Tìm kiếm dịch vụ..."
                               value="<%= (keyword != null) ? keyword : ""%>">
                        <button class="btn btn-outline-primary ms-2">🔍 Tìm</button>
                        <a href="manageService" class="btn btn-outline-secondary ms-2">✖ Reset</a>
                        <button type="button" class="btn btn-success ms-2" onclick="openAddModal()">➕ Thêm</button>
                    </form>
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead class="table-secondary">
                                <tr>
                                    <th>Tên Dịch Vụ</th>
                                    <th>Mô tả</th>
                                    <th>Giá (VNĐ)</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (list != null && !list.isEmpty()) {
                                    for (Service s : list) {%>
                                <tr>
                                    <td><%= s.getServiceName()%></td>
                                    <td><%= s.getDescription()%></td>
                                    <td><%= String.format("%,.0f", s.getPrice())%></td>
                                    <td class="action-buttons">
                                        <button type="button" class="btn btn-warning btn-sm"
                                                onclick="openEditModal('<%= s.getServiceId()%>', '<%= s.getServiceName().replace("'", "\\'")%>',
                                                                '<%= s.getDescription() != null ? s.getDescription().replace("'", "\\'") : ""%>',
                                                                '<%= s.getPrice()%>')">
                                            ✏️ Sửa
                                        </button>
                                        <a href="manageService?action=delete&serviceId=<%= s.getServiceId()%>"
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Bạn có chắc muốn xóa dịch vụ này?');">
                                            🗑 Xóa
                                        </a>
                                    </td>
                                </tr>
                                <% }
                            } else { %>
                                <tr><td colspan="4" class="text-center text-muted">Không có dữ liệu</td></tr>
                                <% }%>
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
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title" id="modalTitle">Thêm dịch vụ</h5>
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
                                <textarea name="description" id="description" class="form-control"></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Giá (VNĐ)</label>
                                <input type="number" name="price" id="price" step="0.01" class="form-control" required>
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
            const modal = new bootstrap.Modal(document.getElementById('serviceModal'));
            function openAddModal() {
                document.getElementById('modalTitle').innerText = "➕ Thêm dịch vụ";
                document.getElementById('action').value = "add";
                document.getElementById('serviceForm').reset();
                document.getElementById('serviceId').value = "";
                modal.show();
            }
            function openEditModal(id, name, desc, price) {
                document.getElementById('modalTitle').innerText = "✏️ Sửa dịch vụ";
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