<%-- 
    Document   : managePatient
    Created on : Oct 2, 2025
    Author     : lepho
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Patient" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý Bệnh Nhân</title>
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
            <div class="row">
                <!-- Cột trái: danh sách bệnh nhân -->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <!-- Ô tìm kiếm -->
                            <form class="mb-3 d-flex" action="PatientsController" method="get">
                                <input type="hidden" name="action" value="search">
                                <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm bệnh nhân..." 
                                       value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : ""%>">
                                <button type="submit" class="btn btn-secondary ms-2">🔍</button>
                            </form>

                            <!-- Danh sách bệnh nhân -->
                            <div class="list-group">
                                <%
                                    ArrayList<Patient> list = (ArrayList<Patient>) request.getAttribute("patients");
                                    if (list == null || list.isEmpty()) {
                                %>
                                <div class="list-group-item text-center text-muted">
                                    Không có bệnh nhân nào
                                </div>
                                <%
                                } else {
                                    for (Patient p : list) {
                                %>
                                <a href="PatientsController?action=edit&id=<%= p.getPatientId()%>" 
                                   class="list-group-item list-group-item-action">
                                    👤 <%= p.getFullName()%><br>
                                    <small>ID: 0000<%= p.getPatientId()%></small>
                                </a>
                                <%
                                        }
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Cột phải: Form thêm / cập nhật -->
                <div class="col-md-8">
                    <%
                        Patient patient = (Patient) request.getAttribute("patient");
                        boolean isEdit = patient != null;
                    %>

                    <div class="card mb-4 <%= isEdit ? "" : "border-primary"%>">
                        <div class="card-header fw-bold <%= isEdit ? "" : "text-primary"%>">
                            <%= isEdit ? "Cập nhật thông tin bệnh nhân" : "➕ Tạo hồ sơ mới"%>
                        </div>
                        <div class="card-body">
                            <form method="post" action="PatientsController">
                                <input type="hidden" name="action" value="<%= isEdit ? "update" : "insert"%>">
                                <% if (isEdit) {%>
                                <input type="hidden" name="patientId" value="<%= patient.getPatientId()%>">
                                <% }%>

                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Họ và Tên</label>
                                        <input type="text" name="fullName" class="form-control" value="<%= isEdit ? patient.getFullName() : ""%>" required>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label">Ngày sinh</label>
                                        <input type="date" name="dob" class="form-control" value="<%= isEdit && patient.getDob() != null ? patient.getDob() : ""%>" required>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label">Giới tính</label>
                                        <select name="gender" class="form-select">
                                            <option <%= isEdit && "Nam".equals(patient.getGender()) ? "selected" : ""%>>Nam</option>
                                            <option <%= isEdit && "Nữ".equals(patient.getGender()) ? "selected" : ""%>>Nữ</option>
                                            <option <%= isEdit && "Khác".equals(patient.getGender()) ? "selected" : ""%>>Khác</option>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label">Số BHYT</label>
                                        <input type="text" name="insuranceNumber" class="form-control" value="<%= isEdit ? patient.getInsuranceNumber() : ""%>">
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label">Liên hệ</label>
                                        <input type="text" name="emergencyContact" class="form-control" value="<%= isEdit ? patient.getEmergencyContact() : ""%>">
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label">Tỉnh</label>
                                        <select name="provinceId" class="form-select">
                                            <%
                                                Map<Integer, String> provinces = (Map<Integer, String>) request.getAttribute("provinces");
                                                int selectedId = isEdit ? patient.getProvinceId() : 1; // default 1 = Hà Nội
                                                for (Map.Entry<Integer, String> entry : provinces.entrySet()) {
                                            %>
                                            <option value="<%= entry.getKey()%>" <%= entry.getKey() == selectedId ? "selected" : ""%>>
                                                <%= entry.getValue()%>
                                            </option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </div>



                                    <div class="col-md-6">
                                        <label class="form-label">Số điện thoại</label>
                                        <input type="text" name="phone" class="form-control" value="<%= isEdit ? patient.getPhone() : ""%>">
                                    </div>

                                </div>
                                <div class="mt-3 text-end">
                                    <% if (isEdit) { %>
                                    <button type="submit" class="btn btn-success">Lưu</button>
                                    <% } else { %>
                                    <button type="submit" class="btn btn-primary">Tạo</button>
                                    <% } %>
                                    <a href="PatientsController" class="btn btn-outline-secondary">Hủy</a>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>

            </div> <!-- /row -->
        </div> <!-- /content -->

        <!-- các nội dung HTML khác -->

        <% String errorMessage = (String) request.getAttribute("errorMessage");%>

        <!-- Modal ảo -->
        <div id="errorModal" class="custom-modal">
            <div class="custom-modal-content">
                <p><%= errorMessage != null ? errorMessage : ""%></p>
                <button class="custom-ok-btn" onclick="closeModal()">OK</button>
            </div>
        </div>
        <script>
            function closeModal() {
                document.getElementById('errorModal').style.display = 'none';
            }

        // Nếu có errorMessage thì hiện modal
            <% if (errorMessage != null) { %>
            document.getElementById('errorModal').style.display = 'block';
            <% }%>
        </script>

    </body>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</html>
