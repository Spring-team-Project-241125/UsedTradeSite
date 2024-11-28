package com.mbc.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	
	private int pagenum;
	private int amount;
	
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1,10);
	}

	public Criteria(int pagenum, int amount) {
		this.pagenum = pagenum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		
		return type == null? new String[] {}: type.split("");
	}
   
   private int pagenum;
   private int amount;
   
   private String type;
   private String keyword;
   
   public Criteria() {
      this(1,10);
   }

   public Criteria(int pagenum, int amount) {
      this.pagenum = pagenum;
      this.amount = amount;
   }
   
   public String[] getTypeArr() {
      
      return type == null? new String[] {}: type.split("");
   }
}
