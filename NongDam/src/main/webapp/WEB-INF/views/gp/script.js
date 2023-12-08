function kakaoPay() {
	if (confirm("구매 하시겠습니까?")) { // 구매 클릭시 한번 더 확인하기
		IMP.init("imp01003550"); // 가맹점 식별코드
		IMP.request_pay({
			pg: 'kakaopay', // PG사 코드표에서 선택
			pay_method: 'card', // 결제 방식
			merchant_uid: 'IMP', // 결제 고유 번호
			name: '상품명', // 제품명
			amount: 100, // 가격
			//구매자 정보 ↓
			buyer_email: 'www@www.com',
			buyer_name: 'wwwwww',
			buyer_tel: '010-1234-5678',
			buyer_addr: '서울특별시 강남구 삼성동',
			buyer_postcode: '123-456'
		}, function(rsp) { // callback
			if (rsp.success) { //결제 성공시
				console.log(rsp);
				if (response.status == 200) { // DB저장 성공시
					alert('결제 완료!')
					window.location.reload();
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