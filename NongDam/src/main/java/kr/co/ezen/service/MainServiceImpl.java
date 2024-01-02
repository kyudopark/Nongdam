package kr.co.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ezen.entity.Gp;
import kr.co.ezen.entity.Info;
import kr.co.ezen.entity.Tr;
import kr.co.ezen.mapper.MainMapper;

@Service
public class MainServiceImpl implements MainService{

	@Autowired
	MainMapper mainMapper;
	
	@Override
	public List<Tr> findTr() {
		List<Tr> Trlist = mainMapper.findTr();
		return Trlist;
	}

	@Override
	public List<Gp> findGp() {
		List<Gp> Gplist = mainMapper.findGp();
		return Gplist;
	}

	@Override
	public Info findInfo() {
		Info infolist = mainMapper.findInfo();
		
		return infolist;
	}
	
	

}
