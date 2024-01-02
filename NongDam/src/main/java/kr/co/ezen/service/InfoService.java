package kr.co.ezen.service;

import java.util.List;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Info;

public interface InfoService {
	
	//게시글 전체 보기 
	public List<Info> findAll(Criteria cri);
	
	//글쓰기
	public void insert(Info In);
	//idx값을 기준으로 게시글 조회
	public Info findByidx(int info_idx);
	//조회수
	public int totalCount(Criteria cre);
	//조회수 증가 
	public void updatecnt(int info_idx);
	//삭제
	public void deleteByIdx(int info_idx);
	//수정
	public void updateByIdx(Info vo);
	//태그
	public List<Info> findnew(Criteria cri);
	public List<Info> findtenure(Criteria cri);
	
	//태그(조회수 순)
	
	public List<Info> findBycountnew(Criteria cri);
	public List<Info> findBycountenure(Criteria cri);
	
	
	//조회수or날짜 별로 최신순/인기순
	public List<Info> findBydate(Criteria cri);
	public List<Info> findBycount(Criteria cri);
	//좋아요 
	public void updateLike(int info_idx);
	
	
}
