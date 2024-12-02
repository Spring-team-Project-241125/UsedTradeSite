package com.mbc.mapper;

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
public class UserMapperTests {
	
	@Autowired
	private UserMapper mapper;
	
	@Test
	public void testRead() {
		UserVO vo = mapper.read(2L);
		
		log.info(vo);
	}
	
	@Test
	public void testCreate() {
		UserVO vo = new UserVO();
		vo.setId("test01");
		vo.setPwd("1111");
		
		mapper.create(vo);
		
		log.info(vo);
	}
	
	@Test
	public void testIdAvailable() {
		UserVO vo = new UserVO();
		vo.setId("test10");

		boolean result = mapper.existsById(vo.getId());
		
		log.info("exists id : " + result);
	}
	
	@Test
	public void testUpdate() {
		UserVO vo = new UserVO();
		vo.setUno(6L);
		vo.setPwd("1234");
		
		int count = mapper.update(vo);
		
		log.info("Update count: " + count);
	}
	
	@Test
	public void testDelete() {
		int count = mapper.delete(6L);
		
		log.info("Delete count: " + count);
	}
}
