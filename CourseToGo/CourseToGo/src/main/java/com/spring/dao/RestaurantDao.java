package com.spring.dao;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Controller;

import com.spring.dto.Restaurant;
import com.spring.dto.SearchKeyword;
import com.spring.mapper.RestaurantMapper;

import lombok.RequiredArgsConstructor;

import java.util.List;
@Controller
@RequiredArgsConstructor
public class RestaurantDao {
	@Autowired
	final RestaurantMapper restaurantMapper2;
    private NamedParameterJdbcTemplate jdbcTemplate;

    // 생성자
    
    public void getAllRestaurants() {
    	SearchKeyword temp = new SearchKeyword();
    	List<Restaurant> RestaurantList =restaurantMapper2.getRestaurantBySearchKeyword(temp);
		System.out.println(RestaurantList);
		return;
    }
    
 
}
