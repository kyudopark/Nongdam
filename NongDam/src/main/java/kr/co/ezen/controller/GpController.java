package kr.co.ezen.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Gp;
import kr.co.ezen.entity.GpUser;
import kr.co.ezen.entity.PageCre;
import kr.co.ezen.service.GpService;

@Controller
@RequestMapping("/gp/*")
public class GpController {
	
	@Autowired
	private GpService gpService;
	
	@RequestMapping("/main")
	public String main(Model m, Criteria cri) {
		if(cri.getKeyword()==null) {
			cri.setKeyword("");
		}
		
		List<Gp> li = gpService.findAll(cri);
		
		m.addAttribute("li", li);
		m.addAttribute("cri", cri);
		
		PageCre pageCre = new PageCre();
	      pageCre.setCri(cri);
	      pageCre.setTotalCount(gpService.totalCount(cri));

	      m.addAttribute("pageCre", pageCre);
		return "gp/main";
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam("gp_idx") int gp_idx, Model m,
			@ModelAttribute("cri") Criteria cri) {
		//게시글조회
		
		Gp vo = gpService.findByIdx(gp_idx);
		//List<GpUser> cvo = gpService.findByUser(gp_idx);
		
		m.addAttribute("vo", vo);
		//m.addAttribute("cvo", cvo);		
		
		return "gp/detail";
	}
	
	@GetMapping("/write")
	public String write() {
		//게시글작성화면
		return "gp/write";
	}
	
	@PostMapping("/write")
	public String write(Gp vo, HttpSession session, HttpServletRequest request, RedirectAttributes rttr) throws IOException, ParseException {
		
		MultipartRequest multi = null;
		int fileSize = 40 * 1024 * 1024;
		String sPath = request.getRealPath("resources/image/gp"); 
		multi = new MultipartRequest(request, sPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		String gp_title = multi.getParameter("gp_title");
		String gp_price = multi.getParameter("gp_price");
		String gp_content = multi.getParameter("gp_content");
		String user_idx = multi.getParameter("user_idx");
		
		Date gp_date_start = formatter.parse(multi.getParameter("gp_date_start"));
		Date gp_date_last = formatter.parse(multi.getParameter("gp_date_last"));
		
		
		String thumb="";
		File file = multi.getFile("thumbImg");
		if (file != null) {
			
			String ext = file.getName().substring(file.getName().lastIndexOf(".") + 1);
			ext = ext.toUpperCase();
			if (ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG")) {
			
				thumb=file.getName();
			} else {
				if(file.exists()) {
					file.delete();
				}
				return "redirect:/gp/write";
			}
		}
		
		vo.setUser_idx(user_idx);
		vo.setGp_title(gp_title);
		vo.setGp_date_start(gp_date_start);
		vo.setGp_date_last(gp_date_last);
		vo.setGp_content(gp_content);
		vo.setGp_price(gp_price);
		vo.setGp_thumb(thumb);
		gpService.insert(vo);
		return "redirect:/gp/main";
	}
	
	@GetMapping("/request")
	public String request(@RequestParam("gp_idx") int gp_idx, Model m) {
		Gp vo = gpService.findByIdx(gp_idx);
		m.addAttribute("vo", vo);
		return "/gp/request";
	}
	
	@PostMapping("/request")
	public String request(GpUser gu, RedirectAttributes rttr){
		gpService.request(gu);
		return "redirect:/gp/main";
	}
	
	
	@GetMapping("/modify")
	public String modify(Model m,@RequestParam("gp_idx") int gp_idx) {
		Gp vo = gpService.findByIdx(gp_idx);
		m.addAttribute("vo",vo);
		return "/gp/modify";
	}
	
	@PostMapping("/modify")
	public String modify(Gp vo, HttpSession session, HttpServletRequest request) throws IOException, ParseException {
		MultipartRequest multi = null;
		int fileSize = 40 * 1024 * 1024;
		String sPath = request.getRealPath("resources/image/gp"); 
		multi = new MultipartRequest(request, sPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		String gp_title = multi.getParameter("gp_title");
		String gp_price = multi.getParameter("gp_price");
		String gp_content = multi.getParameter("gp_content");
		
		
		Date gp_date_start = formatter.parse(multi.getParameter("gp_date_start"));
		Date gp_date_last = formatter.parse(multi.getParameter("gp_date_last"));
		String thumb="";
		File file = multi.getFile("thumbImg");
		if (file != null) {
			
			String ext = file.getName().substring(file.getName().lastIndexOf(".") + 1);
			ext = ext.toUpperCase();
			if (ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG")) {
			
				thumb=file.getName();
			} else {
				if(file.exists()) {
					file.delete();
				}
				return "redirect:/gp/write";
			}
		}
		vo.setGp_title(gp_title);
		vo.setGp_date_start(gp_date_start);
		vo.setGp_date_last(gp_date_last);
		vo.setGp_content(gp_content);
		vo.setGp_price(gp_price);
		vo.setGp_thumb(thumb);
		gpService.updateByIdx(vo);
		return "redirect:/gp/main";
	}
	
	@GetMapping("/deleteByIdx")
	public String deleteByIdx(@RequestParam("gp_idx") int gp_idx, Criteria cri, RedirectAttributes rttr) {
		gpService.deleteByIdx(gp_idx);
		return "redirect:/gp/main";
	}
	
}
