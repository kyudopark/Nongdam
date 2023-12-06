package kr.co.ezen.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ezen.entity.User;
import kr.co.ezen.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService{

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
		
		return  userMapper.userLogin(uvo);
	}
}
