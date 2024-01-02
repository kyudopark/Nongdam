package kr.co.ezen.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.entity.Gp;
import kr.co.ezen.entity.GpUser;
import kr.co.ezen.entity.Tr;
import kr.co.ezen.entity.User;

public interface AdminService {
	public List<User> findAll(Criteria cri);
	public void deleteByIdx(int user_idx);
	public void updateAdminStatus(User user);
	public void deleteByCheckbox(List<Integer> selectedUsers);
	
	public int countGpAll();
	public int countTrAll();
	public int countFreeAll();
	
	public Map<String, Integer> getCountsByDate(String date);
	public Map<String, Integer> getCountsByDate(String date, int daysToAddOrSubtract);
	public String getSelectedDate(String date, int daysToAddOrSubtract);
	public Map<String, Long> getCountBySignupMethod();
}
