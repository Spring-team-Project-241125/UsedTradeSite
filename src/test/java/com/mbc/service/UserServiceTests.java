package com.mbc.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.mbc.domain.UserVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserServiceTests {
	
	@Autowired
	private UserService service;
	
	@Test
	public void testGet() {
		log.info(service.get(1L));
	}
	
	@Test
	public void testRegister() {
		UserVO vo = new UserVO();
		vo.setId("test01");
		vo.setPwd("1111");
		
		service.register(vo);
		
		log.info("생성된 아이디 : " + vo.getId());
	}
	
	@Test
	public void testIdAvailable() {
		UserVO vo = new UserVO();
		vo.setId("test01");
		
		boolean result = service.isIdAvailable(vo.getId());
		
		log.info("아이디 중복 : " + result);
	}
	
	@Test
	public void testModify() {
		UserVO vo = service.get(8L);
		
		if(vo == null) return;
		
		vo.setPwd("1234");
		int result = service.modify(vo);
		
		log.info("modify result : " + result);
	}
	
	@Test
	public void testRemove() {
		int result = service.remove(8L);
		
		log.info("remove reulst : " + result);		
	}
}
