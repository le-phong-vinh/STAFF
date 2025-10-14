package controller;

import dao.DoctorDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import model.Doctor;
import model.Room;
import model.Schedule;
import model.Specialty;
@WebServlet(name = "StaffSchedule", urlPatterns = {"/StaffSchedule"})
public class StaffSchedule extends HttpServlet {


  private  DoctorDAO dao = new DoctorDAO();
 @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

   

    // Lấy danh sách bác sĩ
    List<Doctor> doctors = dao.getAllDoctors();

    // Lấy danh sách chuyên khoa
    List<Specialty> specialties = dao.getAllSpecialties();
 List<Schedule> schedules = dao.getAllSchedules();
    // Lấy danh sách phòng
    List<Room> rooms = dao.getAllRooms();

    // Gửi dữ liệu lên JSP
    request.setAttribute("doctors", doctors);
    request.setAttribute("specialties", specialties);
    request.setAttribute("rooms", rooms);
       request.setAttribute("schedules", schedules);

    // Chuyển đến JSP
    request.getRequestDispatcher("/WEB-INF/Staff/schedule.jsp").forward(request, response);
}

//@Override
//protected void doPost(HttpServletRequest request, HttpServletResponse response)
//        throws ServletException, IOException {
//    request.setCharacterEncoding("UTF-8");
//    response.setContentType("text/html; charset=UTF-8");
//
//    String action = request.getParameter("action");
//    String scheduleId = request.getParameter("scheduleId");
//    String doctorId = request.getParameter("doctorId");
//    String roomId = request.getParameter("roomId");
//    String date = request.getParameter("date");
//    String shift = request.getParameter("shift");
//
//    response.getWriter().println("<!DOCTYPE html>");
//    response.getWriter().println("<html><head><meta charset='UTF-8'><title>Test Action</title></head><body>");
//    response.getWriter().println("<h3>Action: " + action + "</h3>");
//    response.getWriter().println("<ul>");
//    response.getWriter().println("<li>scheduleId: " + scheduleId + "</li>");
//    response.getWriter().println("<li>doctorId: " + doctorId + "</li>");
//    response.getWriter().println("<li>roomId: " + roomId + "</li>");
//    response.getWriter().println("<li>date: " + date + "</li>");
//    response.getWriter().println("<li>shift: " + shift + "</li>");
//    response.getWriter().println("</ul>");
//    response.getWriter().println("<a href='StaffSchedule'>Quay lại</a>");
//    response.getWriter().println("</body></html>");
//}





    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "replace":
                    System.out.println("thay thế");
                    deleteSchedulesByDoctor(request, response);
                              break;
                case "assign":
                    assignSchedule(request, response);
                    break;
                case "edit":
                    editSchedule(request, response);
                    break;
                case "delete":
                    deleteSchedule(request, response);
                    break;
                default:
                    response.sendRedirect("StaffSchedule");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("StaffSchedule");
        }
    }

    private void deleteSchedulesByDoctor(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String doctorId = request.getParameter("doctorId");
        String roomId = request.getParameter("room");
        String dateStr = request.getParameter("date");
        String shift = request.getParameter("shift");
        System.out.println(doctorId+" "+roomId+" "+shift+" "+dateStr);
        dao.deleteSchedulesByDoctorAndShift(doctorId, dateStr, shift);
          Schedule s = new Schedule();
        s.setDoctorId(Integer.parseInt(doctorId));
        s.setRoomId(Integer.parseInt(roomId));
        s.setDate(Date.valueOf(dateStr)); // Chuyển String sang java.sql.Date
        s.setShiftName(shift);

        boolean success = dao.insertSchedule(s);

        response.sendRedirect("StaffSchedule");
}
       private void assignSchedule(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        String dateStr = request.getParameter("date");
        String shift = request.getParameter("shift");
     if (dao.checkSchedule(doctorId, dateStr, shift)) {
    request.getSession().setAttribute("showConflictModal", true);
    request.getSession().setAttribute("conflictDoctor", doctorId);
    request.getSession().setAttribute("conflictDate", dateStr);
     request.getSession().setAttribute("Room", roomId);
    request.getSession().setAttribute("conflictShift", shift);
   response.sendRedirect("StaffSchedule");
    return;
}

        Schedule s = new Schedule();
        s.setDoctorId(doctorId);
        s.setRoomId(roomId);
        s.setDate(Date.valueOf(dateStr)); // Chuyển String sang java.sql.Date
        s.setShiftName(shift);

        boolean success = dao.insertSchedule(s);

        response.sendRedirect("StaffSchedule");
    }

    private void editSchedule(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        String dateStr = request.getParameter("date");
        String shift = request.getParameter("shift");

        Schedule s = new Schedule();
        s.setScheduleId(scheduleId);
        s.setDoctorId(doctorId);
        s.setRoomId(roomId);
        s.setDate(Date.valueOf(dateStr));
        s.setShiftName(shift);

        boolean success = dao.updateSchedule(s);

        response.sendRedirect("StaffSchedule");
    }

    private void deleteSchedule(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
        boolean success = dao.deleteSchedule(scheduleId);
        response.sendRedirect("StaffSchedule");
    }


// helper escape để tránh XSS
private String escapeHtml(String s) {
    if (s == null) return "";
    return s.replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("\"", "&quot;")
            .replace("'", "&#039;");
}

}
