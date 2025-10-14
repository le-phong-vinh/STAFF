<%-- 
    Document   : header
    Created on : Oct 1, 2025
    Author     : Ho Gia Bao - CE191304
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<style>
 /* Đảm bảo navbar full ngang, cố định trên đầu, cao 60px */
.navbar {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    height: 60px;
    z-index: 1000;
    padding-left: 20px;
    padding-right: 20px;
    background: #fff !important; /* Nền trắng */
    box-shadow: 0 2px 8px 0 rgba(0,0,0,0.03);
}
body {
    padding-top: 60px; /* tránh bị che nội dung */
}

/* Logo */
.navbar-brand img {
    height: 40px;
    width: auto;
    display: block;
    margin-right: 8px;
}
/* Tên logo */
.navbar-brand span {
    font-weight: bold;
    color: #222;
    letter-spacing: 1px;
}

/* Menu điều hướng */
.navbar-nav .nav-link {
    font-weight: 500;
    font-size: 1rem;
    color: #222 !important; /* Màu chữ tối */
    transition: color 0.2s;
}
.navbar-nav .nav-link.active,
.navbar-nav .nav-link:hover {
    color: #1976d2 !important; /* Màu xanh dương hoặc tuỳ ý */
    background: #f3f3f3;
    border-radius: 5px;
}

/* Dropdown tài khoản */
.dropdown .btn {
    display: flex;
    align-items: center;
    font-weight: 500;
    gap: 4px;
    color: #222;
    background: #f8f9fa;
    border: none;
}
.dropdown .btn:focus {
    box-shadow: none;
}
.dropdown-menu {
    min-width: 160px;
    font-size: 1rem;
    background: #fff;
    border: 1px solid #eee;
}
.dropdown-menu .dropdown-item {
    font-weight: 500;
    color: #222;
}
.dropdown-menu .dropdown-item:hover {
    background: #f1f1f1;
    color: #1976d2;
}

/* Avatar user bên phải (nếu có) */
.dropdown .bi-person-circle {
    font-size: 1.6rem;
    vertical-align: middle;
    color: #1976d2;
}

/* Responsive: logo nhỏ lại trên mobile */
@media (max-width: 576px) {
    .navbar {
        height: 52px;
        padding-left: 8px;
        padding-right: 8px;
    }
    .navbar-brand img {
        height: 32px;
        margin-right: 6px;
    }
    .navbar-brand span {
        font-size: 1rem;
    }
}
</style>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white">
    <div class="container-fluid">

        <!-- Logo -->
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/home">
            <img src="${pageContext.request.contextPath}/Asset/logo.png" alt="FMec Hospital" class="me-2" height="40">
        </a>

        <!-- Toggle cho mobile -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Menu -->
       <c:if test="${empty sessionScope.loggedUser or sessionScope.loggedUser.role ne 'staff'}">
    <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
        <ul class="navbar-nav d-flex gap-4">
            <li class="nav-item">
                <a class="nav-link ${currentPage == 'home' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/home">Trang chủ</a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${currentPage == 'doctors' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/doctors">Danh Sách Bác Sĩ</a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${currentPage == 'booking' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/booking">Đặt Lịch Hẹn</a>
            </li>
        </ul>
    </div>
</c:if>

        <!-- Dropdown tài khoản -->
        <div class="dropdown ms-auto">
            <button class="btn btn-outline-light btn-sm dropdown-toggle" type="button"
                    id="userMenu" data-bs-toggle="dropdown" aria-expanded="false">
                <c:choose>
                    <c:when test="${not empty sessionScope.loggedUser}">
                        <i class="bi bi-person-circle me-1"></i>${sessionScope.loggedUser.username}
                    </c:when>
                    <c:otherwise>
                        <i class="bi bi-person-circle me-1"></i>Tài khoản
                    </c:otherwise>
                </c:choose>
            </button>

            <ul class="dropdown-menu dropdown-menu-end text-center" aria-labelledby="userMenu">
               <c:choose>
    <c:when test="${not empty sessionScope.loggedUser}">
        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Hồ sơ cá nhân</a></li>
        <c:if test="${sessionScope.loggedUser.role ne 'staff'}">
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/historyOfAppointment">Lịch sử khám</a></li>
        </c:if>
        <li><hr class="dropdown-divider"></li>
        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
    </c:when>
    <c:otherwise>
        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/register">Đăng ký</a></li>
    </c:otherwise>
</c:choose>
            </ul>
        </div>
    </div>
</nav>

