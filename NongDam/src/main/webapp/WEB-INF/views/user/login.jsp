<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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

<link rel="stylesheet"
	href="${contextPath }/resources/common/css/style.css">

<meta name="농담" content="안녕하세요, 농업 정보 커뮤니티 농담입니다." />

<!-- 파비콘 -->
<link rel="icon" type="image/x-icon"
	href="${contextPath }/resources/image/common/favicon.ico" />
<link rel="shortcut icon" type="image/x-icon"
	href="${contextPath }/resources/image/common/favicon.ico" />

<title>농담 | 농업 정보 커뮤니티</title>

<!-- fontAwesome -->
<script src="https://kit.fontawesome.com/f34a67d667.js"
	crossorigin="anonymous"></script>
	

<script src="https://www.google.com/recaptcha/enterprise.js?render=6LePKTkpAAAAAMrly0tV36TPjrmDBVwRJhKV01Ua"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.5.0/kakao.min.js"
	integrity="sha384-kYPsUbBPlktXsY6/oNHSUDZoTX6+YI51f63jCPEIPFP09ttByAdxd2mEjKuhdqn4"
	crossorigin="anonymous"></script>


<script src="https://www.google.com/recaptcha/api.js"></script>
<script>


$(function () {
    $('#loginForm').submit(function (event) {
        // 폼 제출을 막기 위해 기본 이벤트를 중단
        event.preventDefault();

        // 캡차 검증 후 제출 여부를 결정하는 함수
        function submitFormIfCaptchaValid() {
            // 캡차 검증 결과에 따라 동작 수행
            switch (captcha) {
                case 0:
                    console.log("자동 가입 방지 봇 통과");
                    // 캡차 통과 시 폼 서버로 제출
                    $('#loginForm')[0].submit();
                    break;
                case 1:
                    alert("자동 가입 방지 봇을 확인 한뒤 진행 해 주세요.");
                    break;
                default:
                    alert("자동 가입 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : " + Number(captcha) + "]");
                    break;
            }
        }

        // Ajax를 통한 캡차 검증
        $.ajax({
            url: '${contextPath}/user/VerifyRecaptcha',
            type: 'post',
            data: {
                recaptcha: $("#g-recaptcha-response").val()
            },
            success: function (data) {
                // 캡차 검증 결과를 전역 변수에 저장
                captcha = data;

                // 캡차 검증 후 폼 제출 여부를 결정하는 함수 호출
                submitFormIfCaptchaValid();
            }
        });
    });
});

</script>





<script type="text/javascript">
  $(document).ready(function(){
    if(${!empty msgType}){
      $("#messageType").attr("class", "modal-content panel-warning");    
      $("#myMessage").modal("show");
    }
  });
  </script>

</head>
<body>
	<jsp:include page="userHeader.jsp" />

	<div class="container">
		<!-- 로그인 -->
		<!-- https://getbootstrap.com/docs/5.3/forms/floating-labels/#example -->
		<div class="row justify-content-center text-center mt-5 mb-5">
			<div class="col-12 col-md-10 col-lg-7 col-xl-6">
				<h4 class="mb-5">로그인</h4>
				<form action="${contextPath }/user/userLogin" method="post" id="loginForm">
					<div>
						<!-- input의 placeholder와 라벨의 이름을 같게 주세요.-->
						<!-- 아이디 -->
						<div class="form-floating mb-3">
							<input type="text" class="form-control" id="user_id"
								name="user_id" placeholder="아이디" /> <label for="user_id">아이디</label>
						</div>
						<!-- 비밀번호 -->
						<div class="form-floating mb-3">
							<input type="password" class="form-control" id="user_pw"
								name="user_pw" placeholder="비밀번호" /> <label for="user_pw">비밀번호</label>
						</div>

					</div>
					<!-- 로그인 버튼 -->
					<div class="form-group mb-4">
						<button type="submit"
							class="form-control btn btn-lg btn-secondary">
							<i class="fa-solid fa-right-to-bracket"></i> 로그인
						</button>
					</div>
					
				
				</form>
				
				
				<!-- form 영역 끝 -->

				<!-- a 태그들 -->
				<div class="ps-3 pe-3 text-center mb-5">
					<a href="${contextPath }/user/signup"
						class="text-muted ps-3 pe-3 border-end">회원가입하기</a> <a
						href="${contextPath }/user/findid"
						class="text-muted ps-3 pe-3 border-end">아이디 찾기</a> <a
						href="${contextPath }/user/findpw" class="text-muted ps-3 pe-3">비밀번호
						찾기</a>
				</div>
														
				<div class="g-recaptcha" data-sitekey="6LePKTkpAAAAAMrly0tV36TPjrmDBVwRJhKV01Ua"></div>
															
				
				<!-- SNS 로그인 파트 -->
				<div class="container mt-4">
					<!-- 한줄 -->
					<div class="row align-items-center">
						<hr class="col-4 mb-0" />
						<span class="col-4 p-0">SNS 로그인</span>
						<hr class="col-4 mb-0" />
					</div>
					
					
					<div class="mt-4 mb-4 text-decoration-none">
						 <a href="${kakaoLoginUrl }" class="text-decoration-none "
						style="color:#000000">
							<div style="background-color:#FEE500;border-radius:12px;"
							class="d-flex flex-row align-items-center justify-content-start mb-2 ps-2 pe-3">
								<img
								src="${contextPath }/resources/image/user/loginbtn-kakao-logo.png"
								width="50px" />
								<b class="d-block w-100 text-center">카카오 간편 로그인</b>
							</div>
						</a>
						<a href="${googleAuthUrl }" class="text-decoration-none" 
						style="color:#797a98">
							<div style="background-color:#f2f2f2; border-radius:12px;"
							class="d-flex flex-row align-items-center justify-content-start mb-2 ps-2 pe-3">
								<img
								src="${contextPath }/resources/image/user/loginbtn-google-logo.svg"
								style="width:50px;margin-left:2px" alt="구글 로그인 버튼" />
								<b class="d-block w-100 text-center">구글 간편 로그인</b>
							</div>
						</a>

						<a href="${naverLoginUrl }" class="text-decoration-none"
						style="color:#FFFFFF">
							<div style="background-color:#03C75A;border-radius:12px;"
							class="d-flex flex-row align-items-center justify-content-start mb-2 ps-2 pe-3">
								<img height="50" 
								src="${contextPath }/resources/image/user/loginbtn-naver-logo.png"/>
								<b class="d-block w-100 text-center">네이버 간편 로그인</b>
							</div>
						</a>


					</div>
				</div>
				<!-- SNS 로그인 파트 끝-->
			</div>
		</div>
		<!-- 로그인 끝 -->
	</div>

	<!-- 실패 메세지를 출력(modal) -->
	<div id="myMessage" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div id="messageType" class="modal-content panel-info">
				<div class="modal-header panel-heading">
					<button type="button" class="btn" data-bs-dismiss="modal">&times;</button>
					<h4 class="modal-title">${msgType}</h4>
				</div>
				<div class="modal-body">
					<p>${msg}</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn" data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>


	


</body>
</html>