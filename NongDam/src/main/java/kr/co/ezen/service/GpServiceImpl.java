package kr.co.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Gp;
import kr.co.ezen.entity.GpUser;
import kr.co.ezen.mapper.GpMapper;

@Service
public class GpServiceImpl implements GpService{
	
	@Autowired
	private GpMapper gpMapper;
	
	@Override
	public List<Gp> findAll(Criteria cri) {
		List<Gp> li = gpMapper.findAll(cri);
		return li;
	}

	@Override
	public int totalCount(Criteria cri) {
		int count = gpMapper.totalCount(cri);
		return count;
	}
	
	@Override
	public Gp findByIdx(int gp_idx) {
		Gp gpDetail = gpMapper.findByIdx(gp_idx);	
		return gpDetail;
	}
	
	public List<GpUser> findGpUserbyIdx(int user_idx) {
		List<GpUser> gpUserList = gpMapper.findGpUserbyIdx(user_idx);
		return gpUserList;
	}

	@Override
	public void insert(Gp vo) {
		gpMapper.insert(vo);
	}
	
	@Override
	public void updateByIdx(Gp vo) {
		gpMapper.updateByIdx(vo);
	}

	@Override
	public void deleteByIdx(int gp_idx) {
		gpMapper.deleteByIdx(gp_idx);
	}
	
	@Override
	public void request(GpUser gu) {
		gpMapper.request(gu);
	}

	@Override
	public void deleteRequest(int user_idx, int gp_idx) {
		gpMapper.deleteRequest(user_idx, gp_idx);
		
	}

}
