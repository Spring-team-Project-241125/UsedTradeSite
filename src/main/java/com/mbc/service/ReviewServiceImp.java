package com.mbc.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mbc.domain.AttachVO;
import com.mbc.domain.Criteria;
import com.mbc.domain.ReviewPageDTO;
import com.mbc.domain.ReviewVO;
import com.mbc.mapper.AttachMapper;
import com.mbc.mapper.ReviewMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class ReviewServiceImp implements ReviewService {
	
	private final ReviewMapper mapper;
	
	private final AttachMapper attachMapper;
	
	@Transactional
	@Override
	public void register(ReviewVO vo) {
		
		log.info("register....." + vo);
		
		mapper.register(vo);
		
		if(vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
			return;
		}
		
		vo.getAttachList().forEach(attach -> {
			attach.setRno(vo.getRno());
			attachMapper.insertRno(attach);
		});
	}

	@Override
	public ReviewVO get(Long rno) {
		log.info("get......" + rno);
		
		return mapper.read(rno);
	}
	
	@Transactional
	@Override
	public int modify(ReviewVO vo) {
		log.info("modify...." + vo);
		
		attachMapper.deleteAllRno(vo.getRno());
		
		int modifyResult = mapper.update(vo);
		
		if(modifyResult == 1 && vo.getAttachList() != null &&
				vo.getAttachList().size() > 0) {
			
			vo.getAttachList().forEach(attach -> {
				attach.setRno(vo.getRno());
				attachMapper.insertRno(attach);
			});
		}
			return modifyResult;
		
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		
		log.info("remove..." + rno);
		
		attachMapper.deleteAllRno(rno);
		
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

	@Override
	public List<AttachVO> getAttachList(Long rno) {
		log.info("rno : " + rno);
		
		return attachMapper.findByRno(rno);
	}
	
}