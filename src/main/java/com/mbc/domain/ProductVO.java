package com.mbc.domain;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Setter
@Getter
public class ProductVO {
	
	private Long pno;
	private Long uno;
	private Long cate_no;
	private String p_title;
	private String p_content;
	private Long p_price;
	private Long p_quantity;
	private Date p_regdate;
	private Date p_updatedate;
	
	private String sellerId; // 판매자 ID 추가

	private List<attachVO> p_image;
	
}
