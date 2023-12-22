<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<html lang="ko" data-bs-theme="light">
<head>
     <!-- UTF-8 사용-->
    <meta charset="UTF-8">
    <!-- 기본 화면 보기 설정 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	
    <!-- bootstrap 5.3.2 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>

    <!--제이쿼리-->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    
    <!-- ckEditor 5 -->
    <script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/ckeditor.js"></script>

    <!-- fontAwesome -->
    <script src="https://kit.fontawesome.com/f34a67d667.js" crossorigin="anonymous"></script>
    
    <!-- 스타일시트 -->
    <link rel="stylesheet" href="${contextPath }/resources/common/css/style.css">
    <!-- 기본js -->
    <script type="text/javascript" src="${contextPath }/resources/common/js/common.js"></script>
    <script type="text/javascript" src="${contextPath }/resources/common/js/darkmode.js"></script>
    <meta name="농담" content="안녕하세요, 농업 정보 커뮤니티 농담입니다."/>
    
    <!-- 파비콘 -->
    <link rel="icon" type="image/x-icon" href="${contextPath }/resources/image/common/favicon.ico"/>
    <link rel="shortcut icon" type="image/x-icon" href="${contextPath }/resources/image/common/favicon.ico"/>
    
    <title>농담 | 농업 정보 커뮤니티</title>
  
    
    <script type="text/javascript">
	var webSocket = new WebSocket('ws://localhost:8080/ezen/chat/${chatroom_idx}');
	
	var insertdate;
	function dateupdate(chat_time){
		if(insertdate != chat_time){
			let appendDate = "<li class='mt-4 mb-4 pt-0 row align-items-center w-100 ps-4'>";
			appendDate += "<span class='w-50 ms-auto me-auto badge rounded-pill text-bg-secondary'>";
			appendDate += chat_time;
			appendDate += "</span></li>";
			$('#viewOl').append(appendDate);
			
			insertdate = chat_time;
			findlastuser('');
		}
	}
	var lastuser;
	function findlastuser(user_idx){
		if(lastuser != user_idx){
			lastuser = user_idx;
		}else{
			$('#viewOl li:last .name').addClass("d-none");
		}
		if(lastuser == null || lastuser == ''){
			lastuser = user_idx;
		}
	}
	
	$(document).ready(function(){
		scroll();
	})
    function scroll(){
        var viewDiv = document.getElementById("viewDiv");
        viewDiv.scrollTop = viewDiv.scrollHeight;
    }
	function chat_time_fmt(chat_time){
		return String(chat_time.getHours()).padStart(2, "0") + ":" + String(chat_time.getMinutes()).padStart(2, "0");
	}
	function chat_date_fmt(chat_time){
		return chat_time.getFullYear()+"-"+String(chat_time.getMonth()+1).padStart(2, "0")+"-"+String(chat_time.getDate()).padStart(2, "0");
	}
	function chat_message_filtering(chat_message){
		chat_message = chat_message.replaceAll("<", "&lt;");
		chat_message = chat_message.replaceAll(">", "&gt;");
		chat_message = chat_message.replaceAll("\\(", "&#40;");
		chat_message = chat_message.replaceAll("\\)", "&#41;");
		chat_message = chat_message.replaceAll("'", "&#x27;");
		return chat_message;
	}
	function enterKey(){
		if(window.event.keyCode==13){
			sendMessage();
		}
	}
	
	function disabledRoom(){
		
		let result = confirm('정말 채팅방을 나가시겠습니까? 나가기 이전의 채팅 내역은 복원되지 않습니다.');
		
		if(result == false){
			return;
		}else{
			let chatroom_idx = parseInt($('#chatroom_idx').val());
			let user_idx = parseInt($('#user_idx').val());
			
			$.ajax({
				url:"disabledRoom",
				type:"post",
				data:{'user_idx':user_idx,
					'chatroom_idx':chatroom_idx},
				success:function(data){
					alert("채팅방이 삭제되었습니다. 채팅방 리스트로 돌아갑니다.");
					location.href="${contextPath}/chat/main";
				},
				error:function(){
					alert("에러 발생. 다시 시도해 주세요.");
				}
			});
		}
		
	}
	
	//============================================
	function myMessage(data){
		let chat_time = chat_time_fmt(data.chat_time);
		let myMessages;
		
          
		myMessages = "<li class='p-2 pb-1 d-flex flex-column align-items-end'>";
		myMessages += "	<div class='name'>${uvo.user_name }</div>";
		myMessages += "		<div class='d-flex flex-row  align-items-end justify-content-end w-100'>";
		myMessages += "			<div class='d-inline-block text-secondary' style='margin-right: 4px; margin-bottom: 2px;'>";
		myMessages += 				chat_time;
		myMessages += "			</div>";
		myMessages += " 	<div class='p-3 bg-secondary bg-gradient text-light rounded-start-4 rounded-bottom-4 text-break' ";
		myMessages += "		style='width: auto; max-width: 70% '>";
		myMessages += "			<span>"+data.chat_message+"</span>";
		myMessages += "		</div>";
		myMessages += "	</div>";
		myMessages += "</li>";

		
		return myMessages;
	}	
	function corrMessage(data){
		let chat_time = chat_time_fmt(data.chat_time);
		
		let corrMessages;
		corrMessages = "<li class='p-2 d-flex flex-column align-items-start'>";
		corrMessages += " 	<div class='name'>${room.user_corr_name }</div>";
		corrMessages += "	<div class='d-flex flex-row align-items-end w-100'>";
		corrMessages += "		<div class='p-3 bg-body-secondary bg-body-gradient text-body-light rounded-end-4 rounded-bottom-4' ";
		corrMessages += "		style='width: auto; max-width: 70% '>";
		corrMessages += 			data.chat_message
		corrMessages += "		</div>";
		corrMessages += "		<div class='d-inline-block text-secondary' style='margin-left: 4px; margin-bottom: 2px;'>";
		corrMessages += 			chat_time;
		corrMessages += "		</div>";
		corrMessages += "	</div>";
		corrMessages += "</li>";
	
		
		return corrMessages;
	}
		
		
	//============================================
	//전송
	function sendMessage(){
		let chatroom_idx = parseInt($('#chatroom_idx').val());
		let user_idx = parseInt($('#user_idx').val());
		let chat_message = $('#chatMessage').val();
		chat_message = chat_message_filtering(chat_message);
		let chat_time = new Date();
		
		if(chat_message.length = 0 || chat_message == null || chat_message == ''){
			alert("채팅 내용을 작성해 주세요.");

		} else{
	
			let vo = {'user_idx' : user_idx,
					'chatroom_idx': chatroom_idx,
					'chat_message' : chat_message,
					'chat_time' : chat_time};
			
			webSocket.send(JSON.stringify(vo)); //전송
			$('#chatMessage').val("");
			$('#chatMessage').focus();
			let chat_date = chat_date_fmt(chat_time);
			dateupdate(chat_date);
			let message = myMessage(vo);
			$('#viewOl').append(message);
			findlastuser(user_idx);
			scroll();
		}
	}
	
	function disconnect(){
		webSocket.close();
	}
	
	
	//============================================
		
	webSocket.onopen = function(e){
		console.log("웹소켓 연결 성공.");

	}
	webSocket.onclose = function(e){
		$('#viewOl').append("<span class='w-50 mt-4 mb-4 ms-auto me-auto badge rounded-pill text-bg-secondary'>웹소켓 서버가 종료되었습니다.</span>");
	}
	webSocket.onerror = function(e){
		console.log(e);
		$('#viewOl').append("<span class='w-50 mt-4 mb-4 ms-auto me-auto badge rounded-pill text-bg-danger'>연결 중 에러가 발생했습니다.</span>");
	}
	webSocket.onmessage = function(event){
		let data = JSON.parse(event.data);
		data.chat_time = new Date(data.chat_time);
		let chat_date = chat_date_fmt(data.chat_time);
		dateupdate(chat_date);
		data.chat_message = chat_message_filtering(data.chat_message);
		
		//appendmessage
		if(data.user_idx == ${uvo.user_idx}){
			let message = myMessage(data);
			$('#viewOl').append(message);
		}else{
			let messagea = corrMessage(data);
			$('#viewOl').append(messagea);
		}
		findlastuser(data.user_idx);
		scroll();
	}
	
	
	</script>
    
