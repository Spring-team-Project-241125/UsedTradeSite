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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.mbc.domain.ProductVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@Log4j
@WebAppConfiguration
public class ProductControllerTests {

	@Autowired
	private WebApplicationContext ctx;

	private MockMvc mockMvc;

	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}

	@Test
	public void testList() throws Exception {

		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/product/list")).andReturn().getModelAndView().getModelMap());
	}
	
	@Test
	public void testListPaging() throws Exception {
		
		log.info(mockMvc.perform(
				MockMvcRequestBuilders.get("/product/list")
				.param("pagenum", "2")
				.param("amount", "50"))
				.andReturn().getModelAndView().getModelMap());
	}

	@Test
	public void testRegister() throws Exception {

	    String resultPage = mockMvc
	            .perform(MockMvcRequestBuilders.post("/product/register")
	            		.param("uno", "1")  // 사용자 ID 예시 (uno가 1인 사용자)
	            		.param("cate_no", "1")
	                    .param("p_title", "아이폰 15 Pro")  // 스마트폰 제목으로 변경
	                    .param("p_content", "최신 5G 지원 아이폰 15 Pro, 뛰어난 카메라 성능과 고속 성능 제공")  // 스마트폰 내용으로 변경
	                    .param("p_price", "1500000")  // 가격 예시 (아이폰 15 Pro 가격)
	                    .param("p_quantity", "30")  // 수량 예시
	            )
	            .andReturn().getModelAndView().getViewName();

	    log.info(resultPage);
	}

	@Test
	public void testGet() throws Exception {

		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/product/get").param("pno", "2")).andReturn()
				.getModelAndView().getModelMap());
	}

	@Test
	public void testRemove() throws Exception {

		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/product/remove").param("pno", "10")).andReturn()
				.getModelAndView().getViewName();

		log.info(resultPage);
	}

	@Test
	public void testModify() throws Exception {

		String resultPage = mockMvc
				.perform(MockMvcRequestBuilders.post("/product/modify").param("pno", "1").param("title", "수정된 테스트 새글 제목")
						.param("content", "수정된 테스트 새글 내용").param("writer", "user00"))
				.andReturn().getModelAndView().getViewName();

		log.info(resultPage);

	}

}
