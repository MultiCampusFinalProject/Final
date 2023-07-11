package com.spring.dto;

import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Getter;
import lombok.Setter;

@Document(collection = "directions")
@Getter
@Setter
public class Direction {
    @Id
    private int courseId;
    private List<DirectionPoint> directionPointList;
	public void setDirectionPointList(List<DirectionPoint> directionPointList2) {
		// TODO Auto-generated method stub
		directionPointList=directionPointList2;
	}


    // 생성자, getter, setter 등 필요한 메서드 추가

    // ...
}