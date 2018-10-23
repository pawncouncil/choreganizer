package com.home.chorganizer.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name="users")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler", "house"})
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Email(message="Invalid email format. Ex: user@user.com")
    private String email;
    @Size(min=1, max=64, message="First name can not be empty")
    private String first;
    @Size(min=1, max=64, message="Last name can not be empty")
    private String last;
    @Size(min=10, message="Phone number must be 10 digits.")
    private String phone;
    @JsonIgnore
	@Size(min=8, message="Password must be at least 8 characters")
    private String password;
    @JsonIgnore
    @Transient
    private String confirm;
    
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
        name = "users_roles", 
        joinColumns = @JoinColumn(name = "user_id"), 
        inverseJoinColumns = @JoinColumn(name = "role_id"))
    private List<Role> roles;
	@DateTimeFormat(pattern="yyyy-MM-dd")
    private Date lastSignIn;
    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="house_id", referencedColumnName = "id")
	private House house;
    @OneToMany(mappedBy="creator", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Chore> createdChores;
    @OneToMany(mappedBy="assignee", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Chore> assignedChores;
    @Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
    @JsonIgnore
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;
    
    
    public User() {}
    
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
	 public House getHouse() {
			return house;
	}
	public void setHouse(House house) {
		this.house = house;
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
        this.updatedAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }


}