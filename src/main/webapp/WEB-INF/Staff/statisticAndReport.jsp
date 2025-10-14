<%-- 
    Document   : statisticAndReport
    Author     : Le Phong Vinh - CE181130
--%>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    List<Map<String, Object>> serviceRevenue = (List<Map<String, Object>>) request.getAttribute("serviceRevenue");
    List<Map<String, Object>> diseaseStats = (List<Map<String, Object>>) request.getAttribute("diseaseStats");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thống kê & Báo cáo</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- ✅ Thêm Bootstrap Icons (không đổi nội dung, chỉ để dùng icon khi cần) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
      body {
        background-color: #eaf4f3 !important;
        font-family: Arial, sans-serif;
        padding-top: 60px; /* tránh bị header che */
        margin: 0;
        box-sizing: border-box;
      }
      /* Sidebar cố định trái, dưới header */
      .sidebar {
        position: fixed;
        top: 60px;
        left: 0;
        width: 230px;
        height: calc(100vh - 60px);
        background: #1d2f3c;
        color: #fff;
        padding: 20px 10px;
        z-index: 998;
        display: flex;
        flex-direction: column;
      }
      .sidebar ul {
        list-style: none;
        padding: 0;
        margin: 0;
      }
      .sidebar ul li a {
        display: block;
        color: #fff;
        text-decoration: none;
        padding: 10px 12px;
        border-radius: 6px;
        margin-bottom: 8px;
        transition: background 0.2s;
      }
      .sidebar ul li a:hover {
        background: #2f4658;
      }
      .sidebar ul li a.active {
        background: linear-gradient(90deg, #0d6efd, #2980b9);
        color: #fff;
        font-weight: bold;
        box-shadow: inset 4px 0 0 #fff;
      }
      /* Nội dung chính nằm gọn, không bị tràn phải */
      .main-content {
        margin-left: 230px;
        margin-top: 20px;
        padding: 20px;
        box-sizing: border-box;
        max-width: calc(100vw - 230px); /* Đảm bảo không tràn phải khi màn hình nhỏ */
        overflow-x: auto;
      }
      .stat-card {
        background: #fff;
        border-radius: 10px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.09);
        text-align: center;
        padding: 22px 8px;
        margin-bottom: 8px;
      }
      .stat-card h6 {
        color: #1976d2;
        font-size: 1rem;
        margin-bottom: 8px;
      }
      .stat-card h2 {
        margin: 0;
        font-weight: bold;
        color: #1d2f3c;
        font-size: 1.5rem;
      }
      .card {
        border-radius: 8px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
      }
      .table-responsive {
        overflow-x: auto;
      }
      .table {
        width: 100%;
        min-width: 450px;
        table-layout: auto;
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
      /* Responsive: ẩn sidebar khi mobile, content chiếm full */
      @media (max-width: 991px) {
        .sidebar {
          position: static;
          width: 100%;
          height: auto;
          top: auto;
          left: auto;
          padding: 10px 5px;
        }
        .main-content {
          margin-left: 0;
          max-width: 100vw;
        }
      }

      /* ===================================================== */
      /* ✅ BỔ SUNG CSS ĐỒNG BỘ/HIỆN ĐẠI HƠN — KHÔNG ĐỔI NỘI DUNG */
      /* ===================================================== */

      :root {
        --bg: #f5f9f8;
        --card-radius: 14px;
        --shadow: 0 4px 15px rgba(0,0,0,0.08);
      }

      /* Nền nhẹ & animation vào .main-content (không đổi cấu trúc) */
      body { background-color: var(--bg) !important; }
      .main-content { animation: fadeIn .35s ease-in-out; }
      @keyframes fadeIn {
        from { opacity: 0; transform: translateY(8px); }
        to   { opacity: 1; transform: translateY(0); }
      }

      /* Card “mềm” hơn */
      .card {
        border-radius: var(--card-radius);
        box-shadow: var(--shadow);
        border: 0;
        background: #fff;
      }
      .card .card-header {
        background: #fff;
        color: #222;
        font-weight: 600;
        font-size: 1.05rem;
        padding: 12px 16px;
        border-bottom: 1px solid #eee;
      }

      /* Stat card đồng bộ bo góc & bóng */
      .stat-card {
        border-radius: 12px;
        box-shadow: var(--shadow);
        padding: 18px 10px;
      }

      /* Bảng: header sáng, hover nhẹ */
      .table thead th {
        background: #f8f9fa;
        font-weight: 600;
        font-size: .95rem;
      }
      .table td, .table th {
        font-size: .95rem;
        transition: background-color .25s ease;
      }
      .table-hover tbody tr:hover {
        background-color: #eef6ff;
      }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/Include/header.jsp" />
    <jsp:include page="/WEB-INF/Include/sidebar.jsp" />

    <div class="main-content">
        <!-- 4 box thống kê -->
        <div class="row mb-4">
            <div class="col-lg-3 col-md-6 mb-3">
                <div class="stat-card">
                    <h6>Doanh thu hôm nay</h6>
                    <h2><%=request.getAttribute("revToday")%> VND</h2>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-3">
                <div class="stat-card">
                    <h6>Doanh thu tuần này</h6>
                    <h2><%=request.getAttribute("revWeek")%> VND</h2>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-3">
                <div class="stat-card">
                    <h6>Doanh thu tháng này</h6>
                    <h2><%=request.getAttribute("revMonth")%> VND</h2>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-3">
                <div class="stat-card">
                    <h6>Doanh thu năm nay</h6>
                    <h2><%=request.getAttribute("revYear")%> VND</h2>
                </div>
            </div>
        </div>

        <!-- Bảng -->
        <div class="row g-3">
            <!-- Doanh thu theo dịch vụ -->
            <div class="col-lg-6 col-md-12">
                <div class="card h-100">
                    <div class="card-header fw-bold">💊 Doanh thu theo dịch vụ</div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-sm table-bordered table-hover mb-0">
                                <thead class="table-secondary">
                                    <tr>
                                        <th>Dịch vụ</th>
                                        <th>Số lượt</th>
                                        <th>Doanh thu</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (serviceRevenue != null && !serviceRevenue.isEmpty()) {
                                            for (Map<String, Object> r : serviceRevenue) {%>
                                    <tr>
                                        <td><%=r.get("serviceName")%></td>
                                        <td><%=r.get("count")%></td>
                                        <td><%=r.get("revenue")%> VND</td>
                                    </tr>
                                    <% }
                                    } else { %>
                                    <tr><td colspan="3" class="text-center">Không có dữ liệu</td></tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Thống kê bệnh -->
            <div class="col-lg-6 col-md-12">
                <div class="card h-100">
                    <div class="card-header fw-bold">📋 Thống kê bệnh nhân theo loại bệnh</div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-sm table-bordered table-hover mb-0">
                                <thead class="table-secondary">
                                    <tr>
                                        <th>Loại bệnh</th>
                                        <th>Số bệnh nhân</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (diseaseStats != null && !diseaseStats.isEmpty()) {
                                            for (Map<String, Object> d : diseaseStats) {%>
                                    <tr>
                                        <td><%=d.get("diseaseName")%></td>
                                        <td><%=d.get("count")%></td>
                                    </tr>
                                    <% }
                                    } else { %>
                                    <tr><td colspan="2" class="text-center">Không có dữ liệu</td></tr>
                                    <% }%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div><!-- /row -->
    </div><!-- /main-content -->
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</html>
