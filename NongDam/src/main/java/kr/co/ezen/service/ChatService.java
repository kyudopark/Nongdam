package kr.co.ezen.service;

import java.util.List;

import kr.co.ezen.entity.Chat;
import kr.co.ezen.entity.ChatRoom;

public interface ChatService {
	
	public int findCorr_idx(Chat vo);
	public ChatRoom findChatroom(ChatRoom vo);
	public List<Integer> findR_idxByU_idx(int user_idx);
	public List<ChatRoom> findAllChatroom(int user_idx);
	public ChatRoom isExistence(ChatRoom vo);
	public void createRoom(ChatRoom vo);
	public List<Chat> findChatting(ChatRoom vo);
	public int insert(Chat vo);
	public int disabledRoom(ChatRoom vo);
	

}
