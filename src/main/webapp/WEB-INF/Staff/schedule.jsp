
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Doctor, model.Room, model.Schedule" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý lịch bác sĩ</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f7f8;
        }
        .content {
            margin-left: 230px;
            margin-top: 80px;
            padding: 20px;
        }
        @media (max-width: 768px) {
            .content {
                margin-left: 0;
                padding: 10px;
            }
        }
        .card {
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            background: #fff;
            padding: 20px;
        }
        .card h3 {
            color: #0d6efd;
            font-weight: 600;
        }
        .schedule-table {
            border-radius: 8px;
            overflow: hidden;
            table-layout: fixed;
        }
        .schedule-table th, .schedule-table td {
            vertical-align: middle;
            text-align: center;
            min-width: 120px;
            word-wrap: break-word;
        }
        .schedule-table th {
            background-color: #0099ff;
            color: white;
            font-weight: 500;
        }
        .schedule-table td span {
            font-weight: 500;
        }
        .btn-sm {
            margin-top: 4px;
            width: 47%;
        }
        /* Cải tiến CSS cho nút Phân công (assign-btn) */
        .assign-btn {
            background-color: #28a745 !important; /* Màu xanh lá chủ đạo */
            border-color: #218838 !important; /* Viền xanh đậm hơn */
            color: #fff !important; /* Chữ trắng */
            font-weight: 600;
            font-size: 14px; /* Kích thước chữ */
            padding: 6px 12px; /* Padding: 6px trên/dưới, 12px trái/phải */
            line-height: 1.5; /* Chiều cao dòng */
            border-radius: 6px; /* Góc bo tròn */
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(40, 167, 69, 0.3); /* Bóng đổ xanh lá */
            display: inline-block; /* Đảm bảo kích thước đúng */
            width: auto; /* Đặt lại width để nút tự co giãn theo nội dung */
            min-width: 80px; /* Chiều rộng tối thiểu */
        }
        .assign-btn:hover {
            background-color: #218838 !important; /* Xanh đậm hơn khi hover */
            border-color: #1e7e34 !important;
            color: #fff !important;
            transform: translateY(-1px); /* Nâng nhẹ khi hover */
            box-shadow: 0 4px 8px rgba(40, 167, 69, 0.4); /* Bóng đổ đậm hơn */
        }
        .assign-btn:focus, .assign-btn:active {
            background-color: #1e7e34 !important; /* Xanh rất đậm khi click */
            border-color: #1c7430 !important;
            color: #fff !important;
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.5); /* Viền focus */
            transform: translateY(0); /* Trở về vị trí ban đầu */
        }
        /* CSS cho nút Tuần trước và Tuần sau */
        .week-nav-btn {
            background-color: #0d6efd !important; /* Màu xanh dương */
            border-color: #0d6efd !important;
            color: #fff !important;
            font-weight: 500;
            font-size: 14px;
            padding: 6px 12px;
            border-radius: 6px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(13, 110, 253, 0.3);
            margin: 0 5px; /* Khoảng cách giữa các nút */
        }
        .week-nav-btn:hover {
            background-color: #0b5ed7 !important; /* Xanh đậm hơn khi hover */
            border-color: #0a58ca !important;
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(13, 110, 253, 0.4);
        }
        .week-nav-btn:focus, .week-nav-btn:active {
            background-color: #0a58ca !important; /* Xanh rất đậm khi click */
            border-color: #0a53be !important;
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.5);
            transform: translateY(0);
        }
        .week-nav-container {
            display: flex;
            align-items: center;
            gap: 10px; /* Khoảng cách giữa input và nút */
            margin-bottom: 15px;
        }
        .list-group-item {
            transition: background-color 0.2s, box-shadow 0.2s;
            cursor: pointer;
            border-radius: 6px;
        }
        .list-group-item:hover {
            background-color: #d1f3ff;
            box-shadow: 0 0 8px rgba(0,123,255,0.4);
        }
        .list-group-item.active {
            background-color: #0d6efd !important;
            color: #fff !important;
        }
        #confirmModal .modal-dialog {
            max-width: 400px;
            margin: 6rem auto;
        }
        #confirmModal .modal-content {
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.3);
            overflow: hidden;
            max-width: 400px;
        }
        #confirmModal .modal-header {
            background: linear-gradient(90deg, #28a745, #218838);
            color: #fff;
            font-weight: 600;
            border-bottom: none;
        }
        #confirmModal .modal-footer {
            border-top: none;
            justify-content: center;
            padding: 1rem 1.5rem;
        }
        #confirmModal .btn-success {
            background-color: #28a745;
            border: none;
            padding: 0.5rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            transition: background 0.3s;
        }
        #confirmModal .btn-success:hover {
            background-color: #218838;
        }
        #confirmModal .btn-secondary {
            border-radius: 8px;
            padding: 0.5rem 1.5rem;
        }
    </style>
