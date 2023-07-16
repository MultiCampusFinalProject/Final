package com.spring.controller;




import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.dto.CourseInformDTO;
import com.spring.dto.CourseReview;
import com.spring.dto.CtgUserDTO;
import com.spring.dto.PlaceDTO;
import com.spring.dto.PlaceReview;
import com.spring.service.CourseReviewService;
import com.spring.service.CourseService;
import com.spring.service.PlaceReviewService;
import com.spring.service.PlaceService;

@Controller
public class ReviewController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	@Autowired
	private CourseReviewService coursereviewservice;
	
	@Autowired
	private PlaceReviewService placereviewservice;
	
	@Autowired
	private PlaceService placeService;
	
	@Autowired
	private CourseService courseService;
	
	@RequestMapping(value = "/setReview", method = RequestMethod.GET)
	public String insertCourseReviewForm(@RequestParam(value = "placeId1", required = false) String placeId1, 
			                        	 @RequestParam(value = "placeId2", required = false) String placeId2, 
										 @RequestParam(value = "placeId3", required = false) String placeId3, 
										 @RequestParam(value = "placeId4", required = false) String placeId4, 
										 @RequestParam(value = "placeId5", required = false) String placeId5,
										 @RequestParam(value= "courseId") String courseId,
										 HttpSession session, Model model) {
		
		CtgUserDTO user = (CtgUserDTO) session.getAttribute("user");		
		Integer[] placeIds = new Integer[5];
		CourseInformDTO courseInform = null;
		
	    try {
	        placeIds[0] = placeId1 != null && !placeId1.isEmpty() ? Integer.parseInt(placeId1) : null;
	        placeIds[1] = placeId2 != null && !placeId2.isEmpty() ? Integer.parseInt(placeId2) : null;
	        placeIds[2] = placeId3 != null && !placeId3.isEmpty() ? Integer.parseInt(placeId3) : null;
	        placeIds[3] = placeId4 != null && !placeId4.isEmpty() ? Integer.parseInt(placeId4) : null;
	        placeIds[4] = placeId5 != null && !placeId5.isEmpty() ? Integer.parseInt(placeId5) : null;
	    } catch (NumberFormatException e) {
	        e.printStackTrace();
	    }
	    
   	    List<PlaceDTO> placeList = new ArrayList<PlaceDTO>();
   	    
		for (Integer placeId : placeIds) {
		    if (placeId != null) {
		        try {
					placeList.add(placeService.getPlaceByPlaceId(placeId));
				} catch (Exception e) {
					e.printStackTrace();
				}
		    }
		}
		

		
		try {
			courseInform = courseService.getCourseInformByCourseId(Integer.parseInt(courseId));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("courseId", courseId);
		model.addAttribute("placeList", placeList); // placeId, placeName만 사용
		model.addAttribute("user", user);
		model.addAttribute("courseInform", courseInform);
		
		return "setReview";
	}
	
	
	private String[] filterNullValues(String... models) {
	    List<String> filteredValues = new ArrayList<>();
	    for (String value : models) {
	        if (value != null && !value.isEmpty()) {
	            filteredValues.add(value);
	        }
	    }
	    return filteredValues.toArray(new String[filteredValues.size()]);
	}
	
	/* 코스리뷰 작성 이랑 장소 리뷰 별점 표기  */ // http://localhost:8090/review 
	@RequestMapping(value = "/review", method= RequestMethod.POST)
	public String insertCouseReview(@ModelAttribute CourseReview courseReview,
									@ModelAttribute("placeScore1") String placeScore1,
									@ModelAttribute("placeScore2") String placeScore2,
									@ModelAttribute("placeScore3") String placeScore3,
									@ModelAttribute("placeScore4") String placeScore4,
									@ModelAttribute("placeScore5") String placeScore5,
									@ModelAttribute("place1") String placeId1,
									@ModelAttribute("place2") String placeId2,
									@ModelAttribute("place3") String placeId3,
									@ModelAttribute("place4") String placeId4,
									@ModelAttribute("place5") String placeId5,
									HttpSession session) { 

		CtgUserDTO user = (CtgUserDTO) session.getAttribute("user");		
		
		String[] placeScores = filterNullValues(placeScore1, placeScore2, placeScore3, placeScore4, placeScore5);
		String[] placeIds = filterNullValues(placeId1, placeId2, placeId3, placeId4, placeId5);
		
		 for (int i = 0; i < placeScores.length; i++) {
			 System.out.println(placeScores[i]);
		 }		
		 for (int i = 0; i < placeIds.length; i++) {
			 System.out.println(placeIds[i]);
		 }		
		int placeCount = 0;
		String query = "";
		
		// placeScore, placeId가 비어있지 않을 시 placeReview insert 실행
				for (int i = 0; i < placeIds.length; i++) {
					if (placeScores[i] != null && placeIds[i] != null) {
						PlaceReview newPlaceReview = new PlaceReview(user.getUserId(), Integer.parseInt(placeIds[i]), Integer.parseInt(placeScores[i]));
						boolean result = false;
						
							try {
								result = placereviewservice.insertPlaceReview(newPlaceReview);
							} catch (Exception e) {
								e.printStackTrace();
							}
							if(result) {
								System.out.println("place" + i + "리뷰 결과 : " + result);			
								placeCount++;
							}
		
					}
				}
				// CourseReview insert 실행
				
				boolean result = false;
				
				try {
					result = coursereviewservice.insertCourseReview(courseReview);
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				if(result) {
					System.out.println("course 리뷰 결과 : " + result);						
				}
				    
		        query += ("courseId="+ String.valueOf(courseReview.getCourseId())+"&");
		        
		        for(int i= 0; i< placeCount; i++) {
		        	query+="placeId"+(i+1) + "="+placeIds[i];
		            	if (i!= placeCount-1) {
		            		query+="&";
		            	}
		            	else{
		            	}
		        }		
		        System.out.println(query);
			
		System.out.println(courseReview);
		
		return "redirect:/courseList/Map?" + query;
		
	}

	/* 코스 리뷰 아이디 검색 */ // http://localhost:8090/review/21
	@RequestMapping(value = "/review/{course_review_id}", method = RequestMethod.GET)
	public String updateCourseForm(@PathVariable("course_review_id") int courseReviewId,
								   Model model) throws Exception {
		
		// db값에 설정된 코스 리뷰 아이디를 가져오기
		CourseReview coursereview = coursereviewservice.getCourseReviewByReviewId(courseReviewId);
		System.out.println(coursereview);
		model.addAttribute("coursereview", coursereview);
	

		
		
		return "updatereview";
	}
		
	/* 코스 리뷰 수정 */ // http://localhost:8090/review/{course_review_id}
	@RequestMapping(value = "/review/{course_review_id}", method= RequestMethod.PUT)
	public String updateCourseReview(@PathVariable("course_review_id") int courseReviewId,
			                         @ModelAttribute("content") String content,
			                         @ModelAttribute("courseScore") int courseScore) throws Exception { 
		
		// 코스 리뷰 아이디를 통해서 수정하기 
		CourseReview coursereview = coursereviewservice.getCourseReviewByReviewId(courseReviewId);
		System.out.println(coursereview);
		coursereview.setContent(content);
		coursereview.setCourseScore(courseScore);

		coursereviewservice.updateCourseReview(coursereview);
		
		
		return "redirect:/review";
		
	}
	
	/* 코스 리뷰 삭제  */ 
	@RequestMapping(value = "/review/{course_review_id}", method= RequestMethod.DELETE)
	public String deleteCourse(@PathVariable("course_review_id") int courseReviewId) throws Exception { 
        
		System.out.println(courseReviewId);
		coursereviewservice.deleteCourseReviewByReviewId(courseReviewId);
		
		
		return "redirect:/review";
		
	}
	

}


