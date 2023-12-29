package kr.co.ezen.controller;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Gp;
import kr.co.ezen.entity.GpUser;
import kr.co.ezen.entity.Imgur;
import kr.co.ezen.entity.PageCre;
import kr.co.ezen.entity.Tr;
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
	public String detail(@RequestParam("gp_idx") int gp_idx, Model m, Criteria cri) {
		//게시글조회
		
		Gp vo = gpService.findByIdx(gp_idx);
		
		m.addAttribute("vo", vo);
		m.addAttribute("cri",cri);	
		
		return "gp/detail";
	}
	
	@GetMapping("/write")
	public String write() {
		return "gp/write";
	}
	
	@PostMapping("/write")
	public String write(@RequestParam("thumbImg") MultipartFile file, @RequestParam("gp_title") String gp_title,
			@RequestParam("gp_price") String gp_price, @RequestParam("gp_content") String gp_content,
			@RequestParam("user_idx") int user_idx, @RequestParam("gp_date_start") String gp_date_start,
			@RequestParam("gp_date_last") String gp_date_last,
			Gp vo, HttpSession session, HttpServletRequest request, RedirectAttributes rttr) throws IOException, ParseException {
		
		String uploadPath = request.getServletContext().getRealPath("/resources/image/gp");
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		vo.setUser_idx(user_idx);
		vo.setGp_title(gp_title);
		vo.setGp_date_start(formatter.parse(gp_date_start));
		vo.setGp_date_last(formatter.parse(gp_date_last));
		vo.setGp_content(gp_content);
		vo.setGp_price(gp_price);

		if (file != null && !file.isEmpty()) {
	    	String ckEditorFileName = file.getOriginalFilename();
	    	String ext = ckEditorFileName.substring(ckEditorFileName.lastIndexOf(".") + 1).toUpperCase();

	    	// 썸네일 파일 저장
	    	String thumbnailFileName = "thumbnail.png";
	    	String thumbnailFilePath = uploadPath + File.separator + thumbnailFileName;
	    	File thumbnailDest = new File(thumbnailFilePath);
	    	file.transferTo(thumbnailDest);

	    	// 썸네일 이미지 업로드
	    	Imgur imgur = new Imgur();
	    	String thumbnailImageUrl = imgur.requestUpload(Files.readAllBytes(thumbnailDest.toPath())); // 썸네일 이미지 업로드
                                                                              // 서비스 호출 및 URL

	    	// 데이터베이스에 필요한 정보 등록
	    	vo.setGp_thumb(thumbnailImageUrl);

	    	// 원본 이미지 저장
	    	String ckEditorFileNameWithoutExt = ckEditorFileName.substring(0, ckEditorFileName.lastIndexOf("."));
	    	String ckEditorImageFileName = ckEditorFileNameWithoutExt + "_original." + ext;
	    	String ckEditorFilePath = uploadPath + File.separator + ckEditorImageFileName;
	    	File ckEditorDest = new File(ckEditorFilePath);
	    	file.transferTo(ckEditorDest);

	    	// 원본 이미지 업로드
	    	String ckEditorImageUrl = imgur.requestUpload(Files.readAllBytes(ckEditorDest.toPath())); // 원본 이미지 업로드 서비스

	    }
		
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
	public String modify(@RequestParam("thumbImg") MultipartFile file, 
			@RequestParam("gp_title") String gp_title, @RequestParam("gp_idx") int gp_idx,
			@RequestParam("gp_price") String gp_price, @RequestParam("gp_content") String gp_content,
			@RequestParam("user_idx") int user_idx, @RequestParam("gp_date_start") String gp_date_start,
			@RequestParam("gp_date_last") String gp_date_last, @RequestParam(value = "existing_image", required = false) String existingImage,
			Gp vo, HttpSession session, HttpServletRequest request, RedirectAttributes rttr) throws IOException, ParseException {
		
		Gp existingTr = gpService.findByIdx(gp_idx);
		String existingThumbnail = existingTr.getGp_thumb();
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		vo.setUser_idx(user_idx);
		vo.setGp_title(gp_title);
		vo.setGp_date_start(formatter.parse(gp_date_start));
		vo.setGp_date_last(formatter.parse(gp_date_last));
		vo.setGp_content(gp_content);
		vo.setGp_price(gp_price);
		
		if (existingImage != null && !existingImage.isEmpty() && !file.isEmpty()) {
	        String imagePath = request.getServletContext().getRealPath("resources/image/gp/") + existingImage;
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
		
		// 파일이 비어있지 않은 경우에만 업로드 진행
		if (file != null && !file.isEmpty()) {
	    	   String ckEditorFileName = file.getOriginalFilename();
	           String ext = ckEditorFileName.substring(ckEditorFileName.lastIndexOf(".") + 1).toUpperCase();

	           // 썸네일 파일 저장
	           String thumbnailFileName = "thumbnail.png";
	           String thumbnailFilePath = request.getServletContext().getRealPath("/resources/image/tr") + File.separator + thumbnailFileName;
	           File thumbnailDest = new File(thumbnailFilePath);
	           file.transferTo(thumbnailDest);

	           // 썸네일 이미지 업로드
	           Imgur imgur = new Imgur();
	           String thumbnailImageUrl = imgur.requestUpload(Files.readAllBytes(thumbnailDest.toPath())); // 썸네일 이미지 업로드 서비스 호출 및 URL 받아오기

	           // 데이터베이스에 필요한 정보 등록
	           vo.setGp_thumb(thumbnailImageUrl); // 썸네일 이미지 URL을 vo에 설정


	           // 원본 이미지 저장
	           String ckEditorFileNameWithoutExt = ckEditorFileName.substring(0, ckEditorFileName.lastIndexOf("."));
	           String ckEditorImageFileName = ckEditorFileNameWithoutExt + "_original." + ext;
	           String ckEditorFilePath = request.getServletContext().getRealPath("/resources/image/tr") + File.separator + ckEditorImageFileName;
	           File ckEditorDest = new File(ckEditorFilePath);
	           file.transferTo(ckEditorDest);

	           // 원본 이미지 업로드
	           String ckEditorImageUrl = imgur.requestUpload(Files.readAllBytes(ckEditorDest.toPath())); // 원본 이미지 업로드 서비스 호출 및 URL 받아오기

	       }
		
		
		
		gpService.updateByIdx(vo);
		return "redirect:/gp/main";
	}
	
	@GetMapping("/deleteByIdx")
	public String deleteByIdx(@RequestParam("gp_idx") int gp_idx, Criteria cri, RedirectAttributes rttr) {
		gpService.deleteByIdx(gp_idx);
		return "redirect:/gp/main";
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
	
}
