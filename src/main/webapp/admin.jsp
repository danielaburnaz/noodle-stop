<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="java.util.Map"%>
<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.entities.User"%>
<%
    User user =(User)session.getAttribute("user_type");
    if (user==null){
        session.setAttribute("error_message", "In order to proceed, you must first login.");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if(user.getUserType().equals("customer")){
            session.setAttribute("error_message", "Your account does not have admin privileges.");
            response.sendRedirect("login.jsp");
            return;
        }
    }
%>
<%
    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> list = cdao.getCategories();
    
    ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
    List<Product> pList = pdao.getAllProducts();
    
    //get count
    Map<String,Long> m = Helper.getCounts(FactoryProvider.getFactory());
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Admin Panel</title>
        <%@include file="components/common_css_js.jsp"%>
        <style>
        .admin .card:hover{
            background: #f2f2f2;
            cursor:pointer;
        }
        </style>
    </head>
    <body>
        <%@include file="components/navbar.jsp"%>
        <div class="container admin">
            
            <div class="container-fluid">
                <%@include file="components/message.jsp"%>
            </div>
            
            <div class="row mt-3">
                <!-- 1 -->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <!--<div class="container">-->
                                <img style="max-width: 120px;" class="img-fluid rounded-circle" src="img/user.png">
                            <!--</div>-->
                            <!--//if user.size==1display user h1-->
                            <h1><%= m.get("userCount")%></h1>
                           <h1>Users</h1> 
                        </div>
                    </div>
                </div>
                
                <!--2 -->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center" data-bs-toggle="modal" data-bs-target="#edit-category-modal">
                            <!--<div class="container">-->
                                <img style="max-width: 120px;" class="img-fluid" src="img/category.png">
                            <!--</div>-->
                            <h1><%= list.size()%></h1>
                           <h1>Categories</h1> 
                        </div>
                    </div>                    
                </div>
                
                <!--3 -->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center" data-bs-toggle="modal" data-bs-target="#edit-products-modal">
                            <!--<div class="container">-->
                                <img style="max-width: 120px;" class="img-fluid" src="img/product.png">
                            <!--</div>-->
                            <h1><%= m.get("productCount")%></h1>
                            <h1>Products</h1> 
                        </div>
                    </div>                    
                </div>
            </div>
            
            <div class="row mt-3 justify-content-center"> <!--center this -->
                <!--4 -->
                <div class="col-md-4">    
                    <div class="card" data-bs-toggle="modal" data-bs-target="#add-category-modal">
                        <div class="card-body text-center">
                            <!--<div class="container">-->
                                <img style="max-width: 120px;" class="img-fluid" src="img/addCategory.png">
                            <!--</div>-->
                           <h1>Add category</h1> 
                        </div>
                    </div>                    
                </div>
                
                <!--5 -->
                <div class="col-md-4">                    
                    <div class="card" data-bs-toggle="modal" data-bs-target="#add-product-modal">
                        <div class="card-body text-center">
                            <!--<div class="container">-->
                                <img style="max-width: 120px;" class="img-fluid" src="img/addProduct.png">
                            <!--</div>-->
                           <h1>Add products</h1> 
                        </div>
                    </div>                    
                </div>
                
            </div>
        </div>
                <!-- Edit/Delete Categories Modal -->
        <div class="modal fade" id="edit-category-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Edit Product:</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                  <form action="ProductOperationServlet" method="post">
                      
                      
                      <div class="container text-center">
                        <% for (Category c : list) { %>
                        <!--<button class="btn button">-->
                          <a class="btn button" href="edit-category.jsp?id=<%= c.getCategoryId() %>"><%= c.getCategoryTitle()%></a>
                        <!--</button>-->
                      <% } %>
                      </div>
                  </form>
                  
              </div>
            </div>
          </div>
        </div>

        <!-- Edit/Delete Products Modal -->
        <div class="modal fade" id="edit-products-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Edit Product:</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                  <form action="ProductOperationServlet" method="post">
                      
                      
                      <div class="container text-center">
                        <% for (Product p : pList) { %>
                        <!--<button class="btn button">-->
                          <a class="btn button" href="edit-product.jsp?id=<%= p.getpId() %>"><%= p.getpName()%></a>
                        <!--</button>-->
                      <% } %>
                      </div>
                  </form>
                  
              </div>
            </div>
          </div>
        </div>
        <!-- Add Category Modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">New Category Details:</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                  <form action="ProductOperationServlet" method="post">
                      
                      <input type="hidden" name="operation" value="addcategory"/>
                      
                      <div  class="form-group">
                          <input type="text" class="form-control" name="catTitle" placeholder="Title" required/>
                      </div>
                      
                      <div class="form-group mt-3">
                          <textarea style="height: 150px;" class="form-control" placeholder="Description" name="catDescription" required></textarea>
                      </div>
                      
                      <div class="container text-center">
                          <button class="btn button">Add Category</button>
                      </div>
                  </form>
                  
              </div>
            </div>
          </div>
        </div>
        
        <!-- Add Product Modal -->

        <div class="modal fade" id="add-product-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">New Product Details:</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                  <form action="ProductOperationServlet" method="post"enctype="multipart/form-data">
                      
                      <input type="hidden" name="operation" value="addproduct"/>
                      
                      <!--title-->
                      <div  class="form-group">
                          <input type="text" class="form-control" name="pName" placeholder="Title" required/>
                      </div>
                      <!--description-->
                      <div  class="form-group mt-3">
                          <textarea style="height: 150px;" class="form-control" name="pDesc" placeholder="Product description..." required></textarea>
                      </div>
                      <!--price-->
                      <div  class="form-group mt-3">
                          <input type="number" class="form-control" name="pPrice" placeholder="Price" required/>
                      </div>
                      <!--discount? I might remove this later-->
                      <div  class="form-group mt-3">
                          <input type="number" class="form-control" name="pDiscount" placeholder="Discount" required/>
                      </div>
                      <!--quantity-->
                      <div  class="form-group mt-3">
                          <input type="number" class="form-control" name="pQuantity" placeholder="Quantity" required/>
                      </div>
                      
                      <!--category-->
                      
                      
                      
                      <div  class="form-group mt-3">
                          <select name="catId" class="form-control" id="">
                              <% for (Category c : list) {%>
                              <option value="<%= c.getCategoryId()%>"><%= c.getCategoryTitle()%></option>
                              <%} %>
                          </select>
                      </div>
                      
                      <!--product image-->
                      <div  class="form-group mt-3">
                          <label for="pPic">Select an image of the product:</label>
                          <br>
                          <input type="file" name="pPic" required/>
                      </div>
                      
                      
                      <div class="container text-center">
                          <button class="btn button">Add Product</button>
                      </div>
                      
                  </form>   
              </div>
            </div>
          </div>
        </div>
        
    </body>
</html>
