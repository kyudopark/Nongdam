package kr.co.ezen.mapper;


import kr.co.ezen.entity.User;

public interface UserMapper {

	
	public void insertUser(User user);
	public User registerCheck(String user_id);
	public User userLogin(User uvo);
}
