package kr.co.ezen.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.PageCre;
import kr.co.ezen.entity.Tr;
import kr.co.ezen.service.TrService;

@Controller
@RequestMapping("/tr/*")
public class TrController {
	@Autowired
	private TrService TrService;
	
	@RequestMapping("/main")
	public String main(Model m,Criteria cri) {
		if(cri.getKeyword()==null) {
			cri.setKeyword("");
		}
		
		List<Tr> li = TrService.findAll(cri);
		
		
		m.addAttribute("li", li);
		m.addAttribute("cri", cri);
		
		PageCre pageCre = new PageCre();
	      pageCre.setCri(cri); //PageCre의 Criteria cri 필드에 매개변수 cri 넣음
	      pageCre.setTotalCount(TrService.totalCount(cri)); //int 총 게시글 수

	      m.addAttribute("pageCre", pageCre);
		return "tr/main";
	}
	
}
