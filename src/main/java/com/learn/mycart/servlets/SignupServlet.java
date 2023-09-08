
package com.learn.mycart.servlets;

//import java.text.SimpleDateFormat;
//import java.text.ParseException;
//import java.util.Date;

import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;
import com.learn.mycart.helper.PasswordHashing;
import com.learn.mycart.helper.PhoneNumberValidator;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import javax.persistence.Query;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class SignupServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                String userName = request.getParameter("user_name");
                String userLastName = request.getParameter("user_lastname");
                String userEmail = request.getParameter("user_email");
                String userPassword = request.getParameter("user_password");
                String hashedPassword = PasswordHashing.doHashing(userPassword);
                String userPhone = request.getParameter("user_phone");
                String userAddress = request.getParameter("user_address");
                String userDob = request.getParameter("user_dob"); // This will be in 'yyyy-mm-dd' format
                
//                validations for age
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date dobDate = sdf.parse(userDob);

                // Calculate the user's age based on the date of birth
                Calendar dobCalendar = Calendar.getInstance();
                dobCalendar.setTime(dobDate);
                Calendar currentCalendar = Calendar.getInstance();
                int age = currentCalendar.get(Calendar.YEAR) - dobCalendar.get(Calendar.YEAR);

                // Check if the user's age is within the allowed range
                if (age < 13 || age > 100) {
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("error_message", "You must be between 13 and 100 years old to create an account.");
                    response.sendRedirect("sign_up.jsp");
                    return;
                }
                
//                validations for phone number
                if (!PhoneNumberValidator.isValidPhoneNumber(userPhone)) {
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("error_message", userPhone + " is not a valid phone number.");
                    response.sendRedirect("sign_up.jsp");
                    return;
                } 
                
//                validations
                if(userName.isEmpty() || userLastName.isEmpty() 
                        || userEmail.isEmpty() || userPassword.isEmpty()
                        || userPhone.isEmpty() || userAddress.isEmpty()
                        || userDob.isEmpty()){
                HttpSession httpSession = request.getSession();
		httpSession.setAttribute("error_message", "Please fill out the entire form.");
		response.sendRedirect("sign_up.jsp");
                return;
                }
                
//                creating user object to store data
                User user = new User(userName, userLastName, userEmail, hashedPassword, userPhone, "default.jpg", userAddress, "customer", dobDate);
         
                Session hibernateSession = FactoryProvider.getFactory().openSession();
                // Check if email exists
                Query query = hibernateSession.createQuery("SELECT COUNT(*) FROM User WHERE userEmail = :email", Long.class);
                query.setParameter("email", userEmail);
                Long emailCount = (Long) query.getSingleResult();

                if (emailCount > 0) {
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("error_message", "Email already exists. Please use a different email.");
                    response.sendRedirect("sign_up.jsp");
                    return;
                }
                Transaction tx = hibernateSession.beginTransaction();
                int userId = (int) hibernateSession.save(user);
                tx.commit();
                hibernateSession.close();

//                String successMessage = "User successfully saved with ID: " + userId;
//                request.setAttribute("successMessage", successMessage);
//                request.getRequestDispatcher("/signup_success.jsp").forward(request, response);
//                
                
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Account created successfully! " + userId);

                //add redirect after signup/login to front page
                response.sendRedirect("sign_up.jsp");
//                return;
                
            } catch (Exception e) {
                e.printStackTrace();
                HttpSession httpSession = request.getSession();
		httpSession.setAttribute("error_message", "Unable to Register - " + e.getLocalizedMessage());//add a catch exception for phone (maybe)
		response.sendRedirect("sign_up.jsp");
            }
            
            
            
            
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
