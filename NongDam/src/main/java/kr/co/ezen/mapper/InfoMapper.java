package kr.co.ezen.mapper;

import java.util.List;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.entity.Info;

public interface InfoMapper {
	
	public List<Info> findAll(Criteria cri);
	public void insert(Info In);
	public Info findByidx(int info_idx);
	public int totalCount(Criteria cre);
	public void updatecnt(int info_idx);
	public void deleteByIdx(int info_idx);
	public void updateByIdx(Info vo);
	public void Modify(Info In);
	public List<Info> findnew(Criteria cri);
	public List<Info> findtenure(Criteria cri);
	public List<Info> findBydate(Criteria cri);
	public List<Info> findBycount(Criteria cri);
	public List<Info> findBycountnew(Criteria cri);
	public List<Info> findBycountenure(Criteria cri);
	public void updateLike(int info_idx); 


}
