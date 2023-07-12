package com.spring.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.dto.CtgUserDTO;
import com.spring.dto.UserBookmarkCourseDTO;
import com.spring.service.BookmarkService;

@Controller
public class BookmarkController {
	
	@Autowired
	private BookmarkService bkService;
	
	// 코스 리스트에서 찜하기 기능----------------------------------------------------
	@RequestMapping(value = "/courseList", method = RequestMethod.POST)
	public String insertCourseBookmark(@RequestParam("courseId") int courseId, 
									   HttpSession session) {
		int userId = (int) session.getAttribute("userId");
		
		UserBookmarkCourseDTO ubmk = new UserBookmarkCourseDTO();
//		System.out.println(userId);
//		System.out.println(courseId);
		ubmk.setUserId(userId);
		ubmk.setCourseId(courseId);

		try {
			bkService.insertCourseBookmark(userId, courseId);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return "redirect:/courseList";
	}
	
}
