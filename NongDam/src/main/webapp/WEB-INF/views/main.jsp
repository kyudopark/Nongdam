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

<!-- 231222 modal -->
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

	<jsp:include page="common/header.jsp" />


	<!-- 메인페이지 7/5 row -->
	<div class="container mt-5 md-5">
		<div class="border rounded-2 container">
			<div class="row">
				<div class="col-lg-7 col-12 p-3">
					<p class="d-flex flex-wrap">
						<span class="d-inline-block me-auto fs-6 fw-bolder">추천하는 최신
							정보를 알려드립니다.</span> <a class="d-inline-block text-muted"
							href="${contextPath }/info/main">정보 게시판으로 &gt;</a>
					<div class="row p-3">
						<img class="col-12 col-sm-6 bg-light object-fit-cover p-0"
							style="min-height: 240px" src="#" />
						<div class="col-12 col-sm-6 pt-3">
							<p class="fw-bolder">{제목}</p>
							<p class="title-overflow-6">{내용}</p>
						</div>
					</div>
					</p>
				</div>
				<!-- 공동구매 마감 임박 상품들 -->
				<div class="border-start col-lg-5 col-12 p-3">
				    <p class="d-flex flex-wrap">
				        <span class="d-inline-block me-auto fs-6 fw-bolder">공동구매 마감
				            임박 상품들</span> <a class="d-inline-block text-muted"
				            href="${contextPath }/gp/main">공동구매 게시판 &gt;</a>
				    </p>
				    <div id="carouselExample" class="carousel carousel-dark slide" data-bs-ride="carousel">
				        <div class="carousel-inner">
				            <c:forEach var="gplist" items="${gplist}" varStatus="loop">
				                <div class="carousel-item ${loop.first ? 'active' : ''}">
				                    <div class="row p-3">
				                        <img class="col-12 col-sm-6 bg-light object-fit-cover p-0"
				                            style="height: 240px"
				                            src="${contextPath }/resources/image/gp/${gplist.gp_thumb }" />
				                        <div class="col-12 col-sm-6 pt-3">
				                            <p class="fw-bolder">상품명 : ${gplist.gp_title}</p>
				                            <p class="title-overflow-6">신청 시작일 : <fmt:formatDate value="${gplist.gp_date_start }" pattern="YYYY-MM-dd "/></p>
				                            <p class="title-overflow-6">신청 마감일 : <fmt:formatDate value="${gplist.gp_date_last }" pattern="YYYY-MM-dd "/></p>
				                            <p class="title-overflow-6">신청 가격 : ${gplist.gp_price }</p>
				                            <a class="btn btn-outline-secondary" href="${contextPath }/gp/detail?gp_idx=${gplist.gp_idx}">게시글 더보기</a>
				                        </div>
				                    </div>
				                </div>
				            </c:forEach>
				        </div>
				        <a class="carousel-control-prev" href="#carouselExample" role="button" data-bs-slide="prev"></a>
				        <a class="carousel-control-next" href="#carouselExample" role="button" data-bs-slide="next"></a>
				        <div class="carousel-indicators mb-0">
							<button data-bs-target="#carouselExample" data-bs-slide-to="0" class="btn bg-tertiary active" aria-current="true" aria-label="Slide 1"></button>
							<button data-bs-target="#carouselExample" data-bs-slide-to="1" class="btn bg-tertiary" aria-label="Slide 2"></button>
							<button data-bs-target="#carouselExample" data-bs-slide-to="2" class="btn bg-tertiary" aria-label="Slide 3"></button>
							<button data-bs-target="#carouselExample" data-bs-slide-to="3" class="btn bg-tertiary" aria-label="Slide 4"></button>
						</div>
				    </div>
				</div>
			</div>
		</div>
	</div>

	<!-- 메인페이지 뉴스레터 홍보글-->
	<div class="mt-5 mb-5 bg-secondary text-light p-3"
		style="height: 110px;">
		<div class="container d-flex">
			<div>
				<i class="fa-solid fa-seedling fa-lg" aria-hidden="false"></i>
			</div>
			<div>
				<h5>추천하는 최신 정보를 알려드립니다.</h5>
				<div>
					<p class="m-0">
						Lorem ipsum dolor sit amet, <br> consectetur adipisicing
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
				<span class="d-inline-block me-auto fs-5 fw-bolder">지금 사람들이
					거래중인 농기구를 싸게 구매해보세요.</span> <a class="d-inline-block text-muted"
					href="${contextPath }/tr/main"> 더보기 &gt;</a>
			</p>
			<div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 ">

				<!-- 카드 하나 시작 -->
			<c:forEach var="trlist" items="${trlist }">
				<div class="col  pb-4">
						<a class="text-decoration-none"
							href="${contextPath }/tr/detail?tr_idx=${trlist.tr_idx}">
							<div class="card">
								<c:if test="${!empty trlist.tr_imgpath}">
									<img
										class="border-bottom rounded-2 bg-light w-100 object-fit-cover"
										height="200px"
										src="${trlist.tr_imgpath }">
								</c:if>
								<c:if test="${empty trlist.tr_imgpath }">
									<img src="${contextPath }/resources/image/common/thumbnail.svg"
										class="border-bottom rounded-2 bg-light w-100 object-fit-cover"
										height="200">
								</c:if>
								<div class="card-body">
									<h5 class="card-title title-overflow-2">${trlist.tr_title }
									</h5>
									<p class="card-text">
										작성자 ${trlist.user_nickname} <br>
										<fmt:formatDate value="${trlist.tr_time }"
											pattern="YYYY-MM-dd " />
									</p>
								</div>
							</div>
						</a>
					
				</div>
				</c:forEach>
				<!-- 카드 하나 끝 -->

			</div>
			<!-- 더보기 버튼-->
			<div class="d-flex justify-content-center">
				<a class="btn btn-lg btn-outline-secondary"
					href="${contextPath }/tr/main">게시글 더보기</a>
			</div>
		</div>
	</div>
	<!-- ============================================== -->


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
					<button type="button" class="btn"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>


	<jsp:include page="common/footer.jsp" />
</body>
</html>
