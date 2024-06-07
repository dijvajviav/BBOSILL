package com.bbosil.cart.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bbosil.cart.vo.CartVO;
import com.webjjang.util.page.PageObject;

public interface CartService {

	// 장바구니 리스트 처리
	public List<CartVO> list(@Param("id") String id, PageObject pageObject);

	// 물건을 장바구니에 담기 처리(옵션이 O)
	public int write(CartVO vo);
	
	// 물건을 장바구니에 담기 처리(옵션이 X)
	public int writenopotion(CartVO vo);

	// 장바구니 물건 삭제 처리
	public int delete(long cno);
	
	// 장바구니 물건 중복확인 처리(옵션이 O)
	public CartVO itemcheck(CartVO vo);
	
	// 장바구니 물건 중복확인 처리(옵션이 X)
	public CartVO itemchecknopotion(CartVO vo);
	
	// 중복된 장바구니의 물건에 수량 추가 처리(옵션이 O)
	public int update(CartVO vo);
	
	// 중복된 장바구니의 물건에 수량 추가 처리(옵션이 X)
	public int updatenopotion(CartVO vo);
	
	// 장바구니 물건의 수량  수정 처리
	public int updateItemCount(@Param("cno") long cno, @Param("count") int count);


	




}
