package com.spring.mapper;


import org.apache.ibatis.annotations.Mapper;

import com.spring.dto.CoursePlaceDTO;
import com.spring.dto.PlaceDTO;

@Mapper
public interface CoursePlaceMapper {

//	public PlaceDTO getPlaceByPlaceId(int placeId);

	public int insertCoursePlace(CoursePlaceDTO coursePlace);

}
