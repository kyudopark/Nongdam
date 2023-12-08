package kr.co.ezen.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;


public interface FreeService {
	
	//게시글 전체 보기 
	public List<Free> findAll(Criteria cre);
	//idx값을 기준으로 게시글 조회
	public Free findByidx(int idx);
	//글쓰기
	public void insert(Free fr);
	
}
