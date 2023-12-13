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
    <!-- gp/* js파일 -->
    <script type="text/javascript" src="${contextPath }/resources/gp/js/script.js"></script>
    
    <meta name="농담" content="안녕하세요, 농업 정보 커뮤니티 농담입니다."/>
    
    <!-- 파비콘 -->
    <link rel="icon" type="image/x-icon" href="${contextPath }/resources/image/common/favicon.ico"/>
    <link rel="shortcut icon" type="image/x-icon" href="${contextPath }/resources/image/common/favicon.ico"/>
    
    <title>농담 | 농업 정보 커뮤니티</title>
    
    <script type="text/javascript">
	    
	    //페이지 번호 클릭 할때 이동하기
	  $(document).ready(function () {
		  $('button').on('click',function(e){
  			var fData = $("#fr");
  			var btn = $(this).data('btn'); // 내가 현재 클릭한 버튼 -> data-btn
  			
  			if(btn == 'request') {
	  				fData.attr("action", "${contextPath }/gp/request");
	  			} else if(btn == 'modify') {
	  				fData.attr("action", "${contextPath }/gp/modify");
	  			} else if(btn == 'back') {
	  				fData.find("#idx").remove();
	  				fData.attr("action", "${contextPath }/gp/main");
	  			} else if(btn == 'delete') {
	  				let result = confirm('해당 공동구매 게시글을 삭제하시겠습니까?');
	  				if(result == false){
	  					return;
	  				} else {
	  					fData.attr("action", "${contextPath}/gp/deleteByIdx");
	  				}
	  			}
	  			fData.submit();
  			});
	    });
	
	</script>
	
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	<jsp:include page="../common/banner.jsp"/>
	
	<!-- 여기에 컨텐츠를 추가 -->
	<!-- 메인페이지 7/5 row -->
    <div class="container mt-5 mb-4">
        <div class="border rounded-2 container">
            <div class="row">
                <!--썸네일-->
                <div class="col-lg-7 col-12 p-0 bg-light" style="height: 300px;">
                    <img src="${contextPath }/resources/image/gp/${vo.gp_thumb }" style="width: 100%; height: 100%;">
                </div>
                <!--오른쪽-->
                <div class="border-start col-lg-5 col-12 p-3">
                    <!-- 세줄까지 출력하고 싶다면 클래스명을 ...-3 으로 바꾸세요.-->
                    <h4 class="title-overflow-2">${vo.gp_title}</h4>
                    <p class="pt-0">
                        <div>
                            <span class="fw-bolder">신청 시작일 </span>
                            <span><fmt:formatDate value="${vo.gp_date_start }" pattern="YYYY-MM-dd "/></span>
                        </div>
                        <div>
                            <span class="fw-bolder">신청 마감일 </span>
                            <span><fmt:formatDate value="${vo.gp_date_last }" pattern="YYYY-MM-dd "/></span>
                        </div>
                    </p>
                    <p class="pt-3 fs-5">
                        <span class="fw-bolder">가격 </span>
                        <span>${vo.gp_price}원</span>
                    </p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 시작일 / 마감일 비교용 -->
	<c:set var="currentDate" value="<%= new java.util.Date() %>"/>
	<c:set var="startDate" value="${vo.gp_date_start }"/>
	<c:set var="endDate" value="${vo.gp_date_last }"/>
		
	<c:set var="diffMillis" value="${startDate.time - currentDate.time}"/>
	<c:set var="diffDays" value="${diffMillis / (24 * 60 * 60 * 1000)}"/>
		                        
	<c:set var="diffMillisEnd" value="${endDate.time - currentDate.time}"/>
	<c:set var="diffDaysEnd" value="${diffMillisEnd / (24 * 60 * 60 * 1000)}"/>

    <!-- 글 조회 블럭 -->
    <div class="container mt-4 mb-5">
        <div class=" border rounded-2" id="detailBlock">
            <!-- ckEditor로 작성된 content인 경우, ck-content 클래스는 필수로 들어가야 한다.-->
            <div class="container pt-5 pb-5 ck-content">${vo.gp_content }</div>
            <!-- 신청하기 버튼 -->
            <div class="container pt-5 pb-4 text-center">
            	<c:if test="${diffDays <= 0 and diffDaysEnd > 0}">
                	<button class="btn btn-secondary" data-btn = "request" >신청하기</button>
                </c:if>
                <button class="btn btn-outline-secondary" data-btn = "back" >목록으로</button>
                
                <c:if test="${uvo.user_id eq 'admin' }">
                	<button class="btn btn-success" data-btn = "modify" >수정하기</button>
                	<button class="btn btn-warning" data-btn = "delete">삭제하기</button>
                </c:if>
            </div>
        </div>
    </div>
    
    <form id="fr" method="get">
		<input type="hidden" id="gp_idx" name="gp_idx" value="${vo.gp_idx }"/>
		<input type="hidden" id="user_idx" name="user_idx" value="${uvo.user_idx }"/>
	</form>

	
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>