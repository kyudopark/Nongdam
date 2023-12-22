package kr.co.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.User;
import kr.co.ezen.mapper.AdminMapper;

@Service
public class AdminServiceImpl  implements AdminService{
		
	@Autowired
	private AdminMapper adminMapper;
	
	@Override
	public void deleteByIdx(int user_idx) {
		adminMapper.deleteByIdx(user_idx);
	}

	@Override
	public List<User> findAll(Criteria cri) {
		List<User> li= adminMapper.findAll(cri);
		return li;
	}

	@Override
	public void updateAdminStatus(User user) {
		adminMapper.updateAdminStatus(user);
	}

	@Override
	public void deleteByCheckbox(List<Integer> selectedUsers) {
		adminMapper.deleteByCheckbox(selectedUsers);
	}



	
	
	
	
}
