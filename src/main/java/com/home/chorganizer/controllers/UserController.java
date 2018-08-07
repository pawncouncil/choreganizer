package com.home.chorganizer.controllers;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


import com.home.chorganizer.models.Chore;
import com.home.chorganizer.models.Role;
import com.home.chorganizer.models.User;
import com.home.chorganizer.repositories.RoleRepository;
import com.home.chorganizer.services.ChoreService;
import com.home.chorganizer.services.UserService;
import com.home.chorganizer.validator.UserValidator;

@Controller
public class UserController {
    private UserService userService;
    private RoleRepository roleRepository;
    private UserValidator userValidator;
	private ChoreService choreService;
    private void makeRoles() {
    	if(roleRepository.findAll().size() == 0) {
    		Role user = new Role();
    		user.setType("ROLE_USER");
    		roleRepository.save(user);
    		Role admin = new Role();
    		admin.setType("ROLE_ADMIN");
    		roleRepository.save(admin);
    		Role superb = new Role();
    		superb.setType("ROLE_SUPER");
    		roleRepository.save(superb);
    	}
    }
    public UserController(UserService userService, UserValidator userValidator, RoleRepository roleRepository, ChoreService choreService) {
        this.userService = userService;
        this.roleRepository = roleRepository;
        this.choreService = choreService;
        this.userValidator = userValidator;
        makeRoles();

    }

    @RequestMapping("/login")
    public String login(@RequestParam(value="error", required=false) String error, @RequestParam(value="logout", required=false) String logout, Model model, HttpSession session) {
    	if(logout != null) {
            model.addAttribute("logout", "Logout Successful!");
        }
        if(error != null) {
            model.addAttribute("logError", "Invalid credentials, please try again.");
        }
        return "index.jsp";
    }
    
    
    @PostMapping("/register")
    public String registration(@Valid @ModelAttribute("user") User user, BindingResult result, Model model, HttpSession session) {
        userValidator.validate(user, result);
        if(result.hasErrors()) {
            return "index.jsp";
        }
        if(userService.allUsers().size() == 0) {
        	User u = userService.saveSuper(user);
            session.setAttribute("userId", u.getId());
            return "redirect:/";
        }
        else {
            User u = userService.savePleb(user);
            session.setAttribute("userId", u.getId());
            return "redirect:/";
        }
    }   
    
    @RequestMapping(value= {"/", "/home"})
    public String user(@ModelAttribute("chore") Chore chore, HttpSession session, Principal principal, Model model, @RequestParam(value="priority", required=false) String priority) {
    	Long userId = (Long) session.getAttribute("userId");
    	User user = userService.findById(userId);
    	model.addAttribute("user", user);

     
        
        if(user.getRoles().size() > 1) {
        	return "redirect:/admin";
        }
        return "userdash.jsp";
    } 
    @RequestMapping("/admin")
    public String admin(@ModelAttribute("chore") Chore chore, HttpSession session, Principal principal, Model model, @RequestParam(value="priority", required=false) String priority) {
        String email = principal.getName();
        model.addAttribute("user", userService.findByEmail(email));
        model.addAttribute("allUsers", userService.allUsers());
        User user = userService.findByEmail(email);
        session.setAttribute("userId", user.getId());
        if(user.getRoles().size() > 2) {
        	model.addAttribute("super", "this is a super admin user");
        }
        if(user.getRoles().size() > 1) {
        	model.addAttribute("admin", "this is an admin user"); 
        }
        return "admindash.jsp";
    }    
 
    
    
    
    
    
    @RequestMapping("/make-admin/{id}")
    public String makeAd(@PathVariable("id") Long id){
        User user = userService.findById(id);
        userService.updateAdmin(user);
        return "redirect:/admin";
    }
    @PostMapping("/take-admin/{id}")
    public String takeAd(@PathVariable("id") Long id){
        User user = userService.findById(id);
        userService.updatePleb(user);
        return "redirect:/admin";
    }
    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id){
    	userService.deleteUser(id);
        return "redirect:/admin";
        
        // test comment added for github usage.
    }
    
    @RequestMapping("/logout")
    public String logout(Principal principal, HttpSession session) {
    	String email = principal.getName();
        User user = userService.findByEmail(email);
        userService.updateSignIn(user);
        session.invalidate();
        return "redirect:/login?logout";
    }
    
//    @RequestMapping("/admin/chores")
//    public String home(HttpSession session, Model model, @RequestParam(value="priority", required=false) String priority) {
//        // get user from session, save them in the model and return the home page
//    	Long userId = (Long) session.getAttribute("userId");
//    	User u = userService.findById(userId);
//    	model.addAttribute("user", u);
//    	if(priority==null) {
//          		model.addAttribute("chores", choreService.allChores());
//
//       	} else if (priority.equals("descend")) { 
//        		model.addAttribute("chores", choreService.allDescend());
//
//       	} else if (priority.equals("ascend")) {
//        		model.addAttribute("chores", choreService.allAscend());
//       	}
//        	return "userdash.jsp";
//    }
    
//    @RequestMapping("/chores/new")
//    public String chore(@ModelAttribute("chore") Chore chore, Model model, HttpSession session) {
//    	List<User> users = userService.allUsers();
// 	    model.addAttribute("users", users);
//    	return "admindash.jsp";
//   
//    }
    
    @RequestMapping(value="/chores/new", method=RequestMethod.POST)
    public String createChore(@Valid @ModelAttribute("chore") Chore chore, BindingResult result, Model model, HttpSession session) {
       if (result.hasErrors()) {
           return "admindash.jsp";
       } else {
    	   System.out.println("got here");
    	   Long userId = (Long) session.getAttribute("userId");
    	   User user = userService.findById(userId);
    	   System.out.println(user);
    	   model.addAttribute("user", user);
    	   chore.setCreator(user);
           choreService.createChore(chore);
           System.out.println(chore.getId());
           return "redirect:/admin";
       }

    }
    
}