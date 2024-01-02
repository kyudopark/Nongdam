package kr.co.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.entity.FreeComment;
import kr.co.ezen.entity.TrComment;
import kr.co.ezen.mapper.FreeMapper;

@Service
public class FreeServiceImpl implements FreeService {
	
	@Autowired
	private FreeMapper freemapper;

	@Override
	
	public List<Free> findAll(Criteria cri) {
		List<Free> li=freemapper.findAll(cri);
		return li;
	}


	@Override
	public Free findByidx(int free_idx) {
		Free fre=freemapper.findByidx(free_idx);
		return fre;
	}

	@Override
	public void insert(Free fr) {
		freemapper.insert(fr);
		
	}
	
	@Override
	public int totalCount(Criteria cri) {
		int Counet= freemapper.totalCount(cri);
		return Counet;
}
	
	@Override
	public void deleteByIdx(int free_idx) {
		freemapper.deleteByIdx(free_idx);
	}

	@Override
	public void updateByIdx(Free fr) {
		freemapper.updateByIdx(fr);
	}

	@Override
	public void updatecnt(int free_idx) {
		freemapper.updatecnt(free_idx);
		
	}
	


	
	//====================
	@Override
	public List<FreeComment> findAllComment(int tr_idx) {
		List<FreeComment> cvo = freemapper.findAllComment(tr_idx);
		return cvo;
	}

	@Override
	public void updateCommentByIdx(FreeComment cvo) {
		freemapper.updateCommentByIdx(cvo);
	}

	@Override
	public void deleteCommentByIdx(int tr_comment_idx) {
		freemapper.deleteCommentByIdx(tr_comment_idx);
	}

	@Override
	public void deleteCommentByFree_idx(int free_idx) {
		freemapper.deleteByIdx(free_idx);
	}

	@Override
	public void insertComment(FreeComment cvo) {
		freemapper.insertComment(cvo);
	}

	@Override
	public void insertReplyComment(FreeComment cvo) {
		freemapper.insertReplyComment(cvo);
	}
	//========================================
	

	
}