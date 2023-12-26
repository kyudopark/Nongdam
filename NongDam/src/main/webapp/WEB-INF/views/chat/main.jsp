<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<fmt:formatDate var="today" value="<%=new java.util.Date() %>" type="date" />

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
	var webSocket = new WebSocket('ws://localhost:8080/ezen/chat/user${uvo.user_idx}');

	
	//============================================
	webSocket.onopen = function(e){
		console.log("웹소켓 서버에 연결되었습니다.");
	}
	webSocket.onclose = function(e){
		console.log("웹소켓 서버가 종료되었습니다.");
	}
	webSocket.onerror = function(e){
		console.log(e);
		alert("오류로 인해 웹소켓 서버가 종료되었습니다. 새로고침 또는 로그인을 다시 해주세요.");
	}
	webSocket.onmessage = function(event){
		update();
	}
	
	function update(){
		location.reload(true);
	}
	
	
	</script>
</head>
<body class="d-flex flex-column justify-content-between" style="min-height: 100vh;height: 100vh;max-height: 100vh;">

    <div id="header" class="bg-body-tertiary bg-gradient border-bottom">
        <div class="container">
            <div class="nav navbar text-muted">
                <div class="fw-bold fs-5 d-flex gap-2 align-items-center">
                	<!-- ~231222 laky -->
                    <i class="fa-solid fa-comments fa-xs" style="width: 18px;"></i>
                    <div>채팅 리스트 ${uvo.user_name }</div>
                </div>
                
            </div>
        </div>
    </div>
    <!--채팅방 내부 -->
    <div id="viewDiv" class="bg-body container overflow-y-scroll p-0 pb-4 h-100" >
        <ol id="viewOl" class="list-group list-group-numbered">
        	<c:if test="${empty crvo }">
        		<li class="w-100 pt-3">
        			<div class="text-center text-muted">
	        			아직 채팅방이 없습니다.
	        			<br>
	        			1:1거래 게시판에서 채팅을 시작해보세요!
        			</div>
        		</li>
        	</c:if>
            <c:forEach var="crvo" items="${crvo }">
	            <!-- 상대 채팅 -->
	            <li class="p-2 pt-3 pb-3 d-flex flex-column align-items-start border-bottom">
	                <a href="${contextPath }/chat/room/${crvo.chatroom_idx}" 
	                	class="text-body" style="text-decoration: none;">
	                <div class="d-flex flex-row align-items-center">
	                	<c:if test="${crvo.user_corr_profile == null}">
	                    	<img class="bg-body-secondary object-fit-cover me-2 border"
	                        style="height: 40px; width: 40px; border-radius: 50%;"
	                        src="${contextPath }/resources/image/common/thumbnail-profile-seed.svg">
	                    </c:if>
	                    <c:if test="${crvo.user_corr_profile != null}">
	                    	<img class="bg-body-secondary object-fit-cover me-2 border"
	                        style="height: 40px; width: 40px; border-radius: 50%;"
	                        src="${contextPath }/resources/image/myPage/${crvo.user_corr_profile}" >
	                    </c:if>
	                    <div>
	                        <div class="title-overflow-1">
	                            <span class="fw-bold">${crvo.user_corr_name }</span>
	                            <span class="text-muted" style="font-size: small;">
	                            	<c:if test="${today >= crvo.last_chat_time }">
	                            		<fmt:formatDate value="${crvo.last_chat_time }" type="date" dateStyle="long"/>
	                            	</c:if>
	                            	<c:if test="${today < crvo.last_chat_time }">
	                            		<fmt:formatDate value="${crvo.last_chat_time }" type="time" timeStyle="short" />
	                            	</c:if>
	                            </span>
	                        </div>
	                        <div class="title-overflow-1">${crvo.last_chat_message }</div>
	                    </div>
	                </div>
	                </a>
	            </li>
	            <!-- 상대 채팅 끝 -->
           	</c:forEach>
        </ol>
    </div>
	<!-- 채팅방 끝 -->

	<style>
	    ::-webkit-scrollbar {
		  width: 10px;
		}
		
		::-webkit-scrollbar-thumb {
		  background-color: var(--bs-tertiary-bg-rgb);
		}
		
		::-webkit-scrollbar-track {
		  background-color: var(--bs-tertiary-bg-rgb);
		}
	
	</style>
   
</body>
</html>