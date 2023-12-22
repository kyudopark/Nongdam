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

<!-- fontAwesome -->
<script src="https://kit.fontawesome.com/f34a67d667.js"
	crossorigin="anonymous"></script>

<meta name="농담" content="안녕하세요, 농업 정보 커뮤니티 농담입니다."/>
    
    <!-- 파비콘 -->
    <link rel="icon" type="image/x-icon" href="${contextPath }/resources/image/common/favicon.ico"/>
    <link rel="shortcut icon" type="image/x-icon" href="${contextPath }/resources/image/common/favicon.ico"/>
    
    <title>농담 | 농업 정보 커뮤니티</title>


<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if (data.userSelectedType === 'R') {
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    var extraAddr = ''; // 추가 주소 변수
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }

                    // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                    if (extraAddr !== '') {
                        extraAddr = ' (' + extraAddr + ')';
                    }
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('user_zipcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

<script type="text/javascript">
$(document).ready(function(){
	
	
		
    
	
	 	showMessageOnFocus($("#user_id"), $("#passMessageid"), "! 아이디를 입력하세요");
	    showMessageOnFocus($("#user_name"), $("#passMessagename"), "! 이름을 입력하세요");
	    showMessageOnFocus($("#user_nickname"), $("#passMessagenickname"), "! 닉네임을 입력하세요");
	    showMessageOnFocus($("#user_email"), $("#passMessageemail"), "! 이메일을 입력하세요");
	
	if(${not empty msgType}){
		$("#messageType").attr("class", "modal-content panel-warning");
		$("#myMessage").modal("show");
	}
	
	var isIdChecked = false;
	var isEmailVerified = false; // 이메일 인증 여부
	var code;

	function updateRegisterButtonState() {
	    // 아이디 중복 확인과 이메일 인증이 모두 완료되면 버튼 활성화
	    if (isIdChecked && isEmailVerified) {
	        $("#registerBtn").prop("disabled", false);
	    } else {
	        $("#registerBtn").prop("disabled", true);
	    }
	}


	$("#registerCheck").click(function (){
		var user_id = $("#user_id").val();

	    // 아이디 중복 확인만 수행
	    $.ajax({
	        url: "${contextPath}/user/userRegisterCheck",
	        type: "get",
	        data: { "user_id": user_id },
	        success: function (result) {
	            if (result == 1) {
	                $("#checkMessage").html("V 사용가능한 아이디 입니다");
	                isIdChecked = true; // 아이디 중복 확인 완료
	                updateRegisterButtonState(); // 버튼 상태 갱신
	            } else {
	                $("#checkMessage").html("! 중복 아이디 입니다.");
	                isIdChecked = false; // 아이디 중복 확인 실패
	                updateRegisterButtonState(); // 버튼 상태 갱신
	            }
	            $("#myModal").modal('show');
	        },
	        error: function () {
	            alert("error");
	        }
	    });
	}) 
	    


	$("#emailAuth").click(function () {
	    const user_email = $("#user_email").val(); // 사용자가 입력한 이메일 값 얻어오기

	    // 이메일 인증만 수행
	    $.ajax({
	        url: '${contextPath}/user/EmailAuth',
	        data: {
	            user_email: user_email
	        },
	        type: 'POST',
	        dataType: 'json',
	        success: function (result) {
	            console.log("result : " + result);
	            $("#authCode").attr("disabled", false);
	            code = result;
	            alert("인증 코드가 입력하신 이메일로 전송 되었습니다.");
	            isEmailVerified = true; // 이메일 인증 완료
	            updateRegisterButtonState(); // 버튼 상태 갱신
	        },
	        error: function () {
	            alert("error");
	        }
	    });
	});

	$("#authCode").on("focusout", function () {
	    const inputCode = $("#authCode").val();

	    console.log("입력코드 : " + inputCode);
	    console.log("인증코드 : " + code);

	    if (Number(inputCode) === code) {
	        $("#emailAuthWarn").html('V 인증번호가 일치합니다.');
	        $("#emailAuthWarn").css('color', 'green');

	        $('#emailAuth').attr('disabled', true);
	        $('#email').attr('readonly', true);

	        isEmailVerified = true; // 이메일 인증 완료
	        updateRegisterButtonState(); // 버튼 상태 갱신
	    } else {
	        $("#emailAuthWarn").html('! 인증번호가 불일치 합니다. 다시 확인해주세요!');
	        $("#emailAuthWarn").css('color', 'red');

	        isEmailVerified = false; // 이메일 인증 실패
	        updateRegisterButtonState(); // 버튼 상태 갱신
	    }
	});

	
	
	

	
	
	
	
	
});

<!-- -->





function showMessageOnFocus($element, $messageElement, message) {
    $element.on("focus", function () {
        if ($(this).val() === "") {
            $messageElement.html(message);
        }
    });

    $element.on("input", function () {
        if ($(this).val() !== "") {
            $messageElement.html("");
        }
    });
}

function passwordCheck(){
	var userPass1=$("#user_pw").val();
	var userPass2=$("#user_pw2").val();
	if(userPass1!=userPass2){
		$("#passMessage").html("! 비밀번호가 일치하지 않습니다");
	}
	else{
		$("#passMessage").html("");
		$("#user_pw1").val(userPass1);	
	}
} 










 function mailCheck() {
    var user_email = $("#user_email").val();

    $.ajax({
        url: "${contextPath}/user/emailCheck",
        type: "post",
        data: {"user_email": user_email},
        success: function (result) {
            if (result == 1) {
                $("#checkMessage").html("사용 가능한 이메일입니다.");
            } else {
                $("#checkMessage").html("중복된 이메일입니다.");
            }
            $("#myModal").modal('show');
        },
        error: function () {
            alert("error");
        }
    });
} 





	
	
	
</script>
</head>
<body>

	<jsp:include page="userHeader.jsp" />

	<div class="container">
		<form name="frm" method="post" action="${contextPath }/user/signup">
			<input type="hidden" id="user_pw1" name="user_pw1" value="" />
			<div class="row justify-content-center mt-5 mb-5">
				<div class="col-12 col-lg-8">
					<h4 class="mb-4">회원가입</h4>
					<hr />
					<!-- 회원가입 -->
					<!-- 여기에 없는 것들은 비밀번호쪽 div 영역을 복사해서 사용-->
					<!-- 안에 텍스트 추가하고 싶으면 -->
					<!-- input 태그에 placeholder 속성을 추가해서 사용하시면 됩니다. -->
					<div class="mb-3 row">
						<label for="user_id" class="col-sm-3 col-md-2 col-form-label">아이디<span
							class="text-danger">*</span></label>
						<div class="col-sm-9 col-md-10">
							<div class="form-group mb-2">
								<div class="row g-2">
									<div class="col-auto">
										<!-- 아이디 input -->
										<input type="text" class="form-control" id="user_id"
											name="user_id" placeholder="4~20자" maxlength="20"/>
									</div>
									<div class="col-auto">
										<!-- 중복검사 버튼-->
										<button type="button" class="btn btn-secondary" id="registerCheck">중복확인</button>
									</div>
									<span id="passMessageid" class="text-danger"></span>
								</div>
							</div>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="user_pw" class="col-sm-3 col-md-2 col-form-label">비밀번호<span
							class="text-danger">*</span></label>
						<div class="col-sm-9 col-md-10">
							<input type="password" class="form-control" id="user_pw"
								onkeyup="passwordCheck()" name="user_pw" placeholder="4~20자" maxlength="20"/>
						</div>
					</div>

					<div class="mb-3 row">
						<label for="user_pw2" class="col-sm-3 col-md-2 col-form-label">비밀번호확인<span
							class="text-danger">*</span></label>
						<div class="col-sm-9 col-md-10">
							<input type="password" class="form-control" id="user_pw2"
								name="user_pw2" onkeyup="passwordCheck()"
								placeholder="비밀번호와 일치해야 합니다." maxlength="20"/> <span id="passMessage"
								class="text-danger"></span>
						</div>
					</div>

					<div class="mb-3 row">
						<label for="user_name" class="col-sm-3 col-md-2 col-form-label">이름<span
							class="text-danger">*</span></label>
						<div class="col-sm-9 col-md-10">
							<input type="text" class="form-control" id="user_name"
								name="user_name" placeholder="이름을 입력하세요" /> <span
								id="passMessagename" class="text-danger"></span>
						</div>

					</div>

					<div class="mb-3 row">
						<label for="user_nickname"
							class="col-sm-3 col-md-2 col-form-label">닉네임<span
							class="text-danger">*</span></label>
						<div class="col-sm-9 col-md-10">
							<input type="text" class="form-control" id="user_nickname"
								name="user_nickname" placeholder="닉네임을 입력하세요" /> <span
								id="passMessagenickname" class="text-danger"></span>
						</div>

					</div>

					<div class="mt-4 mb-3 row">
						<label class="col-sm-3 col-md-2 col-form-label">성별<span
							class="text-danger">*</span></label>
						<div class="col-sm-9 col-md-10">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="user_gender"
									id="user_gender_male" value="1" checked /> <label
									class="form-check-label" for="user_gender_male">남자</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="user_gender"
									id="user_gender_female" value="0" /> <label
									class="form-check-label" for="user_gender_female">여자</label>
							</div>
						</div>
					</div>


					<div class="mb-3 row">
						<label for="user_email" class="col-sm-3 col-md-2 col-form-label">이메일<span
							class="text-danger">*</span></label>
						<div class="col-sm-9 col-md-10">
							<div class="form-group mb-2">
								<div class="row g-2">
									<div class="col-auto mb-2">

										<input type="email" class="form-control" id="user_email"
											name="user_email" placeholder="비밀번호 찾기시 사용됩니다" />
									</div>
									<div class="col-auto">

										<button type="button" class="btn btn-secondary" id="emailAuth">이메일
											인증</button>
									</div>
									<div class="col-12">
										<div class=" row">
											<div class="col-12 col-md-auto">
												<input class="form-control" placeholder="인증 코드 6자리를 입력해주세요."
													maxlength="6" disabled="disabled" name="authCode"
													id="authCode" type="text" autofocus> <span
													id="emailAuthWarn"></span>
											</div>
											<div class="col-auto"></div>
										</div>
									</div>
								</div>
							</div>
							<span id="passMessageemail" class="text-danger"></span>
						</div>

					</div>










					<div class="mb-3 row">
						<label for="user_zipcode" class="col-sm-3 col-md-2 col-form-label">주소</label>
						<div class="col-sm-9 col-md-10">
							<div class="form-group mb-2">
								<div class="row g-2">
									<div class="col-auto">

										<input type="text" class="form-control" name="user_zipcode"
											id="user_zipcode" placeholder="우편번호" readonly />
									</div>
									<div class="col-auto">
										<!-- 우편번호 찾기 버튼-->
										<button type="button" onclick="sample6_execDaumPostcode()"
											class="btn btn-secondary">우편번호 찾기</button>
									</div>
								</div>
							</div>


							<input type="text" class="form-control mb-2" id="sample6_address"
								name="user_addr" placeholder="주소"> <input type="text"
								class="form-control" id="sample6_detailAddress" name="user_addr"
								placeholder="상세주소">
						</div>
					</div>







					<!-- 버튼 -->
					<div
						class="mt-5 mb-5 d-flex flex-wrap justify-content-between align-items-end">
						<span class="fst-italic text-danger"></span>
						<div class="text-end">
							<button type="submit" class="btn btn-secondary"  id="registerBtn" disabled >
								<i class="fa-solid fa-user-check"></i> 회원가입
							</button>
							<a class="btn btn-outline-secondary"
								href="${contextPath }/user/login"><i
								class="fa-solid fa-user-xmark"></i> 취소</a>
						</div>
					</div>
		</form>

		<!--  다이얼로그창(모달) -->
		<!-- Modal -->
		<div id="myModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div id="checkType" class="modal-content panel-info">
					<div class="modal-header panel-heading">
						<button type="button" class="btn" data-bs-dismiss="modal">&times;</button>
						<h4 class="modal-title"></h4>
					</div>
					<div class="modal-body">
						<p id="checkMessage"></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn" data-bs-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
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
	</div>
	</div>
	</div>

</body>
</html>