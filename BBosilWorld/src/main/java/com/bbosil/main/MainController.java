package com.bbosil.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/main")
public class MainController {

	
	@GetMapping("/main")
	public String main() {
		
		
		return "main/main";
	}
}
