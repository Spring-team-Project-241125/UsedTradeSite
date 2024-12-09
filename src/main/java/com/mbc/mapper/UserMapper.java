package com.mbc.mapper;

import com.mbc.domain.UserVO;

public interface UserMapper {
	
	// 나의 회원정보
	public UserVO read(Long uno);
	
	// 회원가입(등록)
	public void create(UserVO vo);
	
	// 아이디 중복 확인
	public boolean existsById(String id);
	
	// 회원정보 수정
	public int update(UserVO vo);
	
	// 회원탈퇴
	public int delete(Long uno);
	
	 // 사용자 인증 체크
    public UserVO checkUser(String id, String pwd);  // id와 pwd가 일치하는 사용자 존재 여부 확인
	
}
