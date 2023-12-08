package kr.co.ezen.mapper;

import java.util.List;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;

public interface FreeMapper {
	
	public List<Free> findAll(Criteria cre);
	public void insert(Free fr);
	public Free findByidx(int idx);

}
