<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<html lang="ko" data-bs-theme="light">
<head>
<!-- UTF-8 사용-->
<meta charset="UTF-8">
<!-- 기본 화면 보기 설정 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- bootstrap 5.3.2 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
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

<!-- fontAwesome -->
<script src="https://kit.fontawesome.com/f34a67d667.js"
	crossorigin="anonymous"></script>

<!-- 스타일시트 -->
<link rel="stylesheet"
	href="${contextPath }/resources/common/css/style.css">
<!-- 기본js -->
<script type="text/javascript"
	src="${contextPath }/resources/common/js/common.js"></script>

<meta name="농담" content="안녕하세요, 농업 정보 커뮤니티 농담입니다." />

<!-- 파비콘 -->
<link rel="icon" type="image/x-icon"
	href="${contextPath }/resources/image/common/favicon.ico" />
<link rel="shortcut icon" type="image/x-icon"
	href="${contextPath }/resources/image/common/favicon.ico" />

<title>농담 | 농업 정보 커뮤니티</title>





</head>

<body>

	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/banner.jsp" />

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
							<button class="accordion-button" type="button"
								data-bs-toggle="collapse" data-bs-target="#collapseOne"
								aria-expanded="true" aria-controls="collapseOne">
								관리자페이지</button>
						</h2>
						<div id="collapseOne" class="accordion-collapse collapse show"
							data-bs-parent="#accordionExample">
							<div class="accordion-body p-0">
								<ul class="list-group list-group-flush rounded-bottom-2">
									<li class="list-group-item  bg-body-secondary"><a
										class="text-decoration-none text-body" href="#">회원 정보 변경</a></li>
									<li class="list-group-item"><a
										class="text-decoration-none text-body" href="#">{메뉴}</a></li>
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
						<!-- 관리자페이지-회원탈퇴 -->
						<div class="pt-4 pb-4 mt-4 mb-4">
							<h4 class="ms-2 mb-4 text-body-secondary">
								<i class="fa-solid fa-wrench me-2"></i> 회원 상태 변경
							</h4>
							<div class="pt-2">
								<!-- 검색 파트 -->
								<form method="get">
									<div class="d-flex flex-row flex-wrap justify-content-between">
										<div class="col-12 col-lg-auto">
											<div class="input-group mb-3">
												<select class="btn btn-outline-secondary dropdown-toggle"
													name="type">
													<option class="dropdown-item" value="user_name"
														${cri.type == 'user_name' ? 'selected' : ''}>이름</option>
													<option class="dropdown-item" value="user_nickname"
														${cri.type == 'user_nickname' ? 'selected' : ''}>닉네임</option>
													<option class="dropdown-item" value="user_id"
														${cri.type == 'user_id' ? 'selected' : ''}>아이디</option>
												</select> <input type="text" name="keyword" class="form-control"
													value="${cri.keyword}" placeholder="검색">
												<button class="btn btn-secondary" type="submit">검색</button>
											</div>
										</div>
										<div class="col-auto">
											<button type="button" class="btn btn-danger"
												onclick="deleteSelectedUsers()">선택 회원 탈퇴</button>
										</div>
									</div>
								</form>
								<!-- 리스트 -->
								<div class="text-center title-overflow-1">
									<!-- head -->
									<div class="fw-bolder bg-body-secondary"
										style="padding-right: 16px;">
										<div
											class="d-flex flex-wrap align-items-center pt-1 pb-1 border-bottom">
											<div class="d-none d-lg-block col-lg-1">#</div>
											<div class="col-3 col-md-2 col-lg-1 pt-1 pb-1">이름</div>
											<div class="col-3 col-md-3 col-lg-2 pt-1 pb-1">닉네임</div>
											<div
												class="d-none d-lg-block col-lg-3 pt-1 pb-1 title-overflow-1">아이디</div>
											<div class="d-none d-lg-block col-lg-1 pt-1 pb-1">SNS</div>
											<div class="col-2 col-md-2 col-lg-1 pt-1 pb-1">선택</div>
											<div class="col-4 col-md-5 col-lg-3 pt-1 pb-1">처리</div>
										</div>
									</div>
									<!-- head 끝 -->
									<!-- body 시작 -->
									<div class="overflow-y-scroll overflow-x-hidden"
										style="max-height: 500px;">
										<c:forEach var="li" items="${li}">
											<div
												class="d-flex flex-wrap align-items-center pt-2 pb-2 border-bottom">
												<div class="d-none d-lg-block col-lg-1">${li.user_idx}</div>
												<div class="col-3 col-md-2 col-lg-1 pt-1 pb-1">${li.user_name}</div>
												<div class="col-3 col-md-3 col-lg-2 pt-1 pb-1">${li.user_nickname}</div>
												<div
													class="d-none d-lg-block col-lg-3 title-overflow-1 pt-1 pb-1">${li.user_id}</div>
												<div class="d-none d-lg-block col-lg-1 pt-1 pb-1">
													<!-- 셋 중 하나를 사용 -->
													<span class="badge text-bg-warning">카카오</span>
													<!-- <span class="badge text-bg-secondary">자체 회원</span> -->
													<!-- <span class="badge text-bg-primary bg-gradient">구글</span> -->
												</div>
												<div class="col-2 col-md-2 col-lg-1 pt-1 pb-1">
													<input type="checkbox" name="selectedUsers"
														value="${li.user_idx}">
												</div>
												<div class="col-4 col-md-5 col-lg-3 pt-1 pb-1">
													<a href="#" class="updateadminbutton${li.user_idx}"
														onclick="updateAdminStatus(${li.user_idx}, ${li.user_admin})">${li.user_admin ? '관리자 해제' : '관리자 설정'}</a>
													<span> | </span> <a href="#"
														onclick="deleteByIdx(${li.user_idx})">탈퇴</a>
												</div>
											</div>
										</c:forEach>
									</div>
									<!-- body 끝 -->
								</div>
							</div>
						</div>



						<!-- 컨텐츠가 이 밖으로 나가면 안됩니다-->
					</div>
				</div>
			</div>
			<!-- 오른쪽 화면 끝 -->
		</div>
	</div>
	<!-- 마이페이지 끝 -->


	<script>
	function deleteSelectedUsers() {
	    var checkboxes = document.getElementsByName("selectedUsers");
	    var selectedUsers = [];
	    
		let result = confirm('정말 탈퇴하시겠습니까?');
		
		if(result == true){
		
		    for (var i = 0; i < checkboxes.length; i++) {
		        if (checkboxes[i].checked) {
		            selectedUsers.push(parseInt(checkboxes[i].value)); // 배열에 숫자로 변환된 값 추가
		        }
		    }
	
		    if (selectedUsers.length > 0) {
		        $.ajax({
		            type: "POST",
		            url: "${contextPath}/admin/deleteByCheckbox", // 수정 필요한 부분
		            data: JSON.stringify(selectedUsers),
		            contentType: "application/json",
		            success: function (response) {
		                alert("탈퇴되었습니다.");
		                location.reload();
		            },
		            error: function (xhr, status, error) {
		                console.log("탈퇴에 실패했습니다.");
		                console.log(error);
		            }
		        });
		    } else {
		       alert("선택된 사용자가 없습니다.");
		    }
		}
		
	}
	
	
  function updateAdminStatus(userIdx, userAdmin) {
    $.ajax({
      url: '${contextPath}/admin/updateAdminStatus',
      type: 'POST',
      data: {
        "user_idx": userIdx,
        "user_admin": !userAdmin
      },
      success: function(response) {
       console.log('업데이트 성공');
       let button = $(".updateadminbutton"+ userIdx);
       if(button.text() === "관리자 설정"){
         button.removeClass("btn-danger").addClass("btn-primary").text("관리자 해제");
         alert("변경되었습니다.");
       } else if(button.text() === "관리자 해제"){
         button.removeClass("btn-primary").addClass("btn-danger").text("관리자 설정");
         alert("변경되었습니다.");
       }
      },
      error: function(xhr, status, error) {
        console.error('업데이트 실패', error);
      }
    });
  }
</script>

	<script type="text/javascript">
		function deleteByIdx(user_idx){
			let result = confirm('정말 삭제하시겠습니까? 유저 정보가 삭제됩니다.');
				
			if(result == false){
				return;
			}else{
				$.ajax({
					url:"deleteByIdx",
					type:"post",
					data:{"user_idx":user_idx},
					success:function(data){
						alert("성공적으로 삭제되었습니다.");
						location.href="${contextPath}/admin/userManage";
					},
					error:function(){
						alert("error");
					}
				})
				
			}
		}
		
		</script>

	<jsp:include page="../common/footer.jsp" />
</body>
</html>
