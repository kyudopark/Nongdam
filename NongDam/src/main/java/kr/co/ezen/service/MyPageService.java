package kr.co.ezen.service;

import java.util.List;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Gp;
import kr.co.ezen.entity.Tr;
import kr.co.ezen.entity.User;

public interface MyPageService {
	
	public List<Tr> findByIdx(int user_idx);
	
	public User findAll(int user_idx);
	
	public void updateUserInfo(User user);
	
	public void deleteUserById(int user_idx);
	
}
