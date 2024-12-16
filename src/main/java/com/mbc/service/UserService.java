package com.mbc.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mbc.domain.UserVO;
import com.mbc.domain.AttachVO;

@Service
public interface UserService {
	
	public UserVO get(Long uno);
	
	public void register(UserVO vo);
	
	public boolean isIdAvailable(String id);
	
	public int modify(UserVO vo);
	
	public int remove(Long uno);
	
	public List<AttachVO> getAttachList(Long uno);
	
	public UserVO authenticate(String id, String pwd);
	
	public Long getUnoByUsername(String username);
	
}