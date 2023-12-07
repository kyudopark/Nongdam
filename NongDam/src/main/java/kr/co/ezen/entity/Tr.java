package kr.co.ezen.entity;

import java.util.Date;

import lombok.Data;

@Data
public class Tr {
	
	private int tr_idx;
	private String tr_title;
	private String tr_content;
	private String user_idx;
	private String tr_imgpath;
	
	//추가
	private String user_nickname;
	private Date tr_time;


}