</head>

<body>
          <jsp:include page="/WEB-INF/Include/header.jsp" />
        <jsp:include page="/WEB-INF/Include/sidebar.jsp" />

    <div class="content">
        <div class="card p-3">
            <h3 class="mb-3">Quản lý lịch bác sĩ</h3>

            <!-- Chọn tuần và nút điều hướng -->
            <div class="week-nav-container">
                <button class="btn week-nav-btn" id="prevWeekBtn">Tuần trước</button>
                <div class="mb-3">
                    <label for="weekPicker" class="form-label"></label>
                   <input type="date" id="weekPicker" class="form-control" style="max-width:250px;margin-top: 8px;">
                </div>
                <button class="btn week-nav-btn" id="nextWeekBtn">Tuần sau</button>
            </div>

            <!-- Bảng lịch -->
            <div class="table-responsive">
                <table class="table table-bordered schedule-table">
                    <thead>
                        <tr id="weekHeader"><th rowspan="2">Phòng</th><th rowspan="2">Ca</th></tr>
                    </thead>
                    <tbody id="scheduleBody"></tbody>
                </table>
            </div>
        </div>
    </div>

     <!-- Modal thông báo trùng lịch -->
<div class="modal fade" id="conflictModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-warning text-dark">
        <h5 class="modal-title">Xung đột lịch</h5>
      </div>
      <div class="modal-body">
        Bác sĩ này đã có lịch trong ca này.<br>
        Bạn có muốn <strong>thay thế</strong> bằng lịch mới không?
      </div>
      <div class="modal-footer">
        <form method="post" action="<%=request.getContextPath()%>/StaffSchedule">
          <input type="hidden" name="action" value="replace">
          <input type="hidden" name="doctorId" value="<%= session.getAttribute("conflictDoctor") %>">
          <input type="hidden" name="date" value="<%= session.getAttribute("conflictDate") %>">
          <input type="hidden" name="shift" value="<%= session.getAttribute("conflictShift") %>">
           <input type="hidden" name="room" value="<%= session.getAttribute("Room") %>">
          <button type="submit" class="btn btn-danger">Thay thế</button>
        </form>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
      </div>
    </div>
  </div>
</div>

<%
  Boolean showModal = (Boolean) session.getAttribute("showConflictModal");
  if (showModal != null && showModal) {
%>
<script>
  document.addEventListener("DOMContentLoaded", function() {
    var modal = new bootstrap.Modal(document.getElementById("conflictModal"));
    modal.show();
  });
</script>
<%
    session.removeAttribute("showConflictModal");
    session.removeAttribute("conflictDoctor");
    session.removeAttribute("conflictDate");
    session.removeAttribute("conflictShift");
  }
