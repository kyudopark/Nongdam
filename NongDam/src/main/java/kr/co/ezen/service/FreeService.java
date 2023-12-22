package kr.co.ezen.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.entity.FreeComment;
import kr.co.ezen.entity.TrComment;

public interface FreeService {
	
	//게시글 전체 보기 
	public List<Free> findAll(Criteria cre);
	//idx값을 기준으로 게시글 조회
	public Free findByidx(int free_idx);
		
	//글쓰기
	public void insert(Free fr);
	//조회수
	public int totalCount(Criteria cri);
	//삭제
	public void deleteByIdx(int free_idx);
	//수정
	public void Modify(Free fr);
	//태그
	public List<Free> findfr(Criteria cri);
	public List<Free> findqu(Criteria cri);
	
	//조회수 증가 
	public void updatecnt(int free_idx);
	//조회수or날짜 별로 최신순/인기순
	public List<Free> findBydate(Criteria cri);
	public List<Free> findBycount(Criteria cri);
	
	

	public List<FreeComment> findAllComment(int free_idx);
	public void insertComment(FreeComment dev);
	public void insertReplyComment(FreeComment dev);
	public void updateCommentByIdx(FreeComment dev);
	public void deleteCommentByIdx(int free_comment_idx);
	public void deleteCommentByfree_idx(int free_idx);
	
}
