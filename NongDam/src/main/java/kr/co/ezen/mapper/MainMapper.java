package kr.co.ezen.mapper;

import java.util.List;

import kr.co.ezen.entity.Gp;
import kr.co.ezen.entity.Info;
import kr.co.ezen.entity.Tr;

public interface MainMapper {
	public List<Tr> findTr();
	public List<Gp> findGp();
	
	
	
	public Info findInfo();

}
