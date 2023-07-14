package com.spring;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
//@ComponentScan(basePackages = "com.spring")
public class CourseToGo {

	public static void main(String[] args) {
		SpringApplication.run(CourseToGo.class, args);
	}

}
