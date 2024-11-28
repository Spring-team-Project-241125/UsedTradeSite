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
	
	
	@Transactional
	@Override
	public int register(ReviewVO vo) {
		
		log.info("register....." + vo);
		
		return mapper.insert(vo);
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
	public List<ReviewVO> getList(Criteria cri, Long uno) {

		log.info("get Reply List of a Board " + cri + " , " + uno);
		
		return mapper.getListWithPaging(cri, uno);
	}

	@Override
	public ReviewPageDTO getListPage(Criteria cri, Long uno) {

		return new ReviewPageDTO( 
				mapper.getCountByUno(uno),
				mapper.getListWithPaging(cri, uno)
				);
	}
	
	
}
