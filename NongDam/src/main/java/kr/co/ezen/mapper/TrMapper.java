package kr.co.ezen.mapper;

import java.util.List;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Tr;
import kr.co.ezen.entity.TrComment;

public interface TrMapper {

	// 오류 발견해서 고쳐놓음. 231206 13:34
	public List<Tr> findAll(Criteria cri);
	public int totalCount(Criteria cri);
	public Tr findByIdx(int tr_idx);	
	public void updateByIdx(Tr vo);
	public void deleteByIdx(int tr_idx);
	public void insert(Tr vo);
	
	
	//-------댓글-------------------------
	
	public List<TrComment> findAllComment(int tr_idx);
	public void updateCommentByIdx(TrComment cvo);
	public void deleteCommentByIdx(int tr_comment_idx);
	public void deleteCommentByTr_idx(int tr_idx);
	public void insertComment(TrComment cvo);
	public void insertReplyComment(TrComment cvo);
	

}
