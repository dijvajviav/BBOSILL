package com.bbosil.util.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.bbosil.member.vo.LoginVO;






public class AuthorityFilter extends HttpFilter implements Filter {
    public Map<String, Integer> authMap = new HashMap<>();
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
     * @see HttpFilter#HttpFilter()
     */
    public AuthorityFilter() {
        super();
        System.out.println("authFilter - on");
//        // TODO Auto-generated constructor stub
//        authMap.put("/item/write.do", 9);
//        authMap.put("/item/writeForm.do", 9);
//        authMap.put("/item/update.do", 9);
//        authMap.put("/item/updateForm.do", 9);
//        authMap.put("/item/delete.do", 9);
//        
//        authMap.put("/price/write.do", 9);
//        authMap.put("/price/update.do", 9);
//        authMap.put("/price/delete.do", 9);
//        
    
        // 회원관리 - 관리자 9 만 되는 것
        authMap.put("/member/list.do", 9);
        // 회원관리 - 관리자 9 나 일반회원 1 중 하나면 되는 것
        authMap.put("/member/view.do", 1);
        authMap.put("/member/update.do", 1);
        authMap.put("/member/delete.do", 1);
        authMap.put("/member/logout.do", 1);
        authMap.put("/coupon/listMemCo.do", 1);
        
        // 장바구니 - 관리자 9 나 일반회원 1 중 하나면 되는 것
        authMap.put("/cart/list.do", 1);
      
  
        
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

		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpSession session = httpRequest.getSession();
		LoginVO login = (LoginVO) session.getAttribute("login");
		
		String uri = httpRequest.getRequestURI();
		
		Integer authNo = authMap.get(uri);
		System.out.println("필요 권한 : " + authNo);
		
		if(authNo != null) {
			if(login == null) {
				httpRequest.getRequestDispatcher("/WEB-INF/views/error/loginError.jsp").forward(httpRequest, response);;
				return;
			}
			if(authNo > login.getGradeNo()) {
				httpRequest.getRequestDispatcher("/WEB-INF/views/error/authError.jsp").forward(httpRequest, response);
				return;
			}	
		}
		
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