%>

    <!-- Modal phân công -->
    <div class="modal fade" id="assignModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Phân công / Chỉnh sửa bác sĩ</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p id="modalDay"></p>
                    <p>Ca: <span id="modalShift"></span></p>
                    <input type="hidden" id="scheduleId" value="">
                    <input type="hidden" id="modalRoomId" value="">
                    <input type="text" id="searchDoctor" class="form-control mb-2" placeholder="Tìm bác sĩ theo tên hoặc chuyên khoa...">
                    <ul id="doctorResults" class="list-group"></ul>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal xác nhận -->
    <div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title">Xác nhận phân công</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p><b>Bác sĩ:</b> <span id="confirmDoctor"></span></p>
                    <p><b>Phòng:</b> <span id="confirmRoom"></span></p>
                    <p><b>Ngày:</b> <span id="confirmDate"></span></p>
                    <p><b>Ca:</b> <span id="confirmShift"></span></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" id="btnConfirmAssign" class="btn btn-success">Xác nhận</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal phân công / chi tiết lịch -->
    <div class="modal fade" id="assignModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="assignModalLabel"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <!-- Phần hiển thị chi tiết lịch khi click vào tên bác sĩ -->
                    <div id="scheduleDetails" style="display: none;">
                        <p><b>Bác sĩ:</b> <span id="detailDoctorName"></span></p>
                        <p><b>Phòng:</b> <span id="detailRoomName"></span></p>
                        <p><b>Ngày:</b> <span id="detailDate"></span></p>
                        <p><b>Ca:</b> <span id="detailShift"></span></p>
                        <div class="d-flex justify-content-center mt-3">
                            <button class="btn btn-primary me-2" id="btnEditSchedule" style="display: none;">Sửa</button>
                            <button class="btn btn-danger" id="btnDeleteSchedule" style="display: none;">Xóa</button>
                        </div>
                    </div>

                    <!-- Phần tìm kiếm bác sĩ để phân công/chỉnh sửa -->
                    <div id="assignDoctorForm">
                        <p id="modalDay"></p>
                        <p>Ca: <span id="modalShift"></span></p>
                        <input type="hidden" id="scheduleId" value="">
                        <input type="hidden" id="modalRoomId" value="">
                        <input type="hidden" id="modalDoctorId" value=""> <!-- Lưu trữ doctorId tạm thời -->
                        <input type="text" id="searchDoctor" class="form-control mb-2" placeholder="Tìm bác sĩ theo tên hoặc chuyên khoa...">
                        <ul id="doctorResults" class="list-group"></ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // --- Dữ liệu phòng ---
        let allRooms = [];
        <%
         List<Room> rooms = (List<Room>) request.getAttribute("rooms");
         if (rooms != null) {
             for (Room r : rooms) {
        %>
        allRooms.push({
            id: <%= r.getRoomId() %>,
            name: "Phòng <%= r.getRoomNumber() %> - <%= r.getRoomType() %> (Sức chứa: <%= r.getCapacity() %>)"
        });
        <% } } %>

        // --- Dữ liệu bác sĩ ---
        let allDoctors = [];
        <%
          List<Doctor> doctors = (List<Doctor>) request.getAttribute("doctors");
          if (doctors != null) {
              for (Doctor d : doctors) {
        %>
        allDoctors.push({
            id: <%= d.getDoctorId() %>,
            name: "<%= d.getFullName().replace("\"","\\\"") %>",
            specialty: "<%= d.getSpecialtyName().replace("\"","\\\"") %>"
        });
        <% } } %>

        // --- Dữ liệu lịch ---
        let allSchedules = [];
        <%
          List<Schedule> schedules = (List<Schedule>) request.getAttribute("schedules");
          if (schedules != null) {
              for (Schedule s : schedules) {
        %>
        allSchedules.push({
            scheduleId: <%= s.getScheduleId() %>,
            doctorId: <%= s.getDoctorId() %>,
            roomId: <%= s.getRoomId() %>,
            date: "<%= s.getDate() %>",
            shiftName: "<%= s.getShiftName() %>",
            status: "<%= s.getStatus() %>"
        });
        <% } } %>

        // --- Lấy các ngày trong tuần ---
        function getWeekDays(dateStr) {
            let date = new Date(dateStr);
            let day = date.getDay();
            let diffToMonday = (day === 0 ? -6 : 1 - day);
            let monday = new Date(date);
            monday.setDate(date.getDate() + diffToMonday);
            let days = [];
            for (let i = 0; i < 7; i++) {
                let d = new Date(monday);
                d.setDate(monday.getDate() + i);
                days.push(d);
            }
            return days;
        }

        // --- Render lịch ---
        function renderSchedule(dateStr) {
            if (!dateStr) return;
            let days = getWeekDays(dateStr);
            let weekHeader = document.getElementById("weekHeader");
            let scheduleBody = document.getElementById("scheduleBody");

            weekHeader.innerHTML = '<th rowspan="2">Phòng</th><th rowspan="2">Ca</th>';
            scheduleBody.innerHTML = '';

            let dayNames = ["Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7", "CN"];

            for (let i = 0; i < days.length; i++) {
                let d = days[i];
                weekHeader.innerHTML += "<th>" + dayNames[i] + "<br><small>" + d.toLocaleDateString("vi-VN") + "</small></th>";
            }

            allRooms.forEach(room => {
                let roomId = room.id;
                let roomName = room.name;
                let rowMorning = '<tr><td rowspan="2">' + roomName + '</td><td><b>Sáng</b></td>';
                let rowAfternoon = '<tr><td><b>Chiều</b></td>';

                for (let i = 0; i < days.length; i++) {
                    let d = days[i];
                    let dateText = d.toISOString().split("T")[0];

                    ["Sáng", "Chiều"].forEach(shift => {
                        let sched = allSchedules.find(s => s.roomId == roomId && s.date === dateText && s.shiftName === shift);
                        let cellContent;
                        if (sched) {
                            let doc = allDoctors.find(d => d.id === sched.doctorId);
                            cellContent = "<b>" + (doc ? doc.name : "?") + "</b><br>" +
                                "<button class='btn btn-sm btn-outline-secondary me-1 edit-btn' data-id='"
                                + sched.scheduleId + "' data-doctor='" + (doc ? doc.id : "") + "' data-date='" + dateText +
                                "' data-shift='" + shift + "' data-room='" + roomId + "'>Sửa</button>" +
                                "<button class='btn btn-sm btn-outline-danger delete-btn' data-id='" 
                                + sched.scheduleId + "' data-room='" + roomId + "'>Xóa</button>";
                        } else {
                            cellContent = 
                                "<button class='btn btn-sm btn-warning assign-btn' data-date='" + dateText + "' data-shift='" + shift + "' data-room='" + roomId + "'>Phân công</button>";
                        }
                        if (shift === "Sáng") {
                            rowMorning += "<td>" + cellContent + "</td>";
                        } else {
                            rowAfternoon += "<td>" + cellContent + "</td>";
                        }
                    });
                }

                rowMorning += '</tr>';
                rowAfternoon += '</tr>';
                scheduleBody.innerHTML += rowMorning + rowAfternoon;
            });

            // Edit / Assign modal
            document.querySelectorAll('.assign-btn, .edit-btn').forEach(btn => {
                btn.addEventListener('click', function () {
                    let modal = new bootstrap.Modal(document.getElementById('assignModal'));
                    let scheduleId = this.dataset.id || "";
                    let doctorId = this.dataset.doctor || "";
                    let date = this.dataset.date;
                    let shift = this.dataset.shift;
                    let roomId = this.dataset.room;
                    document.getElementById('scheduleId').value = scheduleId;
                    document.getElementById('modalRoomId').value = roomId;
                    document.getElementById('modalDay').textContent = "Ngày: " + date;
                    document.getElementById('modalShift').textContent = shift;
                    renderDoctorList();
                    if (doctorId) {
                        let li = document.querySelector("#doctorResults li[data-id='" + doctorId + "']");
                        if (li) li.classList.add("active");
                    }
                    modal.show();
                });
            });

            // Delete
            document.querySelectorAll('.delete-btn').forEach(btn => {
                btn.addEventListener('click', function () {
                    let scheduleId = this.dataset.id;
                    if (confirm("Bạn có chắc chắn muốn xóa lịch này?")) {
                        let form = document.createElement("form");
                        form.method = "POST";
                        form.action = "<%=request.getContextPath()%>/StaffSchedule";
                        form.innerHTML = "<input type='hidden' name='action' value='delete'>" +
                                "<input type='hidden' name='scheduleId' value='" + scheduleId + "'>" +
                                "<input type='hidden' name='selectedDate' value='" + document.getElementById("weekPicker").value + "'>";
                        document.body.appendChild(form);
                        form.submit();
                    }
                });
            });
        }

        function renderDoctorList(filter) {
            if (filter === undefined) filter = "";
            let results = document.getElementById("doctorResults");
            results.innerHTML = "";
            let filtered = allDoctors.filter(d => d.name.toLowerCase().includes(filter.toLowerCase()) || d.specialty.toLowerCase().includes(filter.toLowerCase()));
            if (filtered.length === 0) {
                results.innerHTML = "<li class='list-group-item text-muted'>Không tìm thấy bác sĩ</li>";
            } else {
                filtered.forEach(d => {
                    let li = document.createElement("li");
                    li.className = "list-group-item";
                    li.dataset.id = d.id;
                    li.textContent = d.id + " - " + d.name + " (" + d.specialty + ")";
                    results.appendChild(li);
                });
            }
        }

        // --- Event ---
        document.getElementById("assignModal").addEventListener("shown.bs.modal", () => renderDoctorList());
        document.getElementById("searchDoctor").addEventListener("input", e => renderDoctorList(e.target.value));
        document.getElementById("doctorResults").addEventListener("click", e => {
            if (e.target && e.target.classList.contains("list-group-item")) {
                let doctorId = e.target.dataset.id;
                let doctorName = e.target.textContent.split(" - ")[1].split(" (")[0];
                let roomId = document.getElementById("modalRoomId").value;
                let room = allRooms.find(r => r.id == roomId);
                let roomName = room ? room.name : '';
                let modal = document.getElementById("assignModal");
                let date = modal.querySelector("#modalDay").textContent.replace("Ngày: ", "");
                let shift = modal.querySelector("#modalShift").textContent;
                let scheduleId = document.getElementById("scheduleId").value;

                document.getElementById("confirmDoctor").textContent = doctorName;
                document.getElementById("confirmRoom").textContent = roomName;
                document.getElementById("confirmDate").textContent = date;
                document.getElementById("confirmShift").textContent = shift;

                let confirmModal = new bootstrap.Modal(document.getElementById("confirmModal"));
                confirmModal.show();

                document.getElementById("btnConfirmAssign").onclick = function () {
                    let form = document.createElement("form");
                    form.method = "POST";
                    form.action = "<%=request.getContextPath()%>/StaffSchedule";
                    form.innerHTML =
                            "<input type='hidden' name='doctorId' value='" + doctorId + "'>" +
                            "<input type='hidden' name='roomId' value='" + roomId + "'>" +
                            "<input type='hidden' name='date' value='" + date + "'>" +
                            "<input type='hidden' name='shift' value='" + shift + "'>" +
                            "<input type='hidden' name='scheduleId' value='" + scheduleId + "'>" +
                            "<input type='hidden' name='action' value='" + (scheduleId ? "edit" : "assign") + "'>" +
                            "<input type='hidden' name='selectedDate' value='" + document.getElementById("weekPicker").value + "'>";
                    document.body.appendChild(form);
                    form.submit();
                }
            }
        });

        // --- Khởi tạo và lưu/restore ngày từ localStorage ---
        let weekPicker = document.getElementById("weekPicker");
        const STORAGE_KEY = 'selectedWeekDate';

        // Restore ngày từ localStorage khi load trang
        function restoreSelectedDate() {
            const savedDate = localStorage.getItem(STORAGE_KEY);
            if (savedDate) {
                weekPicker.value = savedDate;
                renderSchedule(savedDate);
            } else {
                let today = new Date().toISOString().split("T")[0];
                weekPicker.value = today;
                renderSchedule(today);
            }
        }

        // Lưu ngày khi thay đổi
        weekPicker.addEventListener("change", function() {
            const selectedDate = this.value;
            localStorage.setItem(STORAGE_KEY, selectedDate);
            renderSchedule(selectedDate);
        });

        // --- Xử lý nút Tuần trước và Tuần sau ---
        document.getElementById("prevWeekBtn").addEventListener("click", function() {
            let currentDate = new Date(weekPicker.value);
            currentDate.setDate(currentDate.getDate() - 7);
            let newDate = currentDate.toISOString().split("T")[0];
            weekPicker.value = newDate;
            localStorage.setItem(STORAGE_KEY, newDate);
            renderSchedule(newDate);
        });

        document.getElementById("nextWeekBtn").addEventListener("click", function() {
            let currentDate = new Date(weekPicker.value);
            currentDate.setDate(currentDate.getDate() + 7);
            let newDate = currentDate.toISOString().split("T")[0];
            weekPicker.value = newDate;
            localStorage.setItem(STORAGE_KEY, newDate);
            renderSchedule(newDate);
        });

        // Khởi tạo
        restoreSelectedDate();
    </script>
</body>
</html>
