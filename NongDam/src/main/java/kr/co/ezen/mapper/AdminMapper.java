package kr.co.ezen.mapper;


import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.entity.Gp;
import kr.co.ezen.entity.Tr;
import kr.co.ezen.entity.User;


public interface AdminMapper {

	public List<User> findAll(Criteria cri);
	public void deleteByIdx(int user_idx);
	public void updateAdminStatus(User user);
	public void deleteByCheckbox(List<Integer> selectedUsers);
	
	public int countGpAll();
	public int countTrAll();
	public int countFreeAll();
	
	public int getCountByDate(@Param("date") String date);
	
	// 공동구매 게시글 날짜별 count 쿼리
	public Map<String, Object> selectGpCountsByDate(String date);

    // 1:1 거래 게시글 날짜별 count 쿼리
	public Map<String, Object> selectTrCountsByDate(String date);

    // 자유 게시글 날짜별 count 쿼리
	public Map<String, Object> selectFreeCountsByDate(String date);
	
	 // 'user_kakaologin' 값에 따른 회원가입 방식별 count 가져오기
	public Map<String, Long> getCountBySignupMethod();
}
