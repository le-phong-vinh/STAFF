<%-- 
    Document   : newjsp
    Created on : Oct 1, 2025, 11:42:28 AM
    Author     : Ho Gia Bao - CE191304
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/Include/header.jsp" />

<body>

<!-- Content -->
<div class="container my-4">
  <h4 class="page-title mb-3">Nội dung chi tiết đặt hẹn</h4>

  <div class="row g-4">
    <!-- Left form -->
    <div class="col-lg-7">
      <div class="panel">
        <!-- Specialty -->
        <div class="mb-3 select-wrap">
          <label class="form-label fw-semibold">Chuyên Khoa<span class="text-danger">*</span></label>
          <select class="form-select rounded-xl pe-5">
            <option value="" selected>— Chọn chuyên khoa —</option>
            <option>Tim mạch</option>
            <option>Nội tổng hợp</option>
            <option>Nhi</option>
            <option>Da liễu</option>
          </select>
        
        </div>

        <!-- Doctor -->
        <div class="mb-3 select-wrap">
          <label class="form-label fw-semibold">Bác sĩ<span class="text-danger">*</span></label>
          <select class="form-select rounded-xl pe-5">
            <option value="" selected>— Chọn bác sĩ —</option>
            <option>BS. Trương Ngọc Hải</option>
            <option>BS. Nguyễn Văn A</option>
            <option>BS. Phạm Thị B</option>
          </select>
         
        </div>

        <!-- Reason -->
        <div class="mb-2">
          <label class="form-label fw-semibold">Lý do khám</label>
          <textarea rows="5" class="form-control rounded-xl" placeholder="Mô tả triệu chứng hoặc yêu cầu của bạn..."></textarea>
        </div>
      </div>
    </div>

    <!-- Right time slots -->
    <div class="col-lg-5">
      <div class="panel">
        <label class="form-label fw-semibold">Thời gian khám<span class="text-danger">*</span></label>

        <div class="d-flex flex-wrap gap-2">
          <button type="button" class="slot active">
            <div class="date">22/09</div>
            <div class="dow">Thứ 2</div>
          </button>
          <button type="button" class="slot">
            <div class="date">23/09</div>
            <div class="dow">Thứ 3</div>
          </button>
          <button type="button" class="slot">
            <div class="date">24/09</div>
            <div class="dow">Thứ 4</div>
          </button>
          <button type="button" class="slot">
            <div class="date">26/09</div>
            <div class="dow">Ngày khác</div>
          </button>
        </div>

        <p class="mt-3 mb-0 note">
          *Lưu ý: Tổng đài viên sẽ gọi lại để quý khách xác nhận & cập nhật thời gian phù hợp nếu cần thiết.
        </p>
      </div>
    </div>
  </div>

  <!-- Submit -->
  <div class="text-center mt-3">
    <button class="btn btn-primary rounded-pill fw-semibold">
      Đăng ký
    </button>
  </div>
</div>

<jsp:include page="/WEB-INF/Include/footer.jsp" />

