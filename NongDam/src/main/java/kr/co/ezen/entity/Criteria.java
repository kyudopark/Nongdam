package kr.co.ezen.entity;

import lombok.Data;

@Data
public class Criteria {
	//231205
	//검색, 페이징을 위한 객체입니다.
	//필요한 부분은 전부 들어있으므로 수정하지 말아주세요!!
	
	
	private int page; //현재 페이지번호
	private int perPageNum; //한 페이지에 보여줄 게시글 개수
	
	//검색기능을 위한 필드 추가
	private String type;
	private String keyword;
	
	private String tag;
	
	
	public Criteria() { //기본생성자
		this.page= 1;
		this.perPageNum = 12; //페이지에 들어가는 게시글 개수
	}
	
	//현재 페이지 게시글 시작번호
	public int getPageStart() {
		// 1~10 1 / 11~20 2 / 21~30 3
		return (page-1)*perPageNum; 
	}
}
