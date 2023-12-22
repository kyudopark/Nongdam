package kr.co.ezen.entity;

import java.util.Date;

import lombok.Data;

@Data
public class Info {
	
	
	private int info_idx;  
	private int info_title;
	private int info_content;
	private int info_date;
	private Date user_idx;
	private String info_tag;
	private int info_count;
	
	//join
	
	private String user_nickname;
	
}