</head>

<body class="d-flex flex-column justify-content-between" style="min-height: 100vh;height: 100vh;max-height: 100vh;">


	<input type="hidden" id="user_idx" value="${uvo.user_idx }" readonly />
	<input type="hidden" id="chatroom_idx" value="${chatroom_idx }" readonly />



    <!--위-->
    <div id="header" class="bg-body-tertiary bg-gradient border-bottom">
        <div class="container">
            <div class="nav navbar">
            <!-- ~231222 laky -->
                <div class="fw-bold fs-5 d-flex gap-2 align-items-center">
                	<c:if test="${empty room.user_corr_profile }">
                    	<img src="${contextPath }/resources/image/common/thumbnail-profile-seed.svg"
                    	style="width: 22px; height: 22px; border-radius: 50%;"
                     	class="object-fit-cover bg-body-secondary">
                    </c:if>
                    <c:if test="${!empty room.user_corr_profile }">
                    	<img src="${contextPath }/resources/image/myPage/${room.user_corr_profile }"
                    	style="width: 22px; height: 22px; border-radius: 50%;"
                     	class="object-fit-cover bg-body-secondary">
                    </c:if>
                     
                    <div>${room.user_corr_name }</div>
                </div>
                <div class="dropdown">
                    <a class="text-secondary" href="#" 
                    role="button" data-bs-toggle="dropdown" aria-expanded="false">
                       <i class="fa-solid fa-bars"></i>
                    </a>
                  
                    <ul class="dropdown-menu dropdown-menu-end">
                      <li><a class="dropdown-item" href="javascript:disabledRoom()">채팅방 삭제</a></li>
                      <li><a class="dropdown-item" href="${contextPath }/chat/main">채팅방 리스트로</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!--채팅방 내부 -->
    <div id="viewDiv" class="container overflow-y-scroll p-0 ps-2 pe-1 pb-4 h-100" >
        <ol id="viewOl" class="list-group list-group-numbered">
        	<script>
        		dateupdate(insertdate)
        	</script>
            <c:forEach items="${li }" var="li">
            	<script>
					dateupdate("<fmt:formatDate value='${li.chat_time }' pattern='YYYY-MM-dd'/>")
				</script>
				<c:if test="${li.user_idx == uvo.user_idx }">
		            <!-- 내 채팅 -->
		            <li class='p-2 pb-1 d-flex flex-column align-items-end'>
		                <div class='name'>${uvo.user_name }</div>
		                <div class='d-flex flex-row  align-items-end justify-content-end w-100'>
		                    <div class='d-inline-block text-secondary' style='margin-right: 4px; margin-bottom: 2px;'>
		                        <fmt:formatDate value="${li.chat_time }" pattern="HH:mm"/>
		                    </div>
		                    <div class='p-3 bg-secondary bg-gradient text-light rounded-start-4 rounded-bottom-4 text-break' 
		                    style='width: auto; max-width: 70% '>
		                        <span>
		                        	${li.chat_message }
		                        </span>
		                    </div>
		                </div>
		            </li>
		            <!-- 내 채팅 끝 -->
	            </c:if>
				<c:if test="${li.user_idx != uvo.user_idx }">
		            
					<!-- 상대 채팅 -->
		            <li class='p-2 d-flex flex-column align-items-start'>
		                <div class='name'>${room.user_corr_name }</div>
		                <div class='d-flex flex-row align-items-end w-100'>
		                    <div class='p-3 bg-body-secondary bg-body-gradient text-body-light rounded-end-4 rounded-bottom-4' 
		                    style='width: auto; max-width: 70% '>
		                        ${li.chat_message }
		                    </div>
		                    <div class='d-inline-block text-secondary' style='margin-left: 4px; margin-bottom: 2px;'>
		                        <fmt:formatDate value="${li.chat_time }" pattern="HH:mm"/>
		                    </div>
		                </div>
		            </li>
		            <!-- 상대 채팅 끝 -->
		            
				</c:if>
				<script>
					findlastuser(${li.user_idx})
				</script>
			</c:forEach>
            
        </ol>
    </div>
    <!--하단-->
    <div id="footer" class="container pt-3 pb-3 mt-0 mb-0 border-top d-flex  bg-body-tertiary">
        <div class="input-group p-0 border bg-body rounded-3">
            <textarea type="text" class="m-2 form-control-plaintext d-inline-block"
            id="chatMessage" onkeyup="enterKey()"></textarea>
            <button class="btn btn-sm btn-secondary ms-auto" 
	            type="button"
	            id="sendBtn" onclick="sendMessage()">&uparrow;</button>
        </div>
    </div>

	<style>
		::-webkit-scrollbar {
		  width: 10px;
		}
		
		::-webkit-scrollbar-thumb {
		  background-color: var(--bs-body-color);
		}
		
		::-webkit-scrollbar-track {
		  background-color: var(--bs-tertiary-bg-rgb);
		}
	
	</style>
   
</body>
</html>