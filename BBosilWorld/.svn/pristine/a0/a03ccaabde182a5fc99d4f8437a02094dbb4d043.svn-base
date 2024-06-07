package com.bbosil.exception;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

/*
 * 일반적인 예외 처리(동작) 프로그램
 * 예외타입이 Exception이면 처리되는 메서드 -> 내부 예외 : 500 번 오류
 * 
 * */
@ControllerAdvice 
@Log4j
public class CommonExceptionAdvice {
	
	//자동생성 어노테이션
	/* @Controller : MVC의 컨트롤러. HTTP 요청 처리하고 사용자 입력을 받은 데이터를 수집해
	 * 해당 정보를 가공하고 그 결과를 view로 전달.
	 * 
	 *  @Service : 서비스. 데이터 처리 로직을 사용해서 해당 기능을 제공하는 역할
	 *  
	 *  @Repository : DB관련 데이터처리 (DAO)
	 *  
	 *  @Component : 일반 클래스, 개발자 커스텀 클래스.
	 *  
	 *   @RestController: Controller와 유사하지만, ajax 를 쓸때 사용
	 *   
	 *   @Advice : AOP에 사용, 공통 관심사항 처리 . 필터와 같은 역할도 하고, 트랜젝션에 사용

	 *  자동 생성 위치에 대한 설정이 필요하다. servlet-context.xml , 
	 *  uri 필요 없을시  : root-context.xml-> */
	// 예외타입이 Exception이면 처리되는 메서드 -> 내부 예외 : 500번 오류
	
	@ExceptionHandler(Exception.class)
	public String exception(@ModelAttribute(name="exception") Exception ex, Model model) {
		
		log.error("Exception ....." + ex.getMessage());
		
		model.addAttribute("exception", ex);
		log.error(model);
		
		return "error_page";
		
	}
	
	
	//404 처리되는 메서드
	//처리 결과를 표시하는 JSP가 없는 경우는 처리하지 않는다. URL이 없는 경우만 처리한다.
	//JSP가 없는 처리 = web.xml에 error-page에 error-code 404로 잡힘
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404(NoHandlerFoundException ex) {
		
		return "custom404";
	}
	
}
