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
    
    <script>
    $(document).ready(function(){
    	findLikeCount();
    	findUser_idxIsExist();
    })
    function deleteByIdx(info_idx){
		let result = confirm('정말 삭제하시겠습니까?');
			
		if(result == false){
			return;
		}else{
			$.ajax({
				url:"deleteByIdx",
				type:"post",
				data:{"info_idx":info_idx},
				success:function(data){
					alert("성공적으로 삭제되었습니다.");
					location.href="${contextPath}/info/main";
				},
				error:function(){
					alert("error");
				}
			})
			
		}
	}
    
    function mainfrm(){
    	$('#mainfrm').submit();
    }
    
    function findLikeCount(){
		let info_idx = ${vo.info_idx};
    	$.ajax({
			url:"findLikeCount",
			type:"get",
			data: {"info_idx":info_idx},
			dataType: "json",
			success:function(data){
				$('#infoLikes').text(data);
			},
			error:function(){
				alert("error");
			}
		});
    }
    function findUser_idxIsExist(){
    	let user_idx = ${uvo.user_idx};
    	let info_idx = ${vo.info_idx};
    	if(user_idx == 0 || user_idx == '' || user_idx == null){
    		return
    	}
    	$.ajax({
			url:"findUser_idxIsExist",
			type:"get",
			data: {"user_idx":user_idx,
				"info_idx":info_idx},
			dataType: "json",
			success:function(data){
				if(data == 1){
		    		$('#clickLikeBtn').removeClass('btn-outline-secondary');
		    		$('#clickLikeBtn').addClass('btn-secondary');
		    	}else if(data == 0){
		    		$('#clickLikeBtn').removeClass('btn-secondary');
		    		$('#clickLikeBtn').addClass('btn-outline-secondary');
		    	}
			},
			error:function(){
				alert("error");
			}
		});
    }
    function clickLikeBtn(info_idx,user_idx){
    	if(user_idx == '0' || user_idx == '' || user_idx == null){
    		alert("로그인시 이용할 수 있는 기능입니다. 로그인해주세요.");	
    		return false;
    	}
    	//ajax
    	//int값을 리턴받음
    	$.ajax({
			url:"clickLikeBtn",
			type:"get",
			data: {"info_idx":info_idx,
				"user_idx":user_idx},
			dataType: "json",
			success:function(data){
				findLikeCount();
				if(data == 1){
		    		//추천 버튼을 누름
		    		alert("추천되었습니다.");
		    		$('#clickLikeBtn').removeClass('btn-outline-secondary');
		    		$('#clickLikeBtn').addClass('btn-secondary');
		    	}else if(data == 0){
		    		//추천을 누르지 않음
		    		alert("추천을 취소하였습니다.");
		    		$('#clickLikeBtn').removeClass('btn-secondary');
		    		$('#clickLikeBtn').addClass('btn-outline-secondary');
		    	}
			},
			error:function(){
				alert("error");
			}
		})
    }
    </script>
       
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	<jsp:include page="../common/banner.jsp"/>
	
	
		<!-- 글 조회 div container-->
    <div class="container mt-5 mb-5">
        <div class="pt-3 pb-3">
            <a class="text-muted" href="javascript:mainfrm()"> &lt; 목록으로 </a>
        </div>
        <!-- 글 제목 -->
        <div class="border-bottom">
            <h4 class="fw-4">[${vo.info_tag}] ${vo.info_title }</h4>
            <p class="d-flex flex-wrap align-items-center gap-2">
                <span class="d-block me-auto fst-italic text-muted">
                	<fmt:formatDate value="${vo.info_date }" pattern="YYYY-MM-dd hh:mm"/>
                </span>
                <span class="d-inline-block"><b>작성자</b> ${vo.user_nickname }</span>
            </p>
        </div>
        <!-- 글 본문(ckEditor) -->
        <div class="pt-3 pb-3 ck-content">
            <!-- 이 안에서 출력-->
            ${vo.info_content}
        </div>
        <div class="text-center mb-4">
        	<button id="clickLikeBtn" class="btn btn-outline-secondary" onclick="clickLikeBtn(${vo.info_idx},${uvo.user_idx })">
                    <span><i class="fa-regular fa-thumbs-up"></i> </span>
                    <span id="infoLikes"> ${vo.info_like }</span>
            </button>
        </div>

        <!-- 기타 버튼 -->
        <div class="border-bottom text-end mt-3 pb-3">
	        <c:if test="${uvo.user_idx == vo.user_idx || uvo.user_admin == true}">
	            <c:if test="${uvo.user_idx == vo.user_idx }">
	            <a href="${contextPath }/info/modify?info_idx=${vo.info_idx}" class="btn btn-secondary">수정</a>
	            </c:if>
	            <button onclick="deleteByIdx(${vo.info_idx})" class="btn btn-danger">삭제</button>
            </c:if>
            <a href="javascript:mainfrm()" class="btn btn-secondary">리스트</a>
        </div>

        <!-- info/main으로 갈때 사용하는 폼 -->
        <form action="${contextPath }/info/main" method="get" id="mainfrm">
        	<c:if test="${cri.page != 1 && cri.perPageNum != 12 }">
	        	<input type="hidden" name="page" value="${cri.page }"/>
	        	<input type="hidden" name="perPageNum" value="${cri.perPageNum }"/>
			</c:if>
        	<c:if test="${!empty cri.type }">
        		<input type="hidden" name="type" value="${cri.type }"/>
        		<input type="hidden" name="keyword" value="${cri.keyword }"/>
        	</c:if>
        	<c:if test="${!empty cri.tag }">
        		<input type="hidden" name="tag" value="${cri.tag }"/>
        	</c:if>
        </form>
      </div>
        
       
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>
