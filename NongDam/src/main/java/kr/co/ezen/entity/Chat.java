package kr.co.ezen.entity;

import java.util.Date;

import lombok.Data;

@Data
public class Chat {

	private int chatroom_idx;
	private int user_idx;
	private String chat_message;
	
	//231217
	private Date chat_time;
	
}
