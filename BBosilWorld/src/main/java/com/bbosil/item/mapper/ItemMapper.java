package com.bbosil.item.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bbosil.item.util.ItemPageObject;
import com.bbosil.item.vo.CategoryVO;
import com.bbosil.item.vo.ItemVO;
import com.bbosil.item.vo.PriceVO;
import com.webjjang.util.page.PageObject;

@Repository
public interface ItemMapper {
	
	//item
	public List<ItemVO> list(ItemPageObject pageObject);
	
	public List<CategoryVO> category();
	
	
	public ItemVO view(long no);
	
	public int increase(long no);
	
	public int write(ItemVO vo);
	
	public int writePrice(ItemVO vo);
	
	public long getTotalRow(ItemPageObject pageObject);
	
	public int update(ItemVO vo);
	
	public int delete(long no);
	
	
	//price
	
	public List<PriceVO> priceList(long no);
	
	public int priceWrite(PriceVO vo);
	
	public int priceUpdate(PriceVO vo);
	
	public int priceDelete(PriceVO vo);
	
	public PriceVO findWrapper(PriceVO vo);
	
	public int wrapperPush(PriceVO vo);
	
	public int sDatePush(PriceVO vo);
	
	public int eDatePush(PriceVO vo);
	
//	public int datesPush(PriceVO vo);
	
	public int newDate(PriceVO vo);
	
}
