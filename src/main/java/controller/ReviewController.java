package controller;

import dao.ReviewDAO;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import model.Review;


@WebServlet(name = "ReviewController", urlPatterns = {"/ReviewController"})
public class ReviewController extends HttpServlet {
private ReviewDAO reviewDAO;

 @Override
    public void init() {
       reviewDAO = new ReviewDAO();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

   
        ArrayList<Review> reviewList = reviewDAO.getAllReviews();

        // Gửi list lên JSP
        request.setAttribute("reviewList", reviewList);
        request.getRequestDispatcher("/WEB-INF/Staff/manageReview.jsp").forward(request, response);
    }

   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

     String action = request.getParameter("action");
   String id = request.getParameter("reviewId");

       System.out.println(action+" "+id);

        switch (action) {
            case "show":
                System.out.println("do show");
                show(request, response);
                break;
            case "delete":
                   System.out.println("do delete");
                delete(request, response);
                break;
            case "hide":
                   System.out.println("do hide");
                hide(request, response);
                break;
           
        }
}


    @Override
    public String getServletInfo() {
        return "Servlet hiển thị danh sách review";
    }

    private void show(HttpServletRequest request, HttpServletResponse response) throws IOException {
   String id = request.getParameter("reviewId");
        reviewDAO.showReview(id); 
        System.out.println(id);
            response.sendRedirect("ReviewController");    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
     String id = request.getParameter("reviewId");
        reviewDAO.deleteReview(id);    
            response.sendRedirect("ReviewController");
    }

    private void hide(HttpServletRequest request, HttpServletResponse response) throws IOException {
    String id = request.getParameter("reviewId");
        reviewDAO.hideReview(id);    
            response.sendRedirect("ReviewController");    }
}
