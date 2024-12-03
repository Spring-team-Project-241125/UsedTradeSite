package com.mbc.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mbc.domain.Criteria;
import com.mbc.domain.ReviewPageDTO;
import com.mbc.domain.ReviewVO;
import com.mbc.mapper.ReviewMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class ReviewServiceImp implements ReviewService {
	
	private final ReviewMapper mapper;
	
	
	@Override
	public void register(ReviewVO vo) {
		
		log.info("register....." + vo);
		
		mapper.register(vo);
	}

	@Override
	public ReviewVO get(Long rno) {
		log.info("get......" + rno);
		
		return mapper.read(rno);
	}

	@Override
	public int modify(ReviewVO vo) {
		
		log.info("modify...." + vo);
		
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		
		log.info("remove..." + rno);
		
		return mapper.delete(rno);
	}
	
	
	
	@Override
    public List<ReviewVO> getReviewListWithProductAndbuyerIdAndsellerId(Criteria cri) {
        return mapper.getReviewListWithProductAndbuyerIdAndsellerId(cri);
    }

	@Override
	public List<ReviewVO> getReviewListByUno(Long uno) {
		return mapper.getReviewListByUno(uno);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		
		return mapper.getTotalCount(cri);
	}
	
}