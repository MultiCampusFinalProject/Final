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
public class CourseDTO {
    private int courseId;
    private int userId;
    private String courseName;
    private String courseContent;
    private double courseAvgScore;
    private int courseNumber;

 // ������
    @Builder
    public CourseDTO(int courseId, int userId, String courseName,String courseContent, double courseAvgScore, int courseNumber) {
        this.courseId = courseId;
        this.userId = userId;
        this.courseName = courseName;
        this.courseContent = courseContent;
        this.courseAvgScore = courseAvgScore;
        this.courseNumber = courseNumber;
    }
    
}