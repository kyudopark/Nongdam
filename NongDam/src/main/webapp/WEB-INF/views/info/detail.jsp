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
    
    $(document).ready(function() {
        $('#delete').click(function() {
            $.ajax({
                type: 'GET',
                url: 'deleteByIdx',
                data: { info_idx: '${vo.info_idx}' }, 
                success: function(response) {
                    alert('삭제하겠습니까?');
                    location.href = '/ezen/info/main';
                },
                error: function(error) {
                    console.error('에러:', error);
                }
            });
        });
    })
    
    </script>
    
    
    
    
    
    
</script>
       
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	<jsp:include page="../common/banner.jsp"/>
	
	
	<!-- 글 조회 div container-->
    <div class="container mt-5 mb-5">
        <div class="pt-3 pb-3">
             <a class="text-muted " href="${contextPath}/info/main"">목록으로</a>
        </div>
        <!-- 글 제목 -->
        <div class="border-bottom">
            <h4 class="fw-4"> ${vo.info_title}</h4>
            <p class="d-flex flex-wrap align-items-center gap-2">
                <span class="d-block me-auto fst-italic text-muted"><fmt:formatDate value="${vo.info_date}" pattern="yyyy-MM-dd"/></span>

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
                ${vo.info_content}
            </div>
            
            <form name="freeboomup">
						<s:csrfInput />
						<input type="hidden" name="freeidx" value="${vo.info_idx}">
						<input type="hidden" name="userIdx" value="${vo.user_idx}">
					</form>
            
              <div class=" pb-3">
            <div class="m-auto text-center">
                <button class="btn  btn-outline-secondary" id="boomup" type="button">
                    <span><i class="fa-regular fa-thumbs-up"></i></span>
                    <span id="boomup" name="boomup">${vo.info_boomup }</span>	
                    
                </button>
            </div>
        </div>
            
					
            
	            <!-- 기타 버튼 -->
	       
			    <div class="border-bottom text-end pb-3">
			     <c:if test="${ uvo.user_admin == true}">
			        <a class="btn btn-secondary" href="${contextPath}/info/modify?info_idx=${vo.info_idx}"> 수정하기 </a>
			        <button class="btn btn-secondary" id="delete" type="button">삭제</button>
			      </c:if> 
			        <a class="btn btn-secondary" href="${contextPath}/info/main"> 리스트 </a>
			    </div>

       
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>
