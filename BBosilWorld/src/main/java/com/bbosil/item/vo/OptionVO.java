package com.bbosil.item.vo;

import lombok.Data;

@Data
public class OptionVO {

	private String optionType;
	private String optionValue;
	private long itemNo;
	private long optionValueNo;
	
	//optionType테이블의 키 번호다.
	private long optionNo;
	
}
