package com.spring.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class CtgUserDTO {
	
    private int userId;
    
    @JsonProperty("id")
    private String naverId;
    
    @JsonProperty("name")
    private String userName;
    
    @JsonProperty("nickname")
    private String userNickname;
    
    @JsonProperty("email")
    private String userEmail;
    
    @JsonProperty("birthyear")
    private int userBirthYear;
    
    private int userAdmin;   
    private String userPhoto;  
    private String userIntroduce;
    
    
    @Builder // 회원가입 필수정보(userId 제외)만으로 이루어진 builder
    public CtgUserDTO(String naverId, String userName, String userNickname, String userEmail,
    			   int userBirthYear) {
    	this.naverId = naverId;
    	this.userName = userName;
    	this.userNickname = userNickname;
		this.userEmail = userEmail;
		this.userBirthYear = userBirthYear;
    }
    
    
}
