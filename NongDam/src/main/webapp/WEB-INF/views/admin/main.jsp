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
<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<meta name="농담" content="안녕하세요, 농업 정보 커뮤니티 농담입니다." />

<!-- 파비콘 -->
<link rel="icon" type="image/x-icon"
	href="${contextPath }/resources/image/common/favicon.ico" />
<link rel="shortcut icon" type="image/x-icon"
	href="${contextPath }/resources/image/common/favicon.ico" />

<title>농담 | 농업 정보 커뮤니티</title>

	<script type="text/javascript">
	$(document).ready(function () {
	    const ctx = document.getElementById('myChart').getContext('2d');
	  
	    // Initialize the chart
	    let myChart = new Chart(ctx, {
	        type: 'doughnut',
	        data: {
	            labels: ['Red', 'Blue', 'Green'],
	            datasets: [{
	                label: '# of Votes',
	                data: [${gp.gpCount}, ${tr.trCount}, ${gpUser.gpUserCount}],
	                borderWidth: 1
	            }]
	        },
	        options: {
	            responsive: false,
	            scales: {
	                y: {
	                    max: 50
	                }
	            }
	        }
	    });

	    $('#lineButton').on('click', function() {
	        // Destroy the existing chart
	        myChart.destroy();

	        // Create a new chart as a line chart
	        const newChart = new Chart(ctx, {
	            type: 'line',
	            data: {
	                labels: ['1:1거래', 'Blue', 'Green'],
	                datasets: [{
	                    label: '# of Votes',
	                    data: [${gp.gpCount}, ${tr.trCount}, ${gpUser.gpUserCount}],
	                    borderWidth: 1
	                }]
	            },
	            options: {
	                responsive: false,
	                scales: {
	                    y: {
	                        max: 50
	                    }
	                }
	            }
	        });

	        // Update the reference to the current chart
	        myChart = newChart;
	    });

	    $('#doughnutButton').on('click', function() {
	        // Destroy the existing chart
	        myChart.destroy();

	        // Create a new chart as a doughnut chart
	        const newChart = new Chart(ctx, {
	            type: 'doughnut',
	            data: {
	                labels: ['Red', 'Blue', 'Green'],
	                datasets: [{
	                    label: '# of Votes',
	                    data: [${gp.gpCount}, ${tr.trCount}, ${gpUser.gpUserCount}],
	                    borderWidth: 1
	                }]
	            },
	            options: {
	                responsive: false,
	                scales: {
	                    y: {
	                        max: 50
	                    }
	                }
	            }
	        });
	
	        // Update the reference to the current chart
	        myChart = newChart;
	    });
	    
	    $('#barButton').on('click', function() {
	        // Destroy the existing chart
	        myChart.destroy();

	        // Create a new chart as a doughnut chart
	        const newChart = new Chart(ctx, {
	            type: 'bar',
	            data: {
	                labels: ['Red', 'Blue', 'Green'],
	                datasets: [{
	                    label: '# of Votes',
	                    data: [${gp.gpCount}, ${tr.trCount}, ${gpUser.gpUserCount}],
	                    borderWidth: 1
	                }]
	            },
	            options: {
	                responsive: false,
	                scales: {
	                    y: {
	                        max: 50
	                    }
	                }
	            }
	        });

	        // Update the reference to the current chart
	        myChart = newChart;
	    });
	});
	</script>


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
                                관리자 페이지
                            </button>
                        </h2>
                        <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">
                            <div class="accordion-body p-0">
                                <ul class="list-group list-group-flush rounded-bottom-2">
                                    <li class="list-group-item  bg-body-secondary">
                                        <a class="text-decoration-none text-body" href="${contextPath }/admin/main">관리자페이지 메인</a>
                                    </li>
                                    <li class="list-group-item">
                                        <a class="text-decoration-none text-body" href="${contextPath }/admin/userManage">회원정보 관리</a>
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
                    <div class="border rounded-2 p-4 container">
		            	<div class="row row-cols-1 row-cols-md-2 row-cols-xl-4 ">
							<div class="col-6">
								<canvas id="myChart" width="550" height="350" role="img"></canvas>
							</div>
						</div>
						<button id="barButton" class="btn btn-secondary">막대</button>
						<button id="lineButton" class="btn btn-secondary">라인</button>
						<button id="doughnutButton" class="btn btn-secondary">도넛</button>
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
