package kr.co.ezen.service;

import java.util.List;
import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.entity.FreeComment;

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
	public void updateByIdx(Free fr);


	
	//조회수 증가 
	public void updatecnt(int free_idx);

	
	//댓글===================================
	public List<FreeComment> findAllComment(int tr_idx);
	public void updateCommentByIdx(FreeComment cvo);
	public void deleteCommentByIdx(int free_comment_idx);
	public void deleteCommentByFree_idx(int free_idx);
	public void insertComment(FreeComment cvo);
	public void insertReplyComment(FreeComment cvo);
	//======================================
}
