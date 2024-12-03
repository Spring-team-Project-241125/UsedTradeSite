package com.mbc.service;

import java.util.List;

import com.mbc.domain.Criteria;
import com.mbc.domain.ReviewPageDTO;
import com.mbc.domain.ReviewVO;

public interface ReviewService {
	
	public void register(ReviewVO vo);
	
	public ReviewVO get(Long rno);
	
	public int modify(ReviewVO vo);
	
	public int remove(Long rno);
	

	
	public List<ReviewVO> getReviewListWithProductAndbuyerIdAndsellerId(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public List<ReviewVO> getReviewListByUno(Long uno);
}