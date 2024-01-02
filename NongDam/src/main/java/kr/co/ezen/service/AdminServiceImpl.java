package kr.co.ezen.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	@Override
	public int countGpAll() {
		return adminMapper.countGpAll();
	}

	@Override
	public int countTrAll() {
		return adminMapper.countTrAll();
	}
	
	@Override
	public int countFreeAll() {
		return adminMapper.countFreeAll();
	}
	
	@Override
	public Map<String, Integer> getCountsByDate(String date) {
	    Map<String, Integer> countsByDate = new HashMap<>();

	    // 공동구매 게시글 날짜별 count
	    Map<String, Object> gpCounts = adminMapper.selectGpCountsByDate(date);
	    System.out.println("gpCounts: " + gpCounts);  // 디버그용 출력
	    countsByDate.put("gpCount", gpCounts != null ? Integer.parseInt(gpCounts.get("count").toString()) : 0);

	    // 1:1 거래 게시글 날짜별 count
	    Map<String, Object> trCounts = adminMapper.selectTrCountsByDate(date);
	    System.out.println("trCounts: " + trCounts);  // 디버그용 출력
	    countsByDate.put("trCount", trCounts != null ? Integer.parseInt(trCounts.get("count").toString()) : 0);

	    // 자유 게시글 날짜별 count
	    Map<String, Object> freeCounts = adminMapper.selectFreeCountsByDate(date);
	    System.out.println("freeCounts: " + freeCounts);  // 디버그용 출력
	    countsByDate.put("freeCount", freeCounts != null ? Integer.parseInt(freeCounts.get("count").toString()) : 0);

	    return countsByDate;
	}

	@Override
	public Map<String, Integer> getCountsByDate(String date, int daysToAddOrSubtract) {
	    LocalDate targetDate = LocalDate.parse(date);
	    LocalDate adjustedDate = targetDate.plusDays(daysToAddOrSubtract);

	    Map<String, Integer> countsByDate = new HashMap<>();
	    
	    // 공동구매 게시글 날짜별 count
	    Map<String, Object> gpCounts = adminMapper.selectGpCountsByDate(adjustedDate.toString());
	    countsByDate.put("gpCount", gpCounts != null ? Integer.parseInt(gpCounts.get("count").toString()) : 0);

	    // 1:1 거래 게시글 날짜별 count
	    Map<String, Object> trCounts = adminMapper.selectTrCountsByDate(adjustedDate.toString());
	    countsByDate.put("trCount", trCounts != null ? Integer.parseInt(trCounts.get("count").toString()) : 0);

	    // 자유 게시글 날짜별 count
	    Map<String, Object> freeCounts = adminMapper.selectFreeCountsByDate(adjustedDate.toString());
	    countsByDate.put("freeCount", freeCounts != null ? Integer.parseInt(freeCounts.get("count").toString()) : 0);

	    return countsByDate;
	}
	
	@Override
    public String getSelectedDate(String date, int daysToAddOrSubtract) {
        // 받은 날짜를 LocalDate로 변환
        LocalDate selectedDate = LocalDate.parse(date);

        // daysToAddOrSubtract를 사용하여 날짜를 계산
        selectedDate = selectedDate.plusDays(daysToAddOrSubtract);

        // 변환된 날짜를 문자열로 반환
        return selectedDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }
	
}
