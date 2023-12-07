package kr.co.ezen.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;


public interface FreeService {

	public List<Free> frelist(Criteria cre);
	public void freinsert();
	
}
