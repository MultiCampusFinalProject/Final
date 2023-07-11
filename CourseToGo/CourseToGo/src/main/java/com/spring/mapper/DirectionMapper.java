package com.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.dto.DirectionDTO;
import com.spring.dto.PlaceDTO;

@Mapper
public interface DirectionMapper {

	void insertDirectionList(List<DirectionDTO> directionDTOList);

	List<DirectionDTO> getDirectionsByCourseId(int courseId);		
}
