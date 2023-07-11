package com.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.dto.Restaurant;
import com.spring.dto.SearchKeyword;
import com.spring.mapper.RestaurantMapper;

import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
public class MapController {

	final RestaurantMapper restaurantMapper;
	@RequestMapping(value = "/map")
	public String map(Model model){
		System.out.println("map test");
		List<Restaurant> RestaurantList =restaurantMapper.getAllRestaurant();
		System.out.println(RestaurantList.subList(0, 20));
		model.addAttribute("RestaurantList", RestaurantList.subList(0, 20));
		return "map";
	}
		@RequestMapping(value = "/map2")
		public String map2(Model model){
			System.out.println("map test");
			List<Restaurant> RestaurantList =restaurantMapper.getAllRestaurant();
			System.out.println(RestaurantList.subList(0, 20));
			model.addAttribute("RestaurantList", RestaurantList.subList(0, 20));
			return "map2";
		}
		@RequestMapping(value = "/주변")
		public String map3() {
			List<Restaurant> RestaurantList =restaurantMapper.getAllRestaurant();
			System.out.println(RestaurantList);
			System.out.println("map test");
			return "주변";
		}
		
		@RequestMapping("/restaurant")
	public String searchKeyword(@ModelAttribute SearchKeyword searchKeyword, Model model) {
//			System.out.println(searchKeyword);
			
			
			List<Restaurant> RestaurantList =restaurantMapper.getAllRestaurant();
			System.out.println(RestaurantList);
			model.addAttribute("RestaurantList", RestaurantList);
			return "Restaurant";
		}
		@RequestMapping("/test")
		public String searchKeyword() {
//				System.out.println(searchKeyword);
				
				
		
				return "test";
			}
}
