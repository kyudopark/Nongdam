package kr.co.ezen.mapper;

import java.util.List;


import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.entity.FreeComment;

public interface FreeMapper {
	
	public List<Free> findAll(Criteria cri);
	public void insert(Free fr);
	public Free findByidx(int free_idx);
	public int totalCount(Criteria cre);
	public void updatecnt(int free_idx);
	public void deleteByIdx(int free_idx);
	public void updateByIdx(Free fr);
	public Free read(int free_idx);
	public Free getUserIdx(String user_nickname);
	public void Modify(Free fr);

	
	//-------댓글-------------------------
	
	public List<FreeComment> findAllComment(int free_idx);
	public void updateCommentByIdx(FreeComment cvo);
	public void deleteCommentByIdx(int free_comment_idx);
	public void deleteCommentByFree_idx(int free_idx);
	public void insertComment(FreeComment cvo);
	public void insertReplyComment(FreeComment cvo);
		
	
}
