<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chorganizer</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Amatic+SC" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
    <script>
	    $(document).ready(function(){
		    	// Get the modal
		        var modal = document.getElementById("myModal");
		    	
		    	 // Get the second modal
	            var modal2 = document.getElementById("myModal2");
	
	            // When the user clicks the login button, open the modal
	            $("#myBtn").click(function() {
	                $(modal).show()
	                $(modal2).hide();
	            });
	            
	            // When the user clicks the register button, open the modal
	            $("#myBtnTwo").click(function() {
	                $(modal2).show();
	                $(modal).hide();
	            });
	
	            // When the user clicks on <span> (x), close the modal
	            $(".close").first().click(function() {
	            	$(modal).hide();
	            });
	            
	            $(".close").last().click(function() {
	            	$(modal2).hide();
	            });
	
	            // When the user clicks anywhere outside of the modal, close it
	            $(window).click(function(event) {
	                if (event.target == modal) {
	                	$(modal).hide();
	                }
	                if (event.target == modal2) {
	                	$(modal2).hide();
	                }
	            });
	        });
   	</script>
   	<style>
   	  body	{
      	margin: 0;
      	padding: 0;
	  }
	   
	  a	{
	      color: black;
	      text-decoration: none;
	      font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
	      font-size: 16px;
	  }
	  
	  .modal {
	      display: none;
	      position: fixed;
	      z-index: 1;
	      padding-top: 100px;
	      left: 0;
	      top: 0;
	      width: 40%;
	      height: 100%;
	      overflow: auto;
	      background-color: rgb(0,0,0);
	      background-color: rgba(0,0,0,0.4);
	      margin-left: 400px;
	  }
	
	  .modal-content {
	      background-color: #fefefe;
	      margin: auto;
	      padding: 20px;
	      border: 1px solid #888;
	      width: 80%;
	  }
	  
	  .close {
	      color: #aaaaaa;
	      float: right;
	      font-size: 28px;
	      font-weight: bold;
	  }
	
	  .close:hover, .close:focus {
	      color: #000;
	      text-decoration: none;
	      cursor: pointer;
	  }
	    
	  .header	{
	      position: relative;
	      z-index: 100;
	      height: 45px;
	      text-align: center;
	      background: #444; 
	      height: 45px;
	      padding-left: 10px;
	      padding-top: 10px;
	      width: auto;
	  }
	  
	  #myBtnTwo	{
	      background-color:transparent;
	      display:inline-block;
	      cursor:pointer;
	      color:#ffffff;
	      font-family:Arial;
	      font-size:14px;
	      text-decoration:none;
	      margin-left: 10px;
	  }
	  
	  #myBtn	{
	      background-color:transparent;
	      display:inline-block;
	      cursor:pointer;
	      color:#ffffff;
	      font-family:Arial;
	      font-size:14px;
	      text-decoration:none;
	      margin-left: 370px;
	  }
	  
	  #logo	{
	      color: rgb(0, 225, 255);
	      font-family: 'Amatic SC', cursive;
	      vertical-align: top;
	      margin-left: 500px;
	      font-size: 35px;
	      display: inline;
	  }
	  
	  #logo:hover	{
	  	color: white;
	  }
	  
	  .homebutton	{
	      size: 7px;
	      color: white;
	  }
	  
	  .homebutton:hover, #myBtn:hover, #myBtnTwo:hover {
	  	color: rgb(0, 225, 255);
	  }
	  
	  .logolink:hover {
	      text-decoration: none;
	  }
   	</style>
</head>
<body>
 <!-- The Header -->
    <div class="header">
        <a class="homebutton" href="/home"><i class="fas fa-home"></i></a>
        <a href="/home"class="logolink"><h1 id="logo">Choreganizer</h1></a>
        <a id="myBtn" >Login</a>
        <a id="myBtnTwo" >Register</a>
    </div>
    
    <c:if test="${logout != null}">
        <p><c:out value="${logout}"></c:out></p>
    </c:if>
    <c:if test="${logError != null}">
	     <p>${logError}</p>
	</c:if>
    <!-- The Modal for Login -->
    <div id="myModal" class="modal">
	    <!-- Modal content to login -->
	    <div class="modal-content">
	    	<span class="close">&times;</span>
	    	<h1>Login</h1>
		    <form method="POST" action="/login">
		        <p>Email: </p><input type="text" name="username"/>
		        <p>Password: </p><input type="password" name="password"/>
		        <input type="hidden"  name="${_csrf.parameterName}" value="${_csrf.token}"/>
		        <br><br><input type="submit" value="Login" class="btn btn-dark"/>
		    </form>
		</div>
    </div>
    
     <!-- The Modal for Registering -->
    <div id="myModal2" class="modal">
        <!-- Modal content to register -->
        <div class="modal-content">
            <span class="close">&times;</span>
           	<h1>Register</h1>
			<fieldset>
			    <p><form:errors path="user.*"/></p>
			    <form:form method="POST" action="/register" modelAttribute="user">
			        <p><form:label path="email">Email: </form:label><br><form:input path="email"/></p>
			        <p><form:label path="first">First Name: </form:label><br><form:input path="first"/></p>
			        <p><form:label path="last">Last Name: </form:label><br><form:input path="last"/></p>
			        <form:label path="phone">Phone: </form:label><br>
		    		<p><form:input type="tel" path="phone" name="phone"
			           placeholder="123-456-7890"
			           pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}"
			           required= "true" />
			   	 	<span class="validity"></span></p>
			        <p><form:label path="password">Password: </form:label><br><form:password path="password"/></p>
			        <p><form:label path="confirm">Confirm Password: </form:label><br><form:password path="confirm"/></p>
			        <input type="submit" value="Register" class="btn btn-dark"/>
			    </form:form>
		   </fieldset> 
   		</div>
   </div>
    
</body>
</html>