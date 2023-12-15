package kr.co.ezen.entity;

import lombok.Data;
import java.util.*;	

@Data
public class FreeComment {
	
	private int free_idx;  
	private int free_parent_idx;
	private int free_comment_idx;
	private int user_idx;
	private Date tr_comment_time;
	private String free_comment_content;
	private int free_comment_useable;
	
	//join
	
	private String user_nickname;
	private String user_Profile;

}
