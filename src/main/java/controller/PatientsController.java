package controller;

import dao.PatientsDAO;
import dao.ProvincesDAO;
import model.Patient;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
@WebServlet(name = "PatientsController", urlPatterns = {"/PatientsController"})
public class PatientsController extends HttpServlet {
    private PatientsDAO dao;

    @Override
    public void init() {
        dao = new PatientsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deletePatient(request, response);
                break;
            case "search":
                searchPatients(request, response);
                break;
            default:
                listPatients(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("insert".equals(action)) {
            System.out.println("tạo nhaaaaaaaaaa");
            insertPatient(request, response);
        } else if ("update".equals(action)) {
            updatePatient(request, response);
        }else 
             listPatients(request, response);
     
    }

    // ---------------- CRUD & SEARCH ----------------

    private void listPatients(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Patient> list = dao.getAllPatients();
        request.setAttribute("patients", list);

        // Load provinces
        ProvincesDAO provDao = new ProvincesDAO();
        request.setAttribute("provinces", provDao.getAllProvinces());

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Staff/managePatient.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Patient patient = dao.getPatientById(id);
        request.setAttribute("patient", patient);
        request.setAttribute("patients", dao.getAllPatients());

        // Load provinces
        ProvincesDAO provDao = new ProvincesDAO();
        request.setAttribute("provinces", provDao.getAllProvinces());

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Staff/managePatient.jsp");
        dispatcher.forward(request, response);
    }

    private void searchPatients(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        ArrayList<Patient> list = dao.searchPatients(keyword);
        request.setAttribute("patients", list);

        // Load provinces
        ProvincesDAO provDao = new ProvincesDAO();
        request.setAttribute("provinces", provDao.getAllProvinces());

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Staff/managePatient.jsp");
        dispatcher.forward(request, response);
    }

 private void insertPatient(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    Patient p = new Patient();
    p.setFullName(request.getParameter("fullName"));
    p.setDob(java.sql.Date.valueOf(request.getParameter("dob")));
    p.setGender(request.getParameter("gender"));
    p.setInsuranceNumber(request.getParameter("insuranceNumber"));
    p.setEmergencyContact(request.getParameter("emergencyContact"));
    p.setProvinceId(Integer.parseInt(request.getParameter("provinceId")));
    p.setEmail(request.getParameter("email"));
    p.setPhone(request.getParameter("phone"));

    // Kiểm tra duplicate phone
    if (dao.isPhoneExists(p.getPhone())) {
        request.setAttribute("errorMessage", "Số điện thoại đã tồn tại!");
        request.setAttribute("patient", p);
        request.setAttribute("provinces", new ProvincesDAO().getAllProvinces());
        listPatients(request, response);
        return;
    }

    // Kiểm tra duplicate email
    if (dao.isEmailExists(p.getEmail())) {
        request.setAttribute("errorMessage", "Email đã tồn tại!");
        request.setAttribute("patient", p);
        request.setAttribute("provinces", new ProvincesDAO().getAllProvinces());
         listPatients(request, response);
        return;
    }

    // Nếu không trùng mới insert
    dao.insertPatient(p);
    response.sendRedirect("PatientsController");
}

    private void updatePatient(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Patient p = new Patient();
        p.setPatientId(Integer.parseInt(request.getParameter("patientId")));
        p.setFullName(request.getParameter("fullName"));
        p.setDob(java.sql.Date.valueOf(request.getParameter("dob")));
        p.setGender(request.getParameter("gender"));
        p.setInsuranceNumber(request.getParameter("insuranceNumber"));
        p.setEmergencyContact(request.getParameter("emergencyContact"));
        p.setProvinceId(Integer.parseInt(request.getParameter("provinceId")));
        p.setEmail(request.getParameter("email"));
        p.setPhone(request.getParameter("phone"));

        dao.updatePatient(p);
        response.sendRedirect("PatientsController");
    }

    private void deletePatient(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        dao.deletePatient(id);
        response.sendRedirect("PatientsController");
    }
}
