package kr.co.ezen.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.co.ezen.entity.User;
import kr.co.ezen.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;

	@Override
	public void insertUser(User user) {
		userMapper.insertUser(user);

	}

	@Override
	public User registerCheck(String user_id) {
		return userMapper.registerCheck(user_id);

	}

	@Override
	public User userLogin(User uvo) {

		return userMapper.userLogin(uvo);
	}

	@Override
	public boolean isNameExists(String userName) {
		return userMapper.isNameExists(userName);
	}

	@Override
	public boolean isEmailExists(String user_email) {
		return userMapper.isEmailExists(user_email);
	}

	@Override
	public User findUserId(String user_name, String user_email) {
		return userMapper.findUserId(user_name, user_email);
	}

	@Override
	public void sendEmail(User user, String div) throws Exception {
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com";
		String hostSMTPid = "kdpark1002@gmail.com";
		String hostSMTPpwd = "ysmr eint wxzt fvnu";

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "nongdamAdmin@gmail.com";
		String fromName = "농담 관리자";
		String subject = "";
		String msg = "";

		if (div.equals("findpw")) {
			subject = "농담 임시 비밀번호 입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += user.getUser_id() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
			msg += "<p>임시 비밀번호 : ";
			msg += user.getUser_pw() + "</p></div>";
		}

		// 받는 사람 E-Mail 주소
		String mail = user.getUser_email();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSL(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(465); // 네이버 이용시 587

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setTLS(true);
			email.addTo(mail);
			email.setFrom(fromEmail, fromName);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
	}

	@Override
	public int updatePw(User user) throws Exception {
		return userMapper.updatePw(user);
	}

	 @Override
	    public void findPw(HttpServletResponse response, User user) throws Exception {
	        response.setContentType("text/html;charset=utf-8");
	        User ck = userMapper.readUser(user.getUser_id());
	        PrintWriter out = response.getWriter();

	        if (ck == null) {
	            out.print("등록되지 않은 아이디입니다.");
	            out.close();
	        } else if (!user.getUser_email().equals(ck.getUser_email())) {
	            out.print("등록되지 않은 이메일입니다.");
	            out.close();
	        } else {
	        	
	        	String pw = "";
	    		for (int i = 0; i < 12; i++) {
	    			pw += (char) ((Math.random() * 26) + 97);
	    		}
	            
	            user.setUser_pw(pw);
	            userMapper.updatePw(user);
	            sendEmail(user, "findpw");
	            out.print("이메일로 임시 비밀번호를 발송하였습니다.");
	            out.close();
	        }
	    }

	@Override
	public User readUser(String user_id) {
		return  userMapper.readUser(user_id);
	}

	  public String getAccessToken (String authorize_code) {
	        String access_Token = "";
	        String refresh_Token = "";
	        String reqURL = "https://kauth.kakao.com/oauth/token";

	        try {
	            URL url = new URL(reqURL);

	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

	            //    POST 요청을 위해 기본값이 false인 setDoOutput을 true로
	            conn.setRequestMethod("POST");
	            conn.setDoOutput(true);

	            //    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
	            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	            StringBuilder sb = new StringBuilder();
	            sb.append("grant_type=authorization_code");
	            sb.append("&client_id=41c36dcb7aca960f26e11b76d0f2416c");
	            sb.append("&redirect_uri=http://localhost:8080/ezen/user/login");
	            //sb.append("&redirect_uri=http://www.couponbook.shop/member/kakaoLogin");
	            sb.append("&code=" + authorize_code);
	            bw.write(sb.toString());
	            bw.flush();

	            //    결과 코드가 200이라면 성공
	            int responseCode = conn.getResponseCode();
	            System.out.println("responseCode : " + responseCode);

	            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
	            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	            String line = "";
	            String result = "";

	            while ((line = br.readLine()) != null) {
	                result += line;
	            }
	            System.out.println("response body : " + result);

	            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
	            JsonParser parser = new JsonParser(); 
	            JsonElement element = parser.parse(result);

	            access_Token = element.getAsJsonObject().get("access_token").getAsString();
	            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

	            System.out.println("access_token : " + access_Token);
	            System.out.println("refresh_token : " + refresh_Token);

	            br.close();
	            bw.close();
	        } catch (IOException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }

	        return access_Token;
	    }
	    
	    
	    public User getUserInfo (String access_Token) {
	       System.out.println("---- KS:getUerInfo -----");
	        //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
	        HashMap<String, Object> userInfo = new HashMap<>();
	        String reqURL = "https://kapi.kakao.com/v2/user/me";
	        try {
	            URL url = new URL(reqURL);
	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	            conn.setRequestMethod("GET");

	            //    요청에 필요한 Header에 포함될 내용
	            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

	            int responseCode = conn.getResponseCode();
	            System.out.println("responseCode : " + responseCode);

	            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

	            String line = "";
	            String result = "";

	            while ((line = br.readLine()) != null) {
	                result += line;
	            }
	            System.out.println("response body : " + result);

	            JsonParser parser = new JsonParser();
	            JsonElement element = parser.parse(result);

	            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
	            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

	            long uid = element.getAsJsonObject().get("id").getAsLong();
	            String nickname = properties.getAsJsonObject().get("nickname").getAsString();
	            String email = kakao_account.getAsJsonObject().get("email").getAsString();
	            //String profile_image = properties.getAsJsonObject().get("profile_image").getAsString();

	            userInfo.put("uid", uid);
	            userInfo.put("nickname", nickname);
	            userInfo.put("email", email);
	            //userInfo.put("profile_image", profile_image);
	            System.out.println("KMS: 130 " + userInfo);

	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	        
	        // 코드 추가
	        User result = userMapper.findKakao(userInfo);
	        
	        //저장된 정보가 있는지 확인하는 코드
	        if(result == null) {
	        	userMapper.kakaoInsert(userInfo);
	           System.out.println("KS 142: DB에 없는 사용자 ");
	           //정보 저장 후 컨트롤러에 정보를 전달
	           return userMapper.findKakao(userInfo);
	        } else {
	           System.out.println("KS 146: 있는 사용자  ");
	           //저장된 정보가 있으면 result를 전송한다
	           return result;
	        }

	    }


	   public User kakaoNumber(User userInfo) {
	      // 카카오 번호 찾기
	      System.out.println("KS 156: " + userMapper.kakaoNumber(userInfo)); 
	      return userMapper.kakaoNumber(userInfo);
	   }

	@Override
	public void kakaoInsert(HashMap<String, Object> userInfo) {
		userMapper.kakaoInsert(userInfo);
		
	}

	@Override
	public User findKakao(HashMap<String, Object> userInfo) {
		
		return userMapper.findKakao(userInfo);
	}

	@Override
	public User selectUserByKakaoUserId(String user_kakaologin) {
		
		return userMapper.selectUserByKakaoUserId(user_kakaologin);
	} 

	
	
	
	
	
	
}