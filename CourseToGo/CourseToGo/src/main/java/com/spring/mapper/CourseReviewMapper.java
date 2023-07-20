package com.spring.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.spring.dto.CourseReview;


@Mapper
public interface CourseReviewMapper {
	
	/* 코스 리뷰 아이디 검색 */
	public CourseReview getCourseReviewByReviewId (int courseReviewId);
	
	/* 코스 리뷰 작성하기 */
	public int insertCourseReview(CourseReview coursereview) throws SQLException;
	
	/* 코스 리뷰 수정하기 */
    public int updateCourseReview(CourseReview coursereview) throws SQLException;
    
	/* 코스 리뷰  삭제하기 */
	public int deleteCourseReviewByReviewId(int courseReviewId)throws SQLException;
	
    /* 코스 아이디 검색 */
    public List<CourseReview> getCourseReviewByCourseId (int courseId) throws SQLException;
	
	// userId로 CourseReview 객체 리스트 반환	
    public List<CourseReview> getCourseReviewByUserId(int userId) throws SQLException;

    // userId와 courseId로 CourseReview 객체 리스트 반환
    public CourseReview getCourseReviewByUserIdAndCourseId(@Param("userId") int userId, @Param("courseId") int courseId) throws SQLException;

    // 코스리뷰왕
	public List<Integer> getReviewTop3() throws SQLException;

	

}
