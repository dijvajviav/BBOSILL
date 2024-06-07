package com.bbosil.orders.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bbosil.orders.vo.OrderDetailVO;
import com.bbosil.orders.vo.OrdersVO;
import com.webjjang.util.page.PageObject;

@Repository
public interface OrdersMapper {

	List<OrdersVO> list(@Param("pageObject") PageObject pageObject, @Param("id") String id);

	List<OrderDetailVO> detailList(@Param("pageObject") PageObject pageObject, @Param("ono") Long ono);

	// 페이지 처리를 위한 총 행의 갯수 가져오는 메서드
	long getTotalRow(PageObject pageObject);

	// 주문 번호에 해당하는 주문 정보를 가져오는 메서드
	List<OrdersVO> view(@Param("ono") Long ono);

	// 주문 정보를 DB에 등록하는 메서드
	int write(OrdersVO vo);

	// 주문 상세 정보를 DB에 등록하는 메서드
	int detailWrite(OrderDetailVO vo);

	// 주문 정보를 업데이트하는 메서드
	int update(OrdersVO vo);

	// 주문이 완료된 아이템을 카트에서 삭제하는 메서드
	void delete(@Param("id") String id);
}
