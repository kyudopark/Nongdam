package kr.co.ezen.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

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
		
		return "tr/write";
	}
	
	@PostMapping("/write")
	public String write(Tr vo,HttpServletRequest request, HttpSession session, RedirectAttributes rttr)
			throws IOException{ 
		MultipartRequest multi = null;
		int fileSize = 40 * 1024 * 1024; // 10MB
		String sPath = request.getRealPath("resources/image/tr");
		
		multi = new MultipartRequest(request, sPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
		
		String newPro="";
		File file = multi.getFile("tr_imgpath");
		if (file != null) {
			String ext = file.getName().substring(file.getName().lastIndexOf(".") + 1);
			ext = ext.toUpperCase();
			if (ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG")) {
				
			
			newPro=file.getName();
			}else {
				if(file.exists()) {
					file.delete();
				}
				return "redirect:/tr/write";
			}
		}
		vo.setTr_imgpath(newPro);
		trService.insert(vo);

		
		return "redirect:/tr/main";
				
	}
	
	@PostMapping("/delete")
	public String delete(@RequestParam("tr_idx") int tr_idx) {
		//삭제 버튼 눌렀을때 정말 삭제하시겠습니까?띄우고 확인 누르면 /delete로 이동
		
		//tr_idx로 글 삭제
		
		//tr_idx로 댓글들 삭제
		trService.deleteByIdx(tr_idx);
		
		return "redirect:/tr/main";
	}
	
	@GetMapping("/modify")
	public String modify(Model m,@RequestParam("tr_idx") int tr_idx) {
		
		
		Tr vo=trService.findByIdx(tr_idx);
		
		m.addAttribute("vo",vo);
		
		return "/tr/modify";
	}
	
	@PostMapping("/modify")
	public String modify(Tr vo) {
		
		trService.updateByIdx(vo);
		return "redirect:/tr/main";
	}
	
}