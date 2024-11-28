package com.mbc.mapper;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.asyncDispatch;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
public class ProductMapperTests {
	
	@Autowired
	private ProductMapper mapper;
	
	@Test
	public void testPaging() {
		
	    Criteria cri = new Criteria();
	    cri.setPagenum(1);
	    cri.setAmount(10);
	    
	    List<ProductVO> list = mapper.getListWithPaging(cri);
	    
        list.forEach(Product -> log.info(Product));
	}
	
	@Test
	public void testInsert() {
	    // ProductVO 객체 생성 및 필드 값 설정
	    ProductVO product = new ProductVO();
	    product.setPno(6L); // 상품 ID
	    product.setUno(5L); // 판매자 ID
	    product.setCate_no(1L); // 카테고리 ID
	    product.setP_title("스마트폰"); // 상품 제목
	    product.setP_content("최고의 스마트폰, 5G 지원"); // 상품 설명
	    product.setP_price(1000000L); // 상품 가격
	    product.setP_quantity(50L); // 상품 수량
	    
	    log.info(product);
	    
	    // 매퍼를 사용해 데이터 삽입
	    mapper.insert(product);

	    // 로그 출력
	    log.info("삽입된 상품 정보: " + product);
	}
	
	@Test
	public void testInsertSelectKey() {
		// ProductVO 객체 생성 및 필드 값 설정
	    ProductVO product = new ProductVO();
	    product.setPno(6L); // 상품 ID
	    product.setUno(5L); // 판매자 ID
	    product.setCate_no(1L); // 카테고리 ID
	    product.setP_title("스마트폰"); // 상품 제목
	    product.setP_content("최고의 스마트폰, 5G 지원"); // 상품 설명
	    product.setP_price(1000000L); // 상품 가격
	    product.setP_quantity(50L); // 상품 수량
		
		mapper.insertSelectKey(product);
		
		log.info(product);
	}
	
	@Test
	public void testRead() {
		Long pno = 5L;
		
		ProductVO Product = mapper.read(pno);
		log.info(Product);
	}
	
	@Test
	public void testDelete() {
		int result = mapper.delete(6L);
		
		log.info("result: " + result);
	}
	
	@Test
	public void testUpdate() {
	    Long pno = 5L; // 수정할 상품 번호

	    // 기존 데이터를 읽어오기
	    ProductVO product = mapper.read(pno);
	    if (product == null) {
	        log.warn("해당 상품을 찾을 수 없습니다. pno: " + pno);
	        return;
	    }

	    // 수정할 내용 설정
	    product.setP_title("수정된 스마트폰 제목");
	    product.setP_content("업데이트된 스마트폰 설명");
	    product.setP_price(1200000L); // 가격 변경
	    product.setP_quantity(30L); // 수량 변경
	    product.setCate_no(2L); // 카테고리 변경

	    // 데이터 업데이트
	    int result = mapper.update(product);

	    // 결과 확인
	    if (result > 0) {
	        log.info("업데이트 성공! 수정된 상품 정보: " + product);
	    } else {
	        log.warn("업데이트 실패. pno: " + pno);
	    }
	}
	
	@Test
	public void testSearch() { // 검색어 및 검색필드 적용후의 페이징처리 테스트
		
		Criteria cri = new Criteria();
		cri.setKeyword("스마트폰");
		cri.setType("TC");
		
		List<ProductVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(Product -> log.info(Product));
	}
	
	@Test
	public void testGetTotalCount() {
		Criteria cri = new Criteria();
		
		cri.setKeyword("스마트폰");
		cri.setType("C");
		int totalCount = mapper.getTotalCount(cri);
		log.info("totalCount: " + totalCount);
	}

}
