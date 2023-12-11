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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	public String write(HttpServletRequest request, 
			HttpSession session, RedirectAttributes rttr) throws IOException {
		
		//멀티파트
		MultipartRequest multi = null;
		int fileSize = 40 * 1024 * 1024; // 10MB
		String sPath = request.getRealPath("resources/image/tr"); 
		
		multi = new MultipartRequest(request, sPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
		      
         
		// 데이터베이스 테이블에 회원이미지를 업데이트
		String tr_title = multi.getParameter("tr_title");
		String user_idx = multi.getParameter("user_idx");
		String tr_content = multi.getParameter("tr_content");
		String newPro="";
		File file=multi.getFile("tr_imgpath"); 
		if(file !=null) { 
		   String ext=file.getName().substring(file.getName().lastIndexOf(".")+1);
		   ext=ext.toUpperCase(); 
			if(ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG")){
			   
			   newPro=file.getName();
			   
			}else {
				if(file.exists()) {
					file.delete(); 
				}
			   return "redirect:/tr/write";
		    }
		 }
		 //이미지를 db에 업데이트
		 Tr vo=new Tr();
		 vo.setTr_title(tr_title);
		 vo.setTr_content(tr_content);
		vo.setUser_idx(user_idx);
		 vo.setTr_imgpath(newPro);
		
		 trService.insert(vo);

		return "redirect:/tr/main";
	}
	
	


	@GetMapping("/modify")
	public String modify(Model m,@RequestParam("tr_idx") int tr_idx) {
		
		Tr vo=trService.findByIdx(tr_idx);
		m.addAttribute("vo",vo);
		return "/tr/modify";
	}
	
	@PostMapping("/modify")
	public String modify(HttpServletRequest request, HttpSession session, RedirectAttributes rttr) throws IOException {

	    // 멀티파트
	    MultipartRequest multi = null;
	    int fileSize = 40 * 1024 * 1024; // 10MB
	    String sPath = request.getRealPath("resources/image/tr");

	    multi = new MultipartRequest(request, sPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());

	    // 데이터베이스 테이블에 회원이미지를 업데이트
	    String tr_idx_String = multi.getParameter("tr_idx");
	    int tr_idx = Integer.parseInt(tr_idx_String);
	    String tr_title = multi.getParameter("tr_title");
	    String tr_content = multi.getParameter("tr_content");
	    String newPro = "";
	    File file = multi.getFile("tr_imgpath");
	    if (file != null) {
	        String ext = file.getName().substring(file.getName().lastIndexOf(".") + 1);
	        ext = ext.toUpperCase();
	        if (ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG")) {
	            newPro = file.getName();
	        } else {
	            if (file.exists()) {
	                file.delete();
	            }
	            return "redirect:/tr/modify";
	        }
	    }

	    // 이미지 삭제
	    String existingImage = multi.getParameter("existing_image");
	    if (existingImage != null || !existingImage.isEmpty()) {
	        String imagePath = request.getServletContext().getRealPath("resources/image/tr/") + existingImage;
	        File existingFile = new File(imagePath);
	        if (existingFile.exists()) {
	            if (existingFile.delete()) {
	                System.out.println("기존 파일 삭제 성공");
	            } else {
	                System.out.println("기존 파일 삭제 실패");
	            }
	        } else {
	            System.out.println("존재하지 않는 파일입니다.");
	        }
	    }

	    // 이미지를 DB에 업데이트
	    Tr vo = new Tr();
	    vo.setTr_idx(tr_idx);
	    vo.setTr_title(tr_title);
	    vo.setTr_content(tr_content);
	    vo.setTr_imgpath(newPro);
	    trService.updateByIdx(vo);

	    return "redirect:/tr/main";
	}
	
	
	//--------------------------------------------------------


	//231206
	@PostMapping("/insertComment")
	public @ResponseBody void insertComment(TrComment cvo) {
		trService.insertComment(cvo);
	}
	@GetMapping("/getComment")
	public @ResponseBody List<TrComment> getComment(int tr_idx){
		List<TrComment> cvo = trService.findAllComment(tr_idx);
		return cvo;
	}
	@PostMapping("/deleteByIdx")
	public @ResponseBody void deleteByIdx(int tr_idx) {
		trService.deleteByIdx(tr_idx);
		trService.deleteCommentByTr_idx(tr_idx);
	}	
	@PostMapping("/deleteCommentByIdx")
	public @ResponseBody void deleteCommentByIdx(int tr_comment_idx) {
		trService.deleteCommentByIdx(tr_comment_idx);
	}
	@PostMapping("/insertReplyComment")
	public @ResponseBody void insertReplyComment(TrComment vo) {
		trService.insertReplyComment(vo);
	}
	//231207
	@PostMapping("/updateComment")
	public @ResponseBody void updateComment(TrComment cvo) {
		trService.updateCommentByIdx(cvo);
	}
	
	
}



