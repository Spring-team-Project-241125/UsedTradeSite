package com.mbc.mapper;

import java.util.List;

import com.mbc.domain.ProductVO;
import com.mbc.domain.Criteria;

public interface ProductMapper {
	
	public List<ProductVO> getListWithPaging(Criteria cri);
	
	public void insert(ProductVO product);
	
	public void insertSelectKey(ProductVO product);
	
	public ProductVO read(Long pno);
	
	public int delete(Long pno);
	
	public int update(ProductVO product);
	
	public int getTotalCount(Criteria cri);
	
	public ProductVO getProductWithSellerId(Long pno); // 특정 상품 번호(pno)를 기준으로 상품 정보를 조회합니다.
	
	public List<ProductVO> getProductsByUno(Long uno); // 특정 사용자 번호(uno)를 기준으로 해당 사용자가 등록한 상품 목록을 조회
	
}
