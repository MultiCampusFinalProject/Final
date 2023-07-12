package com.spring.controller;


import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.dto.CourseDTO;
import com.spring.dto.CoursePlaceDTO;
import com.spring.dto.PlaceDTO;
import com.spring.service.CoursePlaceService;
import com.spring.service.CourseService;
import com.spring.service.DirectionService;
import com.spring.service.PlaceService;

@Controller
public class MarkerController {
	@Autowired
	private CourseService courseService;
	@Autowired
	private CoursePlaceService cpService;
	@Autowired
	private PlaceService placeService;
	@Autowired
	private DirectionService directionService;
	@Transactional
	@PostMapping("/saveMarker")
	 public String saveMarker(HttpServletRequest request, 
							@RequestParam String courseName, 
							@RequestParam int courseNumber, 
							@RequestParam String courseContent, 
							@RequestParam(value = "placeId1", required = false) Integer placeId1, 
							@RequestParam(value = "placeId2", required = false) Integer placeId2, 
							@RequestParam(value = "placeId3", required = false) Integer placeId3, 
							@RequestParam(value = "placeId4", required = false) Integer placeId4, 
							@RequestParam(value = "placeId5", required = false) Integer placeId5,
     RedirectAttributes redirectAttributes)
	 						
	{
		redirectAttributes.addAttribute("placeId1", placeId1);
		redirectAttributes.addAttribute("placeId2", placeId2);
		redirectAttributes.addAttribute("placeId3", placeId3);
		redirectAttributes.addAttribute("placeId4", placeId4);
		redirectAttributes.addAttribute("placeId5", placeId5);    
        HttpSession session = request.getSession();
//        int userId = (int) session.getAttribute("userId");
        int userId = 1;
        int courseId = -1;
        System.out.println(courseContent);
        //CourseDTO 생성
        CourseDTO course = CourseDTO.builder().userId(userId)
        					.courseName(courseName)
        					.courseNumber(courseNumber)
        					.courseContent(courseContent)
        					.build();
    	
    	
	    	try {
	    		
	    		//CourseService에 삽입
	    	 courseId = 	courseService.insertCourse(course); // course update
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		    	
		    	Integer[] placeIdList = new Integer[5]; 
		    	placeIdList[0] = placeId1;
		    	placeIdList[1] = placeId2;
		    	placeIdList[2] = placeId3;
		    	placeIdList[3] = placeId4;
		    	placeIdList[4] = placeId5;
    			
    	System.out.println(courseId);
    	for (int i = 0; i < courseNumber; i++) {
    		
    		//주어진 코스에 맞게 코스 플레이스 관계형 데이터 삽입
    		CoursePlaceDTO coursePlace = CoursePlaceDTO.builder().courseId(courseId).placeId(placeIdList[i]).selectionOrder(i+1).build();
    		try {
				cpService.insertCoursePlace(coursePlace); // coursePlace : update
			} catch (Exception e) {
				e.printStackTrace();
			}
  		   		
    		
		}
    	
    	
    	//direction15api를 활용한 실제 경로데이터 삽입 ( 제작시에)
    	//1. place1 의 위도 경로 정보
    	
    	//2. place + courseNumber 의 위도 경도 정보
    	//3. 1~ courseNumber 사이의 경유지 위도 경도 정보
    	
    	PlaceDTO place= null;
    	
    	String start= null;
    	String goal =null;
    	  String waypoints = null;
    	  String[] longLatList = new String[5];
    	  
    	String apiUrl = "https://naveropenapi.apigw.ntruss.com/map-direction-15/v1/driving";
    	for (int i = 0; i < courseNumber; i++) {
    		try {
				place = placeService.getPlaceByPlaceId(placeIdList[i]);
				longLatList[i] = place.getLongitude()+","+place.getLatitude();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
    	start = longLatList[0];
    	if(courseNumber > 1)goal = longLatList[courseNumber-1];
    	
    	for(int i = 0 ; i < courseNumber-2;i++) {
    		
    		
    		if(waypoints == null)waypoints ="";
    		waypoints =waypoints+ longLatList[i] +":" + longLatList[i+1];
    		if(i != courseNumber-2)waypoints+="|";
    	}
    	
    	
    		
    		
    	
    	
        
       
       
    	String encodedWaypoints=null;
	      System.out.println(goal);
          System.out.println(start);
          System.out.println(waypoints);
          try {
			encodedWaypoints = URLEncoder.encode(waypoints, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
          
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-NCP-APIGW-API-KEY-ID",  "eeovn23rmv");
        headers.set("X-NCP-APIGW-API-KEY", "u1LzIow7CE8uktkBnVz6oPo4utFP9fYgNMeP64zZ");
        
        MultiValueMap<String, String> requestBody = new LinkedMultiValueMap<>();
        requestBody.add("start", start);
        requestBody.add("goal", goal);
        requestBody.add("waypoints", waypoints);
        RestTemplate restTemplate = new RestTemplate();
        URI uri= null;
        
        try {
        	if(courseNumber > 2) {
        		  uri = new URI(apiUrl + "?start=" + start + "&goal=" + goal + "&waypoints=" + encodedWaypoints);
        	}
        	if(courseNumber ==1) {
        		 return "CourseList";
        	}
        	if(courseNumber == 2) {
        		  uri = new URI(apiUrl + "?start=" + start + "&goal=" + goal);
        	}
         
        } catch (URISyntaxException e) {
            e.printStackTrace();
            return "CourseList";
        }
        System.out.println("start=" + start + "&goal=" + goal + "&waypoints=" + waypoints);
        RequestEntity<?> requestEntity = new RequestEntity<>(headers, HttpMethod.GET, uri);
        
        ResponseEntity<String> responseEntity = restTemplate.exchange(requestEntity, String.class);
        String responseBody = responseEntity.getBody();
        System.out.println(responseBody);
        directionService.insertDirections(responseBody, courseId);// 경로 저장
//        redirectAttributes.addAttribute("placeId1", placeId1);
        return "courseList";
    }
}