package com.spring.mapper;

import java.sql.SQLException;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.spring.dto.UserBookmarkCourseDTO;

@Mapper
public interface BookmarkMapper {
	
	// ---------------------------------------------------------------
	public int insertCourseBookmark(@Param("userId") int userId, @Param("courseId") int courseId) throws SQLException;


}