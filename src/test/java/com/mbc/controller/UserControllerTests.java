package com.mbc.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
//Test for Controller
@WebAppConfiguration
public class UserControllerTests {
	
	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before  // 모든 테스트 전 매번 실행되는 메서드
	public void setup() {
		// 가상 구조를 세팅, 화면(View)이 없어도 Controller도 테스트 진행 가능
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testGet() throws Exception {
		
		ModelMap modelMap = mockMvc.perform(MockMvcRequestBuilders.get("/user/detail")
				.param("uno", "1"))
			.andReturn().getModelAndView().getModelMap();
		
		log.info("modelMap : " + modelMap);
	}
	
	@Test
	public void testRegister() throws Exception {
		
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/user/register")
				.param("id", "test01")
				.param("pwd", "1111")
			).andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	
	@Test
	public void testModify() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/user/modify")
				.param("uno", "1")
				.param("id", "user01")
				.param("pwd", "1234")
			).andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	
	@Test
	public void testRemove() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/user/remove")
				.param("uno", "9")
			).andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
}
