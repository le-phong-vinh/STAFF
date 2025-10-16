<%-- 
    File      : doctors.jsp
    Purpose   : Danh sách bác sĩ + search realtime (giữ màu navbar theo header)
    Author    : Ho Gia Bao - CE191304
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/Include/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<section class="doctors-page container py-3">
    <h1 class="title h3 mb-3 text-center">Danh sách bác sĩ</h1>



    <!-- BẢNG DANH SÁCH -->
    <div class="table-responsive">
        <table class="table table-hover align-middle">
            <thead class="table-light">
                <tr>
                    <th style="width:80px;">ID Bác sĩ</th>
                    <th>Tên bác sĩ</th>
                    <th>Chuyên khoa</th>
                    <th style="width:220px;">Đặt lịch khám ngay</th>
                </tr>
            </thead>

            <tbody>
                <c:choose>
                    <c:when test="${not empty requestScope.doctors}">
                        <c:forEach var="d" items="${requestScope.doctors}">
                            <tr>
                                <td>${d.doctorId}</td>
                                <td>${d.doctorName}</td>
                                <td>${d.specialtyName}</td>
                                <td>
                                    <a class="btn btn-success btn-sm"
                                       href="${pageContext.request.contextPath}/appointment/book?doctorId=${d.doctorId}">
                                        <i class="bi bi-calendar-plus me-1"></i> Đặt lịch khám
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="4" class="text-center text-muted py-4">No results.</td></tr>
                    </c:otherwise>
                </c:choose>
            </tbody>

        </table>
    </div>
</section>
<jsp:include page="/WEB-INF/Include/footer.jsp" />

