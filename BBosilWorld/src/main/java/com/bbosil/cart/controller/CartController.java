package com.bbosil.cart.controller;

import java.io.IOException;
import java.util.ArrayList;
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

import com.bbosil.cart.service.CartService;
import com.bbosil.cart.vo.CartVO;
import com.bbosil.item.service.OptionService;
import com.bbosil.item.vo.OptionVO;
import com.bbosil.member.vo.LoginVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/cart")
@Log4j
public class CartController {

	@Autowired
	@Qualifier("cartServiceImpl") // 자동 DI 할때 타입이 같은 것이 나오면 구분하기 위한 문자열.
	private CartService service;

	@Autowired
	@Qualifier("optionServiceImpl")
	private OptionService optionService;
	
	// 장바구니 리스트
	@RequestMapping("/list.do")
	public String list(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		log.info(" - 장바구니 리스트 실행");
		System.out.println("--- 장바구니 리스트 실행");
	
		// 현재 로그인 되어 있는 아이디 받기
		String id = ((LoginVO) (session.getAttribute("login"))).getId();
	
        // pageObject 만들기
		PageObject pageObject = PageObject.getInstance(request);

     	// model에 데이터를 속성으로 추가하면 request에 담긴다. -> jsp까지 전달된다.
		model.addAttribute("list", service.list(id, pageObject));
	
     	// list.jsp에서 페이지 처리에 필요하다.
		model.addAttribute("pageObject", pageObject);
		
		// /WEB-INF/views/ + member/list + .jsp - forwoard
		return "cart/list";

	}
	
	@PostMapping("/write.do")
	@ResponseBody // AJAX 요청에 대한 응답으로 JSON을 반환하도록 합니다.
	public Map<String, Object> write(CartVO vo, HttpSession session, long[] optionValueNo ) {
	    Map<String, Object> result = new HashMap<>();
	    String id = ((LoginVO) (session.getAttribute("login"))).getId();
	    vo.setId(id);
	    
	    int count = 0; // mapper의 결과를 받아오는 값 insert니까 int로 선언
	    
	    
	    // 옵션이 있다면 
	    if (optionValueNo != null) {
	    	String optionnames = ""; // 옵션들의 요소들의 이름
	    	// List<OptionVO> optionVO = new ArrayList<OptionVO>();
	    	
		    for(long ov : optionValueNo) {
				optionnames += "-"+ optionService.cartOption(ov).getOptionType() + "/" + optionService.cartOption(ov).getOptionValue() + "-";
			}
		    
		    vo.setOptionnames(optionnames); // 하나의 문자열로 만든 옵션들을 CartVO vo에 세팅해준다.
		    
		    CartVO alreadyVO = service.itemcheck(vo); // 중복된 물건이 있는지 확인
		    
		    
		    if(alreadyVO != null) { // 중복된 물건이 있으면
		    	 count = service.update(vo); // 수량만 업데이트
		    }else { // 중복된 물건이 없으면
		    	 count = service.write(vo); // 옵션이 포함된 vo를 write한다.
		    }
		    
	    } // if (optionValueNo != null)가 true인 부분
	    
	    else { // 옵션이 null 이면 (if (optionValueNo != null)가 false인 부분)
	    	
	    	 CartVO alreadyVO = service.itemchecknopotion(vo); // 중복된 물건이 있는지 확인
	    	
	    	if(alreadyVO != null) { // 중복된 물건이 있으면
	    		count = service.updatenopotion(vo); // 수량만 업데이트
		    }else { // 중복된 물건이 없으면
		    	count = service.writenopotion(vo); // 옵션이 포함되지 않은 vo를 write한다.
		    }
	    }
	    
	    
	    if (count == 1) { // 장바구니에 잘 입력 되었으면 
        result.put("status", "success");
        result.put("message", "장바구니에 추가되었습니다.");
        
    } else { // 장바구니에 잘 입력이 안되었으면 
        result.put("status", "fail");
        result.put("message", "장바구니 추가 실패.");
    } 
	    return result;
} // end of @PostMapping("/write.do")
	
	
	
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
	
	// 장바구니 물건 수량 수정
	@PostMapping("/updateQuantity")
	@ResponseBody // 이 어노테이션은 응답을 View로 사용하지 않고 HTTP 응답 본문에 직접 쓰도록 합니다.
	public String updateQuantity(CartVO vo, HttpSession session) {
	    // String id = ((LoginVO) (session.getAttribute("login"))).getId();
		long cno = vo.getCno(); 
		int count = vo.getCount();
		System.out.println("cno = " + cno);
		System.out.println("count = " + count);
	    try {
	        // 서비스를 호출하여 삭제 처리
	        int result = service.updateItemCount(cno, count);
	        System.out.println("물건의 수량을 변경해버릴 거야~~~~~~~");
	        
	        // 1이 반환되어 돌아오면 succes라는 문자열을 반환한다
	        if(result ==1) return "success";
	        else { // 1이 아닌 다른 수가 반환되어 돌아오면 fail라는 문자열을 반환한다
	        	return "fail";
	        }
	    } catch(Exception e) {
	        log.error("수량 수정 오류", e);
	        return "fail";
	    }
	}
	
}
