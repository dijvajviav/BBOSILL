package com.bbosil.notice.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bbosil.notice.vo.NoticeVO;
import com.webjjang.util.page.PageObject;

@Repository
public interface NoticeMapper {
	
	// 공지사항 리스트
	public List<NoticeVO> list(PageObject pageObject);
	
	// 전체 데이터 개수 
	public Long getTotalRow(PageObject pageObject);
	
	// 공지사항 상세보기
	public NoticeVO view(Long no);
	
	// 공지사항 글 쓰기
	public int write(NoticeVO vo);
	
	// 공지사항 수정
	public int update(NoticeVO vo);
	
	// 공지사항 삭제
	public int delete(long no);

	// 기간이 지난 공지사항 삭제
	public int expiredNotice();
	
}
