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
    	
   		<script type="text/javascript">
   		

  	  $(document).ready(function () {
  	        $(".page-link").on("click", function (e) {
  	            e.preventDefault();  // 기본 이벤트 막기
  	            
  	            var page = $(this).attr("href");  //페이지 번호
  	            $("#page").val(page);  // 페이지 폼 설정
  	            $("#pageFrm").submit();  // 폼 서브밋
  	        });
		
	});
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
      <nav id="main">
          <div class="nav nav-tabs" id="nav-tab" role="tablist">
                        <!--  class="nav-link(기본) active(선택된 값) text-body(텍스트 색 지정)"-->
                        <!-- 필요한 경우 button을 a 태그로 바꾸어도 괜찮습니다. (단, a태그로 바꾸는 경우 type=button 삭제하세요 )-->
               <a href= "../free/main?type=" class="nav-link text-body active" role="tab" aria-controls="nav-home" aria-selected="true">전체</a>
               <a href="../free/main?type=free" class="nav-link text-body" role="tab" aria-controls="nav-profile" aria-selected="true">자유</a>
               <a href="../free/main?type=question" class="nav-link text-body" role="tab" aria-controls="nav-contact" aria-selected="true">질문</a>
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
	               
	            <c:forEach var="li" items="${li}">
				    <tr>
				        <td><span class="text-muted">${li.free_idx}</span></td>
				        <td><a class="text-decoration-none tr-list-click" href="${contextPath}/free/detail?free_idx=${li.free_idx}">[${li.free_tag}] ${li.free_title }</span></td>
				        <td class="d-none d-md-table-cell">
				        <c:set var="now" value="<%=new java.util.Date() %>"></c:set>	        
						<fmt:formatDate value="${li.free_date }" pattern="yyyy년 MM월 dd일 HH시 mm분"/>	
						</td>
				        <td class="d-none d-md-table-cell">${li.user_nickname }</td>
				        <td class="d-none d-md-table-cell"></td>
				       <td class="d-none d-md-table-cell">${li.free_count}</td>
				    </tr>
				    
				</c:forEach>
	                
                    <td colspan="6">
                        <div class="d-flex flex-wrap justify-content-between">
                            <!-- 정렬용 더미 -->
                            <div class="d-none d-md-block" style="width: 70px"></div>
                            <!-- 검색 인풋 -->
                            
                            <div style="width: 20rem;">
                            	<form method="get">
                                <div class="input-group" >
                                    <select class="btn btn-outline-secondary dropdown-toggle" name="type">
                                        <option class="dropdown-item" value="free_title">제목</option>
										<option class="dropdown-item" value="user_nickname">작성자</option>
                                    </select >
                                    <input type="text" name="keyword" class="form-control" placeholder="검색" value="${cri.keyword }">
                                    <button class="btn btn-secondary" type="submit">검색</button>
                                </div>
                                </form>
                            </div>
                            
                            <!-- 글쓰기 버튼(2) -->
                            <a class="text-decoration-none" href="${contextPath}/free/write">
                            <button class="btn btn-outline-secondary" id="a3button"> 글쓰기</button>
                        </div>
                    </td>    
                </tr>
            </tbody>
            
            
        </table>
       
        <!-- 페이징 -->
        <div class="mt-3">
            <nav class="d-flex justify-content-center">
			    <ul class="pagination">
			        <c:if test="${pageCre.prev}"> 
			        <!-- 이전버튼 -->
			            <li class="paginate-item">
			                <a class="page-link text-secondary" href="${pageCre.cri.startPage-1}">&laquo;</a>
			            </li> 
			        </c:if> 
			        <!-- 현재버튼 -->
				        <c:forEach var="pageNum" begin="${pageCre.startPage}" end="${pageCre.endPage}">
					    <li class="page-item ${pageCre.cri.page == pageNum ? 'active' : ''}">
					        <a class="page-link ${pageCre.cri.page == pageNum ? 'bg-secondary border-secondary' : ''}" href="${pageNum}">${pageNum}</a>
					    </li>
						</c:forEach>
			        
			        <!-- 다음페이지 -->
			        <c:if test="${pageCre.next}"> 
			            <li class="page-item">
			                <a class="page-link text-secondary" href="${pageCre.endPage+1}">&raquo;</a>
			            </li>
			        </c:if> 
			    </ul> 
			    
					<!-- /.page -->
            </nav>
        </div>	
        
        	<form id="pageFrm" action="${contextPath}/free/main" method="get">
        		
				<input type="hidden" id="user_idx" name="user_idx" value="1"/>
				<input type="hidden" id="page" name="page" value="${pageCre.cri.page }"/>
				<input type="hidden" id="perPageNum" name="perPageNum" value="${pageCre.cri.perPageNum }"/>
			
               	<!-- 페이지 이동 시 값 가져가는 것 방지  -->
        		<c:if test="${empty pageCre.cri.keyword }">
					<input type="hidden" name="type" value="${ pageCre.cri.type}"/>
               		<input type="hidden" name="keyword" value="${pageCre.cri.keyword}"/>
				</c:if>
			</form>	

        
    </div>
    <!-- ============================================== -->
</div>

	<jsp:include page="../common/footer.jsp"/>
</div>
</body>
</html>
