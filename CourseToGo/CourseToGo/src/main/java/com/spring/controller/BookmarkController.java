package com.spring.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.dto.CtgUserDTO;
import com.spring.dto.UserBookmarkCourseDTO;
import com.spring.service.BookmarkService;

@Controller
public class BookmarkController {
	
	@Autowired
	private BookmarkService bkService;
	
	// 코스 리스트에서 찜하기 기능----------------------------------------------------
	@RequestMapping(value = "/courseBookmark", method = RequestMethod.POST)
	public String insertUserBookmark(@ModelAttribute("courseId") String courseId, 
									   HttpSession session) {
		
		CtgUserDTO user =  (CtgUserDTO) session.getAttribute("user");
		int intCourseId = Integer.parseInt(courseId);
		
		System.out.println(user);
		System.out.println(intCourseId);
		
		try {
			bkService.insertUserBookmark(user.getUserId(), intCourseId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return "redirect:/courseList";
	}
	
	// 유저 아이디를 통해 유저가 북마크한 코스 객체 리스트 반환 ----------------------------------
	public List<UserBookmarkCourseDTO> getUserBookmarkListByUserId(int userId) {
		
		List<UserBookmarkCourseDTO> bookmarkList = null;
		
		try {
			bookmarkList = bkService.getUserBookmarkListByUserId(userId);
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
		return bookmarkList;
	}
	
	// 유저 아이디를 통해 유저가 북마크한 리스트 삭제
	public int deleteUserBookmarkListByUserId(int userId) {
		int result = 0;
		
		try {
			result = bkService.deleteUserBookmarkListByUserId(userId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 유저 아이디와 코스 아이디를 통해 유저의 북마크 삭제 
	public boolean deleteUserBookmarkByUserIdAndCourseId(int userId, int courseId) {
		boolean result = false;
		
		try {
			result = bkService.deleteUserBookmarkByUserIdAndCourseId(userId, courseId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}

	
}
