<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> list = cdao.getCategories();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Admin Panel</title>
        <%@include file="components/common_css_js.jsp"%>
    </head>
    <body>
        <%@include file="components/navbar.jsp"%>
        <div class="container-fluid">
            <div class="row ">
                <div class="col-md-4 offset-md-4 square">
        <%   int productId = 0;   
            try {
                productId = Integer.parseInt(request.getParameter("id"));
            } catch (NumberFormatException e) {
                // Handle the case where the parameter is not a valid integer
                // You might want to redirect or display an error message here
                e.printStackTrace();
                HttpSession httpSession = request.getSession();
		httpSession.setAttribute("error_message", "number format error - " + e.getLocalizedMessage());
		response.sendRedirect("admin.jsp");
            }
            %>
        <%
            if (productId > 0) {
                ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
                Product p = productDao.getProductById(productId);
        %>

            <form action="ProductOperationServlet" method="post">

                <input type="hidden" name="operation" value="editproduct">
                <input type="hidden" name="productId" value="<%= p.getpId() %>">
                <div class="mb-3">
                    <label for="name">Product name:</label>
                    <input type="text" name="pName" value="<%= p.getpName() %>">
                </div>
                <div class="mb-3">
                    <label for="name">Product price:</label>
                    <input type="number" name="pPrice" value="<%= p.getpPrice() %>">
                </div>
                <div class="mb-3">
                    <label for="name">Product discount (in %):</label>
                    <input type="number" name="pDiscount" value="<%= p.getpDiscount() %>">
                </div>
                <div class="mb-3">
                    <label for="name">Product quantity:</label>
                    <input type="number" name="pQuantity" value="<%= p.getpQuantity() %>">
                </div>
                <div class="form-group mt-3">
                    <select name="catId" class="form-control" id="">
                              <% for (Category c : list) {%>
                              <option value="<%= c.getCategoryId()%>"><%= c.getCategoryTitle()%></option>
                              <%} %>
                    </select>
                </div>
                <div class="mb-3">
                    <button class="btn btn-success" type="submit">Update</button>
                    <button class="btn btn-danger" type="submit" name="delete">Delete</button>
                </div>
            </form>
        <%
            }
        %>
        
        </div>
        </div>
        </div>
    </body>
</html>
