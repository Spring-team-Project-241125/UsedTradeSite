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
	public void testRegister() {
	    // ReviewVO 객체 생성
	    ReviewVO vo = new ReviewVO();
	    
	    // set 메서드를 통해 값 설정
	    vo.setPno(4L);
	    vo.setUno(4L);
	    vo.setR_content("안녕하세요");
	    vo.setR_img_path("");
	    vo.setR_img_name("");
	    vo.setR_img_o_name("");
	    
	    // 리뷰 등록 서비스 호출
	    reviewService.register(vo);
	    
	    // 등록된 리뷰의 Rno 값 확인
	    log.info(vo.getRno());
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
	    // ReviewVO 객체 생성
	    ReviewVO vo = new ReviewVO();
	    
	    // set 메서드를 통해 값 설정
	    vo.setRno(60L);
	    vo.setPno(1L);
	    vo.setUno(1L);
	    vo.setR_content("내용을 수정합니다");
	    vo.setR_img_path("");
	    vo.setR_img_name("");
	    vo.setR_img_o_name("");
	    
	    // 리뷰 수정 서비스 호출
	    int result = reviewService.modify(vo);
	    
	    // 수정된 리뷰 처리 확인
	    log.info("Modify result: " + result);
	}
	
	
	
	
	
	
	
}
