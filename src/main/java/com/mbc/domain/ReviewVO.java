package com.mbc.domain;



import java.sql.Date;

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
	private String r_img_path;
	private String r_img_name;
	private String r_img_o_name;
	
	private Date r_regdate;
	private Date r_updatedate;
	
	
	private String p_title;   // 상품명
	private String sellerId;  // 작성자 ID (판매자 ID)
	private String buyerId; // 구매자 ID
}
