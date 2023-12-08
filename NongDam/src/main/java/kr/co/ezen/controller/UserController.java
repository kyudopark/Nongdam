package kr.co.ezen.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import kr.co.ezen.entity.User;
import kr.co.ezen.mapper.UserMapper;
import kr.co.ezen.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	private static final Logger log = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
    private UserService userService;
	
	@Autowired
	JavaMailSenderImpl mailSender ; 

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String userLogin() {
       
        return "user/login";
    }

    @RequestMapping(value = "/signup", method = RequestMethod.GET)
    public String userSignup() {
        
        return "user/signup";
    }

    @RequestMapping(value = "/findid", method = RequestMethod.GET)
    public String findId() {
        
        return "user/findid";
    }

    @RequestMapping(value = "/findpw", method = RequestMethod.GET)
    public String findPassword() {
       
        return "user/findpw";
    }
    
    @RequestMapping(value = "/findpw", method = RequestMethod.POST)
    public void findPwPOST(@ModelAttribute User user, HttpServletResponse response) throws Exception{
    	userService.findPw(response, user);
    }
    
    
    @RequestMapping("/userRegisterCheck")
	public @ResponseBody int memRegisterCheck(@RequestParam("user_id") String user_id) {
		
		User u=userService.registerCheck(user_id);
		if(u!=null || user_id.equals("")) {
			return 0;
		}
			return 1;
		
	}

   
    @PostMapping("/signup")
    public String userSignup(@ModelAttribute User user) {
        userService.insertUser(user);
        
        return "redirect:/user/login";
    }
    
    
    
    @RequestMapping("/signup")
    public String memRegister(User user, String user_pw1, String user_pw2, RedirectAttributes rttr, HttpSession session) {
        if (user.getUser_id() == null || user.getUser_id().equals("") ||
                user_pw1 == null || user_pw1.equals("") ||
                user_pw2 == null || user_pw2.equals("") ||
                user.getUser_name() == null || user.getUser_name().equals("") ||
                user.getUser_nickname() == null || user.getUser_nickname().equals("") ||
                user.getUser_gender() == null || user.getUser_gender().equals("")) {

            rttr.addFlashAttribute("msgType", "실패");
            rttr.addFlashAttribute("msg", "값 다 입력안했습니다.");
            return "redirect:/user/signup";
        }

        if (!user_pw1.equals(user_pw2)) {
            rttr.addFlashAttribute("msgType", "실패");
            rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
            return "redirect:/user/signup";
        }

        user.setUser_profile("");

        try {
            userService.insertUser(user);
            rttr.addFlashAttribute("msgType", "성공");
            rttr.addFlashAttribute("msg", "회원가입 되었습니다.");
            return "redirect:/user/login";
        } catch (Exception e) {
            rttr.addFlashAttribute("msgType", "실패");
            rttr.addFlashAttribute("msg", "이미 존재하는 회원입니다.");
            return "redirect:/user/signup";
        }
    }

    
    @RequestMapping("/userLogin")
    public String userLogin(User user, RedirectAttributes rttr, HttpSession session) {
        if (user.getUser_id() == null || user.getUser_id().equals("") ||
                user.getUser_pw() == null || user.getUser_pw().equals("")) {
            rttr.addFlashAttribute("msgType", "실패");
            rttr.addFlashAttribute("msg", "아이디와 비밀번호를 입력하세요.");
            return "redirect:/user/login";
        }

        User uvo = userService.userLogin(user); // 로그인이 될 경우 -> id와 pw가 일치

        if (uvo != null) {
            rttr.addFlashAttribute("msgType", "성공");
            rttr.addFlashAttribute("msg", "로그인 되었습니다");
            session.setAttribute("uvo", uvo);
            return "redirect:/";
        } else {
            rttr.addFlashAttribute("msgType", "실패");
            rttr.addFlashAttribute("msg", "로그인 실패");
            return "redirect:/user/login";
        }
    }

    @RequestMapping("/logout")
    public String userLogout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
    
    @PostMapping("/checkId")
    @ResponseBody
    public String checkUserId(@RequestParam("user_name") String user_name, @RequestParam("user_email") String user_email, User user) {
         user = userService.findUserId(user_name, user_email);
         if (user != null) {
             return user.getUser_id();
         } else {
             return null;
         }
         
    }
    
  //이메일 인증
  	@PostMapping("/EmailAuth")
  	@ResponseBody
  	public int emailAuth(String user_email) {
  		
  		log.info("전달 받은 이메일 주소 : " + user_email);
  		
  		//난수의 범위 111111 ~ 999999 (6자리 난수)
  		Random random = new Random();
  		int checkNum = random.nextInt(888888)+111111;
  		
  		//이메일 보낼 양식
  		String fromEmail = "nongdamAdmin@gmail.com";
  		String fromName = "농담 관리자";
  		String toMail = user_email;
  		String title = "농담 회원가입 인증 이메일 입니다.";
  		String content = "<div align='center' style='border:1px solid black; font-family:verdana'>" +
                "<h3 style='color: green;'>" +
                "인증 코드는 " + checkNum + " 입니다. </h3>" +
                "<p>해당 인증 코드를 인증 코드 확인란에 기입하여 주세요. </p></div>";
  		
  		
  		
  		try {
  			MimeMessage message = mailSender.createMimeMessage(); //Spring에서 제공하는 mail API
              MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
              helper.setFrom(fromEmail, fromName);
              helper.setTo(toMail);
              helper.setSubject(title);
              helper.setText(content, true);
              mailSender.send(message);
  		} catch (Exception e) {
  			e.printStackTrace();
  		}
  		
  		log.info("랜덤숫자 : " + checkNum);
  		return checkNum;
  	}

    

    
}
