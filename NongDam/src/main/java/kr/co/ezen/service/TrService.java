package kr.co.ezen.service;

import java.util.List;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Tr;

public interface TrService {
	
	
	public List<Tr> findByIdx(Criteria cri);
	public void updateByIdx(Tr vo);
	public void deleteByIdx(int tr_Idx);
	public List<Tr> findAll(Criteria cri);
	public int totalCount(Criteria cri);
	public void insert(Tr vo);
}
