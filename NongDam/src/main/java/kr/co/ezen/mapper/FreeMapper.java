package kr.co.ezen.mapper;

import java.util.List;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;

public interface FreeMapper {
	
	public List<Free> frelist(Criteria cre);
	public void freinsert();

}
