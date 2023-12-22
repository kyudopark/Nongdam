package kr.co.ezen.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
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
	public String main(Model m, Criteria cri) {
		if (cri.getKeyword() == null) {
			cri.setKeyword("");
		}

		List<Tr> li = trService.findAll(cri);

		m.addAttribute("li", li);
		m.addAttribute("cri", cri);

		PageCre pageCre = new PageCre();
		pageCre.setCri(cri); // PageCre의 Criteria cri 필드에 매개변수 cri 넣음
		pageCre.setTotalCount(trService.totalCount(cri)); // int 총 게시글 수

		m.addAttribute("pageCre", pageCre);
		return "tr/main";
	}

	@GetMapping("/detail")
	public String detail(@RequestParam("tr_idx") int tr_idx, Model m, Criteria cri) {
		// 게시글조회

		Tr vo = trService.findByIdx(tr_idx);
		List<TrComment> cvo = trService.findAllComment(tr_idx);

		m.addAttribute("vo", vo);
		m.addAttribute("cvo", cvo);
		m.addAttribute("cri",cri);

		return "tr/detail";
	}

	@GetMapping("/write")
	public String write() {

		return "tr/write";
	}

	@PostMapping("/write")
	public String write(@RequestParam("tr_imgpath") MultipartFile file, @RequestParam("tr_title") String tr_title,
	                    @RequestParam("user_idx") String user_idx, @RequestParam("tr_content") String tr_content,
	                    Model m,RedirectAttributes rttr, HttpServletRequest request) throws IOException {

	    String uploadPath = request.getServletContext().getRealPath("/resources/image/tr");

	    Tr vo = new Tr();
	    vo.setTr_title(tr_title);
	    vo.setTr_content(tr_content);
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
	        vo.setTr_imgpath(fileName);
	    }

	    trService.insert(vo);

	    return "redirect:/tr/main";
	}

	@GetMapping("/modify")
	public String modify(Model m, @RequestParam("tr_idx") int tr_idx) {

		Tr vo = trService.findByIdx(tr_idx);
		m.addAttribute("vo", vo);
		return "/tr/modify";
	}

	@PostMapping("/modify")
	public String modify(@RequestParam("tr_imgpath") MultipartFile file, @RequestParam("tr_idx") int tr_idx,
	                     @RequestParam("tr_title") String tr_title, @RequestParam("tr_content") String tr_content,
	                     @RequestParam(value = "existing_image", required = false) String existingImage,
	                     HttpServletRequest request, RedirectAttributes rttr) throws IOException {

	    Tr existingTr = trService.findByIdx(tr_idx);
	    String existingThumbnail = existingTr.getTr_imgpath();

	    Tr vo = new Tr();
	    vo.setTr_idx(tr_idx);
	    vo.setTr_title(tr_title);
	    vo.setTr_content(tr_content);

	    // 기존 이미지 삭제 로직은 유지됩니다.
	    if (existingImage != null && !existingImage.isEmpty() && !file.isEmpty()) {
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

	    // 파일이 비어있지 않은 경우에만 업로드 진행
	    if (file != null && !file.isEmpty()) {
	        String originalFileName = file.getOriginalFilename();
	        String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1).toUpperCase();

	        // 파일명 중복 처리
	        String fileName = originalFileName;
	        int count = 1;
	        String uploadPath = request.getServletContext().getRealPath("/resources/image/tr");
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
	        vo.setTr_imgpath(fileName);
	    } else {
	        // 파일이 비어있으면 기존 이미지 경로를 유지
	        vo.setTr_imgpath(existingThumbnail);
	    }

	    trService.updateByIdx(vo);

	    return "redirect:/tr/main";
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

						String uploadPath = req.getSession().getServletContext().getRealPath("/resources/image/tr");
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
						String fileUrl = req.getContextPath() + "/resources/image/tr/" + fileName2 + fileName; // url경로

						System.out.println("fileUrl :" + fileUrl);

						JsonObject json = new JsonObject();
						json.addProperty("uploaded", 1);
						json.addProperty("fileName", fileName);
						json.addProperty("url", req.getContextPath() + "/resources/image/tr/" + fileName2 + fileName); // 파일명
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

	// --------------------------------------------------------

	// 231206
	@PostMapping("/insertComment")
	public @ResponseBody void insertComment(TrComment cvo) {
		trService.insertComment(cvo);
	}

	@GetMapping("/getComment")
	public @ResponseBody List<TrComment> getComment(int tr_idx) {
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

	// 231207
	@PostMapping("/updateComment")
	public @ResponseBody void updateComment(TrComment cvo) {
		trService.updateCommentByIdx(cvo);
	}

}
