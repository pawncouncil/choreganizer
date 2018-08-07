<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login/Register</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css?family=Pacifico" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/css/styles.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script>
    $(document).ready(function(){
	    	// Get the modal
	        var modal = document.getElementById("myModal");
	    	
	    	 // Get the second modal
            var modal2 = document.getElementById("myModal2");
	
	        // Get the login button that opens the modal
	        var btn = document.getElementById("myBtn");
	
	        // Get the register button that opens the modal
            var btn2 = document.getElementById("myBtn2");
	        
	        // Get the <span> element that closes the modals
	        var span = document.getElementsByClassName("close")[0];
			
	        // Get the <span> element that closes the modals
	        var span2 = document.getElementsByClassName("close")[1];

            // When the user clicks the login button, open the modal
            btn.onclick = function() {
                modal.style.display = "block";
            }
            
            // When the user clicks the register button, open the modal
            btn2.onclick = function() {
                modal2.style.display = "block";
            }

            // When the user clicks on <span> (x), close the modal
            span.onclick = function() {
                modal.style.display = "none";
            }
            
            span2.onclick = function() {
                modal2.style.display = "none";
            }

            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function(event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                } else {
                	modal.style.display = "block";
            	}
            }

            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function(event) {
                if (event.target == modal2) {
                    modal2.style.display = "none";
                } else {
                	modal2.style.display = "block";
                }
            }
        });
    </script>
</head>
<body>
 <!-- The Header -->
    <div class="header">
        <a class="homebutton" href="/home"><i class="fas fa-home"></i></a>
        <a href="/home"class="logolink"><h1 id="logo">Choreganizer</h1></a>
        <a id="myBtn" >Login</a>
        <a id="myBtn2" >Register</a>
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
		    <form method="POST" action="/login" class="logForm">
		        <p>Email: </p><input type="text" name="username"/>
		        <p>Password: </p><input type="password" name="password"/>
		        <input type="hidden"  name="${_csrf.parameterName}" value="${_csrf.token}"/>
		        <br><br><input type="submit" value="Login" class="btn btn-dark"/>
		    </form>
		</div>
    </div>
    
     <!-- The Modal for Registering -->
    <div id="myModal2" class="modal2">
        <!-- Modal content to register -->
        <div class="modal-content2">
            <span class="close">&times;</span>
           	<h1>Register</h1>
			<fieldset>
			    <p><form:errors path="user.*"/></p>
			    <form:form method="POST" action="/register" modelAttribute="user" class="regForm">
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