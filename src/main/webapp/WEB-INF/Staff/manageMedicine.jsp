<%@page import="model.Medicine"%>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    List<Medicine> list = (List<Medicine>) request.getAttribute("list");
    String keyword = (String) request.getAttribute("keyword");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý Thuốc</title>
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
                margin-top: 20px;
                padding: 20px;
            }
            .card {
                border-radius: var(--card-radius);
                box-shadow: var(--shadow);
                border: 0;
            }
            /* ======= CHUẨN HÓA BẢNG (không khung cuộn) ======= */
            .table td, .table th {
                vertical-align: middle;
                text-align: center;
            }
            .table thead th {
                background: #f1f3f5;
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
            .cell-text {
                max-width: 520px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            @media (max-width: 768px) {
                .content {
                    margin-left: 0;
                }
                .toolbar .form-control {
                    min-width: 180px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/Include/header.jsp" />
        <jsp:include page="/WEB-INF/Include/sidebar.jsp" />

        <div class="content">
            <div class="card">
                <div class="card-header fw-bold d-flex justify-content-between align-items-center">
                    Quản lý Thuốc
                </div>
                <div class="card-body">
                    <!-- Toolbar tìm kiếm (đồng bộ) -->
                    <form class="toolbar d-flex align-items-center gap-2 mb-3" action="manageMedicine" method="get">
                        <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm thuốc..."
                               value="<%= (keyword != null) ? keyword : ""%>">
                        <button class="btn btn-outline-primary" type="submit">🔍 Tìm</button>
                        <a href="manageMedicine" class="btn btn-outline-secondary">✖ Reset</a>
                        <button type="button" class="btn btn-success" onclick="openAddModal()">➕ Thêm</button>
                    </form>

                    <!-- Bảng thuốc (đồng bộ cấu trúc) -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover mb-0">
                            <thead class="table-secondary">
                                <tr>
                                    <th style="width:110px;">ID</th>
                                    <th style="width:260px;">Tên thuốc</th>
                                    <th>Mô tả</th>
                                    <th style="width:160px;">Đơn vị</th>
                                    <th style="width:160px;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (list != null && !list.isEmpty()) {
                                        for (Medicine m : list) {
                                            String name = (m.getName() != null) ? m.getName() : "";
                                            String desc = (m.getDescription() != null) ? m.getDescription() : "";
                                            String unit = (m.getUnit() != null) ? m.getUnit() : "";

                                            String nameEsc = name.replace("'", "\\'");
                                            String descEsc = desc.replace("'", "\\'");
                                            String unitEsc = unit.replace("'", "\\'");
                                %>
                                <tr>
                                    <td><%= m.getMedicineId()%></td>
                                    <td class="cell-text" title="<%= name%>"><%= name%></td>
                                    <td class="cell-text" title="<%= desc%>"><%= desc%></td>
                                    <td class="cell-text" title="<%= unit%>"><%= unit%></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button type="button" class="btn btn-warning btn-sm"
                                                    onclick="openEditModal('<%= m.getMedicineId()%>', '<%= nameEsc%>', '<%= descEsc%>', '<%= unitEsc%>')">
                                                ✏️ Sửa
                                            </button>
                                            <a href="manageMedicine?action=delete&medicineId=<%= m.getMedicineId()%>"
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('Bạn có chắc muốn xóa thuốc này?');">
                                                🗑 Xóa
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="5" class="text-center text-muted">Không có dữ liệu</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal thêm/sửa thuốc (đồng bộ) -->
        <div class="modal fade" id="medicineModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <form action="manageMedicine" method="post" id="medicineForm">
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
                                <textarea name="description" id="description" class="form-control" rows="3"></textarea>
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
                                                       document.getElementById('medicineForm').reset();
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
