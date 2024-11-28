package com.mbc.service;

import static org.junit.Assert.*;

import java.util.List;

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
public class ReviewServiceTests {

	@Autowired
	private ReviewService reviewService;
	
	//리뷰추가
	@Test
	public void testInsert() {
		ReviewVO vo = ReviewVO.builder()
				.pno(4L)
				.uno(4L)
				.r_content("안녕하세요")
				.r_img_path("")
				.r_img_name("")
				.r_img_o_name("")
				.build();
				
				log.info(reviewService.register(vo));
	}
	
	//리뷰삭제
	@Test
	public void testDelete() {
		Long pno = 5L;
		reviewService.remove(pno);
	}
	
	//리뷰수정
	@Test
	public void testModify() {
		ReviewVO vo = ReviewVO.builder()
				.rno(24L)
				.pno(1L)
				.uno(1L)
				.r_content("내용을 수정합니다")
				.r_img_path("")
				.r_img_name("")
				.r_img_o_name("")
				.build();
		
		//리뷰 수정
		int result = reviewService.modify(vo);
		
		//리뷰 처리 확인
		log.info("Modify result: " + result);
		
	}
	
	//리뷰 목록 조회
	@Test
	public void testGetList() {
		Criteria cri = new Criteria();
		cri.setPagenum(1);
		cri.setAmount(10);
		Long uno = 1L;
		
		List<ReviewVO> reviewList = reviewService.getList(cri, uno);
		
		for (ReviewVO review : reviewList) {
            log.info(review);
        }
	}
	
	
	
	
	
}
