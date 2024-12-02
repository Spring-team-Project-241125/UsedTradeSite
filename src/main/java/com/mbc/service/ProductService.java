package com.mbc.service;

import java.util.List;

import com.mbc.domain.ProductVO;
import com.mbc.domain.Criteria;

public interface ProductService {
	
	public void register(ProductVO product);
	
	public ProductVO get(Long pno);
	
	public int modify(ProductVO product);
	
	public int remove(Long pno);
	
	public List<ProductVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	//public ProductVO getProductDetail(Long pno);
	
	public List<ProductVO> getProductsByUno(Long uno); // 판매자 ID를 기준으로 Product 조회


}
