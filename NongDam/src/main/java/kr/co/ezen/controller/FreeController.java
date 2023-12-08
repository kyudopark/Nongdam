package kr.co.ezen.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.mapper.FreeMapper;
import kr.co.ezen.service.FreeService;


@Controller
@RequestMapping("/free/*")	
public class FreeController {
	
	@Autowired
	FreeService freeservice;

	@RequestMapping("main")
	public String free(Model m, Criteria cre) {
		
		List<Free> li = freeservice.findAll(cre);
		
		m.addAttribute("li", li);
		m.addAttribute("cre", cre);
		
		return "free/main";
	}
	
	@GetMapping("modify") 
	public String checkinsert() {
		return "free/modify";
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam("free_idx") int gp_idx, Model m,
			@ModelAttribute("cri") Criteria cri) {
		//게시글조회
		
		  = .findByIdx(gp_idx);
		//List<GpUser> cvo = gpService.findByUser(gp_idx);
		
		m.addAttribute("vo", vo);
		//m.addAttribute("cvo", cvo);		
		
		return "gp/detail";
	}
	
	@GetMapping("get")
	public String freeContent(@RequestParam("idx") int idx, Model mo) {
		
		Free fre=freeservice.findByidx(idx);
		mo.addAttribute("fre",fre);
		return "free/detail";
		
	}
	
	@PostMapping("freinsert")
	public String insert(Free fr) {
		freeservice.insert(fr);
		return "redirect:ezen/free/main";
	}

}
