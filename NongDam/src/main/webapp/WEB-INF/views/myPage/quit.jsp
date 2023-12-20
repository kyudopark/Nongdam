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
   
</script>

</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	<jsp:include page="../common/banner.jsp"/>
	
	<!-- 마이페이지 전체 시작 -->
    <div class="container mt-5 mb-5">
        <div class="row">
            <!-- 왼쪽 메뉴바 -->
            <div class="col-12 col-md-3">
                <div class="accordion mb-2">
                    <!-- id="collapseOne"과 data 속성은 건들지 말것-->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <!-- 타이틀 -->
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                마이페이지
                            </button>
                        </h2>
                        <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">
                            <div class="accordion-body p-0">
                                <ul class="list-group list-group-flush rounded-bottom-2">
                                    <li class="list-group-item ">
                                        <a class="text-decoration-none text-body" href="${contextPath }/myPage/main">마이페이지 메인</a>
                                    </li>
                                    <li class="list-group-item ">
                                        <a class="text-decoration-none text-body" href="${contextPath }/myPage/modify">회원정보 수정</a>
                                    </li>
                                    
                                    <li class="list-group-item ">
                                        <a class="text-decoration-none text-body" href="${contextPath }/myPage/gplist">공동구매 참여내역</a>
                                    </li>
                                    <li class="list-group-item bg-body-secondary">
                                        <a class="text-decoration-none text-body" href="${contextPath }/myPage/quit">회원 탈퇴</a>
                                    </li>
                                    
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 왼쪽 메뉴바 ========================================= -->
            <!-- 오른편 화면 -->
            <div class="col-12 col-md-9">
                <div class="container">
                    <div>
                        <!-- 마이페이지 회원탈퇴 -->
                        <div class="pt-4 pb-4 mt-4 mb-4">
                            <h4 class="ms-2 mb-4 text-body-secondary"><i class="fa-solid fa-wrench me-2"></i> 회원 탈퇴</h4>
                            <div class="pt-2">
                                <div class="text-center border">
                                    <p class="fw-bolder fs-5 p-4 pt-0" style="margin-top:2.6rem; ">회원 탈퇴</p>
                                    <p>회원 탈퇴 시 가입 정보가 모두 삭제됩니다.</p>
                                    <p>SNS 연동 계정 탈퇴 시에 해당 연동은 끊어지며,</p>
                                    <p>작성한 게시글과 댓글은 모두 숨김처리됩니다.</p>
                                    <p><b>회원 탈퇴 처리</b>를 위해 <b>비밀번호를 다시 한번 입력</b>해 주시기 바랍니다.</p>
                                    <form action="${contextPath}/myPage/quit" method="post">
                                    <input type="password" class="form-control ms-auto me-auto mb-2 mt-4" style="max-width: 18rem;" id="user_pw" name="user_pw" placeholder="비밀번호 입력">
                                    <button type="submit" id="quitBtn" class="btn btn-danger" style="width:100%;max-width: 18rem; margin-bottom:3rem;">탈퇴하기 </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- 마이페이지 회원탈퇴 끝 -->
					</div>
             	</div>
             </div>    
            <!-- 오른쪽 화면 끝 -->
        </div>
    </div>
    
    <!-- 마이페이지 끝 -->
	
	
	
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>
