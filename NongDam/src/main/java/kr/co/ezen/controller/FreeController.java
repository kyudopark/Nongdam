package kr.co.ezen.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.entity.FreeComment;
import kr.co.ezen.entity.Gp;
import kr.co.ezen.entity.PageCre;
import kr.co.ezen.entity.TrComment;
import kr.co.ezen.mapper.FreeMapper;
import kr.co.ezen.service.FreeService;

@Controller
@RequestMapping("/free/*")	
public class FreeController {
	
	@Autowired
	FreeService freeservice;

	@GetMapping("main")
	public String free(Model m, Criteria cri) {
		
	    if (cri.getKeyword() == null) {
	        cri.setKeyword("");
	    }

	    String url = "free/main?type=" + cri.getType();

	    List<Free> li; // 자유게시판이냐 질문게시판이냐로 옮겨짐.
	    if (cri.getType() == null || cri.getType().isEmpty()) {
	        li = freeservice.findAll(cri);
	    } else if (cri.getType().equals("free")) {
	        li = freeservice.findfr(cri);
	    } else if (cri.getType().equals("question")) {
	        li = freeservice.findqu(cri);
	    } else {
	       
	        return ""; 
	    }

	    m.addAttribute("cri", cri);
	    m.addAttribute("li", li);

	    PageCre pageCre = new PageCre();
	    pageCre.setCri(cri);
	    pageCre.setTotalCount(freeservice.totalCount(cri));
	    m.addAttribute("pageCre", pageCre);

	    return "free/main";
	}	
	
	//게시글조회
		@GetMapping("detail")
	public String detail(@RequestParam("free_idx") int free_idx, Model m, Criteria cre) {
		
		Free vo=freeservice.findByidx(free_idx);
		List<FreeComment> dev = freeservice.findAllComment(free_idx);
		m.addAttribute("vo",vo);
		m.addAttribute("dev", dev);
		
		freeservice.updatecnt(free_idx);
		
		return "free/detail";
	}
	
	//게시글작성화면
	@GetMapping("write")
	public String write() {
		
		return "free/write";
	}
	
	@GetMapping("insert") 
	public String checkinsert() {
		return "free/modify";
	}
	
	
	@PostMapping("/write")
	public String write(Free fr) {
		freeservice.insert(fr);
		return "redirect:/free/main";	
	}
	
	
	@GetMapping("deleteByIdx")
	public String deleteByIdx(@RequestParam("free_idx") int free_idx, Criteria cri, RedirectAttributes rttr) {
		freeservice.deleteByIdx(free_idx);
		return "redirect:/free/main";
	}
	
	@GetMapping("modify")
	public String Modify(@RequestParam("free_idx") int free_idx, Model mo) {
		
		Free vo=freeservice.findByidx(free_idx);
		mo.addAttribute("vo", vo);
		
		return "free/modify";
	}
	
	@PostMapping("/modify")
	public String modify(Free vo) {
		freeservice.Modify(vo);
		return "redirect:/free/main";

	}

	//댓글 관련 controller
	
	@PostMapping("/insertComment")
	public @ResponseBody void insertComment(FreeComment comm) {
		freeservice.insertComment(comm);
		
	}	
	
	@GetMapping("/findAllComment")
	public @ResponseBody List<FreeComment> findAllComment(int free_idx){
		List<FreeComment> dev = freeservice.findAllComment(free_idx);
		System.out.println(dev);
		return dev;
		
	}
}

