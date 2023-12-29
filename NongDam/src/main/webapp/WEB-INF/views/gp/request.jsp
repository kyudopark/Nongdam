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
    
    <!-- gp/* js파일 -->
    <script type="text/javascript" src="${contextPath }/resources/gp/js/script.js"></script>
    
    <meta name="농담" content="안녕하세요, 농업 정보 커뮤니티 농담입니다."/>
    
    <!-- 파비콘 -->
    <link rel="icon" type="image/x-icon" href="${contextPath }/resources/image/common/favicon.ico"/>
    <link rel="shortcut icon" type="image/x-icon" href="${contextPath }/resources/image/common/favicon.ico"/>
    
    <!-- 카카오페이 결제 -->
	<!-- iamport.payment.js -->
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

	<!-- 다음(카카오) 우편번호 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	
    <title>농담 | 농업 정보 커뮤니티</title>
	
	<script type="text/javascript">
	$(document).ready(function () {
		$(".page-link").on("click", function (e) {
            e.preventDefault();  // 기본 이벤트 막기
		});
        
		// 개수 * 가격 = 총 가격 구하는 function
	 	$("#gp_num").on('input', function() {
			var num = $("#gp_num").val();
			var price = ${vo.gp_price};
					
			if (num !== null && $.isNumeric(num)) {
				var totalPrice = price * num;
				$("#gp_total_output").val(totalPrice); 
			} else {
		        $("#gp_total_output").val(0);
		    }
		});
	 	
		// 기존 주소지 사용 function
	 	$('input[name="radio"]').change(function () {
	        if ($('#inlineRadio1').is(':checked')) {
	            $('#gp_zipcode').val($("#user_zipcode").val());
	            var userAddr = $("#user_addr").val();
	            var addrParts = userAddr.split(',');

	            if (addrParts.length === 2) {
	                $('#addr1').val(addrParts[0]);
	                $('#addr2').val(addrParts[1]);
	                
			        var addr2 = $("#addr1").val();
			        var addr3 = $("#addr2").val();
			        
			        var fullAddress = addr2 + ',' + addr3;
			        
			        $("#gp_addr").val(fullAddress);
	            } else {
	                console.error("Invalid address format");
	            }
	        } else {
	            $('#gp_zipcode').val("");
	            $('#addr1').val("");
	            $('#addr2').val("");
	        }
	    });
	 	
		// 신규 배송지 입력 function
		$("#addr1, #addr2").on('input', function() {
			var addr = $("#addr1").val();
			var addr2 = $("#addr2").val();
		        
		    var fullAddress = addr + ',' + addr2;   
		    $("#gp_addr").val(fullAddress);
		});
	});
	
	// 카카오페이 결제 API function
	function kakaoPay() {
		if (confirm("구매 하시겠습니까?")) { // 구매 클릭시 한번 더 확인하기
			IMP.init("imp01003550"); // 가맹점 식별코드
			const randomNum = Math.random() * 1000
			const randomNumFloor = Math.floor(randomNum)
			IMP.request_pay({
				pg: 'kakaopay', // PG사 코드표에서 선택
				pay_method: 'card', // 결제 방식
				merchant_uid: randomNumFloor, // 결제 고유 번호
				name: $('#gp_title').text(), // 제품명
				amount: $('#gp_total_output').val(), // 가격
				//구매자 정보 ↓
				buyer_email: $('#gp_email').val(),
				buyer_name: $('#gp_name').val(),
				buyer_addr: $('#gp_addr').val(),
				buyer_postcode: $('#gp_zipcode').val()
			}, function(rsp) { // callback
				if (rsp.success) { //결제 성공시
					console.log(rsp);
					$("#gp_uid").val(rsp.merchant_uid);
					$('#submitForm').submit();
					if (response.status == 200) { // DB저장 성공시
						alert('결제 완료!')
						
					} else { // 결제완료 후 DB저장 실패시
						alert('error:[${response.status}]\n결제요청이 승인된 경우 관리자에게 문의바랍니다.');
						// DB저장 실패시 status에 따라 추가적인 작업 가능성
					}
				} else if (rsp.success == false) { // 결제 실패시
					alert(rsp.error_msg)
				}
			});
		} else {
			return false;
		}
	};
	
	
	</script>
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	<jsp:include page="../common/banner.jsp"/>
	
	
	<!-- 여기에 컨텐츠를 추가 -->
	<!-- 메인페이지 7/5 row -->
    <div class="container mt-5 mb-4">
        <div class="border rounded-2 container">
            <div class="row">
                <!--썸네일-->
                <div class="col-lg-7 col-12 p-0 bg-light" style="height: 280px;">
                    <img src="${contextPath }/resources/image/gp/${vo.gp_thumb }" class="object-fit-cover w-100" style="height: 300px;">
                </div>
                <!--오른쪽-->
                <div class="border-start col-lg-5 col-12 p-3">
                    <!-- 세줄까지 출력하고 싶다면 클래스명을 ...-3 으로 바꾸세요.-->
                    <h4 class="title-overflow-2" id = "gp_title">${vo.gp_title}</h4>
                    <p class="pt-0">
                        <div>
                            <span class="fw-bolder">신청 시작일 </span>
                            <span><fmt:formatDate value="${vo.gp_date_start }" pattern="YYYY-MM-dd "/></span>
                        </div>
                        <div>
                            <span class="fw-bolder">신청 마감일 </span>
                            <span><fmt:formatDate value="${vo.gp_date_last }" pattern="YYYY-MM-dd "/></span>
                        </div>
                    </p>
                    <p class="pt-3 fs-5">
                        <span class="fw-bolder">가격 </span>
                        <span>${vo.gp_price} 원</span>
                    </p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 신청 폼 블럭 -->
    <div class="container mt-4 mb-5">
        <div class="border rounded-2 ">
            <h4 class="p-4 border-bottom">신청 폼</h4>
            
            <div class="container pt-5 pb-5 col-lg-10 ">
            	<form method="post" action="${contextPath}/gp/request" id ="submitForm">  
	            	<input type="hidden" id="gp_idx" name="gp_idx" value="${vo.gp_idx}"/>
					<input type="hidden" id="user_idx" name="user_idx" value="${uvo.user_idx}"/>
					<input type="hidden" id="gp_addr" name="gp_addr" value=""/>
					<input type="hidden" id="gp_uid" name="gp_uid" value=""/>
                <!-- 수령자명 -->
                <div class="mb-4 col-12 col-md-6 col-lg-5">
                    <label for="gp_name" class="form-label">
                        수령자명
                    </label>
                    <input type="text" class="form-control" 
                        id="gp_name" name="gp_name" placeholder="이름" value = "${uvo.user_name }">
                </div>
                <!-- 수령자 연락처 -->
                <div class="mb-4 col-12 col-md-6 col-lg-5">
                    <label for="gp_email" class="form-label">
                        수령자 연락처
                    </label>
                    <input type="eamil" class="form-control" 
                        id="gp_email" name = "gp_email" placeholder="이메일" value = "${uvo.user_email }">
                </div>
                <!-- 수량 -->
                <div class="mb-4 col-4 col-md-3 col-lg-2">
                    <label for="gp_num" class="form-label">
                        수량
                    </label>
                    <div class="d-flex align-items-center gap-2">
                        <input type="text" class="form-control" 
                            id="gp_num" name = "gp_num" placeholder="0~9">
                        <div></div>
                    </div>
                </div>
                <!-- 총 가격 -->
                <div class="mb-4 col-5 col-md-4 col-lg-3">
                    <label for="gp_total" class="form-label">
                        총 가격
                    </label>
                    <div class="d-flex align-items-center gap-2">
                        <input type="text" readonly class="form-control" 
                            id="gp_total_output" name="gp_total" placeholder="-">
                        <div>원</div>
                    </div>
                </div>
                <!-- 배송지 -->
                <div class="mb-4">
                    <!-- 배송지 상단 라벨과 버튼 -->
                    <div class="d-flex flex-row flex-wrap justify-content-between">
                    	<input type="hidden" id="user_zipcode" value="${uvo.user_zipcode}" />
						<input type="hidden" id="user_addr" value="${uvo.user_addr}" />
                        <label class="form-label">배송지 입력</label>
                        <div class="d-inline-block">
                            <!-- 기존 배송지 사용 radio -->
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" 
                                    name="radio" id="inlineRadio1" value="option1">
                                <label class="form-check-label" for="inlineRadio1">
                                    기존 배송지 사용
                                </label>
                            </div>
                            <!-- 신규 배송지 입력 radio(checked)-->
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" checked
                                    name="radio" id="inlineRadio2" value="option2">
                                <label class="form-check-label" for="inlineRadio2">
                                    신규 배송지 입력(Default)
                                </label>
                            </div>
                        </div>
                    </div>
                    <!-- 배송지 입력 인풋태그들 -->
                    <div class="p-3 bg-body-tertiary border">
                        <div class="form-group mb-2">
                            <div class="row g-2">
                                <div class="col-auto">
                                    <!-- 우편번호. readonly로 되어있으나 풀어도 됩니다 -->
                                    <input type="text" class="form-control" id="gp_zipcode" name="gp_zipcode" readonly>
                                </div>
                                <div class="col-auto">
                                    <!-- 우편번호 찾기 버튼-->
                                    <button type="button" class="btn btn-secondary" onclick="execDaumPostcode()">우편번호 찾기</button>
                                    <!-- 입력된 우편번호 초기화 버튼 -->
                                    <button type="button" class="btn btn-secondary" onclick="execDaumPostcodeReset()">초기화</button>
                                </div>
                            </div>
                        </div>
                        <input type="text" class="form-control mb-2" id="addr1" placeholder="주소" readonly>
                        <input type="text" class="form-control" id="addr2" placeholder="상세 주소">
                    </div>
                </div>
            </div>
            </form>
            <!-- 신청하기 버튼 -->
            <div class="container pt-5 pb-4 text-center">
                <button class="btn btn-secondary" onclick="kakaoPay()"><i class="fa-solid fa-credit-card"></i> 결제</button>
                <a href="javascript:history.go(-1)" class="btn btn-outline-secondary">취소</a>
            </div>
            
        </div>
    </div>
    <!-- 신청 폼 블럭 끝 -->
	

	<jsp:include page="../common/footer.jsp"/>
</body>
</html>