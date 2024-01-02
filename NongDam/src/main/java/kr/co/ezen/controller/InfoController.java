package kr.co.ezen.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
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
import com.google.gson.JsonObject;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.entity.Imgur;
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
		   public String write(MultipartFile file, @RequestParam("info_title") String info_title,
		                       @RequestParam("user_idx" ) int user_idx, @RequestParam("info_content") String info_content,
		                       @RequestParam("info_tag") String info_tag,Model m,RedirectAttributes rttr, HttpServletRequest request) throws IOException {

		       String uploadPath = request.getServletContext().getRealPath("/resources/image/Info");

		       Info vo = new Info();
		       vo.setInfo_tag(info_tag);
		       vo.setInfo_title(info_title);
		       vo.setInfo_content(info_content);
		       vo.setUser_idx(user_idx);
		   

		       if (file != null && !file.isEmpty()) {
			    	String ckEditorFileName = file.getOriginalFilename();
			    	String ext = ckEditorFileName.substring(ckEditorFileName.lastIndexOf(".") + 1).toUpperCase();
			    	
			    	

			    	// 썸네일 이미지 업로드
			    	Imgur imgur = new Imgur();		                                                                              // 서비스 호출 및 URL

			    	// 데이터베이스에 필요한 정보 등록

			    	// 원본 이미지 저장
			    	String ckEditorFileNameWithoutExt = ckEditorFileName.substring(0, ckEditorFileName.lastIndexOf("."));
			    	String ckEditorImageFileName = ckEditorFileNameWithoutExt + "_original." + ext;
			    	String ckEditorFilePath = uploadPath + File.separator + ckEditorImageFileName;
			    	File ckEditorDest = new File(ckEditorFilePath);
			    	file.transferTo(ckEditorDest);

			    	// 원본 이미지 업로드
			    	String ckEditorImageUrl = imgur.requestUpload(Files.readAllBytes(ckEditorDest.toPath())); // 원본 이미지 업로드 서비스

			    }
		       infoservice.insert(vo);

		       return "redirect:/info/main";
		       
		   }
		
		
		 @ResponseBody
		   @RequestMapping(value = "fileupload.do")
		   public String communityImageUpload(@RequestParam("upload") MultipartFile upload) {
		      JsonObject jsonObject = new JsonObject();

		      try {
		         if (upload != null && !upload.isEmpty() && upload.getContentType().toLowerCase().startsWith("image/")) {
		            Imgur imgurUploader = new Imgur();
		            byte[] bytes = upload.getBytes();

		            // 이미지를 imgur에 업로드하고 URL 받아오기
		            String imageUrl = imgurUploader.requestUpload(bytes);

		            // CKEditor에 이미지 URL 반환
		            jsonObject.addProperty("uploaded", 1);
		            jsonObject.addProperty("url", imageUrl);
		         }
		      } catch (Exception e) {
		         e.printStackTrace();
		         // 업로드 실패 시 오류 반환
		         jsonObject.addProperty("uploaded", 0);
		         jsonObject.addProperty("error", "Failed to upload image");
		      }

		      return jsonObject.toString();
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
		public String modify(MultipartFile file, @RequestParam("info_title") String info_title,
		                     @RequestParam("info_idx") int info_idx, @RequestParam("info_content") String info_content,
		                     @RequestParam("info_tag") String info_tag,Model m, RedirectAttributes rttr, HttpServletRequest request) throws IOException {

		    String uploadPath = request.getServletContext().getRealPath("/resources/image/Info");

		    Info vo = infoservice.findByidx(info_idx); // user_idx를 기준으로 정보 조회
		    
		    vo.setInfo_tag(info_tag);
		    vo.setInfo_idx(info_idx);
		    vo.setInfo_title(info_title);
		    vo.setInfo_content(info_content);
		    
			rttr.addAttribute("info_idx", info_idx);

		    if (file != null && !file.isEmpty()) {
		        String ckEditorFileName = file.getOriginalFilename();
		        String ext = ckEditorFileName.substring(ckEditorFileName.lastIndexOf(".") + 1).toUpperCase();

		        // 썸네일 이미지 업로드
		        Imgur imgur = new Imgur();
		        String ckEditorImageUrl = null; // 원본 이미지 업로드 URL 초기화

		        // 원본 이미지 저장
		        String ckEditorFileNameWithoutExt = ckEditorFileName.substring(0, ckEditorFileName.lastIndexOf("."));
		        String ckEditorImageFileName = ckEditorFileNameWithoutExt + "_original." + ext;
		        String ckEditorFilePath = uploadPath + File.separator + ckEditorImageFileName;
		        File ckEditorDest = new File(ckEditorFilePath);
		        file.transferTo(ckEditorDest);

		        // 원본 이미지 업로드
		        ckEditorImageUrl = imgur.requestUpload(Files.readAllBytes(ckEditorDest.toPath())); // 원본 이미지 업로드 서비스

		        // 수정된 이미지 URL 등록
		    }

		    infoservice.updateByIdx(vo);

		    return "redirect:/info/detail";
		}
}