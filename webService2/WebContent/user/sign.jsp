<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<link href="${path}/asset/css/creative.css" rel="stylesheet">
<link href="${path}/asset/css/sign.css" rel="stylesheet">

<!-- Bootstrap core CSS -->
<link href="${path}/asset/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom fonts for this template -->
<link href="${path}/asset/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">

<!-- source codepen.io -->
<link
	href="https://cdn.jsdelivr.net/foundation/6.2.0/foundation.min.css"
	rel="stylesheet">
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
	rel="stylesheet">

<!-- Plugin CSS -->
<link href="${path}/asset/vendor/magnific-popup/magnific-popup.css"
	rel="stylesheet">
</head>
<body>
	<jsp:include page="../nav.jsp"></jsp:include>
	<div id="my_container container">
<!-- 			<form method="post" autocomplete="off" action="sign.go" id="signForm"> -->
			<form method="post" autocomplete="off" id="signForm">
				<div class="row signRow info">
					<div
						class="wrapper large-5 columns large-centered small-7 small-centered">
						<div class="row header">
							<div class="large-12 columns">SIGN IN</div>
						</div>

						<div class="row username">
							<div class="large-9 columns large-centered">
								<label for="id"><i class="fa fa-user"></i></label> <input
									id="id" type="text" name="id"
									placeholder="id" required autocomplete="off" />
							</div>
						</div>

						<div class="row password">
							<div class="large-9 columns large-centered">
								<label for="password"><i class="fa fa-lock"></i></label> <input
									id="password" type="password" name="password"
									placeholder="password" required autocomplete="off" />
							</div>
						</div>

						<div class="row submit" id="btnOn">
							<div class="large-9 columns large-centered">
								<input type="submit" value="SUBMIT">
							</div>
						</div>
					</div>
				</div>
			</form>
			<span class='morphButton'> <i class="fa fa-refresh fa-spin loading"></i>
				<i class="fa fa-check success"></i> <i class="fa fa-times failure"></i>
			</span> <span class="morphHeader"><span>SIGN IN</span></span>
			
	</div>
<br><br><br><br><br>
<script src="${path}/asset/vendor/jquery/jquery.min.js"></script>
	<script src="${path}/asset/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Plugin JavaScript -->
	<script src="${path}/asset/vendor/jquery-easing/jquery.easing.min.js"></script>
	<script src="${path}/asset/vendor/scrollreveal/scrollreveal.min.js"></script>
	<script
		src="${path}/asset/vendor/magnific-popup/jquery.magnific-popup.min.js"></script>

	<!-- Custom scripts for this template -->
	<script src="${path}/asset/js/creative.js"></script>
	
	<!-- sourceURL=pen.js -->
	<script
		src='https://cdnjs.cloudflare.com/ajax/libs/gsap/1.19.0/TweenMax.min.js'></script>
	<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
	<script
		src='//static.codepen.io/assets/common/stopExecutionOnTimeout-41c52890748cd7143004e05d3c5f786c66b19939c4500ce446314d1748483e13.js'></script>
	<!-- Custom scripts for this template -->
	<script src="${path}/asset/js/loginPop.js"></script>
	<script src="${path}/asset/js/login.js"></script>
</body>
</html>