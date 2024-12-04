package com.mbc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mbc.domain.Criteria;
import com.mbc.domain.ReviewVO;

public interface ReviewMapper {
	
	// 등록 작업
	public void register(ReviewVO vo);
	
	// 조회
	public ReviewVO read(Long rno);
	
	// 삭제
	public int delete(Long rno);
	
	//수정
	public int update (ReviewVO review);
//  유저id 와 상품 제목을 포함한 리뷰 목록을 조회하는 메소드
	public List<ReviewVO> getReviewListWithProductAndbuyerIdAndsellerId(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	
	public List<ReviewVO> getReviewListByUno(Long uno);
	
	
	public void delete(String uuid);
	



	
}
