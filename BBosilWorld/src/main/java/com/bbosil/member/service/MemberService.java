package com.bbosil.member.service;

import org.apache.ibatis.annotations.Param;

import com.bbosil.member.vo.LoginVO;
import com.bbosil.member.vo.MemberVO;
import com.webjjang.util.page.PageObject;

public interface MemberService {

	// 로그인 처리
	public LoginVO login(LoginVO vo);

	// 회원가입 처리
	public int write(MemberVO vo);

	// 회원 리스트 처리
	public Object list(PageObject pageObject);

	// 회원 상세보기 처리
	public MemberVO view(String id);

	// 회원 내정보 수정 처리
	public int update(MemberVO vo);
	
	// 아이디 찾기
	public String findid(MemberVO vo);
	
	// 비밀번호 찾기
	public MemberVO findpw(MemberVO vo);
	
	// 비밀번호 변경 처리
	public int changepw(MemberVO vo);
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	// AJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAX
	
	// 회원가입시 아이디 중복 체크 처리
	public boolean checkIdDuplicate(String id);
	
	// 회원가입시 이메일 중복체크 처리
	public boolean checkEmailDuplicate(String email);
	
	// 회원 탈퇴시 비밀번호 확인 처리
	public boolean checkPassword(@Param("id") String id, @Param("password") String password);
	
	// 회원 탈퇴 처리
	public boolean delete(String id);





	
}
