package com.mbc.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class UserVO {
	
	private Long uno;
	private String id;
	private String pwd;
	private String phone;
	private String u_img_path;
	private String u_img_name;
	private String u_img_o_name;
	private Date u_regdate;
	
	private List<attachVO> attachList;
	
}
