package com.spring.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mapper.AreaMapper;
import com.spring.mapper.CourseMapper;

@Service
public class AreaService {
	@Autowired
	AreaMapper areaMapper;

	public List<String> getRecommendations(String query) throws Exception {
		// TODO Auto-generated method stub
		
		List<String> result=  new ArrayList<>();
		result = areaMapper.getRecommendations(query);
		if(result!=null) {
			
		}
		else {
			throw new Exception("no data");
		}
		return 	result;
	}
}
