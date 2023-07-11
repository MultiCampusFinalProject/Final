package com.spring.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@NoArgsConstructor
@Getter
@Setter
@ToString
public class CourseInformDTO {
    private int courseId;
    private int userId;
    private String courseName;
    private double courseAvgScore;
    private int courseNumber;
    private	String courseList;
    private	String courseIdList;
    private String courseContent;
    @Builder
    public CourseInformDTO(int courseId, int userId, String courseName, double courseAvgScore, int courseNumber,String courseIdList,String courseList,String courseContent) {
        this.courseId = courseId;
        this.userId = userId;
        this.courseName = courseName;
        this.courseAvgScore = courseAvgScore;
        this.courseNumber = courseNumber;
        this.courseIdList = courseIdList;
        this.courseList = courseList;
        this.courseContent = courseContent;
    }
    
}