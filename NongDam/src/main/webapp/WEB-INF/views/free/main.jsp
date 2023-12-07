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
    
    <script>
    	function checkinsert() {
    		
    			location.href="../free/detail";
    		}
    	

    </script>
    
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	<jsp:include page="../common/banner.jsp"/>
	
	
<!-- 게시판 조회 -->
<div id="a1">

    <!-- 게시판 tab+table div container-->
    <div class="container mt-5 mb-5">
        <!-- 태그 탭 -->
        <nav>
            <div class="nav nav-tabs" id="nav-tab" role="tablist">
                <!--  class="nav-link(기본) active(선택된 값) text-body(텍스트 색 지정)"-->
                <!-- 필요한 경우 button을 a 태그로 바꾸어도 괜찮습니다. (단, a태그로 바꾸는 경우 type=button 삭제하세요 )-->
                <button class="nav-link text-body active" data-bs-toggle="tab" type="button" role="tab" aria-controls="nav-home" aria-selected="true">전체</button>
                <button class="nav-link text-body" data-bs-toggle="tab" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">질문</button>
                <button class="nav-link text-body" data-bs-toggle="tab" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">자유</button>
            </div>
        </nav>
        
        <!-- 게시글 테이블 -->
        <div class="d-flex justify-content-end mt-4">
            <select class="btn btn-secondary dropdown-toggle" name="type">
                <option class="dropdown-item" value="title">제목</option>
                <option class="dropdown-item" value="title">작성자</option>
            </select>
        </div>
        <table class="table table-hover mt-2 text-center mw-100">
            <!-- 필요없는 열은 빼고 사용하세요. -->
            <thead>
                <tr class="table-dark">
                    <th>#</th>
                    <th>제목</th>
                    <th class=" d-none d-md-table-cell">날짜</th>
                    <th class=" d-none d-md-table-cell">작성자</th>
                    <th class=" d-none d-md-table-cell">추천</th>
                    <th class=" d-none d-md-table-cell">조회수</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>${free_idx}</td>
                    <td class="text-start">
                        <a href="javascript:void(0)" class="text-decoration-none text-body" id="a4button">
                            <span class="text-muted">[{태그명}]</span>
                            ${free_title}
                        </a>
                    </td>
                    <td class="text-muted d-none d-md-table-cell">${free_date}</td>
                    <td class=" d-none d-md-table-cell">${user_nickname}</td>
                    <td class=" d-none d-md-table-cell">{추천}</td>
                    <td class=" d-none d-md-table-cell">${free_idx}</td>
                </tr>
                <tr>
                    <td colspan="6">
                        <div class="d-flex flex-wrap justify-content-between">
                            <!-- 정렬용 더미 -->
                            <div class="d-none d-md-block" style="width: 70px"></div>
                            <!-- 검색 인풋 -->
                            <div style="width: 20rem;">
                                <div class="input-group" >
                                    <select class="btn btn-outline-secondary dropdown-toggle" name="type">
                                        <option class="dropdown-item" value="title">제목</option>
                                        <option class="dropdown-item" value="title">작성자</option>
                                    </select >
                                    <input type="text" class="form-control" placeholder="검색">
                                    <button class="btn btn-secondary" type="button">검색</button>
                                </div>
                            </div>
                            <!-- 글쓰기 버튼(2) -->
                            <button class="btn btn-outline-secondary" id="a3button" onclick="checkinsert()"> 글쓰기</button>
                        </div>
                    </td>    
                </tr>
            </tbody>
        </table>
        
        <!-- 페이징 -->
        <div class="mt-4">
            <nav class="d-flex justify-content-center">
                <ul class="pagination">
                    <!-- 이전 버튼 -->
                    <li class="page-item">
                        <a class="page-link text-secondary" href="#">&laquo;</a>
                    </li>
                    <!-- 현재 페이지 -->
                    <li class="page-item active " aria-current="page">
                        <a class="page-link bg-secondary border-secondary">1</a>
                    </li>
                    <!-- 일반 번호 -->
                    <li class="page-item"><a class="page-link text-secondary" href="#">2</a></li>
                    
                    <!-- 다음 버튼 -->
                    <li class="page-item">
                        <a class="page-link text-secondary" href="#">&raquo;</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
    <!-- ============================================== -->
</div>

	<jsp:include page="../common/footer.jsp"/>
</body>
</html>
