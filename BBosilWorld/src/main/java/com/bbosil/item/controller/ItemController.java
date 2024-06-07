package com.bbosil.item.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bbosil.item.service.ItemService;
import com.bbosil.item.service.OptionService;
import com.bbosil.item.util.ItemPageObject;
import com.bbosil.item.vo.ItemVO;
import com.webjjang.util.file.FileUtil;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/item")
public class ItemController {

	@Inject
	@Qualifier("itemServiceImpl")
	private ItemService service;
	
	@Inject
	@Qualifier("optionServiceImpl")
	private OptionService optionService;
	
	private String path = "/resources/upload/item";
	
	@GetMapping("/list.do")
	public String list(Model model, HttpServletRequest request) throws Exception {
		log.info("itemController.()list----------");
		
		ItemPageObject pageObject = ItemPageObject.getInstance(request);
		//페이징처리와 현재 페이지, 최초페이지 최종페이지 구분을 위한 객체 pageObject를 getInstance()를 통해 생성한다.
		
		if(pageObject.getPerPageNum() == 10) pageObject.setPerPageNum(8);
		
		model.addAttribute("pageObject", pageObject);
		model.addAttribute("list", service.list(pageObject));
		//서비스 객체를 통해 list 데이터를  DB에서 가져오는 Mapper를 실행한다. 그후  그 데이터를 list라는 키로 저장해서 view 쪽으로 넘긴다.
		
		//사용자가 최종적으로 이동할 url을 반환한다.
		return "item/list";
	}
	
	@GetMapping("/view.do")
	public String view(Model model, HttpServletRequest request , long no, long inc) throws Exception {
		log.info("itemController.()view----------");
		
		PageObject pageObject = PageObject.getInstance(request);
		//page,perPageNumber,key,word파라미터를 저장하는 pageObject를 getInstance()를 통해 생성한다.
		
		
		
		
		model.addAttribute("distinctType", optionService.distincType(no));
		//상품이 가진 옵션종류를 중복값없이 가져온다.
		
		model.addAttribute("option", optionService.list(no));
		//상품이 가지고있는 옵션의 상세정보를 가져온다.
		
		model.addAttribute("optionValue", optionService.valueList());
		//이미 등록되있는 모든 옵션값들을 가져온다.
		
		model.addAttribute("optionType", optionService.typeList());
		//이미 등록되있는 모든 옵션종류를 가져온다.
		
		model.addAttribute("pageObject", pageObject);
		model.addAttribute("vo", service.view(no, inc));
		//서비스 객체를 통해 list 데이터를  DB에서 가져오는 Mapper를 실행한다. 그후  그 데이터를 list라는 키로 저장해서 view 쪽으로 넘긴다.
		
		//사용자가 최종적으로 이동할 url을 반환한다.
		return "item/view";
	}
	
	
	
	@GetMapping("/write.do")
	public String writeForm() throws Exception {
		log.info("itemController.()writeForm----------");
		
		//사용자가 최종적으로 이동할 url을 반환한다.
		return "item/write";
	}
	
	@PostMapping("/write.do")
	public String write(ItemVO vo, HttpServletRequest request) throws Exception {
		log.info("itemController.()write----------");
		
		String fileName = FileUtil.upload(path, vo.getImageFile(), request);
		//입력받은 파일데이터를 서버에 등록한뒤 파일의 이름을 변수에 저장한다.
		
		vo.setItemImage(fileName);
		
		int result = service.write(vo);
		//DAO(myBatis)에서 DB 조작 성공시 결과값이 1이 나온다.
		
		if(result != 1) {
			FileUtil.remove(FileUtil.getRealPath("", fileName, request));
		}
		//DB sql 실행 결과가 실패했으면 서버에 올린 파일을 지운다.
		
		//사용자가 최종적으로 이동할 url을 반환한다.
		return "redirect:list.do";
	}
	
	@GetMapping("/update.do")
	public String updateForm(Model model, long no) throws Exception {
		log.info("itemController.()updateForm----------");
		
		model.addAttribute("vo" , service.view(no, 0));
		
		//사용자가 최종적으로 이동할 url을 반환한다.
		return "item/update";
	}
	
	@PostMapping("/update.do")
	public String update(ItemVO vo, HttpServletRequest request , String deleteFile,
			PageObject pageObject) throws Exception {
		log.info("itemController.()update----------");
		
		String fileName = FileUtil.upload(path, vo.getImageFile(), request);
		//입력받은 파일데이터를 서버에 등록한뒤 파일의 이름을 변수에 저장한다.
		
		vo.setItemImage(fileName);
		
		log.info("내가확인할 itemName : " + vo.getItemName());
		
		int result = service.update(vo);
		//DAO(myBatis)에서 DB 조작 성공시 결과값이 1이 나온다.
		
		if(result != 1) {
			FileUtil.remove(FileUtil.getRealPath("", fileName, request));
			//DB 데이터 조작이 실패했을 경우에, 새로 올린 이미지 파일을 지운다.
		}else {
			FileUtil.remove(FileUtil.getRealPath("", deleteFile, request));
			//DB 데이터 조작이 성공했을 경우, 기존의 이미지 파일을 지운다.
		}

		
		//사용자가 최종적으로 이동할 url을 반환한다.
		return "redirect:view.do?no=" + vo.getItemNo() + "&inc=0&" + pageObject.getPageQuery();
	}
	
	
	@GetMapping("/delete.do")
	public String delete(Model model, long no, String deleteFile , HttpServletRequest request, 
			PageObject pageObject) throws Exception {
		log.info("itemController.()delete----------");
		
		int result = service.delete(no);
		
		if (result ==1) {
			FileUtil.remove(FileUtil.getRealPath("", deleteFile, request));
			//db정보가 삭제된 뒤에만 파일을 삭제한다.
		}
		
		//사용자가 최종적으로 이동할 url을 반환한다.
		return "redirect:list.do?" + pageObject.getPageQuery();
	}
	
}
