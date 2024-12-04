package com.mbc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mbc.domain.ProductVO;
import com.mbc.domain.AttachVO;
import com.mbc.domain.Criteria;
import com.mbc.mapper.ProductMapper;
import com.mbc.mapper.AttachMapper;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
// @AllArgsConstructor  // 모든 필드를 초기화
@RequiredArgsConstructor // 필수 필드만 초기화
//final 필드나 @NonNull이 붙은 필드만 포함하는 생성자를 생성
public class ProductServiceImpl implements ProductService{
	
	@Autowired
	private final ProductMapper mapper;
	
	@Autowired
	private AttachMapper attachmapper;

	
	
//	 public ProductVO getProductDetail(Long pno) {
//	        // 제품 정보 조회
//	        ProductVO product = productMapper.getProductById(pno);
//
//	        // 제품의 uno 값을 통해 판매자 정보 조회
//	        Long uno = product.getUno();
//	        String sellerId = userMapper.getUserIdByUno(uno); // uno로 id를 조회
//
//	        product.setSellerId(sellerId); // ProductVO에 판매자 id를 설정
//
//	        return product;
//	    }
	
	@Transactional
	@Override
	public void register(ProductVO product) {
		mapper.insertSelectKey(product); // 상품 정보 등록

		if(product.getAttachList() == null || product.getAttachList().size() <= 0) {
			return;
		}
		
		product.getAttachList().forEach(attach -> {
			attach.setPno(product.getPno());
			attachmapper.insertPno(attach);
		});
	}

	@Override
	public ProductVO get(Long pno) {
		
		log.info("get.......");
		
		return mapper.read(pno);
	}

	@Transactional
	@Override
	public int modify(ProductVO Product) {

		log.info("modify.......");
		
		attachmapper.deleteAllPno(Product.getPno());
		
		int modifyResult = mapper.update(Product);
		
		if(modifyResult == 1 && Product.getAttachList() != null &&
				Product.getAttachList().size() > 0) {
			
			Product.getAttachList().forEach(attach -> {
				attach.setPno(Product.getPno());
				attachmapper.insertPno(attach);
			});
		}
		
		return modifyResult;
	}

	@Transactional
	@Override
	public int remove(Long pno) {
		
		log.info("remove.......");
		
		attachmapper.deleteAllPno(pno);
		
		return mapper.delete(pno);
	}

	@Override
	public List<ProductVO> getList(Criteria cri) {
		
		log.info("get List with criteria: " + cri);
		
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
	
	 @Override
	    public ProductVO getProductWithSellerId(Long pno) {
	        // 제품 정보와 판매자 ID를 함께 조회
	        return mapper.getProductWithSellerId(pno);
	    }

	@Override
	public List<ProductVO> getProductsByUno(Long uno) {
		// uno 를 기준으로 제품 정보를 조회
		 return mapper.getProductsByUno(uno);
	}
	
	@Override
	public List<AttachVO> getAttachList(Long pno) {
		log.info("pno : " + pno);
		
		return attachmapper.findByPno(pno);
	}

}
