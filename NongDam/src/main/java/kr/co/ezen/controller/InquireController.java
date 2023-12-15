package kr.co.ezen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/inquire/*")
public class InquireController {

	@RequestMapping("/main")
	public String main() {	
		return "inquire/main";
	}
	
}
