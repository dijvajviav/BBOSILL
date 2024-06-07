package com.bbosil.notice.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class NoticeVO {
	
	private long no;
	private String title;
	private String content;
	// DB에서 JSP까지 데이터 가져오기를 할 때는 자동 변환이 되어서 문제가 발생되지 않는다. 
	// 사용자가 날짜를 입력할 때는 java의 Date 객체 형식에 맞춰줘야 한다. 
	// -> 사용자 날짜 패턴으로 변환하는 @DateTimeFormat 어노테이션을 사용하여 날짜 패턴을 지정할 수 있다. 
	// @DateTimeFormat(pattern = "yyyy-mm-dd")
	private String startDate;
	private String endDate;
	private String writeDate;
	private String updateDate;
	private long priority;
	
}