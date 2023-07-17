package com.spring.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.ui.Model;

import com.spring.dto.CourseDTO;
import com.spring.dto.CourseInformDTO;
import com.spring.dto.CourseReview;
import com.spring.dto.CtgUserDTO;
import com.spring.dto.DirectionDTO;
import com.spring.dto.DirectionPoint;
import com.spring.dto.PlaceDTO;
import com.spring.dto.RankingItem;
import com.spring.dto.Restaurant;
import com.spring.dto.SearchKeyword;
import com.spring.mapper.PlaceMapper;
import com.spring.mapper.RestaurantMapper;
import com.spring.dto.PageRequestDTO;
import com.spring.dto.PageResponseDTO;
import com.spring.service.CourseReviewService;
import com.spring.service.CourseService;
import com.spring.service.DirectionService;
import com.spring.service.PlaceService;
import com.spring.service.RankingService;

import lombok.RequiredArgsConstructor;




@Controller
@RequiredArgsConstructor
public class CourseController {
	final DirectionService directionService;
	final private MongoTemplate mongoTemplate;
	private final RankingService rankingService;
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

//	@RequestMapping( value = "/courseList/keyword")
	@RequestMapping( value = "/courseListWithPagination")
	public String naverMap(PageRequestDTO pageRequest ,Model model,HttpSession session) {
		List<CourseInformDTO> courseInformList=new ArrayList<>();
		System.out.println(pageRequest);
		CtgUserDTO user =  (CtgUserDTO) session.getAttribute("user");
	    int userId = user.getUserId();	
		pageRequest.setUserId(userId);
	    
		int total = 0;
		try {
			courseInformList = courseService.getCourseWithPageRequest(pageRequest);
//		acourseInformList	 =  courseService.getCourseBySearchKeyword(searchKeyword);
			//collectSearchKeyword - 
			total = courseService.getTotalCount(pageRequest);
//		s	searchService.saveSearchKeyword(userId, keyword);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		PageResponseDTO pageResponse = new PageResponseDTO(total, 10, pageRequest);
		System.out.println(pageResponse);
		model.addAttribute("CourseInformList", courseInformList);
		model.addAttribute("pageInfo", pageResponse);
		//추천 코스 id
		List<String> recommandedCourses = rankingService.sortCourseIdByCount();
		List<CourseInformDTO> recommandedCourseInformList = new ArrayList<CourseInformDTO>();
		System.out.println(recommandedCourses);
		
		for(String temp : recommandedCourses) {
			try {
			CourseInformDTO recommandedCourseinform	= courseService.getCourseInformByCourseId(Integer.parseInt(temp));
			recommandedCourseInformList.add(recommandedCourseinform);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		System.out.println(recommandedCourseInformList);
		model.addAttribute("recommandedCourseInformList",recommandedCourseInformList);
		
		return "CourseList";
	}
	@RequestMapping( value = "/modalInform")
	@ResponseBody
	public String showModal(Model model, @RequestParam int placeId) {
		 // 모달에 표시할 데이터 조회 및 가공
	   PlaceDTO data = null;
	try {
		data = placeService.getPlaceByPlaceId(placeId);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	    
	    // JSON 데이터 생성
	String jsonData = "{"
		    + "\"placeName\": \"" + data.getPlaceName() + "\","
		    + "\"주소\": \"" + data.getAddress() + "\","
		    + "\"score\": \"" + data.getPlaceAvgScore() + "\""
		    + "}";
	    
	    return jsonData;
		
	}
	@RequestMapping(value = "/courseList/Map", method = RequestMethod.GET)
	public String showMapPage(Model model,
	         @RequestParam(value = "courseId", required = false) String courseId,
	         @RequestParam(value = "courseNumber", required = false) String courseNumber,
             @RequestParam(value = "placeId1", required = false) Float placeId1,
             @RequestParam(value = "placeId2", required = false) Float placeId2,
             @RequestParam(value = "placeId3", required = false) Float placeId3,
             @RequestParam(value = "placeId4", required = false) Float placeId4,
             @RequestParam(value = "placeId5", required = false) Float placeId5
			)  {
		
		if(placeId1 == null) {
			System.out.println("id1 = null");
		}
		
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
	    if(placeId1!=null)placeIdList[0]= Float.valueOf(placeId1).intValue();
	    if(placeId2!=null)placeIdList[1]= Float.valueOf(placeId2).intValue();
	    if(placeId3!=null)placeIdList[2]= Float.valueOf(placeId3).intValue();
	    if(placeId4!=null)placeIdList[3]= Float.valueOf(placeId4).intValue();
	    if(placeId5!=null)placeIdList[4]= Float.valueOf(placeId5).intValue();
	   System.out.println(placeIdList);
	   
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

		List<DirectionDTO> DirectionList = directionService.getDirectionsByCourseId(Integer.parseInt(courseId));

		
		List<CourseReview> courseReview = null;
		try {
			courseReview = reviewService.getCourseReviewByCourseId(Integer.parseInt(courseId));
			System.out.println(courseReview);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(DirectionList);
		model.addAttribute("DirectionList", DirectionList);
//		System.out.println(placeList);
		model.addAttribute("PlaceList", placeList);
//		model.add

		model.addAttribute("Course", course);
		model.addAttribute("CourseReview", courseReview);
//		List<RankingItem> topRankingItems = rankingService.getTopRankingItems();
//	    model.addAttribute("topRankingItems", topRankingItems);
//	    System.out.println(topRankingItems);
	   
	    
	    return "CourseMap"; // 뷰 이름 반환 (map.html 또는 map.jsp 등)
	}
		return "CourseMap";
		}
	   @GetMapping("/topRanking")
	    public String getTopRanking(Model model) {
	        
//	        model.addAttribute("topRankingItems", topRankingItems);
//	        System.out.println(topRankingItems);
	        return "test"; // Return the name of your view page
	    }
}
