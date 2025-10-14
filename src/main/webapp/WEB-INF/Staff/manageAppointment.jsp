<%-- 
    Document   : manageAppointment
    Created on : Oct 2, 2025, 7:58:39 AM
    Author     : Le Phong Vinh - CE181130
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý cuộc hẹn</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #eaf4f3;
            }
            .content {
                margin-left: 230px; /* chừa sidebar */
                margin-top: 80px;   /* chừa header */
                padding: 20px;
            }
            .card {
                border-radius: 8px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            }
            .table-responsive {
                max-height: 500px;
                overflow-y: auto;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/Include/header2.jsp" />
        <!-- Sidebar chính -->
        <jsp:include page="/Include/sidebar.jsp" />
        <!-- Nội dung -->
        <div class="content">
            <div class="row">
                <!-- Danh sách cuộc hẹn -->
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-body">
                            <!-- Ô tìm kiếm -->
                            <div class="d-flex mb-3">
                                <input type="text" class="form-control" placeholder="Tìm kiếm lịch hẹn...">
                                <button class="btn btn-outline-secondary ms-2">🔍</button>
                            </div>

                            <!-- Bảng cuộc hẹn -->
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead class="table-secondary">
                                        <tr>
                                            <th>Mã Hẹn</th>
                                            <th>Bệnh nhân</th>
                                            <th>SĐT</th>
                                            <th>Ngày/Giờ</th>
                                            <th>Trạng thái</th>
                                            <th>Bác sĩ</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>A001</td>
                                            <td>Nguyen An</td>
                                            <td>0909090909</td>
                                            <td>21/09 10:00</td>
                                            <td>Đang xử lý</td>
                                            <td>Chưa phân công</td>
                                            <td>
                                                <button class="btn btn-sm btn-success">Xác nhận</button>
                                                <button class="btn btn-sm btn-danger">Hủy</button>
                                                <button class="btn btn-sm btn-warning">Phân công</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>A002</td>
                                            <td>Nguyen B</td>
                                            <td>0909090999</td>
                                            <td>21/09 11:00</td>
                                            <td>Đang xử lý</td>
                                            <td>BS. Trí</td>
                                            <td>
                                                <button class="btn btn-sm btn-success">Xác nhận</button>
                                                <button class="btn btn-sm btn-danger">Hủy</button>
                                                <button class="btn btn-sm btn-warning">Phân công</button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Chi tiết lịch hẹn & phân công -->
                <div class="col-md-4">
                    <!-- Panel chi tiết lịch hẹn -->
                    <div class="card mb-3">
                        <div class="card-header fw-bold">LỊCH HẸN A001</div>
                        <div class="card-body">
                            <p><b>Bệnh nhân:</b> Nguyen An</p>
                            <p><b>SĐT:</b> 0909...</p>
                            <p><b>Ngày/Giờ:</b> 21/09 10:00</p>
                            <p><b>Trạng thái:</b> Đang xử lý</p>
                            <div class="text-end">
                                <button class="btn btn-success">Đồng ý</button>
                                <button class="btn btn-outline-secondary">Hủy</button>
                            </div>
                        </div>
                    </div>

                    <!-- Panel phân công bác sĩ -->
                    <div class="card">
                        <div class="card-header fw-bold">PHÂN CÔNG BÁC SĨ - A001</div>
                        <div class="card-body">
                            <input type="text" class="form-control mb-3" placeholder="Nhập tên bác sĩ...">

                            <div class="list-group mb-3">
                                <a href="#" class="list-group-item list-group-item-action">👨‍⚕️ Nguyen Van A<br><small>000001</small></a>
                                <a href="#" class="list-group-item list-group-item-action">👨‍⚕️ Nguyen Van B<br><small>000002</small></a>
                                <a href="#" class="list-group-item list-group-item-action">👨‍⚕️ Nguyen Van C<br><small>000003</small></a>
                            </div>

                            <div class="text-end">
                                <button class="btn btn-primary">Lưu</button>
                                <button class="btn btn-outline-secondary">Hủy</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
