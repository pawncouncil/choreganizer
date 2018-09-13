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
    <title>Admin Dash</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Amatic+SC" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script>
	    $(document).ready(function(){
	    		
	    	// Target the modal
	        var modal = document.getElementById("createModal");
	    	
            // When the user clicks the create button, open the modal
            $("#create").click(function(e) {
                $("#modalTitle").html("Create Chore");
                $("#newChore").attr("action", "/chores/new");
                $("#title").val("");
     			$("#description").val("");
     			$("#priority").val("");
     			$("#assignee").val("");
                $('#submit').val("Create");
            	$(modal).show();
                $("#title").focus();
                e.stopPropagation();
            });
               
            // When the user clicks on <span> (x), close the modal
            $("#closeCreate").click(function(e) {
            	$(modal).hide();
            	e.stopPropagation();
            });
            
            $("#choreError").click(function(e) {
            	$(".alert").hide();
            	e.stopPropagation();
            });

            // When the user clicks anywhere outside of the modal, close it
            $(document).click(function(event) {
                if ( $("#createForm").has(event.target).length == 0 && modal.style.display == "block" ) {
                	$(modal).hide();
                	event.stopPropagation();
                }
            });
            
            // Edit Chore
            $(".edit").click(function() {fillModal($(this).attr("id"))});
            
            function fillModal(id){
            	$("#modalTitle").html("Edit Chore");
            	$.get("/chores/"+ id +"/edit", function(chore) {
         			$("#newChore").attr("action", "/chores/"+ id +"/edit");
         			$("#title").val(chore.title);
         			$("#description").val(chore.description);
         			$("#priority").val(chore.priority);
         			$("#assignee").val(chore.assignee.id);
         			$('#submit').val("Edit");
         			$("#createModal").show();
            	}); 
            }
            
	     });
   	 </script>

