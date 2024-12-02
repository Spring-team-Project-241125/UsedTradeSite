package com.mbc.controller;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mbc.domain.ReviewVO;
import com.mbc.service.ReviewService;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
@WebAppConfiguration
public class ReviewControllerTests {

	@Autowired
	private ReviewService reviewService;
	
	private MockMvc mockMvc;
	
	@Before
	public void setUp() {
		// MockMvc 객체를 사용하여 ReviewController를 standalone 모드에서 테스트할 수 있도록 설정
		mockMvc = MockMvcBuilders.standaloneSetup(new ReviewController(reviewService)).build();
	}
	
	//리뷰 리스트 불러오기
	@Test
	public void testList() throws Exception {
		
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/review/list"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	
	//리뷰 등록
	@Test
	public void testRegister() throws Exception {
	    // ReviewVO 객체 생성
	    ReviewVO vo = new ReviewVO();
	    
	    // set 메서드를 통해 값 설정
	    vo.setPno(5L);
	    vo.setUno(5L);
	    vo.setR_content("레지스터 테스트!!");
	    vo.setR_img_path("");
	    vo.setR_img_name("");
	    vo.setR_img_o_name("");
	    
	    // 리뷰 등록 서비스 호출
	    reviewService.register(vo);
	    
	    // 생성된 게시물의 번호 출력
	    log.info("생성된 게시물의 번호 : " + vo.getPno());
	}
	
	//리뷰 수정
	@Test
	public void testModify() throws Exception {
		String resultPage = mockMvc
				.perform(MockMvcRequestBuilders.post("/review/modify")
				.param("rno", "24")
				.param("pno", "1")
				.param("uno", "1")
				.param("r_content", "modify 테스트!!"))
				.andReturn()
				.getModelAndView()
				.getViewName();
				log.info(resultPage);
	}
	
	//리뷰 삭제
	@Test
	public void testRemove() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/review/remove")
				.param("rno", "29"))
				.andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	
	@Test
	public void testGet() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders
				.get("/review/get")
				.param("rno", "30"))
				.andReturn()
				.getModelAndView().getModelMap());
		
	}
	
}
