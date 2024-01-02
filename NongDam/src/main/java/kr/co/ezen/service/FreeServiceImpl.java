package kr.co.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.entity.FreeComment;
import kr.co.ezen.entity.FreeHeart;
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
	public void Modify(Free fr) {
		freemapper.updaetByIdx(fr);
	}
	
	@Override
	public List<Free> findfr(Criteria cri) {
		List<Free> fr=freemapper.findfr(cri);
		return fr;
	}

	@Override
	public List<Free> findqu(Criteria cri) {
		List<Free> qu=freemapper.findqu(cri);
		return qu;
	}
	
	@Override
	public void updatecnt(int free_idx) {
		freemapper.updatecnt(free_idx);
		
	}
	
	@Override
	public List<Free> findBydate(Criteria cri) {
		List<Free> fd=freemapper.findBydate(cri);
		return fd;
	}


	@Override
	public List<Free> findBycount(Criteria cri) {
		List<Free> fc=freemapper.findBycount(cri);
		return fc;
	}
	
	@Override
	public List<Free> findBycountfr(Criteria cri) {
		List<Free> cfr=freemapper.findBycountfr(cri);
		return cfr;
	}


	@Override
	public List<Free> findBycountqu(Criteria cri) {
		List<Free> cqu=freemapper.findBycountqu(cri);
		return cqu;
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