package com.mbc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mbc.domain.Criteria;
import com.mbc.domain.ReviewVO;

public interface ReviewMapper {
	
	// 등록 작업
	public int insert(ReviewVO vo);
	
	// 조회
	public ReviewVO read(Long rno);
	
	// 삭제
	public int delete(Long rno);
	
	//수정
	public int update (ReviewVO review);
	
	public List<ReviewVO> getList(Long uno);
	
	//페이징 처리
	public List<ReviewVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("uno") Long uno
			);
	
	public int getCountByUno(Long uno);

}
