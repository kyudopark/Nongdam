// gp/* 불러올 때 banner Text 교체문
$(document).ready(function () {
	        var bannerTitle = "공동구매 게시판";
	        var bannerText1 = "다양한 제품들을 많은 사람들과 함께 싼 가격에 구매해보세요";
	        var bannerText2 = "공동구매 게시글들은 문의 혹은 별도의 연락을 받아 게시글을 올려드리고 있습니다.";
	        
	        $("#banner-title").text(bannerTitle);
	        $("#banner-content1").text(bannerText1);
	        $("#banner-content2").text(bannerText2);
	  
	    });
	    

// request.jsp 다음 우편번호 입력 API
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
      
      
      
      
      
      
      
      
      