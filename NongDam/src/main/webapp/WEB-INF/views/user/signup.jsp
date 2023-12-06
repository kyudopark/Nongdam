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


<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('user_zipcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
<script type="text/javascript">
$(document).ready(function(){
	if(${not empty msgType}){
		$("#messageType").attr("class", "modal-content panel-warning");
		$("#myMessage").modal("show");
	}
	
	
	
});

function passwordCheck(){
	var userPass1=$("#user_pw").val();
	var userPass2=$("#user_pw2").val();
	if(userPass1!=userPass2){
		$("#passMessage").html("비밀번호가 일치하지 않습니다");
	}
	else{
		$("#passMessage").html("");
		$("#user_pw1").val(userPass1);	//서버에 일치하는 비번값 넘겨준다(hidden으로 - #memPassword)
	}
} 


function registerCheck(){
	var user_id=$("#user_id").val();
	//result : 1 (사용할 수 있는 아이디) / 0 : 사용할 수 없는 아이디
	$.ajax({
		url:"${contextPath}/user/userRegisterCheck",
		type:"get",
		data:{"user_id":user_id},
		success:function(result){
			if(result==1){
				$("#checkMessage").html("사용가능한 아이디 입니다");					
				}
			else{
				$("#checkMessage").html("중복 아이디 입니다.");					
			}
			$("#myModal").modal('show');
		},
		error:function(){
			alert("error");
		}
	});
}

	
	
	
</script>
</head>
<body>

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
											name="user_id" placeholder="0~00자" />
									</div>
									<div class="col-auto">
										<!-- 중복검사 버튼-->
										<button type="button" class="btn btn-secondary" onclick="registerCheck()">중복확인</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="user_pw" class="col-sm-3 col-md-2 col-form-label">비밀번호<span
							class="text-danger">*</span></label>
						<div class="col-sm-9 col-md-10">
							<input type="password" class="form-control" id="user_pw" onkeyup="passwordCheck()"
								name="user_pw" placeholder="0~00자" />
						</div>
					</div>

					<div class="mb-3 row">
						<label for="user_pw2" class="col-sm-3 col-md-2 col-form-label">비밀번호확인<span
							class="text-danger">*</span></label>
						<div class="col-sm-9 col-md-10">
							<input type="password" class="form-control" id="user_pw2" name="user_pw2" onkeyup="passwordCheck()" />
							<!-- 아래 span태그를 가리려면 span class에 d-none을 추가하면 됩니다 -->
							<!-- 편한 자리로 옮기거나 추가해서 사용하세요-->
							<span id="passMessage" class="text-danger"></span>
						</div>
					</div>

					<div class="mb-3 row">
						<label for="user_name" class="col-sm-3 col-md-2 col-form-label">이름<span
							class="text-danger">*</span></label>
						<div class="col-sm-9 col-md-10">
							<input type="text" class="form-control" id="user_name"
								name="user_name" placeholder="이름을 입력하세요" />
						</div>
					</div>

					<div class="mb-3 row">
						<label for="user_nickname"
							class="col-sm-3 col-md-2 col-form-label">닉네임<span
							class="text-danger">*</span></label>
						<div class="col-sm-9 col-md-10">
							<input type="text" class="form-control" id="user_nickname"
								name="user_nickname" placeholder="닉네임을 입력하세요" />
						</div>
					</div>

					<div class="mt-4 mb-3 row">
    <label class="col-sm-3 col-md-2 col-form-label">성별<span class="text-danger">*</span></label>
    <div class="col-sm-9 col-md-10">
        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="user_gender" id="user_gender_male" value="1" checked />
            <label class="form-check-label" for="user_gender_male">남자</label>
        </div>
        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="user_gender" id="user_gender_female" value="0" />
            <label class="form-check-label" for="user_gender_female">여자</label>
        </div>
    </div>
</div>


					<div class="mb-3 row">
						<label for="user_email" class="col-sm-3 col-md-2 col-form-label">이메일<span
							class="text-danger">*</span></label>
						<div class="col-sm-9 col-md-10">
							<input type="email" class="form-control" id="user_email" name="user_email"
								placeholder="비밀번호 찾기시 사용됩니다" />
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
										<button type="button" onclick="sample4_execDaumPostcode()"
											class="btn btn-secondary">우편번호 찾기</button>
									</div>
								</div>
							</div>
							<input type="text" class="form-control mb-2"
								id="sample4_roadAddress" name="user_addr" placeholder="도로명 주소" />
							<input type="text" class="form-control"
								id="sample4_detailAddress" name="user_addr" placeholder="상세 주소" />
						</div>
					</div>




					<div class="mb-3 row">
						<label for="formFile" class="col-sm-3 col-md-2 col-form-label">프로필
							사진</label>
						<div class="col-sm-9 col-md-10">
							<input class="form-control" type="file" id="formFile" />
						</div>
					</div>
		

		<!-- 버튼 -->
		<div
			class="mt-5 mb-5 d-flex flex-wrap justify-content-between align-items-end">
			<span class="fst-italic text-danger">{에러메세지 또는 설명 텍스트인데 쓸거 없으면
				그냥 텍스트만 비워주세요.}</span>
			<div class="text-end">
				<button type="submit" class="btn btn-secondary">
					<i class="fa-solid fa-user-check"></i> 회원가입
				</button>
				<a class="btn btn-outline-secondary" href="#"><i
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
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title"></h4>
						</div>
						<div class="modal-body">
							<p id="checkMessage"></p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
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
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">${msgType}</h4>
						</div>
						<div class="modal-body">
							<p>${msg}</p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
	</div>
	</div>
	</div>

</body>
</html>