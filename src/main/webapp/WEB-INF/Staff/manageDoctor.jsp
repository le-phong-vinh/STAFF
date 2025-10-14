<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Doctor, model.Specialty" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý bác sĩ</title>
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
            <h4 class="mb-3">👨‍⚕️ Quản lý bác sĩ</h4>
            <div class="row">
                <!-- Danh sách bác sĩ -->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex mb-3">
                                <input type="text" class="form-control" placeholder="Tên, ID">
                                <select class="form-select ms-2">
                                    <option>Khoa Nội</option>
                                    <option>Khoa Ngoại</option>
                                    <option>Khoa Nhi</option>
                                </select>
                            </div>
                            <div class="list-group" style="max-height: 500px; overflow-y: auto;">
                                <%
                                    ArrayList<Doctor> doctors = (ArrayList<Doctor>) request.getAttribute("doctors");
                                    if (doctors != null && !doctors.isEmpty()) {
                                        for (Doctor d : doctors) {
                                %>
                                <a href="#" class="list-group-item list-group-item-action doctor-item"
                                   data-id="<%= d.getDoctorId()%>"
                                   data-userid="<%= d.getUserId()%>"
                                   data-name="<%= d.getFullName()%>"
                                   data-license="<%= d.getLicenseNumber()%>"
                                   data-specialtyid="<%= d.getSpecialtyId()%>"
                                   data-phone="<%= d.getPhone()%>"
                                   data-email="<%= d.getEmail()%>"
                                   data-status="<%= d.getScheduleStatus()%>">
                                    👨‍⚕️ <%= d.getFullName()%><br>
                                    <small>    ID: 0000<%=  d.getDoctorId()%></small>
                                </a>
                                <%      }
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Form cập nhật + phân công -->
                <div class="col-md-8">
                    <!-- Cập nhật bác sĩ -->
                    <div class="card mb-3">
                        <div class="card-header fw-bold">CẬP NHẬT BÁC SĨ</div>
                        <div class="card-body">
                            <form action="DoctorsController" method="post" onsubmit="return confirmUpdate()">
                                <input type="hidden" name="action" value="update">
                                <!-- giữ userId để submit (ẩn) -->
                                <input type="hidden" id="userId" name="userId" value="">
                                <!-- giữ doctorId để submit -->
                                <input type="hidden" id="doctorId" name="doctorId" value="">

                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Họ và tên</label>
                                        <input type="text" id="doctorName" name="fullName" class="form-control" value="">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Mã bác sĩ</label>
                                        <!-- Hiển thị nhưng không cho sửa -->
                                        <input type="text" id="doctorId_display" class="form-control" value="" disabled>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label">Số giấy phép</label>
                                        <input type="text" id="licenseNumber" name="licenseNumber" class="form-control" value="">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Chuyên khoa</label>
                                        <select id="specialtyId" name="specialtyId" class="form-select">
                                            <%
                                                ArrayList<Specialty> specialties = (ArrayList<Specialty>) request.getAttribute("specialties");
                                                Doctor doctor = (Doctor) request.getAttribute("doctor");
                                                int selectedSpId = doctor != null ? doctor.getSpecialtyId() : -1;
                                                if (specialties != null) {
                                                    for (Specialty sp : specialties) {
                                            %>
                                            <option value="<%= sp.getSpecialtyId()%>"
                                                    <%= sp.getSpecialtyId() == selectedSpId ? "selected" : ""%>>
                                                <%= sp.getSpecialtyName()%>
                                            </option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Số điện thoại</label>
                                        <input type="text" id="phone" name="phone" class="form-control" value="">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Mail</label>
                                        <input type="text" id="email" name="email" class="form-control" value="">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Trạng thái</label>
                                        <select id="doctorStatus" name="status" class="form-select">
                                            <option value="1">Đang làm việc</option>
                                            <option value="0">Không hoạt động</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="text-end mt-3">
                                    <button type="submit" class="btn btn-success">Lưu</button>
                                    <button type="button" class="btn btn-outline-secondary" 
                                            onclick="window.location.href = 'DoctorsController'">Hủy</button>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!-- Script confirm -->
        <script>
            function confirmUpdate() {
                return confirm("Bạn có chắc chắn muốn lưu thay đổi bác sĩ này?");
            }
        </script>
        <script>
            document.querySelectorAll('.doctor-item').forEach(item => {
                item.addEventListener('click', function (e) {
                    e.preventDefault();
                    const id = this.dataset.id;
                    const userId = this.dataset.userid;
                    const name = this.dataset.name;
                    const license = this.dataset.license;
                    const specialtyId = this.dataset.specialtyid;
                    const phone = this.dataset.phone;
                    const email = this.dataset.email;
                    const status = this.dataset.status;

                    // fill vào form
                    document.querySelector('#doctorId').value = id;
                    document.querySelector('#doctorId_display').value = id;
                    document.querySelector('#userId').value = userId;
                    document.querySelector('#doctorName').value = name;
                    document.querySelector('#licenseNumber').value = license;
                    document.querySelector('#specialtyId').value = specialtyId;
                    document.querySelector('#phone').value = phone;
                    document.querySelector('#email').value = email;
                    document.querySelector('#doctorStatus').value = status;

                    document.querySelector('#assignDoctorName').textContent = name + " (" + id + ")";
                });
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
