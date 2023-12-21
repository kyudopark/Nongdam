package kr.co.ezen.controller;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
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
		return "gp/write";
	}
	
	@PostMapping("/write")
	public String write(@RequestParam("thumbImg") MultipartFile file, @RequestParam("gp_title") String gp_title,
			@RequestParam("gp_price") String gp_price, @RequestParam("gp_content") String gp_content,
			@RequestParam("user_idx") String user_idx, @RequestParam("gp_date_start") String gp_date_start,
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
	        vo.setGp_thumb(fileName);
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
			@RequestParam("user_idx") String user_idx, @RequestParam("gp_date_start") String gp_date_start,
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
	        String originalFileName = file.getOriginalFilename();
	        String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1).toUpperCase();

	        // 파일명 중복 처리
	        String fileName = originalFileName;
	        int count = 1;
	        String uploadPath = request.getServletContext().getRealPath("/resources/image/gp");
	        String filePath = uploadPath + File.separator + fileName;
	        File dest = new File(filePath);
	        while (dest.exists()) {
	            String nameWithoutExtension = originalFileName.substring(0, originalFileName.lastIndexOf("."));
	            fileName = nameWithoutExtension + count + "." + ext;
	            filePath = uploadPath + File.separator + fileName;
	            dest = new File(filePath);
	            count++;
	        }

	        // 파일 저장
	        file.transferTo(dest);

	        // DB에 필요한 정보 업데이트
	        vo.setGp_thumb(fileName);
	    } else {
	        // 파일이 비어있으면 기존 이미지 경로를 유지
	        vo.setGp_thumb(existingThumbnail);
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
	public void communityImageUpload(HttpServletRequest req, HttpServletResponse resp,
			MultipartHttpServletRequest multiFile) throws Exception {
		JsonObject jsonObject = new JsonObject();
		PrintWriter printWriter = null;
		OutputStream out = null;
		MultipartFile file = multiFile.getFile("upload");

		if (file != null) {
			if (file.getSize() > 0 && StringUtils.isNotBlank(file.getName())) {
				if (file.getContentType().toLowerCase().startsWith("image/")) {
					try {

						String fileName = file.getOriginalFilename();
						byte[] bytes = file.getBytes();

						String uploadPath = req.getSession().getServletContext().getRealPath("/resources/image/gp");
						System.out.println("uploadPath: " + uploadPath);

						File uploadFile = new File(uploadPath);
						if (!uploadFile.exists()) {
							uploadFile.mkdir();
						}
						String fileName2 = UUID.randomUUID().toString();
						uploadPath = uploadPath + "/" + fileName2 + fileName;

						out = new FileOutputStream(new File(uploadPath));
						out.write(bytes);

						printWriter = resp.getWriter();
						String fileUrl = req.getContextPath() + "/resources/image/gp/" + fileName2 + fileName; // url경로

						System.out.println("fileUrl :" + fileUrl);

						JsonObject json = new JsonObject();
						json.addProperty("uploaded", 1);
						json.addProperty("fileName", fileName);
						json.addProperty("url", req.getContextPath() + "/resources/image/gp/" + fileName2 + fileName); // 파일명
																														// 변경한
																														// URL로
																														// 설정
						printWriter.print(json);
						System.out.println(json);

					} catch (IOException e) {
						e.printStackTrace();
						// 파일 업로드 실패 시 에러 응답
						JsonObject errorJson = new JsonObject();
						errorJson.addProperty("uploaded", 0);
						errorJson.addProperty("error", "파일 업로드에 실패했습니다.");
						printWriter.print(errorJson);
					} finally {
						// IO 자원 관리 - 닫아주기
						if (out != null) {
							out.close();
						}
						if (printWriter != null) {
							printWriter.close();
						}
					}
				}

			}

		}
	}
	
}
