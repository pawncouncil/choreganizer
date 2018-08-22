<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
   
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>User Dash</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Amatic+SC" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
	<div id="wrapper">
	<div class="headers">
        <h1 id="logo">House ${house.name}</h1>
         <a href="/logout" class="headera">Logout</a>
    </div>
    <div class="container">
	    <div class="user">
	        <h1>Welcome Home, ${user.first}!</h1>
	        <table style="text-align: left; outline: 1px black solid;">
	            <tr style="margin: 5px;">
	                <td style="padding: 5px;">Name: ${user.first} ${user.last}</td>
	               <%--  <td style="padding: 5px;">${user.first} ${user.last}</td> --%>
	            </tr>
	            <tr style="margin: 5px;">
	                <td style="padding: 5px;">Phone #: ${user.phone}</td>
	               <%--  <td style="padding: 5px;">${user.phone}</td> --%>
	            </tr>
	            <tr style="margin: 5px;">
	                <td style="padding: 5px;">Email: ${user.email}</td>
	                <%-- <td style="padding: 5px;">${user.email}</td> --%>
	            </tr>
	            <tr style="margin: 5px;">
	                <td style="padding: 5px;">House member since: <fmt:formatDate pattern = "MMMMM dd, yyyy" value="${user.createdAt}"></fmt:formatDate></td>
	                <%-- <td style="padding: 5px;"><fmt:formatDate pattern = "MMMMM dd, yyyy" value="${user.createdAt}"></fmt:formatDate></td> --%>
	            </tr>
	            <tr style="margin: 5px;">
	                <td style="padding: 5px;">Last Sign In: <fmt:formatDate pattern = "MMMMM dd, yyyy" value="${user.lastSignIn}"></fmt:formatDate></td>
	               <%--  <td style="padding: 5px;"><fmt:formatDate pattern = "MMMMM dd, yyyy" value="${user.lastSignIn}"></fmt:formatDate></td> --%>
	            </tr>
	        </table>
		</div>
		<div class="scroll">
			<table class="table table-ruled">
				<thead>
				  <tr>
				    <th>Chore</th>
				    <th>Description</th>
				    <!-- <th>Creator</th> -->
				    <th>Assignee</th>
				    <th>Priority</th>
				    <th>Status</th>
				  </tr>
				</thead>
				<tbody>
				 <c:forEach items="${chores}" var="chore"> 
				  <tr>
				  	<td>${chore.title}</td>
				    <td>${chore.description}</td>
				    <td>${chore.assignee.first}</td>
				    <c:if test="${chore.priority == 1 }">
				    <td><c:out value="Low"/></td></c:if>
				    <c:if test="${chore.priority == 2 }">
				    <td><c:out value="Medium"/></td></c:if>
				    <c:if test="${chore.priority == 3 }">
				    <td><c:out value="High"/></td></c:if>
				    <c:choose>
					    <c:when test="${chore.assignee == user }">
					    <td><a href="/chores/${chore.id}/delete">Completed</a></td></c:when>
					    <c:otherwise>
					    <td><a href="#">Not Completed</a></td></c:otherwise>
				    </c:choose>
				  </tr>
				</c:forEach>
			  </tbody>
			</table>
		</div>
		</div>
	</div>
</body>
</html>