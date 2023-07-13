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
	private CourseReviewService coursereviewservice;
	
	@Autowired
	private PlaceReviewService placereviewservice;
	
	/* http://localhost:8090/review  */
	@RequestMapping(value = "/review", method = RequestMethod.GET)
	public String insertCourseReviewForm(@RequestParam(value = "placeId1", required = false) String placeId1, 
			                        	 @RequestParam(value = "placeId2", required = false) String placeId2, 
										 @RequestParam(value = "placeId3", required = false) String placeId3, 
										 @RequestParam(value = "placeId4", required = false) String placeId4, 
										 @RequestParam(value = "placeId5", required = false) String placeId5,
										 @RequestParam(value= "courseId") String courseId) {
		
		return "review";
	}
	
	
	/* 코스리뷰 작성 이랑 장소 리뷰 별점 표기  */ // http://localhost:8090/review 
	@RequestMapping(value = "/review", method= RequestMethod.POST)
	public String insertCouseReview(@ModelAttribute CourseReview coursereview,
			                        @RequestParam(value="score" , required=false) int star,
			                        @RequestParam(value="userId" , required=false) int userId,
			                        @RequestParam(value="score1" , required=false) int placeScore1,
			                        @RequestParam(value="score2" , required=false) int placeScore2,
			                        @RequestParam(value="score3" , required=false) int placeScore3,
			                        @RequestParam(value="score4" , required=false) int placeScore4,
			                        @RequestParam(value="score5" , required=false) int placeScore5,
			                        @RequestParam(value = "placeId1", required = false) Integer placeId1, 
									@RequestParam(value = "placeId2", required = false) Integer placeId2, 
									@RequestParam(value = "placeId3", required = false) Integer placeId3, 
									@RequestParam(value = "placeId4", required = false) Integer placeId4, 
									@RequestParam(value = "placeId5", required = false) Integer placeId5
			                        ) throws Exception { 
		
		System.out.println(star);

		coursereview.setCourseScore(star);
		System.out.println(coursereview);
		
		PlaceReview pr1 = new PlaceReview();
		pr1.setPlaceId(placeId1);
		pr1.setPlaceScore(placeScore1);
		pr1.setUserId(userId);
		
		
		PlaceReview pr2 = new PlaceReview();
		pr2.setPlaceId(placeId2);
		pr2.setPlaceScore(placeScore2);
		pr2.setUserId(userId);
		
		PlaceReview pr3 = new PlaceReview();
		pr3.setPlaceId(placeId3);
		pr3.setPlaceScore(placeScore3);
		pr3.setUserId(userId);
		
		PlaceReview pr4 = new PlaceReview();
		pr4.setPlaceId(placeId4);
		pr4.setPlaceScore(placeScore4);
		pr4.setUserId(userId);
		
		PlaceReview pr5 = new PlaceReview();
		pr5.setPlaceId(placeId5);
		pr5.setPlaceScore(placeScore5);
		pr5.setUserId(userId);
		
		coursereviewservice.insertCourseReview(coursereview);
		
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
		CourseReview coursereview = coursereviewservice.getCourseReviewByReviewId(courseReviewId);
		System.out.println(coursereview);
		model.addAttribute("coursereview", coursereview);
		
		
		model.addAttribute("test", 3);
		model.addAttribute("test", 5);
		model.addAttribute("test", 3);
		model.addAttribute("test", 4);
		model.addAttribute("test", 5);
		
		return "updatereview";
	}
		
	/* 코스 리뷰 수정 */ // http://localhost:8090/review/{course_review_id}
	@RequestMapping(value = "/review/{course_review_id}", method= RequestMethod.PUT)
	public String updateCourseReview(@PathVariable("course_review_id") int courseReviewId,
			                         @ModelAttribute("content") String content,
			                         @ModelAttribute("courseScore") int courseScore,
			                         @RequestParam(value="score1" , required=false) int placescore1,
				                     @RequestParam(value="score2" , required=false) int placescore2,
				                     @RequestParam(value="score3" , required=false) int placescore3,
				                     @RequestParam(value="score4" , required=false) int placescore4,
				                     @RequestParam(value="score5" , required=false) int placescore5,
			                         @RequestParam(value = "placeId1", required = false) Integer placeId1, 
									 @RequestParam(value = "placeId2", required = false) Integer placeId2, 
									 @RequestParam(value = "placeId3", required = false) Integer placeId3, 
									 @RequestParam(value = "placeId4", required = false) Integer placeId4, 
									 @RequestParam(value = "placeId5", required = false) Integer placeId5) throws Exception { 
		
		// 코스 리뷰 아이디를 통해서 수정하기 
		CourseReview coursereview = coursereviewservice.getCourseReviewByReviewId(courseReviewId);
		System.out.println(coursereview);
		coursereview.setContent(content);
		coursereview.setCourseScore(courseScore);

		coursereviewservice.updateCourseReview(coursereview);
		
		System.out.println("placeId: " + placeId1);
		
		PlaceReview pr1 = new PlaceReview();
		pr1.setPlaceId(placeId1);
		pr1.setPlaceScore(placescore1);
		
		
		PlaceReview pr2 = new PlaceReview();
		pr2.setPlaceId(placeId2);
		pr2.setPlaceScore(placescore2);
		
		PlaceReview pr3 = new PlaceReview();
		pr3.setPlaceId(placeId3);
		pr3.setPlaceScore(placescore3);
		
		PlaceReview pr4 = new PlaceReview();
		pr4.setPlaceId(placeId4);
		pr4.setPlaceScore(placescore4);
		
		PlaceReview pr5 = new PlaceReview();
		pr5.setPlaceId(placeId5);
		pr5.setPlaceScore(placescore5);
		
		placereviewservice.updatePlaceReview(pr1);
		placereviewservice.updatePlaceReview(pr2);
		placereviewservice.updatePlaceReview(pr3);
		placereviewservice.updatePlaceReview(pr4);
		placereviewservice.updatePlaceReview(pr5);
		
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


