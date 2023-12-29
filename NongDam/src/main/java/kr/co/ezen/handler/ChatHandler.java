package kr.co.ezen.handler;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import kr.co.ezen.entity.Chat;
import kr.co.ezen.service.ChatService;

//231216
//231218

public class ChatHandler extends TextWebSocketHandler{
	
	//chat/{idx}
	private static Map<String, List<WebSocketSession>> clients = new ConcurrentHashMap<>();
	//chat/user{idx}
	private static Map<String, List<WebSocketSession>> user_clients = new ConcurrentHashMap<>();
	
	@Autowired
	private ChatService chatService;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		//들어온path에서 chat/다음의 값을 가져옴
		String chatroom_idx = getChatroom_idx(session.getUri().getPath());
		
		// /user{idx}로 넘어온 걸로 의심되는 것들을 가져옴
		if(chatroom_idx.length()>=4){
			String isuser = chatroom_idx.substring(0,4);
	        if(isuser.equals("user")) {
	        	try {
	        		
		        	String user_idx = chatroom_idx.substring(4);
		        	if(user_idx != null) {

			        	user_clients.computeIfAbsent(user_idx, k -> new ArrayList<>()).add(session);

			        	
			        	//System.out.println("user_clients 출력 ::: "+user_clients.get(user_idx));
			        	//System.out.println("chat/user로 접속: ["+user_idx+"] 세션 추가함");
			        	return;
    				}
		        	
	        	}catch(Exception e) {
	        		System.out.println("user_clients 추가 중 예외 발생");
	        		e.printStackTrace();
	        		return;
	        	} // catch 끝
	        	
	        }
	    }
		//or
		clients.computeIfAbsent(chatroom_idx, k -> new ArrayList<>()).add(session);
		//System.out.println("chat/로 접속: ["+chatroom_idx+"] 세션 추가함");
	
	}
	
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		Gson gson = new Gson();
		Chat vo = gson.fromJson(message.getPayload(),Chat.class);
		
		//보낸 사람의 chatroom_idx
		String chatroom_idx = Integer.toString(vo.getChatroom_idx());
		//보낸 사람의 chatroom_idx 을 기준으로 해당 방에 접속한 사람들을 찾아냄
        List<WebSocketSession> chatroom_sessions = clients.get(chatroom_idx);
        
        //또한 user{idx}로 접속한 사람들
    	// select user_idx from chatRoom where chatroom_idx=#{chatroom_idx} and user_idx!=#{user_idx}
    	// 인 service문을 가져와서 밑처럼 저장
    	String user_corr_idx = Integer.toString(chatService.findCorr_idx(vo));

        List<WebSocketSession> user_sessions = user_clients.get(user_corr_idx);
    	List<WebSocketSession> sender_sessions = user_clients.get(Integer.toString(vo.getUser_idx()));
    	
    	//room/user{idx}
    	if(user_sessions != null ) {
    		for (WebSocketSession corrSessions : user_sessions) {
    			//System.out.println("O :: 받는 사람 ["+user_corr_idx + "] 세션에게 "+ message +"가 전달됩니다.");
            	corrSessions.sendMessage(message);
    		}
    	}else {
    		//System.out.println("X :: 받는 사람 ["+user_corr_idx+"]의 WebsocketSession이 없음");
    	}
    	
    	if(sender_sessions != null ) {
    		for (WebSocketSession corrSessions : sender_sessions) {
    			//System.out.println("O :: 보낸 사람 ["+vo.getUser_idx() + "] 세션에게 "+ message +"가 전달됩니다.");
            	corrSessions.sendMessage(message);
    		}
    	}else {
    		//System.out.println("X :: 보낸 사람 ["+vo.getUser_idx()+"]의 WebsocketSession이 없음");
    		
    	}
    	//=======================================================
        
        //room/{idx}인경우
        if (chatroom_sessions != null) {
            for (WebSocketSession corrSessions : chatroom_sessions) {
	           if (corrSessions.isOpen() && corrSessions.getId() != session.getId()) {
	            	//System.out.println(corrSessions.getId() + " 에게 "+ message +"가 전달됩니다.");
	            	corrSessions.sendMessage(message);
	            	
	           }else if(corrSessions.isOpen() && corrSessions.getId() == session.getId()){
	            	//자신이 보낸 경우 (room/{idx}의 본인이 전달)
	        		int result = chatService.insert(vo);
	        		//System.out.println("DB 저장 여부:" + result);
	           }
            }
	             
        }
		//=======================================================
	}
	
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		

		String chatroom_idx = getChatroom_idx(session.getUri().getPath());
		List<WebSocketSession> chatroom_sessions = clients.get(chatroom_idx);
		
		if (chatroom_sessions != null) {
        	chatroom_sessions.remove(session);
        	//System.out.println("종료");
            if (chatroom_sessions.isEmpty()) {
            	clients.get(chatroom_idx).remove(session);
           }
        } // if (chatroom_sessions != null)  끝
		 
		if(chatroom_idx.length()>4){
			String isuser = chatroom_idx.substring(0,4);
	        if(isuser.equals("user")) {
	        	String user_idx = chatroom_idx.substring(4);
	        	List<WebSocketSession> user_sessions = user_clients.get(user_idx);
	        	if (user_sessions != null) {
	        		user_sessions.remove(session);
	        		//System.out.println("종료");
	                if (user_sessions.isEmpty()) {
	                	user_clients.remove(user_idx);
	               }
	            }
	        }
	    } //if(chatroom_idx.length()>4) 끝
	
       
		
	}
	
	public String getChatroom_idx(String path) {
		return path.substring(path.lastIndexOf('/') + 1);
	}
	
	
}
