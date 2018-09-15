package com.home.chorganizer.controllers;
import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.home.chorganizer.models.Chore;
import com.home.chorganizer.models.House;
import com.home.chorganizer.models.User;
import com.home.chorganizer.services.ChoreService;
import com.home.chorganizer.services.HouseService;
import com.home.chorganizer.services.UserService;

@RestController
public class ChoreAPI {
	
	UserService userService;
	ChoreService choreService;
	HouseService houseService;
	
	public ChoreAPI(UserService userService, ChoreService choreService, HouseService houseService) {
		this.userService = userService;
		this.choreService = choreService;
		this.houseService = houseService;
	}
	
	// get single chore
	@RequestMapping("/chores/{idEdit}")
	public Chore edit(@PathVariable("idEdit") Long id) {
    	Chore choreToEdit = choreService.findOne(id);
    	User assignee = choreToEdit.getAssignee();
    	assignee.setAssignedChores(null);
    	choreToEdit.setAssignee(assignee);
    	return choreToEdit;
    	
    }
	
	//get users for a home
	@RequestMapping("/home/users/{houseId}")
	public List<User> getUsers(@PathVariable("houseId") Long houseId) {
		House house = houseService.findOne(houseId);
		List<User> users = userService.allUsers(house);
		return users;
	}
	
	//get chores for the home
	@RequestMapping("/home/chores/{houseId}")
	public List<Chore> getChores(@PathVariable("houseId") Long houseId) {
		House house = houseService.findOne(houseId);
		List<Chore> chores = choreService.allChoresFromHome(house);
		return chores;
	}
}
