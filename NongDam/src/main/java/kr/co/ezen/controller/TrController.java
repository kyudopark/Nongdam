package kr.co.ezen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/tr/*")
public class TrController {

	@RequestMapping("/main")
	public String main() {
		return "tr/test";
	}
	
}
