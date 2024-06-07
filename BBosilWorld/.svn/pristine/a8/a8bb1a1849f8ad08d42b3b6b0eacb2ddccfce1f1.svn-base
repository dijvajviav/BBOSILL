package com.bbosil.member.service;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bbosil.member.mapper.MemberMapper;
import com.bbosil.member.vo.LoginVO;
import com.bbosil.member.vo.MemberVO;
import com.webjjang.util.page.PageObject;

@Service // 자동 생성
@Qualifier("memberServiceImpl") // 자동 DI 할때 타입이 같은 것이 나오면 구분하기 위한 문자열.
public class MemberServiceImpl implements MemberService{

	@Inject // 자동 DI
	private MemberMapper mapper;
	
	@Override // 로그인 처리
	public LoginVO login(LoginVO vo) {
		return mapper.login(vo);
	}

	@Override // 회원가입 처리
	public int write(MemberVO vo) {
		return mapper.write(vo);
	}

	@Override // 회원 리스트 처리
	public List<MemberVO> list(PageObject pageObject) {
		// 페이지 처리를 위해서는 전체 데이터 개수
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		// mapper.getTotalRow();
		return mapper.list(pageObject);
	}

	@Override // 회원 상세보기 처리
	public MemberVO view(String id) {
		return mapper.view(id);
	}

	@Override // 회원 내정보 수정 처리
	public int update(MemberVO vo) {
		return mapper.update(vo);
	}
	
	@Override // 아이디 찾기
	public String findid(MemberVO vo) {
		return mapper.findid(vo);
	}
	

	@Override // 비밀번호 찾기 처리
	public MemberVO findpw(MemberVO vo) {
		return mapper.findpw(vo);
	}
	

	@Override // 비밀번호 변경 처리
	public int changepw(MemberVO vo) {
		return mapper.changepw(vo);
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	// AJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAXAJAX


	@Override // 회원가입시 아이디 중복 체크 처리
	public boolean checkIdDuplicate(String id) {
	    String result = mapper.checkIdDuplicate(id);
	    return result != null; // 조회된 결과가 있으면 true (중복), 없으면 false (중복 아님)
	}

	@Override // 회원가입시 이메일 중복체크 처리
	public boolean checkEmailDuplicate(String email) {
		String result = mapper.checkEmailDuplicate(email);
	    return result != null; // 조회된 결과가 있으면 true (중복), 없으면 false (중복 아님)
	}

	@Override // 회원 탈퇴시 비밀번호 확인 처리
	public boolean checkPassword(@Param("id") String id, @Param("password") String password) {
		String result = mapper.checkPassword(id, password);
	    return result != null; // 조회된 결과가 있으면 true (일치), 없으면 false 불일치)
	}

	@Override
	public boolean delete(String id) {
		int result = mapper.delete(id);
	    return result != 0; // 0이 아니면 true (일치), 0이면 false 불일치)
	}



	
}
