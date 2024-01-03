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
    <script type="text/javascript" src="${contextPath }/resources/common/js/free/bannerText.js"></script>

</head>

<body>
	<jsp:include page="../common/header.jsp"/>
	<jsp:include page="../common/banner.jsp"/>

    <!-- 글 작성 div container-->
    <div class="container mt-5 mb-5">
        <h4 class="mt-5 mb-5"> 게시글 수정</h4>
        <form method="post">

            <!-- 말머리 있는 버전 -->
            <div class="row">
                <!-- 말머리 -->
                <div class="col-12 col-md-3 mb-3">
                    <select class="form-select" name="free_tag" id="free_tag">
						<option value="자유" ${vo.free_tag == '자유' ? 'selected' : ''}>자유</option>
    					<option value="질문" ${vo.free_tag == '질문' ? 'selected' : ''}>질문</option>
                    </select>
                </div>
                <!--제목-->
                <div class="col-12 col-md-9 form-group mb-3">
                    <input type="text" id="title" name="free_title" value="${vo.free_title }" class="form-control">
                </div>
            </div>

            <!-- ckEditor -->
            <div class="form-group mt-5 mb-3">
                <!-- 실제 에디터 박스-->
                <!-- id는 변경하지 마세요 -->
                <textarea id="editor" name="free_content">
                    <p>${vo.free_content }</p>
                    <p></p>
                    <p></p>
                </textarea>
                <!-- 스크립트문. 항상 에디터 박스 바로 뒤에 놓을 것-->
			 	<script>
			        ClassicEditor
			            .create(document.querySelector('#editor'), {
			                ckfinder: {
			                    uploadUrl: 'fileupload.do' 
			                }
			            })
			            .then(editor => {
			                console.log('Editor was initialized', editor);
			            })
			            .catch(error => {
			                console.error('There was an error initializing the editor', error);
			            });
			    </script>
            </div>

            <!-- 글 작성하기 버튼-->
            <div class="text-center">
                <button type="sumbit" class="btn btn-secondary" id="modify">글 수정하기</button>
                <a href="javascript:history.go(-1)" class="btn btn-outline-secondary">취소</a>
            </div>
        </form>
    </div>
   
    
    <!-- ============================================== -->

</body>
</html>
