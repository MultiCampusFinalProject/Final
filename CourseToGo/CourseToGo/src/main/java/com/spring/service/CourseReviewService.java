package com.spring.service;

import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.spring.dto.CourseReview;
import com.spring.mapper.CourseReviewMapper;


@Service
public class CourseReviewService {
	
	@Autowired
	CourseReviewMapper mapper;

	
	/* 코스 리뷰 아이디 검색 */ 
	public CourseReview getCourseReviewByReviewId(int courseReviewId) throws Exception { 
		  CourseReview coursereview = mapper.getCourseReviewByReviewId(courseReviewId);
		
		return coursereview; 
	}


	
	/* 코스 리뷰 등록 */
	public boolean insertCourseReview(CourseReview coursereview) throws SQLException, Exception {
		
		boolean result = false;
		
		int res = mapper.insertCourseReview(coursereview);
		
		if(res != 0) {
			result = true;
		} else {
			throw new Exception("리뷰 등록 실패");
		}
		
		return result;
	}

	
	/* 코스 리뷰 수정 */
	public boolean updateCourseReview(CourseReview coursereview) throws SQLException, Exception {
		boolean result = false;
		
		int res = mapper.updateCourseReview(coursereview);
		
		if(res != 0) {
			result = true;
		} else {
			throw new Exception("리뷰 수정 실패");
		}
		
		return result;
	}
	
	/* 코스 리뷰 삭제 */
	public boolean deleteCourseReviewByReviewId(int courseReviewId) throws SQLException, Exception {
		boolean result = false;
		
		int res = mapper.deleteCourseReviewByReviewId(courseReviewId);
		
		
		if(res != 0) {
			result = true;
		} else {
			throw new Exception("리뷰 삭제 실패");
		}
		
		return result;
	}
	
	public List<CourseReview> getCourseReviewByCourseId(int courseId) throws Exception { 
		List<CourseReview> coursereview = mapper.getCourseReviewByCourseId(courseId);
		
		return coursereview; 
	}


	// userId로 CourseReview 객체 리스트 반환
	public List<CourseReview> getCourseReviewByUserId(int userId) throws SQLException {
		return mapper.getCourseReviewByUserId(userId);
	}
	

    // userId와 courseId로 CourseReview 객체 리스트 반환
    public CourseReview getCourseReviewByUserIdAndCourseId(int userId, int courseId) throws SQLException {
        return mapper.getCourseReviewByUserIdAndCourseId(userId, courseId);
    }


    // 코스리뷰왕
	public List<Integer> getReviewTop3() throws SQLException{
		return mapper.getReviewTop3();
	}	
	
	

	
}

