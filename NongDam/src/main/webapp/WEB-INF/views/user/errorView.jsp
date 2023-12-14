<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>Error Page</h1>

    <%-- 요청 스코프에서 예외 속성이 있는지 확인합니다. --%>
    <c:if test="${not empty requestScope['javax.servlet.error.exception']}">
        <%-- 특정 에러 정보가 있는 경우 표시합니다. --%>
        <p>에러가 발생했습니다: ${requestScope['javax.servlet.error.message']}</p>
        <p>에러 유형: ${requestScope['javax.servlet.error.exception'].getClass().getSimpleName()}</p>
        <pre>
            스택 트레이스:
            ${requestScope['javax.servlet.error.exception'].printStackTrace(out)}
        </pre>
    </c:if>

    <%-- 특정 에러 정보가 없는 경우 일반적인 메시지를 표시합니다. --%>
    <c:if test="${empty requestScope['javax.servlet.error.exception']}">
        <p>죄송합니다, 에러가 발생했습니다. 나중에 다시 시도해주세요.</p>
    </c:if>

</body>
</html>