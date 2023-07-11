package com.spring.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.spring.dto.CourseDTO;
import com.spring.dto.CoursePlaceDTO;
import com.spring.dto.PlaceDTO;
import com.spring.service.CoursePlaceService;
import com.spring.service.CourseService;
import com.spring.service.PlaceService;

@RestController
public class MarkerController {
	@Autowired
	private CourseService courseService;
	@Autowired
	private CoursePlaceService cpService;
	@Autowired
	private PlaceService placeService;
	

	@PostMapping("/saveMarker")
	 public void saveMarker(HttpServletRequest request, 
							@RequestParam String courseName, 
							@RequestParam int courseNumber, 
							@RequestParam (value = "placeId4", required = false) Integer placeId1, 
							@RequestParam(value = "placeId4", required = false) Integer placeId2, 
							@RequestParam(value = "placeId4", required = false) Integer placeId3, 
							@RequestParam(value = "placeId4", required = false) Integer placeId4, 
							@RequestParam(value = "placeId5", required = false) Integer placeId5) 
	{
	        
        HttpSession session = request.getSession();
//        int userId = (int) session.getAttribute("user_id");
        int userId = 1;
    	
        CourseDTO course = CourseDTO.builder().userId(userId).courseName(courseName).courseNumber(courseNumber).build();
    	
    	
	    	try {
				courseService.insertCourse(course);
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		    	
		    	Integer[] placeIdList = new Integer[5]; 
		    	placeIdList[0] = placeId1;
		    	placeIdList[1] = placeId2;
		    	placeIdList[2] = placeId3;
		    	placeIdList[3] = placeId4;
		    	placeIdList[4] = placeId5;
    			
    	
    	for (int i = 0; i < courseNumber; i++) {
    		
//    		PlaceDTO placeDTO = placeService.getPlaceByPlaceId(placeIdList[i]);
    		CoursePlaceDTO coursePlace = CoursePlaceDTO.builder().placeId(placeIdList[i]).selectionOrder(i+1).build();
    		try {
				cpService.insertCoursePlace(coursePlace);
			} catch (Exception e) {
				e.printStackTrace();
			}
  		   		
    		
		}
    
    }
}