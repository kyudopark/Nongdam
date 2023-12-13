
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
	
	    //임시
	    //넘길때 header의 로고, 자유게시판, 글쓰기버튼에 id정보 없애야 함
	    for(let i=1;i<=5;i++){
	        $('#a'+i+'button').click(function(){
	            for(let a=1;a<=5;a++){
	                $('#a'+a).hide();
	            }
	            $('#a'+i).show();
	
	            if(i == 2){
	                $('#ahead').hide();
	            }else if(i == 5){
	                $('#ahead').show();
	                $('#ahead h4').text('마이페이지');
	                $('#ahead p').html('회원정보를 열람하고 수정할 수 있는 페이지입니다.<br>서브타이틀은 두줄까지 작성할 수 있습니다.');
	            }else{
	                $('#ahead').show();
	                $('#ahead h4').text('자유게시판');
	                $('#ahead p').html('모두가 자유롭게 정보를 주고받을 수 있는 게시판입니다.<br>서브타이틀은 두줄까지 작성할 수 있습니다.');
	            }
	        });
	    }
	   
	    //document.ready 끝
	});
