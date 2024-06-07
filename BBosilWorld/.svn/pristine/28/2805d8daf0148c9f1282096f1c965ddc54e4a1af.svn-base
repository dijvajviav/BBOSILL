package com.bbosil.item.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bbosil.item.mapper.OptionMapper;
import com.bbosil.item.vo.OptionVO;

@Qualifier("optionServiceImpl")
@Service
public class OptionServiceImpl implements OptionService{
	
	@Inject
	private OptionMapper mapper;
	
	@Override
	public List<OptionVO> list(long itemNo) {
		
		return mapper.list(itemNo);
	}
	
	@Override
	public List<OptionVO> distincType(long itemNo) {
		// TODO Auto-generated method stub
		return mapper.distincType(itemNo);
	}
	
	@Override
	public List<OptionVO> typeList() {
		// TODO Auto-generated method stub
		return mapper.typeList();
	}

	@Override
	public List<OptionVO> valueList() {
		// TODO Auto-generated method stub
		return mapper.valueList();
	}

	@Override
	public int writeType(OptionVO vo) {
		// TODO Auto-generated method stub
		return mapper.writeType(vo);
	}

	@Override
	public int writeValue(OptionVO vo) {
		// TODO Auto-generated method stub
		return mapper.writeValue(vo);
	}

	@Override
	public int writeOption(OptionVO vo) {
		// TODO Auto-generated method stub
		return mapper.writeOption(vo);
	}


	@Override
	public OptionVO cartOption(long optionValueNo) {
		// TODO Auto-generated method stub
		return mapper.cartOption(optionValueNo);
	}

	@Override
	public int deleteType(OptionVO vo) {
		// TODO Auto-generated method stub
		return mapper.deleteType(vo);
	}

	@Override
	public int deleteValue(OptionVO vo) {
		// TODO Auto-generated method stub
		return mapper.deleteValue(vo);
	}

	@Override
	public int deleteOption(OptionVO vo) {
		// TODO Auto-generated method stub
		return mapper.deleteOption(vo);
	}

	@Override
	public int deleteOptionType(OptionVO vo) {
		// TODO Auto-generated method stub
		return mapper.deleteOptionType(vo);
	}

	@Override
	public int deleteAllOption(OptionVO vo) {
		// TODO Auto-generated method stub
		return mapper.deleteAllOption(vo);
	}





}
