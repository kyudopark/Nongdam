package kr.co.ezen.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.entity.FreeComment;
import kr.co.ezen.entity.FreeHeart;
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
	public String free(@RequestParam(required = false, value = "tag") String tag,
	                   Model m, Criteria cri, HttpSession session) {
	    if (cri.getKeyword() == null) {
	        cri.setKeyword("");
	    }

	    String url = "free/main?tag=" + tag;
	     
	    List<Free> li;
	    if (tag == null || tag.isEmpty()) {
	        li = freeservice.findAll(cri);
	    } else if (tag.equals("free")) {
	        li = freeservice.findfr(cri);
	    } else if (tag.equals("question")) {
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
	
	@RequestMapping("main/sort")
		public String main(@RequestParam(required = false, value = "tag") String tag,Model m, Criteria cri) {
			if (cri.getKeyword()==null) {
				cri.setKeyword(null);
				}
				
			String url = "free/main?tag=" + tag;
		     

		    List<Free> li;
		    if (tag == null || tag.isEmpty()) {
		        li = freeservice.findBycount(cri);
		    } else if (tag.equals("free")) {
		        li = freeservice.findBycountfr(cri);
		    } else if (tag.equals("question")) {
		        li = freeservice.findBycountqu(cri);
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
		
		@GetMapping("write")
		public String write() {
		    return "free/write";
		}


		@PostMapping("/write")
		public String write(Free fr, @RequestParam(required = false) Integer user_idx) {
		    fr.setUser_idx(user_idx); // Free 객체에 user_idx 값을 설정해줘야 함
		    freeservice.insert(fr);
		    return "redirect:/free/main";
		}	

		@GetMapping("deleteByIdx")
		public String deleteByIdx(@RequestParam("free_idx") int free_idx, Criteria cri, RedirectAttributes rttr) {
		    freeservice.deleteByIdx(free_idx);
		    freeservice.deleteCommentByFree_idx(free_idx);
		    return "redirect:/free/main";
		}

		@GetMapping("modify")
		public String Modify(@RequestParam("free_idx") int free_idx, Model mo) {
		    Free vo = freeservice.findByidx(free_idx);
		    mo.addAttribute("vo", vo);
		    return "free/modify";
		}

		@PostMapping("/modify")
		public String modify(Free vo) {
		    freeservice.Modify(vo);
		    return "redirect:/free/main";
		}
		

		
	//======================================

	// 231206 ---> 240102 댓글 tr에서 free로 넘기는작업
	@PostMapping("/insertComment")
	public @ResponseBody void insertComment(FreeComment cvo) {
		freeservice.insertComment(cvo);
	}

	@GetMapping("/getComment")
	public @ResponseBody List<FreeComment> getComment(int free_idx) {
		List<FreeComment> cvo = freeservice.findAllComment(free_idx);
		return cvo;
	}

	@PostMapping("/deleteByIdx")
	public @ResponseBody void deleteByIdx(int free_idx) {
		freeservice.deleteByIdx(free_idx);
		freeservice.deleteCommentByFree_idx(free_idx);
	}

	@PostMapping("/deleteCommentByIdx")
	public @ResponseBody void deleteCommentByIdx(int free_comment_idx) {
		freeservice.deleteCommentByIdx(free_comment_idx);
	}

	@PostMapping("/insertReplyComment")
	public @ResponseBody void insertReplyComment(FreeComment vo) {
		freeservice.insertReplyComment(vo);
	}

	@PostMapping("/updateComment")
	public @ResponseBody void updateComment(FreeComment cvo) {
		freeservice.updateCommentByIdx(cvo);
	}
	//========================================================
}

