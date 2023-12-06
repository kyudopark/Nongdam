package kr.co.ezen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/* 231205
 * 기본적으로 세팅되어있습니다.
 * 이 클래스는 수정하지 말아주세요.
 * */

@Controller
public class HomeController {
	

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {	
		return "main";
	}
	
	
	//아래는 단순 리다이렉트. 특별한 일이 없다면 수정하지 말아주세요.
	//ABC기준 정렬
	@RequestMapping("/admin")
	public String admin() {
		return "redirect:/admin/main";
	}
	@RequestMapping("/chat")
	public String chat() {
		return "redirect:/chat/main";
	}
	@RequestMapping("/free")
	public String free() {
		return "redirect:/free/main";
	}
	@RequestMapping("/gp")
	public String gp() {
		return "redirect:/gp/main";
	}
	@RequestMapping("info")
	public String info() {
		return "redirect:/info/main";
	}
	@RequestMapping("/myPage")
	public String myPage() {
		return "redirect:/myPage/main";
	}
	@RequestMapping("/tr")
	public String tr() {
		return "redirect:/tr/main";
	}
	
}
