package com.spring.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.spring.dto.PlaceDTO;
import com.spring.service.AreaService;
import com.spring.service.PlaceService;

@Controller
public class SearchController {
	@Autowired
	private PlaceService placeService;
	@Autowired
	private AreaService areaService;
    @GetMapping("/places")
    public ResponseEntity<List<PlaceDTO>> getAllPlaces(){
        List<PlaceDTO> places = placeService.getAllPlaces();
        return new ResponseEntity<>(places, HttpStatus.OK);
    }
    
    @PostMapping("/search")
    public ResponseEntity<List<PlaceDTO>> searchPlaces(@RequestParam("placeName") String placeName){
        List<PlaceDTO> searchResults = placeService.searchPlaces(placeName);
        return new ResponseEntity<>(searchResults, HttpStatus.OK);
    }
    @ResponseBody
    @GetMapping("/search")
    public List<String> getSearchSuggestions(@RequestParam("query") String query) {
        // 검색어를 기반으로 추천 결과 생성
    	List<String> suggestions= new ArrayList<String>();
    	System.out.println(query);
    	try {
			suggestions = areaService.getRecommendations(query);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
  
        return suggestions;
    }
    @GetMapping("/searchEngine")
    public String searchEngineTest() {
   
        return "searchEngine";
    }
    
    @GetMapping("/jSearchA")
    public ResponseEntity<String> searchPlacesByArea(@RequestParam("areaName") String areaName) {
        
    	List<PlaceDTO> searchResults2 = placeService.searchPlacesByArea(areaName);
        StringBuilder sb = new StringBuilder();
        for (PlaceDTO place : searchResults2) {
            sb.append("Place ID: ").append(place.getPlaceId()).append("<br>");
            sb.append("Place Name: ").append(place.getPlaceName()).append("<br>");
            sb.append("Latitude: ").append(place.getLatitude()).append("<br>");
            sb.append("Longitude: ").append(place.getLongitude()).append("<br>");
            sb.append("Address: ").append(place.getAddress()).append("<br>");
            sb.append("Average Score: ").append(place.getPlaceAvgScore()).append("<br>");
            sb.append("<br>");
        }
                
        if (searchResults2.isEmpty()) {
            System.out.println("검색결과 없음.");
        }
        
        return new ResponseEntity<>(sb.toString(), HttpStatus.OK);
    }
   

    
    @GetMapping("/jSearchAC")
    public String searchPlacesByAreaOrCategory(@RequestParam("areaName") String areaName, @RequestParam("categoryName") String categoryName, Model model3) {
    	

    	System.out.println(areaName);
    	System.out.println(categoryName);
    	
    	List<PlaceDTO> searchResults4 = placeService.searchPlacesByAreaOrCategory(areaName, categoryName);
    	model3.addAttribute("placesByAreaOrCategory", searchResults4);
    	System.out.println(searchResults4);
    	if (searchResults4.isEmpty()) {
    		System.out.println("검색결과 없음.");
    	}
    	
    	return "naverMap";
    }
      

     
    
    
}
