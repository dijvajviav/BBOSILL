package com.bbosil.cart.vo;

import lombok.Data;

@Data
public class CartVO {
	
	private long cno; // 장바구니 번호
	private String id; // 아이디(중복불가)
	private long itemNo; // 상품번호
	private String itemName; // 상품이름
	private String itemImage; // 상품 이미지
	private int itemPrice; // 상품 가격
	private int discount; // 할인가
	private int rate; // 할인률
	private int count; // 상품 수량
	private String optionnames; // 옵션 이름의 집합
	
	// 실판매가 : stdPrice - discount / stdPrice - (stdPrice * rate / 100)
	// 판매가를 계산해서 넘겨누는 메서드
	public int getPrice() {
		if(discount > 0) return itemPrice - discount;
		if(rate > 0) return itemPrice - (itemPrice * rate / 100);
		return itemPrice;
	}
}
