package kr.co.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ezen.entity.Chat;
import kr.co.ezen.entity.ChatRoom;
import kr.co.ezen.mapper.ChatMapper;

@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatMapper chatMapper;

	@Override
	public int findCorr_idx(Chat vo) {
		
		return chatMapper.findCorr_idx(vo);
	}

	@Override
	public ChatRoom findChatroom(ChatRoom vo) {
		return chatMapper.findChatroom(vo);
	}

	@Override
	public List<Integer> findR_idxByU_idx(int user_idx) {
		return chatMapper.findR_idxByU_idx(user_idx);
	}

	@Override
	public List<ChatRoom> findAllChatroom(int user_idx) {
		return chatMapper.findAllChatroom(user_idx);
	}

	@Override
	public ChatRoom isExistence(ChatRoom vo) {
		return chatMapper.isExistence(vo);
	}

	@Override
	public void createRoom(ChatRoom vo) {
		chatMapper.createRoom(vo);
	}

	@Override
	public List<Chat> findChatting(ChatRoom vo) {
		List<Chat> li = chatMapper.findChatting(vo);
		return li;
	}

	@Override
	public int insert(Chat vo) {
		return chatMapper.insert(vo);
	}

	@Override
	public int disabledRoom(ChatRoom vo) {
		return chatMapper.disabledRoom(vo);
	}

	

}
