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
    private double courseAvgScore;
    private int courseNumber;

 // »ý¼ºÀÚ
    @Builder
    public CourseDTO(int courseId, int userId, String courseName, double courseAvgScore, int courseNumber) {
        this.courseId = courseId;
        this.userId = userId;
        this.courseName = courseName;
        this.courseAvgScore = courseAvgScore;
        this.courseNumber = courseNumber;
    }
    
}