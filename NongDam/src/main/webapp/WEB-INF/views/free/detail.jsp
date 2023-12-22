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
    
    $(document).ready(function() {
        $('#delete').click(function() {
            $.ajax({
                type: 'GET',
                url: 'deleteByIdx',
                data: { free_idx: '${vo.free_idx}' }, 
                success: function(response) {
                    alert('삭제하겠습니까?');
                    location.href = '/ezen/free/main';
                },
                error: function(error) {
                    console.error('에러:', error);
                }
            });
        });
    })
    
    </script>
    
    <script type="text/javascript">
    
    $(document).ready(function(){
        findAllComment(); // 페이지가 준비되면 findAllComment 함수 실행
    });

    // 댓글 조회하는 함수
   
	function findAllComment(){
		//변수를 선언해준다 
    	let free_idx = $('#free_idx').val();
        $.ajax({
            type: 'GET',
            url: 'findAllComment',
            dataType: 'JSON',
            data: { "free_idx":free_idx }, // 댓글 조회할 때 필요한 데이터 전달
            success:AllComment,
			error:function(){
				alert("error"); 
				}
        })
    }
    
		function AllComment(data) {
			var DATE = new Date();
			let commentList = "";
                $.each(data, function(index, obj) {
                    comment += '<div class="p-3 mt-3 mb-3 d-flex flex-nowrap gap-1">';
                    // 답글의 유무로 style설정
                    if (obj.free_parent_idx !== obj.free_comment_idx) {
                        comment += '<div class="ms-2 me-3">';
                    } else {
                        comment += '<div style="margin-top:2px; width: 22px; height: 22px; border-radius: 50%; display: flex; justify-content: center; align-items: center;">';
                    }

                    // 프로필 사진 처리
                    if (obj.user_profile !== null && obj.user_profile !== '') {
                        // 이미지가 있는 경우
                        comment += '<div style="width: 22px; height: 22px; border-radius: 50%;">';
                        comment += '<img class="object-fit-cover" style="width: 22px; height: 22px; border-radius: 50%;" src="' + obj.user_profile + '">';
                        comment += '</div>';
                    } else {
                        // 이미지가 없는 경우
                        comment += '<i class="fa-regular fa-user"></i>';
                    }

                    // 댓글 필수 정보
	                    comment += '<div class="w-100 ' + obj.free_comment_idx + '">';
	                    comment += '<div>';
	                    comment += '<h6 class="d-inline-block">' + obj.user_nickname + '</h6>';
	                    comment += '<small class="text-secondary">' + obj.free_comment_time + '</small>';
	                    comment += '</div>';

                    if (obj.free_comment_useable == 1) {
                        // 조회
                        comment += '<div class="pb-2"></div>';
                        comment += '<div class="text-break pb-1">' + obj.free_comment_content + '</div>';
                    }
                });
                error: function() {
                    console.error('에러');
                }
            }
            
        });
    }

    // 댓글 입력 함수
    function insertComment() {
    	var fData = $("#insert").serialize();
        let free_comment_content = $('#free_comment_content').val();
        if (free_comment_content.length == 0) {
            alert("댓글을 입력해주세요");
            return;
        }
        window.insertComment = insertComment;
        let free_comment_idx = $('#free_comment_idx').val();
        $.ajax({
            url: "insertComment",
            type: "post",
            data: { free_comment_idx: "free_comment_idx" }, // 댓글 입력할 때 필요한 데이터 전달
            success: function(comm) {
                alert('입력되었습니다.');
                $('#insert')[0].reset(); //입력 후 form 리셋
                findAllComment(); // 댓글 입력 후 다시 조회
            },
            error: function() {
                alert('에러');
            }
        });
    }
    
   
</script>
       
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	<jsp:include page="../common/banner.jsp"/>
	
	
	<!-- 글 조회 div container-->
    <div class="container mt-5 mb-5">
        <div class="pt-3 pb-3">
             <a class="text-muted " href="${contextPath}/free/main"">목록으로</a>
        </div>
        <!-- 글 제목 -->
        <div class="border-bottom">
            <h4 class="fw-4"> ${vo.free_title}</h4>
            <p class="d-flex flex-wrap align-items-center gap-2">
                <span class="d-block me-auto fst-italic text-muted"><fmt:formatDate value="${vo.free_date}" pattern="yyyy-MM-dd"/></span>

                <span class="d-inline-block"></span>
                <button class="btn bxtn-sm btn-outline-secondary">
                    <i class="fa-regular fa-comment"></i>
                    1:1 채팅
                </button>
            </p>
        </div>
            <!-- 글 본문(ckEditor) -->
            <div class="pt-3 pb-3 ck-content">
                <!-- 이 안에서 출력-->
                ${vo.free_content}
            </div>

            
	            <!-- 기타 버튼 -->
	            <div class="border-bottom text-end pb-3">
	                <a class="btn btn-secondary" href="${contextPath}/free/modify?free_idx=${vo.free_idx}"> 수정하기 </a>
            		<button class="btn btn-secondary" id="delete" type="button" >삭제</button>
	                <a class="btn btn-secondary" href="${contextPath}/free/main"> 리스트 </a>
	                
	            </div>

        <!-- 댓글 -->
        
        <div class="mt-3 text-end">
        		<form id="insert">
        	<!-- 서버로 데이터를 넘길 때 사용 -->
        	<input type="hidden" name="user_idx" value="1">
	        <input type="hidden" id="free_idx" name="free_idx" value="${vo.free_idx }">
	        <div class="mt-3 text-end">
            <div class="text-start p-2">댓글 작성</div>
            <div class="form-floating">
                <textarea class="form-control" id="comments" name="comments" style="height: 100px"></textarea>
                <label for="comments" >댓글 내용 </label>
            </div>
            <div>
                <span id="Fullcomment" class="text-danger d-inline-block d-none">최대 글자수를 초과하였습니다.</span>
	            <button type="button"  onclick="insertComment()" class="btn btn-sm btn-secondary d-inline-block">등록</button>
            </div>
            	</form>
            <!-- 댓글 최대 글자수 설정 -->
             <script>
	        $(document).ready(function(){
	        	$('#comments').on('input',function(){
	        		let textLength = $(this).val().length;
	        		if (textLength >= 254) {
	        			$(this).val($(this).val().substr(0, 255));
	        			$('#Fullcomment').removeClass('d-none');
	        		}else{
	        			$('#Fullcomment').addClass('d-none');
	        		}
	        	
	        	})
	        })
        </script>
    
            
        </div>
              <!-- 등록된 댓글들 -->
        <h6 class="border-top mt-3 p-3 pb-0">댓글 <span class="text-muted">(최신순)</span></h6>
        <div id="commentView">
            
			<div class="p-3 mt-3 mb-3 text-muted">
				
			</div>
            
        </div>
       
            <!--댓글이 있는 페이지에 있어야 하는 스크립트 영역 -->
            <script>
            
                $(document).ready(function(){
                    $('textarea.form-control').css('resize','none');
                    $('textarea.form-control').css('overflow','hidden');
                    $('textarea').each(function(){
                        this.style.height = 'auto';
                        this.style.height = (this.scrollHeight+10) + 'px';
                    }).on('input', function(){
                        this.style.height = 'auto';
                        this.style.height = (this.scrollHeight+10) + 'px';
                    })
                });
            </script>
        </div>

    </div>
	
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>
