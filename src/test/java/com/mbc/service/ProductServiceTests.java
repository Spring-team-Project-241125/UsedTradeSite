package com.mbc.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.mbc.domain.ProductVO;
import com.mbc.domain.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ProductServiceTests {
	
	@Autowired
	private ProductService service;
	
	@Test
	public void testRegister() {
	    
	    ProductVO product = new ProductVO();
	    
	    product.setUno(2L);  // 예시로 값을 설정 (실제로는 사용자의 'uno' 값에 맞게 설정해야 합니다)
	    product.setCate_no(2L);  // 카테고리 번호도 예시로 설정
	    product.setP_title("수학의 정석");
	    product.setP_content("수학책");
	    product.setP_price(10000L);  // 예시 가격
	    product.setP_quantity(100L);  // 예시 수량
	    
	    service.register(product);
	    
	    log.info("생성된 게시물의 번호: " + product.getPno());  // pno는 DB에서 자동 생성되므로 여기에 값을 설정할 필요는 없습니다.
	}
	
	@Test
	public void testGetList() {
		 
		//service.getList().forEach(Product -> log.info(Product));
		service.getList(new Criteria(2,10)).forEach(Product -> log.info(Product));
	}
	
	@Test
	public void testGet() {
		log.info(service.get(5L));
	}
	
	@Test
	public void testDelete() {
		log.info(service.remove(8L));
	}
	
	@Test
	public void testModify() {
	    // 수정할 제품 객체를 DB에서 조회
	    ProductVO product = service.get(5L);
	    
	    // 수정할 값 설정
	    product.setP_title("수정된 제목");
	    product.setP_content("수정된 내용");
	    product.setUno(1L);  // 예시로 uno 값을 설정 (실제 유저의 uno 값으로 수정 필요)
	    product.setCate_no(1L);  // 카테고리 번호도 예시로 설정
	    product.setP_price(15000L);  // 예시 가격 수정
	    product.setP_quantity(50L);  // 예시 수량 수정
	    
	    // 수정된 내용을 로그로 출력
	    log.info(service.modify(product));
	}
	
	

}
