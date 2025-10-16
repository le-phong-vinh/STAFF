<%-- 
    Document   : updateBooking
    Created on : Oct 1, 2025, 1:09:58 PM
    Author     : Ho Gia Bao - CE191304
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>FMec Hospital – Thay đổi lịch hẹn</title>

  

  <style>
    :root{
      --brand-bg:#d9f0f5;
      --chip:#cfeefe;
      --panel:#f7fbfe;
      --slot:#eef3f6;
      --primary:#00c8ff;
    }
    body{ background:#f9f9f9; }
    .navbar{ background:var(--brand-bg); }
    .nav-tabs-like .nav-link{
      background:#f2fbfd; border:1px solid #cfe7ee; border-radius:.75rem; padding:.5rem 1rem; margin-right:.5rem;
    }
    .nav-tabs-like .nav-link.active{ background:#fff; box-shadow:0 1px 3px rgba(0,0,0,.08); }

    .page-title{ font-weight:800; margin:24px 0 8px; }
    .divider{ height:2px; width:120px; background:#222; border-radius:2px; margin-bottom:14px; }

    .panel{ background:#fff; border-radius:1.1rem; padding:1.25rem; box-shadow:0 1px 5px rgba(0,0,0,.05); }
    .form-control.rounded-xl, .form-select.rounded-xl{ border-radius:1.25rem; background:var(--panel); }
    .select-wrap{ position:relative; }
    .select-wrap .bi-chevron-down{
      position:absolute; right:.75rem; top:50%; transform:translateY(-50%); pointer-events:none;
      background:#e8f5fb; border-radius:999px; padding:.28rem;
    }

    .slot{
      background:var(--slot); border:1px solid #dfe7ec; border-radius:.9rem; padding:.7rem .9rem;
      min-width:110px; text-align:center; cursor:pointer;
    }
    .slot .date{ font-weight:700; }
    .slot .dow{ font-size:.9rem; color:#6b7280; }
    .slot.active{ background:#ddeffc; border-color:var(--primary); box-shadow:0 0 0 3px rgba(0,200,255,.15); }
    .slot.disabled{ opacity:.45; cursor:not-allowed; }

    .btn-primary.rounded-pill{ padding:.6rem 1.5rem; }

    footer{ background:var(--brand-bg); padding:14px 0; margin-top:28px; }
    .foot-sub{ background:#eef6f8; padding:8px 0; font-size:.85rem; color:#6b7280; }
  </style>
</head>
<body>
<jsp:include page="/Include/header.jsp" />

<!-- Content -->
<div class="container my-3">
  <h4 class="page-title">Thay đổi lịch hẹn</h4>
  <div class="divider"></div>

  <div class="row g-4">
    <!-- Left: fields -->
    <div class="col-lg-7">
      <div class="panel">
        <div class="mb-3 select-wrap">
          <label class="form-label fw-semibold">Chuyên Khoa<span class="text-danger">*</span></label>
          <select class="form-select rounded-xl pe-5">
            <option selected>Tim mạch</option>
            <option>Nội tổng hợp</option>
            <option>Nhi</option>
            <option>Da liễu</option>
          </select>
          <i class="bi bi-chevron-down"></i>
        </div>

        <div class="mb-3 select-wrap">
          <label class="form-label fw-semibold">Bác sĩ<span class="text-danger">*</span></label>
          <select class="form-select rounded-xl pe-5">
            <option>BS. Trương Ngọc Hải</option>
            <option selected>BS. Nguyễn Văn A</option>
            <option>BS. Phạm Thị B</option>
          </select>
          <i class="bi bi-chevron-down"></i>
        </div>

        <div class="mb-2">
          <label class="form-label fw-semibold">Lý do khám</label>
          <textarea rows="5" class="form-control rounded-xl" placeholder="Mô tả cập nhật triệu chứng..."></textarea>
        </div>
      </div>
    </div>

    <!-- Right: time -->
    <div class="col-lg-5">
      <div class="panel">
        <label class="form-label fw-semibold">Thời gian khám<span class="text-danger">*</span></label>
        <div class="d-flex flex-wrap gap-2">
          <button type="button" class="slot active">
            <div class="date">22/09</div><div class="dow">Thứ 2</div>
          </button>
          <button type="button" class="slot">
            <div class="date">23/09</div><div class="dow">Thứ 3</div>
          </button
