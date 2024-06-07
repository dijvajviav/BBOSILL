package com.bbosil.orders.vo;

import java.sql.Date;
import java.util.List;
import lombok.Data;

@Data
public class OrdersVO {
	private Long ono; // 주문번호
	private String id; // 회원 ID
	private String cartNo; // 장바구니 번호
	private String name; // 수령인
	private String tel; // 수령인 연락처
	private Date oDate; // 주문일자
	private Long deliveryCost; // 배송비
	private int payment; // 결제수단
	private int postalCode; // 우편번호
	private String address; // 배송 주소
	private String detAddress; // 상세 배송 주소
	private int status; // 주문 상태
	private String request; // 요청사항
	private String reason; // 환불사유
	private long oPrice; // 주문 가격
	private List<OrderDetailVO> details; // 상세 주문 정보 목록
}
