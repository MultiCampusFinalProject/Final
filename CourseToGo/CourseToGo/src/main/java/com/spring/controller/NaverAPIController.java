package com.spring.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.dto.CtgUserDTO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class NaverAPIController {
	
	// application.properties에 저장된 값들-------------------------
	@Value("${naver.api.login.client.id}")
	private String clientId;	
	
	@Value("${naver.api.login.client.secret}")			
	private String clientSecret;			
				
	@Value("${naver.api.login.apiURL}")			
	private String apiURL;	
	
	@Value("${naver.api.login.callbackURL}")			
	private String callbackURL;	
	
	@Value("${naver.api.new.access.token.apiURL}")			
	private String newAccessTokenApiURL;	
	// ----------------------------------------------------------
	
	@Autowired
	private NaverAPIProfileController profileController;
	
	@Autowired
	private CtgUserController userController;

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

	// localhost:----/test 로 callback URL을 설정. 출력해줄 jsp는 myPage.jsp입니다
	@GetMapping(value = "/test")
	public String loginPOSTNaver(@RequestParam("code") String code,
								 @RequestParam("state") String state,
								 HttpSession session) {
		int sessionTime = 60 * 60; // 1시간
		session.setMaxInactiveInterval(sessionTime);
		
		log.info("login 시도");
		String redirectURI = "";
		      
		try {
			redirectURI = URLEncoder.encode(callbackURL, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		  
		// 접근 토큰 발급 요청 URL
		String apiURL;
		apiURL = newAccessTokenApiURL;
		apiURL += "client_id=" + clientId;
		apiURL += "&client_secret=" + clientSecret;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&code=" + code;
		apiURL += "&state=" + state;
		//log.info("접근 토큰 발급 요청 apiURL = "+apiURL); //<-접근 토큰 발급 요청 URL 확인하고 싶으면 활성화
		JSONObject json = null; // 접근 토큰(json객체)
		try {
		    URL url = new URL(apiURL);
		    HttpURLConnection con = (HttpURLConnection)url.openConnection();
		    con.setRequestMethod("GET");
		    int responseCode = con.getResponseCode();
		    log.info("접근 토큰 응답 코드 = "+responseCode); // <- 응답받은 접근 토큰 '응답 코드' 확인 200:성공 
		
		    BufferedReader br;           
		    	if(responseCode==200) { // 정상 호출시 connection에서 가져온 정보 입력
		    		br = new BufferedReader(new InputStreamReader(con.getInputStream()));
		    	} else {  // 에러 발생시
		    		br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
		    	}
		
			String inputLine;
			StringBuffer res = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
			  res.append(inputLine);
			}
			log.info("접근 토근 응답 json 확인 :" + res); // <- 응답받은 접근 '토큰 내용' 확인
			log.info("여기까지 접근 토큰 요청 과정");
		            
		    br.close();
			 
			if(responseCode==200) { // 정상 호출시 응답받은 토큰을 JSONObject로 변환  
		          json = new JSONObject(res.toString());
		          System.out.println("json : " + json);
		    }	    			            
		} catch (Exception e) {
		    System.out.println(e);
		}
		        
		CtgUserDTO user = profileController.getMemberProfile(json); // 접근 토큰을 이용해 네이버에서 유저 프로필을 가져와 user 객체에 맵핑해 돌려주는 메서드
		
		// 맵핑한 user객체정보로 DB접속, 기존 등록된 회원인지 확인
		CtgUserDTO searchUser = userController.getCtgUserByNaverIdAndName(user.getNaverId().substring(0, 10),
															   		   user.getNaverId().substring(user.getNaverId().length() -10),
																	   user.getUserName());
		
		// 등록된 회원이 아니면
		if (searchUser == null) {
			userController.insertCtgUser(user);
			CtgUserDTO newUser = userController.getCtgUserByNaverIdAndName(user.getNaverId().substring(0, 10),
			   		   user.getNaverId().substring(user.getNaverId().length() -10),
					   user.getUserName());
			
			session.setAttribute("userId", newUser.getUserId());
			session.setAttribute("userName", newUser.getUserName());
			session.setAttribute("userEmail", newUser.getUserEmail());
			session.setAttribute("userNickname", newUser.getUserNickname());
			session.setAttribute("userIntroduce", newUser.getUserIntroduce());
			session.setAttribute("userPhoto", newUser.getUserPhoto());

			return "signupDone";
		}else {
			
		// 등록된 회원이라면	
			session.setAttribute("userId", searchUser.getUserId());
			session.setAttribute("userName", searchUser.getUserName());
			session.setAttribute("userEmail", searchUser.getUserEmail());
			session.setAttribute("userNickname", searchUser.getUserNickname());
			session.setAttribute("userIntroduce", searchUser.getUserIntroduce());
			session.setAttribute("userPhoto", searchUser.getUserPhoto());
			return "redirect:/home";
		}	
	}
}