package kr.co.ezen.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.entity.Info;
import kr.co.ezen.entity.PageCre;


import kr.co.ezen.service.InfoService;
@Controller
@RequestMapping("/info/*")
public class InfoController {
	
	@Autowired
	InfoService infoservice;

	@GetMapping("main")
	public String info(@RequestParam(required = false, value = "tag") String tag,
	                   Model m, Criteria cri,HttpSession session) {
	    if (cri.getKeyword() == null) {
	        cri.setKeyword("");
	    }

	    String url = "info/main?tag=" + tag;
	     

	    List<Info> li;
	    if (tag == null || tag.isEmpty()) {
	        li = infoservice.findAll(cri);
	    } else if (tag.equals("new")) {
	        li = infoservice.findnew(cri);
	    } else if (tag.equals("tenure")) {
	        li = infoservice.findtenure(cri);
	    } else {
	        return "";
	    }

	    m.addAttribute("cri", cri);
	    m.addAttribute("li", li);
	   

	    PageCre pageCre = new PageCre();
	    pageCre.setCri(cri);
	    pageCre.setTotalCount(infoservice.totalCount(cri));
	    m.addAttribute("pageCre", pageCre);

	    return "info/main";
	}	
	
	@RequestMapping("main/sort")
	public String main(@RequestParam(required = false, value = "tag") String tag,Model m, Criteria cri) {
		if (cri.getKeyword()==null) {
			cri.setKeyword(null);
			}
			
		String url = "info/main?tag=" + tag;
	     

	    List<Info> li;
	    if (tag == null || tag.isEmpty()) {
	        li = infoservice.findBycount(cri);
	    } else if (tag.equals("new")) {
	        li = infoservice.findBycountnew(cri);
	    } else if (tag.equals("tenure")) {
	        li = infoservice.findBycountenure(cri);
	    } else {
	        return "";
	    }
	    
	    m.addAttribute("cri", cri);
	    m.addAttribute("li", li);

	    PageCre pageCre = new PageCre();
	    pageCre.setCri(cri);
	    pageCre.setTotalCount(infoservice.totalCount(cri));
	    m.addAttribute("pageCre", pageCre);

	    return "info/main";
		    
		}
		//게시글조회
		@GetMapping("detail")
	public String detail(@RequestParam("info_idx") int info_idx, Model m, Criteria cre) {
		
		Info vo=infoservice.findByidx(info_idx);

		m.addAttribute("vo",vo);
		
		infoservice.updatecnt(info_idx);

		return "info/detail";
	}
	
		@GetMapping("write")
		public String write() {
		    return "info/write";
		}

		@GetMapping("insert")
		public String checkinsert() {
		    return "info/modify";
		}

		@PostMapping("/write")
		   public String write(@RequestParam("Info_imgpath") MultipartFile file, @RequestParam("Info_title") String Info_title,
		                       @RequestParam("user_idx" ) int user_idx, @RequestParam("Info_content") String Info_content,
		                       Model m,RedirectAttributes rttr, HttpServletRequest request) throws IOException {

		       String uploadPath = request.getServletContext().getRealPath("/resources/image/Info");

		       Info vo = new Info();
		       vo.setInfo_title(Info_title);
		       vo.setInfo_content(Info_content);
		       vo.setUser_idx(user_idx);
		   
		   
		       if (file != null && !file.isEmpty()) {
		           String originalFileName = file.getOriginalFilename();
		           String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
		           ext = ext.toUpperCase();

		           // 파일명 중복 처리
		           String fileName = originalFileName;
		           int count = 1;
		           while (new File(uploadPath + File.separator + fileName).exists()) {
		               String nameWithoutExtension = originalFileName.substring(0, originalFileName.lastIndexOf("."));
		               fileName = nameWithoutExtension + count + "." + ext;
		               count++;
		           }

		           // 파일 저장
		           String filePath = uploadPath + File.separator + fileName;
		           File dest = new File(filePath);
		           file.transferTo(dest);

		           // 데이터베이스에 필요한 정보 등록
		           vo.setInfo_imgpath(fileName);
		       }

		       infoservice.insert(vo);

		       return "redirect:/Info/main";
		       
		   }
		   
		@GetMapping("deleteByIdx")
		public String deleteByIdx(@RequestParam("info_idx") int info_idx, Criteria cri, RedirectAttributes rttr) {
		    infoservice.deleteByIdx(info_idx);
		    return "redirect:/info/main";
		}

		@GetMapping("modify")
		public String Modify(@RequestParam("info_idx") int info_idx, Model mo) {
		    Info vo = infoservice.findByidx(info_idx);
		    mo.addAttribute("vo", vo);
		    return "info/modify";
		}

		@PostMapping("/modify")
		public String modify(Info vo) {
		    infoservice.Modify(vo);
		    return "redirect:/info/main";
		}

		@PostMapping("/boomup")
		public String boomup(int info_idx) {
		    infoservice.updateLike(info_idx);
		    return "redirect:/info/detail";
		}
	
}
