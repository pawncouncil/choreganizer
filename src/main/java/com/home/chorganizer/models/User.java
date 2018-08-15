package com.home.chorganizer.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="users")
public class User {
    
    @Id
    @GeneratedValue
    private Long id;
    @Email(message="Invalid email format. Ex: user@user.com")
    private String email;
    @Size(min=1, max=64, message="First name can not be empty")
    private String first;
    @Size(min=1, max=64, message="Last name can not be empty")
    private String last;
    @Size(min=12, message="Phone number must be 10 digits.")
    private String phone;
	@Size(min=8, message="Password must be at least 8 characters")
    private String password;
    @Transient
    private String confirm;
    @Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;
    public House getHouse() {
		return house;
	}
	public void setHouse(House house) {
		this.house = house;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
    private Date lastSignIn;
    @ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="house_id")
	private House house;
    @OneToMany(mappedBy="creator", fetch = FetchType.LAZY)
    private List<Chore> createdChores;
    @OneToMany(mappedBy="assignee", fetch = FetchType.LAZY)
    private List<Chore> assignedChores;
    public List<Chore> getCreatedChores() {
		return createdChores;
	}
	public void setCreatedChores(List<Chore> createdChores) {
		this.createdChores = createdChores;
	}
	public List<Chore> getAssignedChores() {
		return assignedChores;
	}
	public void setAssignedChores(List<Chore> assignedChores) {
		this.assignedChores = assignedChores;
	}
	@ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
        name = "users_roles", 
        joinColumns = @JoinColumn(name = "user_id"), 
        inverseJoinColumns = @JoinColumn(name = "role_id"))
    private List<Role> roles;
    
    public User() {
    	this.updatedAt = new Date();
    	// this.lastSignIn = new Date();
    }
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public String getFirst() {
		return first;
	}
	public void setFirst(String first) {
		this.first = first;
	}
	public String getLast() {
		return last;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public void setLast(String last) {
		this.last = last;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getConfirm() {
        return confirm;
    }
    public void setConfirm(String confirm) {
        this.confirm = confirm;
    }
    public Date getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    public Date getUpdatedAt() {
        return updatedAt;
    }
    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
    public Date getLastSignIn() {
		return lastSignIn;
	}
	public void setLastSignIn(Date lastSignIn) {
		this.lastSignIn = lastSignIn;
	}
	public List<Role> getRoles() {
        return roles;
    }
    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }
    
    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }


}