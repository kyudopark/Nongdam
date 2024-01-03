package kr.co.ezen.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Collection;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;



import com.google.gson.Gson;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import kr.co.ezen.entity.KakaoDTO;
import kr.co.ezen.entity.User;
import kr.co.ezen.entity.VerifyRecaptcha;
import kr.co.ezen.service.UserService;


@Controller
@RequestMapping("/user/*")

@CrossOrigin("*")
public class UserController {
	
	
	
	private static final Logger log = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
    private UserService userService;
	
	
	@Autowired 
	GoogleLoginBO googleLoginBO;
	
	
	@Autowired
	JavaMailSenderImpl mailSender;
	
	@Autowired
	KakaoLoginBO kakaoLoginBO;
	

	//231226===================
	@Autowired
	NaverLoginBO naverLoginBO;
	//=========================
	
	
	
	private String apiResult = null;
    


    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String userLogin(HttpSession session, Model model) throws Exception{
    	String kakaoLoginUrl = kakaoLoginBO.requestCode(session);
    	model.addAttribute("kakaoLoginUrl",kakaoLoginUrl);
    	
    	
    	
		
		
		String googleAuthUrl = googleLoginBO.requestCode(session);
	      
		model.addAttribute("googleAuthUrl", googleAuthUrl);
		 
        
        
        //231226
		String state = naverLoginBO.getState();
	    session.setAttribute("state", state);
	    String naverLoginUrl = naverLoginBO.getRedirectApiURI(state);
	    model.addAttribute("naverLoginUrl", naverLoginUrl);
        //===================================================
        
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
    
    @RequestMapping("/googlecallback")
    public String googlecallback(Model model, @RequestParam("code") String code, @RequestParam("state") String state,
            HttpSession session, RedirectAttributes rttr) throws IOException {
        String token = googleLoginBO.requestToken(session, code, state);
        apiResult = googleLoginBO.requestProfile(token);
        JSONObject full = new JSONObject(apiResult);

        String userId = full.getBigInteger("id").toString();

        // 사용자 ID로 DB에서 해당 사용자 정보 조회
        User existingUser = userService.findGoogleId(userId);

        if (existingUser == null) {
            // 등록되지 않은 사용자일 경우, 새로 등록
            User newUser = new User();
            newUser.setUser_id(userId);
            newUser.setUser_pw(full.getBigInteger("id").toString());
            newUser.setUser_name(full.getString("name"));
            newUser.setUser_nickname(full.getString("name"));
            newUser.setUser_email(full.getString("email"));
            newUser.setUser_kakaologin("G");

            // 새로운 사용자 DB에 저장
            userService.insertGoogleUser(newUser);

            // 새로 등록된 사용자를 세션에 설정
            session.setAttribute("uvo", newUser);
            rttr.addFlashAttribute("msgType", "성공");
            rttr.addFlashAttribute("msg", "구글 소셜 회원 가입 되었습니다.");

            model.addAttribute("mem", newUser);
        } else {
            // 이미 등록된 사용자일 경우, 로그인 처리
            session.setAttribute("uvo", existingUser);
            rttr.addFlashAttribute("msgType", "성공");
            rttr.addFlashAttribute("msg", "구글 로그인 되었습니다.");
        }

        return "redirect:/";
    }

    
    
    @RequestMapping("/kakaocallback")
    public String kakaoCallBack(HttpSession session, @RequestParam("code") String code,@RequestParam(value = "state", required = false) String state, Model model, RedirectAttributes rttr) {
        
    	try {
            
            String token = kakaoLoginBO.requestToken(session, code, state);
            
            // 토큰을 사용하여 사용자 프로필 정보를 가져옵니다.
            String profile = kakaoLoginBO.requestProfile(token);
            
            model.addAttribute("token", token);
            model.addAttribute("profile", profile);
            
            
            KakaoDTO kakaoDTO = parseKakaoProfile(profile);
            
            handleKakaoUser(session, kakaoDTO, model, rttr);
            
			
            return "redirect:/"; // 성공 시 메인 페이지로 리다이렉트
            

            

            
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/user/login"; // 에러 발생 시 에러 페이지로 이동
        }
    }
    
    private KakaoDTO parseKakaoProfile(String profile) {
        JsonObject jsonObject = JsonParser.parseString(profile).getAsJsonObject();

        String kuser_id = jsonObject.get("id").getAsString();
        
        JsonObject properties = jsonObject.getAsJsonObject("properties");
        String kuser_nickname = properties.get("nickname").getAsString();
        String kuser_name = properties.get("nickname").getAsString();  // 이 부분을 카카오에서 받아오는 값에 맞게 수정
        String kuser_email = jsonObject.getAsJsonObject("kakao_account").get("email").getAsString();

        KakaoDTO kakaoDTO = new KakaoDTO();
        kakaoDTO.setKuser_id(kuser_id);
        kakaoDTO.setKuser_nickname(kuser_nickname);
        kakaoDTO.setKuser_name(kuser_name);
        kakaoDTO.setKuser_email(kuser_email);
        

        return kakaoDTO;
    }
    
   
    
    private String handleKakaoUser(HttpSession session, KakaoDTO kakaoDTO, Model model,RedirectAttributes rttr) {
        // kuser_id를 기준으로 사용자 조회
        User existingUser = userService.selectUserByKakaoLogin(kakaoDTO.getKuser_id());


        if (existingUser == null) {
            // 등록되지 않은 사용자일 경우, 새로 등록
            User newUser = convertToUser(kakaoDTO);
            
            
            userService.kakaoUser(newUser); // 새로운 사용자 DB에 저장

            // 로그인 처리
            session.setAttribute("uvo", newUser);
            
            rttr.addFlashAttribute("msgType", "성공");
            rttr.addFlashAttribute("msg", "카카오 소셜 회원가입 되었습니다.");

            // 회원가입 페이지로 리다이렉트
            return "redirect:/";
        } else {
            // 이미 등록된 사용자일 경우, 로그인 처리
            session.setAttribute("uvo", existingUser);
            
            rttr.addFlashAttribute("msgType", "성공");
            rttr.addFlashAttribute("msg", "카카오 로그인 되었습니다.");
			
            return "redirect:/"; // 또는 리다이렉트할 다른 페이지
        }
    }


    private User convertToUser(KakaoDTO kakaoDTO) {
        User user = new User();
        // User 객체에 필요한 정보를 KakaoDTO에서 가져와서 설정
        user.setUser_id(kakaoDTO.getKuser_id());
        user.setUser_nickname(kakaoDTO.getKuser_nickname());
        user.setUser_name(kakaoDTO.getKuser_name());
        user.setUser_email(kakaoDTO.getKuser_email());
        // 나머지 필요한 정보들을 설정

        return user;
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
  		
  		
  		String content = "<div style='width: 100%; display: flex; justify-content: center;'>" +
  		        "<div style='max-width: 640px; border: 1px solid gainsboro; border-radius: 4px;margin-top: 20px;margin-bottom: 20px;'>" +
  		        "<div style='background-color: gainsboro;'>" +
  		        "<a href='#' style='border-radius: 4px;text-decoration: none;'>" +
  		        "<h3 style='margin-top: 0; padding:10px ;color: gray;'>농담</h3>" +
  		        "</a>" +
  		        "</div>" +
  		        "<div style='padding: 40px 20px 40px 20px;'>" +
  		        "<h2 style='margin: 0;'>이메일 인증 코드</h2>" +
  		        "<p style='color: gray;'>" +
  		        "회원가입시 필요한 이메일 인증 코드입니다." +
  		        "<br>" +
  		        "아래의 코드를 복사해 인증 코드 확인란에 기입하여 주세요." +
  		        "</p>" +
  		        "<h2 style='background-color: whitesmoke; color: gray; padding: 10px;'>" +
  		        checkNum +
  		        "</h2>" +
  		        "</div>" +
  		        "<div style='padding:20px; border-top: 1px solid gainsboro; color: gray;'>" +
  		        "본 이메일은 발신 전용 이메일이며," +
  		        "문의에 대한 회신은 처리되지 않습니다. " +
  		        "사이트 <b>농담</b>과 관련되어 문의하실 점이 있으시다면 " +
  		        "<a href='#'>문의하기</a> 페이지를 이용해 주십시오." +
  		        "</div>" +
  		        "</div>" +
  		        "</div>";
  		
  		
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

  	@ResponseBody
	@RequestMapping(value = "/VerifyRecaptcha", method = RequestMethod.POST)
	public int VerifyRecaptcha(HttpServletRequest request) {
		// 시크릿 키를 캡챠를 받아올수 있는 Class에 보내서 그곳에서 값을 출력한다
	    VerifyRecaptcha.setSecretKey("6LePKTkpAAAAAMVgafPHWD4wEEy5O8ejitcrzKnh");
	    String gRecaptchaResponse = request.getParameter("recaptcha");
	    try {
	       if(VerifyRecaptcha.verify(gRecaptchaResponse))
	          return 0; // 성공
	       else return 1; // 실패
	    } catch (Exception e) {
	        e.printStackTrace();
	        return -1; //에러
	    }
	}
  	


	//231226 naver로그인관련
  	
  	//콜백
  	//user/naver-callback?code=&state=
  	@RequestMapping("/naver-callback")
  	public String navercallback(HttpSession session,String code, String state, RedirectAttributes rttr) {

  		String session_state = (String) session.getAttribute("state");
  	    if (!state.equals(session_state)) {
  	        System.out.println("세션에 저장된 state와 다른 값으로 반환되었습니다.");
  	        session.removeAttribute("state");
  	        return "redirect:/";
  	    }

  	    String apiURL = naverLoginBO.getAuthorizationApiURI(code, state);
  	    String access_token = "";
  	    try {
  			URL url = new URL(apiURL);
  			HttpURLConnection con = (HttpURLConnection)url.openConnection();
  			con.setRequestMethod("GET");
  			int responseCode = con.getResponseCode();
  			BufferedReader br;
  			if(responseCode==200) { // 정상 호출
  			  br = new BufferedReader(new InputStreamReader(con.getInputStream()));
  			} else {  // 에러 발생
  			  br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
  			}
  			String inputLine;
  			StringBuffer res = new StringBuffer();
  			while ((inputLine = br.readLine()) != null) {
  			  res.append(inputLine);
  			}
  			br.close();
  			if(responseCode==200) {
  				//res.toString() <= json형식의 access_token,refresh_token		
  				Gson gson = new Gson();
  				JsonObject naverUser = gson.fromJson(res.toString(), JsonObject.class);
  				access_token = naverUser.get("access_token").getAsString();
  				User profile = naverLoginBO.getNaverProfile(access_token);
  				
  				User uvoIsEx = userService.findNaverId(profile);
  				
  				if(uvoIsEx!=null){
  					session.setAttribute("uvo", uvoIsEx);
  					
  					rttr.addFlashAttribute("msgType", "성공");
  		            rttr.addFlashAttribute("msg", "네이버 로그인 되었습니다.");
  				}else{
	  				userService.insertNaverUser(profile);
	  				User uvo = userService.findNaverId(profile);
	  				session.setAttribute("uvo", uvo);
	  				rttr.addFlashAttribute("msgType", "성공");
	  	            rttr.addFlashAttribute("msg", "네이버 소셜 회원 가입 되었습니다.");
  				}
  			}
  	    } catch (Exception e) {
  	      System.out.println(e);
  	      return "redirect:user/login";
  	    }
  	    
  	    return "redirect:/";
  	}
    
  
  
    
}