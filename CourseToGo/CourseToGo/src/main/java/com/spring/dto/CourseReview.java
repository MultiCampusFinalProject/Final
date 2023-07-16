package com.spring.dto;


import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class CourseReview {
	
	private int courseReviewId; //리뷰 아이디
	private int courseId; // 코스아이디
	private int userId;   // 사용자
	private String content; // 리뷰내용 
	private int courseScore; // 리뷰 평점 
	private Date reviewDate; // 리뷰 날짜 
	
	
	@Builder
	public CourseReview(int courseId, int userId, String content, int courseScore, Date reviewDate) {
		this.courseId = courseId;
		this.userId = userId;
		this.content = content;
		this.courseScore = courseScore;
		this.reviewDate = reviewDate;
	}
}
