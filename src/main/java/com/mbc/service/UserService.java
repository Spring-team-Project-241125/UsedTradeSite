package com.mbc.service;

import org.springframework.stereotype.Service;

import com.mbc.domain.UserVO;

@Service
public interface UserService {
	
	public UserVO get(Long uno);
	
	public void register(UserVO vo);
	
	public boolean isIdAvailable(String id);
	
	public int modify(UserVO vo);
	
	public int remove(Long uno);
	
}