package kr.co.ezen.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.ezen.entity.Gp;
import kr.co.ezen.entity.Info;
import kr.co.ezen.entity.Tr;
import kr.co.ezen.service.MainService;

/* 231205
 * 기본적으로 세팅되어있습니다.
 * 이 클래스는 수정하지 말아주세요.
 * */

@Controller
public class HomeController {
	
	@Autowired
	private MainService mainservice;
	

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model m) {	
		List<Tr> trlist = mainservice.findTr();
		List<Gp> gplist = mainservice.findGp();
		m.addAttribute("trlist", trlist);
		m.addAttribute("gplist", gplist);
		
		
		Info infolist = mainservice.findInfo();
		if(infolist != null) {
			String getInfo_content = infolist.getInfo_content();
			getInfo_content = getInfo_content.replaceAll("<(/)?([a-zA-Z]*)([0-9]?)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
			if(getInfo_content.length() > 250) {
				getInfo_content = getInfo_content.substring(0, 250);
			}
			infolist.setInfo_content(getInfo_content);
		}
		m.addAttribute("infolist", infolist);
		
		
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
