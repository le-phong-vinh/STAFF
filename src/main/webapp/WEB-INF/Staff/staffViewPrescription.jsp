<%@page import="java.util.*, model.Invoice, model.InvoiceDetail"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    List<Invoice> list = (List<Invoice>) request.getAttribute("list");
    Invoice selectedInvoice = (Invoice) request.getAttribute("selectedInvoice");
    List<InvoiceDetail> details = (List<InvoiceDetail>) request.getAttribute("details");
    String keyword = request.getParameter("keyword");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Hóa đơn</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        :root {
            --bg: #f5f9f8;
            --card-radius: 14px;
            --shadow: 0 4px 15px rgba(0,0,0,0.08);
        }
        body {
            background-color: var(--bg) !important;
            font-family: "Segoe UI", Arial, sans-serif;
            padding-top: 60px;
        }
        .content {
            margin-left: 230px;
            padding: 20px;
            animation: fadeIn .4s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        .card {
            border-radius: var(--card-radius);
            box-shadow: var(--shadow);
            border: 0;
            background: #fff;
        }
        .card-header {
            background: #fff;
            color: #222;
            font-weight: 600;
            font-size: 1.1rem;
            padding: 12px 16px;
            border-bottom: 1px solid #eee;
        }
        /* Toolbar nhỏ gọn */
        .toolbar .form-control {
            min-width: 250px;
            border-radius: 30px;
            padding-left: 15px;
            font-size: 0.9rem;
            height: 36px;
            transition: box-shadow .2s ease;
        }
        .toolbar .form-control:focus {
            box-shadow: 0 0 0 .2rem rgba(13,110,253,.25);
        }
        .toolbar .btn {
            border-radius: 20px;
            padding: 4px 10px;
            font-size: .85rem;
            display: inline-flex;
            align-items: center;
            gap: 4px;
            transition: transform .2s ease, background-color .2s ease;
        }
        .toolbar .btn:hover { transform: translateY(-1px); }
        /* Table */
        .table thead th {
            background: #f8f9fa;
            font-weight: 600;
            font-size: 0.95rem;
        }
        .table td, .table th {
            vertical-align: middle;
            text-align: center;
            font-size: .95rem;
            transition: background-color .25s ease;
        }
        .table-hover tbody tr:hover { background-color: #eef6ff; }
        .cell-text {
            max-width: 520px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .action-buttons .btn {
            padding: 2px 8px;
            font-size: .8rem;
        }
        /* Modal animation */
        .modal.fade .modal-dialog {
            transform: scale(.9);
            opacity: 0;
            transition: all .25s ease;
        }
        .modal.fade.show .modal-dialog {
            transform: scale(1);
            opacity: 1;
        }
        .modal-content {
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .modal-header {
            background: #fff;
            border-bottom: 1px solid #eee;
            color: #222;
            font-weight: 600;
        }
        @media (max-width: 768px) {
            .content { margin-left: 0; }
            .toolbar .form-control { min-width: 180px; }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/Include/header.jsp" />
    <jsp:include page="/WEB-INF/Include/sidebar.jsp" />

    <div class="content">
        <div class="card">
            <div class="card-header">Quản lý Hóa đơn</div>
            <div class="card-body">
                <!-- Toolbar -->
                <form class="toolbar d-flex align-items-center gap-2 mb-3" action="manageInvoice" method="get">
                    <input type="text" name="keyword" class="form-control" placeholder="🔍 Tìm kiếm hóa đơn..."
                           value="<%= (keyword != null) ? keyword : "" %>">
                    <button class="btn btn-primary" type="submit" title="Tìm"><i class="bi bi-search"></i></button>
                    <a href="manageInvoice" class="btn btn-outline-secondary" title="Reset"><i class="bi bi-x-lg"></i></a>
                </form>

                <!-- Bảng hóa đơn -->
                <div class="table-responsive">
                    <table class="table table-bordered table-hover mb-0">
                        <thead class="table-secondary">
                            <tr>
                                <th style="width:110px;">Mã</th>
                                <th style="width:260px;">Bệnh nhân</th>
                                <th>Ngày lập</th>
                                <th style="width:160px;">Tổng tiền</th>
                                <th style="width:160px;">Trạng thái</th>
                                <th style="width:140px;">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% if (list != null && !list.isEmpty()) {
                               for (Invoice inv : list) { %>
                            <tr>
                                <td>HD<%= inv.getInvoiceId() %></td>
                                <td class="cell-text"><%= inv.getPatientName() %></td>
                                <td><%= inv.getIssuedAt() %></td>
                                <td class="text-end"><%= String.format("%,.0f", inv.getTotalAmount()) %> VND</td>
                                <td class="<%= inv.isStatus() ? "text-success fw-bold" : "text-danger fw-bold" %>">
                                    <%= inv.isStatus() ? "Đã thanh toán" : "Chưa thanh toán" %>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <!-- Gọi servlet để lấy chi tiết; modal sẽ tự mở nếu có selectedInvoice -->
                                        <a href="manageInvoice?action=detail&invoiceId=<%= inv.getInvoiceId() %>"
                                           class="btn btn-info btn-sm" title="Xem">👁</a>
                                    </div>
                                </td>
                            </tr>
                        <% } } else { %>
                            <tr><td colspan="6" class="text-center text-muted">Không có dữ liệu</td></tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Chi tiết Hóa đơn -->
    <div class="modal fade" id="invoiceDetailModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chi tiết Hóa đơn</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <% if (selectedInvoice != null) { %>
                        <p><b>Mã Hóa đơn:</b> HD<%= selectedInvoice.getInvoiceId() %></p>
                        <p><b>Bệnh nhân:</b> <%= selectedInvoice.getPatientName() %></p>
                        <p><b>Ngày lập:</b> <%= selectedInvoice.getIssuedAt() %></p>
                        <p><b>Tổng tiền:</b> <%= String.format("%,.0f", selectedInvoice.getTotalAmount()) %> VND</p>
                        <p>
                            <b>Trạng thái:</b>
                            <span class="<%= selectedInvoice.isStatus() ? "text-success" : "text-danger" %> fw-bold">
                                <%= selectedInvoice.isStatus() ? "Đã thanh toán" : "Chưa thanh toán" %>
                            </span>
                        </p>
                        <% if (selectedInvoice.isStatus() && selectedInvoice.getPaymentMethod() != null) { %>
                            <p><b>Phương thức thanh toán:</b> <%= selectedInvoice.getPaymentMethod() %></p>
                        <% } %>

                        <% if (!selectedInvoice.isStatus()) { %>
                            <div class="text-center mb-3">
                                <button type="button" class="btn btn-success w-100"
                                        onclick="confirmPayment(<%= selectedInvoice.getInvoiceId() %>)">
                                    ✔ Thanh toán hóa đơn này
                                </button>
                            </div>
                        <% } else { %>
                            <div class="text-center mb-3">
                                <a href="manageInvoice?action=print&invoiceId=<%= selectedInvoice.getInvoiceId() %>"
                                   class="btn btn-outline-success w-100" target="_blank">
                                    🖨 In / Lưu PDF (JSP)
                                </a>
                            </div>
                        <% } %>
                        <hr>
                    <% } %>

                    <% if (details != null && !details.isEmpty()) { %>
                        <ul class="list-unstyled">
                            <% for (InvoiceDetail d : details) { %>
                                <li class="mb-2">
                                    <span class="badge bg-<%= d.getType().equals("service") ? "primary" : "warning text-dark" %>">
                                        <%= d.getType().equals("service") ? "Dịch vụ" : "Thuốc" %>
                                    </span>
                                    <b><%= d.getName() %></b> (SL: <%= d.getQuantity() %>)
                                    <% if ("service".equals(d.getType())) { %>
                                        - <span class="text-success"><%= String.format("%,.0f", d.getPrice()) %> VND</span>
                                    <% } %>
                                    <% if ("medicine".equals(d.getType())) { %>
                                        <br><small class="text-muted">
                                            💊 Liều dùng: <%= d.getDosage() %>, Thời gian: <%= d.getDuration() %>
                                        </small>
                                    <% } %>
                                </li>
                            <% } %>
                        </ul>
                    <% } else if (selectedInvoice != null) { %>
                        <p class="text-muted text-center mt-3">Hóa đơn này chưa có chi tiết.</p>
                    <% } else { %>
                        <p class="text-muted text-center mt-3">Chọn hóa đơn để xem chi tiết</p>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal xác nhận thanh toán -->
    <div class="modal fade" id="confirmPayModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận thanh toán</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="paymentForm" action="manageInvoice" method="post">
                        <input type="hidden" name="action" value="pay">
                        <input type="hidden" name="invoiceId" id="invoiceIdInput">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Phương thức thanh toán:</label>
                            <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                                <option value="" disabled selected>-- Chọn phương thức --</option>
                                <option value="Tiền mặt">💵 Tiền mặt</option>
                                <option value="Chuyển khoản">🏦 Chuyển khoản</option>
                                <option value="Thẻ">💳 Thẻ</option>
                            </select>
                        </div>
                        <p class="text-center text-muted mb-0">Xác nhận thanh toán cho hóa đơn này?</p>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-success btn-sm" onclick="submitPayment()">Xác nhận</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Mở modal thanh toán
        function confirmPayment(invoiceId) {
            document.getElementById('invoiceIdInput').value = invoiceId;
            const modal = new bootstrap.Modal(document.getElementById('confirmPayModal'));
            modal.show();
        }
        function submitPayment() {
            const method = document.getElementById('paymentMethod').value;
            if (!method) { alert("Vui lòng chọn phương thức thanh toán!"); return; }
            document.getElementById('paymentForm').submit();
        }
        // Tự động mở modal chi tiết nếu đã có selectedInvoice từ servlet
        <% if (selectedInvoice != null) { %>
            const detailModal = new bootstrap.Modal(document.getElementById('invoiceDetailModal'));
            detailModal.show();
        <% } %>
    </script>
</body>
</html>
