package com.spring.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.dto.CourseDTO;
import com.spring.dto.CourseInformDTO;
import com.spring.dto.CtgUserDTO;
import com.spring.dto.UserBookmarkCourseDTO;
import com.spring.service.CourseService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class PageController {
	
	// 페이지이동, 세션관리 담당하는 컨트롤러
	
	@Autowired
	private CtgUserController userController;
	
	@Autowired
	private CourseService courseService;
	
	@Autowired
	private BookmarkController bookmarkController;
	
	@Value("${naver.api.login.client.id}")
	private String clientId;	
	
	@Value("${naver.api.login.callbackURL}")			
	private String callbackURL;	
	
	@Value("${naver.api.login.apiURL}")			
	private String apiURL;	
	
	// /home으로 접속시 네이버 로그인 화면으로 이동하는  "apiURL"주소를 세션에 저장하여 home.jsp로 이동.
	// "접근 토큰 요청" 메서드
	@GetMapping(value = "/home")			
	public String login(HttpSession session) {			
		log.info("home 화면 출력");	
			
		String redirectURI="";			
				
		try {		
			redirectURI = URLEncoder.encode(callbackURL, "UTF-8");	
		} catch (UnsupportedEncodingException e) {		
			e.printStackTrace();	
		}		
				
		SecureRandom random = new SecureRandom();			
		String state = new BigInteger(130, random).toString();			
					
		apiURL += "&client_id=" + clientId;			
		apiURL += "&redirect_uri=" + redirectURI;			
		apiURL += "&state=" + state;			
					
		session.setAttribute("apiURL", apiURL);			
					
		return "home";		
	}
	
	// 회원 정보를 수정하는 페이지로 이동하는 메서드----------------------------------------------------
	@GetMapping(value = "/myPageInformModify")
	public String updateCtgUserForm(){
		return "myPageInformModify";
	}
	
	@PostMapping(value = "/signupDone")
	public String signupDone(@ModelAttribute("userNickname") String newUserNickname,
							 @ModelAttribute("userIntroduce") String newUserIntroduce,
						 	 Model model, HttpSession session) {
	
		CtgUserDTO newUser = (CtgUserDTO)session.getAttribute("newUser");
		newUser.setUserNickname(newUserNickname);
		newUser.setUserIntroduce(newUserIntroduce);
		
		boolean result = userController.insertCtgUser(newUser);
		
		if (result) {	
			CtgUserDTO user = userController.getCtgUserByNaverIdAndName(newUser.getNaverId().substring(0, 10),
																		newUser.getNaverId().substring(newUser.getNaverId().length() -10),
																		newUser.getUserName());
			CtgUserDTO userForSession = new CtgUserDTO(user.getUserId(), user.getUserName(),
													   user.getUserNickname(), user.getUserEmail(),
													   user.getUserPhoto(), user.getUserIntroduce());
					
			session.setAttribute("user", userForSession);			
			return "signupDone";
		}
		return "home";
		
	}
	
	// 로그아웃 시 세션 소멸
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		if(session != null) {
			session.invalidate();
		}
		return "redirect:/home";
	}
	
	// 회원 정보 수정 페이지에서 입력된 닉네임과 자기소개를 받아 수정하는 메서드---------------------------------
	// 성공하면 : true / 실패하면 : false		
	@PostMapping(value = "/myPageInformModify")
	public String updateCtgUser(@ModelAttribute("userNickname") String userNickname,
								@ModelAttribute("userIntroduce") String userIntroduce,
								@ModelAttribute("userPhoto") String userPhoto,
								HttpSession session) { 
		CtgUserDTO user =  (CtgUserDTO) session.getAttribute("user");
		CtgUserDTO DBuser = userController.getCtgUserByUserId(user.getUserId());
		
		DBuser.setUserNickname(userNickname);
		user.setUserNickname(userNickname);
		DBuser.setUserIntroduce(userIntroduce);
		user.setUserIntroduce(userIntroduce);
		DBuser.setUserPhoto(userPhoto);
		user.setUserPhoto(userPhoto);
		
		boolean result = false;
		
		try {
			result = userController.updateCtgUser(DBuser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(result) {
			session.setAttribute("user", user);
			return "myPageInformModify"; 
		}
		return "redirect:/home"; 

	}
	
	@GetMapping(value = "/courseList")
	public String getCourseListPage(HttpSession session,
									Model model) {
		
		List<CourseInformDTO> courseInformList = new ArrayList<>();
		
		try {
			courseInformList = courseService.getAllCourses();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("CourseInformList", courseInformList);
		return "CourseList";
	}
	
	@GetMapping(value = "/naverMap")
	public String getCourseMakePage(HttpSession session) {
//		CtgUserDTO user = (CtgUserDTO) session.getAttribute("user");
//		System.out.println(user);		
		
		return "naverMap";
	}
	
	@GetMapping(value = "/userContents")
	public String getUserContentsPage(HttpSession session) {
//		CtgUserDTO user = (CtgUserDTO) session.getAttribute("user");
//		System.out.println(user);
		
		return "userContents";
	}
	
	@GetMapping(value = "/userBookmarkList")
	public String getUserBookmarkListPage(HttpSession session,
										  Model model) {
		CtgUserDTO user = (CtgUserDTO) session.getAttribute("user");
		List<UserBookmarkCourseDTO> userBookmarkList = bookmarkController.getUserBookmarkListByUserId(user.getUserId());		
		
		List<CourseInformDTO> courseInformList = new ArrayList<>();
		
		for(UserBookmarkCourseDTO userBookmark : userBookmarkList) {
			
			int courseId = userBookmark.getCourseId();
			CourseInformDTO courseInform = null;
			
			try {
				courseInform = courseService.getCourseInformByCourseId(courseId);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			courseInformList.add(courseInform);
		}
		
		model.addAttribute("CourseInformList", courseInformList);	
		
		return "userBookmarkList";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
