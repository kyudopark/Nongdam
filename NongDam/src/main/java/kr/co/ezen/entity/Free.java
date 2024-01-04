package kr.co.ezen.entity;

import java.util.Date;
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
	
	private String user_nickname;
	private int freeCount;

}


