
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Login - NoodleStop</title>
        <%@include file="components/common_css_js.jsp"%>

    </head>
    <body>
        <%@include file="components/navbar.jsp"%>
<!-- add background with food
    hashmap password-->
    <div class="card-body">
        <div class="container-fluid position-absolute top-50 start-50 translate-middle">
            <div class="row ">
                <div class="col-md-4 offset-md-4 square">
                    <%@include file="components/message.jsp"%>
                    
                   <h3 class="text-center my-3" style="font-weight: 600">Login</h3>
                   <form action="LoginServlet" method="post">
                        <div class="form-group mt-3">
                            <label for="email" class="form-label">Email</label>
                            <input name="user_email" type="email" class="form-control" id="email" placeholder="maria@mail.com">
                        </div>
                        
                        <div class="form-group mt-3">
                            <label for="password" class="form-label">Password</label>
                            <input name="user_password" type="password" class="form-control" id="password" placeholder="...">
                        </div>
                        <div class="form-group text-center mt-3">
                            <button class="btn button">
                                Login
                            </button>
                        </div>
                       
                       <div class="form-group text-center mt-3">
                           Don't have an account? Create one <a href="sign_up.jsp">here</a>
                       </div>

                    </form>
                   
                </div>
            </div>
        </div>
    </div>
        <%@include file="components/common_modals.jsp" %>
    </body>
</html>
