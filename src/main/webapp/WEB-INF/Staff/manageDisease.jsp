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
        <title>Quản lý loại bệnh</title>
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
                    <!-- Thanh tìm kiếm -->
                    <form class="d-flex mb-3" action="manageDisease" method="get">
                        <input type="text" name="keyword" class="form-control"
                               placeholder="Tìm kiếm loại bệnh..."
                               value="<%= (keyword != null) ? keyword : ""%>">
                        <button type="submit" class="btn btn-outline-primary ms-2">🔍 Tìm</button>
                        <a href="manageDisease" class="btn btn-outline-secondary ms-2">✖ Reset</a>
                        <button type="button" class="btn btn-success ms-2" onclick="openAddModal()">➕ Thêm</button>
                    </form>

                    <!-- Bảng danh sách -->
                    <div class="table-responsive" style="max-height: 500px; overflow-y: auto;">
                        <table class="table table-bordered table-hover">
                            <thead class="table-secondary">
                                <tr>
                                    <th>ID</th>
                                    <th>Tên bệnh</th>
                                    <th>Mô tả</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (list != null && !list.isEmpty()) {
                                        for (Disease d : list) {
                                            String nameEscaped = d.getDiseaseName().replace("'", "\\'");
                                            String descEscaped = (d.getDescription() != null)
                                                    ? d.getDescription().replace("'", "\\'")
                                                    : "";
                                %>
                                <tr>
                                    <td><%= d.getDiseaseId()%></td>
                                    <td><%= d.getDiseaseName()%></td>
                                    <td><%= d.getDescription() != null ? d.getDescription() : ""%></td>
                                    <td class="action-buttons">
                                        <button type="button" class="btn btn-warning btn-sm"
                                                onclick="openEditModal('<%= d.getDiseaseId()%>', '<%= nameEscaped%>', '<%= descEscaped%>')">
                                            ✏️ Sửa
                                        </button>
                                        <a href="manageDisease?action=delete&diseaseId=<%= d.getDiseaseId()%>"
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Bạn có chắc muốn xóa bệnh này?');">
                                            🗑 Xóa
                                        </a>
                                    </td>
                                </tr>
                                <%  }
    } else { %>
                                <tr><td colspan="4" class="text-center text-muted">Không có dữ liệu</td></tr>
                                <% }%>
                            </tbody>

                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- 🔹 Modal Thêm / Sửa Loại Bệnh -->
        <div class="modal fade" id="diseaseModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <form action="manageDisease" method="post" id="diseaseForm">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title" id="modalTitle">Thêm loại bệnh</h5>
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
                                <textarea name="description" id="description" class="form-control"></textarea>
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

                       // ➕ Thêm mới
                       function openAddModal() {
                           document.getElementById('modalTitle').innerText = "➕ Thêm loại bệnh";
                           document.getElementById('action').value = "add";
                           document.getElementById('diseaseForm').reset();
                           document.getElementById('diseaseId').value = "";
                           diseaseModal.show();
                       }

                       // ✏️ Sửa
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
