<%@page import="com.learn.mycart.entities.User"%>
<%
    User user1 =(User)session.getAttribute("user_type");
%>
<nav style="z-index: 1!important"class="navbar navbar-expand-lg navbar-light custom-bg">
    <div class="container">
<!--          <div  class="container-fluid">-->
            
            <a class="navbar-brand" id="link" href="index.jsp"><img src="img/Noodle-stop.png" alt="logo" class="logo" style="height: 100%; width: 200px;"></a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="navbar-nav ml-auto">
                  <li class="nav-item active">
                      <a class="nav-link" href="#!" data-bs-toggle="modal" data-bs-target="#cart"><span class="bi bi-cart" style="font-size: 19px"><span class=" cart-items">()</span></span></a>
                  </li>
                <%
                    if(user1==null){
                      
                    %>
                      
                  <li class="nav-item">
                    <a class="nav-link active" href="login.jsp">Login</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link active" href="sign_up.jsp">Sign up</a>
                  </li>
                <%  }else{
                    
                %>
                  <li class="nav-item">
                    <a class="nav-link active"
                       <%if (user1.getUserType().equals("admin")){
                       %>href="admin.jsp"<%
                       }else{
                       %>href="customer.jsp"<%
                       }%>><%= user1.getUserName() %>
                    </a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link active" href="LogoutServlet">Logout</a>
                  </li>
             
                <%  }
                %>
                  
              </ul>
            </div>
          <!--</div>-->
    </div>
</nav>