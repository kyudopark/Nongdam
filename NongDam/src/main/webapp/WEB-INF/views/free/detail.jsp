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
    
    <meta name="농담" content="안녕하세요, 농업 정보 커뮤니티 농담입니다."/>
    
    <!-- 파비콘 -->
    <link rel="icon" type="image/x-icon" href="${contextPath }/resources/image/common/favicon.ico"/>
    <link rel="shortcut icon" type="image/x-icon" href="${contextPath }/resources/image/common/favicon.ico"/>
    
    <title>농담 | 농업 정보 커뮤니티</title>
    
   <script type="text/javascript">
    
   
    $(document).ready(function(){
    	findAllComment();
    })
    
    function findAllComment() {
    	
        let free_idx = $("#free_idx").val();
        $.ajax({
            url: "findAllComment",
            type: "get",
            data: { "free_idx":free_idx  },
            dataType: "json",
            success: CommentAll,
            error: function () {
                alert("에러 발생");
            }
        });
    }
            
    function CommentAll(data){
       	var dt=new Date();
       	let dat;
       	let commentlist="";
       	
   	  	$.each(data, function(index, obj) {
     		  
     		  dt.setTime(obj.free_comment_time);
     		  
     		  //date 객체
     		  dat=dt.toISOString().replace(/T/, ' ').replace(/\..+/, '');
     		  
     		  //이스케이프 랜더링 작업 (HTML깨지지 않게 오류 방지 )
     		  obj.free_comment_content = obj.free_comment_content.replaceAll("\\(", "&#40;");
			  obj.free_comment_content = obj.free_comment_content.replaceAll("\\)", "&#41;");
			  obj.free_comment_content = obj.free_comment_content.replaceAll("\n", "<br/>");
     		  
     		commentlist +='<div class="p-3 mt-3 mb-3 d-flex flex-nowrap gap-1">';
 	    if(obj.free_parent_idx != obj.free_comment_idx){ //답글 여부 
 	    	commentlist += "		<div class=ms-2></div>";
 	    }
 	    	commentlist += 	"<div style='margin-top:2px;width: 22px; height: 22px; border-radius: 50%; display: flex; justify-content: center; align-items: center; '>";
 	    
 	    if (obj.user_profile == null || obj.user_profile == '') {
 	    	commentlist += "	<img class='object-fit-cover' style='width: 22px; height: 22px; border-radius: 50%;'";
 	    	commentlist += '	 src="${contextPath}/resources/image/common/thumbnail-profile-seed.svg">';
         } else {
        	 commentlist += "	<img class='object-fit-cover' style='width: 22px; height: 22px; border-radius: 50%;'";
  	    	commentlist += '	 src="' + obj.user_profile + '">';
         }	
 	    	commentlist += "	</div>";
 	    	//댓글 필수 컨텐츠
 	    	commentlist += "<div class='w-100' id='comment"+obj.free_comment_idx+"'>";
 	    	commentlist += "	<div>";
 	    	commentlist += "			<h6 class='d-inline-block'>";
 	    	commentlist += 				obj.user_nickname;
 	       	    if(${vo.user_idx==obj.user_idx}){
 	       	commentList += "		<span class='badge text-bg-secondary'>작성자</span>"
 	       	    }	
     		//댓글 필수 컨텐츠
     		 commentlist += "		</h6>";
     		 commentlist += "	<small class='text-secondary'>"+dat+"</small>";
     		 commentlist += "	</div>";
     		 
      		 if(obj.free_comment_useable == 1) { //삭제여부 확인 1이 기본. 
      		 commentlist += "	<div class='pb-2' id='free_comment" + obj.free_comment_idx + "'>";
      		 commentlist += " 			<div class='ViewComment text-break pb-1'>"+obj.free_comment_content+"</div>";	
      		 commentlist += "					<c:if test='${!empty uvo}'>";
      		 commentlist += "						<div class='updateComment pb-1'>";
      		 
      		 commentlist += "                        <form>";
      		 // 수정 부분 .버튼을 누르면 수정 가능하게끔 					
      		 commentlist += "					<textarea class='form-control' id='textarea'>"+obj.free_comment_content+"</textarea>";
             commentlist += "								<button type='button' class='btn btn-sm btn-secondary mt-2'";
      		 commentlist += "								onclick='updateComment(" + obj.free_comment_idx + ")'>수정하기</button>";
      		 commentlist += "						</form>";
      		 commentlist += "						</div>";
      		 commentlist += "						<small class='d-flax flex-nowrap gap-2'>";
      		 //idx값 서로 비교 
      		 if(obj.free_parent_idx == obj.free_comment_idx){	
      			 //호출해도 상단으로 올라가지 않고 이동하지 않는다
      		 commentlist += "							<a href='javascript:replyCommentButton("+ obj.free_comment_idx +")' class='text-secondary text-decoration-none'>답글</a>";
      		}
      		 if(obj.user_idx==${uvo.user_idx}||${uvo.user_admin}==true){ //idx값 비교
   			 if(obj.user_idx == ${uvo.user_idx}) {
      		 commentlist += "					<a href='javascript:updateCommentBy("+ obj.free_comment_idx +")' class='text-secondary text-decoration-none'>수정</a>";	 
      	     }
      	     commentlist += "						<a href='javascript:deleteCommentByIdx("+ obj.free_comment_idx+ ")' class='text-secondary text-decoration-none'>삭제</a>";
      		 }     		 

      		 commentlist += "						</small>";
      		 commentlist += "					</c:if>";
      		 commentlist += "	</div>";
      		 }else {//useablel이 1이 아니라면
      		 commentlist += "<div class='pb-2'>";
      		 commentlist += "	<div class='text-muted'>삭제된 댓글 입니다.</div>";
      		 commentlist += "</div>";
      		 }
      		 
      		 if(obj.free_parent_idx == obj.free_comment_idx) {
      		 commentlist += "		<form class='mt-2' id='replyCommentForm' style='display:none'>";
      		 
      		 commentlist += " 		<h6 class='border-top pt-2'>답글달기</h6>";
      		 commentlist += "			<textarea class='form-control free_comment_content' id='reply'></textarea>";
      		 commentlist += "			<button type='button' onclick='replyComment("+obj.free_parent_idx+")'";
      		 commentlist += "			class='btn btn-sm btn-secondary mt-2 ms-auto'>등록하기</button>";
               
               commentlist += "		</form>";
      		 }
      		 	
               commentlist += "		</div>";
               commentlist += "	</div>";
      		 	
      		 })//each 끝
        		 
        if (commentlist !== "") { // comment가 있다면
		    $("#ViewComment").html(commentlist); // comment를 HTML로 추가
		   	$('.updateComment').hide();
			
		}
        	  textareaResizing();
       
      } //commentAll 끝
        	
       function insertCommentclick() {
            let free_comment_content = $('#free_comment_content').val();
            if (free_comment_content.length < 2) {
                alert("댓글을 입력해주세요");
                return;
            }

            const cmt=$('#InsertComment').serialize();

            $.ajax({
                url: "insertComment",
                type: "post",
                data: cmt,
                success: function (data) {
                    alert("입력되었습니다.");
                    $("#InsertComment")[0].reset();
                    findAllComment();
                },
                error: function () {
                    alert("에러 발생");
                }
            });
        } //insertCommentclick() 끝
        
        //수정부분 ajax
       //------------------------------------------------------------------------
        function updateCommentBy(free_comment_idx){
            $('#free_comment'+free_comment_idx).children('.ViewComment').toggle();
            $('#free_comment'+free_comment_idx).children('.updateComment').toggle();
            $('#comment'+free_comment_idx+" .replyComment").hide();
        }

        function updateComment(free_comment_idx){
        	
            let free_comment_content = $('#textarea').val();
            if(free_comment_content.length < 2){
                alert("댓글을 입력해주세요.");
                return;
            }
        
            $.ajax({
                url:"updateComment",
                type:"post",
                data:{"free_comment_idx":free_comment_idx, "free_comment_content":free_comment_content},
                success:function(data){
                    alert("댓글이 수정되었습니다.");
                    findAllComment();
                },
                error:function(){
                    alert("error");
                }
            })
        }
        
        //대댓글 관련 ajax ---------------------------------------------

        function replyCommentButton(free_comment_idx){
            $('#comment_content'+free_comment_idx).children('.ViewComment').show();
            $('#comment_content'+free_comment_idx).children('.updateComment').hide();
            $('#comment'+free_comment_idx+" #replyCommentform").slideToggle();
        }
       
        function replyComment(free_parent_idx){
            let free_comment_content_val = $('#reply').val();
            if(free_comment_content_val.length < 2){
                alert("댓글을 입력해주세요");
                return;
            }
            $('#replyCommentform #refre_comment_content').val(free_comment_content_val);
            $('#replyCommentform #refre_parent_idx').val(free_parent_idx);
           
            let cvo = $('#replyCommentForm').serialize();
            
            $.ajax({
                url:"insertReplyComment",
                type:"post",
                data:cvo,
                success:function(data){
                    alert("입력되었습니다.");
                    findAllComment();
                },
                error:function(){
                    alert("error");
                }
            });
        } //대댓글 끝
        
        $(document).ready(function() {
            $('#delete').click(function() {
                $.ajax({
                    type: 'get',
                    url: 'deleteByIdx',
                    data: { free_idx: '${vo.free_idx}' }, 
                    success: function(response) {
                        alert('삭제하겠습니까?');
                        location.href = '/ezen/free/main';
                    },
                    error: function(error) {
                        console.error('에러:', error);
                    }
                });
            });
            
        }); 
        
        function deleteCommentByIdx(free_comment_idx) {
        	let result=confirm("댓글을 삭제하시겠습니까?")
        	
        	if(result==false) {
        		return;
        	}else{
        		$.ajax({
        			type:'post',
        			url: 'deleteCommentByIdx',
        			data: {'free_comment_idx' : free_comment_idx },
        			success : function(response) {
        				alert('삭제 되었습니다.');
        				findAllComment();
        			},
        			error: function(error) {
        				console.error('에러', error);
        			}
        		})
        	}
        }
        
      
    </script>
   
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	<jsp:include page="../common/banner.jsp"/>
	
	
	<!-- 글 조회 div container-->
    <div class="container mt-5 mb-5">
        <div class="pt-3 pb-3">
        
             <a class="text-muted " href="${contextPath}/free/main"><목록으로</a>
        </div>
        <!-- 글 제목 -->
        <div class="border-bottom">
            <h4 class="fw-4"> ${vo.free_title}</h4>
            <p class="d-flex flex-wrap align-items-center gap-2">
                <span class="d-block me-auto fst-italic text-muted"><fmt:formatDate value="${vo.free_date}" pattern="yyyy-MM-dd"/></span>

                <span class="d-inline-block"></span>
                <button class="btn bxtn-sm btn-outline-secondary">
                    <i class="fa-regular fa-comment"></i>
                    1:1 채팅
                </button>
            </p>
        </div>
            <!-- 글 본문(ckEditor) -->
            <div class="pt-3 pb-3 ck-content">
                <!-- 이 안에서 출력-->
                ${vo.free_content}
            </div>
            
            <form name="freeboomup">
			    <s:csrfInput />
			    <input type="hidden" name="freeidx" value="${vo.free_idx}">
			    <input type="hidden" name="userIdx" value="${uvo.user_idx}">
			            <div class="pb-3">
			                <div class="m-auto text-center">
			                    <button class="btn btn-outline-secondary" id="likeboomup" type="button" value="likeboomup">
			                        <span><i class="fa-regular fa-thumbs-up"></i></span>
			                        <span id="boomup">${vo.free_boomup}</span>
			                    </button>
			                </div>
			            </div>
			</form>
	            <!-- 기타 버튼 -->
	       
			    <div class="border-bottom text-end pb-3">
			     <c:if test="${uvo.user_idx == vo.user_idx || uvo.user_admin == true}">
			        <a class="btn btn-secondary" href="${contextPath}/free/modify?free_idx=${vo.free_idx}"> 수정하기 </a>
			        <button class="btn btn-secondary" id="delete" type="button">삭제</button>
			      </c:if> 
			        <a class="btn btn-secondary" href="javascript:history.go(-1)"> 리스트 </a>
			    </div>

        <!-- 댓글 -->
        
        <div class="mt-3">
        		<form id="InsertComment">
        	<!-- 서버로 데이터를 넘길 때 사용 -->
        	<input type="hidden" name="user_idx" value="${uvo.user_idx }">
	        <input type="hidden" id="free_idx" name="free_idx" value="${vo.free_idx }">
	        <div class="mt-3 text-end">
            <div class="text-start p-2">댓글 작성</div>
            <div class="form-floating">
                <textarea class="form-control" id="free_comment_content" style="height: 100px" name="free_comment_content"
                <c:if test="${empty uvo }">readonly="readonly"</c:if> ></textarea>
                <label for="free_comment_content">
                	<c:if test="${!empty uvo }">
                	댓글 내용
                	</c:if>
                	<c:if test="${empty uvo }">
                	로그인 후 댓글 작성이 가능합니다.
                	</c:if>
                </label>
                
            </div>
            <div>
                <span id="Fullcomment" class="text-danger d-inline-block d-none">최대 글자수를 초과하였습니다.</span>
                <c:if test="${!empty uvo}">
	            <button type="button" onclick="insertCommentclick()" class="btn btn-sm btn-secondary d-inline-block">등록</button>
	             </c:if>
            </div>
            	</form>
            <!-- 댓글 최대 글자수 설정 -->
          <script>
	        $(document).ready(function(){
	        	$('#comments').on('input',function(){
	        		let textLength = $(this).val().length;
	        		if (textLength >= 254) {
	        			$(this).val($(this).val().substr(0, 255));
	        			$('#Fullcomment').removeClass('d-none');
	        		}else{
	        			$('#Fullcomment').addClass('d-none');
	        		}
	        	
	        	})
	        })
        </script>
    
            
        </div>
              <!-- 등록된 댓글들 -->
        <h6 class="border-top mt-3 p-3 pb-0">댓글 <span class="text-muted">(최신순)</span></h6>
        <div id="ViewComment">
            
			<div class="p-3 mt-3 mb-3 text-muted">
				
			</div>
            
        </div>
        
        	<!-- 댓글에 대한 답변. 숨겨놓고 나중에 보여주기 위함. -->
	     <form id="replyCommentform" method="post">
	        <input type="hidden" id="refre_idx" name="refre_idx" value="${vo.free_idx}">
	        <input type="hidden" id="reuser_idx" name="reuser_idx" value="${uvo.user_idx }">
	        <input type="hidden" id="refre_parent_idx" name="refre_parent_idx" value="">
	        <input type="hidden" id="refre_comment_content" name="refre_comment_content" value="">
	    </form>
        
       
            <!--댓글이 있는 페이지에 있어야 하는 스크립트 영역 -->
            <script>
            	$(document).ready(function(){
            		textareaResizing();
            	});
            
              function textareaResizing(){
                    $('textarea.form-control').css('resize','none');
                    $('textarea.form-control').css('overflow','hidden');
                    $('textarea').each(function(){
                        this.style.height = 'auto';
                        this.style.height = (this.scrollHeight+10) + 'px';
                    }).on('input', function(){
                        this.style.height = 'auto';
                        this.style.height = (this.scrollHeight+10) + 'px';
                    })
                }
            </script>
        </div>

    </div>
		
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>
