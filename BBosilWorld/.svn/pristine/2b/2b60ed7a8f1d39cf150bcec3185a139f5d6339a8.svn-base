package com.bbosil.item.controller;

import java.util.List;

import javax.inject.Inject;

import org.json.HTTP;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bbosil.item.service.ItemService;
import com.bbosil.item.vo.PriceVO;

import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/price")

public class PriceController {
	
	@Inject
	@Qualifier("itemServiceImpl")
	private ItemService service;
	
	
	@GetMapping(value = "/list.do", produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE,
			MediaType.APPLICATION_XML_VALUE
	})
	public ResponseEntity<List<PriceVO >> priceList(long no) {
//		ResponseEntity : 클라이언트에게 HTTP요청을 받은 뒤 처리한 코드를 본문에 넣고, 헤더와 상태코드를 추가하고 이들을 더 세밀하게
// 조작할 수 있는 객체이다. 본문을 JSON,XML , 등의 특정 데이터 형식만으로도 받을 수 있고, 호환문제가 적어 비동기 통신에 사용된다.
		
		List<PriceVO> priceList = service.priceList(no);
		//ResponseEntity로 보낼 응답 본문에 넣을 
		
		log.info("PriceController.PriceList()---------------");
		
		return new ResponseEntity<>(priceList , HttpStatus.OK);
	
	}
	
	@PostMapping(value = "/write.do", consumes = "application/json",
			produces = {"application/text; charset=utf-8" })
	public ResponseEntity<String> priceWrite(@RequestBody PriceVO vo) {
//		ResponseEntity : 클라이언트에게 HTTP요청을 받은 뒤 처리한 코드를 본문에 넣고, 헤더와 상태코드를 추가하고 이들을 더 세밀하게
// 조작할 수 있는 객체이다. 본문을 JSON,XML , 등의 특정 데이터 형식만으로도 받을 수 있고, 호환문제가 적어 비동기 통신에 사용된다.
		
		int result = service.priceWrite(vo);
		//ResponseEntity로 보낼 응답 본문에 넣을 
		
		log.info("PriceController.PriceWrite()---------------");
		
		return new ResponseEntity<>("가격 등록 성공!" , HttpStatus.OK);
		
	}
	
	@PutMapping(value = "/update.do", consumes = "application/json",
			produces = {"application/text; charset=utf-8" })
	public ResponseEntity<String> priceUpdate(@RequestBody PriceVO vo) {
//		ResponseEntity : 클라이언트에게 HTTP요청을 받은 뒤 처리한 코드를 본문에 넣고, 헤더와 상태코드를 추가하고 이들을 더 세밀하게
// 조작할 수 있는 객체이다. 본문을 JSON,XML , 등의 특정 데이터 형식만으로도 받을 수 있고, 호환문제가 적어 비동기 통신에 사용된다.
		
		int result = service.priceUpdate(vo);
		//ResponseEntity로 보낼 응답 본문에 넣을 
		
		log.info("PriceController.priceUpdate()---------------");
		
		return new ResponseEntity<>("가격 수정 성공!" , HttpStatus.OK);
		
	}
	
	@DeleteMapping(value = "/delete.do", consumes = "application/json",
			produces = {"application/text; charset=utf-8" })
	public ResponseEntity<String> priceDelete(@RequestBody PriceVO vo) {
//		ResponseEntity : 클라이언트에게 HTTP요청을 받은 뒤 처리한 코드를 본문에 넣고, 헤더와 상태코드를 추가하고 이들을 더 세밀하게
// 조작할 수 있는 객체이다. 본문을 JSON,XML , 등의 특정 데이터 형식만으로도 받을 수 있고, 호환문제가 적어 비동기 통신에 사용된다.
		
		int result = service.priceDelete(vo);
		//ResponseEntity로 보낼 응답 본문에 넣을 
		
		log.info("PriceController.priceDelete()---------------");
		
		return new ResponseEntity<>("가격 삭제 성공!" , HttpStatus.OK);
		
	}
	
	
	
}
