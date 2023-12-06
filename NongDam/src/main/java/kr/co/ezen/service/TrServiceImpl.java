package kr.co.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Tr;
import kr.co.ezen.entity.TrComment;
import kr.co.ezen.mapper.TrMapper;

@Service
public class TrServiceImpl implements TrService {
	
	@Autowired
	private TrMapper trMapper;


	@Override
	public void updateByIdx(Tr vo) {
		trMapper.updateByIdx(vo);
	}

	@Override
	public void deleteByIdx(int tr_Idx) {
		trMapper.deleteByIdx(tr_Idx);
	}

	@Override
	public List<Tr> findAll(Criteria cri) {
		List<Tr> li= trMapper.findAll(cri);
		return li;
	}

	@Override
	public Tr findByIdx(int tr_idx) {
		Tr trinfo = trMapper.findByIdx(tr_idx);	
		return trinfo;
	}

	@Override
	public int totalCount(Criteria cri) {
		int count =trMapper.totalCount(cri);
		return count;
	}


	@Override
	public void insert(Tr vo) {
		trMapper.insert(vo);
	}

	//---------------------------------------

	@Override
	public List<TrComment> findAllComment(int tr_idx) {
		List<TrComment> cvo = trMapper.findAllComment(tr_idx);
		return cvo;
	}

	@Override
	public void updateCommentByIdx(TrComment cvo) {
		
		
	}

	@Override
	public void deleteCommentByIdx(int tr_comment_idx) {
	
	}

	@Override
	public void deleteCommentByTr_idx(int tr_idx) {
	
	}

	@Override
	public void insertComment(TrComment vo) {

	}

	@Override
	public void insertReplyComment(TrComment vo) {

	}

}
