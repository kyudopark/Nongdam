package kr.co.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.mapper.FreeMapper;

@Service
public class FreeServiceImpl implements FreeService {
	
	@Autowired
	private FreeMapper freemapper;

	@Override
	
	public List<Free> findAll(Criteria cre) {
		List<Free> li=freemapper.findAll(cre);
		return li;
	}


	@Override
	public Free findByidx(int idx) {
		Free fre=freemapper.findByidx(idx);
		return fre;
	}

	@Override
	public void insert(Free fr) {
		freemapper.insert(fr);
		
	}

}
