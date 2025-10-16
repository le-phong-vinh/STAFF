<%-- 
    Document   : staffHome
    Created on : Oct 1, 2025, 4:27:25 PM
    Author     : Le Phong Vinh - CE181130
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Trang chủ</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #eaf4f3;
            }

            /* Content */
            .content {
                margin-left: 230px;
                margin-top: 80px; /* chừa header */
                padding: 20px;
            }

            .filter-box, .stat-box {
                background: #fff;
                border-radius: 12px;
                padding: 15px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
                margin-bottom: 20px;
            }
            .stat-box {
                background: #f0f0f0;
            }

            .patient-card {
                background: #fff;
                border-radius: 6px;
                padding: 8px 12px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                box-shadow: 0 1px 3px rgba(0,0,0,0.2);
                margin-bottom: 8px;
            }
            .green-dot {
                width: 12px;
                height: 12px;
                border-radius: 50%;
                background: limegreen;
                display: inline-block;
                margin-right: 5px;
            }
            .done {
                color: green;
                font-weight: bold;
            }

        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/Include/header.jsp" />
        <jsp:include page="/WEB-INF/Include/sidebar.jsp" />
        <div class="content">
            <div class="row">
                <!-- Bộ lọc + bảng -->
                <div class="col-md-7">
                    <div class="filter-box">
                        <div class="row mb-3">
                            <div class="col-md-3"><input class="form-control" placeholder="Họ và Tên"></div>
                            <div class="col-md-3"><input class="form-control" placeholder="Mã hẹn"></div>
                            <div class="col-md-3"><input class="form-control" placeholder="Mã BN"></div>
                            <div class="col-md-3"><input class="form-control" placeholder="Trạng thái"></div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6"><input type="date" class="form-control"></div>
                            <div class="col-md-6"><input type="date" class="form-control"></div>
                        </div>
                        <h6>Các Lịch hẹn cần xác nhận</h6>
                        <table class="table table-bordered table-sm">
                            <thead class="table-secondary">
                                <tr>
                                    <th>TT</th>
                                    <th>SĐT</th>
                                    <th>Mã BN</th>
                                    <th>Tên BN</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr><td>01</td><td>000001</td><td>000001</td><td>Nguyen Van A</td></tr>
                                <tr><td>02</td><td>000002</td><td>000002</td><td>Nguyen Van A</td></tr>
                                <tr><td>03</td><td>000003</td><td>000003</td><td>Nguyen Van A</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Box thống kê -->
                <div class="col-md-5">
                    <div class="stat-box">
                        <h6>Số Lượng Lịch hẹn hôm nay</h6>
                        <p>12 lịch hẹn | 8 đã xác nhận | 3 chờ xử lý | 1 đã hủy</p>
                        <div class="patient-card">
                            <div>👤 Nguyen Van A<br><small>000001</small></div>
                            <div><span class="green-dot"></span><span class="done">Done</span></div>
                        </div>
                        <div class="patient-card">
                            <div>👤 Nguyen Van A<br><small>000001</small></div>
                            <div><span class="green-dot"></span><span class="done">Done</span></div>
                        </div>
                    </div>

                    <div class="stat-box">
                        <h6>Bệnh nhân mới đăng ký</h6>
                        <div class="patient-card">
                            <div>👤 Nguyen Van A<br><small>000001</small></div>
                            <div><span class="green-dot"></span><span class="done">Done</span></div>
                        </div>
                        <div class="patient-card">
                            <div>👤 Nguyen Van A<br><small>000001</small></div>
                            <div><span class="green-dot"></span><span class="done">Done</span></div>
                        </div>
                        <div class="patient-card">
                            <div>👤 Nguyen Van A<br><small>000001</small></div>
                            <div><span class="green-dot"></span><span class="done">Done</span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</html>
