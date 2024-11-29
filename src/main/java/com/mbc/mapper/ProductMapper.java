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
	
	public ProductVO getProductWithSellerId(Long pno); // 판매자 ID가 포함된 Product 조회
	
	public List<ProductVO> getProductsByUno(Long uno); // 판매자 ID를 기준으로 Product 조회
	
}
