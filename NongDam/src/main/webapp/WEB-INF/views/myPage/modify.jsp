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
                                    <li class="list-group-item  bg-body-secondary">
                                        <a class="text-decoration-none text-body" href="${contextPath }/myPage/modify">회원정보 수정</a>
                                    </li>
                                    <li class="list-group-item">
                                        <a class="text-decoration-none text-body" href="${contextPath }/myPage/main">마이페이지 메인</a>
                                    </li>
                                    <li class="list-group-item">
                                        <a class="text-decoration-none text-body" href="${contextPath }/myPage/quit">회원 탈퇴</a>
                                    </li>
                                    <li class="list-group-item">
                                        <a class="text-decoration-none text-body" href="${contextPath }/myPage/gplist">공동구매 참여내역</a>
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
                        <!-- 여기부터 필요없는 부분만 지우고 사용하세요. -->
                        <!-- =============================================== -->
					<form name="frm" method="post" action="${contextPath }/user/signup">
						
						<div class="d-flex justify-content-center mt-5 mb-5">
							<div>
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
											
											<div>
												<!-- 아이디 input -->
												<input type="text" class="form-control" id="user_id"
													name="user_id" placeholder="4~20자" maxlength="20" readonly/>
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
							<div class="mt-5 mb-5 d-flex flex-wrap justify-content-between align-items-end">
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
							</div>
							</div>
							
						</form>


                        

                        


                        
                    <!-- 컨텐츠가 이 밖으로 나가면 안됩니다-->
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
