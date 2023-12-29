package kr.co.ezen.service;

import java.util.List;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Gp;
import kr.co.ezen.entity.GpUser;
import kr.co.ezen.entity.Tr;
import kr.co.ezen.entity.User;

public interface AdminService {
	public List<User> findAll(Criteria cri);
	public void deleteByIdx(int user_idx);
	public void updateAdminStatus(User user);
	public void deleteByCheckbox(List<Integer> selectedUsers);
	
	public int countGpAll(Gp gp);
	public int countTrAll(Tr tr);
	public int countGpUserAll(GpUser gpUser);
	
}
