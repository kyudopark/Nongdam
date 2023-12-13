package kr.co.ezen.mapper;

import java.util.List;


import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.entity.FreeComment;

public interface FreeMapper {
	
	public List<Free> findAll(Criteria cre);
	public void insert(Free fr);
	public Free findByidx(int free_idx);
	public int totalCount(Criteria cre);
	public void updatecnt(int free_idx);
	public void deleteByIdx(int free_idx);
	public void updaetByIdx(Free fr);
	public Free read(int free_idx);
	public void Modify(Free fr);
	public List<Free> findfr(Criteria cre);
	public List<Free> findqu(Criteria cre);
	
	
	public List<FreeComment> findAllComment(int free_idx);

}
