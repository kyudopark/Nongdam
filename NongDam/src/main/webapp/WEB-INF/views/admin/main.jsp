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
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- datepicker -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<meta name="농담" content="안녕하세요, 농업 정보 커뮤니티 농담입니다." />

<!-- 파비콘 -->
<link rel="icon" type="image/x-icon"
	href="${contextPath }/resources/image/common/favicon.ico" />
<link rel="shortcut icon" type="image/x-icon"
	href="${contextPath }/resources/image/common/favicon.ico" />

<title>농담 | 농업 정보 커뮤니티</title>

<script type="text/javascript">
    $(document).ready(function () {
        // 전역으로 데이터를 정의
        var gpData = ${gp.gpCount};
        var trData = ${tr.trCount};

        // Chart를 그릴 캔버스 요소를 가져옴
        const ctx = document.getElementById('myChart').getContext('2d');

        // datepicker 초기화
        $("#datepicker").datepicker({
		    changeMonth: true,
		    changeYear: true,
		    showButtonPanel: true,
		    closeText: '확인',
		    dateFormat: 'yy-mm-dd',
		    defaultDate: new Date('2023-07-19'),
		    onSelect: function(dateText, inst) {
		        // 선택한 날짜를 컨트롤러로 전달하고 +3일, -3일의 범위에 있는 데이터를 가져와 차트 갱신
		        var formattedDate = $.datepicker.formatDate('yy-mm-dd', new Date(dateText));
		        updateChartData(formattedDate);
		    }
		});

        // 초기 차트 생성
        let myChart = createChart();

        // 추가된 함수: 선택한 날짜를 컨트롤러로 전달하고 +3일, -3일의 범위에 있는 데이터를 가져와 차트 갱신
        function updateChartData(selectedDate) {
            $.ajax({
                type: "GET",
                url: "${contextPath}/admin/main",
                data: { selectedDate: selectedDate },
                success: function (response) {
                    // 성공 시 처리 (response에서 데이터를 활용하여 표시)
                    console.log(response);

                    // 각 엔터티에 대한 데이터를 추출
                    gpData = response.gp.gpCount;
                    trData = response.tr.trCount;
                    var labels = response.labels;

                    // 가져온 데이터를 기반으로 차트 갱신
                    updateChart(myChart, 'line', labels, [gpData, trData]);
                },
                error: function (error) {
                    // 에러 처리
                    console.error(error);
                }
            });
        }

        // 추가된 함수: 차트를 업데이트하는 함수
        function updateChart(chart, type, labels, data) {
            chart.data.labels = labels;
            chart.data.datasets[0].data = data;
            chart.config.type = type;
            chart.update();
        }

        // 추가된 함수: 차트를 생성하는 함수
        function createChart() {
            const ctx = document.getElementById('myChart').getContext('2d');
            return new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['공동구매', '1:1거래'],
                    datasets: [{
                        data: [gpData, trData],
                        borderColor: 'rgba(255, 99, 132, 1)',
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
        }
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
            <!-- 오른쪽 내용 -->
			     <!-- 오른쪽 내용 -->
			<div class="col-12 col-md-9">
			    <div class="container">
			        <div class="border rounded-2 p-4 container">
			            <!-- 차트와 짧은 텍스트 -->
			            <div class="row">
			                <!-- 차트 -->
			                <div class="col-md-7">
			                    <canvas id="myChart" width="500" height="350" role="img"></canvas>
			                </div>
			                <!-- 짧은 텍스트 -->
			                <div class="border-start col-md-4">
			                    <div class="row mt-4">
			                        <div class="col-12">
			                        	<form method="get">
			                            	날짜 선택 <input type="hidden" id="dateSelect">
			                            </form>
			                            <div id="datepicker"></div>
			                        </div>
			                    </div>
			                </div>
			                <!-- 긴 텍스트 입력 폼 -->
			                <div class="col-md-12 mt-4">
							    <div class="mb-3">
							        <label for="Count1" class="form-label">1:1 거래 게시판 게시글 수 : <span id="trCount">${tr.trCount}</span></label><br>
							        <label for="Count2" class="form-label">공동구매 게시판 게시글 수 : <span id="gpCount">${gp.gpCount}</span></label><br>
							    </div>
							</div>
			            </div>
			        </div>
			    </div>
			</div>
		</div>
	</div>
    <!-- 마이페이지 끝 -->




	
	<jsp:include page="../common/footer.jsp" />

</body>
</html>