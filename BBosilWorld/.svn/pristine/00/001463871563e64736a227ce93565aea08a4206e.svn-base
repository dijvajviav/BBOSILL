package com.bbosil.item.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bbosil.item.service.ItemService;
import com.bbosil.item.vo.CategoryVO;

import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/category")
public class CategoryController {

	@Inject
	@Qualifier("itemServiceImpl")
	private ItemService service;
	
	
	@GetMapping(value = "/list.do" , produces = {
			MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<CategoryVO>> list (HttpServletRequest request){
		
		List<CategoryVO> list =  service.category();
		//카테고리 전체 리스트를 받아온다.
		
		ServletContext app = request.getServletContext(); 
		//application 영역 객체를 생성한다
		
		app.setAttribute("category", list);
		//application 영역에 category 리스트를 'category' 키로 저장한다.
		
		return new ResponseEntity<>( list , HttpStatus.OK);
	} 
}
