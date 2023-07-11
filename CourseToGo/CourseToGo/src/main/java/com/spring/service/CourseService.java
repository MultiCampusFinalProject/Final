package com.spring.service;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.dto.CourseDTO;
import com.spring.dto.CourseInformDTO;
import com.spring.mapper.CourseMapper;
import com.spring.mapper.RestaurantMapper;

import lombok.RequiredArgsConstructor;

@Service
public class CourseService {
	@Autowired
	CourseMapper courseMapper;
	


	public int insertCourse(CourseDTO course) throws Exception {
		int courseId = -1;
				
		 courseMapper.insertCourse(course);
		 courseId = course.getCourseId();	
		 System.out.println();
			if(courseId == -1) {
				throw new Exception("no sequence");
			} else {
			
			}
				
			return courseId;
		
	}
	public List<CourseInformDTO>  getAllCourses() throws Exception {
	
		List<CourseInformDTO> res=new ArrayList<>();
				 res= courseMapper.getAllCourses();
				System.out.println(res);
				if(!res.isEmpty()) {
					
				} else {
					throw new Exception("no data");
				}
				
				return res;
		
	}
	public CourseDTO getCourseById(int courseId) throws SQLException {
		CourseDTO res;
//		System.out.println("service = " +courseId);
		 res= courseMapper.getCourseById(courseId);
		System.out.println(res);
		if(res==null
				) {
			
		} else {
//			throw new Exception("no data");
		}
		
		return res;
	}



}