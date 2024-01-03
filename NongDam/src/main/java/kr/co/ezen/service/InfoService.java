package kr.co.ezen.service;

import java.util.List;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Info;
import kr.co.ezen.entity.InfoLike;

public interface InfoService {

	public List<Info> findAll(Criteria cri);
	
	public void insert(Info vo);
	public Info findByIdx(int info_idx);
	public int totalCount(Criteria cri);
	public void updatecnt(int info_idx);
	public void deleteByIdx(int info_idx);
	public void updateByIdx(Info vo);

	public int findUser_idxIsExist(InfoLike lvo);
	public int findLikeCount(int info_idx);
	public void insertInfoLike(InfoLike lvo);
	public void deleteInfoLike(InfoLike lvo);
}
