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
	
	
			<div style="width: 20rem;">
				<form method="get" >
					<div class="input-group">
	
						<select class="btn btn-outline-secondary dropdown-toggle"
							name="type">
							<option class="dropdown-item"  value="user_id">아이디</option>
							<option class="dropdown-item"  value="user_nickname">이름</option>
							<option class="dropdown-item"  value="user_name">닉네임</option>	
						</select> <input type="text" name="keyword" class="form-control"
							value="${cri.keyword }" placeholder="검색">
						<button class="btn btn-secondary" type="submit">검색</button>
	
					</div>
				</form>
			</div>
			
			 <table class="table table-hover mt-2 text-center mw-100">
    <!-- 필요없는 열은 빼고 사용하세요. -->
    <thead>
        <tr class="table-dark">
            <th class="d-none d-md-table-cell">이름</th>
            <th class="d-none d-md-table-cell">아이디</th>
            <th class="d-none d-md-table-cell">닉네임</th>
            <th class="d-none d-md-table-cell">관리자 변경</th>
            <th class="d-none d-md-table-cell">탈퇴하기</th>
        </tr>
    </thead>
    <c:forEach var="li" items="${li}">
        <tbody>										
            <th>${li.user_name}</th>
            <th>${li.user_id}</th>
            <th>${li.user_nickname}</th>
<td><button class="btn btn-primary updateadminbutton${li.user_idx }" onclick="updateAdminStatus (${li.user_idx},${li.user_admin})">${li.user_admin ? '해제' : '설정'}</button></td>
            <td>
                <button onclick="deleteByIdx(${li.user_idx})" class="btn btn-danger">탈퇴</button>
            </td>
        </tbody>
    </c:forEach>
</table>

<script>
  function updateAdminStatus(userIdx, userAdmin) {
    $.ajax({
      url: '${contextPath}/admin/updateAdminStatus',
      type: 'POST',
      data: {
        "user_idx": userIdx,
        "user_admin": !userAdmin
      },
      success: function(response) {
       console.log('업데이트 성공');
       let text= $(".updateadminbutton"+ userIdx).html();
       if(text =="설정"){
    	   $(".updateadminbutton"+ userIdx).html("해제")
    	   
       }
       else if(text =="해제"){
    	   $(".updateadminbutton"+ userIdx).html("설정")
       
       }
      },
      error: function(xhr, status, error) {
        console.error('업데이트 실패', error);
      }
    });
  }
</script>

		<script type="text/javascript">
		function deleteByIdx(user_idx){
			let result = confirm('정말 삭제하시겠습니까? 유저 정보가 삭제됩니다.');
				
			if(result == false){
				return;
			}else{
				$.ajax({
					url:"deleteByIdx",
					type:"post",
					data:{"user_idx":user_idx},
					success:function(data){
						alert("성공적으로 삭제되었습니다.");
						location.href="${contextPath}/admin/userManage";
					},
					error:function(){
						alert("error");
					}
				})
				
			}
		}
		
		</script>
	
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>
