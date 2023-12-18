package kr.co.ezen.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.ezen.entity.User;
import kr.co.ezen.mapper.UserMapper;



@Controller
@RequestMapping("/myPage")
public class myPageController {
	
	@Autowired
	UserMapper userMapper;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
    public String myPageMain() {
        
        return "myPage/main";
    }

    @RequestMapping(value = "/modify", method = RequestMethod.GET)
    public String myPageModify() {
        
        return "myPage/modify";
    }

    @RequestMapping(value = "/quit", method = RequestMethod.GET)
    public String myPageQuid() {
       
        return "myPage/quit";
    }
    
    @RequestMapping(value = "/gplist", method = RequestMethod.GET)
    public String myPagegplist() {
       
        return "myPage/gplist";
    }
	
    @RequestMapping("/userImageUpdate")
    public String userImageUpdate(@RequestParam("user_profile")MultipartFile file,@RequestParam("user_nickname")String user_nickname,HttpSession session, HttpServletRequest request)
          throws IOException {

       String uploadPath = request.getServletContext().getRealPath("/resources/image/myPage");
       User uvo = (User)session.getAttribute("uvo");
       
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
           uvo.setUser_profile(fileName);
       }
       
       userMapper.updateUserProfile(uvo);
       

       session.setAttribute("uvo", uvo);
      

       return "redirect:/myPage/main";
    }
    
    
}
