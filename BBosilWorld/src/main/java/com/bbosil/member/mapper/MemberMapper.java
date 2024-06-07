package com.bbosil.member.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bbosil.member.vo.LoginVO;
import com.bbosil.member.vo.MemberVO;
import com.webjjang.util.page.PageObject;

@Repository
public interface MemberMapper {

	// 로그인 처리
	public LoginVO login(LoginVO vo);
	
	// 회원가입 처리
	public int write(MemberVO vo);

	// 회원 리스트를 출력하기 위해 필요한 회원 데이터 전체의 수를 구하는 처리
	public long getTotalRow(PageObject pageObject);

	// 회원 리스트 처리
	public List<MemberVO> list(PageObject pageObject);
	
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
	
	////////////////////////////////////////////////////////////////////////
	// AJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAX
	
	// 회원가입시 아이디 중복체크 처리
	public String checkIdDuplicate(String id);
	
	// 회원가입시 이메일 중복체크 처리
	public String checkEmailDuplicate(String email);
	
	// 회원 탈퇴시 비밀번호 확인 처리
	public String checkPassword(@Param("id") String id, @Param("password") String password);
	
	// 회원탈퇴 처리
	public int delete(String id);
	




	
}
