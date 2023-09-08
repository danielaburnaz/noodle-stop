<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Sign up - NoodleStop</title>
        <%@include file="components/common_css_js.jsp"%>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">		
	<style>
            .input-group-append {
		cursor: pointer;
            }
	</style>
        
    </head>
    <body>
        <%@include file="components/navbar.jsp"%>
        <div class="container-fluid">
            <div class="row ">
                <div class="col-md-4 offset-md-4 square">
                    <%@include file="components/message.jsp"%>
                    
                    
                    <h3 class="text-center my-3" style="font-weight: 600">Create a new account</h3>
                    <form action="SignupServlet" method="post">
                        
                        <div class="form-group">
                            <label for="name" class="form-label">First name:</label>
                            <input name="user_name" type="text" class="form-control" id="name" placeholder="Maria">
                        </div>
                        
                        <div class="form-group mt-3">
                            <label for="last-name" class="form-label">Last name:</label>
                            <input name="user_lastname" type="text" class="form-control" id="lastname" placeholder="Andreescu">
                        </div>
                        <div class="form-group mt-3">
                            <label for="email" class="form-label">Email:</label>
                            <input name="user_email" type="email" class="form-control" id="email" placeholder="maria@mail.com">
                        </div>
                        <div class="form-group mt-3">
                            <label for="password" class="form-label">Password:</label>
                            <input name="user_password" type="password" class="form-control" id="password" placeholder="...">
                        </div>
                        <div class="form-group mt-3">
                            <label for="phone" class="form-label">Phone number:</label>
                            <input name="user_phone" class="form-control" id="phone" placeholder="+40700999888">
                        </div>

                        <div class="form-group mt-3">
                            <label for="address" class="form-label">Address:</label>
                            <textarea name="user_address" class="form-control" placeholder="Enter your address"></textarea>
                        </div>
                        <!--if user is not 13 do not create account-->
                        <div class="form-group mt-3">
                            <label for="user_dob">Date of Birth:</label>
                            <input type="date" class="form-control" id="user_dob" name="user_dob" required>
                        </div>

                        <div class="form-group text-center mt-3">
                            <button class="btn button">
                                Sign up
                            </button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
        <%@include file="components/common_modals.jsp" %>
    </body>


<!--     Add Bootstrap JS and jQuery links here 
-->    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- Add Bootstrap Datepicker JS link here -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
    <script>
        // Initialize the datepicker
        $(document).ready(function() {
            $("#user_dob").datepicker({
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayHighlight: true
            });
        });
    </script>

</html>
