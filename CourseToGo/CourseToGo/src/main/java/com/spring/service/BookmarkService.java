package com.spring.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.dto.UserBookmarkCourseDTO;
import com.spring.mapper.BookmarkMapper;

@Service
public class BookmarkService {
	
	@Autowired
	private BookmarkMapper bkMapper;
	
	// 코스 리스트에서 찜하기 기능----------------------------------------------------
	public boolean insertUserBookmark(int userId, int courseId) throws SQLException{
		int result = bkMapper.insertUserBookmark(userId, courseId);
		
		if(result != 0) {
			return true;
		}
		return false;
	}

	// 유저 아이디를 통해 유저가 북마크한 코스 객체 리스트 반환 ----------------------------------
	public List<UserBookmarkCourseDTO> getUserBookmarkListByUserId(int userId) throws SQLException {
		return bkMapper.getUserBookmarkListByUserId(userId);
	}

	// 유저 아이디를 통해 유저가 북마크한 리스트 삭제 ----------------------------------
	public int deleteUserBookmarkListByUserId(int userId) throws SQLException {
		return bkMapper.deleteUserBookmarkListByUserId(userId);
	}

	// 유저 아이디와 코스 아이디를 통해 유저의 북마크 삭제 --------------------------------	
	public boolean deleteUserBookmarkByUserIdAndCourseId(int userId, int courseId) throws SQLException {
		return bkMapper.deleteUserBookmarkByUserIdAndCourseId(userId, courseId);
	}
	

	
	
	
	
	
	
	
	
	
	
	
}