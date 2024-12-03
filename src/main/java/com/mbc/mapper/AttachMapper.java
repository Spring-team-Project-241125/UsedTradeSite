package com.mbc.mapper;

import java.util.List;

import com.mbc.domain.AttachVO;

public interface AttachMapper {

	public List<AttachVO> findByUno(Long uno);
	
	public List<AttachVO> findByPno(Long pno);
	
	public List<AttachVO> findByRno(Long rno);
	
	public void insertUno(AttachVO vo);
	
	public void insertPno(AttachVO vo);
	
	public void insertRno(AttachVO vo);
	
	public void delete(String uuid);
}
