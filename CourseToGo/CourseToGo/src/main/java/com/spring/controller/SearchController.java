package com.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.dto.PlaceDTO;
import com.spring.service.PlaceService;

@Controller
public class SearchController {
	@Autowired
	private PlaceService placeService;
	
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
    
    //placeName
//    @GetMapping("/search")
//    public ResponseEntity<String> searchPlacesGet(@RequestParam("placeName") String placeName) {
//       
//    	List<PlaceDTO> searchResults = placeService.searchPlacesByPlaceName(placeName);
//        
//        StringBuilder sb = new StringBuilder();
//        for (PlaceDTO place : searchResults) {
//            sb.append("Place ID: ").append(place.getPlaceId()).append("<br>");
//            sb.append("Place Name: ").append(place.getPlaceName()).append("<br>");
//            sb.append("Latitude: ").append(place.getLatitude()).append("<br>");
//            sb.append("Longitude: ").append(place.getLongitude()).append("<br>");
//            sb.append("Address: ").append(place.getAddress()).append("<br>");
//            sb.append("Average Score: ").append(place.getPlaceAvgScore()).append("<br>");
//            sb.append("<br>");
//        }
//           
//        if (searchResults.isEmpty()) {
//            System.out.println("검색결과 없음.");
//        }
//        
//        return new ResponseEntity<>(sb.toString(), HttpStatus.OK);
//    }
//    
//    @GetMapping("/search")
//    public String searchPlacesGet(@RequestParam("placeName") String placeName,
//    								Model model) {
//        
//    	List<PlaceDTO> searchResults = placeService.searchPlacesByPlaceName(placeName);
//        
//        model.addAttribute("placeList", searchResults);
//           
//        if (searchResults.isEmpty()) {
//            System.out.println("검색결과 없음.");
//        }
//        
//        return "naverMap";
//    }

    
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
   
//    @GetMapping("/jSearchA")
//    public String searchPlacesByArea(@RequestParam("areaName") String areaName,
//    								Model model1) {
//    	List<PlaceDTO> searchResults2 = placeService.searchPlacesByArea(areaName);
//    	model1.addAttribute("placesByArea", searchResults2);
//    	
//    	
//    	if (searchResults2.isEmpty()) {
//    		System.out.println("검색결과 없음.");
//    	}
//    	
//    	return "naverMap";
//    }
   
//    @GetMapping("/jSearchC")
//    public ResponseEntity<String> searchPlacesByCategory(@RequestParam("categoryName") String categoryName) {
//    	
//    	List<PlaceDTO> searchResults3 = placeService.searchPlacesByCategory(categoryName);
//    	StringBuilder sb = new StringBuilder();
//    	for (PlaceDTO place : searchResults3) {
//    		sb.append("Place ID: ").append(place.getPlaceId()).append("<br>");
//    		sb.append("Place Name: ").append(place.getPlaceName()).append("<br>");
//    		sb.append("Latitude: ").append(place.getLatitude()).append("<br>");
//    		sb.append("Longitude: ").append(place.getLongitude()).append("<br>");
//    		sb.append("Address: ").append(place.getAddress()).append("<br>");
//    		sb.append("Average Score: ").append(place.getPlaceAvgScore()).append("<br>");
//    		sb.append("<br>");
//    	}
//    	
//    	if (searchResults3.isEmpty()) {
//    		System.out.println("검색결과 없음.");
//    	}
//    	
//    	return new ResponseEntity<>(sb.toString(), HttpStatus.OK);
//    }
    
  
//    @GetMapping("/jSearchAC")
//    public ResponseEntity<String>searchPlacesByAreaOrCategory(@RequestParam("areaName") String areaName, @RequestParam("categoryName") String categoryName) {
//    	
//    	List<PlaceDTO> searchResults4 = placeService.searchPlacesByAreaOrCategory(areaName, categoryName);
//    	StringBuilder sb = new StringBuilder();
//    	for (PlaceDTO place : searchResults4) {
//    		sb.append("Place ID: ").append(place.getPlaceId()).append("<br>");
//    		sb.append("Place Name: ").append(place.getPlaceName()).append("<br>");
//    		sb.append("Latitude: ").append(place.getLatitude()).append("<br>");
//    		sb.append("Longitude: ").append(place.getLongitude()).append("<br>");
//    		sb.append("Address: ").append(place.getAddress()).append("<br>");
//    		sb.append("Average Score: ").append(place.getPlaceAvgScore()).append("<br>");
//    		sb.append("<br>");
//    	}
//    	
//    	if (searchResults4.isEmpty()) {
//    		System.out.println("검색결과 없음.");
//    	}
//    	
//    	return new ResponseEntity<>(sb.toString(), HttpStatus.OK);
//    }
    
    @GetMapping("/jSearchAC")
    public String searchPlacesByAreaOrCategory(@RequestParam("areaName") String areaName, @RequestParam("categoryName") String categoryName, Model model3) {
    	
//    	if (categoryName.equals("''") || categoryName.equals("") ) {
//			categoryName = null;
//		}
//    	if (areaName.equals("''") || areaName.equals("") ) {
//    		areaName = null;
//    	}
    	
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
