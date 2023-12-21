package kr.co.ezen.mapper;

import java.util.List;

import kr.co.ezen.entity.Tr;
import kr.co.ezen.entity.User;

public interface MyPageMapper {

	public List<Tr> findByIdx(int user_idx);
	
	public User findAll(int user_idx);
	
	public void updateUserInfo(User user);
	
	public void deleteUserById(int user_idx);
	
	//public void deleteUserByName(int user_idx);
}
