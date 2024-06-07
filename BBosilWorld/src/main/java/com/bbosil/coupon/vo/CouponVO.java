package com.bbosil.coupon.vo;

import lombok.Data;

@Data
public class CouponVO {
	
	private long couponno; // 쿠폰 번호
	private String id; // 아이디(중복불가)
	private String couponname; // 쿠폰 이름
	private int discountvalue; // 쿠폰 가격
	private int usagelimit; // 쿠폰 개수(사용 제한 횟수)
}
