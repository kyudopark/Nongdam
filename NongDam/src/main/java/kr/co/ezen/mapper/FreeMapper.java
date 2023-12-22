package kr.co.ezen.mapper;

import java.util.List;


import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.entity.FreeComment;
import kr.co.ezen.entity.TrComment;

public interface FreeMapper {
	
	public List<Free> findAll(Criteria cri);
	public void insert(Free fr);
	public Free findByidx(int free_idx);
	public int totalCount(Criteria cre);
	public void updatecnt(int free_idx);
	public void deleteByIdx(int free_idx);
	public void updaetByIdx(Free fr);
	public Free read(int free_idx);
	public Free GetUserIdx(String user_nickname);
	public void Modify(Free fr);
	public List<Free> findfr(Criteria cri);
	public List<Free> findqu(Criteria cri);
	public List<Free> findBydate(Criteria cri);
	public List<Free> findBycount(Criteria cri);
	

	//댓글
	public List<FreeComment> findAllComment(int free_idx);
	public void insertComment(FreeComment comm);
	public void insertReplyComment(FreeComment comm);
	public void updateCommentByIdx(FreeComment comm);
	public void deleteCommentByIdx(int free_comment_idx);
	public void deleteCommentByfree_idx(int free_idx);

}
