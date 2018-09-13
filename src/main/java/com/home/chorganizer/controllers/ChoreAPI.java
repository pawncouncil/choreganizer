package com.home.chorganizer.controllers;
import java.security.Principal;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.home.chorganizer.models.Chore;
import com.home.chorganizer.models.User;
import com.home.chorganizer.services.ChoreService;
import com.home.chorganizer.services.UserService;

@RestController
public class ChoreAPI {
	
	UserService userService;
	ChoreService choreService;
	
	public ChoreAPI(UserService userService, ChoreService choreService) {
		this.userService = userService;
		this.choreService = choreService;
	}

	@RequestMapping("chores/{idEdit}/edit")
	public Chore edit(@PathVariable("idEdit") Long id, Principal principal) {
    	Chore choreToEdit = choreService.findOne(id);
    	User assignee = choreToEdit.getAssignee();
    	assignee.setAssignedChores(null);
    	choreToEdit.setAssignee(assignee);
    	return choreToEdit;
    	
    }
}
