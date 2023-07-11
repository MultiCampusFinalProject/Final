package com.spring.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.dto.CourseDTO;
import com.spring.mapper.DirectionMapper;
import com.spring.dto.DirectionDTO;
@Service
public class DirectionService {
	@Autowired
	DirectionMapper directionMapper;
	

	public void insertDirections(String responseBody, int courseId) {
		// TODO Auto-generated method stub
		 ObjectMapper objectMapper = new ObjectMapper();
		 try {
	            JsonNode rootNode = objectMapper.readTree(responseBody);
	            JsonNode pathNode = rootNode.path("route").path("traoptimal").get(0).path("path");
	            List<DirectionDTO> directionDTOList = new ArrayList<>();

	            if (pathNode.isArray()) {
	                int directionOrder = 1;
	                for (JsonNode coordinateNode : pathNode) {
	                    double longitude = coordinateNode.get(0).asDouble();
	                    double latitude = coordinateNode.get(1).asDouble();
	                    DirectionDTO directionDTO = DirectionDTO.builder()
	                            .courseId(courseId)
	                            .directionOrder(directionOrder++)
	                            .latitude(latitude)
	                            .longitude(longitude)
	                            .build();
	                    directionDTOList.add(directionDTO);
	                }
	            }
	            System.out.println(directionDTOList);
	            directionMapper.insertDirectionList(directionDTOList);
	}
		 catch (IOException e) {
	            e.printStackTrace();
	        }
}
	
	  public List<DirectionDTO> getDirectionsByCourseId(int courseId) {
	        return directionMapper.getDirectionsByCourseId(courseId);
	    }
	
}