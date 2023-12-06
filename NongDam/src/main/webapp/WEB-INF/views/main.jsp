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

	<jsp:include page="common/header.jsp"/>
	

	<!-- 메인페이지 7/5 row -->
    <div class="container mt-5 md-5">
        <div class="border rounded-2 container">
            <div class="row">
                <div class="col-lg-7 col-12 p-3">
                    <p class="d-flex flex-wrap">
                        <span class="d-inline-block me-auto fs-6 fw-bolder">추천하는 최신 정보를 알려드립니다.</span>
                        <a class="d-inline-block text-muted" href="${contextPath }/info/main">정보 게시판으로 &gt;</a>
                        <div class="row p-3">
                            <img class="col-12 col-sm-6 bg-light object-fit-cover p-0" 
                            style="min-height: 240px"
                            src="#"/>
                            <div class="col-12 col-sm-6 pt-3">
                                <p class="fw-bolder">{제목}</p>
                                <p class="title-overflow-6">
                                    {내용}
                                </p>
                            </div>
                        </div>
                    </p>
                </div>
                <div class="border-start col-lg-5 col-12 p-3">
                    <p class="d-flex flex-wrap">
                        <span class="d-inline-block me-auto fs-6 fw-bolder">공동구매 마감 임박 상품들</span>
                        <a class="d-inline-block text-muted" href="${contextPath }/gp/main">공동구매 게시판 &gt;</a>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- 메인페이지 뉴스레터 홍보글-->
    <div class="mt-5 mb-5 bg-secondary text-light p-3" style="height: 110px;">
        <div class="container d-flex">
            <div>
                <i class="fa-solid fa-seedling fa-lg" aria-hidden="false"></i>
            </div>
            <div>
                <h5>추천하는 최신 정보를 알려드립니다.</h5>
                <div>
                    <p class="m-0">
                        Lorem ipsum dolor sit amet, 
                        <br>
                        consectetur adipisicing 
                    </p>
                </div>
            </div>
        </div>
    </div>
    <!-- ============================================== -->

    <!--카드형식 div container-->
    <div class="container mt-5 mb-5">
        <div class="border rounded-2 p-4 container">
            <p class="d-flex flex-wrap">
                <span class="d-inline-block me-auto fs-5 fw-bolder">지금 사람들이 거래중인 농기구를 싸게 구매해보세요.</span>
                <a class="d-inline-block text-muted" href="${contextPath }/tr/main"> 더보기 &gt;</a>
            </p>
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 ">
                
                <!-- 카드 하나 시작 -->
                <div class="col  pb-4">
                    <a class="text-decoration-none" href="#">
                        <div class="card">
                            <img class="border-bottom rounded-2 bg-light w-100 object-fit-cover" height="200px"
                            src="#">
                            <div class="card-body">
                                <h5 class="card-title title-overflow-2">
                                    {1:1거래게시판 제목}
                                </h5>
                                <p class="card-text">
                                    작성자 {닉네임}
                                    <br>
                                    작성일 {YYYY-MM-DD}
                                </p>
                            </div>
                        </div>
                    </a>
                </div>
                <!-- 카드 하나 끝 -->
                

            </div>
            <!-- 더보기 버튼-->
            <div class="d-flex justify-content-center">
                <a class="btn btn-lg btn-outline-secondary" href="${contextPath }/tr/main">게시글 더보기</a>
            </div>
        </div>
    </div>
    <!-- ============================================== -->
	
	
	
	<jsp:include page="common/footer.jsp"/>
</body>
</html>
