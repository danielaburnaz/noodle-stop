
package com.learn.mycart.servlets;

import com.learn.mycart.dao.UserDao;
import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UpdateUserInfo extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String op = request.getParameter("operation");
            
            if (op.trim().equals("edituser")) {
                HttpSession httpSession = request.getSession();
                User user = (User) httpSession.getAttribute("user_type");
                if (user == null) {
                    httpSession.setAttribute("error_message", "User not found.");
                    response.sendRedirect("customer.jsp");
                    return;
                }

                UserDao userDao = new UserDao(FactoryProvider.getFactory());
                if (request.getParameter("delete") != null) {
                    // Perform the delete operation
                    userDao.deleteProduct(user);
                    // Redirect or forward as needed after deletion
                    httpSession.setAttribute("error_message", "User Deleted");
                    response.sendRedirect("login.jsp");
                    return;
                } else {

                String newName = request.getParameter("userName");
                String newEmail = request.getParameter("userEmail");
                String newPhone = request.getParameter("userPhone");
                String newAddress = request.getParameter("userAddress");

                // update user attributes
                user.setUserName(newName);
                user.setUserEmail(newEmail);
                user.setUserPhone(newPhone);
                user.setUserAddress(newAddress);

                // save updated user
                userDao.updateUser(user);

                //bro de ce nu se printeaza mesajul
                httpSession.setAttribute("success_message", "Profile Updated");
                response.sendRedirect("customer.jsp");
                return;
                }
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
