package com.mbc.mapper;

import static org.junit.Assert.*;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.mbc.domain.Criteria;
import com.mbc.domain.ReviewVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReviewMapperTests {
	
	
	private Long[] pnoArr = {1L, 2L, 3L, 4L, 5L};
	
	
	@Autowired
	private ReviewMapper mapper;
	
	
	@Test
	public void testCreate() {
		
		IntStream.rangeClosed(1, 5)
	    .forEach(i -> {
	        // ReviewVO 객체를 생성한 후 setter 메서드를 사용하여 값을 설정
	        ReviewVO vo = new ReviewVO();
	        
	        vo.setPno(pnoArr[i % 5]);  // pno 배열 값 설정
	        vo.setUno(pnoArr[i % 5]);  // uno 배열 값 설정
	        vo.setR_content("리뷰 테스트" + i);  // r_content 값 설정
	        vo.setR_img_path("");  // r_img_path 값 설정
	        vo.setR_img_name("");  // r_img_name 값 설정
	        vo.setR_img_o_name("");  // r_img_o_name 값 설정
						
						
				
				mapper.register(vo);
				
			});
	}
	
	
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}
	
	
	@Test
	public void testRead() {
		Long targetRno = 2L;
		 ReviewVO vo = mapper.read(targetRno);
		 
		 log.info(vo);
	}
	
	@Test
	public void testDelete() {
		Long targetRno = 10L;
		
		mapper.delete(targetRno);
	}
	
	
	@Test
	public void testUpdate() {
		ReviewVO vo = mapper.read(9L);
		
		vo.setR_content("수정된 내용");
		
		mapper.update(vo);
	}
	
	
	
	@Test
	public void testPaging() {
	    // Criteria 객체 생성 후 페이지 번호와 항목 수 설정
	    Criteria cri = new Criteria();
	    cri.setPagenum(1);  // 두 번째 페이지
	    cri.setAmount(10);  // 페이지당 10개 항목
	    
	    // Mapper에서 getListWithPaging 메서드 호출
	    List<ReviewVO> list = mapper.getReviewListWithProductAndbuyerIdAndsellerId(cri);

	    // 결과 출력
	    list.forEach(review -> log.info(review));  // 리뷰 번호 출력
	}
	
	@Test
	public void testSearch() {
		Criteria cri = new Criteria();
		cri.setKeyword("새로");
		cri.setType("TC");
		
		List<ReviewVO> list = mapper.getReviewListWithProductAndbuyerIdAndsellerId(cri);
		
		list.forEach(review -> log.info(review));
	}
}