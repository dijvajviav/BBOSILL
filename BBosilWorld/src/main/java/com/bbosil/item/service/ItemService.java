package com.bbosil.item.service;

import java.util.List;

import com.bbosil.item.vo.ItemVO;
import com.bbosil.item.vo.PriceVO;
import com.bbosil.item.util.ItemPageObject;
import com.bbosil.item.vo.CategoryVO;

public interface ItemService {
	
	
	public List<ItemVO> list(ItemPageObject pageObject);
	
	public List<CategoryVO> category();
	

	public ItemVO view(long no, long inc);
	
	public int write(ItemVO vo);
	
	public int update(ItemVO vo);
	
	public int delete(long no);
	
	//price
	
	public List<PriceVO> priceList(long no);
	
	public int priceWrite(PriceVO vo);
	
	public int priceUpdate(PriceVO vo);
	
	public int priceDelete(PriceVO vo);
	

	
}
