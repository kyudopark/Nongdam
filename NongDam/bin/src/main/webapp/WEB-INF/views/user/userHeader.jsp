<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<script type="text/javascript" src="${contextPath }/resources/common/js/darkmode.js"></script>
	<header class="border-bottom bg-body-tertiary" >
	    <div class="container pt-2 fw-bolder">
	        
	        <!-- 두번째 줄 -->
	        <div class="pt-2 fs-5 d-flex pb-4" style="">
	            <!-- 두번째 줄 왼편(로고) -->
	            <a class="navbar-brand mb-auto"  href="${contextPath }/">
	                <img src="https://getbootstrap.com/docs/5.3/assets/brand/bootstrap-logo.svg"
	                style="width: 30px;" alt="logo">
	                <span>로고</span>
	            </a>
	            
	        </div>
	        
	        <!-- 마지막 줄 끝-->
	    </div>
	</header>
  <!-- ============================================== -->
