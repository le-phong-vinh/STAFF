<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Invoice, model.InvoiceDetail, java.util.*" %>
<%
    Invoice invoice = (Invoice) request.getAttribute("invoice");
    List<InvoiceDetail> details = (List<InvoiceDetail>) request.getAttribute("details");

    // Tách danh sách thành 2 nhóm hehehe
    List<InvoiceDetail> services = new ArrayList<>();
    List<InvoiceDetail> medicines = new ArrayList<>();

    if (details != null) {
        for (InvoiceDetail d : details) {
            if ("service".equals(d.getType())) {
                services.add(d);
            } else if ("medicine".equals(d.getType())) {
                medicines.add(d);
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hóa đơn - HD<%= invoice.getInvoiceId() %></title>
    <style>
        @page { size: A5; margin: 15mm; }

        body {
            font-family: 'DejaVu Sans', Arial, sans-serif;
            margin: 0 auto;
            max-width: 800px;
            background: #fff;
            color: #000;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        h2 {
            margin-top: 40px;
            text-align: center;
            text-transform: uppercase;
            margin-bottom: 30px;
        }

        .clinic-header {
            text-align: center;
            margin-bottom: 20px;
        }

        .clinic-header img {
            width: 70px;
            height: auto;
            vertical-align: middle;
        }

        .clinic-header h3 {
            display: inline-block;
            margin-left: 10px;
            color: #004a7c;
        }

        .info {
            margin-top: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            padding: 10px 15px;
            background: #f9f9f9;
        }

        .info p {
            margin: 5px 0;
            line-height: 1.4;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            font-size: 14px;
        }

        th, td {
            border: 1px solid #000;
            padding: 8px;
            text-align: center;
        }

        th {
            background: #e9ecef;
        }

        .section-title {
            margin-top: 30px;
            font-weight: bold;
            text-transform: uppercase;
            color: #004a7c;
            border-bottom: 2px solid #004a7c;
            padding-bottom: 5px;
        }

        .footer {
            margin-top: 30px;
            text-align: center;
            font-style: italic;
        }

        .signatures {
            margin-top: 40px;
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            text-align: center;
        }

        .signatures div {
            width: 45%;
        }

        @media print {
            .no-print { display: none; }
        }

        .no-print {
            text-align: center;
            margin-top: 20px;
        }

        .no-print button {
            padding: 8px 20px;
            border: none;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }

        .no-print button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="clinic-header">
        <img src="${pageContext.request.contextPath}/img/logo.png" alt="Logo">
        <h3>PHÒNG KHÁM ĐA KHOA FMEC</h3>
        <p>Địa chỉ: 600 Nguyễn Văn Cừ, P. An Bình, TP. Cần Thơ — Điện thoại: (012) 1234 5678</p>
    </div>

    <h2>HÓA ĐƠN THANH TOÁN</h2>

    <div class="info">
        <p><b>Mã hóa đơn:</b> HD<%= invoice.getInvoiceId() %></p>
        <p><b>Bệnh nhân:</b> <%= invoice.getPatientName() %></p>
        <p><b>Ngày lập:</b> <%= invoice.getIssuedAt() %></p>
        <p><b>Tổng tiền:</b> <%= String.format("%,.0f", invoice.getTotalAmount()) %> VND</p>
        <p><b>Phương thức thanh toán:</b> 
            <%= invoice.getPaymentMethod() != null ? invoice.getPaymentMethod() : "—" %>
        </p>
        <p><b>Trạng thái:</b> <span style="color:green;">Đã thanh toán</span></p>
    </div>

    <!-- BẢNG DỊCH VỤ -->
    <% if (!services.isEmpty()) { %>
        <div class="section-title">DỊCH VỤ</div>
        <table>
            <thead>
                <tr>
                    <th>Tên dịch vụ</th>
                    <th>Số lượng</th>
                    <th>Đơn giá (VND)</th>
                    <th>Thành tiền (VND)</th>
                </tr>
            </thead>
            <tbody>
                <% for (InvoiceDetail s : services) { %>
                <tr>
                    <td><%= s.getName() %></td>
                    <td><%= s.getQuantity() %></td>
                    <td><%= String.format("%,.0f", s.getPrice()) %></td>
                    <td><%= String.format("%,.0f", s.getPrice() * s.getQuantity()) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>

    <!-- BẢNG THUỐC -->
    <% if (!medicines.isEmpty()) { %>
        <div class="section-title">ĐƠN THUỐC</div>
        <table>
            <thead>
                <tr>
                    <th>Tên thuốc</th>
                    <th>Số lượng</th>
                    <th>Liều dùng</th>
                    <th>Thời gian</th>
                </tr>
            </thead>
            <tbody>
                <% for (InvoiceDetail m : medicines) { %>
                <tr>
                    <td><%= m.getName() %></td>
                    <td><%= m.getQuantity() %></td>
                    <td><%= m.getDosage() %></td>
                    <td><%= m.getDuration() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>

    <div class="signatures">
        <div>
            <b>Người lập hóa đơn</b><br>
            <i>(Ký tên)</i><br><br><br>
            ....................................
        </div>
        <div>
            <b>Khách hàng</b><br>
            <i>(Ký tên)</i><br><br><br>
            ....................................
        </div>
    </div>

    <div class="footer">
        Cảm ơn quý khách đã sử dụng dịch vụ của chúng tôi!<br>
        Chúc quý khách sức khỏe & an lành 💚
    </div>

    <div class="no-print">
        <button onclick="window.print()">🖨 In / Lưu PDF</button>
    </div>
</body>
</html>
