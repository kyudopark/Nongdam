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

<link rel="stylesheet" href="/common.css" />

<!-- fontAwesome -->
<script src="https://kit.fontawesome.com/f34a67d667.js"
	crossorigin="anonymous"></script>
</head>
<body>
	<div class="container">
		<!-- 로그인 -->
		<!-- https://getbootstrap.com/docs/5.3/forms/floating-labels/#example -->
		<div class="row justify-content-center text-center mt-5 mb-5">
			<div class="col-12 col-md-10 col-lg-7 col-xl-6">
				<h4 class="mb-5">로그인</h4>
				<!-- form 영역-->
				<div>
					<!-- input의 placeholder와 라벨의 이름을 같게 주세요.-->
					<!-- 아이디 -->
					<div class="form-floating mb-3">
						<input type="text" class="form-control" id="user_id"
							placeholder="아이디" /> <label for="user_id">아이디</label>
					</div>
					<!-- 비밀번호 -->
					<div class="form-floating mb-3">
						<input type="password" class="form-control" id="user_pw"
							placeholder="비밀번호" /> <label for="user_pw">비밀번호</label>
					</div>
					<!-- 아이디/비밀번호 찾기 -->

					<!-- 만약 실패한 경우 화면을 강조하고 싶다면 -->
					<!-- input 태그의 클래스에 is-invalid를 추가하는 방법도 있습니다-->
					<!-- 아래는 예제입니다.(확인하신 후에 지우세요) -->
					<!-- <div class="form-floating mb-3">
                        <input type="password" class="form-control is-invalid" id="user_pw" placeholder="유효성검사 예시">
                        <label for="user_pw">유효성검사 예시</label>
                    </div> -->
					<!-- 예제 끝 -->
				</div>
				<!-- 로그인 버튼 -->
				<div class="form-group mb-4">
					<button class="form-control btn btn-lg btn-secondary">
						<i class="fa-solid fa-right-to-bracket"></i> 로그인
					</button>
				</div>
				<!-- form 영역 끝 -->

				<!-- a 태그들 -->
				<div class="ps-3 pe-3 text-center mb-3">
					<a href="${contextPath }/user/signup" class="text-muted ps-3 pe-3 border-end">회원가입하기</a> 
					<a href="${contextPath }/user/findid" class="text-muted ps-3 pe-3 border-end">아이디 찾기</a> 
					<a href="${contextPath }/user/findpw" class="text-muted ps-3 pe-3">비밀번호 찾기</a>
				</div>

				<!-- SNS 로그인 파트 -->
				<div class="container mt-5">
					<!-- 한줄 -->
					<div class="row align-items-center">
						<hr class="col-4 mb-0" />
						<span class="col-4 p-0">SNS 로그인</span>
						<hr class="col-4 mb-0" />
					</div>
					<!-- 버튼 영역 -->
					<div class="mt-4 mb-4">{SNS 로그인 버튼 자리입니다. 편의대로 바꾸세요}</div>
				</div>
				<!-- SNS 로그인 파트 끝-->
			</div>
		</div>
		<!-- 로그인 끝 -->
	</div>


</body>
</html>