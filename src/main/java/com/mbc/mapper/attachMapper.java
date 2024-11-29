package com.mbc.mapper;

import java.util.List;

import com.mbc.domain.attachVO;

public interface attachMapper {

	public List<attachVO> findByUno(Long uno);
	
	public List<attachVO> findByPno(Long pno);
	
	public List<attachVO> findByRno(Long rno);
	
	public void insertUno(attachVO vo);
	
	public void insertPno(attachVO vo);
	
	public void insertRno(attachVO vo);
	
	public void delete(String uuid);
}
