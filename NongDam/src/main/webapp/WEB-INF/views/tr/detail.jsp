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
			getComment();
		})
		function getComment(){
			let tr_idx = $('#tr_idx').val();	
			$.ajax({
				url:"getComment",
				type:"get",
				data: {"tr_idx":tr_idx},
				dataType: "json",
				success:viewComment,
				error:function(){
					alert("error");
				}
			})
		}
		function viewComment(data){
			var date = new Date();
			let fmtTime;
			let commentList ="";
			$.each(data, function(index,obj){
				
				date.setTime(obj.tr_comment_time);
				fmtTime = date.toISOString().replace(/T/, ' ').replace(/\..+/, '');
				
				commentList += "<div class='p-3 mt-3 mb-3 d-flex flex-nowrap gap-1'>";
				// 답글여부
				if(obj.tr_parent_idx != obj.tr_comment_idx){
					commentList += "	<div class='ms-2 me-3'> </div> ";
				}
				commentList += "	<div style='width: 22px; height: 22px; border-radius: 50%;'>";
				
				// 썸네일
				if(obj.user_profile == null || obj.user_profile == ''){
					commentList += "		<i class='fa-regular fa-user'></i>";
				}else{
					commentList +="			<img class='object-fit-cover' style='width: 22px; height: 22px; border-radius: 50%;'";
					commentList += " 			src='"+ obj.user_profile +"'>"
				}
				commentList += "	</div>";
				commentList += "	<div class='w-100'>";
				commentList += "		<div>";
				commentList += " 			<h6 class='d-inline-block'>"+ obj.user_nickname +"</h6>";
				commentList += "			<small class='text-secondary'>"+fmtTime+"</small>";
				commentList += "		</div>";
				if(obj.tr_comment_useable == 1){
				commentList += "		<div class='pb-2'>";
				commentList += "			<div>"+obj.tr_comment_content+"</div>";
				commentList += "			<c:if test='${empty uvo }'> ";
				commentList += " 				<div class='d-none'>";
				commentList += "					<textarea class='form-control'>"+obj.tr_comment_content+"</textarea>";
				commentList += "				</div>";
				commentList += "				<small class='d-flex flex-nowrap gap-2'>";
				commentList += "					<a class='text-secondary text-decoration-none'>답글</a>";
				commentList += "  					<a class='text-secondary text-decoration-none'>수정</a>";
				commentList += "					<a href='javascript:deleteCommentByIdx("+obj.tr_comment_idx+")' class='text-secondary text-decoration-none'>삭제</a>";
				commentList += "					<c:if test='${"+obj.user_idx +" eq uvo.user_idx }'>";
				commentList += "					</c:if>";
				commentList += "				</small>";
				commentList += "			</c:if>";
				commentList += "		</div>";
				}else{
				commentList += "		<div class='pb-2'>";
				commentList += "			<div>삭제된 게시글입니다.</div>";
				commentList += "		</div>";
				}
				commentList += "	</div>"; 
				commentList += "</div>";
				
			})
			if(commentList != "")
			$('#commentView').html(commentList);
		}
		
		
		function insertComment(){
			const cvo = $('#insertCommentForm').serialize();

			 $.ajax({
				url:"insertComment",
				type:"post",
				data:cvo,
				success:function(data){
					alert("입력되었습니다.");
					$('#insertCommentForm')[0].reset();
					getComment();
				},
				error:function(){
					alert("error");
				}
			})
		}
		
		function openChatByIdx(user_idx){
		   window.open("${contextPath}/chat/list/"+user_idx,"채팅하기","width=400, height=500, left=100, top=50");
		}
		
		function deleteByIdx(tr_idx){
			
			let result = confirm('정말 삭제하시겠습니까? 게시글을 삭제하면 댓글까지 전부 삭제됩니다.');
				
			if(result == false){
				return;
			}else{
				$.ajax({
					url:"deleteByIdx",
					type:"put",
					data:{"tr_idx":tr_idx},
					success:function(data){
						alert("성공적으로 삭제되었습니다.");
						location.href="${contextPath}/tr/main";
					},
					error:function(){
						alert("error");
					}
				})
				
			}
		}
		function deleteCommentByIdx(tr_comment_idx){
			
			let result = confirm('정말 삭제하시겠습니까? 삭제한 댓글은 되돌릴 수 없습니다.');
				
			if(result == false){
				return;
			}else{
				$.ajax({
					url:"deleteCommentByIdx",
					type:"put",
					data:{"tr_comment_idx":tr_comment_idx},
					success:function(){
						alert("성공적으로 삭제되었습니다.");
						getComment();
					},
					error:function(){
						alert("error");
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
            <a class="text-muted" href="javascript:history.go(-1)"> &lt; 목록으로 </a>
        </div>
        <!-- 글 제목 -->
        <div class="border-bottom">
            <h4 class="fw-4">${vo.tr_title }</h4>
            <p class="d-flex flex-wrap align-items-center gap-2">
                <span class="d-block me-auto fst-italic text-muted">
                	<fmt:formatDate value="${vo.tr_time }" pattern="YYYY-MM-dd hh:mm"/>
                </span>

                <span class="d-inline-block">${vo.user_nickname }</span>
                <button onclick="openChatByIdx(${vo.user_idx})" class="btn btn-sm btn-outline-secondary">
                    <i class="fa-regular fa-comment"></i>
                    1:1 채팅
                </button>
            </p>
        </div>
        <!-- 글 본문(ckEditor) -->
        <div class="pt-3 pb-3 ck-content">
            <!-- 이 안에서 출력-->
            ${vo.tr_content}
        </div>


        <!-- 기타 버튼 -->
        <div class="border-bottom text-end pb-3">
            <a class="btn btn-secondary">수정</a>
            <button onclick="deleteByIdx(${vo.tr_idx})" class="btn btn-danger">삭제</button>
            <a href="javascript:history.go(-1)" class="btn btn-secondary">리스트</a>
        </div>

        <!-- 댓글 -->
        <form id="insertCommentForm">
	        <input type="hidden" name="user_idx" value="1">
	        <input type="hidden" id="tr_idx" name="tr_idx" value="${vo.tr_idx }">
	        <div class="mt-3 text-end">
	            <div class="text-start p-2">댓글 작성</div>
	            <div class="form-floating">
	                <textarea class="form-control" id="tr_comment_content" style="height: 100px" name="tr_comment_content"></textarea>
	                <label for="tr_comment_content">댓글 내용</label>
	            </div>
	            <div>
	                <span class="text-danger d-inline-block">최대 글자수를 초과하였습니다.</span>
	                <button type="button" onclick="insertComment()" class="btn btn-sm btn-secondary d-inline-block">등록</button>
	            </div>
	        </div>
        </form>
        
        <!-- 등록된 댓글들 -->
        <h6 class="border-top mt-3 p-3 pb-0">댓글</h6>
        <div id="commentView">
            
			<div class="p-3 mt-3 mb-3 text-muted">
				등록된 댓글이 없습니다. 댓글을 달아보세요!
			</div>
            
        </div>
		<!--댓글이 있는 페이지에 있어야 하는 스크립트 영역 -->
        <script>
            $(document).ready(function(){
                $('textarea.form-control').css('resize','none');
                $('textarea.form-control').css('overflow','hidden');
                $('textarea').each(function(){
                    this.style.height = 'auto';
                    this.style.height = (this.scrollHeight+10) + 'px';
                }).on('input', function(){
                    this.style.height = 'auto';
                    this.style.height = (this.scrollHeight+10) + 'px';
                })
            });
        </script>
    </div>
    
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>
