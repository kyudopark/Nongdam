package kr.co.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Info;
import kr.co.ezen.entity.InfoLike;
import kr.co.ezen.mapper.InfoMapper;

@Service
public class InfoServiceImpl implements InfoService {
	
	@Autowired
	private InfoMapper infoMapper;

	@Override
	public List<Info> findAll(Criteria cri) {
		List<Info> li=infoMapper.findAll(cri);
		return li;
	}

	@Override
	public void insert(Info In) {
		infoMapper.insert(In);
		
	}

	@Override
	public Info findByIdx(int info_idx) {
		Info In=infoMapper.findByIdx(info_idx);
		return In;
	}

	@Override
	public int totalCount(Criteria cri) {
		int count=infoMapper.totalCount(cri);
		return count;
	}

	@Override
	public void updatecnt(int info_idx) {
		infoMapper.updatecnt(info_idx);
		
	}

	@Override
	public void deleteByIdx(int info_idx) {
		infoMapper.deleteByIdx(info_idx);
	}

	@Override
	public void updateByIdx(Info vo) {
		infoMapper.updateByIdx(vo);
		
	}

	@Override
	public int findUser_idxIsExist(InfoLike lvo) {
		int result = infoMapper.findUser_idxIsExist(lvo);
		
		return result;
	}

	@Override
	public int findLikeCount(int info_idx) {
		int result = infoMapper.findLikeCount(info_idx);
		return result;
	}

	@Override
	public void insertInfoLike(InfoLike lvo) {
		infoMapper.insertInfoLike(lvo);
	}

	@Override
	public void deleteInfoLike(InfoLike lvo) {
		infoMapper.deleteInfoLike(lvo);
	}



}
