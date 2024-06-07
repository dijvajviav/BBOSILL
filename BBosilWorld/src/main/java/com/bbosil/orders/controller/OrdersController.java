package com.bbosil.orders.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bbosil.cart.service.CartService;
import com.bbosil.cart.vo.CartVO;
import com.bbosil.item.vo.ItemVO;
import com.bbosil.member.vo.LoginVO;
import com.bbosil.orders.service.OrdersService;
import com.bbosil.orders.vo.OrderDetailVO;
import com.bbosil.orders.vo.OrdersVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/orders")
@Log4j
public class OrdersController {

	@Autowired
	private OrdersService service;

	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;

	String path = "/resources/upload/items";

	/*
	
	@GetMapping("/list.do")
	public String list(Model model, HttpSession session, HttpServletRequest request) throws Exception {
		log.info("주문 리스트 실행");
		// 세션에서 로그인 정보를 가져옴
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		if (loginVO == null || loginVO.getId() == null) {
			// 로그인 정보가 없으면 로그인 페이지로 리다이렉트
			return "redirect:/login"; // 로그인 페이지 주소로 변경
		}
		String id = loginVO.getId();
		PageObject pageObject = PageObject.getInstance(request);
		List<OrdersVO> ordersList = service.list(pageObject, id);
		model.addAttribute("list", ordersList);
		model.addAttribute("pageObject", pageObject);
		return "orders/list";
	}

	@GetMapping("/view.do")
	public String view(Model model, long ono) {
		log.info("주문 상세 정보 조회");
		List<OrdersVO> result = service.view(ono);
		model.addAttribute("list", result);
		return "orders/view";
	}
	
	
	@PostMapping("/update.do")
	public String update(OrdersVO vo, Long ono) {
		service.update(vo);
		return "redirect:view.do?ono=" + ono;
	}
	
	*/

	@GetMapping("/writeForm.do")
	public String writeForm(Model model, HttpSession session, PageObject pageObject) {

		// 세션에서 로그인 정보를 가져옴
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		if (loginVO == null || loginVO.getId() == null) {
			// 로그인 정보가 없으면 로그인 페이지로 리다이렉트
			return "redirect:/member/login.do"; // 로그인 페이지 주소로 변경
		}
		String id = loginVO.getId();
		model.addAttribute("list", cartService.list(id, pageObject));
		log.info("Orders writeForm");

		return "orders/writeform";
	}

	@PostMapping("/write.do")
	@Transactional
	public String write(OrdersVO vo, OrderDetailVO detailVO, PageObject pageObject, HttpSession session) {
		// 세션에서 로그인 정보를 가져와서 주문자 아이디로 설정
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		if (loginVO == null || loginVO.getId() == null) {
			// 로그인 정보가 없으면 로그인 페이지로 리다이렉트
			return "redirect:/login"; // 로그인 페이지 주소로 변경
		}
		vo.setId(loginVO.getId());
		try {
			service.write(vo, detailVO);
			return "redirect:list.do"; // 주문 리스트 페이지로 리다이렉트
		} catch (Exception e) {
			// 예외 발생 시 롤백 처리
			log.error("주문 등록 중 오류가 발생했습니다.", e);
			return "error-page";
		}
	}


}
