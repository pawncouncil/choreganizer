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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Update User</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css?family=Amatic+SC" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
	<h1>Update ${currUser.first} Info</h1>
	<fieldset>
	    <form:form method="POST" action="/user/${currUser.id}/update" modelAttribute="user">
	        <p><form:input path="email" value="${currUser.email}"/><br><form:errors path="email" class="text text-danger"/></p>
	        <p><form:input path="first" value="${currUser.first}"/><br><form:errors path="first" class="text text-danger"/></p>
	        <p><form:input path="last" value="${currUser.last}"/><br><form:errors path="last" class="text text-danger"/></p>
    		<p><form:input type="tel" path="phone"
	           value="${currUser.phone}"
	           pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}"
	           required= "true" />
	        <input type="submit" value="Update" class="btn btn-dark"/>
	    </form:form>
   </fieldset> 
</body>
</html>