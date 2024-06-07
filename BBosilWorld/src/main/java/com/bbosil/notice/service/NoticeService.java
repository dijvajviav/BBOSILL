package com.bbosil.notice.service;

import java.util.List;

import com.bbosil.notice.vo.NoticeVO;
import com.webjjang.util.page.PageObject;

public interface NoticeService {
	
	// 공지사항 리스트
	public List<NoticeVO> list(PageObject pageObject);
	
	// 공지사항 상세보기
	public NoticeVO view(Long no);
		
	// 공지사항 글 쓰기
	public int write(NoticeVO vo);
	
	// 공지사항 글 수정
	public int update(NoticeVO vo);

	// 공지사항 삭제
	public int delete(long no);

	// 기간이 지난 공지사항 삭제
	public int expiredNotice();

}
