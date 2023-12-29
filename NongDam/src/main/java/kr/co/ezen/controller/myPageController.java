package kr.co.ezen.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.ezen.entity.Gp;
import kr.co.ezen.entity.GpUser;
import kr.co.ezen.entity.Tr;

import kr.co.ezen.entity.User;
import kr.co.ezen.mapper.GpMapper;
import kr.co.ezen.mapper.UserMapper;
import kr.co.ezen.service.GpService;
import kr.co.ezen.service.MyPageService;



@Controller
@RequestMapping("/myPage/*")
public class myPageController {
	
	@Autowired
	MyPageService myPageService;
	
	@Autowired
	UserMapper userMapper;
	
	@Autowired
	GpService gpService;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String myPageMain(Model m, HttpSession session) {
	    
	    	User uvo = (User)session.getAttribute("uvo");
	    	int user_idx =uvo.getUser_idx();
	    	//테스트용
	    	session.setMaxInactiveInterval(900);
	    	List<Tr> li=myPageService.findByIdx(user_idx);
	        
	        m.addAttribute("li", li);
	        return "myPage/main";
	    
	}

    @RequestMapping(value = "/modify", method = RequestMethod.GET)
    public String myPageModify() {
        
        return "myPage/modify";
    }
    
    @RequestMapping(value = "/modify", method = RequestMethod.POST)
    public String myPageModi(@ModelAttribute User user, RedirectAttributes rttr, HttpSession session) {
        try {
            // myPageService.updateUserInfo 메서드가 예상대로 호출되고 있는지 확인
            System.out.println("Updating user information: " + user);

            // 정보 업데이트
            myPageService.updateUserInfo(user);

            // 업데이트 성공 메시지 설정
            rttr.addFlashAttribute("msgType", "success");
            rttr.addFlashAttribute("msg", "수정되었습니다.");

            // 세션에 업데이트된 사용자 정보 저장
            session.setAttribute("uvo", user);

            // 디버그용 메시지 출력
            System.out.println("User information updated successfully: " + user);

            // 리다이렉트
            return "redirect:/myPage/main";
        } catch (Exception e) {
            // 업데이트 실패 메시지 설정
            rttr.addFlashAttribute("msgType", "error");
            rttr.addFlashAttribute("msg", "수정 중 오류가 발생했습니다.");

            // 에러 로그 출력
            e.printStackTrace();

            // 에러 페이지로 리다이렉트 또는 에러 페이지를 보여줄 뷰 이름 반환
            return "redirect:/";
        }
    }
    @RequestMapping(value = "/quit", method = RequestMethod.GET)
    public String myPageQuid() {
       
        return "myPage/quit";
    }
    
    @RequestMapping(value = "/quit", method = RequestMethod.POST)
    public String myPageQuit(@RequestParam("user_pw") String user_pw, HttpSession session, RedirectAttributes rttr) {
    	
    	
    	
    	User uvo = (User)session.getAttribute("uvo");
    	int user_idx =uvo.getUser_idx();
    	
    	if (uvo != null) {
            String storedPassword = uvo.getUser_pw(); 

            
            if (user_pw.equals(storedPassword)) {

            	myPageService.deleteUserById(user_idx);
            	rttr.addFlashAttribute("msgType", "성공");
                rttr.addFlashAttribute("msg", "회원탈퇴 되었습니다.");
            	session.invalidate();

                return "redirect:/";
            } else {
                // 비밀번호가 일치하지 않을 경우, 에러 메시지를 추가하고 탈퇴 페이지로 리다이렉트
            	rttr.addFlashAttribute("msgType", "실패");
            	rttr.addFlashAttribute("msg", "입력하신 정보가 일치하지 않습니다.");
                return "redirect:/myPage/quit";
            }
        } else {
            
        	
            return "redirect:/";
        }
        
    }
    
    @RequestMapping(value = "/quit2", method = RequestMethod.POST)
    public String myPageQuit2(@RequestParam("user_name") String user_name, HttpSession session, RedirectAttributes rttr) {
    	
    	
    	
    	User uvo = (User)session.getAttribute("uvo");
    	int user_idx =uvo.getUser_idx();
    	
    	if (uvo != null) {
            String storedName = uvo.getUser_name(); 

            
            if (user_name.equals(storedName)) {

            	myPageService.deleteUserById(user_idx);
            	rttr.addFlashAttribute("msgType", "성공");
                rttr.addFlashAttribute("msg", "회원탈퇴 되었습니다.");
            	session.invalidate();

                return "redirect:/";
            } else {
                // 비밀번호가 일치하지 않을 경우, 에러 메시지를 추가하고 탈퇴 페이지로 리다이렉트
            	rttr.addFlashAttribute("msgType", "error");
                rttr.addFlashAttribute("msg", "입력하신 정보가 일치하지 않습니다.");
                return "redirect:/myPage/quit";
            }
        } else {
            return "redirect:/";
        }
        
    }
    
    @RequestMapping(value = "/gplist", method = RequestMethod.GET)
    public String myPagegplist(Model m, HttpSession session) {
    	User uvo = (User)session.getAttribute("uvo");
        int user_idx = uvo.getUser_idx();
        
        List<GpUser> gpUserList = gpService.findGpUserbyIdx(user_idx);
        

        for (GpUser gpUser : gpUserList) {
            int gp_idx = gpUser.getGp_idx();
            Gp gp = gpService.findByIdx(gp_idx);

            // Gp 객체가 null이 아닌 경우에만 속성 복사 수행
            if (gp != null) {
                // Gp 정보에서 필요한 속성들을 GpUser 객체에 추가
                gpUser.setGp_date_start(gp.getGp_date_start());
                gpUser.setGp_date_last(gp.getGp_date_last());
                gpUser.setGp_title(gp.getGp_title());
                gpUser.setGp_price(gp.getGp_price());
            }
        }

        m.addAttribute("gpUserList", gpUserList);
        
        return "myPage/gplist";
    }
    
    @RequestMapping(value = "/updateAddr", method = RequestMethod.POST)
    public String updateAddr(GpUser gpUser, @RequestParam("gp_zipcode") String gp_zipcode, @RequestParam("gp_addr") String gp_addr, 
    						@RequestParam("gp_idx") int gp_idx, @RequestParam("user_idx") int user_idx) {
    	gpUser.setGp_idx(gp_idx);
    	gpUser.setUser_idx(user_idx);
    	gpUser.setGp_zipcode(gp_zipcode);
    	gpUser.setGp_addr(gp_addr);
    	
    	gpService.updateAddr(gpUser);
    	return "redirect:/myPage/gplist";
    }
    
    @RequestMapping(value = "/deleteRequest", method = RequestMethod.GET)
    public String deleteRequest(@RequestParam("gp_idx") int gp_idx, @RequestParam("user_idx") int user_idx) {
    	gpService.deleteRequest(user_idx, gp_idx);
    	return "redirect:/myPage/gplist";
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
