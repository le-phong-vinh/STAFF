<%@page import="java.util.*, model.Invoice, model.InvoiceDetail"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    List<Invoice> list = (List<Invoice>) request.getAttribute("list");
    List<InvoiceDetail> details = (List<InvoiceDetail>) request.getAttribute("details");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý hóa đơn</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            /* Nền & font đồng bộ */
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #eaf4f3 !important;
                padding-top: 60px; /* giống trang Service */
            }

            /* KHÔNG cần custom .sidebar ở đây vì đã include sidebar.jsp
               => Nếu bạn còn đoạn CSS .sidebar cũ, hãy xoá để tránh xung đột. */

            /* Khu vực nội dung giống trang Service */
            .content {
                margin-left: 230px;
                margin-top: 20px;
                padding: 20px;
            }

            /* Card đồng bộ góc bo + bóng */
            .card {
                border-radius: 8px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
                border: none;
                background: #fff;
            }

            /* Header card nhẹ nhàng */
            .card-header {
                font-weight: 700;
                font-size: 1.05rem;
                background-color: #f6f8fa;
                color: #1d2f3c;
                border-bottom: 2px solid #d0dee0;
            }

            /* Bảng: căn giữa & giữa dòng */
            .table td, .table th {
                vertical-align: middle;
                text-align: center;
            }

            /* Cụm nút thao tác không xuống dòng + giãn cách nhỏ */
            .action-buttons,
            .table .actions {
                display: flex;
                gap: 6px;
                white-space: nowrap;
                justify-content: center;
            }

            /* Cột mô tả/ghi chú tự xuống dòng (nếu cần) */
            .table td:nth-child(3) {
                white-space: normal;
                word-wrap: break-word;
                max-width: 300px;
            }

            /* Form tìm kiếm đẹp và gọn như trang Service */
            form.d-flex input[type="text"] {
                flex: 1;
            }
            form.d-flex button,
            form.d-flex a {
                white-space: nowrap;
            }

            /* Khu chi tiết hóa đơn: style đồng bộ, gọn gàng */
            .list-unstyled {
                margin: 0;
                padding: 0;
            }
            .list-unstyled li {
                background: #ffffff;
                border-radius: 10px;
                margin-bottom: 10px;
                padding: 12px 14px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.05);
                transition: all 0.2s ease-in-out;
            }
            .list-unstyled li:hover {
                transform: translateY(-2px);
                box-shadow: 0 3px 8px rgba(0,0,0,0.12);
            }

            .badge {
                font-size: 0.8rem;
                padding: 6px 10px;
                border-radius: 8px;
            }
            .list-unstyled b {
                font-size: 1rem;
                color: #1a3b5d;
            }
            .list-unstyled small {
                display: inline-block;
                margin-top: 4px;
                color: #555;
                line-height: 1.4;
            }

            /* Màu badge thống nhất */
            .badge.bg-primary {
                background-color: #0d6efd !important;
            } /* Dịch vụ */
            .badge.bg-warning.text-dark {
                background-color: #ffdd57 !important;
                color: #333 !important;
            } /* Thuốc */

            /* Tổng thể nút: bo tròn nhẹ, cảm giác Bootstrap 5 */
            .btn {
                border-radius: .5rem;
            }
        </style>

    </head>
    <body>
        <jsp:include page="/WEB-INF/Include/header.jsp" />
        <jsp:include page="/WEB-INF/Include/sidebar.jsp" />

        <div class="content">
            <div class="row g-3">
                <!-- Danh sách hóa đơn -->
                <div class="col-lg-8 col-md-7">
                    <div class="card">
                        <div class="card-header fw-bold">📑 Danh sách hóa đơn</div>
                        <div class="card-body">
                            <!-- Form tìm kiếm -->
                            <form class="d-flex mb-3" action="manageInvoice" method="get">
                                <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm hóa đơn...">
                                <button class="btn btn-outline-primary ms-2">🔍 Tìm</button>
                                <a href="manageInvoice" class="btn btn-outline-secondary ms-2">✖ Reset</a>
                            </form>

                            <div class="table-responsive" style="max-height:500px; overflow-y:auto;">
                                <table class="table table-bordered table-hover">
                                    <thead class="table-secondary">
                                        <tr>
                                            <th>Mã Hóa đơn</th>
                                            <th>Bệnh nhân</th>
                                            <th>Ngày lập</th>
                                            <th>Tổng tiền</th>
                                            <th>Trạng thái</th>
                                            <th>Chi tiết</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (list != null && !list.isEmpty()) {
                                                for (Invoice inv : list) {%>
                                        <tr>
                                            <td>HD<%= inv.getInvoiceId()%></td>
                                            <td><%= inv.getPatientName()%></td>
                                            <td><%= inv.getIssuedAt()%></td>
                                            <td><%= inv.getTotalAmount()%> VND</td>
                                            <td class="<%= inv.isStatus() ? "text-success" : "text-danger"%> fw-bold">
                                                <%= inv.isStatus() ? "Đã thanh toán" : "Chưa thanh toán"%>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="manageInvoice?action=detail&invoiceId=<%= inv.getInvoiceId()%>"
                                                       class="btn btn-sm btn-info">👁 Xem</a>



                                                </div>
                                            </td>
                                        </tr>
                                        <% }
                                        } else { %>
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

                <!-- Chi tiết hóa đơn -->
                <div class="col-lg-4 col-md-5">
                    <div class="card">
                        <div class="card-header fw-bold">📋 Chi tiết Hóa đơn</div>
                        <div class="card-body">
                            <%
                                Invoice selectedInvoice = (Invoice) request.getAttribute("selectedInvoice");
                                if (selectedInvoice != null) {
                            %>
                            <p><b>Mã Hóa đơn:</b> HD<%= selectedInvoice.getInvoiceId()%></p>
                            <p><b>Bệnh nhân:</b> <%= selectedInvoice.getPatientName()%></p>
                            <p><b>Ngày lập:</b> <%= selectedInvoice.getIssuedAt()%></p>
                            <p><b>Tổng tiền:</b> <%= selectedInvoice.getTotalAmount()%> VND</p>

                            <p>
                                <b>Trạng thái:</b>
                                <span class="<%= selectedInvoice.isStatus() ? "text-success" : "text-danger"%> fw-bold">
                                    <%= selectedInvoice.isStatus() ? "Đã thanh toán" : "Chưa thanh toán"%>
                                </span>
                            </p>
                            <% if (selectedInvoice.isStatus() && selectedInvoice.getPaymentMethod() != null) {%>
                            <p><b>Phương thức thanh toán:</b> <%= selectedInvoice.getPaymentMethod()%></p>
                            <% } %>

                            <% if (!selectedInvoice.isStatus()) {%>
                            <!-- Nút thanh toán -->
                            <div class="text-center mb-3">
                                <button type="button" class="btn btn-success w-100"
                                        onclick="confirmPayment(<%= selectedInvoice.getInvoiceId()%>)">
                                    ✔ Thanh toán hóa đơn này
                                </button>
                            </div>
                            <% } else {%>
                            <!-- Nút mở trang in hóa đơn JSP -->
                            <div class="text-center mb-3">
                                <a href="manageInvoice?action=print&invoiceId=<%= selectedInvoice.getInvoiceId()%>"
                                   class="btn btn-outline-success w-100" target="_blank">
                                    🖨 In / Lưu PDF (JSP)
                                </a>
                            </div>
                            <% } %>



                            <hr>
                            <% } %>

                            <% if (details != null && !details.isEmpty()) { %>
                            <ul class="list-unstyled">
                                <% for (InvoiceDetail d : details) {%>
                                <li>
                                    <span class="badge bg-<%= d.getType().equals("service") ? "primary" : "warning text-dark"%>">
                                        <%= d.getType().equals("service") ? "Dịch vụ" : "Thuốc"%>
                                    </span>
                                    <b><%= d.getName()%></b>
                                    (SL: <%= d.getQuantity()%>)

                                    <% if ("service".equals(d.getType())) {%>
                                    - <span class="text-success"><%= d.getPrice()%> VND</span>
                                    <% } %>

                                    <% if ("medicine".equals(d.getType())) {%>
                                    <br>
                                    <small class="text-muted">
                                        💊 Liều dùng: <%= d.getDosage()%>,
                                        Thời gian: <%= d.getDuration()%>
                                    </small>
                                    <% } %>
                                </li>
                                <% } %>
                            </ul>
                            <% } else { %>
                            <p class="text-muted text-center mt-3">Chọn hóa đơn để xem chi tiết</p>
                            <% }%>
                        </div>

                    </div>
                </div>

            </div>
        </div>

        <!-- Modal xác nhận thanh toán -->
        <div class="modal fade" id="confirmPayModal" tabindex="-1">
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
                                <label for="paymentMethod" class="form-label fw-bold">Phương thức thanh toán:</label>
                                <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                                    <option value="" disabled selected>-- Chọn phương thức --</option>
                                    <option value="Tiền mặt">💵 Tiền mặt</option>
                                    <option value="Chuyển khoản">🏦 Chuyển khoản</option>
                                    <option value="Thẻ">💳 Thẻ</option>
                                </select>
                            </div>

                            <p class="mt-3 mb-0 text-muted text-center">
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

        <script>
            // Hiển thị modal và gán invoiceId
            function confirmPayment(invoiceId) {
                document.getElementById('invoiceIdInput').value = invoiceId;
                const modal = new bootstrap.Modal(document.getElementById('confirmPayModal'));
                modal.show();
            }

            // Gửi form xác nhận
            function submitPayment() {
                const method = document.getElementById('paymentMethod').value;
                if (!method) {
                    alert("Vui lòng chọn phương thức thanh toán!");
                    return;
                }
                document.getElementById('paymentForm').submit();
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


    </body>
</html>
