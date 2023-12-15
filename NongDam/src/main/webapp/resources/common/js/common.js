
	/* 채팅방 오픈 함수 */
	function openChat(){
	    window.open("${contextPath}/chat/list","채팅하기","width=400, height=500, left=100, top=50");
	}
	
	$(document).ready(function(){
	    //문서 준비 완료되었을때 ckEditor부분 다크모드 관련 클래스 추가
	    //css도 따로 하나 들어가있음(바로 밑에 있는 스타일태그)
	    //굳이 여기 있을 필요는 없긴 한데 일단 여기에 넣어놓음
	    $('.ck-editor__main').addClass('bg-body');
	
	    //헤더 버거메뉴
	    $('#header-button').click(function(){
	        $('.collapse').slideToggle();
	    })
	
	    
	   
	    //document.ready 끝
	});
