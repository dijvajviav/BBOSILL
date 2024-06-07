package com.bbosil.coupon.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bbosil.coupon.service.CouponService;
import com.bbosil.coupon.vo.CouponVO;
import com.bbosil.member.vo.LoginVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/coupon")
@Log4j
public class CouponController {

	@Autowired
	@Qualifier("couponServiceImpl") // 자동 DI 할때 타입이 같은 것이 나오면 구분하기 위한 문자열.
	private CouponService service;
	
	
	// 본인 소유의 쿠폰 리스트 (이건 내 정보에서 들어가게 할 거임)
	@RequestMapping("/listMemCo.do")
	public String listMemCo(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		log.info(" - 본인 소유 쿠폰 리스트 실행");
		System.out.println("--- 본인 소유 쿠폰 리스트 실행");
		
		// 현재 로그인 되어 있는 아이디 받기
		String id = ((LoginVO) (session.getAttribute("login"))).getId();
		
		// pageObject 만들기
		PageObject pageObject = PageObject.getInstance(request);
		
		// model에 데이터를 속성으로 추가하면 request에 담긴다. -> jsp까지 전달된다.
		model.addAttribute("listMemCo", service.listMemCo(id, pageObject));
		
		// list.jsp에서 페이지 처리에 필요하다.
		model.addAttribute("pageObject", pageObject);
		
		// /WEB-INF/views/ + member/list + .jsp - forwoard
		return "coupon/list";
	}
	
	
	// 장바구니 담기
	@PostMapping("/write.do")
	public String write(CouponVO vo, HttpSession session, RedirectAttributes rttr) {
		System.out.println("자 ! 장바구니에 담아볼까?");
		
		// 현재 로그인된 아이디를 가져와!
		String id = ((LoginVO) (session.getAttribute("login"))).getId();
		
		// 결과를 판단할 변수
		int result = 0;
		
		// 아마 여기는 그 뭐냐 장바구니 번호랑 아이디랑, 수량이 필요해
		vo.setId(id);
		
		// 선택한 물건이 이미 동일한 계정의 장바구니에 있는지 체크
		System.out.println("중복된 물건인지 체크하자!");
		CouponVO alreadyVO = service.itemcheck(vo); 
		System.out.println("중복된 물건인지 체크했어!!");
		if(alreadyVO != null) { // 장바구니에 동일한 물건이 이미 있다면
			// 기존의 물건에 수량만 더하기
			System.out.println("수량만 더하자!");
			result = service.update(vo);
			System.out.println("동일한 물건이 있습니다 . result = " + result);
		}else { // 장바구니에 동일한 물건이 없다면
			// 새로 추가하기
			System.out.println("아예 새로 추가하자!");
			result = service.write(vo);
			System.out.println("동일한 물건이 없습니다 . result = " + result);
		}
			System.out.println("다왔어! 마지막이야! 그래서 result가 얼마라고? result = " + result );
		if(result == 1) {
			System.out.println(" 장바구니에 추가되셨습니다.");
			rttr.addFlashAttribute("msg", "장바구니에 추가되었습니다.");
		}
		else {
			System.out.println(" 장바구니가 꽉 찼다. 좀 비워라");
			rttr.addFlashAttribute("msg", "장바구니가 꽉 찼다 좀 비워라");
		}
		
		// 장바구니에 물건을 담은 후 장바구니 리스트로 이동
		return "redirect:/coupon/list.do";
	}
	
	////////////////////////////////////////////////////////////////////////
	// AJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAX
	
	// 장바구니 항목 삭제
	@PostMapping("/delete")
	@ResponseBody // 이 어노테이션은 응답을 View로 사용하지 않고 HTTP 응답 본문에 직접 쓰도록 합니다.
	public String delete(long cno, HttpSession session) {
	    // String id = ((LoginVO) (session.getAttribute("login"))).getId();
	    try {
	        // 서비스를 호출하여 삭제 처리
	        int result = service.delete(cno);
	        System.out.println("장바구니의 물건을 삭제해버릴거야~~~~~~");
	        
	        // 1이 반환되어 돌아오면 succes라는 문자열을 반환한다
	        if(result ==1) return "success";
	        else { // 1이 아닌 다른 수가 반환되어 돌아오면 fail라는 문자열을 반환한다
	        	return "fail";
	        }
	    } catch(Exception e) {
	        log.error("장바구니 삭제 오류", e);
	        return "fail";
	    }
	}

	// 본인 소유의 쿠폰 리스트
	@PostMapping("/getUserCoupons")
	@ResponseBody
	public Map<String, Object> getUserCoupons(HttpSession session, HttpServletRequest request) throws Exception {
	    Map<String, Object> resultMap = new HashMap<>();
	    
	    // 로그인된 사용자의 ID를 세션에서 가져옵니다.
	    String id = ((LoginVO) (session.getAttribute("login"))).getId();
	    
	    // pageObject 만들기
	 	PageObject pageObject = PageObject.getInstance(request);
	    
	    try {
	        // 사용자가 소유한 쿠폰 목록을 서비스를 통해 가져옵니다.
	        List<CouponVO> coupons = service.listMemCo(id, pageObject);
	        
	        resultMap.put("status", "success");
	        resultMap.put("coupons", coupons);
	    } catch (Exception e) {
	        log.error("쿠폰 목록 조회 실패", e);
	        resultMap.put("status", "fail");
	    }
	    
	    return resultMap;
	}

}

