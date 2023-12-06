package kr.co.ezen.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.PageCre;
import kr.co.ezen.entity.Tr;
import kr.co.ezen.entity.TrComment;
import kr.co.ezen.service.TrService;

@Controller
@RequestMapping("/tr/*")
public class TrController {
	
	@Autowired
	private TrService trService;
	
	@RequestMapping("/main")
	public String main(Model m,Criteria cri) {
		if(cri.getKeyword()==null) {
			cri.setKeyword("");
		}
		
		List<Tr> li = trService.findAll(cri);
		
		m.addAttribute("li", li);
		m.addAttribute("cri", cri);
		
		PageCre pageCre = new PageCre();
	      pageCre.setCri(cri); //PageCre의 Criteria cri 필드에 매개변수 cri 넣음
	      pageCre.setTotalCount(trService.totalCount(cri)); //int 총 게시글 수

	      m.addAttribute("pageCre", pageCre);
		return "tr/main";
	}
	
	
	@GetMapping("/detail")
	public String detail(@RequestParam("tr_idx") int tr_idx, Model m) {
		//게시글조회
		
		Tr vo = trService.findByIdx(tr_idx);
		List<TrComment> cvo = trService.findAllComment(tr_idx);
		
		m.addAttribute("vo",vo);
		m.addAttribute("cvo",cvo);		
		
		return "tr/detail";
	}
	
	
	@GetMapping("/write")
	public String write() {
		//게시글작성화면
		
		return "tr/write";
	}
	
	@PostMapping("/delete")
	public String delete(@RequestParam("tr_idx") int tr_idx) {
		//삭제 버튼 눌렀을때 정말 삭제하시겠습니까?띄우고 확인 누르면 /delete로 이동
		
		//tr_idx로 글 삭제
		
		//tr_idx로 댓글들 삭제
		trService.deleteByIdx(tr_idx);
		
		return "redirect:/tr/main";
	}
	
	
	//--------------------------------------------------------
	
}
