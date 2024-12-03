package com.mbc.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class UserVO {
	
	private Long uno;
	private String id;
	private String pwd;
	private Date u_regdate;
	private String phone;
	
	private List<AttachVO> attachList;
	
}
