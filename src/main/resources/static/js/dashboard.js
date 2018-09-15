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
    
    // Delete User
    $(".userDelete").click(function (ev) {
    	var id = $(this).attr("id").slice(1);
    	var csrf = $("#csrf").val();
    	$.post("/admin/delete/" + id, { "_csrf": csrf });
    	location.reload();
    	ev.preventDefault();
    });
    
    // Make Admin
    $(".makeAdmin").click(function (ev) {
    	var id = $(this).attr("id").slice(1);
    	var csrf = $("#csrf").val();
    	$.post("/admin/make-admin/" + id, { "_csrf": csrf });
    	location.reload();
    	ev.preventDefault();
    });
    
    // Take Admin
    $(".takeAdmin").click(function(ev) {
    	var id = $(this).attr("id").slice(1);
    	var csrf = $("#csrf").val();
    	$.post("/admin/take-admin/" + id, { "_csrf": csrf });
    	location.reload();
    	ev.preventDefault();
    });
    
    // Edit Chore
    $(".edit").click(function(e) {
    	fillModal($(this).attr("id").slice(1));
    	e.preventDefault();
    });
    
    // Delete Chore
    $(".delete").click(function(ev) {
    	var id = $(this).attr("id").slice(1);
    	var csrf = $("#csrf").val();
    	$.post("/chores/" + id + "/delete", { "_csrf": csrf });
    	location.reload();
    	ev.preventDefault();
    });
    
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