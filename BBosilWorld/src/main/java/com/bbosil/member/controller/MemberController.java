package com.bbosil.member.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

// 이메일 발송할 때 필요한듯
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
//이메일 발송할 때 필요한듯


import com.bbosil.member.service.MemberService;
import com.bbosil.member.vo.LoginVO;
import com.bbosil.member.vo.MemberVO;
import com.bbosil.util.OAth.UserProfile;
import com.bbosil.util.mail.EmailService;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {

	@Autowired
	@Qualifier("memberServiceImpl") // 자동 DI 할때 타입이 같은 것이 나오면 구분하기 위한 문자열.
	private MemberService service;
	
    @Autowired
    private EmailService emailService;
    
    final DefaultMessageService messageService;
    
    public MemberController() {
        // 반드시 계정 내 등록된 유효한 API 키, API Secret Key를 입력해주셔야 합니다!
        this.messageService = NurigoApp.INSTANCE.initialize("NCSVUZD5BKEHM3FG", "2CUA0T1Q9W3DI2KXXXSDEGZUH6LY86KE", "https://api.coolsms.co.kr");
    }
    
	
	// 로그인 폼
	@GetMapping("/login.do")
	public String loginForm() {
		return "member/login";
	}
	
	// 로그인
	@PostMapping("/login.do")
	public String login(LoginVO invo, HttpSession session, RedirectAttributes rttr) {
		
		log.info("로그인 처리 ................................................");
		log.info(invo);
		
		LoginVO vo = service.login(invo); // LoginVO 타입의 vo변수에 로그인 정보를 넣어놓자
		
		
		if(vo == null || vo.getStatus().equals("탈퇴")) {
			// id나 비밀번호가 맞지 않는다.
			rttr.addFlashAttribute("msg", "아이디나 비밀번호가 맞지 않거나 탈퇴한 계정입니다.");
			System.out.println("아이디나 비밀번호가 맞지 않습니다. 다시 시도해 주세요.");
			return "redirect:/member/login.do";
		} else {
			// id나 비밀번호가 맞는다. -> 로그인 처리를 해준다. : session에 로그인 정보를 저장시킨다.
			session.setAttribute("login", vo);
			System.out.println(" 로그인 되었습니다. 즐거운 시간 보내세요.");
			return "redirect:/main/main.do";
		}
	}
	
	
	// 로그아웃 - 딱히 실행할 서비스가 없음
	@GetMapping("/logout.do")
	public String logout(HttpSession session) {
		session.removeAttribute("login");
		return "redirect:/main/main.do"; // 로그아웃 되었으니 main으로 가야하지만 일단 로그인 창으로 이동하자(당장 main이 딱히 없으니까)
	}
	
	// 회원가입 폼
	@GetMapping("/write.do")
	public String write(Model model, HttpSession session) {
		UserProfile userProfile = (UserProfile) session.getAttribute("userProfile");
		
	    if (userProfile != null) {
	        model.addAttribute("userProfile", userProfile);
	        
	        // 세션에서 userProfile을 제거
	        session.removeAttribute("userProfile");
	    }
	    return "member/write";
	}
	
	// 회원가입
	@PostMapping("/write.do")
	public String write(MemberVO vo, String[] tels, RedirectAttributes rttr) {
		String tel = String.join("-", tels); // tels에는 -이 없기 때문에 -을 넣은 Stirng으로 만들어준다.
		vo.setTel(tel); // 바로 위에서 만든 -가 들어간 전화번호를  vo에 세팅해준다.
				
		int result = service.write(vo);
		
		if(result == 1) {
			System.out.println(" 회원가입 되었습니다. 즐거운 시간 보내세요.");
		}
		else {
			System.out.println(" 회원가입 실패!!");
		}
		
		// 회원가입 실행 후 로그인 폼으로 이동
		return "member/login";
	}
	
	// 회원 리스트
	@GetMapping("/list.do")
	public String list(Model model, HttpServletRequest request) throws Exception {
		
		log.info(" - 회원리스트 실행");
		System.out.println("--- 회원리스트 실행");
		
		// pageObject 만들기
		PageObject pageObject = PageObject.getInstance(request);
		
		// model에 데이터를 속성으로 추가하면 request에 담긴다. -> jsp까지 전달된다.
		model.addAttribute("list", service.list(pageObject));
		// list.jsp에서 페이지 처리에 필요하다.
		model.addAttribute("pageObject", pageObject);
		
		// /WEB-INF/views/ + member/list + .jsp - forwoard
		return "member/list";
	}
	
	// 회원 상세보기(회원리스트 or 내 정보보기)
	@GetMapping("/view.do")
	public String view(Model model, HttpServletRequest request) throws Exception {
		
		// session 가져 오기. 왜 ?  아이디 가져올라고
		HttpSession session = request.getSession();
				
		
		log.info(" - 회원 상세보기 실행");
		System.out.println("--- 회원 상세보기 실행");
		
		String id = request.getParameter("id");
			
		if (id == null) // 위에서 선언한 id에 담겨진 값이 없으면 (즉 null이면)
			id = ((LoginVO) (session.getAttribute("login"))).getId(); // 넘어오는 아이디가 없으면 세션에서 받아오니까 내 정보 보기
		
		MemberVO vo = service.view(id);
		
		// model에 데이터를 속성으로 추가하면 request에 담긴다. -> jsp까지 전달된다.
		model.addAttribute("vo", vo);
		// /WEB-INF/views/ + member/list + .jsp - forwoard
		return "member/view";
	}
	
		// 회원 정보 수정 폼(내 정보보기에서 수정 버튼을 눌러 이동)
		@GetMapping("/update.do")
		public String update(Model model, HttpServletRequest request) throws Exception {
			
			// session 가져 오기. 왜 ?  아이디 가져올라고
			HttpSession session = request.getSession();
					
			log.info(" - 회원 정보수정 폼 실행");
			System.out.println("--- 회원 정보수정 폼  실행");
			
			String id = request.getParameter("id");
				
			if (id == null) // 위에서 선언한 id에 담겨진 값이 없으면 (즉 null이면)
				id = ((LoginVO) (session.getAttribute("login"))).getId(); // 넘어오는 아이디가 없으면 세션에서 받아오니까 내 정보 보기
			
			MemberVO vo = service.view(id);
			
			// model에 데이터를 속성으로 추가하면 request에 담긴다. -> jsp까지 전달된다.
			model.addAttribute("vo", vo);
			// /WEB-INF/views/ + member/list + .jsp - forwoard
			return "member/update";
		}
		
		// 회원 상세보기(내 정보보기에서 수정 버튼을 눌러 이동)
		@PostMapping("/update.do")
		public String update(Model model, MemberVO vo, HttpSession session, String[] tels, RedirectAttributes rttr) throws Exception {
			log.info(" - 회원 정보수정 실행");
			System.out.println("--- 회원 정보수정  실행");
			
			String tel = String.join("-", tels); // tels에는 -이 없기 때문에 -을 넣은 Stirng으로 만들어준다.
			vo.setTel(tel); // 바로 위에서 만든 -가 들어간 전화번호를  vo에 세팅해준다.
				
			int result = service.update(vo);
			
			if(result == 1) {
				// 세션 업데이트: 수정된 회원 정보로 세션 정보 업데이트
		        LoginVO loginVO = (LoginVO) session.getAttribute("login"); // 현재 세션의 로그인 정보를 불러오기
		        
		        if (loginVO != null && loginVO.getId().equals(vo.getId())) { // 현재 로그인 되어 있고 & 현재 로그인 아이디랑 vo에 있는 아이디가 같으면
		            loginVO.setName(vo.getName()); // 이름 업데이트
		            
		          session.setAttribute("login", loginVO); // 세션 업데이트
		           
				System.out.println(" 회원 정보수정 되었습니다. 즐거운 시간 보내세요.");
				rttr.addFlashAttribute("msg", "뽀실월드에 오신 것을 환영합니다.");
			}
			}
			else {
				System.out.println(" 회원 정보수정 실패!!. 썩 나가거라!!");
			}
			
			System.out.println("근데 여기 아이디가 있냐 ? ID = " + vo.getId());
			
		    return "redirect:/member/view.do";
		}
		
		// 아이디 찾기 폼
		@GetMapping("/findid.do")
		public String findid() {
			return "member/findid";
		}
		
		// 아이디 찾기
		@PostMapping("/findid.do")
		public String findid(Model model, MemberVO vo, RedirectAttributes rttr) {
			System.out.println(vo.getName());
			System.out.println(vo.getEmail());
			
			// 일치하는 아이디를 찾아 MemeberVO타입 findid에 넣는다.
			String id = service.findid(vo);
			MemberVO findid = new MemberVO();
			findid.setId(id);
			
			// model에 데이터를 속성으로 추가하면  request에 담긴다. -> jsp까지 전달된다.
			model.addAttribute("vo", findid);
			
			// 아이디 찾기 결과 화면으로 이동
			return "member/findresultid";
		}
		
		
		// 비밀번호 찾기 폼
		@GetMapping("/findpw.do")
		public String findpw() {
			return "member/findpw";
		}
		
		// 비밀번호 찾기
		@PostMapping("/findpw.do")
		public String findpw(Model model, MemberVO vo, RedirectAttributes rttr) {
			
			// 일치하는 아이디,이메일,이름 등을찾아 MemeberVO타입 findpw에 넣는다.
			MemberVO findpw = service.findpw(vo);
			
			 if(findpw != null && findpw.getId() != null) {
			        // 일치하는 회원 정보가 있으면 비밀번호 변경 페이지로 이동
			        System.out.println("비밀번호를 찾고 싶은데 findpw안에 대체 뭐있냐?" + findpw.getId());
			        model.addAttribute("vo", findpw);
			        return "member/changepw"; // 또는 필요한 정보를 model에 담아서 전달
			    } else {
			        // 일치하는 회원 정보가 없으면 메시지를 담고 비밀번호 찾기 페이지로 리다이렉트
			        rttr.addFlashAttribute("msg", "일치하는 회원 정보가 없습니다.");
			        System.out.println("아니 안에 없다고 ㅅㅂ");
			        return "redirect:/member/findpw.do"; // 리다이렉트를 통해 비밀번호 찾기 페이지로 이동
			    }

		}
		
		// 비밀번호 변경 폼
		@GetMapping("/changepw.do")
		public String changepw() {
			return "member/changepw";
		}
		
		// 비밀번호 변경
		@PostMapping("/changepw.do")
		public String changepw(Model model, MemberVO vo, RedirectAttributes rttr) {
			
			// 일치하는 아이디,이메일,이름 등을찾아 MemeberVO타입 findpw에 넣는다.
			int result = service.changepw(vo);
			
			if(result == 1) {
			 System.out.println("비밀번호 변경이 완료되었습니다.");
			 return "redirect:/member/logout.do";
			}else {
				System.out.println("비밀번호 변경이 실패하였습니다.");
				return "redirect:/member/view.do";
			}
		}
		
		
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////
// AJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXA
		
		// 회원가입시 아이디 중복 체크
		@PostMapping("/checkIdDuplicate")
		public void checkIdDuplicate(@RequestParam("id") String id, HttpServletResponse response) throws Exception {
			JSONObject jsonResponse = new JSONObject();

			boolean isDuplicate = service.checkIdDuplicate(id);
			System.out.println("야 지금이게  컨트롤러에서 아이디 중복체크 하는 건데 isDuplicate 값이 뭔지 보자 : " + isDuplicate);

			jsonResponse.put("isDuplicate", isDuplicate);

			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jsonResponse.toString());

			return;
		}
		
		// 회원가입시 이메일 중복 체크
		@PostMapping("/checkEmailDuplicate")
		public void checkEmailDuplicate(@RequestParam("email") String email, HttpServletResponse response) throws Exception {
			JSONObject jsonResponse = new JSONObject();

			boolean isDuplicateEmail = service.checkEmailDuplicate(email);
			System.out.println("야 지금이게  컨트롤러에서 이메일 중복체크 하는 건데 isDuplicateEmail 값이 뭔지 보자 : " + isDuplicateEmail);

			jsonResponse.put("isDuplicateEmail", isDuplicateEmail);

			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jsonResponse.toString());

			return;
		}
		
		// 회원가입 시 이메일 인증번호 발송(이메일 중복 확인 이후 이루어져야함)
		@RequestMapping("/sendVerificationEmail")
		public void sendVerificationEmail(HttpSession session, HttpServletResponse response, @RequestParam("email") String email) throws Exception {
			
			String verificationCode = Integer.toString((int)(Math.random() * 900000) + 100000);
			System.out.println("그래서 발송된 인증번호가 뭔데? 이메일 인증번호 : " + verificationCode);
			
	        // 인증번호를 이메일로 발송
	        String subject = "뽀실월드 인증";
	        String text = "뽀실월드 인증번호 : " + verificationCode;
	        emailService.sendVerificationEmail(email, subject, text);
	        
	        // 세션에 인증번호 저장
	        session.setAttribute("verificationCode", verificationCode);
	        
	        // ajax에 값을 반환 
	        JSONObject jsonResponse = new JSONObject();
	        jsonResponse.put("sent", true); // 이렇게 되면 무조건 발송되었다고 나옴

			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jsonResponse.toString());
			
	        return;
		}
		
		// 클라이언트가 입력한 인증번호가 세션에 저장되어있는(발송한 인증번호) 번호와 같은지 검사
		@PostMapping("/verifyVerificationCode")
		public void verifyCode(HttpSession session, @RequestParam("Codeverify") String Codeverify, HttpServletResponse response) throws Exception {
		    // 세션에서 인증번호 가져오기
		    String verificationCode = (String) session.getAttribute("verificationCode");
		    JSONObject jsonResponse = new JSONObject();
		    
		    if (verificationCode != null && verificationCode.equals(Codeverify)) {
		        // 인증 성공
		    	jsonResponse.put("isVerified", true);
		    	session.removeAttribute("verificationCode");
		    } else {
		        // 인증 실패
		    	jsonResponse.put("isVerified", false);
		    }
		    response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jsonResponse.toString());
			
		    return;
		}
		
		// 내 정보보기에서 회원탈퇴를 누른 후 비밀번호를 입력하는데, 그 비밀번호가 현재 로그인 된 계정의 비밀번호와 일치하는지 검사
		@PostMapping("/checkPassword")
		public void checkPassword(@RequestParam("password") String password, HttpServletResponse response, HttpSession session) throws Exception {
			JSONObject jsonResponse = new JSONObject();
			
			// 세션에서 id를 가져오자
			String id = ((LoginVO) (session.getAttribute("login"))).getId();
			System.out.println("checkPassword 잖아? 그래서 지금 id = " + id + " 비밀번호는 = " + password);
			boolean responsed = service.checkPassword(id, password);
			System.out.println("여기까지는 와?");
			jsonResponse.put("responsed", responsed);

			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jsonResponse.toString());

			return;
		}
		
		// 회원탈퇴
		@PostMapping("/delete")
		public void delete(HttpServletResponse response, HttpSession session) throws Exception {
			JSONObject jsonResponse = new JSONObject();
			
			// 세션에서 id를 가져오자
			String id = ((LoginVO) (session.getAttribute("login"))).getId();
			
			boolean deleteResponse = service.delete(id);

			jsonResponse.put("deleteResponse", deleteResponse);

			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jsonResponse.toString());

			return;
		}
		
		// 문자 메세지 보내기
	    @PostMapping("/sendsms")
	    public void sendsms(String phoneNumber, HttpSession session, HttpServletResponse response) throws Exception {
	        Message message = new Message();
	        JSONObject jsonResponse = new JSONObject();
	        // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
	        String phone = "01020909807";
	        
	        String phoneverificationCode = Integer.toString((int)(Math.random() * 900000) + 100000);
	        
	        message.setFrom(phone);
	        message.setTo(phoneNumber);
	        message.setText("뽀실월드 인증번호 : " + phoneverificationCode);
	        
	        // 세션에 인증번호 저장
	        session.setAttribute("phoneverificationCode", phoneverificationCode);
	        
	        
	        SingleMessageSentResponse responsE = this.messageService.sendOne(new SingleMessageSendingRequest(message));
	        
	        System.out.println(response);
	        if(responsE != null) {
	        	jsonResponse.put("sent", true);
	        }else {
	        	jsonResponse.put("sent", false);
	        	}
	        
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().write(jsonResponse.toString());
	        
	        return;
	        }
	    
		// 클라이언트가 입력한 휴대폰 인증번호가 세션에 저장되어있는(발송한 휴대폰  인증번호) 번호와 같은지 검사
		@PostMapping("/verifyPhoneNumber")
		public void verifyPhoneNumber(HttpSession session, @RequestParam("verificationCode") String verificationCode, String phoneNumber, HttpServletResponse response) throws Exception {
		    // 세션에서 인증번호 가져오기
		    String phoneverificationCode = (String) session.getAttribute("phoneverificationCode");
		    JSONObject jsonResponse = new JSONObject();
		    
		    if (phoneverificationCode != null && verificationCode.equals(phoneverificationCode)) {
		        // 인증 성공
		    	jsonResponse.put("verified", true);
		    	session.removeAttribute("verificationCode");
		    } else {
		        // 인증 실패
		    	jsonResponse.put("verified", false);
		    }
		    response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jsonResponse.toString());
			
		    return;
		}
		
		
		
	}
