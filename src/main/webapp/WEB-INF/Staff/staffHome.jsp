<%-- Staff/staffHome.jsp : Trang Dashboard cho nhân viên --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Nếu bạn có header/footer chung, include tại đây --%>
<jsp:include page="/WEB-INF/Include/header.jsp"/>

<%-- Định nghĩa URL giống sidebar để tái dùng nút/links --%>
<c:url var="homeURL" value="/staffHome"/>
<c:url var="patientURL" value="/PatientsController"/>
<c:url var="appointmentURL" value="/manageAppointment.jsp"/>
<c:url var="invoiceURL" value="/manageInvoice"/>
<c:url var="doctorURL" value="/DoctorsController"/>
<c:url var="scheduleURL" value="/StaffSchedule"/>
<c:url var="reviewURL" value="/ReviewController"/>
<c:url var="medicineURL" value="/manageMedicine"/>
<c:url var="diseaseURL" value="/manageDisease"/>
<c:url var="serviceURL" value="/manageService"/>
<c:url var="reportURL" value="/report"/>

<%-- Sidebar cố định của bạn --%>
<jsp:include page="/WEB-INF/Include/sidebar.jsp"/>

<style>
    .content {
        margin-left: 230px;      /* khớp với .sidebar width */
        padding: 20px;
        /*padding-top: 50px;        tránh đè header 60px */
        background: #f6f9fc;
        min-height: 100vh;
        font-family: Arial, sans-serif;
    }
    .card {
        border-radius: 10px;
        box-shadow: 0 4px 14px rgba(0,0,0,.06);
        border: none;
    }
    .quick-grid {
        display: grid;
        grid-template-columns: repeat(4, minmax(220px, 1fr));
        gap: 16px;
    }
    .quick-card a {
        display: block;
        text-decoration: none;
        color: #0d1b2a;
        padding: 16px;
    }
    .quick-card small {
        color:#667;
    }
    .table-wrap {
        overflow:auto;
    }
    @media (max-width: 1200px) {
        .quick-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }
    @media (max-width: 640px)  {
        .quick-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<div class="content">

    <!-- Thống kê nhanh (có thể thay bằng dữ liệu thực từ request/session) -->
    <div class="quick-grid" style="margin-bottom:18px">
        <div class="card quick-card">
            <a href="${appointmentURL}">
                <div style="font-size:13px;color:#667">Cuộc hẹn hôm nay</div>
                <div style="font-size:28px;font-weight:700;margin:2px 0">12</div>
                <small>Nhấp để quản lý cuộc hẹn</small>
            </a>
        </div>
        <div class="card quick-card">
            <a href="${patientURL}">
                <div style="font-size:13px;color:#667">Bệnh nhân mới</div>
                <div style="font-size:28px;font-weight:700;margin:2px 0">5</div>
                <small>Nhấp để quản lý bệnh nhân</small>
            </a>
        </div>
        <div class="card quick-card">
            <a href="${invoiceURL}">
                <div style="font-size:13px;color:#667">Hóa đơn chờ</div>
                <div style="font-size:28px;font-weight:700;margin:2px 0">3</div>
                <small>Nhấp để xử lý hóa đơn</small>
            </a>
        </div>
        <div class="card quick-card">
            <a href="${reviewURL}">
                <div style="font-size:13px;color:#667">Đánh giá mới</div>
                <div style="font-size:28px;font-weight:700;margin:2px 0">2</div>
                <small>Nhấp để xem hỗ trợ đánh giá</small>
            </a>
        </div>
    </div>

    <!-- Lối tắt chức năng (khớp 100% với sidebar) -->
    <div class="card" style="margin-bottom:18px">
        <div style="padding:16px 16px 0 16px">
            <h3 style="margin:0;font-size:18px">Lối tắt nhanh</h3>
        </div>
        <div style="padding:12px 16px 20px 16px" class="quick-grid">
            <a class="card quick-card" href="${patientURL}">
                <div style="font-weight:600;margin-bottom:6px">👤 Quản lý bệnh nhân</div>
                <small>Thêm/Sửa/Hồ sơ bệnh nhân</small>
            </a>
            <a class="card quick-card" href="${appointmentURL}">
                <div style="font-weight:600;margin-bottom:6px">📅 Quản lý cuộc hẹn</div>
                <small>Lịch tiếp nhận & trạng thái</small>
            </a>
            <a class="card quick-card" href="${invoiceURL}">
                <div style="font-weight:600;margin-bottom:6px">💰 Quản lý hóa đơn</div>
                <small>Hóa đơn chờ & in chứng từ</small>
            </a>
            <a class="card quick-card" href="${doctorURL}">
                <div style="font-weight:600;margin-bottom:6px">🩺 Quản lý bác sĩ</div>
                <small>Thông tin & chuyên khoa</small>
            </a>
            <a class="card quick-card" href="${scheduleURL}">
                <div style="font-weight:600;margin-bottom:6px">🗓️ Quản lý lịch bác sĩ</div>
                <small>Phân ca & điều phối</small>
            </a>
            <a class="card quick-card" href="${medicineURL}">
                <div style="font-weight:600;margin-bottom:6px">💊 Quản lý thuốc</div>
                <small>Kho & kê đơn</small>
            </a>
            <a class="card quick-card" href="${diseaseURL}">
                <div style="font-weight:600;margin-bottom:6px">🧬 Quản lý tên bệnh</div>
                <small>Danh mục ICD/tuỳ chỉnh</small>
            </a>
            <a class="card quick-card" href="${serviceURL}">
                <div style="font-weight:600;margin-bottom:6px">🧾 Quản lý dịch vụ</div>
                <small>Bảng giá & nhóm DV</small>
            </a>
            <a class="card quick-card" href="${reportURL}">
                <div style="font-weight:600;margin-bottom:6px">📊 Báo cáo doanh thu</div>
                <small>Thống kê & biểu đồ</small>
            </a>
        </div>
    </div>

    <!-- Bảng “Cuộc hẹn gần đây” (demo) -->
    <div class="card">
        <div style="padding:16px 16px 0 16px">
            <h3 style="margin:0;font-size:18px">Cuộc hẹn gần đây</h3>
        </div>
        <div class="table-wrap" style="padding:8px 16px 16px 16px">
            <table class="table table-sm" style="width:100%">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Bệnh nhân</th>
                        <th>Bác sĩ</th>
                        <th>Thời gian</th>
                        <th>Trạng thái</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%-- Thay bằng dữ liệu thực từ requestScope nếu có --%>
                    <tr>
                        <td>1</td>
                        <td>Nguyễn A</td>
                        <td>BS. Minh</td>
                        <td>09:00  |  14/10</td>
                        <td><span class="badge bg-warning text-dark">Chờ khám</span></td>
                        <td><a href="${appointmentURL}">Chi tiết</a></td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>Trần B</td>
                        <td>BS. Lan</td>
                        <td>09:30  |  14/10</td>
                        <td><span class="badge bg-success">Hoàn tất</span></td>
                        <td><a href="${appointmentURL}">Chi tiết</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

</div>

<%-- Footer chung (nếu có) --%>
