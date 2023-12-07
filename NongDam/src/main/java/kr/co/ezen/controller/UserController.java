package kr.co.ezen.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import kr.co.ezen.entity.User;
import kr.co.ezen.mapper.UserMapper;
import kr.co.ezen.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
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

    

    
}
