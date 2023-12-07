package kr.co.ezen.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.service.FreeService;


@Controller
@RequestMapping("/free/*")	
public class FreeController {
	
	@Autowired
	FreeService freeservice;

	@RequestMapping("main")
	public String free(Model m, Criteria cre) {
		
		List<Free> li = freeservice.frelist(cre);
		
		m.addAttribute("li", li);
		m.addAttribute("cre", cre);
		
			return "free/main";
	}
	
	
}
