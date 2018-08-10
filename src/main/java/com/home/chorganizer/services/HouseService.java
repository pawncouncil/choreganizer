package com.home.chorganizer.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.home.chorganizer.models.House;
import com.home.chorganizer.repositories.HouseRepo;

@Service
public class HouseService {
	private final HouseRepo houseRepo;
	
	public HouseService(HouseRepo houseRepo) {
		this.houseRepo = houseRepo;
	}
	
	public List<House> allHouses() {
		return (List<House>) houseRepo.findAll();
	}
	
	public House createHouse(House house) {
		return houseRepo.save(house);
	}
	
	public House findOne(Long id) {
		Optional<House> house = houseRepo.findById(id);
		if (house.isPresent()) {
			return house.get();
		} else {
			return null;
		}
	}
	
	public House updateHouse(House house) {
    	return houseRepo.save(house);
    }
    
	public void deleteHouse(Long id) {
		houseRepo.deleteById(id);
	}
	
}
