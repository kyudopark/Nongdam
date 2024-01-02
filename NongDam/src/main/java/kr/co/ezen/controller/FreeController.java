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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.entity.FreeComment;
import kr.co.ezen.entity.Imgur;
import kr.co.ezen.entity.PageCre;
import kr.co.ezen.service.FreeService;

@Controller
@RequestMapping("/free/*")	
public class FreeController {
	
	@Autowired
	FreeService freeservice;

	@GetMapping("/main")
	public String free(Model m, Criteria cri) {
	    if (cri.getKeyword() == null) {
	        cri.setKeyword("");
	    }

	    List<Free> li = freeservice.findAll(cri);
	    
	    m.addAttribute("cri", cri);
	    m.addAttribute("li", li);
	   
	    PageCre pageCre = new PageCre();
	    pageCre.setCri(cri);
	    pageCre.setTotalCount(freeservice.totalCount(cri));
	    m.addAttribute("pageCre", pageCre);

	    return "free/main";
	}	
	
	@GetMapping("/write")
	public String writeget() {
		
		return "free/write";
	}
	
	@PostMapping("/write")
	public String write(MultipartFile file, @RequestParam("free_title") String free_title,
           @RequestParam("user_idx" ) int user_idx, @RequestParam("free_content") String free_content,
           @RequestParam("free_tag") String free_tag,Model m,RedirectAttributes rttr, HttpServletRequest request) throws IOException {

		String uploadPath = request.getServletContext().getRealPath("/resources/image/Info");

		Free vo = new Free();
		vo.setFree_tag(free_tag);
		vo.setFree_title(free_title);
		vo.setFree_content(free_content);
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
	    freeservice.insert(vo);
	    return "redirect:/free/main";
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
 
 
 
	@GetMapping("/modify")
	public String Modify(@RequestParam("free_idx") int free_idx, Model mo) {
	    Free vo = freeservice.findByidx(free_idx);
	    mo.addAttribute("vo", vo);
	    return "free/modify";
	}

	@PostMapping("/modify")
	public String modify(MultipartFile file,Free vo, @RequestParam("free_title") String free_title,
            @RequestParam("free_idx") int free_idx, @RequestParam("free_content") String free_content,
            @RequestParam("free_tag") String free_tag,Model m, RedirectAttributes rttr, HttpServletRequest request) throws IOException {
			
	    String uploadPath = request.getServletContext().getRealPath("/resources/image/Info");

		vo.setFree_idx(free_idx);
		vo.setFree_title(free_title);
		vo.setFree_content(free_content);
		vo.setFree_tag(free_tag);				
		rttr.addAttribute("free_idx", free_idx);
		
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
	        
		}
	    freeservice.updateByIdx(vo);
	    return "redirect:/free/detail";
	}
	
	@GetMapping("/detail")
	public String detail(int free_idx, Model m,Criteria cri) {
		
		Free vo = freeservice.findByidx(free_idx);
		m.addAttribute("vo", vo);
		freeservice.updatecnt(free_idx);
		m.addAttribute("cri",cri);
		
		return "free/detail";
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

