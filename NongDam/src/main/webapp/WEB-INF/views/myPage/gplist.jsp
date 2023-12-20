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
                                    <li class="list-group-item ">
                                        <a class="text-decoration-none text-body" href="${contextPath }/myPage/main">마이페이지 메인</a>
                                    </li>
                                    <li class="list-group-item ">
                                        <a class="text-decoration-none text-body" href="${contextPath }/myPage/modify">회원정보 수정</a>
                                    </li>
                                    
                                    <li class="list-group-item bg-body-secondary">
                                        <a class="text-decoration-none text-body" href="${contextPath }/myPage/gplist">공동구매 참여내역</a>
                                    </li>
                                    <li class="list-group-item">
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
                        <!-- 여기부터 필요없는 부분만 지우고 사용하세요. -->
                        <!-- =============================================== -->

                        <!-- 공동구매 -->
                        <div class="mt-2 mb-4 pb-4">
                            <h4 class="ms-2 mb-4 text-body-secondary"><i class="fa-solid fa-tag me-2"></i> 공동구매 신청 내역</h4>
                            <!-- 맨 윗줄 -->
                            <div class="d-flex flex-row flex-wrap pt-2 pb-2 border">
                                <div class="d-none d-lg-block col-1 text-center">
                                    #
                                </div>
                                <div class="col-12 col-lg-5 text-center">
                                    상품
                                </div>
                                <div class="d-none d-lg-block col-lg-3 text-center">
                                    일자
                                </div>
                                <div class="d-none d-lg-block col-lg-3 text-center">
                                    상세
                                </div>
                            </div>
                            <!-- 맨 윗줄 끝 =============================================== -->
                            <!-- 목록 하나 -->
                            <div class="d-flex flex-row flex-wrap justify-content-center align-items-center pt-3 pb-3 border border-top-0 bg-body-tertiary">
                                <div class="d-none d-lg-block col-1 text-center">
                                    {번호}
                                </div>
                                <div class="col-12 col-lg-5">
                                    <div class="d-flex gap-2 ms-3 me-3">
                                        <img src="https://images.unsplash.com/photo-1528301721190-186c3bd85418?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D" 
                                            class="bg-light object-fit-cover"
                                            style="width: 50px; height: 50px;">
                                        <div>
                                            <a href="#" class="text-decoration-none text-body title-overflow-1">
                                                <!-- 둘중 하나 사용하세요 -->
                                                <span class="text-danger">[거래중]</span>
                                                <span class="text-muted">[배송완료]</span>
                                                <!-- 상품명 -->
                                                <span>{상품명}이 긴 경우도 고려됨</span>
                                            </a>
                                            <div class="text-muted">
                                                <span>{0000}원</span>
                                                <span>{00}개</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6 col-lg-3 text-center">
                                    ~ {YYYY-MM-DD}
                                </div>
                                <div class="col-6 col-lg-3 text-center">
                                    <button class="btn btn-sm btn-secondary">세부내역</button>
                                    <button class="btn btn-sm btn-secondary">취소하기</button>
                                </div>
                            </div>
                            <!-- 목록 하나 끝 =============================================== -->
                            <!-- 목록의 세부내역 버튼을 클릭했을 때 나오는 배송지(세부내역) -->
                            <div class="p-3 pt-2 pb-2 border border-top-0">
                                <div class="p-2 pt-3 pb-3">
                                    <h6 class="mb-3">
                                        배송지 설정
                                    </h6>
                                    <!-- 성명 -->
                                    <div class="row align-items-center pb-2">
                                        <div class="col-12 col-sm-2">
                                            성명
                                        </div>
                                        <div class="col-12 col-sm-5">
                                            <input type="text" placeholder="성명" class="form-control">
                                        </div>
                                    </div>
                                    <!-- 배송지 -->
                                    <div class="row mb-2">
                                        <label class="form-label col-12 col-sm-2">배송지</label>
                                        <div class="mb-4 col-12 col-sm-10">
                                            <div class="form-group">
                                                <div class="row mb-2">
                                                    <div class="col-5">
                                                        <!-- 우편번호. readonly로 되어있으나 풀어도 됩니다 -->
                                                        <input type="text" class="form-control" id="user_zipcode" placeholder="00000" readonly>
                                                    </div>
                                                    <div class="col-7">
                                                        <!-- 우편번호 찾기 버튼. -->
                                                        <button class="btn btn-secondary">우편번호 찾기</button>
                                                    </div>
                                                </div>
                                            </div>
                                            <input type="text" class="form-control mb-2" id="user_zipcode2" placeholder="주소">
                                            <input type="text" class="form-control" id="user_zipcode3" placeholder="상세 주소">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-end">
                                        <button class="btn btn-sm btn-outline-secondary me-1"><i class="fa-solid fa-gear"></i> 수정하기</button>
                                    </div>
                                </div>
                            </div>
                            <!-- 세부내역 끝 =============================================== -->

                            <!--공동구매 끝 =============================================== -->
                        </div>
                        <!-- =============================================== -->





                        


                        
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
