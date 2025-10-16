<%-- 
    Document   : sidebar
    Author     : Le Phong Vinh - CE181130
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String currentPage = request.getServletPath();
    String query = request.getQueryString();
    if (query != null) {
        currentPage += "?" + query;
    }
%>
<div class="sidebar">
    <ul>
        <li>
            <a href="staffHome.jsp"
               class="<%= currentPage.contains("staffHome.jsp") ? "active" : ""%>">
               Trang chủ
            </a>
        </li>
        <li>
            <a href="PatientsController"
               class="<%= currentPage.contains("managePatient.jsp") ? "active" : ""%>">
               Quản lý bệnh nhân
            </a>
        </li>
        <li>
            <a href="manageAppointment.jsp"
               class="<%= currentPage.contains("manageAppointment.jsp") ? "active" : ""%>">
               Quản lý cuộc hẹn
            </a>
        </li>
        <li>
            <a href="manageInvoice"
               class="<%= currentPage.contains("manageInvoice") ? "active" : ""%>">
               Quản lý hóa đơn
            </a>
        </li>
        <li>
            <a href="DoctorsController"
               class="<%= currentPage.contains("manageDoctor.jsp") ? "active" : ""%>">
               Quản lý bác sĩ
            </a>
        </li> 
         <li>
            <a href="StaffSchedule"
               class="<%= currentPage.contains("schedule.jsp") ? "active" : ""%>">
               Quản lý lịch bác sĩ
            </a>
        </li>
        <li>
            <a href="ReviewController"
               class="<%= currentPage.contains("manageReview.jsp") ? "active" : ""%>">
               Hỗ trợ đánh giá
            </a>
        </li>
        <li>
            <a href="manageMedicine"
               class="<%= currentPage.contains("manageMedicine") ? "active" : ""%>">
               Quản lý thuốc
            </a>
        </li>
        <li>
            <a href="manageDisease"
               class="<%= currentPage.contains("manageDisease") ? "active" : ""%>">
               Quản lý bệnh
            </a>
        </li>
        <li>
            <a href="manageService"
               class="<%= currentPage.contains("manageService") ? "active" : ""%>">
               Quản lý dịch vụ
            </a>
        </li>
        <li>
            <a href="report"
               class="<%= currentPage.contains("statisticAndReport") ? "active" : ""%>">
               Báo cáo doanh thu
            </a>
        </li>
    </ul>
</div>
<style>
    .sidebar {
        width: 230px;
        height: calc(100vh - 60px);
        background: #1d2f3c;
        position: fixed;
        top: 60px;
        left: 0;
        color: #fff;
        padding: 20px 10px;
        font-family: Arial, sans-serif;
        z-index: 998;
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
        transition: background 0.3s, color 0.3s, transform 0.2s;
    }
    .sidebar ul li a:hover {
        background: #2f4658;
        color: #f1f1f1;
        transform: translateX(3px);
    }
    .sidebar ul li a.active {
        background: linear-gradient(90deg, #0d6efd, #2980b9);
        color: #fff;
        font-weight: bold;
        box-shadow: inset 4px 0 0 #fff;
    }
</style>