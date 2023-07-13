package com.spring.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.spring.dto.UserBookmarkCourseDTO;

@Mapper
public interface BookmarkMapper {
	
	// 코스 리스트에서 찜하기 기능----------------------------------------------------
	public int insertUserBookmark(@Param("userId") int userId, @Param("courseId") int courseId) throws SQLException;

	// 유저 아이디를 통해 유저가 북마크한 코스 객체 리스트 반환 ----------------------------------
	public List<UserBookmarkCourseDTO> getUserBookmarkListByUserId(int userId) throws SQLException;

	// 유저 아이디를 통해 유저가 북마크한 리스트 삭제 ----------------------------------
	public int deleteUserBookmarkListByUserId(int userId) throws SQLException;
	
	// 유저 아이디와 코스 아이디를 통해 유저의 북마크 삭제 --------------------------------
	public boolean deleteUserBookmarkByUserIdAndCourseId(@Param("userId") int userId,
														 @Param("courseId") int courseId) throws SQLException;

	
}