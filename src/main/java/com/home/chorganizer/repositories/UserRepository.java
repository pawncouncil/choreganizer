package com.home.chorganizer.repositories;


import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import com.home.chorganizer.models.User;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {
    User findByEmail(String email);
}