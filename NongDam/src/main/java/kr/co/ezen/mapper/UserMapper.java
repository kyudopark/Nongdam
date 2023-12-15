package kr.co.ezen.mapper;


import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;

import kr.co.ezen.entity.User;

public interface UserMapper {

	
	public void insertUser(User user);
	public User registerCheck(String user_id);
	public User userLogin(User uvo);
	
	public boolean isNameExists(String user_name);
    public boolean isEmailExists(String user_email);
    public User findUserId(@Param("user_name") String user_name, @Param("user_email") String user_email);
    
  //이메일발송
    public void sendEmail(User user,String div) throws Exception;

    //비밀번호찾기
    public void findPw(HttpServletResponse resp, User user) throws Exception;
    
 // 비밀번호 변경
    public int updatePw(User user) throws Exception;
    
    public  User readUser(String user_id);
    
    //public int sendEmailVerification(String user_email);
    
    //public boolean verifyCode(String user_email, String verificationCode);
    
    //카카오 추가 KakaoMapper 삭제하고 여기다 추가함
    public void kakaoInsert(HashMap<String, Object> userInfo);
    public User findKakao(HashMap<String, Object> userInfo);
    public User kakaoNumber(User userInfo);
    
    
    public User selectUserByKakaoLogin(String userKakaoLogin);

}
