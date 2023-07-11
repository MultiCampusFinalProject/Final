package com.spring.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.dto.CtgUserDTO;

@Controller
public class PageController {
	
	// 페이지이동, 세션관리 담당하는 컨트롤러
	
	@Autowired
	private CtgUserController userController;
	
	// 회원 정보를 수정하는 페이지로 이동하는 메서드----------------------------------------------------
	@GetMapping(value = "/myPageInformModify")
	public String updateCtgUserForm(){ 
		return "myPageInformModify";
	}
	
//	@PostMapping(value = "/signupDone")
//	public String signupDone(@ModelAttribute("userNickname") String userNickname,
//							 @ModelAttribute("userIntroduce") String userIntroduce,
//						 	 HttpSession session) {
//		CtgUserDTO user = userController.getCtgUserByUserId((int) session.getAttribute("userId"));
//		user.setUserNickname(userNickname);
//		user.setUserIntroduce(userIntroduce);
//		
//		boolean result = false;
//		
//		try {
//			result = userController.updateCtgUser(user);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		if(result) {
//			session.setAttribute("userIntroduce", userIntroduce);
//			return "signupDone";
//		}
//		return "home"; 
//	}
	
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
		CtgUserDTO user = userController.getCtgUserByUserId((int) session.getAttribute("userId"));
		user.setUserNickname(userNickname);
		user.setUserIntroduce(userIntroduce);
		user.setUserPhoto(userPhoto);
		
		boolean result = false;
		
		try {
			result = userController.updateCtgUser(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(result) {
			session.setAttribute("userNickname", userNickname);
			session.setAttribute("userIntroduce", userIntroduce);
			session.setAttribute("userPhoto", userPhoto);
			return "myPageInformModify"; 
		}
		return "redirect:/home"; 
	}
}
