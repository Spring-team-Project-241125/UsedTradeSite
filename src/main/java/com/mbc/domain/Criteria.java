package com.mbc.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	private int pagenum;  //페이지 번호
	private int amount;   // 화면당 레코드 갯수
	
	private String type;  //제목 or 내용 or 저자
	private String keyword; //검색어   
	
	public Criteria() {
		this(1, 12);
	}
	
	public Criteria(int pageNum, int amount) {
		this.amount = amount;
		this.pagenum = pageNum;
	}
	
	public String[] getTypeArr() {
		
		return type == null? new String[] {}: type.split("");
	}
   
}

