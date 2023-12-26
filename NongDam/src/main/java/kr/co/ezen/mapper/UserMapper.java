package kr.co.ezen.mapper;


import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;

import kr.co.ezen.entity.User;

public interface UserMapper {

	
	public void insertUser(User user);
	public User registerCheck(String user_id);
	public User userLogin(User uvo);
	
	
    public User findUserId(@Param("user_name") String user_name, @Param("user_email") String user_email);
    
    //이메일발송
    public void sendEmail(User user,String div) throws Exception;

    //비밀번호찾기
    public void findPw(HttpServletResponse resp, User user) throws Exception;
    
    // 비밀번호 변경
    public int updatePw(User user) throws Exception;
    
    public  User readUser(String user_id);
    
    public User selectUserByKakaoLogin(String userKakaoLogin);
   
    public void kakaoUser(User user);
    
    public void updateUserProfile(User user);

    
    
    
    //231226 Naver 로그인 관련============
    public User findNaverId(User vo);
    public void insertNaverUser(User vo);
    public void deleteNaverUser(User uvo);
    //==================================
}
