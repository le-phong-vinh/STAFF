<%-- 
    Document   : sidebarStaff
    Author     : Le Phong Vinh - CE181130
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String currentPage = request.getServletPath();
    String query = request.getQueryString();
    if (query != null) {
        currentPage += "?" + query;
    }
%>

<!-- Định nghĩa URL động -->
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

<!-- Sidebar -->
<div class="sidebar">
    <ul>
        <li>
            <a href="${homeURL}"
               class="<%= currentPage.contains("staffHome.jsp") ? "active" : "" %>">
               🏠 Trang chủ
            </a>
        </li>
        <li>
            <a href="${patientURL}"
               class="<%= currentPage.contains("managePatient.jsp") ? "active" : "" %>">
               👤 Quản lý bệnh nhân
            </a>
        </li>
        <li>
            <a href="${appointmentURL}"
               class="<%= currentPage.contains("manageAppointment.jsp") ? "active" : "" %>">
               📅 Quản lý cuộc hẹn
            </a>
        </li>
        <li>
            <a href="${invoiceURL}"
               class="<%= currentPage.contains("manageInvoice") ? "active" : "" %>">
               💰 Quản lý hóa đơn
            </a>
        </li>
        <li>
            <a href="${doctorURL}"
               class="<%= currentPage.contains("manageDoctor.jsp") ? "active" : "" %>">
               🩺 Quản lý bác sĩ
            </a>
        </li>
        <li>
            <a href="${scheduleURL}"
               class="<%= currentPage.contains("schedule.jsp") ? "active" : "" %>">
               🗓️ Quản lý lịch bác sĩ
            </a>
        </li>
        <li>
            <a href="${reviewURL}"
               class="<%= currentPage.contains("manageReview.jsp") ? "active" : "" %>">
               ⭐ Hỗ trợ đánh giá
            </a>
        </li>
        <li>
            <a href="${medicineURL}"
               class="<%= currentPage.contains("manageMedicine") ? "active" : "" %>">
               💊 Quản lý thuốc
            </a>
        </li>
        <li>
            <a href="${diseaseURL}"
               class="<%= currentPage.contains("manageDisease") ? "active" : "" %>">
               🧬 Quản lý tên bệnh
            </a>
        </li>
        <li>
            <a href="${serviceURL}"
               class="<%= currentPage.contains("manageService") ? "active" : "" %>">
               🧾 Quản lý dịch vụ
            </a>
        </li>
        <li>
            <a href="${reportURL}"
               class="<%= currentPage.contains("statisticAndReport") ? "active" : "" %>">
               📊 Báo cáo doanh thu
            </a>
        </li>
    </ul>
</div>

<!-- CSS -->
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
