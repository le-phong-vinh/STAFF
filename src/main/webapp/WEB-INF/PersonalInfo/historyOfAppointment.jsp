<%-- 
    Document   : historyOfAppointment
    Created on : Oct 1, 2025, 12:43:30 PM
    Author     : Ho Gia Bao - CE191304
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>FMec Hospital – Lịch sử đặt khám</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

  

  <style>
    :root{
      --brand-bg:#d9f0f5;
      --chip:#cfeefe;
      --panel:#eaf8ff;
    }
    body{ background:#f9f9f9; }
    .navbar{ background:var(--brand-bg); }
    .nav-tabs-like .nav-link{
      background:#f2fbfd; border:1px solid #cfe7ee; border-radius:.75rem; padding:.5rem 1rem; margin-right:.5rem;
    }
    .nav-tabs-like .nav-link.active{ background:#fff; box-shadow:0 1px 3px rgba(0,0,0,.08); }

    .page-title{ font-weight:800; text-align:center; margin:24px 0; }

    .appt-card{
      background:var(--panel);
      border-radius:1.2rem;
      padding:1rem 1rem 1.1rem;
      border:1px solid #cfe7ee;
    }
    .appt-title{
      font-weight:800; font-size:1.1rem;
      background:#bfe7ff; color:#0b4453;
      padding:.35rem .75rem; border-radius:.75rem;
      display:inline-block;
    }
    .status-badge{
      font-size:.9rem; background:#fff; border-radius:999px; padding:.25rem .65rem; border:1px solid #e7eef2;
      display:inline-flex; align-items:center; gap:.4rem;
    }
    .dot{ width:.6rem; height:.6rem; border-radius:50%; display:inline-block; }
    .dot.success{ background:#22c55e; }
    .dot.cancel{ background:#ef4444; }
    .dot.pending{ background:#f59e0b; }

    .btn-chip{
      border-radius:999px; padding:.4rem .9rem; font-weight:600;
    }

    footer{ background:var(--brand-bg); padding:14px 0; margin-top:28px; }
    .foot-sub{ background:#eef6f8; padding:8px 0; font-size:.85rem; color:#6b7280; }
  </style>
</head>
<body>


<jsp:include page="/Include/header.jsp" />

<div class="container my-4">
  <h3 class="page-title">Lịch sử đặt khám</h3>

  <style>
    /* bảng */
    .table-card {
      background:#fff; border:1px solid #e5e7eb; border-radius:12px; overflow:hidden;
      box-shadow:0 4px 14px rgba(0,0,0,.05);
    }
    .table thead th{
      background:#f8fafc; font-weight:700; color:#111827; border-bottom:1px solid #e5e7eb;
    }
    .table tbody tr:nth-child(even){ background:#fafafa; }
    .table td, .table th { vertical-align: middle; }

    /* status chip */
    .status-badge{
      font-size:.875rem; background:#fff; border-radius:999px; padding:.25rem .65rem;
      border:1px solid #e5e7eb; display:inline-flex; align-items:center; gap:.45rem; font-weight:600;
    }
    .dot{ width:.55rem; height:.55rem; border-radius:50%; display:inline-block; }
    .dot.success{ background:#22c55e; }
    .dot.cancel{ background:#ef4444; }
    .dot.pending{ background:#f59e0b; }

    /* action buttons giống ảnh */
    .btn-icon{
      width:36px; height:32px; display:inline-flex; align-items:center; justify-content:center;
      border:none; border-radius:.5rem; font-size:1rem;
    }
    .btn-view{ background:#0dcaf0; color:#0b3b47; }     /* cyan */
    .btn-edit{ background:#f0ad00; color:#1f1f1f; }     /* yellow */
    .btn-del { background:#dc3545; color:#fff; }        /* red  */
    .btn-icon:hover{ filter:brightness(.95); }
  </style>

  <div class="table-responsive table-card">
    <table class="table table-hover align-middle mb-0">
      <thead>
        <tr>
          <th style="width:60px">#</th>
          <th>Ngày đặt</th>
          <th>Khoa</th>
          <th>Bác sĩ</th>
          <th>Lý do khám</th>
          <th style="width:160px">Trạng thái</th>
          <th style="width:160px" class="text-center">Actions</th>
        </tr>
      </thead>
      <tbody>
        <!-- Row 1: Done + rate -->
        <tr>
          <td>1</td>
          <td>27/02/2025</td>
          <td>Nội tổng quát</td>
          <td>BS. Trương Ngọc Hải</td>
          <td>Khám sức khỏe định kỳ</td>
          <td>
            <span class="status-badge"><span class="dot success"></span> Đặt thành công</span>
          </td>
          <td class="text-center">
            <a href="<%=request.getContextPath()%>/appointment/detail?id=1" class="btn-icon btn-view" title="Xem"><i class="bi bi-eye-fill"></i></a>
            <a href="<%=request.getContextPath()%>/appointment/edit?id=1"   class="btn-icon btn-edit" title="Sửa"><i class="bi bi-pencil-square"></i></a>
            <button type="button" class="btn-icon btn-del" title="Xóa"><i class="bi bi-trash-fill"></i></button>
          </td>
        </tr>

        <!-- Row 2: Done + detail link + disable rate (giữ logic bằng tooltip) -->
        <tr>
          <td>2</td>
          <td>21/02/2025</td>
          <td>Tim mạch</td>
          <td>BS. Nguyễn Văn A</td>
          <td>Đau ngực nhẹ</td>
          <td>
            <span class="status-badge"><span class="dot success"></span> Đặt thành công</span>
          </td>
          <td class="text-center">
            <a href="#" class="btn-icon btn-view" title="Xem chi tiết bệnh"><i class="bi bi-eye-fill"></i></a>
            <a href="<%=request.getContextPath()%>/appointment/edit?id=2" class="btn-icon btn-edit" title="Sửa"><i class="bi bi-pencil-square"></i></a>
            <button type="button" class="btn-icon btn-del" title="Xóa"><i class="bi bi-trash-fill"></i></button>
          </td>
        </tr>

        <!-- Row 3: Canceled -->
        <tr>
          <td>3</td>
          <td>18/02/2025</td>
          <td>Da liễu</td>
          <td>BS. Phạm Thị B</td>
          <td>Dị ứng thời tiết</td>
          <td>
            <span class="status-badge"><span class="dot cancel"></span> Đã hủy</span>
          </td>
          <td class="text-center">
            <a href="#" class="btn-icon btn-view" title="Xem"><i class="bi bi-eye-fill"></i></a>
            <a href="<%=request.getContextPath()%>/appointment/rebook?id=3" class="btn-icon btn-edit" title="Đặt lại"><i class="bi bi-arrow-repeat"></i></a>
            <button type="button" class="btn-icon btn-del" title="Xóa"><i class="bi bi-trash-fill"></i></button>
          </td>
        </tr>

        <!-- Row 4: Pending + Update/Cancel -->
        <tr>
          <td>4</td>
          <td>27/02/2025</td>
          <td>Răng hàm mặt</td>
          <td>BS. Lê C</td>
          <td>Nhổ răng khôn</td>
          <td>
            <span class="status-badge"><span class="dot pending"></span> Đang chờ duyệt</span>
          </td>
          <td class="text-center">
            <a href="<%=request.getContextPath()%>/updateBooking.jsp" class="btn-icon btn-edit" title="Cập nhật"><i class="bi bi-pencil-square"></i></a>
            <button type="button" class="btn-icon btn-del" title="Hủy đặt hẹn"><i class="bi bi-x-circle-fill"></i></button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
