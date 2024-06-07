package com.bbosil.item.util;

import java.io.IOException;

import javax.inject.Qualifier;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.bbosil.item.service.ItemService;
import com.bbosil.item.service.ItemServiceImpl;

import lombok.extern.log4j.Log4j;

/**
 * Servlet Filter implementation class categoryGetter
 */
@Component
@Log4j
public class CategoryGetter implements Filter {

//	@Autowired
//	private ItemServiceImpl service;

    /**
     * Default constructor. 
     */
    public CategoryGetter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		
//		log.info("서비스는 존재하는가? : " + service);
//		
//		request.setAttribute("category", service.category()); 
		
//		***DAO 클래스를 직접 만들어서 그 객체를 여기에 생성해서 사용하는 방법으로 해결해 볼 수 있다. 시간남을 때 하자
		
		
		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
