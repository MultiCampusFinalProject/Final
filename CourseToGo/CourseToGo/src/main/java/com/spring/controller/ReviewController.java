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
	
	@RequestMapping(value = "/review", method = RequestMethod.GET)
	public String insertCourseReviewForm(@RequestParam(value = "placeId1", required = false) String placeId1, 
			                        	 @RequestParam(value = "placeId2", required = false) String placeId2, 
										 @RequestParam(value = "placeId3", required = false) String placeId3, 
										 @RequestParam(value = "placeId4", required = false) String placeId4, 
										 @RequestParam(value = "placeId5", required = false) String placeId5,
										 @RequestParam(value= "courseId") String courseId) {
		
		Integer[] placeIdList = new Integer[5]; //[0,0,0,0,0]

		if(!placeId1.equals("")&&!placeId1.equals("undefined"))placeIdList[0] = Integer.parseInt(placeId1);
   	    if(!placeId2.equals("")&&!placeId2.equals("undefined"))placeIdList[1] = Integer.parseInt(placeId2);
   	    if(!placeId3.equals("")&&!placeId3.equals("undefined"))placeIdList[2] = Integer.parseInt(placeId3);
   	    if(!placeId4.equals("")&&!placeId4.equals("undefined"))placeIdList[3] = Integer.parseInt(placeId4);
   	    if(!placeId5.equals("")&&!placeId5.equals("undefined"))placeIdList[4] = Integer.parseInt(placeId5);
		
//   	    if(placeIdList[3] == 0) {
//   	    	//place가 3개
//   	    }
//   	    else if (placeIdList[4] == 0) {
//   	    	// place가 4개
//   	    }
//   	    
   	    
		
		return "review";
	}
	
	
	/* 코스리뷰 작성 이랑 장소 리뷰 별점 표기  */ // http://localhost:8090/review 
	@RequestMapping(value = "/review", method= RequestMethod.POST)
	public String insertCouseReview(@ModelAttribute CourseReview coursereview,
			                        @RequestParam(value="score" , required=false) int star,
			                        @RequestParam(value= "courseId", required=false) String courseId,
			                        @RequestParam(value="userId" , required=false) int userId,
			                        @RequestParam(value="score1" , required=false) String placeScore1,
			                        @RequestParam(value="score2" , required=false) String placeScore2,
			                        @RequestParam(value="score3" , required=false) String placeScore3,
			                        @RequestParam(value="score4" , required=false) String placeScore4,
			                        @RequestParam(value="score5" , required=false) String placeScore5,
			                        @RequestParam(value = "placeId1", required = false) String placeId1, 
									@RequestParam(value = "placeId2", required = false) String placeId2, 
									@RequestParam(value = "placeId3", required = false) String placeId3, 
									@RequestParam(value = "placeId4", required = false) String placeId4, 
									@RequestParam(value = "placeId5", required = false) String placeId5
			                        ) throws Exception { 
		
		System.out.println(star);

		coursereview.setCourseScore(star);
		System.out.println(coursereview);
		
		Integer[] placeScoreList = new Integer[5];
		
		if(!placeScore1.equals("")&&!placeScore1.equals("undefined"))placeScoreList[0] = Integer.parseInt(placeScore1);
   	    if(!placeScore2.equals("")&&!placeScore2.equals("undefined"))placeScoreList[1] = Integer.parseInt(placeScore2);
   	    if(!placeScore3.equals("")&&!placeScore3.equals("undefined"))placeScoreList[2] = Integer.parseInt(placeScore3);
   	    if(!placeScore4.equals("")&&!placeScore4.equals("undefined"))placeScoreList[3] = Integer.parseInt(placeScore4);
   	    if(!placeScore5.equals("")&&!placeScore5.equals("undefined"))placeScoreList[4] = Integer.parseInt(placeScore5);
   	    
		Integer[] placeIdList = new Integer[5]; 
		
		if(!placeId1.equals("")&&!placeId1.equals("undefined"))placeIdList[0] = Integer.parseInt(placeId1);
   	    if(!placeId2.equals("")&&!placeId2.equals("undefined"))placeIdList[1] = Integer.parseInt(placeId2);
   	    if(!placeId3.equals("")&&!placeId3.equals("undefined"))placeIdList[2] = Integer.parseInt(placeId3);
   	    if(!placeId4.equals("")&&!placeId4.equals("undefined"))placeIdList[3] = Integer.parseInt(placeId4);
   	    if(!placeId5.equals("")&&!placeId5.equals("undefined"))placeIdList[4] = Integer.parseInt(placeId5);
		
   	    
   	    System.out.println("placeIdList[4]: " + placeIdList[4]);
   	    
		PlaceReview pr1 = new PlaceReview();
	    pr1.setPlaceScore(placeScoreList[0]);
	    pr1.setPlaceId(placeIdList[0]);
	    pr1.setUserId(userId);

		
		
		PlaceReview pr2 = new PlaceReview();
	    pr2.setPlaceScore(placeScoreList[1]);
	    pr2.setPlaceId(placeIdList[1]);
	    pr2.setUserId(userId);

		
		PlaceReview pr3 = new PlaceReview();
        pr3.setPlaceScore(placeScoreList[2]);
        pr3.setPlaceId(placeIdList[2]);
        pr3.setUserId(userId);

		
		PlaceReview pr4 = new PlaceReview();
        pr4.setPlaceScore(placeScoreList[3]);
        pr4.setPlaceId(placeIdList[3]);
        pr4.setUserId(userId);

		
		PlaceReview pr5 = new PlaceReview();
        pr5.setPlaceScore(placeScoreList[4]);
        pr5.setPlaceId(placeIdList[4]);
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


