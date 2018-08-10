<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chorganizer</title>
    <link rel="stylesheet" type="text/css" href="/css/homepage.css">
    <link rel="stylesheet" type="text/css" href="/css/sunrise.css">
	<script type="text/javascript" src="js/app.js"></script>
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
</head>
<body onmouseup="stopMove();" onresize="windowResize();">
 <!-- The Header -->
    <div class="header">
        <a class="homebutton" href="/home"><i class="fas fa-home"></i></a>
        <a href="/home"class="logolink"><h1 id="logo">Choreganizer</h1></a>
        <a id="myBtn" >Login</a>
        <a id="myBtnTwo" >Register</a>
    </div>
    
    <c:if test="${logout != null}">
   		<div class="alert alert-danger">
        	<p><c:out value="${logout}"></c:out></p>
        </div>
    </c:if>
    <c:if test="${logError != null}">
	    <div class="alert alert-danger">
		     <p>${logError}</p>
		</div>
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
   <!-- SunSet Backgound -->
    <div id="starsContainer" onmousedown="startMove();" onmouseup="stopMove();">
    	<div id="stars" onmousedown="startMove();" onmouseup="stopMove();"></div>
  	</div>

    <div id="sun" onmousedown="startMove();" onmouseup="stopMove();"></div>

  <div id="sunDay" onmousedown="startMove();" onmouseup="stopMove();"></div>

  <div id="sunSet" onmousedown="startMove();" onmouseup="stopMove();"></div>

  <div id="sky" onmousedown="startMove();" onmouseup="stopMove();"></div>

  <div class="star" style="left: 250px; top: 30px;"></div>
  <div class="star" style="left: 300px; top: 25px;"></div>
  <div class="star" style="right: 40px; top: 40px;"></div>
  <div class="star" style="right: 80px; top: 45px;"></div>
  <div class="star" style="right: 120px; top: 20px;"></div>

  <div id="horizon" onmousedown="startMove();" onmouseup="stopMove();"></div>

  <div id="horizonNight" onmousedown="startMove();" onmouseup="stopMove();"></div>

  <div id="moon" onmousedown="startMove();" onmouseup="stopMove();"></div>
  
  <div id="mountainRange">
    <div id="mountain" onmousedown="startMove();" onmouseup="stopMove();">
  </div>

  </div>

  <div id="division" onmousedown="startDraggingDivision();" onmouseup="stopMove();">

  </div>

  <div id="water" onmousedown="startMove();" onmouseup="stopMove();"></div>

  <div id="waterReflectionContainer" onmousedown="startMove();" onmouseup="stopMove();">
    <div id="waterReflectionMiddle" onmousedown="startMove();" onmouseup="stopMove();">

    </div>
  </div>
  <div id="waterDistance"  onmousedown="startMove();" onmouseup="stopMove();"></div>
  <div id="darknessOverlaySky"  onmousedown="startMove();" onmouseup="stopMove();"></div>
  <div id="darknessOverlay"></div>
  <div id="oceanRippleContainer"></div>
  <div id="oceanRipple"></div>
</body>
</html>