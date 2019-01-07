<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>시작 페이지</title>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!-- Bootstrap core CSS -->
<link href="${path}/asset/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom fonts for this template -->
<link href="${path}/asset/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link href="${path}/asset/css/creative.css" rel="stylesheet">
<link href="${path}/asset/css/mapstyle.css" rel="stylesheet">

<!-- Plugin CSS -->
<link href="${path}/asset/vendor/magnific-popup/magnific-popup.css"
	rel="stylesheet">
<link href="${path}/asset/css/sign.css" rel="stylesheet">
<!-- source codepen.io -->
<link
	href="https://cdn.jsdelivr.net/foundation/6.2.0/foundation.min.css"
	rel="stylesheet">
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
	rel="stylesheet">
<!-- Custom Overlay CSS -->	
<link href="${path}/asset/css/customOverlay.css" rel="stylesheet">

</head>
<body id="page-top">
	<jsp:include page="nav.jsp"></jsp:include>
	<header class="masthead text-center text-white d-flex">
		<div class="container my-auto" style="color: black;">
			<div class="row">
				<div class="col-lg-8 mx-auto">
					<a class="btn btn-primary btn-xl js-scroll-trigger btn-loc"
						href="#about">서비스 소개</a>
				</div>
			</div>
		</div>
	</header>

	<section class="bg-primary" id="about">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 mx-auto text-center">
					<h2 class="section-heading text-white titletext">오작교 서비스는..</h2>
					<hr class="light my-4">
					<div class="text-faded mb-4 introtext">
						<br> '오'늘의 '작'은 '교'감을 이루어주는 까마귀와 까치의 역할을 합니다.<br> <br>
						칠석날 견우와 직녀의 두 별을 만나게 하기 위하여<br> 까마귀와 까치가 만드는 다리를 의미하는 오작교에 대해
						들어보셨나요?<br> <br> 첫인상을 좌우하는 첫 데이트 장소 또는<br> 사랑하는
						사람과의 특별한 추억을 '저장~'해줄 그 곳을 검색해보세요!
					</div>
					<br>
					<br> <a class="btn btn-light btn-xl js-scroll-trigger"
						href=	"#services">서비스로 이동</a>
				</div>
			</div>
		</div>
	</section>

	<section id="services">
		<jsp:include page="service/daumMap.jsp"></jsp:include>
	</section>
	<section id="contact">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 mx-auto text-center">
					<h2 class="section-heading">Let's Get In Touch!</h2>
					<hr class="my-4">
					<div class="mb-5">
					<br>오작교 서비스 이용자 분들에게 깊은 감사의 말씀을 드리며, <br>
					서비스 이용 중 불편하신 점, 궁금하신 점들을 해결해 드리겠습니다. <br>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-4 ml-auto text-center">
					<i class="fas fa-phone fa-3x mb-3 sr-contact-1"></i>
					<p>123-456-6789</p>
				</div>
				<div class="col-lg-4 mr-auto text-center">
					<i class="fas fa-envelope fa-3x mb-3 sr-contact-2"></i>
					<p>
						<a href="mailto:your-email@your-domain.com">feedback@startbootstrap.com</a>
					</p>
				</div>
			</div>
		</div>
	</section>

	<!-- Bootstrap core JavaScript -->
	<script src="${path}/asset/vendor/jquery/jquery.min.js"></script>
	<script src="${path}/asset/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Plugin JavaScript -->
	<script src="${path}/asset/vendor/jquery-easing/jquery.easing.min.js"></script>
	<script src="${path}/asset/vendor/scrollreveal/scrollreveal.min.js"></script>
	<script
		src="${path}/asset/vendor/magnific-popup/jquery.magnific-popup.min.js"></script>

	<!-- Custom scripts for this template -->
	<script src="${path}/asset/js/creative.js"></script>
	</body>
</html>