</head>
<body>
	<div id="wrapper">
		<div class="headers">
			<a class="homebutton" href="/home"><i class="fas fa-home"></i></a>
	        <a href="/home" class="logolink"><h1 id="logo">House ${house.name}</h1></a>
	        <span id="create" class="headera" >Create Chore</span>
	        <a href="/logout" class="headerb">Logout</a>
	    </div>
	    <!-- Invalid Registration Alert -->
		<c:set var="formErrors"><form:errors path="chore.*"/></c:set>
		<c:if test="${not empty formErrors}">
			<div class="alert alert-danger">
				<span class="close" id="choreError">&times;</span>
				<form:errors path="chore.*"/>
			</div>
		</c:if>
	<!-- Admin Dashboard -->
	    <div class="container">
	        <h1>Welcome, ${user.first}</h1> 
	        <div class="scroll">
		        <table class="table table-ruled">
		            <thead>
		              <tr>
		                <th>House Mates</th>
		                <th>Phone #</th>
		                <th>Actions</th>
		                <th>Last Login</th>
		                <th>House Member Since</th>
		              </tr>
		            </thead>
		            <tbody>
		              <c:forEach items="${allUsers}" var="single">
			                 <tr>
			                   <td>${single.first} ${single.last}</td>
			                   <td>${single.phone}</td>
			                   <c:if test="${user.getRoles().size() > 2}">
			                   <td>
			                       <c:if test="${single.getRoles().size() == 3}">Super Admin</c:if>
			                       <c:if test="${single.getRoles().size() != 3}">
			                       <c:if test="${single == user}">Admin</c:if>
			                       <c:if test="${single != user}">
			                       <form action="/admin/delete/${single.id}" method="POST"> <input type="hidden"  name="${_csrf.parameterName}" value="${_csrf.token}"/><input type="submit" class="btn btn-danger" value="Delete User" /></form>
			                       <c:if test="${single.getRoles().size() == 1}"> | <form action="/admin/make-admin/${single.id}" method="POST"> <input type="hidden"  name="${_csrf.parameterName}" value="${_csrf.token}"/><input type="submit" class="btn btn-primary" value="Make Admin" /></form></c:if>
			                       <c:if test="${single.getRoles().size() == 2}"> | <form action="/admin/take-admin/${single.id}" method="POST"> <input type="hidden"  name="${_csrf.parameterName}" value="${_csrf.token}"/><input type="submit" class="btn btn-warning" value="Revoke Admin" /></form></c:if>
			                       </c:if>
			                       </c:if>
			                   </td>
			                    </c:if>
			                   	<c:if test="${user.getRoles().size() == 2}">
			                    <c:if test="${single.getRoles().size() > 1}">
			                    <td>Admin</td>
			                    </c:if>
			                    <c:if test="${single.getRoles().size() == 1}">
			                    <td><form action="/admin/delete/${single.id}" method="POST"> <input type="hidden"  name="${_csrf.parameterName}" value="${_csrf.token}"/><input type="submit" class="btn btn-danger" value="Delete User" /></form> | <form action="/admin/make-admin/${single.id}" method="POST"> <input type="hidden"  name="${_csrf.parameterName}" value="${_csrf.token}"/><input type="submit" class="btn btn-primary" value="Make Admin" /></form></td>
			                    </c:if>
			                    </c:if>
			                   	<c:if test="${single.lastSignIn == null}">
		                       <td>Never signed in</td>
			                   </c:if>
			                   <c:if test="${single.lastSignIn != null}">
			                       <td><fmt:formatDate pattern = "MMMMM dd, yyyy" value="${user.lastSignIn}"></fmt:formatDate></td>
			                   </c:if>
			                   <td><fmt:formatDate pattern = "MMMMM dd, yyyy" value="${user.createdAt}"></fmt:formatDate></td>
			                 </tr>
		               </c:forEach>
		            </tbody>
		        </table>
	        </div>
	        <div class="scroll2">
				<table class="table table-ruled">
					<thead>
					  <tr>
					    <th>All Chores</th>
					    <th>Chore Duties</th>
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
						    <td><c:out value="High"/></td>
					    </c:if>
						<td>
							<a href="#" id="${chore.id}" class="edit">Edit  |</a>
							<a href="/chores/${chore.id}/delete">  Delete</a>
						</td>
					  </tr>
					  </c:forEach>
				    </tbody>
				</table>
			</div>
			<div class="message">
				<div class="row-fluid">
					<table class="table table-bordered table-striped">
					
						<thead>
							<tr>
								<th>
									Message Board
								</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${house.messageBoard.size() == 0}">
								<tr>
									<td colspan="2">No messages</td>
								</tr>
							</c:if>
							<c:if test="${house.messageBoard.size() > 0}">
								<c:forEach items="${house.messageBoard}" var="msg"> 
									<tr>
										<td colspan="2">${msg}</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
				<div class="row-fluid">
					<form id="new-user" action="/message" method="post">
						<input type="text" name="message" placeholder="Message" />
						<input type="hidden"  name="${_csrf.parameterName}" value="${_csrf.token}"/>
						<input type="submit" id="send" class="btn btn-primary" value="Post">
					</form>		
				</div>

			</div> 
			
		    <!-- The Modal for creating Chore -->
		    <div id="createModal" class="modal">
			    <!-- Modal content to login -->
			    <div class="modal-content" id="createForm">
			    	<span class="close" id="closeCreate">&times;</span>
			    	<h1 id="modalTitle"></h1>
				    <form:form method="POST" action="/chores/new" modelAttribute="chore" id="newChore"> 
				    	<form:input path="title"/>
				    	<p>Chore<br>
				    	<form:errors path="title" class="text text-danger"/></p>
				       	
				       	<form:input path="description"/>
				        <p>Description<br>
				        <form:errors path="description" class="text text-danger"/> </p>
				     
				     	<form:select path="priority">
								<form:option value="1">Low</form:option>
								<form:option value="2">Medium</form:option>
								<form:option value="3">High</form:option>
						</form:select>
						<p>Priority<br>
						<form:errors path="priority" class="text text-danger"/></p>
						
				       	<form:select path="assignee" >
				            <c:forEach items="${allUsers}" var="x">
				                <form:option value="${x.id}">${x.first}</form:option>
				            </c:forEach>
				        </form:select>
				        <p>Assignee<br>
				        <form:errors path="assignee" class="text text-danger"/></p>
							       
				        <input type="submit" id="submit"/>
				    </form:form>
				</div>
		    </div>
		</div>
	</div>
</body>
</html>