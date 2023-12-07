package kr.co.ezen.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class Free {
	
	
	private int free_idx;
	private String free_title;
	private String free_content;
	private Date free_date;
	private int user_idx;
	private String free_tag;
	private int free_count;

}
