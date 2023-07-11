package com.spring.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.spring.dto.CtgUserDTO;


@Mapper
public interface CtgUserMapper {
	
	// 네이버 회원 정보가 맵핑된 CtgUser객체를 받아와 회원 가입 진행하는 메서드---------------------------------------------------------------
	public int insertCtgUser(CtgUserDTO user) throws SQLException;
	
	
	// 네이버 회원 정보가 맵핑된 CtgUser객체에서 받아온 naverId, userName 이용하여 기존에 존재하는 회원인지 확인하는 메서드----------------------------
	// 존재하면 : 해당 CtgUser 객체 / 존재하지 않으면 : null	
	public CtgUserDTO getCtgUserByNaverIdAndName(@Param("naverIdFront") String naverIdFront,
											  @Param("naverIdRear") String naverIdRear,
											  @Param("userName") String userName) throws SQLException;	
	
	
	// userId를 받아 회원DTO를 가져오는 메서드---------------------------------------------------------------------------------------
	// 존재하면 : 해당 CtgUser 객체 / 존재하지 않으면 : null	
	public CtgUserDTO getCtgUserByUserId(@Param("userId") int userId) throws SQLException;
	
	
	// 수정된 userDTO를 변수로 받아 업데이트하는 메서드---------------------------------------------------------------------------------------
	// 성공하면 : true / 실패하면 : false	
	public int updateCtgUser(CtgUserDTO ctgUser) throws SQLException;
	
	
	// 회원 탈퇴를 진행하는 메서드---------------------------------------------------------------------------------------
	// 성공하면 : true / 실패하면 : false
	public int unsignCtgUserByUserId(int userId) throws SQLException;




}