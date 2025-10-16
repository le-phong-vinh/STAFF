<%@page import="model.Medicine"%>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    List<Medicine> list = (List<Medicine>) request.getAttribute("list");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lí thuốc</title>
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
            <div class="card-header fw-bold d-flex justify-content-between align-items-center">
                📦 Danh sách thuốc
                <button class="btn btn-success btn-sm" onclick="openAddModal()">➕ Thêm thuốc</button>
            </div>
            <div class="card-body">
                <!-- Search -->
                <form class="d-flex mb-3" action="manageMedicine" method="get">
                    <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm thuốc...">
                    <button class="btn btn-outline-primary ms-2">🔍 Tìm</button>
                    <a href="manageMedicine" class="btn btn-outline-secondary ms-2">✖ Reset</a>
                </form>

                <!-- Bảng thuốc -->
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="table-secondary">
                            <tr>
                                <th>ID</th>
                                <th>Tên Thuốc</th>
                                <th>Mô tả</th>
                                <th>Đơn vị</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (list != null && !list.isEmpty()) {
                                for (Medicine m : list) {
                                    String nameEsc = m.getName().replace("'", "\\'");
                                    String descEsc = (m.getDescription() != null) ? m.getDescription().replace("'", "\\'") : "";
                                    String unitEsc = (m.getUnit() != null) ? m.getUnit().replace("'", "\\'") : "";
                            %>
                            <tr>
                                <td><%= m.getMedicineId() %></td>
                                <td><%= m.getName() %></td>
                                <td><%= m.getDescription() %></td>
                                <td><%= m.getUnit() %></td>
                                <td class="action-buttons">
                                    <button type="button" class="btn btn-warning btn-sm"
                                            onclick="openEditModal('<%= m.getMedicineId() %>', '<%= nameEsc %>', '<%= descEsc %>', '<%= unitEsc %>')">
                                        ✏️ Sửa
                                    </button>
                                    <a href="manageMedicine?action=delete&medicineId=<%= m.getMedicineId() %>"
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Xóa thuốc này?');">🗑 Xóa</a>
                                </td>
                            </tr>
                            <% } } else { %>
                            <tr><td colspan="5" class="text-center text-muted">Không có dữ liệu</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal thêm/sửa thuốc -->
    <div class="modal fade" id="medicineModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="manageMedicine" method="post">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title" id="modalTitle">➕ Thêm thuốc</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="action" id="action" value="add">
                        <input type="hidden" name="medicineId" id="medicineId">
                        <div class="mb-3">
                            <label class="form-label">Tên thuốc</label>
                            <input type="text" name="name" id="name" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea name="description" id="description" class="form-control"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Đơn vị</label>
                            <input type="text" name="unit" id="unit" class="form-control">
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
        const modal = new bootstrap.Modal(document.getElementById('medicineModal'));

        function openAddModal() {
            document.getElementById('modalTitle').innerText = "➕ Thêm thuốc";
            document.getElementById('action').value = "add";
            document.getElementById('medicineId').value = "";
            document.getElementById('name').value = "";
            document.getElementById('description').value = "";
            document.getElementById('unit').value = "";
            modal.show();
        }

        function openEditModal(id, name, desc, unit) {
            document.getElementById('modalTitle').innerText = "✏️ Cập nhật thuốc";
            document.getElementById('action').value = "update";
            document.getElementById('medicineId').value = id;
            document.getElementById('name').value = name;
            document.getElementById('description').value = desc;
            document.getElementById('unit').value = unit;
            modal.show();
        }
    </script>
</body>
</html>
