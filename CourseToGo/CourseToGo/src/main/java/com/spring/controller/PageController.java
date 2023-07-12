package com.spring.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.dto.CtgUserDTO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class PageController {
	
	// 페이지이동, 세션관리 담당하는 컨트롤러
	
	@Autowired
	private CtgUserController userController;
	
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
						 	 HttpSession session) {
		
		String newUserNaverId = (String)session.getAttribute("naverId");
		String newUserName = (String)session.getAttribute("userName");
			
		CtgUserDTO newUser = new CtgUserDTO(newUserNaverId, newUserName, newUserNickname, (String)session.getAttribute("userEmail"),
										    (int)session.getAttribute("userBirthYear"), newUserIntroduce);

// 위에 생성자로는 정상작동하는데 아래 빌더로는 작동이 안됨. 추후 프로젝트 완료 후 고쳐볼 예정.-PSY		
//		CtgUserDTO newUser = CtgUserDTO.builder()
//										.naverId(newUserNaverId)
//										.userName(newUserName)
//										.userNickname(newUserNickname)
//										.userEmail((String)session.getAttribute("userEmail"))
//										.userBirthYear((int)session.getAttribute("userBirthYear"))
//										.userIntroduce(newUserIntroduce)
//										.build();
		
		boolean result = userController.insertCtgUser(newUser);
		
		if (result) {
			session.removeAttribute("naverId");
			session.removeAttribute("userName");
			session.removeAttribute("userEmail");
			session.removeAttribute("userNickname");
			session.removeAttribute("userBirthYear");
	
			
			CtgUserDTO user = userController.getCtgUserByNaverIdAndName(newUserNaverId.substring(0, 10),
																		newUserNaverId.substring(newUserNaverId.length() -10),
																		newUserName);
			
			
			session.setAttribute("userId", user.getUserId());
			session.setAttribute("userName", user.getUserName());
			session.setAttribute("userEmail", user.getUserEmail());
			session.setAttribute("userNickname", user.getUserNickname());
			session.setAttribute("userPhoto", user.getUserPhoto());
			session.setAttribute("userIntroduce", user.getUserIntroduce());
			
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
