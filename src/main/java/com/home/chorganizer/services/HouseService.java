package com.home.chorganizer.services;

import java.util.List;
import java.util.Optional;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.home.chorganizer.models.House;
import com.home.chorganizer.models.User;
import com.home.chorganizer.repositories.HouseRepo;

@Service
public class HouseService {
	private final HouseRepo houseRepo;
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	public HouseService(HouseRepo houseRepo, BCryptPasswordEncoder bCryptPasswordEncoder) {
		this.houseRepo = houseRepo;
		this.bCryptPasswordEncoder = bCryptPasswordEncoder;
	}
	
	public List<House> allHouses() {
		return (List<House>) houseRepo.findAll();
	}
	
	public House createHouse(House house) {
		house.setPassword(bCryptPasswordEncoder.encode(house.getPassword()));
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
	
	public House findByName(String name) {
		return houseRepo.findByName(name);
	}
	
	public House updateHouse(House house) {
    	return houseRepo.save(house);
    }
    
	public void deleteHouse(Long id) {
		houseRepo.deleteById(id);
	}
	
	public void addMember(User member, House house) {
		house.addMember(member);
		houseRepo.save(house);
	}
	
	public void deleteMember(User member, House house) {
		house.removeMember(member);
		houseRepo.save(house);
	}
	
	public boolean authenticateHouse(String name, String password) {
        House house = houseRepo.findByName(name);
        if(house == null) {
            return false;
        } else {
        	// if the passwords match, return true, else, return false
            if(bCryptPasswordEncoder.matches(password, house.getPassword())) {
                return true;
            } else {
                return false;
            }
        }
	}
}
