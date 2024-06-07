package com.bbosil.notice.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bbosil.notice.mapper.NoticeMapper;
import com.bbosil.notice.vo.NoticeVO;
import com.webjjang.util.page.PageObject;

@Service
public class NoticeServiceImpl implements NoticeService{
	
	@Inject
	private NoticeMapper mapper;

	@Override // 공지사항 리스트
	public List<NoticeVO> list(PageObject pageObject) {
		
		// 페이지 처리를 위한 전체 데이터 개수
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		
		return mapper.list(pageObject);
	}

	@Override // 공지사항 상세보기
	public NoticeVO view(Long no) {
		return mapper.view(no);
	} 
	
	@Override // 공지사항 글 쓰기
	public int write(NoticeVO vo) {
		return mapper.write(vo);
	}

	@Override // 공지사항 글 수정
	public int update(NoticeVO vo) {
		return mapper.update(vo);
	}

	@Override // 공지사항 삭제
	public int delete(long no) {
		return mapper.delete(no);
	}

	@Override // 기간이 지난 공지사항 삭제
	public int expiredNotice() {
		return mapper.expiredNotice();
	}
}
