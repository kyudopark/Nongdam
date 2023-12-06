package kr.co.ezen.mapper;

import java.util.List;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Tr;

public interface TrMapper {
	
	
	public List<Tr> findByIdx(Criteria cri);
	public List<Tr> findAll(Criteria cri);
	public int totalCount(Criteria cri);
	public void updateByIdx(Tr vo);
	public void deleteByIdx(int tr_Idx);
	public void insert(Tr vo);

}
