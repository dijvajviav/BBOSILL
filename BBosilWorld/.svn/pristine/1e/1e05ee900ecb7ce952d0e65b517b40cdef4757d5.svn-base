package com.bbosil.item.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bbosil.item.mapper.ItemMapper;
import com.bbosil.item.util.ItemPageObject;
import com.bbosil.item.vo.CategoryVO;
import com.bbosil.item.vo.ItemVO;
import com.bbosil.item.vo.PriceVO;
import com.webjjang.util.page.PageObject;

@Service
@Qualifier("itemServiceImpl")
public class ItemServiceImpl implements ItemService{

	@Inject
	private ItemMapper mapper;
	
	@Override
	public List<CategoryVO> category(){
		// System.out.println(mapper.category());
		return mapper.category();
	}
	
	@Override
	public List<ItemVO> list(ItemPageObject pageObject) {
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}

	@Override
	public ItemVO view(long no, long inc) {
		if(inc == 1) mapper.increase(no);
		return mapper.view(no);
	}

	@Override
	@Transactional
	public int write(ItemVO vo) {
	//상품 정보를 새로 등록할 때 기본 가격과 상품정보 등록을 한다.
		mapper.write(vo);
		return mapper.writePrice(vo);
	}

	@Override
	public int update(ItemVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public int delete(long no) {
		// TODO Auto-generated method stub
		return mapper.delete(no);
	}

	@Override
	public List<PriceVO> priceList(long no) {
		// TODO Auto-generated method stub
		return mapper.priceList(no);
	}

	@Override
	@Transactional
	public int priceWrite(PriceVO vo) {
		
//		시작 혹은 종료날짜만 겹치는 날짜들을 먼저 수정한다. 
		mapper.sDatePush(vo);
		mapper.eDatePush(vo);
		
//		입력 날짜보다 더 큰 범위의 날짜를 찾아낸다
		PriceVO wrapper = mapper.findWrapper(vo);

		if(wrapper != null) {
//			더 큰 범위 날짜를 둘로 나누는 작업을 실행한다.
			
//			더 큰 범위 날짜의 시작일을 입력한 날짜의 시작날짜로 수정한다.
			wrapper.setStartDate(vo.getStartDate());
			mapper.wrapperPush(wrapper);
//			더 큰 범위 날짜의 시작일을 입력 날짜의 종료일로 바꾼다.
			wrapper.setStartDate(vo.getEndDate());
//	 		기존의 가격정보와 새로운 시작일을 가지는 wrapper 객체의 정보를 DB에 등록한다.
			mapper.newDate(wrapper);
			}	
		return mapper.priceWrite(vo);
	}

	@Override
	@Transactional
	public int priceUpdate(PriceVO vo) {

//		시작 혹은 종료날짜만 겹치는 날짜들을 먼저 수정한다. 
		mapper.sDatePush(vo);
		mapper.eDatePush(vo);
		
//		입력 날짜보다 더 큰 범위의 날짜를 찾아낸다
		PriceVO wrapper = mapper.findWrapper(vo);

		if(wrapper != null) {
			
		
//		더 큰 범위 날짜를 둘로 나누는 작업을 실행한다.
		
/*	더 큰 범위 날짜의 시작일을 입력한 날짜의 시작날짜로 수정한다. setEndDate를 쓰면 myBatis에서 set endDate = #{endDate}로
	이해하기 쉬운 형태로 만들 수 있지만, wrapper의 endDate를 변수로 저장한 후 다시 세팅해야하는 코드가 늘기 때문에 코드량은 늘어난다.
*/
		
		wrapper.setStartDate(vo.getStartDate());
		mapper.wrapperPush(wrapper);
		
//		더 큰 범위 날짜의 시작일을 입력 날짜의 종료일로 바꾼다.
		wrapper.setStartDate(vo.getEndDate());
// 		기존의 가격정보와 새로운 시작일을 가지는 wrapper 객체의 정보를 DB에 등록한다.
		mapper.newDate(wrapper);
		}	
		
		return mapper.priceUpdate(vo);
	}

	@Override
	public int priceDelete(PriceVO vo) {

		return mapper.priceDelete(vo);
	}

}
