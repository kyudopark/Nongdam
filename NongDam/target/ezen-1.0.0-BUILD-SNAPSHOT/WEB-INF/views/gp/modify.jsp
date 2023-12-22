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
    <script type="text/javascript" src="${contextPath }/resources/gp/js/script.js"></script>
    
    <meta name="농담" content="안녕하세요, 농업 정보 커뮤니티 농담입니다."/>
    
    <!-- 파비콘 -->
    <link rel="icon" type="image/x-icon" href="${contextPath }/resources/image/common/favicon.ico"/>
    <link rel="shortcut icon" type="image/x-icon" href="${contextPath }/resources/image/common/favicon.ico"/>
    
    <title>농담 | 농업 정보 커뮤니티</title>
    
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	<jsp:include page="../common/banner.jsp"/>
	
	
	<!-- 여기에 컨텐츠를 추가 -->
	<!-- 글 작성 div container-->
    <div class="container mt-5 mb-5">
        <h4 class="mt-5 mb-5">공동구매 게시글 작성</h4>
        <form method="post" enctype="multipart/form-data">
            
            <!--제목-->
            <div class="form-group mb-3">
                <input type="text" id="gp_title" name="gp_title" value="${vo.gp_title}" 
                class="form-control" placeholder="제목을 입력하세요.">
            </div>
            
            <!-- 썸네일 -->
            <div  class="row g-3 mb-3" >
                <div class="col-12 col-md-5">
                    <div class="rounded bg-light 
                    d-flex justify-content-center align-items-center" 
                    style="height: 200px;">
                        <!-- 이미지 존재시 아래 img태그에 src추가 -->
                        <img class="object-fit-cover w-100 h-100" 
                        src="${contextPath }/resources/image/gp/${vo.gp_thumb }">    
                        <!-- 이미지 없을 때 아래 div 태그 보이게 -->
                        <div class="d-none"> 
                            썸네일을 등록해주세요. 
                        </div>
                    </div>
                </div>
				
                <div class="col-12 col-md-7">
                    <!-- 공동구매 라인 -->
                    <label class="form-label">공동구매 시간 설정</label>
                    <div class="row g-3 mb-3">
                        <div class="col-12 col-lg-3">
                            <input type="date"
                            class="form-control"
                            name="gp_date_start"
                            data-placeholder="시작일 선택"
                            required
                            aria-required="true" >
                        </div>
                        <div class="col-12 col-lg-3">
                            <input type="date" 
                            class="form-control"
                            name="gp_date_last"
                            data-placeholder="마감일 선택"
                            required
                            aria-required="true" >
                        </div>
                    </div>
                    <!-- 파일 업로드 input태그 -->
                    <div class="mb-3">
                        <label for="thumbImg" class="form-label">썸네일 올리기</label>
                        <input class="form-control" type="file" id="thumbImg" name="thumbImg">
                    </div>
                    
                    <div class="md-3">
                    	<input type="text" id="gp_price" name="gp_price" value="${vo.gp_price}"
                		class="form-control" placeholder="가격을 입력하세요.">
                	</div>
                	
                </div>
            </div>


            <!-- ckEditor -->
            <div class="form-group mt-5 mb-3">
                <!-- 실제 에디터 박스-->
                <!-- id는 변경하지 마세요 -->
                <textarea id="editor" name="gp_content">
                    <p>${vo.gp_content }</p>
                </textarea>
                <!-- 스크립트문. 항상 에디터 박스 바로 뒤에 놓을 것-->
                <script>
                    ClassicEditor
                        .create( document.querySelector( '#editor' ) )
                        .catch( error => {
                            console.error( error );
                    });
                </script>
            </div>

            <!-- 글 작성하기 버튼-->
            <div class="text-center">
                <button type="submit" class="btn btn-secondary">글 수정하기</button>
                <a href="javascript:history.go(-1)" class="btn btn-outline-secondary">취소</a>
            </div>
        </form>
    </div>
    <!-- ============================================== -->
	
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>
