package kr.co.ezen.entity;

import java.util.Date;

import lombok.Data;

@Data
public class Info {
	
	private int info_idx;  
	private String info_title;
	private String info_content;
	private Date info_date;
	private int user_idx;
	private String info_tag;
	private int info_count;
	private int info_boomup;
	private String info_imgpath;
	
//join
	private String user_nickname;
	
}
