package com.mbc.domain;

import lombok.Data;

@Data
public class attachVO {

	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	
	private Long uno;
	private Long pno;
	private Long rno;
}
