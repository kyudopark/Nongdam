<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

	<header class="border-bottom bg-body-tertiary">
	    <div class="container pt-2 fw-bolder">
	        <!--첫번째 줄-->
	        <div class="fw-bolder" style="font-size: smaller;">
	            <ul class="nav gap-2 align-items-center justify-content-end">
	            	<c:if test="${!empty uvo }">
		                <li>
		                	<a href="#" class="text-decoration-none text-body">
			                    <i class="fa-solid fa-seedling"></i>
			                    ${uvo.user_nickname }님
		                    </a>
		                </li>
	                </c:if>
	                <li><button class="btn btn-sm btn-secondary mode-change-btn" onclick="darkMode()">다크모드</button></li>
	            </ul>
	        </div>
	        <!-- 두번째 줄 -->
	        <div class="pt-2 fs-5 d-flex justify-content-between">
	            <!-- 두번째 줄 왼편(로고) -->
	            <a class="navbar-brand mb-auto"  href="${contextPath }/">
	                <img src="https://getbootstrap.com/docs/5.3/assets/brand/bootstrap-logo.svg"
	                style="width: 30px;" alt="logo">
	                <span>로고</span>
	            </a>
	            <!-- 두번째줄 오른편 -->
	            <div class="navbar navbar-expand-sm bg-body-tertiary text-end justify-content-end" id="navbarSupportedContent">
	                <!-- 모바일 화면에서의 버거메뉴 활성화 버튼-->
	                <button class="navbar-toggler text-right" id="header-button">
	                    <i class="fa-solid fa-bars"></i>
	                </button>
	                
	                <!-- 사이드 -->
	                <div class="collapse navbar-collapse">
	                    <ul class="navbar-nav fs-6">
	                    <c:if test="${empty uvo }">
	                    	<li class="nav-item">
	                            <a class="nav-link" href="${contextPath }/user/login">로그인</a>
	                        </li>
	                        <li class="nav-item">
	                            <a class="nav-link" href="${contextPath }/user/signup">회원가입</a>
	                        </li>
	                    </c:if>
	                    <c:if test="${!empty uvo }">
	                        <li class="nav-item">
	                            <button class="nav-link d-inline-block" onclick="openChat()">채팅</button>
	                        </li>
	                        <li class="nav-item">
	                            <a class="nav-link" href="${contextPath }/user/logout">로그아웃</a>
	                        </li>
	                        <li class="nav-item">
	                            <a class="nav-link" href="${contextPath }/myPage/main" id="a5button">마이페이지</a>
	                        </li>
	                       </c:if>
	                    </ul>
	                </div>
	            </div>
	        </div>
	        <!-- 세번째 줄 -->
	        <div class="navbar navbar-expand-sm bg-body-tertiary">
	            <div class="collapse navbar-collapse fs-5">
	                <ul class="navbar-nav gap-2">
	                    <li class="nav-item"><a class="nav-link" href="${contextPath }/info/main">정보게시판</a></li>
	                    <li class="nav-item"><a class="nav-link" href="${contextPath }/free/main" id="a1button">자유게시판</a></li>
	                    <li class="nav-item"><a class="nav-link" href="${contextPath }/tr/main">1:1 거래</a></li>
	                    <li class="nav-item"><a class="nav-link" href="${contextPath }/gp/main">공동구매</a></li>
	                    <li class="nav-item"><a class="nav-link" href="${contextPath }/inquire/main">문의하기</a></li>
	                </ul>
	            </div>
	        </div>
	        <!-- 마지막 줄 끝-->
	    </div>
	</header>
  <!-- ============================================== -->
