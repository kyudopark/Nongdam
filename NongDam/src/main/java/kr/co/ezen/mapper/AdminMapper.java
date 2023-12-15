package kr.co.ezen.mapper;

import java.util.List;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.User;

public interface AdminMapper {
	public List<User> findAll(Criteria cri);
	public void deleteByIdx(int user_idx);
	public void updateAdminStatus(User user);


}
