package kr.co.ezen.service;

import javax.servlet.http.HttpServletResponse;

import kr.co.ezen.entity.User;

public interface UserService {

	
	public void insertUser(User user);
	public User registerCheck(String user_id);
	public User userLogin(User uvo);
	
	public boolean isNameExists(String user_name);
    public boolean isEmailExists(String user_email);
    public User findUserId(String user_name, String user_email);
    
    //이메일발송
    public void sendEmail(User user,String div) throws Exception;

    //비밀번호찾기
    public void findPw(HttpServletResponse resp, User user) throws Exception;

    public int updatePw(User user) throws Exception;
    
    public  User readUser(String user_id);
    
}
