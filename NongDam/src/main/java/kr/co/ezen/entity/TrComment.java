package kr.co.ezen.entity;

import java.util.Date;

import lombok.Data;

@Data
public class TrComment {

	private int tr_idx;
	private int tr_parent_idx;
	private int tr_comment_idx;
	private int user_idx;
	private Date tr_comment_time;
	private String tr_comment_content;
	private int tr_comment_useable;
	
	//join
	private String user_nickname;
	private String user_profile;
}
