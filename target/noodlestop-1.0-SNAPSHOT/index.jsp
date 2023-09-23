<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Home - NoodleStop</title>
        <link rel="stylesheet" href="css/index.css">
        <%@include file="components/common_css_js.jsp"%>
        
        
    </head>
    <body>
        <%@include file="components/navbar.jsp"%>
        <!--<div class="container">-->

    <section class="welcome">
        <div class="container">
            <div class="text-container">
                <h1>Welcome!</h1>
                
                <button class="btn buttonwelcome" ><a style="text-decoration: none!important;" href="home.jsp">Feel free to take a look at our menu!</a></button>
            </div>
            <div class="images">
                <img src="img/products/food 5.png" alt="" class="left-img">
                <img src="img/products/food 4.png" alt="" class="middle-img">
                <img src="img/products/food.png" alt="" class="right-img">
            </div>
        </div>
    </section>
         <%@include file="components/common_modals.jsp" %>
    </body>
</html>
