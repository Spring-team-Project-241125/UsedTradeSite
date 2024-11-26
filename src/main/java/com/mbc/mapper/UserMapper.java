package com.mbc.mapper;

import com.mbc.domain.UserVO;

public interface UserMapper {
	
	// 나의 회원정보
	public UserVO read(Long uno);
	
	// 회원가입(등록)
	public void create(UserVO vo);
	
	// 회원정보 수정
	public int update(UserVO vo);
	
	// 회원탈퇴
	public int delete(Long uno);
	
}
