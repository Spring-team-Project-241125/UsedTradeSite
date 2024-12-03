package com.mbc.service;

import static org.junit.Assert.assertNotNull;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.mbc.domain.ProductVO;
import com.mbc.domain.AttachVO;
import com.mbc.domain.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ProductServiceTests {
	
	@Autowired
	private ProductService service;
	
	@Test
	public void testRegister() {
	    
	    // 상품 정보 설정
	    ProductVO product = new ProductVO();
	    product.setUno(2L);  // 예시로 값을 설정
	    product.setCate_no(2L);  // 카테고리 번호도 예시로 설정
	    product.setP_title("수학의 정석");
	    product.setP_content("수학책");
	    product.setP_price(10000L);  // 예시 가격
	    product.setP_quantity(100L);  // 예시 수량
	    
	    // 첨부파일 정보 설정 (attachVO 객체 생성)
	    List<AttachVO> attachList = new ArrayList<>();
	    
	    AttachVO attach1 = new AttachVO();
	    attach1.setUuid("uuid1");
	    attach1.setUploadPath("/upload");
	    attach1.setFileName("file1.jpg");
	    attach1.setFileType(true);  // fileType 예시 (이미지로 설정)
	    attach1.setPno(product.getPno());  // 실제 product.getPno()에 맞게 설정
	    
	    AttachVO attach2 = new AttachVO();
	    attach2.setUuid("uuid2");
	    attach2.setUploadPath("/upload");
	    attach2.setFileName("file2.jpg");
	    attach2.setFileType(true);  // fileType 예시 (이미지로 설정)
	    attach2.setPno(product.getPno());  // 실제 product.getPno()에 맞게 설정
	    
	    attachList.add(attach1);
	    attachList.add(attach2);
	    
	    product.setP_image(attachList);  // 상품에 첨부파일 리스트 설정
	    
	    // 상품 등록
	    service.register(product);
	    
	    // 상품 번호가 제대로 생성되었는지 확인
	    log.info("생성된 게시물의 번호: " + product.getPno());  // pno는 DB에서 자동 생성되므로 여기에 값을 설정할 필요는 없습니다.
	    
	    // 추가적인 검증을 위해 DB에서 실제로 데이터가 저장되었는지 확인하는 로직을 추가할 수 있습니다.
	}
	
	@Test
	public void insertDummyProducts() {
        for (int i = 0; i < 100; i++) {
            ProductVO product = new ProductVO();
            product.setUno((long) (i % 5 + 1));  // uno 값은 1부터 5 사이
            product.setCate_no((long) (i % 5 + 1));  // cate_no 값은 1부터 5 사이
            product.setP_title("Product " + (i + 1));
            product.setP_content("This is content for product " + (i + 1));
            product.setP_price((long)1000 + (i % 10) * 100);
            product.setP_quantity((long)50 + (i % 10) * 10);

    //        service.register(product);  // 매퍼를 통해 데이터 삽입
        }
    }
	
	@Test
	public void testGetList() {
		 
		//service.getList().forEach(Product -> log.info(Product));
		service.getList(new Criteria(2,10)).forEach(Product -> log.info(Product));
	}
	
	@Test
	public void testGet() {
		log.info(service.get(5L));
	}
	
	@Test
	public void testDelete() {
		log.info(service.remove(8L));
	}
	
	@Test
	public void testModify() {
	    // 수정할 제품 객체를 DB에서 조회
	    ProductVO product = service.get(5L);
	    
	    // 수정할 값 설정
	    product.setP_title("수정된 제목");
	    product.setP_content("수정된 내용");
	    product.setUno(1L);  // 예시로 uno 값을 설정 (실제 유저의 uno 값으로 수정 필요)
	    product.setCate_no(1L);  // 카테고리 번호도 예시로 설정
	    product.setP_price(15000L);  // 예시 가격 수정
	    product.setP_quantity(50L);  // 예시 수량 수정
	    
	    // 수정된 내용을 로그로 출력
	    log.info(service.modify(product));
	}
	
	

}
