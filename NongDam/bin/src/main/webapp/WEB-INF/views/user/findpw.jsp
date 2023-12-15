<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<!-- 231127 -->
<!-- 언어 ko(한국어) 로 맞춰주세요. -->
<html lang="ko" data-bs-theme="light">
<head>
<!-- UTF-8 사용-->
<meta charset="UTF-8" />
<!-- 기본 화면 보기 설정 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- bootstrap 5.3.2 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous" />
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
	integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
	integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
	crossorigin="anonymous"></script>

<!--제이쿼리-->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>

<!-- ckEditor 5 -->
<script
	src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/ckeditor.js"></script>

<link rel="stylesheet" href="${contextPath }/resources/common/css/style.css">

<meta name="농담" content="안녕하세요, 농업 정보 커뮤니티 농담입니다."/>
    
    <!-- 파비콘 -->
    <link rel="icon" type="image/x-icon" href="${contextPath }/resources/image/common/favicon.ico"/>
    <link rel="shortcut icon" type="image/x-icon" href="${contextPath }/resources/image/common/favicon.ico"/>
    
    <title>농담 | 농업 정보 커뮤니티</title>

<!-- fontAwesome -->
<script src="https://kit.fontawesome.com/f34a67d667.js"
	crossorigin="anonymous"></script>
	
	
<script>
$(function(){
	$("#findBtn").click(function(){
		$.ajax({
			url : "${contextPath}/user/findpw",
			type : "POST",
			data : {
				user_id : $("#user_id").val(),
				user_email : $("#user_email").val(),
				user_name : $("#user_name").val()
			},
			success : function(result) {
				alert(result);
			},
		})
	});
})
</script>
</head>
<body>

	<jsp:include page="userHeader.jsp"/>

	<div class="container mt-5 mb-5">
		<div class="row justify-content-center mt-5 mb-5">
			<div class="col-12 col-md-9 col-lg-7 col-xl-6">
				<h4 class="mb-5 text-center">비밀번호 찾기</h4>
				<div class="mb-3 row justify-content-center">
					<label for="user_name" class="col-2 col-form-label">이름</label>
					<div class="col-8">
						<input type="text" class="form-control" id="user_name" name="user_name" />
					</div>
				</div>
				<div class="mb-4 row justify-content-center">
					<label for="user_id" class="col-2 col-form-label">아이디</label>
					<div class="col-8">
						<input type="text" class="form-control" id="user_id" name="user_id"/>
					</div>
				</div>
				<div class="mb-4 row justify-content-center">
					<label for="user_email" class="col-2 col-form-label">이메일</label>
					<div class="col-8">
						<input type="email" class="form-control" id="user_email" name="user_email" />
					</div>
				</div>
				<!-- 버튼 영역 -->
				<div class="form-group mb-4 text-center">
					<button class="col-10 btn btn-secondary" id="findBtn">이메일 전송</button>
				</div>
				<div class="form-group mb-4 text-center">
				<a href="${contextPath }/user/login" class="col-10 btn btn-outline-secondary"><i
						class="fa-solid fa-right-to-bracket"></i> 로그인하러 가기</a>
				</div>
			</div>
		</div>
	</div>

</body>
</html>