package kr.co.ezen.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.ezen.entity.Chat;
import kr.co.ezen.entity.ChatRoom;
import kr.co.ezen.entity.User;
import kr.co.ezen.service.ChatService;

@Controller
@RequestMapping("/chat/**")
public class ChatController {

	@Autowired
	private ChatService chatService;

	@GetMapping("/main")
	public String main(HttpSession session, Model m) {
		
		User uvo = (User) session.getAttribute("uvo");
		if(uvo == null) {
			return "redirect:/";
		}else {
			int user_idx = uvo.getUser_idx();
			List<ChatRoom> crvo = chatService.findAllChatroom(user_idx);
			m.addAttribute("crvo",crvo);
		}
				
		return "chat/main";
		//끝. 추가할 부분 없음. 
	}
	
	
	//==========================================================================
	
	
	
	//chat/room?user_corr_idx=
	@GetMapping("/enterRoom")
	public String enterRoom(HttpSession session, int user_corr_idx){
		
		User uvo = (User) session.getAttribute("uvo");
		
		if(uvo == null){
			//로그인되어있지 않음
			//System.out.println("로그인되어있지 않음.");
			return "redirect:/user/login";
		}else if(uvo.getUser_idx() == user_corr_idx){
			//만드려는 방이 자기 자신과의 방임
			//System.out.println("같은 idx로 방을 찾으려 함.");
			return "redirect:/chat/main";
		}
	
		//방이 있는지 확인하기 위해 user_idx 두개를 crvo에 세팅함.
		ChatRoom crvo = new ChatRoom();
		crvo.setUser_idx(uvo.getUser_idx());
		crvo.setUser_corr_idx(user_corr_idx);
	
		//방이 있는지 없는지 반환
		ChatRoom roomIsExstence = chatService.isExistence(crvo);
	
		if(roomIsExstence != null){
			//System.out.println("roomIsExstence!=null");
			//방이 이미 있으면 
			//방 번호를 가져오고
			int chatroom_idx = roomIsExstence.getChatroom_idx();

			return "redirect:/chat/room/"+chatroom_idx ;
			
		} else{ 
			//System.out.println("roomIsExstence==null");
			//없으면 
			//방 만들어주고
			//방 다시 찾아서 리다이렉트
			chatService.createRoom(crvo);
			//System.out.println("createRoom");
			ChatRoom room = chatService.isExistence(crvo);
			//System.out.println("isExistence");
			if(room != null) {
				//System.out.println("room != null");
				int chatroom_idx = room.getChatroom_idx();
				return "redirect:/chat/room/"+chatroom_idx; 
			}else {
				//System.out.println("room == null");
				return "redirect:/chat/main";
			}
		 }
	}
	
	
	//==========================================================================
	
	
	
	@RequestMapping("/room/{chatroom_idx}")
	public String room(Model m,@PathVariable("chatroom_idx") int chatroom_idx,HttpSession session) {
		
		User uvo = (User) session.getAttribute("uvo");
		int user_idx = uvo.getUser_idx();
		
		ChatRoom crvo = new ChatRoom();
		crvo.setChatroom_idx(chatroom_idx);
		crvo.setUser_idx(user_idx);

		ChatRoom room = chatService.findChatroom(crvo);
		
		if(room == null) { 
			//System.out.println("room/{chatroom_idx}에서 null 반환됨");
			return "redirect:/chat/main"; 
			
		}else { 
			
			List<Chat> li = chatService.findChatting(room); 
			m.addAttribute("room", room);
			m.addAttribute("li", li); 
			
		}
		
		return "chat/room";
	}

	
	//==========================================================================
	@PostMapping("/disabledRoom")
	public @ResponseBody void disabledRoom(ChatRoom vo) {
		chatService.disabledRoom(vo);
		
	}
}
