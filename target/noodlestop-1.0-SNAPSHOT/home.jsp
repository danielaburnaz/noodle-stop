<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Homepage</title>
        <%@include file="components/common_css_js.jsp"%>
        <link rel="stylesheet" href="css/home.css">

        <!--add on mobile dropdown instead of list-->
        <style>
            .discount-label{
/*                font-size:14px!important;*/
                font-style: italic!important;
                text-decoration: line-through!important;
            }
            @media(min-width: 768px){
                .visible{
                    display: none;
                }
            }
            @media (max-width: 1000px){
                  /* For mobile phones: */
                [class*="col-sm-"] {
                  width: 50%;
                }
            }
            @media (max-width: 650px){
                  /* For mobile phones: */
                [class*="col-sm-"] {
                  width: 100%;
                }
            }            
        </style>

    </head>
    <body>
        <%@include file="components/navbar.jsp"%>
        
        <section class="image-section"></section>
        <div class="container-fill">
            <div class="row mt-3 mx-2">
                <% 
                    String cat = request.getParameter("category");
                    
                    ProductDao dao = new ProductDao(FactoryProvider.getFactory());
                    List<Product> list = null;
                    if (cat == null) {
                        cat = "all"; //default
                    }
                    if(cat.trim().equals("all")){
                        list = dao.getAllProducts();
                    } else {
                        int cId = Integer.parseInt(cat.trim());
                        list = dao.getAllProductsById(cId);
                    }
                    
                    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                    List<Category> catList = cdao.getCategories();

                %>
                <div class="col-md-2">
                    <!-- Dropdown menu visible only at max-width: 1000px -->
                    <div class="list-group mt-4 d-none d-md-block"> <!-- Hidden for screens larger than md -->
                        <a href="home.jsp?category=all" style="
                           background:#8b7b7e!important;
                           color:white!important;
                           border-color:#8b7b7e!important;"
                        class="list-group-item list-group-item-action active" aria-current="true">
                            All Products
                        </a>
                        <% for(Category c:catList){ %>
                        <a href="home.jsp?category=<%= c.getCategoryId()%>" class="list-group-item list-group-item-action">
                            <%= c.getCategoryTitle()%>
                        </a>
                        <% } %>
                    </div>

                    <!-- Add a button to toggle the dropdown menu for screens smaller than md -->
                    <button class="btn btn-secondary btn-lg visible" type="button" data-bs-toggle="collapse" data-bs-target="#categoryDropdown" aria-expanded="false">
                        Categories
                    </button>

                    <!-- The dropdown menu for screens smaller than md -->
                    <div id="categoryDropdown" class="collapse d-md-none">
                        <a href="home.jsp?category=all" style="
                           background:#8b7b7e!important;
                           color:white!important;
                           border-color:#8b7b7e!important;"
                           class="list-group-item list-group-item-action active" aria-current="true">
                            All Products
                        </a>
                        <% for(Category c:catList){ %>
                        <a href="home.jsp?category=<%= c.getCategoryId()%>" class="list-group-item list-group-item-action">
                            <%= c.getCategoryTitle()%>
                        </a>
                        <% } %>
                    </div>
                </div>

                    <!--show products-->
                <div class="col-md-9">

                    <!--row-->
                    <div class="row mt-4">
                            <%
                            String currentCategoryTitle = "All Products"; // default category
                            String currentCategoryDescription = ""; // default desc
                            if (cat != null) {
                                    try {
                                        int categoryId = Integer.parseInt(cat.trim());
                                        for(Category c:catList){    
                                            if (c.getCategoryId() == categoryId) {
                                                currentCategoryTitle = c.getCategoryTitle();
                                                currentCategoryDescription = c.getCategoryDescription();
                                                break; 
                                            }
                                        }
                                    } catch (NumberFormatException e) {
                                        e.printStackTrace();
                                    }
                                }
                            %>
                            <h1><%= currentCategoryTitle %></h1>
                            <h2><%= currentCategoryDescription %></h2>
                                <!--fetching products-->
                                <%
                                    for(Product p:list){
                                %>
                                <div class="col-xs-12 col-sm-4 pb-3">
                                    <div class="card h-100 d-flex flex-column justify-content-between align-items-center text-center">
                                        <!--<div class="container">-->
                                            <img src="img/products/<%= p.getpPhoto()%>" style="max-height: 300px; max-width: 100%; width: auto;border: 5px;border-radius: 10px;" class="card-img-top p-2">
                                        <!--</div>-->
                                        <div class="card-body">
                                            <h3 class="card-title">
                                                <%= p.getpName()%>
                                            </h3>
                                            <p class="card-text">
                                                <%= Helper.get10Words(p.getpDesc())%>
                                            </p>
                                        </div>
                                        <div class="footer pb-3 buttons">
                                            <button class="btn button pl-4 pr-4" onclick="add_to_cart(<%= p.getpId() %>, '<%= p.getpName() %>', <%= p.getPriceAfterApplyingDiscount() %> )">
                                                <% if (p.getpDiscount() != 0) { %>
                                                    <span class="discount-label">
                                                        <%= p.getpPrice()%>
                                                       <!-- < % = p.getpDiscount() >% off-->
                                                    </span>
                                                <% } %>
                                                <%= p.getPriceAfterApplyingDiscount() %> $
                                            </button>              
                                        </div>
                                    </div>
                                </div>
                                <%}
                                    if(list.size()==0){
                                        out.println("<h2>No items in this category :(</h2> ");
                                    }
                                    
                                %>                    
                    </div>
                </div>
            </div>
        </div>
        
        <%@include file="components/common_modals.jsp" %>
    </body>
</html>
