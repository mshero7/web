<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<meta charset="UTF-8">
<meta http-equiv="refresh"
	content="3;url=${path}/index.jsp">
<title>로그인 페이지</title>
<link href="${path}/asset/css/creative.css" rel="stylesheet">
<link href="${path}/asset/css/sign.css" rel="stylesheet">

<!-- source codepen.io -->
<link
	href="https://cdn.jsdelivr.net/foundation/6.2.0/foundation.min.css"
	rel="stylesheet">
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
	rel="stylesheet">
</head>
<body>
	<jsp:include page="../nav.jsp"></jsp:include>
	<div id="my_container container" class="userResult">
		<div
			class="wrapper large-5 columns large-centered small-7 small-centered">
			<div class="row header">
				<div class="large-12 columns">요청된 작업을 수행중입니다...</div>
			</div>
			<div class="row">
				<div class="large-12 columns">
					<br><br>
					<span>${userResult}</span> <br><br><br>
				</div>
			</div>
		</div>
	</div>

	<!-- sourceURL=pen.js -->
	<script
		src='https://cdnjs.cloudflare.com/ajax/libs/gsap/1.19.0/TweenMax.min.js'></script>
	<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
	<script
		src='//static.codepen.io/assets/common/stopExecutionOnTimeout-41c52890748cd7143004e05d3c5f786c66b19939c4500ce446314d1748483e13.js'></script>
	<!-- Custom scripts for this template -->
</body>
</html>