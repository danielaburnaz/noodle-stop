<%
  String message = (String) session.getAttribute("message");
  String error_message =(String) session.getAttribute("error_message");
  if(message!=null){
  
//    out.println(message);
%>
<div class="alert alert-warning alert-dismissible fade show" role="alert">
    <strong> <%= message%> </strong>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
  
<%    
    session.removeAttribute("message");
    
    }
    if(error_message!=null){
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    <strong> <%= error_message%> </strong>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>

<%
    session.removeAttribute("error_message");
    }
%>