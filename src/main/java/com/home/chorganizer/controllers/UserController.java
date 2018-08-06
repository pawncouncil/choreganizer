package com.home.chorganizer.controllers;

import java.security.Principal;
import java.util.ArrayList;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.home.chorganizer.models.Role;
import com.home.chorganizer.models.User;
import com.home.chorganizer.repositories.RoleRepository;
import com.home.chorganizer.services.UserService;
import com.home.chorganizer.validator.UserValidator;

@Controller
public class UserController {
    private UserService userService;
    private RoleRepository roleRepository;
    private UserValidator userValidator;
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
    public UserController(UserService userService, UserValidator userValidator, RoleRepository roleRepository) {
        this.userService = userService;
        this.roleRepository = roleRepository;
        this.userValidator = userValidator;
        makeRoles();

    }

    @RequestMapping("/login")
    public String login(@RequestParam(value="error", required=false) String error, @RequestParam(value="logout", required=false) String logout, Model model, @Valid @ModelAttribute("user") User user) {
    	if(logout != null) {
            model.addAttribute("logout", "Logout Successful!");
        }
        if(error != null) {
            model.addAttribute("logError", "Invalid credentials, please try again.");
        }
        return "index.jsp";
    }
    
    
    @PostMapping("/register")
    public String registration(@Valid @ModelAttribute("user") User user, BindingResult result, Model model) {
        userValidator.validate(user, result);
        if(result.hasErrors()) {
            return "index.jsp";
        }
        if(userService.allUsers().size() == 0) {
            userService.saveSuper(user);
            return "redirect:/";
        }
        else {
            userService.savePleb(user);
            return "redirect:/";
        }
    }   
    
    @RequestMapping(value= {"/", "/home"})
    public String user(Principal principal, Model model) {
        String email = principal.getName();
        model.addAttribute("user", userService.findByEmail(email));
        User user = userService.findByEmail(email);
        if(user.getRoles().size() > 1) {
        	return "redirect:/admin";
        }
        return "userdash.jsp";
    } 
    @RequestMapping("/admin")
    public String admin(Principal principal, Model model) {
        String email = principal.getName();
        model.addAttribute("user", userService.findByEmail(email));
        model.addAttribute("allUsers", userService.allUsers());
        User user = userService.findByEmail(email);
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
    public String logout(Principal principal) {
    	String email = principal.getName();
        User user = userService.findByEmail(email);
        userService.updateSignIn(user);  
        return "redirect:/login?logout";
    }
}
