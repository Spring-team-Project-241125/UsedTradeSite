package com.mbc.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import com.mbc.domain.UserVO;
import com.mbc.security.domain.CustomUser;

import com.mbc.mapper.UserMapper;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	
	@Autowired
	private UserMapper userMapper;
	
	@Override
	public UserDetails loadUserByUsername(String userName) throws
	UsernameNotFoundException{
		
		log.warn("Load User By UserName : " + userName);
		
		//userName means userid
		UserVO vo = userMapper.readById(userName);
		
		log.warn("queried by member mapper: " + vo);
		
		return vo == null ? null : new CustomUser(vo);
		
	}
}
