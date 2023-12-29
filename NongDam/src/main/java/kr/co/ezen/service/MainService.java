package kr.co.ezen.service;

import java.util.List;

import kr.co.ezen.entity.Gp;
import kr.co.ezen.entity.Tr;

public interface MainService {
	public List<Tr> findTr();
	public List<Gp> findGp();

}
