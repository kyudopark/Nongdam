package kr.co.ezen.service;

import java.util.List;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Gp;
import kr.co.ezen.entity.GpUser;

public interface GpService {
	
	public List<Gp> findAll(Criteria cri);
	public int totalCount(Criteria cri);
	
	public Gp findByIdx(int gp_idx);
	public List<GpUser> findGpUserbyIdx(int user_idx);
	
	public void insert(Gp vo);
	
	public void updateByIdx(Gp vo);
	public void deleteByIdx(int gp_idx);
	
	public void request(GpUser gp);
	public void updateAddr(GpUser gpUser);
	public void deleteRequest(int user_idx, int gp_idx);
	
}
