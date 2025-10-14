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
    <style>
        :root {
            --bg: #eaf4f3;
            --card-radius: 12px;
            --shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        body {
            background-color: var(--bg) !important;
            font-family: Arial, sans-serif;
            padding-top: 60px;
        }
        .content {
            margin-left: 230px;
            /*margin-top: 20px;*/
            padding: 20px;
        }
        .card {
            border-radius: var(--card-radius);
            box-shadow: var(--shadow);
            border: 0;
        }
        .table td, .table th {
            vertical-align: middle;
            text-align: center;
        }
        .table thead th {
            background: #f1f3f5;
        }
        .action-buttons {
            display: inline-flex;
            gap: 8px;
            justify-content: center;
        }
        .toolbar .form-control {
            min-width: 280px;
        }
        .toolbar .btn {
            white-space: nowrap;
        }
        .cell-text {
            max-width: 520px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        @media (max-width: 768px) {
            .content {
                margin-left: 0;
            }
            .toolbar .form-control {
                min-width: 180px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/Include/header.jsp" />
    <jsp:include page="/WEB-INF/Include/sidebar.jsp" />

    <div class="content">
        <div class="card">
            <div class="card-header fw-bold d-flex justify-content-between align-items-center">
                Quản lý Hóa đơn
            </div>
            <div class="card-body">
                <!-- 🔎 Thanh công cụ tìm kiếm -->
                <form class="toolbar d-flex align-items-center gap-2 mb-3" action="manageInvoice" method="get">
                    <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm hóa đơn..."
                           value="<%= (keyword != null) ? keyword : "" %>">
                    <button class="btn btn-outline-primary" type="submit">🔍 Tìm</button>
                    <a href="manageInvoice" class="btn btn-outline-secondary">✖ Reset</a>
                </form>

                <!-- 🧾 Bảng hóa đơn -->
                <div class="table-responsive">
                    <table class="table table-bordered table-hover mb-0">
                        <thead class="table-secondary">
                            <tr>
                                <th style="width:110px;">Mã</th>
                                <th style="width:260px;">Bệnh nhân</th>
                                <th>Ngày lập</th>
                                <th style="width:160px;">Tổng tiền</th>
                                <th style="width:160px;">Trạng thái</th>
                                <th style="width:160px;">Thao tác</th>
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
                                        <!-- 👁 Xem hóa đơn (gọi servlet rồi mở modal tự động) -->
                                        <a href="manageInvoice?action=detail&invoiceId=<%= inv.getInvoiceId() %>"
                                           class="btn btn-info btn-sm">
                                            👁 Xem
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <% } } else { %>
                            <tr>
                                <td colspan="6" class="text-center text-muted">Không có dữ liệu</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- 🧾 Modal Chi tiết Hóa đơn -->
    <div class="modal fade" id="invoiceDetailModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Chi tiết Hóa đơn</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <% if (selectedInvoice != null) { %>
                        <p><b>Mã Hóa đơn:</b> HD<%= selectedInvoice.getInvoiceId() %></p>
                        <p><b>Bệnh nhân:</b> <%= selectedInvoice.getPatientName() %></p>
                        <p><b>Ngày lập:</b> <%= selectedInvoice.getIssuedAt() %></p>
                        <p><b>Tổng tiền:</b> <%= selectedInvoice.getTotalAmount() %> VND</p>

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
                                   class="btn btn-outline-success w-100"
                                   target="_blank">
                                    🖨 In / Lưu PDF (JSP)
                                </a>
                            </div>
                        <% } %>
                        <hr>
                    <% } %>

                    <% if (details != null && !details.isEmpty()) { %>
                        <ul class="list-unstyled">
                            <% for (InvoiceDetail d : details) { %>
                                <li>
                                    <span class="badge bg-<%= d.getType().equals("service") ? "primary" : "warning text-dark" %>">
                                        <%= d.getType().equals("service") ? "Dịch vụ" : "Thuốc" %>
                                    </span>
                                    <b><%= d.getName() %></b> (SL: <%= d.getQuantity() %>)

                                    <% if ("service".equals(d.getType())) { %>
                                        - <span class="text-success"><%= d.getPrice() %> VND</span>
                                    <% } %>

                                    <% if ("medicine".equals(d.getType())) { %>
                                        <br>
                                        <small class="text-muted">
                                            💊 Liều dùng: <%= d.getDosage() %>, Thời gian: <%= d.getDuration() %>
                                        </small>
                                    <% } %>
                                </li>
                            <% } %>
                        </ul>
                    <% } else { %>
                        <p class="text-muted text-center mt-3">Chọn hóa đơn để xem chi tiết</p>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <!-- 💳 Modal xác nhận thanh toán -->
    <div class="modal fade" id="confirmPayModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
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
                        <p class="text-center text-muted mb-0">
                            Xác nhận thanh toán cho hóa đơn này?
                        </p>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-success" onclick="submitPayment()">Xác nhận</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 💳 Mở modal xác nhận thanh toán
        function confirmPayment(invoiceId) {
            document.getElementById('invoiceIdInput').value = invoiceId;
            const modal = new bootstrap.Modal(document.getElementById('confirmPayModal'));
            modal.show();
        }

        function submitPayment() {
            const method = document.getElementById('paymentMethod').value;
            if (!method) {
                alert("Vui lòng chọn phương thức thanh toán!");
                return;
            }
            document.getElementById('paymentForm').submit();
        }

        // 🧾 Tự động mở modal chi tiết nếu servlet đã trả về selectedInvoice
        <% if (selectedInvoice != null) { %>
            const detailModal = new bootstrap.Modal(document.getElementById('invoiceDetailModal'));
            detailModal.show();
        <% } %>
    </script>
</body>
</html>
