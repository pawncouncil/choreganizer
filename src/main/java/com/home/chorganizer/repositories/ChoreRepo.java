package com.home.chorganizer.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;


import com.home.chorganizer.models.Chore;

public interface ChoreRepo extends CrudRepository<Chore, Long>{
	
	List<Chore> findAll();
	List<Chore> findAllByOrderByPriorityDesc();
	List<Chore> findAllByOrderByPriorityAsc();

}
