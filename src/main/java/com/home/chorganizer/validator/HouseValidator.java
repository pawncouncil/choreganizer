package com.home.chorganizer.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.home.chorganizer.models.House;

@Component
public class HouseValidator implements Validator{
	
	@Override
    public boolean supports(Class<?> clazz) {
        return House.class.equals(clazz);
    }
    
    @Override
    public void validate(Object object, Errors errors) {
        House house = (House) object;
        if (!house.getConfirm().equals(house.getPassword())) {
            errors.rejectValue("confirm", "Match");
        }         
    }
}
