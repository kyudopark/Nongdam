$(document).ready(function () {
	        var bannerTitle = "공동구매 게시판";
	        var bannerText1 = "다양한 제품들을 많은 사람들과 함께 싼 가격에 구매해보세요";
	        var bannerText2 = "공동구매 게시글들은 문의 혹은 별도의 연락을 받아 게시글을 올려드리고 있습니다.";
	        
	        $("#banner-title").text(bannerTitle);
	        $("#banner-content1").text(bannerText1);
	        $("#banner-content2").text(bannerText2);
	  
	    });

function kakaoPay() {
	if (confirm("구매 하시겠습니까?")) { // 구매 클릭시 한번 더 확인하기
		IMP.init("imp01003550"); // 가맹점 식별코드
		IMP.request_pay({
			pg: 'kakaopay', // PG사 코드표에서 선택
			pay_method: 'card', // 결제 방식
			merchant_uid: 'IMP' + new Date().getTime(), // 결제 고유 번호
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
				if (rsp.status === 'paid') { // DB저장 성공시
					alert('결제 완료!');
					pageFrm.attr("action","${contextPath }/gp/request");
					pageFrm.attr("method", "post");
					$("#submitForm").submit();
				} else { // 결제완료 후 DB저장 실패시
					 alert('error:[' + response.status + ']\n결제요청이 승인된 경우 관리자에게 문의바랍니다.');
					// DB저장 실패시 status에 따라 추가적인 작업 가능성
				}
			} else if (rsp.success === false) { // 결제 실패시
				alert(rsp.error_msg)
			}
		});
		return false;
	} else {
		return false;
	}
};

function execDaumPostcode() {
        new daum.Postcode( {
          oncomplete: function( data ) {
            document.getElementById( 'gp_zipcode' ).value = data.zonecode;
            document.getElementById( 'gp_zipcode2' ).value = data.address;
            document.getElementById( 'gp_zipcode3' ).focus();
          }
        } ).open();
      }
      function execDaumPostcodeReset() {
        document.getElementById( 'gp_zipcode' ).value = null;
        document.getElementById( 'gp_zipcode2' ).value = null;
        document.getElementById( 'gp_zipcode3' ).value = null;
      }