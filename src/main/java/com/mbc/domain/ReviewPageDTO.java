package com.mbc.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ReviewPageDTO {
	
	private int reviewcnt;
	
	private List<ReviewVO> list;
}
