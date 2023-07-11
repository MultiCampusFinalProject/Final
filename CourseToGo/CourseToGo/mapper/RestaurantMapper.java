package com.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.dto.Restaurant;
import com.spring.dto.SearchKeyword;

@Mapper
public interface RestaurantMapper {
	// insertNotice
//	public Integer insertNotice(Restaurant notice);
	public List<Restaurant> getRestaurantBySearchKeyword(SearchKeyword searchKeyword);
//	public List<Restaurant> getAllRestaurant();

}
