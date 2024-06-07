package com.bbosil.coupon.service;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bbosil.coupon.mapper.CouponMapper;
import com.bbosil.coupon.vo.CouponVO;

import com.webjjang.util.page.PageObject;

@Service // 자동 생성
@Qualifier("couponServiceImpl") // 자동 DI 할때 타입이 같은 것이 나오면 구분하기 위한 문자열.
public class CouponServiceImpl implements CouponService{

	@Inject // 자동 DI
	private CouponMapper mapper;

	@Override // 본인 소유 쿠폰 리스트 처리
	public List<CouponVO> listMemCo(@Param("id") String id, PageObject pageObject) {
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.listMemCo(id, pageObject);
		
	}

	@Override // 물건을 장바구니에 담기 처리
	public int write(CouponVO vo) {
		return mapper.write(vo);
	}

	@Override // 장바구니의 물건 삭제 처리
	public int delete(long cno) {
		return mapper.delete(cno);
	}

	@Override // 장바구니 물건 중복확인 처리
	public CouponVO itemcheck(CouponVO vo) {
		return mapper.itemcheck(vo);
	}

	@Override // 중복된 장바구니의 물건에 수량 추가 처리
	public int update(CouponVO vo) {
		return mapper.update(vo);
	}

	@Override // 장바구니 물건의 수량  수정 처리
	public int updateItemCount(@Param("cno") long cno, @Param("count") int count) {
		return mapper.updateItemCount(cno, count);
	}
	
	

	
}
