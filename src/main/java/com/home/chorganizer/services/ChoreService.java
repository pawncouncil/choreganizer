package com.home.chorganizer.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;


import com.home.chorganizer.models.Chore;
import com.home.chorganizer.repositories.ChoreRepo;

@Service
public class ChoreService {
	private final ChoreRepo choreRepo;
	
	public ChoreService(ChoreRepo choreRepo) {
		this.choreRepo = choreRepo;
	}
	
	public List<Chore> allChores() {
		return (List<Chore>) choreRepo.findAll();
	}
	
	public Chore createChore(Chore chore) {
		return choreRepo.save(chore);
	}
	
	public Chore findOne(Long id) {
		Optional<Chore> chore = choreRepo.findById(id);
		if (chore.isPresent()) {
			return chore.get();
		} else {
			return null;
		}
	}
	
	public Chore updateChore(Chore chore) {
    	return choreRepo.save(chore);
    }
    
	public void deleteChore(Long id) {
		choreRepo.deleteById(id);
	}
	
	public List<Chore>allDescend(){
		return choreRepo.findAllByOrderByPriorityDesc();
	}

	public List<Chore>allAscend(){
		return choreRepo.findAllByOrderByPriorityAsc();
	}

}
