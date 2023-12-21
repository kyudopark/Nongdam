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
		return userMapper.readUser(user_id);
	}

	@Override
	public User selectUserByKakaoLogin(String userKakaoLogin) {

		return userMapper.selectUserByKakaoLogin(userKakaoLogin);
	}

	@Override
	public void kakaoUser(User user) {
		userMapper.kakaoUser(user);

	}

	@Override
	public void updateUserProfile(User user) {
		userMapper.updateUserProfile(user);
		
	}

}