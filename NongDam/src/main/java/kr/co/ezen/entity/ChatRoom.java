package kr.co.ezen.entity;

import java.util.Date;

import lombok.Data;

//231217
@Data
public class ChatRoom {
	
	private int chatroom_idx;
	private int user_idx;
	private int user_corr_idx;

	private Date chat_disabled_time;

	private String user_corr_name;
	//231219 14:28
	private String user_corr_profile;
	private Date last_chat_time;
	private String last_chat_message;
	
}
