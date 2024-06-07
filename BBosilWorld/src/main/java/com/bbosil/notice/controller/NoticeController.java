
package com.bbosil.notice.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bbosil.member.vo.LoginVO;
import com.bbosil.notice.service.NoticeService;
import com.bbosil.notice.vo.NoticeVO;
import com.bbosil.util.str.ReplaceChar;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/notice")
@Log4j
public class NoticeController {
	
	@Autowired
	@Qualifier("noticeServiceImpl") // 자동 DI 할때 타입이 같은 것이 나오면 구분하기 위한 문자열.
	private NoticeService service;
	
	// 공지사항 리스트 - /notice/list.do : get
	@GetMapping("/list.do")
	public String list(Model model, HttpServletRequest request) throws Exception  {
		
		log.info(" - 공지사항 리스트 실행");
		System.out.println("--- 공지사항 리스트 실행");
		
	// pageObject 만들기  : List<NoticeVO>가 결과로 나온다.
	 PageObject pageObject = PageObject.getInstance(request);

	 // model에 데이터를 속성으로 추가하면 request에 담긴다. -> jsp까지 전달된다. 
	 model.addAttribute("list", service.list(pageObject));
	 
	 // list.jsp에서 페이지 처리에 필요하다. 
	 model.addAttribute("pageObject", pageObject);
		 
	 return "notice/list";
		
	}
	
	
	// 공지사항 상세보기
	@GetMapping("/view.do")
	public String view(Model model, Long no) {
		
		log.info(" ----- 공지사항 글보기 실행 -----"); 
		
		NoticeVO vo = service.view(no);
		
		// 특수문자 처리 - 공지 내용
		vo.setContent(ReplaceChar.specialChar(vo.getContent()));
		
		model.addAttribute("vo", vo);
		
		// /WEB-INF/views/ + notice/view + .jsp - forward
		
		return "notice/view";
	}
	
	// 공지사항 글 등록 폼 이동
	@GetMapping("/write.do")
	public String writeForm() {
		log.info("----- 공지사항 글등록 폼 -----");
		
		return "notice/write";
	}
	
	// 공지사항 글 등록
	@PostMapping("/write.do")
	public String write(NoticeVO vo, Long perPageNum, RedirectAttributes rttr) {
		
		log.info("----- 공지사항 글 등록 처리 -----");
		log.info(vo); // 데이터 수집 확인
		
		service.write(vo);
		
		rttr.addFlashAttribute("msg", "공지사항 글 등록("+vo.getNo()+"번)되었습니다.");
		
		// 처리가 끝나면 리스트로 이동한다.
		return "redirect:list.do?perPageNum=" + perPageNum;
	}
		
	// 공지사항 글 수정 폼
	@GetMapping("/update.do")
	public String updateForm(Long no, Model model) {
		
		log.info("----- 공지사항 글 수정 폼 -----");
		
		// DB에서 데이터 가져오기 (공지사항 보기) - no 필요
		// 가져온 데이터를 Model(=request)에 담는다. 
		
		model.addAttribute("vo", service.view(no));
		
		return "notice/update";
		
	}
	
	@PostMapping("/update.do")
	public String update(NoticeVO vo, PageObject pageObject, RedirectAttributes rttr) throws Exception
{
		
		log.info("----- 공지사항 글수정 처리 -----");
		log.info(vo); // 데이터 수집 확인
		
		int result = service.update(vo);
		
		// result = 1 : 수정 성공
		// = 0 : 수정 실패 - 번호나 비밀번호가 틀렸다. 
		
		log.info(result);
		
		if(result == 1) rttr.addFlashAttribute("msg", "공지사항 글("+vo.getNo()+")이 수정되었습니다. ");
		else rttr.addFlashAttribute("msg", "공지사항 글("+vo.getNo()+")이 수정되지 않았습니다. ");
		
		// 처리가 끝나면 리스트로 이동한다. - redirect
		
		return "redirect:view.do?no=" + vo.getNo() + "&" + pageObject.getPageQuery();
	}
	
	// 공지사항 글 삭제 처리 - /notice/delete.do : post
	@GetMapping("/delete.do")
	public String delete(long no, RedirectAttributes rttr) {
		
		log.info("----- 공지사항 글삭제 처리 -----");
		log.info(no); // 데이터 수집 확인
		
		int result = service.delete(no);
		
		log.info(result);
		
		if (result == 1) rttr.addFlashAttribute("msg", "공지사항 글 (" + no + ") 번이 삭제되었습니다. ");
		else rttr.addFlashAttribute("msg", "공지사항 글 (" + no + ") 번이 삭제되지 않았습니다. "); 
	
		
		// 처리가 끝나면 리스트로 이동한다. - redirect
		return "redirect:list.do";
	}
	
	// 공지사항 기간 지난 공지사항 삭제
	@PostMapping("/deleteExpiredNotices.do")
	public void update(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		log.info("----- 공지사항 기간 지난 공지 처리 -----");
		
		resp.setContentType("application/json");
	    resp.setCharacterEncoding("UTF-8");

		int result = service.expiredNotice();
		
		   if (result == 1) {
	            resp.getWriter().write("{\"success\": true}");
	        } else {
	            resp.getWriter().write("{\"success\": false}");
	        }
	}
	

}
