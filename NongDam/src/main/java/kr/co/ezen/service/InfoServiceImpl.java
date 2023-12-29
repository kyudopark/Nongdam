package kr.co.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Info;
import kr.co.ezen.mapper.InfoMapper;

@Service
public class InfoServiceImpl implements InfoService {
	
	@Autowired
	private InfoMapper infomapper;

	@Override
	public List<Info> findAll(Criteria cri) {
		List<Info> li=infomapper.findAll(cri);
		return li;
	}

	@Override
	public void insert(Info In) {
		infomapper.insert(In);
		
	}

	@Override
	public Info findByidx(int info_idx) {
		Info In=infomapper.findByidx(info_idx);
		return In;
	}

	@Override
	public int totalCount(Criteria cre) {
		int Counet=infomapper.totalCount(cre);
		return Counet;
	}

	@Override
	public void updatecnt(int info_idx) {
		infomapper.updatecnt(info_idx);
		
	}

	@Override
	public void deleteByIdx(int info_idx) {
		infomapper.deleteByIdx(info_idx);
	}

	@Override
	public void Modify(Info In) {
		infomapper.Modify(In);
		
	}

	@Override
	public List<Info> findnew(Criteria cri) {
		List<Info> neww=infomapper.findnew(cri);
		return neww;
	}

	@Override
	public List<Info> findtenure(Criteria cri) {
		List<Info> tenure=infomapper.findtenure(cri);
		return tenure;
	}

	@Override
	public List<Info> findBydate(Criteria cri) {
		List<Info> fd=infomapper.findBydate(cri);
		return fd;
	}

	@Override
	public List<Info> findBycount(Criteria cri) {
		List<Info> fc=infomapper.findBycount(cri);
		return fc;
	}

	@Override
	public List<Info> findBycountnew(Criteria cri) {
		List<Info> fcn=infomapper.findBycountnew(cri);
		return fcn;
	}

	@Override
	public List<Info> findBycountenure(Criteria cri) {
		List<Info> fce=infomapper.findBycountenure(cri);
		return fce;
	}
	
	@Override
	public void updateLike(int info_idx) {
		infomapper.updateLike(info_idx);
		
	}

	


}
