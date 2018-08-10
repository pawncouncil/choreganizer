package com.home.chorganizer.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
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
    public String login(@ModelAttribute("user") User user, @RequestParam(value="error", required=false) String error, @RequestParam(value="logout", required=false) String logout, Model model, HttpSession session) {
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
    	String email = principal.getName();
    	if(email == null) {
    		return "redirect:/login";
    	}
    	User user = userService.findByEmail(email);
    	model.addAttribute("user", user);
    	Object chores = choreService.allDescend();
		model.addAttribute("chores", chores);
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
        Object chores = choreService.allDescend();
		model.addAttribute("chores", chores);
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
    
    @RequestMapping(value="/chores/new", method=RequestMethod.POST)
    public String createChore(@Valid @ModelAttribute("chore") Chore chore, BindingResult result, Model model, HttpSession session) {
       if (result.hasErrors()) {
           return "admindash.jsp";
       } else {
		   Long userId = (Long) session.getAttribute("userId");
		   User user = userService.findById(userId);
		   model.addAttribute("user", user);
		   chore.setCreator(user);
	       choreService.createChore(chore);
	       return "redirect:/admin";
       }

    }
    
    @GetMapping("/chores/{id}/delete")
   	public String deleteChore(@PathVariable("id")Long id) {
   		choreService.deleteChore(id);
   		return "redirect:/home";
   	}
    
    @RequestMapping("chores/{idEdit}/edit")
    public String edit(@ModelAttribute("chore") Chore chore, @PathVariable("idEdit") Long id, Principal principal, Model model, HttpSession session) {
    	String email = principal.getName();
        model.addAttribute("user", userService.findByEmail(email));
        model.addAttribute("allUsers", userService.allUsers());
        User user = userService.findByEmail(email);
        session.setAttribute("userId", user.getId());
    	Object chores = choreService.allDescend();
		model.addAttribute("chores", chores);
    	Chore choreToEdit = choreService.findOne(id);
//    	Long currentUser = (Long) session.getAttribute("userId");
//    	if (choreToEdit.getCreator().getId() != currentUser) {
//    		return "redirect:/admin";
//    	} else {
    	List<User> users = userService.allUsers();
    	model.addAttribute("users", users);
    	model.addAttribute("chore", choreToEdit);
    	return "/edit.jsp";  
//    	}
    }
    
    @PostMapping("/chores/{id}/edit")
    public String editChore(@Valid@ModelAttribute("chore") Chore chore, BindingResult result, @PathVariable("id") Long id, Model model, HttpSession session) {
    	if (result.hasErrors()) {
    		List<User> users = userService.allUsers();
    		model.addAttribute("users", users);
            return "/edit.jsp";
    	} else {
    		Long currentUser = (Long) session.getAttribute("userId");
    		User u = userService.findById(currentUser);
    		chore.setCreator(u);
    		choreService.updateChore(chore);
    		return "redirect:/chores/{id}/edit";
    	} 
    }
    
    @GetMapping("/sunrise")
   	public String sunRise() {
   		return "sunrise.jsp";
   	}
    
}
