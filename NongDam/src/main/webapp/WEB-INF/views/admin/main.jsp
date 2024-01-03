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
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>

    <!-- datepicker -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <meta name="농담" content="안녕하세요, 농업 정보 커뮤니티 농담입니다." />
    
    <!-- bannerText.js -->
    <script type="text/javascript"
	src="${contextPath }/resources/common/js/admin/bannerText.js"></script>

    <!-- 파비콘 -->
    <link rel="icon" type="image/x-icon"
        href="${contextPath }/resources/image/common/favicon.ico" />
    <link rel="shortcut icon" type="image/x-icon"
        href="${contextPath }/resources/image/common/favicon.ico" />

    <title>농담 | 농업 정보 커뮤니티</title>
    
    <style>
    .ui-datepicker {
		margin-left : auto;
		margin-right: auto;
		}
    </style>

    <script type="text/javascript">
$(document).ready(function () {

    var context = document.getElementById('myChart').getContext('2d');
    var myChart;

    function createInitialChart() {
        var initialData = {
            labels: ['공동구매', '1:1거래', '자유'],
            datasets: [{
                label: '게시판 별 총 게시글 갯수',
                data: [${gp.gpCount}, ${tr.trCount}, ${free.freeCount}],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)'
                ],
                borderWidth: 1
            }]
        };

        myChart = new Chart(context, {
            type: 'bar',
            data: initialData,
            options: {
                scales: {
                    yAxes: [
                        {
                            ticks: {
                                beginAtZero: true
                            }
                        }
                    ]
                }
            }
        });
        displayInitialChartData();
    }
    
    function displayInitialChartData() {
        $("#dataSpan1").html("1:1 거래 게시판 게시글 총 갯수 - " + ${tr.trCount} + "개");
        $("#dataSpan2").html("공동구매 게시판 게시글 총 갯수  - " + ${gp.gpCount} + "개");
        $("#dataSpan3").html("자유 게시판 게시글 총 갯수  - " + ${free.freeCount} + "개");
        $("#dataSpan4").hide();
    }

    // datepicker 초기화
    $("#datepicker").datepicker({
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        closeText: '확인',
        dateFormat: 'yy-mm-dd',
        defaultDate: new Date(),
        onSelect: function(dateText, inst) {
            var formattedDate = $.datepicker.formatDate('yy-mm-dd', new Date(dateText));
            updateChartData(formattedDate);
        },
        beforeShow: function (input, inst) {
            var windowWidth = $(window).width();
            var isMobile = windowWidth <= 767;

            if (isMobile) {
                inst.dpDiv.css({
                    'position': 'absolute',
                    'top': '50%',
                    'left': '50%',
                    'transform': 'translate(-50%, -50%)',
                    'max-width': '100%'
                });
            }
        }
    });
	
 	// 버튼 클릭 시 차트 다시 그리기
    $("#refreshChartBtn").click(function () {
    	myChart.destroy();
        createInitialChart();
    });

 	// 회원가입 방식 차트 다시 그리기
    $("#getCountBySignupMethod").click(function () {
    	getCountBySignupMethod();
    });
 
    // 초기 차트 생성
    createInitialChart();

    function updateChartData(selectedDate) {
        myChart.destroy();

        $.ajax({
            url: "${contextPath}/admin/getCountsByDate",
            type: "GET",
            data: { date: selectedDate },
            success: function (data) {
                $.ajax({
                    url: "${contextPath}/admin/getCountsByDate",
                    type: "GET",
                    data: { date: selectedDate, type: 'plus_minus_days' },
                    success: function (plusMinusData) {
                        var newData = {
						    labels: ['-1일', plusMinusData.selectedDate, '+1일'],
						    datasets: [
						        {
						            label: '1:1 거래',
						            data: [plusMinusData.minus1DayCounts.trCount, plusMinusData.baseCounts.trCount, plusMinusData.plus1DayCounts.trCount],
						            backgroundColor: 'rgba(255, 99, 132, 0.2)',
						            borderColor: 'rgba(255, 99, 132, 1)',
						            borderWidth: 2,
						            type: 'line'
						        },
						        {
						            label: '공동구매',
						            data: [plusMinusData.minus1DayCounts.gpCount, plusMinusData.baseCounts.gpCount, plusMinusData.plus1DayCounts.gpCount],
						            backgroundColor: 'rgba(54, 162, 235, 0.2)',
						            borderColor: 'rgba(54, 162, 235, 1)',
						            borderWidth: 2,
						            type: 'line'
						        },
						        {
						            label: '자유',
						            data: [plusMinusData.minus1DayCounts.freeCount, plusMinusData.baseCounts.freeCount, plusMinusData.plus1DayCounts.freeCount],
						            backgroundColor: 'rgba(255, 206, 86, 0.2)',
						            borderColor: 'rgba(255, 206, 86, 1)',
						            borderWidth: 2,
						            type: 'line'
						        }
						    ]
						};

                        myChart = new Chart(context, {
                            type: 'line',
                            data: newData,
                            options: {
                                scales: {
                                    yAxes: [
                                        {
                                            ticks: {
                                                beginAtZero: true
                                            }
                                        }
                                    ]
                                },
                            }
                        });
                        displayChartData(plusMinusData);
                    },
                    error: function (error) {
                        console.log("Error fetching plus/minus data:", error);
                    }
                });
            },
            error: function (error) {
                console.log("Error fetching data:", error);
            }
        });
    }
    
    function displayChartData(plusMinusData) {
        $("#dataSpan1").html("1:1 거래 게시판 날짜별 게시글 갯수 - " + plusMinusData.minus1DayCounts.trCount + "개, " + plusMinusData.baseCounts.trCount + "개, " + plusMinusData.plus1DayCounts.trCount + "개");
        $("#dataSpan2").html("공동구매 게시판 날짜별 게시글 갯수  - " + plusMinusData.minus1DayCounts.gpCount + "개, " + plusMinusData.baseCounts.gpCount + "개, " + plusMinusData.plus1DayCounts.gpCount + "개");
        $("#dataSpan3").html("자유 게시판 날짜별 게시글 갯수  - " + plusMinusData.minus1DayCounts.freeCount + "개, " + plusMinusData.baseCounts.freeCount + "개, " + plusMinusData.plus1DayCounts.freeCount + "개");
        $("#dataSpan4").hide();
    }
 
    function getCountBySignupMethod() {
        // 서버에 count 데이터 요청
        $.ajax({
            url: "${contextPath}/admin/getCountBySignupMethod",
            type: "GET",
            success: function (data) {
                myChart.destroy();

                // 'doughnut' 차트 데이터 생성
                var newData = {
                    labels: ['구글 로그인', '카카오 로그인', '자체 로그인', '네이버 로그인'],
                    datasets: [{
                        data: Object.values(data),
                        backgroundColor: ['rgba(255, 0, 0, 0.3)', 'rgba(255, 255, 0, 0.3)', 'rgba(0, 0, 255, 0.3)', 'rgba(0, 128, 0, 0.3)'],
                        borderColor: ['rgba(255, 0, 0, 1)', 'rgba(255, 255, 0, 1)', 'rgba(0, 0, 255, 1)', 'rgba(0, 128, 0, 1)'],
                        borderWidth: 1
                    }]
                };
                
                // 새로운 'doughnut' 차트 생성
                myChart = new Chart(context, {
                    type: 'doughnut',
                    data: newData
                });
                displaySignupMethodData(data);
            },
            error: function (error) {
                console.log("Error fetching signup method data:", error);
            }
        });
    }
    
    function displaySignupMethodData(data) {
        $("#dataSpan1").html("자체 회원가입: " + data.nullCount + "개");
        $("#dataSpan2").html("카카오 로그인: " + data.kakaoCount + "개");
        $("#dataSpan3").html("구글 로그인: " + data.googleCount + "개");
        $("#dataSpan4").html("네이버 로그인: " + data.naverCount + "개").show();;
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
                                            <a class="text-decoration-none text-body" href="${contextPath }/admin/main">홈페이지 통계</a>
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
                <div class="col-12 col-md-9">
                	<h4 class="ms-2 mb-4 text-body-secondary">
								<i class="fa-solid fa-chart-pie"></i> 게시글 전체 통계 / 일별 작성 게시글 통계 / 소셜 / 비소셜 로그인 비율 
							</h4>
		            <div class="container">
		                <div class="border rounded-2 p-4 container">
		                    <!-- 차트와 짧은 텍스트 -->
		                    <div class="row">
		                        <!-- 차트 -->
		                        <div class="col-md-8">
								    <canvas id="myChart" class="w-100" role="img"></canvas>
								</div>
								<div class="border-start col-md-4">
								    <div class="row mt-4 justify-content-center">
								        <div class="col-12 text-center">
								            <form method="get">
								                <label for="datepicker" class="form-label">날짜 선택</label>
								            </form>
								            <div id="datepicker"></div>
								        </div>
								        <div class="col-12 mt-2 text-center">
								            <button id="refreshChartBtn" class="btn btn-primary">게시글 전체통계</button>
								            <button id="getCountBySignupMethod" class="btn btn-primary" onclick="getCountBySignupMethod()">회원가입 방식</button>
								        </div>
								    </div>
								</div>
								<div class="col-md-12 mt-4">
									<div class="mb-3">
									    <label for="chartDataInput" class="form-label">통계 데이터 값 :</label>
									    <p id="dataSpan1" class="form-control" readonly></p>
									    <p id="dataSpan2" class="form-control" readonly></p>
									    <p id="dataSpan3" class="form-control" readonly></p>
									    <p id="dataSpan4" class="form-control" readonly></p>
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
