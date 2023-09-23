<%@page import="com.learn.mycart.entities.User"%>
<%
    User user = (User) session.getAttribute("user_type");
        if(user==null){
            session.setAttribute("error_message", "Please login to proceed.");
            response.sendRedirect("login.jsp");
            return;
    }
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Information</title>
    <%@include file="components/common_css_js.jsp"%>
    <%@include file="components/message.jsp"%>
    <%@include file="components/common_modals.jsp"%>
</head>
<body>
    <%@include file="components/navbar.jsp"%>
    <div class="container">
        <div class="container-fluid">
            <div class="row">
                <h2>User Information</h2>

                    <div class="card">
                        <div class="card-body">
                            <h1 class="text-center">Review your details:</h1>
                            <form action="UpdateUserInfo" method="post">
                                <input type="hidden" name="operation" value="edituser"></div>
                                <div class="mb-3">
                                    <label for="name">Your name:</label>
                                    <input value="<%= user.getUserName()%>" name="userName" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Mara">
                                </div>
                                <div class="mb-3">
                                    <label for="email">Email address</label>
                                    <input value="<%= user.getUserEmail()%>" name="userEmail" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Mara">
                                </div>
                                <div class="mb-3">
                                    <label for="name">Phone number:</label>
                                    <input value="<%= user.getUserPhone()%>" name="userPhone" type="text" class="form-control" id="phone" aria-describedby="emailHelp" placeholder="Mara">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleFormControlTextarea1">Shipping address:</label>
                                    <textarea name="userAddress" class="form-control" id="exampleFormControlTextarea1" rows="3"><%= user.getUserAddress() %></textarea>
                                </div>
                                <div class="mb-3">
                                    <button class="btn btn-success" type="submit">Save</button>
                                    <p>Delete account? Warning! This action cannot be undone</p>
                                    <button class="btn btn-danger" type="submit" name="delete">Delete</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
    </div>
</body>
</html>
