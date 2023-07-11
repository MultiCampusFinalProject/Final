package com.spring.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.dto.CourseDTO;
import com.spring.dto.CourseInformDTO;

@Mapper
public interface CourseMapper {

	public int insertCourse(CourseDTO course) throws SQLException;

	public List<CourseInformDTO> getAllCourses() throws SQLException;

	public CourseDTO getCourseById(int courseId) throws SQLException;

}
