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

<script type="text/javascript" src="http://api.nongsaro.go.kr/js/framework.js"></script>	
<script type="text/javascript" src="http://api.nongsaro.go.kr/js/openapi_nongsaro.js"></script>

	
<!-- <script type="text/javascript">
nongsaroOpenApiRequest.apiKey = "202312264D3QMKKMXGFTEQRGQ5BTYG";
nongsaroOpenApiRequest.serviceName = "cropTechInfo";
nongsaroOpenApiRequest.operationName = "mainCategoryList";
nongsaroOpenApiRequest.htmlArea="nongsaroApiLoadingArea";
nongsaroOpenApiRequest.callback = "http://localhost:8080/ezen/user/googlecallback";

</script> -->

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
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                마이페이지
                            </button>
                        </h2>
                        <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">
                            <div class="accordion-body p-0">
                                <ul class="list-group list-group-flush rounded-bottom-2">
                                    <li class="list-group-item  bg-body-secondary">
                                        <a class="text-decoration-none text-body" href="${contextPath }/myPage/main">마이페이지 메인</a>
                                    </li>
                                    <li class="list-group-item">
                                        <a class="text-decoration-none text-body" href="${contextPath }/myPage/modify">회원정보 수정</a>
                                    </li>
                                    
                                    <li class="list-group-item">
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
                       <h4 class="ms-2 mb-4 text-body-secondary"><i class="fa-solid fa-user-lock me-2"></i> 마이페이지 메인</h4>
                       <form action="${contextPath }/myPage/userImageUpdate" method="post" enctype="multipart/form-data">
                       <input type="hidden" value="${uvo.user_nickname }" name="user_nickname">
                        <div class="pt-4 pb-4 mt-4 mb-4 border-top border-bottom">
                            <div class="d-flex flex-row gap-3 flex-wrap justify-content-center align-items-center">
								<!-- img -->
										<c:if test="${empty uvo.user_profile }">
											<img  style="height: 100px; width: 100px; border-radius: 50%; margin-top:20px; margin-bottom: 20px;"
                               			 	class="object-fit-cover bg-body-secondary border" src="${contextPath }/resources/image/common/thumbnail-profile-seed.svg" alt="프로필 이미지x">
											
        								</c:if>
										<c:if test="${!empty uvo.user_profile }">
											<img id="userProfilePreview" style="height: 100px; width: 100px; border-radius: 50%; margin-top:20px; margin-bottom: 20px;"
                               				 class="object-fit-cover bg-body-secondary border" src="${contextPath}/resources/image/myPage/${uvo.user_profile }" alt="프로필 이미지"/>
										 	
        		
        								</c:if>
								
								
								
								
								
                                <div class="d-flex flex-column flex-wrap title-overflow-1">
                                    <h6 class="title-overflow-1">
                                    	
                                    	<c:if test="${uvo.user_kakaologin == 'Y' }">
                                    		<span class="badge text-bg-warning">카카오</span>
                                    	</c:if>
                                    	<c:if test="${empty uvo.user_kakaologin  }">
                                    		<span class="badge text-bg-secondary">자체 회원</span>
                                    	</c:if>
                                        <c:if test="${uvo.user_kakaologin == 'G'  }">
                                    		<span class="badge text-bg-primary bg-gradient">구글</span>
                                    	</c:if>
                                    	
                                    	<c:if test="${user_kakaologin="N" }"> 
											<span class="badge text-bg-success bg-gradient">네이버</span>
										</c:if>
                                        
                                        
										<span>${uvo.user_nickname }님</span>
                                    </h6>
                                    <div class="input-group input-group-sm">
                                        <label class="input-group-text d-none d-sm-block " for="user_profile">프로필 사진</label>
                                        <input type="file" class="form-control" id="user_profile" name="user_profile" onchange="readURL(this);">
                                    </div>
                                    <button type="submit" class="btn btn-sm btn-outline-secondary" value="사진 수정">사진 수정</button>
                                </div>
                            </div>
                        </div>
                        </form>
                        <!-- =============================================== -->

                        <!-- 작성한 게시글 -->
                        <div class="pt-4 pb-4 mt-4 mb-4">
                            <h4 class="ms-2 mb-4  text-body-secondary"><i class="fa-solid fa-pencil me-2"></i> 작성한 게시글</h4>
                            <div>
                                <table class="table table-hover mt-2 text-center mw-100">
                                    <!-- 필요없는 열은 빼고 사용하세요. -->
                                    <thead>
                                        <tr class="table-dark">
                                            <th>게시판</th>
                                            <th>제목</th>
                                            <th class=" d-none d-md-table-cell">날짜</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="li" items="${li}">
                                        <tr>
                                            <td>1:1 거래</td>
                                            <td class="text-start">
                                                <a href="javascript:void(0)" class="text-decoration-none text-body" id="a4button">
                                                    <!-- <span class="text-muted">[{태그명}]</span> -->
                                                   ${li.tr_title}
                                                </a>
                                            </td>
                                            
                                            
                                            <td class="text-muted d-none d-md-table-cell"><fmt:formatDate value="${li.tr_time }" pattern="YYYY-MM-dd "/></td> 
                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
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





	<jsp:include page="../common/footer.jsp" />
	


<script type="text/javascript">
    
    
    function readURL(input) {
    	  if (input.files && input.files[0]) {
    	    var reader = new FileReader();
    	    reader.onload = function(e) {
    	      document.getElementById('userProfilePreview').src = e.target.result;
    	    };
    	    reader.readAsDataURL(input.files[0]);
    	  } else {
    	    document.getElementById('userProfilePreview').src = "${contextPath }/resources/image/common/thumbnail-profile-seed.svg";
    	  }
    	}
</script>

</body>
</html>
