<%
    User user = (User) session.getAttribute("user_type");
        if(user==null){
            session.setAttribute("error_message", "Please login to proceed with your order.");
            response.sendRedirect("login.jsp");
            return;
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="components/common_css_js.jsp"%>

    </head>
    <body>
        <%@include file="components/navbar.jsp"%>
        <div class="container">
            <div class="row mt-5">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h1>Items in your cart:</h1>
                            <!--yeah "cart"  not card-->
                            <div class="cart-body">

                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h1 class="text-center">Review your details:</h1>
                            <form>
                            <div class="mb-3">
                                <label for="name">Your name:</label>
                                <input value="<%= user.getUserName()%> <%= user.getUserLastName()%>" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Mara">
                            </div>
                            <div class="mb-3">
                                <label for="email">Email address</label>
                                <input value="<%= user.getUserEmail()%>" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Mara">
                            </div>
                            <div class="mb-3">
                                <label for="name">Phone number:</label>
                                <input value="<%= user.getUserPhone()%>" type="text" class="form-control" id="phone" aria-describedby="emailHelp" placeholder="Mara">
                            </div>
                            <div class="mb-3">
                                <label for="exampleFormControlTextarea1">Shipping address:</label>
                                <textarea class="form-control" id="exampleFormControlTextarea1" rows="3"><%= user.getUserAddress() %></textarea>
                            </div>
                            <button type="submit" class="btn button order-now" onclick="checkCart()">Order now</button>
                                <script>
                                    
                                </script>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <%@include file="components/common_modals.jsp" %>
    </body>
</html>
