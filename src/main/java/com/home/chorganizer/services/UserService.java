package com.home.chorganizer.services;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.home.chorganizer.models.Role;
import com.home.chorganizer.models.User;
import com.home.chorganizer.repositories.RoleRepository;
import com.home.chorganizer.repositories.UserRepository;

@Service
public class UserService {
    private UserRepository userRepository;
    private RoleRepository roleRepository;
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    public UserService(UserRepository userRepository, RoleRepository roleRepository, BCryptPasswordEncoder bCryptPasswordEncoder)     {
        this.userRepository= userRepository;
        this.roleRepository = roleRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    public void savePleb(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        ArrayList<Role> roles = new ArrayList<Role>();
        roles.add(roleRepository.findByType("ROLE_USER"));
        user.setRoles(roles);
        userRepository.save(user);
    }
    public void saveAdmin(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        ArrayList<Role> roles = new ArrayList<Role>();
        roles.add(roleRepository.findByType("ROLE_USER"));
        roles.add(roleRepository.findByType("ROLE_ADMIN"));
        user.setRoles(roles);
        userRepository.save(user);
    }    
    public void saveSuper(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        ArrayList<Role> roles = new ArrayList<Role>();
        roles.add(roleRepository.findByType("ROLE_USER"));
        roles.add(roleRepository.findByType("ROLE_ADMIN"));
        roles.add(roleRepository.findByType("ROLE_SUPER"));
        user.setRoles(roles);
        userRepository.save(user);
    } 

    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    
    public User findById(Long id) {
 	Optional<User> u = userRepository.findById(id);
    	
    	if(u.isPresent()) {
            return u.get();
    	} else {
    	    return null;
    	}
    }
    
    public List<User> allUsers() {
    	return (List<User>) userRepository.findAll();
    }

    public void updatePleb(User user) {
        ArrayList<Role> roles = new ArrayList<Role>();
        roles.add(roleRepository.findByType("ROLE_USER"));
        user.setRoles(roles);
        userRepository.save(user);
    }
    public void updateAdmin(User user) {
        ArrayList<Role> roles = new ArrayList<Role>();
        roles.add(roleRepository.findByType("ROLE_USER"));
        roles.add(roleRepository.findByType("ROLE_ADMIN"));
        user.setRoles(roles);
        userRepository.save(user);
    }
    public void updateSignIn(User user) {
    	user.setLastSignIn(new Date());
    	userRepository.save(user);
    }
    public void deleteUser(Long id) {
    	userRepository.deleteById(id);
    }
}