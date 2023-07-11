package com.spring.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;

import com.spring.dto.CourseDTO;
import com.spring.dto.CourseInformDTO;
import com.spring.dto.CourseReview;
import com.spring.dto.DirectionDTO;
import com.spring.dto.DirectionPoint;
import com.spring.dto.PlaceDTO;
import com.spring.dto.Restaurant;
import com.spring.mapper.PlaceMapper;
import com.spring.mapper.RestaurantMapper;
import com.spring.service.CourseReviewService;
import com.spring.service.CourseService;
import com.spring.service.DirectionService;
import com.spring.service.PlaceService;

import lombok.RequiredArgsConstructor;




@Controller
@RequiredArgsConstructor
public class CourseController {
	final DirectionService directionService;
	final private MongoTemplate mongoTemplate;
	final PlaceService placeService;
	final private CourseService courseService;
	final private CourseReviewService reviewService;
	@RequestMapping( value = "/courseList")
	public String naverMap(Model model) {
		List<CourseInformDTO> courseInformList=new ArrayList<>();
		try {
		courseInformList	 =  courseService.getAllCourses();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("CourseInformList", courseInformList);
	
		return "CourseList";
	}
	@RequestMapping(value = "/courseList/Map", method = RequestMethod.GET)
	public String showMapPage(Model model,
	         @RequestParam(value = "courseId", required = false) String courseId,
             @RequestParam(value = "placeId1", required = false) Integer placeId1,
             @RequestParam(value = "placeId2", required = false) Integer placeId2,
             @RequestParam(value = "placeId3", required = false)Integer placeId3,
             @RequestParam(value = "placeId4", required = false) Integer placeId4,
             @RequestParam(value = "placeId5", required = false) Integer placeId5)  {
	    // Map 페이지를 표시하는 로직 작성
		if (courseId == null) {
	        // courseId가 null인 경우 처리 로직 작성
	        // 예: 에러 메시지 출력 또는 기본 값 설정 등
	    } else {
	    CourseDTO course = null;
		try {
			course = courseService.getCourseById(Integer.parseInt(courseId));
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
	    int courseNum = course.getCourseNumber();
	    int[] placeIdList = new int[5]; 
	    placeIdList[0]= placeId1;
	    placeIdList[1]=placeId2;
	    placeIdList[2]= placeId3;
	    if(placeId4 !=null)placeIdList[3]= placeId4;
	    if(placeId5 !=null)placeIdList[4]= placeId5;
	   
	   List<PlaceDTO> placeList = new ArrayList<>();
	    for(int i = 0 ; i < courseNum; i++) {
	    	
	    	try {
				placeList.add(placeService.getPlaceByPlaceId(placeIdList[i]));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    }
	    System.out.println("---");
//		System.out.println(mongoTemplate.getDb().getName());
		
		// boot <-> spring-data-mongodb
//		Query query = new Query();
//		System.out.println(courseId);
//		Criteria criteria = Criteria.where("_id").is(Integer.parseInt(courseId));
//		query.addCriteria(criteria);
//		Query query1 =new Query();
//		Criteria criteria1 = Criteria.where("_id").is(2);
//		query1.addCriteria(criteria1);
////		List<Document>  ratingList1 = mongoTemplate.find(query1, Document.class, "directions");
//		List<Document>  ratingList = mongoTemplate.find(query, Document.class, "directions");
//		System.out.println(ratingList);
////		System.out.println(ratingList1);
//		List<DirectionPoint> DirectionList = new ArrayList<>();
		List<DirectionDTO> DirectionList = directionService.getDirectionsByCourseId(Integer.parseInt(courseId));
				//이후에 document list가 아니라 directionPointlist로 받아 처리 변경 수행하겠음
//		System.out.println(ratingList.size());
	
//		for (Document document : ratingList) {
//		    ArrayList<Document> directionPointList = (ArrayList<Document>) document.get("directionPointList");
//		    System.out.println(directionPointList.size());
//		    for (Document location : directionPointList) {
//		        Double latitude = location.getDouble("mapYCoordinate");
//		        Double longitude = location.getDouble("mapXCoordinate");
//		        DirectionList.add(new DirectionPoint(latitude, longitude));
//		        System.out.println("Latitude: " + latitude + ", Longitude: " + longitude);
//		    }
//		}
		
		List<CourseReview> courseReview = null;
		try {
			courseReview = reviewService.getCourseReviewByCourseId(Integer.parseInt(courseId));
			System.out.println(courseReview);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("DirectionList", DirectionList);
//		System.out.println(placeList);
		model.addAttribute("PlaceList", placeList);
//		model.add
		model.addAttribute("Course", course);
		model.addAttribute("CourseReview", courseReview);
	    return "CourseMap"; // 뷰 이름 반환 (map.html 또는 map.jsp 등)
	}
		return "CourseMap";
		}
	
}
