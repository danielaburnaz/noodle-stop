<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Edit Category</title>
        <%@include file="components/common_css_js.jsp"%>
    </head>
    <body>
        <%@include file="components/navbar.jsp"%>
        <div class="container-fluid">
            <div class="row ">
                <div class="col-md-4 offset-md-4 square">
        <%   int categoryId = 0;   
            try {
                categoryId = Integer.parseInt(request.getParameter("id"));
            } catch (NumberFormatException e) {
                e.printStackTrace();
                HttpSession httpSession = request.getSession();
		httpSession.setAttribute("error_message", "number format error - " + e.getLocalizedMessage());
		response.sendRedirect("admin.jsp");
            }
            %>
        <%
            if (categoryId > 0) {
                CategoryDao categoryDao= new CategoryDao(FactoryProvider.getFactory());
                Category cat = categoryDao.getCategorybyId(categoryId);
        %>

            <form action="ProductOperationServlet" method="post">

                <input type="hidden" name="operation" value="editcategory">
                <input type="hidden" name="catId" value="<%= cat.getCategoryId()%>">
                <div class="mb-3">
                    <label for="name">Category name:</label>
                    <input type="text" name="catName" value="<%= cat.getCategoryTitle() %>">
                </div>
                <div class="mb-3">
                    <label for="name">Category description:</label>
                    <textarea  name="catDesc" style="height: 150px;" class="form-control" placeholder="Description"><%= cat.getCategoryDescription()%></textarea>
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
