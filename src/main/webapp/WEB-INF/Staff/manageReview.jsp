<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Review, java.text.SimpleDateFormat" %>
<%
    List<Review> reviewList = (List<Review>) request.getAttribute("reviewList");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý đánh giá</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #eaf4f3 !important;
                font-family: Arial, sans-serif;
                padding-top: 60px;
            }
            .content {
                margin-left: 230px;
                margin-top: 20px;
                padding: 20px;
            }
            .card {
                border-radius: 8px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            }
            .table td, .table th {
                vertical-align: middle;
                text-align: center;
            }
            .action-buttons {
                display: flex;
                gap: 6px;
                justify-content: center;
            }
            form.d-flex input[type="text"] {
                flex: 1;
            }
            form.d-flex button, form.d-flex a {
                white-space: nowrap;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/Include/header.jsp" />
        <jsp:include page="/WEB-INF/Include/sidebar.jsp" />

        <div class="content">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex mb-2">
                        <input type="text" class="form-control" placeholder="Tìm kiếm đánh giá..." id="searchInput">
                        <button class="btn btn-outline-secondary ms-1" onclick="filterTable()">🔍</button>
                    </div>

                    <div class="table-responsive" style="max-height: 600px; overflow-y: auto;">
                        <table class="table table-bordered table-hover" id="reviewTable">
                            <thead class="table-secondary text-center">
                                <tr>
                                    <th>ID</th>
                                    <th>Trạng thái</th>
                                    <th>Bệnh nhân</th>
                                    <th>Bác sĩ</th>
                                    <th>Ngày review</th>
                                    <th>Ngày hẹn</th>
                                    <th>Ngày khám & Ca</th>
                                    <th>Phòng</th>
                                    <th>Dịch vụ</th>
                                    <th>Comment</th>
                                    <th>Sao <button class="btn btn-link p-0" onclick="sortByRating()">↕</button></th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Review r : reviewList) {
                                        String statusText = r.getReviewStatus() == 1 ? "Hiển thị" : "Ẩn";
                                %>
                                <tr>
                                    <td><%= r.getReviewId()%></td>
                                    <td><%= statusText%></td>
                                    <td><%= r.getPatientName()%></td>
                                    <td><%= r.getDoctorName()%></td>
                                    <td><%= r.getReviewCreatedAt()%></td>
                                    <td><%= r.getBookedAt()%></td>
                                    <td><%= sdf.format(r.getScheduleDate()) + " " + r.getShiftName()%></td>
                                    <td><%= r.getRoomId()%></td>
                                    <td><%= r.getServiceReason()%></td>
                                    <td><%= r.getComment()%></td>
                                    <td><% for (int j = 0; j < r.getRating(); j++)
                        out.print("⭐");%></td>
                                    <td>
                                        <button class="btn btn-sm <%= r.getReviewStatus() == 1 ? "btn-warning" : "btn-success"%>"
                                                onclick="confirmAction('<%= r.getReviewId()%>', '<%= r.getReviewStatus() == 1 ? "hide" : "show"%>')">
                                            <%= r.getReviewStatus() == 1 ? "Ẩn" : "Hiển thị"%>
                                        </button>
                                        <button class="btn btn-sm btn-danger" 
                                                onclick="confirmAction('<%= r.getReviewId()%>', 'delete')">Xóa</button>
                                    </td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- MODAL XÁC NHẬN -->
        <div class="modal fade" id="confirmModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-warning">
                        <h5 class="modal-title">Xác nhận hành động</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body" id="confirmMessage">Bạn có chắc muốn thực hiện hành động này không?</div>
                    <div class="modal-footer">
                        <form method="post" action="ReviewController" id="confirmForm">
                            <input type="hidden" name="reviewId" id="confirmReviewId">
                            <input type="hidden" name="action" id="confirmAction">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Xác nhận</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                    function confirmAction(id, action) {
                                        document.getElementById('confirmReviewId').value = id;
                                        document.getElementById('confirmAction').value = action;
                                        const message = {
                                            hide: "Bạn có chắc muốn Ẩn đánh giá này?",
                                            show: "Bạn có chắc muốn Hiển thị lại đánh giá này?",
                                            delete: "⚠️ Bạn có chắc muốn XÓA đánh giá này? Hành động này không thể hoàn tác."
                                        }[action];
                                        document.getElementById('confirmMessage').innerText = message;
                                        new bootstrap.Modal(document.getElementById('confirmModal')).show();
                                    }

                                    function filterTable() {
                                        let input = document.getElementById('searchInput').value.toLowerCase();
                                        document.querySelectorAll('#reviewTable tbody tr').forEach(row => {
                                            row.style.display = row.innerText.toLowerCase().includes(input) ? '' : 'none';
                                        });
                                    }

                                    let sortAsc = true;
                                    function sortByRating() {
                                        const table = document.querySelector("#reviewTable tbody");
                                        const rows = Array.from(table.rows);
                                        rows.sort((a, b) => {
                                            const ra = (a.cells[10].innerText.match(/⭐/g) || []).length;
                                            const rb = (b.cells[10].innerText.match(/⭐/g) || []).length;
                                            return sortAsc ? ra - rb : rb - ra;
                                        });
                                        rows.forEach(r => table.appendChild(r));
                                        sortAsc = !sortAsc;
                                    }
        </script>
    </body>
</html>
