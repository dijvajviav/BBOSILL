package com.bbosil.cart.service;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bbosil.cart.mapper.CartMapper;
import com.bbosil.cart.vo.CartVO;

import com.webjjang.util.page.PageObject;

@Service // 자동 생성
@Qualifier("cartServiceImpl") // 자동 DI 할때 타입이 같은 것이 나오면 구분하기 위한 문자열.
public class CartServiceImpl implements CartService{

	@Inject // 자동 DI
	private CartMapper mapper;

	@Override // 장바구니 리스트 처리
	public List<CartVO> list(@Param("id") String id, PageObject pageObject) {
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(id, pageObject);
	}

	@Override // 물건을 장바구니에 담기 처리(옵션이 O)
	public int write(CartVO vo) {
		return mapper.write(vo);
	}
	

	@Override // 물건을 장바구니에 담기 처리(옵션이 X)
	public int writenopotion(CartVO vo) {
		return mapper.writenopotion(vo);
	}
	

	@Override // 장바구니의 물건 삭제 처리
	public int delete(long cno) {
		return mapper.delete(cno);
	}

	@Override // 장바구니 물건 중복확인 처리(옵션이 O)
	public CartVO itemcheck(CartVO vo) {
		return mapper.itemcheck(vo);
	}
	

	@Override // 장바구니 물건 중복확인 처리(옵션이 X)
	public CartVO itemchecknopotion(CartVO vo) {
		return mapper.itemchecknopotion(vo);
	}

	@Override // 중복된 장바구니의 물건에 수량 추가 처리(옵션이 O)
	public int update(CartVO vo) {
		return mapper.update(vo);
	}
	

	@Override // 중복된 장바구니의 물건에 수량 추가 처리(옵션이 X)
	public int updatenopotion(CartVO vo) {
		return mapper.updatenopotion(vo);
	}

	@Override // 장바구니 물건의 수량  수정 처리
	public int updateItemCount(@Param("cno") long cno, @Param("count") int count) {
		return mapper.updateItemCount(cno, count);
	}




	
}
