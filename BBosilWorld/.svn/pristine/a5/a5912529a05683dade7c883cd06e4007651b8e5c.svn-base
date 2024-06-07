package com.bbosil.item.controller;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bbosil.item.service.OptionService;
import com.bbosil.item.vo.OptionVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/option")
public class OptionController {

	@Inject
	@Qualifier("optionServiceImpl")
	private OptionService service;
	
	//옵션 종류를 등록한다. -ex) 사이즈, 맛, 향, 증정품...
	@GetMapping("/writeType")
	public String writeType(OptionVO vo, long itemNo, PageObject pageObject) throws Exception {
		
		service.writeType(vo);
		
		return "redirect:/item/view.do?no=" + itemNo + "&inc=0&" + pageObject.getPageQuery();
	}
	
	//옵션의 값을  등록한다. -ex) 닭고기맛, 연어맛, 참치맛...
	@GetMapping("/writeValue")
	public String writeValue(OptionVO vo, long itemNo , PageObject pageObject) throws Exception {
		
		service.writeValue(vo);
		
		return "redirect:/item/view.do?no=" + itemNo + "&inc=0&" + pageObject.getPageQuery();
	}
	
	//특정 상품에 옵션을 등록한다.
	@GetMapping("/write")
	public String writeOption(OptionVO vo, long itemNo , PageObject pageObject) throws Exception {
		
		service.writeOption(vo);
		
		return "redirect:/item/view.do?no=" + itemNo + "&inc=0&" + pageObject.getPageQuery();
	}
	
	//기존 옵션 종류중 하나를 삭제한다.
	@GetMapping("/deleteType")
	public String deleteType(OptionVO vo, long itemNo , PageObject pageObject) throws Exception {
		
		
		int result = service.deleteType(vo);
		log.info("deleteType 실행중... 결과값 :" +result );
		
		return "redirect:/item/view.do?no=" + itemNo + "&inc=0&" + pageObject.getPageQuery();
	}
	
	//기존 옵션 종류속 값중 하나를 삭제한다.
	@GetMapping("/deleteValue")
	public String deleteValue(OptionVO vo, long itemNo , PageObject pageObject) throws Exception {
		
		log.info("deleteValue 실행중...");
		
		service.deleteValue(vo);
		
		return "redirect:/item/view.do?no=" + itemNo + "&inc=0&" + pageObject.getPageQuery();
	}
	
	//특정 상품의 옵션을 삭제한다.
	@GetMapping("/deleteOption")
	public String deleteOption(OptionVO vo, long itemNo , PageObject pageObject) throws Exception {
		
		log.info("deleteOption 실행중...");
		
		service.deleteOption(vo);
		
		return "redirect:/item/view.do?no=" + itemNo + "&inc=0&" + pageObject.getPageQuery();
	}
	
	//특정 상품의  옵션종류를 삭제한다.
	@GetMapping("/deleteOptionType")
	public String deleteOptionType(OptionVO vo, long itemNo , PageObject pageObject) throws Exception {
		
		log.info("deleteOptionType 실행중...");
		
		service.deleteOptionType(vo);
		
		return "redirect:/item/view.do?no=" + itemNo + "&inc=0&" + pageObject.getPageQuery();
	}
	
	//특정 상품의 모든 옵션을 삭제한다.
	@GetMapping("/deleteAllOption")
	public String deleteAllOption(OptionVO vo, long itemNo , PageObject pageObject) throws Exception {
		
		log.info("deleteAllOption 실행중...");
		
		service.deleteAllOption(vo);
		
		return "redirect:/item/view.do?no=" + itemNo + "&inc=0&" + pageObject.getPageQuery();
	}
	
	
}
