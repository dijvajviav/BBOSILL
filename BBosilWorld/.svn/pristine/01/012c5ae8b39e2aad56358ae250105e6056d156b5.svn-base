package com.bbosil.item.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bbosil.item.vo.OptionVO;

@Repository
public interface OptionMapper {
	
	public List<OptionVO> list(long itemNo);

	public List<OptionVO> typeList();
	
	public List<OptionVO> valueList();
	
	public List<OptionVO> distincType(long itemNo);
	
	public OptionVO cartOption(long optionValueNo);
	
	
	public int writeType(OptionVO vo);

	public int writeValue(OptionVO vo);
	
	public int writeOption(OptionVO vo);
	

	public int deleteType(OptionVO vo);
	
	public int deleteValue(OptionVO vo);
	
	public int deleteOption(OptionVO vo);
	
	public int deleteOptionType(OptionVO vo);
	
	public int deleteAllOption(OptionVO vo);
	
	
}
