<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collections"%>
   
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="/css/style.css">
	<script type="text/javascript" src="js/app.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Edit Chore</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
	<div class="container">
        <a href="/logout" class="pull-right">Logout</a>
        <h1>Edit: ${chore.title}</h1>
		<table class="table table-ruled table-striped">
			<thead>
			  <tr>
			    <th>All Chores</th>
			    <th>Descriptions</th>
			    <th>Assignee</th>
			    <th>Priority</th>
			    <th>Actions</th>
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
				<td>
					<a href="/chores/${chore.id}/edit">Edit  |</a>
					<a href="/chores/${chore.id}/delete">  Delete</a>
				</td>
			  </tr>
			</c:forEach>
		  </tbody>
		</table>
		<form:form method="POST" action="/chores/${chore.id}/edit" modelAttribute="chore">
	    
	    	<form:input path="title"/>
	    	<p>Chore<br></p>
	       
	       <form:input path="description"/>
	        <p>Description<br> </p>
	     
	       <form:select path="assignee" >
	            <c:forEach items="${users}" var="x">
	                <form:option value="${x.id}">${x.first}</form:option>
	            </c:forEach>
	        </form:select>
	        <p>Assignee</p>
			
			 <form:select path="priority">
					<form:option value="1">Low</form:option>
					<form:option value="2">Medium</form:option>
					<form:option value="3">High</form:option>
			</form:select>
			<p>Priority</p>
	       				       
	        <input type="submit" value="Update"/>
	        <a href="/" class="button">Done</a>
	    </form:form>
	    	
	</div>
</body>
</html>