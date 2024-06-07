package com.bbosil.item.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ItemVO {
	private long itemNo;
	private long categoryNo;
	private long hit;
	private String itemName;
	private String itemContent;
	private String itemImage;
	private String producer;
	private String categoryName;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writeDate;
	private int itemPrice;
	private int discount;
	private int rate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	
	private MultipartFile imageFile; 
	//파일을 서버에 등록할 때 사용할  MultipartFile 객체.
	
	
	public int getPrice() {
		
		if(discount > 0) {
			int salePrice = itemPrice - discount;
			return salePrice;
		}
		
		if(rate > 0) {
			int salePrice = itemPrice - (rate * itemPrice/100);
			return salePrice;
		}
		
		
		
		return itemPrice;
	}
}
