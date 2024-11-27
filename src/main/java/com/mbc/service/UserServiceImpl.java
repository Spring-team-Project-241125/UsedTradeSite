package com.mbc.service;

import org.springframework.stereotype.Service;

import com.mbc.domain.UserVO;
import com.mbc.mapper.UserMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

	private final UserMapper mapper;
	
	@Override
	public UserVO get(Long uno) {
		log.info("get.....");
		
		return mapper.read(uno);
	}

	@Override
	public void register(UserVO vo) {
		log.info("register.....");
		
		mapper.create(vo);
	}
	
	@Override
	public boolean isIdAvailable(String id) {
		log.info("id Available?");		
		
		return mapper.existsById(id);
	}

	@Override
	public int modify(UserVO vo) {
		log.info("modify.....");
		
		return mapper.update(vo);
	}

	@Override
	public int remove(Long uno) {
		log.info("remove.....");
		
		return mapper.delete(uno);
	}

}
