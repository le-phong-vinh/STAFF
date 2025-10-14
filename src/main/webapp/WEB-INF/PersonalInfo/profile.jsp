<%-- 
    Document   : profile
    Created on : Oct 1, 2025, 12:37:06 PM
    Author     : Ho Gia Bao - CE191304
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>FMec Hospital – Hồ Sơ Của Tôi</title>

  
  <style>
    :root{
      --brand-bg:#d9f0f5;
      --chip:#cfeefe;
      --chip-text:#0f4b5a;
    }
    body{ background:#f9f9f9; }
    .navbar{ background:var(--brand-bg); }
    .nav-tabs-like .nav-link{
      background:#f2fbfd; border:1px solid #cfe7ee; border-radius:.75rem; padding:.5rem 1rem; margin-right:.5rem;
    }
    .nav-tabs-like .nav-link.active{ background:#fff; box-shadow:0 1px 3px rgba(0,0,0,.08); }
    .btn-login{ border-radius:.75rem; }

    .profile-box{ max-width:700px; margin:32px auto; background:#fff; border-radius:1.2rem; box-shadow:0 2px 8px rgba(0,0,0,.05); padding:28px; }
    .avatar{ font-size:4rem; background:#eef7fa; padding:18px; border-radius:50%; display:inline-block; }
    .title{ font-weight:700; }

    .chip{
      background:var(--chip); color:var(--chip-text); border:none; border-radius:999px;
      padding:.45rem .9rem; font-weight:600; width:100%; text-align:center;
    }
    .field-display{
      background:#eaf6fb; border-radius:999px; padding:.45rem .9rem;
    }

    .btn-primary.rounded-pill, .btn-secondary.rounded-pill{ padding:.55rem 1.4rem; }

    footer{ background:var(--brand-bg); padding:14px 0; margin-top:32px; }
    .foot-sub{ background:#eef6f8; padding:8px 0; font-size:.85rem; color:#6b7280; }
  </style>
</head>
<body>

<jsp:include page="/Include/header.jsp" />


<!-- Profile view -->
<div class="container">
  <div class="text-center mt-4">
    <span class="avatar"><i class="bi bi-person-circle"></i></span>
    <h4 class="title mt-2">Hồ Sơ Của Tôi</h4>
  </div>

  <div class="profile-box">
    <div class="row gy-3 align-items-center">
      <div class="col-12 col-md-4"><div class="chip">Tên đăng nhập</div></div>
      <div class="col-12 col-md-8"><div class="field-display">username123</div></div>

      <div class="col-12 col-md-4"><div class="chip">Họ và Tên</div></div>
      <div class="col-12 col-md-8"><div class="field-display">Nguyễn Văn A</div></div>

      <div class="col-12 col-md-4"><div class="chip">Ngày sinh</div></div>
      <div class="col-12 col-md-8"><div class="field-display">12/05/1995</div></div>

      <div class="col-12 col-md-4"><div class="chip">Giới tính</div></div>
      <div class="col-12 col-md-8"><div class="field-display">Nam</div></div>

      <div class="col-12 col-md-4"><div class="chip">Số điện thoại</div></div>
      <div class="col-12 col-md-8"><div class="field-display">0901234567</div></div>

      <div class="col-12 col-md-4"><div class="chip">Email</div></div>
      <div class="col-12 col-md-8"><div class="field-display">user@email.com</div></div>

      <div class="col-12 col-md-4"><div class="chip">Số bảo hiểm</div></div>
      <div class="col-12 col-md-8"><div class="field-display">BH123456</div></div>

      <div class="col-12 col-md-4"><div class="chip">Địa chỉ</div></div>
      <div class="col-12 col-md-8"><div class="field-display">123 Nguyễn Trãi, Hà Nội</div></div>
    </div>

    <div class="text-center mt-4">
      <a href="updateProfile.jsp" class="btn btn-secondary rounded-pill fw-semibold">Chỉnh sửa</a>
    </div>
  </div>
</div>

<!-- Footer -->
<footer>
  <div class="container d-flex flex-column flex-md-row align-items-center justify-content-between">
    <div class="fw-semibold">Thông tin liên hệ</div>
    <div class="small text-muted">Phone: 0900 123 777 &nbsp;|&nbsp; Email: support@fmec.vn</div>
    <div class="fs-5">
      <a href="#" class="text-dark me-2"><i class="bi bi-facebook"></i></a>
      <a href="#" class="text-dark"><i class="bi bi-instagram"></i></a>
    </div>
  </div>
  <div class="foot-sub">
    <div class="container d-flex justify-content-between small">
      <span>Bản quyền © 2025 FMec</span>
      <span>Chính sách & điều khoản | Liên hệ hỗ trợ</span>
    </div>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
