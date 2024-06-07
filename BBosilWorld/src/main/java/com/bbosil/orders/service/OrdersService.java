package com.bbosil.orders.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bbosil.orders.mapper.OrdersMapper;
import com.bbosil.orders.vo.OrderDetailVO;
import com.bbosil.orders.vo.OrdersVO;
import com.webjjang.util.page.PageObject;

@Service
public class OrdersService {

	@Inject
	private OrdersMapper mapper;

	// 주문 리스트 조회 서비스 메서드
	public List<OrdersVO> list(PageObject pageObject, String id) {
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		List<OrdersVO> orderList = mapper.list(pageObject, id);
		for (OrdersVO order : orderList) {
			order.setDetails(mapper.detailList(pageObject, order.getOno()));
		}
		return orderList;
	}

	// 주문 상세 정보 조회 서비스 메서드
	public List<OrdersVO> view(Long ono) {
		List<OrdersVO> orderList = mapper.view(ono);
		for (OrdersVO order : orderList) {
			order.setDetails(mapper.detailList(null, order.getOno()));
		}
		return orderList;
	}

	// 주문 등록 서비스 메서드
	public List<OrdersVO> writeForm(OrdersVO vo, PageObject pageObject, String id) {
		// 주문자 아이디 설정
		vo.setId(id);
		List<OrdersVO> orderList = mapper.list(pageObject, id);
		for (OrdersVO order : orderList) {
			order.setDetails(mapper.detailList(pageObject, order.getOno()));
		}
		return orderList;
	}

	// 주문정보 등록 서비스 메서드
	@Transactional
	public void write(OrdersVO vo, OrderDetailVO detailVO) {
		try {
			// 주문 정보 등록
			mapper.write(vo);
			// 등록된 주문 정보의 주문번호를 가져옵니다.
			Long ono = vo.getOno();
			// 상세 주문 정보에 주문번호 설정
			detailVO.setOno(ono);
			// 상세 주문 정보 등록
			mapper.detailWrite(detailVO);
			// 주문이 완료되면 카트에서 해당 아이템을 삭제합니다.
			mapper.delete(vo.getId());
		} catch (Exception e) {
			// 예외 발생 시 롤백 처리
			throw new RuntimeException("주문 등록 중 오류가 발생했습니다.", e);
		}
	}

	// 주문 정보 수정 서비스 메서드
	public int update(OrdersVO vo) {
		return mapper.update(vo);
	}
}
