package com.bbosil.coupon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bbosil.coupon.vo.CouponVO;
import com.bbosil.member.vo.LoginVO;
import com.bbosil.member.vo.MemberVO;
import com.webjjang.util.page.PageObject;

@Repository
public interface CouponMapper {

	// 장바구니 리스트를 출력하기 위해 필요한 상품 전체의 수를 구하는 처리
	public long getTotalRow(PageObject pageObject);

	// 본인 소유 쿠폰 리스트 처리
	public List<CouponVO> listMemCo(@Param("id") String id, PageObject pageObject);

	// 장바구니에 물건 담기 처리
	public int write(CouponVO vo);

	// 장바구니 물건 삭제 처리
	public int delete(long cno);

	// 장바구니 물건 중복확인 처리
	public CouponVO itemcheck(CouponVO vo);
	
	// 중복된 장바구니의 물건에 수량 추가 처리
	public int update(CouponVO vo);
	
	// 장바구니 물건의 수량  수정 처리
	public int updateItemCount(@Param("cno") long cno, @Param("count") int count);

}
