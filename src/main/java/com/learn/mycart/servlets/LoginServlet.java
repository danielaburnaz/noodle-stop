
package com.learn.mycart.servlets;

import com.learn.mycart.dao.UserDao;
import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;
import com.learn.mycart.helper.PasswordHashing;
import static com.learn.mycart.helper.PasswordHashing.doHashing;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String email = request.getParameter("user_email");
            String userPassword = request.getParameter("user_password");
            String hashedPassword = PasswordHashing.doHashing(userPassword);
            //validations
            
            //login user
            UserDao userDao = new UserDao(FactoryProvider.getFactory());
            User user = userDao.getUserByEmailAndPassword(email, hashedPassword);
            System.out.println(user);
            HttpSession httpSession = request.getSession();
            
            if(user!=null){
                
                //login
                httpSession.setAttribute("user_type", user);
                switch (user.getUserType()) {
                    case "admin":
                        response.sendRedirect("admin.jsp");
                        break;
                    case "customer":
                        //                    response.sendRedirect("customer.jsp");
                        response.sendRedirect("index.jsp");
                        break;
                    default:
//                        out.println("user type undentified");
                        httpSession.setAttribute("error_message", "User type not indentified.");
                        response.sendRedirect("login.jsp");
                        break;
                }
                
            } else {
//                out.println("<h1>Invalid details</h1>");
                httpSession.setAttribute("error_message", "Invalid details. Don't have an account? <a href=\"sign_up.jsp\">Sign up here.</a>");
                response.sendRedirect("login.jsp");
                return;
            
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
