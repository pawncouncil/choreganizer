package com.home.chorganizer.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderColumn;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="households")
public class House {

	@Id
    @GeneratedValue
    private Long id;
	@Size(min=1, max=64)
	private String name;
	@Size(min=1, max=64)
	@OneToMany(mappedBy="house", fetch = FetchType.LAZY)
    private List<User> members;
	@OneToMany(mappedBy="house", fetch = FetchType.LAZY)
    private List<Chore> chores;
	@Size(min=8)
    private String password;
	@Transient
    @Size(min=8)
    private String confirm;
	@ElementCollection
	@OrderColumn(name="sequence")
	private List<String> messageBoard;
	@Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;
  
    public House() {}
    
    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<User> getMembers() {
		return members;
	}
	
	public void addMember(User member) {
		this.members.add(member);
	}
	
	public void removeMember(User member) {
		this.members.remove(member);
	}
	
	public void addMessage(User member, String message) {
		String messageToAdd = member.getFirst() + " " + member.getLast() + ": " + message;
		this.messageBoard.add(messageToAdd);
	}

	public List<String> getMessageBoard() {
		return messageBoard;
	}

	public void setMessageBoard(List<String> messageBoard) {
		this.messageBoard = messageBoard;
	}

	public void setMembers(List<User> members) {
		this.members = members;
	}

	public List<Chore> getChores() {
		return chores;
	}

	public void setChores(List<Chore> chores) {
		this.chores = chores;
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
	
	
}
