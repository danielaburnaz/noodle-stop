
package com.learn.mycart.servlets;

import com.learn.mycart.dao.CategoryDao;
import com.learn.mycart.dao.ProductDao;
import com.learn.mycart.entities.Category;
import com.learn.mycart.entities.Product;
import com.learn.mycart.helper.FactoryProvider;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class ProductOperationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

//            servlet2:
//            add category
//            add product
            String op = request.getParameter("operation");
            if(op.trim().equals("addcategory")){
//            add category
//            fetching category data
                String title = request.getParameter("catTitle");
                String description = request.getParameter("catDescription");
                
                Category category = new Category();
                category.setCategoryTitle(title);
                category.setCategoryDescription(description);
                
//                category database save:
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                int catId = categoryDao.saveCategory(category);
//                out.println("Category Saved");

                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("error_message", "Category Saved");
                response.sendRedirect("admin.jsp");
                return;
                
            }else if(op.trim().equals("addproduct")){
//            add product
                String pName = request.getParameter("pName");
                String pDesc = request.getParameter("pDesc");
//                daca crapa aplicatia e din vina lui pPrice
                Double pPrice = Double.parseDouble(request.getParameter("pPrice"));
                int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
                int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
                int catId = Integer.parseInt(request.getParameter("catId"));
                Part part = request.getPart("pPic");
                
                Product p = new Product();
                p.setpName(pName);
                p.setpDesc(pDesc);
                p.setpPrice(pPrice);
                p.setpDiscount(pDiscount);
                p.setpQuantity(pQuantity);
                p.setpPhoto(part.getSubmittedFileName());
                
                //get category by id
                CategoryDao cdoa = new CategoryDao(FactoryProvider.getFactory());
                Category category = cdoa.getCategorybyId(catId);
                
                p.setCategory(category);
                
                
                
//                product database save:
                ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                pdao.saveProduct(p);//important related to my question
                
                //pic upload
                //use this to determine where the path of the image folder is
                //TODO: after uploading it online with a real server
                String path = request.getRealPath("img") + File.separator + "products"+File.separator+part.getSubmittedFileName();
                System.out.println(path);
                
                //upload
                try {
                    
                
                FileOutputStream fos = new FileOutputStream(path);
                InputStream is =part.getInputStream();
                
//                read data
                byte []data=new byte[is.available()];
                is.read(data);
                
//                writing the data
                fos.write(data);
                fos.close();
                is.close();
                } catch (Exception e) {
                
                }
                
//                out.println("Saved sucessfully");
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("error_message", "Product Saved");
                response.sendRedirect("admin.jsp");
                return;

            }else if(op.trim().equals("editproduct")){
                int productId = Integer.parseInt(request.getParameter("productId"));
                String newName = request.getParameter("pName");
                String newDesc = request.getParameter("pDesc");
                double newPrice = Double.parseDouble(request.getParameter("pPrice"));
                int newDiscount = Integer.parseInt(request.getParameter("pDiscount"));
                int newQuantity = Integer.parseInt(request.getParameter("pQuantity"));
                int catId = Integer.parseInt(request.getParameter("catId"));
                
                // Retrieve the product using the ID
                ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
                Product product = productDao.getProductById(productId);
                // Check if the "delete" button was clicked
                if (request.getParameter("delete") != null) {
                    // Perform the delete operation
                    productDao.deleteProduct(product);
                    // Redirect or forward as needed after deletion
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("error_message", "Product Deleted");
                    response.sendRedirect("admin.jsp");
                    return;
                } else {
                    // Update product attributes
                    product.setpName(newName);
                    product.setpDesc(newDesc);
                    product.setpPrice(newPrice);
                    product.setpDiscount(newDiscount);
                    product.setpQuantity(newQuantity);
                    
                    // Update other attributes as needed
                    
                    //get category by id
                    CategoryDao cdoa = new CategoryDao(FactoryProvider.getFactory());
                    Category category = cdoa.getCategorybyId(catId);
                    product.setCategory(category);
                    
                    // Save the updated product
                    productDao.updateProduct(product);

                    // Redirect or forward as needed after update
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("error_message", "Product Updated");
                    response.sendRedirect("admin.jsp");
                    return;
                } 
            }else if(op.trim().equals("editcategory")){
                int catId = Integer.parseInt(request.getParameter("catId"));
                String newName = request.getParameter("catName");
                String newDesc = request.getParameter("catDesc");
                // Retrieve the product using the ID
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                Category category = categoryDao.getCategorybyId(catId);
                
                if (request.getParameter("delete") != null) {
                    
                    
                    // Perform the delete operation
                    categoryDao.deleteCategory(category);
                    // Redirect or forward as needed after deletion
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("error_message", "Please double-check"
                            + " if the category was deleted.<br> If the category had items,"
                            + " first delete the product/reasign the item's category beforewards.");
                    response.sendRedirect("admin.jsp");
                    return;
                } else {
                    // Update product attributes
                    category.setCategoryTitle(newName);
                    category.setCategoryDescription(newDesc);
                    
                    // Update other attributes as needed

                    // Save the updated product
                    categoryDao.updateCategory(category);

                    // Redirect or forward as needed after update
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("error_message", "Category Updated");
                    response.sendRedirect("admin.jsp");
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
