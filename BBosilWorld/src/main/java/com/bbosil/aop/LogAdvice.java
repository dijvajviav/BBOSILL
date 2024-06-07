package com.bbosil.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

//자동 생성 어노테이션
@Aspect
@Log4j
@Component
public class LogAdvice {
	
//					모든 범위,  						*() 아무패턴의 메서드
	
	//교재는 root-context.xml에 설정했지만, 안되서 servlet-context.xml에 적용함. 
	//Execute 클래스 역할. 
	
	//이 어노테이션은 어떤 메서드를 실행할때 이 메서드를 실행할 것인지 알려준다.
	@Around("execution(* com.bbosil.*.service.*Service.*(..))")
	public Object logPrint (ProceedingJoinPoint pjp) throws Throwable {
		Object result = null;
		
		log.info("");
		log.info("");
		log.info("======<AOP Start>========================");
		long start = System.currentTimeMillis();		
		//로그출력 = 실행 클래스, 넘어가는 데이터, 시작 시간
		log.info("실행 객체 :  " + pjp.getTarget());          
		log.info("전달 데이터 : " + Arrays.toString(pjp.getArgs()));
		log.info("=======<AOP>=======================");
		//로그 출력 - 결과 데이터, 끝시간
		result = pjp.proceed();
		//AOP의 타겟 메서드를 실행하는 부분.
		
		log.info("");
		log.info("=======<AOP>=======================");
		log.info("실행 결과: " + result);
		
		
		long end = System.currentTimeMillis();
		log.info("실행 시간: " + (end - start));
		log.info("======<AOP End>========================");
		log.info("");
		return result;
	}
}
