package kr.co.ezen.entity;


import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class Free {
	
	
	private int free_idx;
	private String free_title;
	private String free_content;
	private Date free_date;
	private String user_idx;
	private String free_tag;
	private int free_count;
	
	//조인
	
	private String user_nickname;

}


