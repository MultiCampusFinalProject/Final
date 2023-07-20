package com.spring.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.dto.CourseDTO;
import com.spring.dto.CourseInformDTO;
import com.spring.dto.PageRequestDTO;
import com.spring.dto.SearchKeyword;

@Mapper
public interface CourseMapper {

	public int insertCourse(CourseDTO course) throws SQLException;

	public List<CourseInformDTO> getAllCourses() throws SQLException;

	public CourseDTO getCourseById(int courseId) throws SQLException;

	public List<CourseInformDTO> getCourseBySearchKeyword(SearchKeyword searchKeyword)throws SQLException;

	public int getTotalCount(PageRequestDTO pageRequest)throws SQLException;

	public List<CourseInformDTO> getCourseWithPageRequest(PageRequestDTO pageRequest);

	public CourseInformDTO getCourseInformByCourseId(int courseId);

	public List<CourseInformDTO> getCourseInformByUserId(int userId)throws SQLException;

	
	
	// 코스작성왕
	public List<Integer> getCourseTop3();

	

}
