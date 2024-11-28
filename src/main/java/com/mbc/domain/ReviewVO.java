package com.mbc.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
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
}
