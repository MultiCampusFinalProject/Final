package com.spring.service;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.dto.CtgUserDTO;
import com.spring.dto.UserBookmarkCourseDTO;
import com.spring.mapper.BookmarkMapper;
import com.spring.mapper.CtgUserMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BookmarkService {
	
	@Autowired
	private BookmarkMapper bkMapper;
	
	// ---------------------------------------------------------------
	public boolean insertCourseBookmark(int userId, int courseId) throws SQLException{
		int result = bkMapper.insertCourseBookmark(userId, courseId);
		
		if(result != 0) {
			return true;
		}
		return false;
	}
}