package com.mbc.domain;



import java.sql.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;


@Data
@Getter
@Setter
public class ReviewVO {
	private Long rno;
	private Long pno;
	private Long uno;
	
	private String r_content;

	
	private Date r_regdate;
	private Date r_updatedate;
	
	
	private String p_title;   // 상품명
	private String sellerId;  // 작성자 ID (판매자 ID)
	private String buyerId; // 구매자 ID
	
	private List<AttachVO> attachList;
	
}
