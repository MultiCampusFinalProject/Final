package com.spring.controller;



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
import com.spring.dto.CourseReview;
import com.spring.dto.PlaceReview;
import com.spring.service.CourseReviewService;
import com.spring.service.PlaceReviewService;

@Controller
public class ReviewController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	@Autowired
	private CourseReviewService service;
	
	@Autowired
	private PlaceReviewService placereviewservice;
	
	/* http://localhost:8090/review  */
	@RequestMapping(value = "/review", method = RequestMethod.GET)
	public String insertCourseReviewForm() {
		
		return "review";
	}
	
	
	/* 코스리뷰 작성 이랑 장소 리뷰 별점 표기  */ // http://localhost:8090/review 
	@RequestMapping(value = "/review", method= RequestMethod.POST)
	public String insertCouseReview(@ModelAttribute CourseReview coursereview,
			                         @RequestParam(value="score" , required=false) int star,
			                         @RequestParam(value="userId" , required=false) int userId,
			                         @RequestParam(value="score5" , required=false) int star5,
			                         @RequestParam(value="placeId5" , required=false) int place5,
			                         @RequestParam(value="score4" , required=false) int star4,
			                         @RequestParam(value="placeId4" , required=false) int place4,
			                         @RequestParam(value="score3" , required=false) int star3,
			                         @RequestParam(value="placeId3" , required=false) int place3,
			                         @RequestParam(value="score2" , required=false) int star2,
			                         @RequestParam(value="placeId2" , required=false) int place2,
			                         @RequestParam(value="score1" , required=false) int star1,
			                         @RequestParam(value="placeId1" , required=false) int place1) throws Exception { 
		
		System.out.println(star);

		coursereview.setCourseScore(star);
		System.out.println(coursereview);
		
		PlaceReview pr5 = new PlaceReview();
		pr5.setPlaceId(place5);
		pr5.setPlaceScore(star5);
		pr5.setUserId(userId);
		
		
		PlaceReview pr4 = new PlaceReview();
		pr4.setPlaceId(place4);
		pr4.setPlaceScore(star4);
		pr4.setUserId(userId);
		
		PlaceReview pr3 = new PlaceReview();
		pr3.setPlaceId(place3);
		pr3.setPlaceScore(star3);
		pr3.setUserId(userId);
		
		PlaceReview pr2 = new PlaceReview();
		pr2.setPlaceId(place2);
		pr2.setPlaceScore(star2);
		pr2.setUserId(userId);
		
		PlaceReview pr1 = new PlaceReview();
		pr1.setPlaceId(place1);
		pr1.setPlaceScore(star1);
		pr1.setUserId(userId);
		
		service.insertCourseReview(coursereview);
		
		placereviewservice.insertPlaceReview(pr1);
		placereviewservice.insertPlaceReview(pr2);
		placereviewservice.insertPlaceReview(pr3);
		placereviewservice.insertPlaceReview(pr4);
		placereviewservice.insertPlaceReview(pr5);
		
		return "review";
		
	}

	/* 코스 리뷰 아이디 검색 */ // http://localhost:8090/review/21
	@RequestMapping(value = "/review/{course_review_id}", method = RequestMethod.GET)
	public String updateCourseForm(@PathVariable("course_review_id") int courseReviewId,
								Model model) throws Exception {
		
		// db값에 설정된 코스 리뷰 아이디를 가져오기
		CourseReview coursereview = service.getCourseReviewByReviewId(courseReviewId);
		model.addAttribute("coursereview", coursereview);
		
		return "updatereview";
	}
		
	/* 리뷰 수정 */ // http://localhost:8090/review/21
	@RequestMapping(value = "/review/{course_review_id}", method= RequestMethod.PUT)
	public String updateCourseReview(@PathVariable("course_review_id") int courseReviewId,
			                         @ModelAttribute("content") String content,
			                         @ModelAttribute("score") int courseScore) throws Exception { 
		
		// 코스 리뷰 아이디를 통해서 수정하기 
		CourseReview coursereview = service.getCourseReviewByReviewId(courseReviewId);
		System.out.println(coursereview);
		coursereview.setContent(content);
		coursereview.setCourseScore(courseScore);

		service.updateCourseReview(coursereview);
		
		return "redirect:/review";
		
	}
	
	/* 리뷰 삭제  */ 
	@RequestMapping(value = "/review/{course_review_id}", method= RequestMethod.DELETE)
	public String deleteCourse(@PathVariable("course_review_id") int courseReviewId) throws Exception { 
        
		System.out.println(courseReviewId);
		service.deleteCourseReviewByReviewId(courseReviewId);
		
		
		return "redirect:/review";
		
	}

}

