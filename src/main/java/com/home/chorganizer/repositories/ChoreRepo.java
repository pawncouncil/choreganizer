package com.home.chorganizer.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.home.chorganizer.models.Chore;
import com.home.chorganizer.models.House;

public interface ChoreRepo extends CrudRepository<Chore, Long>{
	
	List<Chore> findAll();
	List<Chore> findAllByOrderByPriorityDesc();
	List<Chore> findAllByOrderByPriorityAsc();
	List<Chore> findByHouse(House house);
}
