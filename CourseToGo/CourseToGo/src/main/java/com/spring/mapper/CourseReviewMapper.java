package com.spring.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

import org.apache.ibatis.annotations.Mapper;

import com.spring.dto.CourseReview;


@Mapper
public interface CourseReviewMapper {
	
	/* 코스 리뷰 아이디 검색 */
	public List<CourseReview> getCourseReviewByCourseId (int courseId);
	
	/* 코스 리뷰 작성하기 */
	public int insertCourseReview(CourseReview coursereview) throws SQLException;
	
	/* 코스 리뷰 수정하기 */
    public int updateCourseReview(CourseReview coursereview) throws SQLException;
    
	/* 코스 리뷰  삭제하기 */
	public int deleteCourseReviewByCourseId(int courseReviewId)throws SQLException;
	
	

}
