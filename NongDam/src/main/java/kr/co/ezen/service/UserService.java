package kr.co.ezen.service;

import kr.co.ezen.entity.User;

public interface UserService {

	
	public void insertUser(User user);
	public User registerCheck(String user_id);
	public User userLogin(User uvo);
}
