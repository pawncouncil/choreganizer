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
    <title>Admin Dash</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
    <div class="container">
        <a href="/logout" class="pull-right">Logout</a>
        <h1>Welcome, ${user.first}</h1>
        <table class="table table-ruled table-striped">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Actions</th>
                    <th>Last Login</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${allUsers}" var="single">
                    <tr>
                        <td>${single.first} ${single.last}</td>
                        <td>${single.email}</td>
                        <c:if test="${user.getRoles().size() > 2}">
                            <td>
                                <c:if test="${single.getRoles().size() == 3}">Super Admin</c:if>
                                <c:if test="${single.getRoles().size() != 3}">
                                    <c:if test="${single == user}">Admin</c:if>
                                    <c:if test="${single != user}">
                                        <a href="/delete/${single.id}">Delete</a>
                                        <c:if test="${single.getRoles().size() == 1}"> | <a href="/make-admin/${single.id}">Make Admin</a></c:if>
                                        <c:if test="${single.getRoles().size() == 2}"> | <a href="/revoke-admin/${single.id}">Revoke Admin</a></c:if>
                                    </c:if>
                                </c:if>
                            </td>
                        </c:if>
                        <c:if test="${user.getRoles().size() == 2}">
                            <c:if test="${single.getRoles().size() > 1}">
                                <td>Admin</td>
                            </c:if>
                            <c:if test="${single.getRoles().size() == 1}">
                                <td><a href="/delete/${single.id}">Delete</a> | <a href="/make-admin/${single.id}">Make Admin</a></td>
                            </c:if>
                        </c:if>
                        <c:if test="${single.lastSignIn == null}">
                            <td>Never signed in</td>
                        </c:if>
                        <c:if test="${single.lastSignIn != null}">
                            <td><fmt:formatDate pattern = "MMMMM dd, yyyy" value="${user.lastSignIn}"></fmt:formatDate></td>
                        </c:if>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>